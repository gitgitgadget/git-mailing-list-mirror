From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] lis3lv02d: support both one- and two-byte sensors
Date: Wed, 11 Feb 2009 00:34:22 +0100
Message-ID: <1234308862-13609-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?=C3=89ric=20Piel?= <Eric.Piel@tremplin-utc.net>,
	Pavel Machek <pavel@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 00:35:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX28y-0000Mk-9F
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 00:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756391AbZBJXea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 18:34:30 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755491AbZBJXe3
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 18:34:29 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:54398 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbZBJXe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 18:34:29 -0500
Received: by fg-out-1718.google.com with SMTP id 16so65118fgg.17
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 15:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=RWCNvZ4Oaq0EISLzjHDBNXbptaMRXzFUOl4DAIlBtyk=;
        b=w85J0BQq2HUJ0ad1Ga32VYue2HqpMK7blWs7jkAR8mULrADYv3DO7c1GLcQ6G6mJiE
         7TYVSgqRe+/H/HfYOtVNQy1nnhGlSPPCK6DGIUHxaeiqtcKmjE0YcrpluXVu8s4YKCtw
         tppWoLhf/x2H+naSael4FjQxbN5eakmTOM1dA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DFXoV3U6W8AEzmcPP5a99tn0kTBXqXjc6AC+tjFXRtWOOdmELzbyaFFhI9JmaYb7h+
         wQauUr8BWZxe9/Fjwuqs502S71e1/sD2PME/dqPvjF0aKSGcHErk4ffH8WMAp1DSJXbM
         WlxbxQxayeEGiqFGUT+1tNqQtabXhPXO0Hudg=
Received: by 10.86.91.3 with SMTP id o3mr191614fgb.35.1234308865877;
        Tue, 10 Feb 2009 15:34:25 -0800 (PST)
Received: from localhost (host-78-15-9-200.cust-adsl.tiscali.it [78.15.9.200])
        by mx.google.com with ESMTPS id 12sm3437530fgg.33.2009.02.10.15.34.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Feb 2009 15:34:25 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.173.g5e148
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109344>

Sensors responding with 0x3B to WHO_AM_I only have one data register pe=
r
direction, thus returning a signed byte from the position which is
occupied by the MSB in sensors responding with 0x3A.

We support both kind of sensors by checking for the sensor type on init
and defining appropriate data-access routines and sensor limits (for th=
e
joystick) depending on what we find.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

To make the patch smaller, I left a funky effect on the 8-bit sensor
reading routine: it actually accesses the byte AFTER the one requested,
so I didn't have to touch all the requests.

Another solution would be to let it access the requested bytes, change
all requests to the subsequent byte, and have the 16-bit routine access
the requested byte and the one BEFORE it. I can remake the patch in thi=
s
sense if reviewers judge it to be formally more correct.

 drivers/hwmon/lis3lv02d.c |   41 +++++++++++++++++++++++++++++++------=
----
 drivers/hwmon/lis3lv02d.h |    9 ++++++++-
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
index 219d2d0..28a1cae 100644
--- a/drivers/hwmon/lis3lv02d.c
+++ b/drivers/hwmon/lis3lv02d.c
@@ -52,9 +52,6 @@
  * joystick.
  */
=20
-/* Maximum value our axis may get for the input device (signed 12 bits=
) */
-#define MDPS_MAX_VAL 2048
-
 struct acpi_lis3lv02d adev;
 EXPORT_SYMBOL_GPL(adev);
=20
@@ -70,6 +67,16 @@ static s16 lis3lv02d_read_16(acpi_handle handle, int=
 reg)
 	return (s16)((hi << 8) | lo);
 }
=20
+static s16 lis3lv02d_read_8(acpi_handle handle, int reg)
+{
+	u8 lo;
+	/* 8-bit sensors store their data in the byte which holds
+	   the MSB for 16-bit sensors, so we actually check the
+	   NEXT position */
+	adev.read(handle, reg + 1, &lo);
+	return *((s8*)(&lo));
+}
+
 /**
  * lis3lv02d_get_axis - For the given axis, give the value converted
  * @axis:      1,2,3 - can also be negative
@@ -98,9 +105,9 @@ static void lis3lv02d_get_xyz(acpi_handle handle, in=
t *x, int *y, int *z)
 {
 	int position[3];
=20
-	position[0] =3D lis3lv02d_read_16(handle, OUTX_L);
-	position[1] =3D lis3lv02d_read_16(handle, OUTY_L);
-	position[2] =3D lis3lv02d_read_16(handle, OUTZ_L);
+	position[0] =3D adev.lis3lv02d_read(handle, OUTX_L);
+	position[1] =3D adev.lis3lv02d_read(handle, OUTY_L);
+	position[2] =3D adev.lis3lv02d_read(handle, OUTZ_L);
=20
 	*x =3D lis3lv02d_get_axis(adev.ac.x, position);
 	*y =3D lis3lv02d_get_axis(adev.ac.y, position);
@@ -121,7 +128,21 @@ void lis3lv02d_poweron(acpi_handle handle)
=20
 	adev.is_on =3D 1;
 	adev.init(handle);
-	adev.write(handle, FF_WU_CFG, 0);
+	adev.read(handle, WHO_AM_I, &adev.whoami);
+	/* Tell apart LISxLV02Dy from LISx02Dy family by checking the LSB
+	 * (0x3A vs 0x3B). TODO More sophisticated checks on other registers
+	 * could be implemented, for example to see if we have 2 or 3 axes, a=
nd
+	 * configure the joystick accordingly.
+	 */
+	if (adev.whoami & 1) {
+		printk(KERN_INFO DRIVER_NAME ": 1-byte sensor found\n");
+		adev.lis3lv02d_read =3D lis3lv02d_read_8;
+		adev.mdps_max_val =3D 128;
+	} else {
+		printk(KERN_INFO DRIVER_NAME ": 2-byte sensor found\n");
+		adev.lis3lv02d_read =3D lis3lv02d_read_16;
+		adev.mdps_max_val =3D 2048;
+	}
 	/*
 	 * BDU: LSB and MSB values are not updated until both have been read.
 	 *      So the value read will always be correct.
@@ -231,9 +252,9 @@ int lis3lv02d_joystick_enable(void)
 	adev.idev->close      =3D lis3lv02d_joystick_close;
=20
 	set_bit(EV_ABS, adev.idev->evbit);
-	input_set_abs_params(adev.idev, ABS_X, -MDPS_MAX_VAL, MDPS_MAX_VAL, 3=
, 3);
-	input_set_abs_params(adev.idev, ABS_Y, -MDPS_MAX_VAL, MDPS_MAX_VAL, 3=
, 3);
-	input_set_abs_params(adev.idev, ABS_Z, -MDPS_MAX_VAL, MDPS_MAX_VAL, 3=
, 3);
+	input_set_abs_params(adev.idev, ABS_X, -adev.mdps_max_val, adev.mdps_=
max_val, 3, 3);
+	input_set_abs_params(adev.idev, ABS_Y, -adev.mdps_max_val, adev.mdps_=
max_val, 3, 3);
+	input_set_abs_params(adev.idev, ABS_Z, -adev.mdps_max_val, adev.mdps_=
max_val, 3, 3);
=20
 	err =3D input_register_device(adev.idev);
 	if (err) {
diff --git a/drivers/hwmon/lis3lv02d.h b/drivers/hwmon/lis3lv02d.h
index 223f1c0..cf61f0f 100644
--- a/drivers/hwmon/lis3lv02d.h
+++ b/drivers/hwmon/lis3lv02d.h
@@ -22,11 +22,14 @@
 /*
  * The actual chip is STMicroelectronics LIS3LV02DL or LIS3LV02DQ that=
 seems to
  * be connected via SPI. There exists also several similar chips (such=
 as LIS302DL or
- * LIS3L02DQ) but not in the HP laptops and they have slightly differe=
nt registers.
+ * LIS3L02DQ) and they have slightly different registers, but we can p=
rovide a
+ * common interface for all of them.
  * They can also be connected via I=C2=B2C.
  */
=20
+/* 2-byte registers */
 #define LIS3LV02DL_ID	0x3A /* Also the LIS3LV02DQ */
+/* 1-byte registers */
 #define LIS302DL_ID	0x3B /* Also the LIS202DL! */
=20
 enum lis3lv02d_reg {
@@ -159,6 +162,10 @@ struct acpi_lis3lv02d {
 	acpi_status (*write) (acpi_handle handle, int reg, u8 val);
 	acpi_status (*read) (acpi_handle handle, int reg, u8 *ret);
=20
+	u8			whoami;    /* 3Ah: 2-byte registries, 3Bh: 1-byte registries */
+	s16 (*lis3lv02d_read) (acpi_handle handle, int reg);
+	int			mdps_max_val;
+
 	struct input_dev	*idev;     /* input device */
 	struct task_struct	*kthread;  /* kthread for input */
 	struct mutex            lock;
--=20
1.6.2.rc0.173.g5e148
