terraform {
  required_version = ">= 0.12"
}

variable raxcloudusername {
  type = string
}

variable raxcloudpassword {
  type = string
}

variable raxcloudtenant {
  type = string
}

variable environment {
  type    = string
  default = "DEV"
}

variable region {
  type        = string
  default     = "SYD"
  description = "Rackspace Cloud Region"
}


# Configure the OpenStack Provider
provider "openstack" {
  user_name = var.raxcloudusername
  password  = var.raxcloudpassword
  tenant_id = var.raxcloudtenant
  auth_url  = "https://identity.api.rackspacecloud.com/v2.0/"
  region    = var.region
  version   = "1.28"
}

# Create a server
resource "openstack_compute_instance_v2" "kubernetes_master" {
  name      = "${var.region}-${var.environment}-k8s-master"
  region    = var.region
  image_id  = "60cbe1c3-f1f5-4aa0-b74e-ddca6f95d292"
  flavor_id = "general1-2"
  key_pair  = "dev_keypair"

  network {
    uuid = "00000000-0000-0000-0000-000000000000"
    name = "public"
  }

  network {
    uuid = "11111111-1111-1111-1111-111111111111"
    name = "private"
  }
}