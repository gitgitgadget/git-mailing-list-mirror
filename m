From: POJAR GEORGE <geoubuntu@gmail.com>
Subject: [PATCH] saa7134: Add support for SnaZio TvPVR PRO
Date: Sun,  9 Feb 2014 18:11:59 +0200
Message-ID: <1391962319-4120-1-git-send-email-user@george>
Cc: POJAR GEORGE <geoubuntu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 09 17:12:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCWzP-0002c2-HM
	for gcvg-git-2@plane.gmane.org; Sun, 09 Feb 2014 17:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbaBIQMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 11:12:10 -0500
Received: from mail-ee0-f42.google.com ([74.125.83.42]:39334 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbaBIQMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Feb 2014 11:12:09 -0500
Received: by mail-ee0-f42.google.com with SMTP id b15so2476187eek.29
        for <git@vger.kernel.org>; Sun, 09 Feb 2014 08:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=RlkcC+gsQ7ndMSOj67RpzobYNMq4YkZg1cmDxAbI75s=;
        b=srM95BZ9NLaGS79W1xi1577B6ewE7TRW6Hwlr8W+Hi8Z8kdZu+lghxrRXcblPPsww/
         5xmGtWocLIJN4OjXYQgVTFQ+7DJv81N9gAfRtuzYIvEwlORkLKRGEKu2ON1YFSeqmtKm
         vjsqzuuRX263FwthKetPAomv6kWpSmG80tfV1aDCXufpOmzgP0+drBz22HaUonBrrOhy
         tCZLQhYX8M9e5yEVPLK0q1XuQSUsqdXr1TEWtP6JTdF0N0t1c2pCRV/mQwEYQ5fJGp33
         C68iIldX1PNFQcvWBP5MA/e5B5gqBb2uUpMZUwHMuXSJzOXJ7gu32i/n0C4Ub4mgg1ix
         asTw==
X-Received: by 10.14.9.134 with SMTP id 6mr572866eet.70.1391962327860;
        Sun, 09 Feb 2014 08:12:07 -0800 (PST)
Received: from localhost.localdomain ([188.24.65.5])
        by mx.google.com with ESMTPSA id g1sm43142324eet.6.2014.02.09.08.12.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Feb 2014 08:12:07 -0800 (PST)
X-Mailer: git-send-email 1.9.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241881>

From: POJAR GEORGE <geoubuntu@gmail.com>

Signed-off-by: POJAR GEORGE <geoubuntu@gmail.com>
---
 Documentation/video4linux/CARDLIST.saa7134     |   1 +
 drivers/media/pci/saa7134/saa7134-cards.c      |  51 ++++++++++-
 drivers/media/pci/saa7134/saa7134-input.c      |  62 +++++++++++++
 drivers/media/pci/saa7134/saa7134.h            |   1 +
 drivers/media/rc/keymaps/Makefile              |   1 +
 drivers/media/rc/keymaps/rc-snazio-tvpvr-pro.c | 116 +++++++++++++++++++++++++
 include/media/rc-map.h                         |   1 +
 7 files changed, 232 insertions(+), 1 deletion(-)
 create mode 100644 drivers/media/rc/keymaps/rc-snazio-tvpvr-pro.c

diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
index 8df17d0..32e4353 100644
--- a/Documentation/video4linux/CARDLIST.saa7134
+++ b/Documentation/video4linux/CARDLIST.saa7134
@@ -191,3 +191,4 @@
 190 -> Asus My Cinema PS3-100                   [1043:48cd]
 191 -> Hawell HW-9004V1
 192 -> AverMedia AverTV Satellite Hybrid+FM A706 [1461:2055]
+193 -> SnaZio TvPVR PRO                         [0x1779:0x13cf,0x1779:0x13d0,0x1779:0x13d1]
diff --git a/drivers/media/pci/saa7134/saa7134-cards.c b/drivers/media/pci/saa7134/saa7134-cards.c
index d45e7f6..3476785 100644
--- a/drivers/media/pci/saa7134/saa7134-cards.c
+++ b/drivers/media/pci/saa7134/saa7134-cards.c
@@ -5827,7 +5827,37 @@ struct saa7134_board saa7134_boards[] = {
 			.gpio = 0x0000800,
 		},
 	},
-
+	[SAA7134_BOARD_SNAZIO_TVPVR_PRO] = {
+		.name           = "SnaZio TvPVR PRO",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_PHILIPS_TDA8290,
+		.radio_type     = UNSET,
+		.tuner_addr     = ADDR_UNSET,
+		.radio_addr     = ADDR_UNSET,
+		.gpiomask       = 1 << 21,
+		.inputs         = {{
+			.name = name_tv,
+			.vmux = 1,
+			.amux = TV,
+			.gpio = 0x0000000,
+			.tv   = 1,
+		}, {
+			.name = name_comp1,     /* Composite input */
+			.vmux = 3,
+			.amux = LINE2,
+			.gpio = 0x0000000,
+		}, {
+			.name = name_svideo,    /* S-Video input */
+			.vmux = 8,
+			.amux = LINE2,
+			.gpio = 0x0000000,
+		} },
+		.radio = {
+			.name = name_radio,
+			.amux = TV,
+			.gpio = 0x0200000,
+		},
+	},
 };
 
 const unsigned int saa7134_bcount = ARRAY_SIZE(saa7134_boards);
@@ -7080,6 +7110,24 @@ struct pci_device_id saa7134_pci_tbl[] = {
 		.subdevice    = 0x2055, /* AverTV Satellite Hybrid+FM A706 */
 		.driver_data  = SAA7134_BOARD_AVERMEDIA_A706,
 	}, {
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
+		.subvendor    = 0x1779,
+		.subdevice    = 0x13cf,
+		.driver_data  = SAA7134_BOARD_SNAZIO_TVPVR_PRO,
+	}, {
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
+		.subvendor    = 0x1779,
+		.subdevice    = 0x13d0,
+		.driver_data  = SAA7134_BOARD_SNAZIO_TVPVR_PRO,
+	}, {
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
+		.subvendor    = 0x1779,
+		.subdevice    = 0x13d1,
+		.driver_data  = SAA7134_BOARD_SNAZIO_TVPVR_PRO,
+	}, {
 		/* --- boards without eeprom + subsystem ID --- */
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
@@ -7608,6 +7656,7 @@ int saa7134_board_init1(struct saa7134_dev *dev)
 	case SAA7134_BOARD_BEHOLD_H7:
 	case SAA7134_BOARD_BEHOLD_A7:
 	case SAA7134_BOARD_KWORLD_PC150U:
+	case SAA7134_BOARD_SNAZIO_TVPVR_PRO:
 		dev->has_remote = SAA7134_REMOTE_I2C;
 		break;
 	case SAA7134_BOARD_AVERMEDIA_A169_B:
diff --git a/drivers/media/pci/saa7134/saa7134-input.c b/drivers/media/pci/saa7134/saa7134-input.c
index 6f43126..62ccc7d 100644
--- a/drivers/media/pci/saa7134/saa7134-input.c
+++ b/drivers/media/pci/saa7134/saa7134-input.c
@@ -416,6 +416,53 @@ static int get_key_pinnacle_color(struct IR_i2c *ir, u32 *ir_key, u32 *ir_raw)
 	return get_key_pinnacle(ir, ir_key, ir_raw, 2, 0x80, 0x88);
 }
 
+/* copied and modified from get_key_msi_tvanywhere_plus() */
+static int get_key_snazio_tvpvr_pro(struct IR_i2c *ir, u32 *ir_key, u32 *ir_raw)
+{
+	unsigned char b;
+	unsigned int gpio;
+
+	/* <dev> is needed to access GPIO. Used by the saa_readl macro. */
+	struct saa7134_dev *dev = ir->c->adapter->algo_data;
+	if (dev == NULL) {
+		i2cdprintk("get_key_snazio_tvpvr_pro: "
+			   "ir->c->adapter->algo_data is NULL!\n");
+		return -EIO;
+	}
+
+	/* rising SAA7134_GPIO_GPRESCAN reads the status */
+
+	saa_clearb(SAA7134_GPIO_GPMODE3, SAA7134_GPIO_GPRESCAN);
+	saa_setb(SAA7134_GPIO_GPMODE3, SAA7134_GPIO_GPRESCAN);
+
+	gpio = saa_readl(SAA7134_GPIO_GPSTATUS0 >> 2);
+
+	/* GPIO&0x100 is pulsed low when a button is pressed. Don't do
+	   I2C receive if gpio&0x100 is not low. */
+
+	if (gpio & 0x100)
+		return 0;       /* No button press */
+
+	/* GPIO says there is a button press. Get it. */
+
+	if (1 != i2c_master_recv(ir->c, &b, 1)) {
+		i2cdprintk("read error\n");
+		return -EIO;
+	}
+
+	/* No button press */
+
+	if (b == 0xff)
+		return 0;
+
+	/* Button pressed */
+
+	dprintk("get_key_snazio_tvpvr_pro: Key = 0x%02X\n", b);
+	*ir_key = b;
+	*ir_raw = b;
+	return 1;
+}
+
 void saa7134_input_irq(struct saa7134_dev *dev)
 {
 	struct saa7134_card_ir *ir;
@@ -1006,6 +1053,21 @@ void saa7134_probe_i2c_ir(struct saa7134_dev *dev)
 		dev->init_data.ir_codes = RC_MAP_FLYDVB;
 		info.addr = 0x0b;
 		break;
+	case SAA7134_BOARD_SNAZIO_TVPVR_PRO:
+		/* copied and modified from MSI TV@nywhere Plus */
+		dev->init_data.name = "SnaZio TvPVR PRO";
+		dev->init_data.get_key = get_key_snazio_tvpvr_pro;
+		dev->init_data.ir_codes = RC_MAP_SNAZIO_TVPVR_PRO;
+		info.addr = 0x30;
+		/* MSI TV@nywhere Plus controller doesn't seem to
+		   respond to probes unless we read something from
+		   an existing device. Weird...
+		   REVISIT: might no longer be needed */
+		rc = i2c_transfer(&dev->i2c_adap, &msg_msi, 1);
+		dprintk("probe 0x%02x @ %s: %s\n",
+			msg_msi.addr, dev->i2c_adap.name,
+			(1 == rc) ? "yes" : "no");
+		break;
 	default:
 		dprintk("No I2C IR support for board %x\n", dev->board);
 		return;
diff --git a/drivers/media/pci/saa7134/saa7134.h b/drivers/media/pci/saa7134/saa7134.h
index 2474e84..28b083f 100644
--- a/drivers/media/pci/saa7134/saa7134.h
+++ b/drivers/media/pci/saa7134/saa7134.h
@@ -338,6 +338,7 @@ struct saa7134_card_ir {
 #define SAA7134_BOARD_ASUSTeK_PS3_100      190
 #define SAA7134_BOARD_HAWELL_HW_9004V1      191
 #define SAA7134_BOARD_AVERMEDIA_A706		192
+#define SAA7134_BOARD_SNAZIO_TVPVR_PRO      193
 
 #define SAA7134_MAXBOARDS 32
 #define SAA7134_INPUT_MAX 8
diff --git a/drivers/media/rc/keymaps/Makefile b/drivers/media/rc/keymaps/Makefile
index 0b8c549..72b2e45 100644
--- a/drivers/media/rc/keymaps/Makefile
+++ b/drivers/media/rc/keymaps/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_RC_MAP) += rc-adstech-dvb-t-pci.o \
 			rc-real-audio-220-32-keys.o \
 			rc-reddo.o \
 			rc-snapstream-firefly.o \
+			rc-snazio-tvpvr-pro.o \
 			rc-streamzap.o \
 			rc-tbs-nec.o \
 			rc-technisat-usb2.o \
diff --git a/drivers/media/rc/keymaps/rc-snazio-tvpvr-pro.c b/drivers/media/rc/keymaps/rc-snazio-tvpvr-pro.c
new file mode 100644
index 0000000..127350e
--- /dev/null
+++ b/drivers/media/rc/keymaps/rc-snazio-tvpvr-pro.c
@@ -0,0 +1,116 @@
+/* rc-snazio-tvpvr-pro.h - Keytable for snazio_tvpvr_pro Remote Controller
+ *
+ * keymap imported from ir-keymaps.c
+ *
+ * Copyright (c) 2010 by Mauro Carvalho Chehab
+ * Copyright (c) 2010 by POJAR GEORGE <geoubuntu@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <media/rc-map.h>
+#include <linux/module.h>
+
+/*
+  Keycodes for remote on the SnaZio TvPVR PRO.
+  POJAR GEORGE <geoubuntu@gmail.com>
+*/
+
+static struct rc_map_table snazio_tvpvr_pro[] = {
+
+/*  ---- Remote Button Layout ----
+
+    POWER   SOURCE  SCAN    MUTE
+    TV/FM   1       2       3
+    |>      4       5       6
+    <|      7       8       9
+    ^^UP    0       +       RECALL
+    vvDN    RECORD  STOP    PLAY
+
+	MINIMIZE          ZOOM
+
+		  CH+
+      VOL-                   VOL+
+		  CH-
+
+	SNAPSHOT           MTS
+
+     <<      FUNC    >>     RESET
+*/
+
+	{ 0x01, KEY_1 },		/* 1 */
+	{ 0x0b, KEY_2 },		/* 2 */
+	{ 0x1b, KEY_3 },		/* 3 */
+	{ 0x05, KEY_4 },		/* 4 */
+	{ 0x09, KEY_5 },		/* 5 */
+	{ 0x15, KEY_6 },		/* 6 */
+	{ 0x06, KEY_7 },		/* 7 */
+	{ 0x0a, KEY_8 },		/* 8 */
+	{ 0x12, KEY_9 },		/* 9 */
+	{ 0x02, KEY_0 },		/* 0 */
+	{ 0x10, KEY_KPPLUS },		/* + */
+	{ 0x13, KEY_AGAIN },		/* Recall */
+
+	{ 0x1e, KEY_POWER },		/* Power */
+	{ 0x07, KEY_VIDEO },		/* Source */
+	{ 0x1c, KEY_SEARCH },		/* Scan */
+	{ 0x18, KEY_MUTE },		/* Mute */
+
+	{ 0x03, KEY_RADIO },		/* TV/FM */
+	/* The next four keys are duplicates that appear to send the
+	   same IR code as Ch+, Ch-, >>, and << .  The raw code assigned
+	   to them is the actual code + 0x20 - they will never be
+	   detected as such unless some way is discovered to distinguish
+	   these buttons from those that have the same code. */
+	{ 0x3f, KEY_RIGHT },		/* |> and Ch+ */
+	{ 0x37, KEY_LEFT },		/* <| and Ch- */
+	{ 0x2c, KEY_UP },		/* ^^Up and >> */
+	{ 0x24, KEY_DOWN },		/* vvDn and << */
+
+	{ 0x00, KEY_RECORD },		/* Record */
+	{ 0x08, KEY_STOP },		/* Stop */
+	{ 0x11, KEY_PLAY },		/* Play */
+
+	{ 0x0f, KEY_CLOSE },		/* Minimize */
+	{ 0x19, KEY_ZOOM },		/* Zoom */
+	{ 0x1a, KEY_CAMERA },		/* Snapshot */
+	{ 0x0d, KEY_LANGUAGE },		/* MTS */
+
+	{ 0x14, KEY_VOLUMEDOWN },	/* Vol- */
+	{ 0x16, KEY_VOLUMEUP },		/* Vol+ */
+	{ 0x17, KEY_CHANNELDOWN },	/* Ch- */
+	{ 0x1f, KEY_CHANNELUP },	/* Ch+ */
+
+	{ 0x04, KEY_REWIND },		/* << */
+	{ 0x0e, KEY_MENU },		/* Function */
+	{ 0x0c, KEY_FASTFORWARD },	/* >> */
+	{ 0x1d, KEY_RESTART },		/* Reset */
+};
+
+static struct rc_map_list snazio_tvpvr_pro_map = {
+	.map = {
+		.scan    = snazio_tvpvr_pro,
+		.size    = ARRAY_SIZE(snazio_tvpvr_pro),
+		.rc_type = RC_TYPE_UNKNOWN,	/* Legacy IR type */
+		.name    = RC_MAP_SNAZIO_TVPVR_PRO,
+	}
+};
+
+static int int __init init_rc_map_snazio_tvpvr_pro(void)
+{
+	return rc_map_register(&snazio_tvpvr_pro_map);
+}
+
+static void __exit exit_rc_map_snazio_tvpvr_pro(void)
+{
+	rc_map_unregister(&snazio_tvpvr_pro_map);
+}
+
+module_init(init_rc_map_snazio_tvpvr_pro)
+module_exit(exit_rc_map_snazio_tvpvr_pro)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("POJAR GEORGE <geoubuntu@gmail.com>");
diff --git a/include/media/rc-map.h b/include/media/rc-map.h
index e5aa240..b802af4 100644
--- a/include/media/rc-map.h
+++ b/include/media/rc-map.h
@@ -177,6 +177,7 @@ void rc_map_init(void);
 #define RC_MAP_REAL_AUDIO_220_32_KEYS    "rc-real-audio-220-32-keys"
 #define RC_MAP_REDDO                     "rc-reddo"
 #define RC_MAP_SNAPSTREAM_FIREFLY        "rc-snapstream-firefly"
+#define RC_MAP_SNAZIO_TVPVR_PRO          "rc-snazio-tvpvr-pro"
 #define RC_MAP_STREAMZAP                 "rc-streamzap"
 #define RC_MAP_TBS_NEC                   "rc-tbs-nec"
 #define RC_MAP_TECHNISAT_USB2            "rc-technisat-usb2"
-- 
1.9.rc1
