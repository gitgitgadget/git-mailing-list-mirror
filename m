From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2] lis3lv02d: support both one- and two-byte sensors
Date: Wed, 11 Feb 2009 00:40:49 +0100
Message-ID: <1234309249-13672-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?=C3=89ric=20Piel?= <Eric.Piel@tremplin-utc.net>,
	Pavel Machek <pavel@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 00:42:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX2FB-0002MN-Vu
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 00:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755616AbZBJXkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 18:40:55 -0500
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755403AbZBJXky
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 18:40:54 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:1450 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbZBJXky (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 18:40:54 -0500
Received: by fg-out-1718.google.com with SMTP id 16so66052fgg.17
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 15:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=FgIjwTYdIOxjJ7hAKMISL+ubzz6TVl5JyUShlzGyvHE=;
        b=Qrrs0knscS4vUUiyT4j64/PONonHJxbls6WuXqdshnC4EMgMtsmX2r78E4F6uTUd9/
         ErMtFRt80U++1pc/SbX98mDncv08nnSVQ/UOqZL+w74vSxQNdszaa+8WLY+7d6W6SRq6
         GkBzCcYxcIgrkOmTm5VMHsAUKRuoO5aG9Jh8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=i6kZEQUJuxLEAl3Yre3ytLJ9cZSxaXqr/WjIaC+rQ96Kc8XlXCF50nHbSE0YV5MFgL
         ZtxpWzQwDpUWD4D4C7lmDM8olZl2yaYyCZkjZyqj09JxleF682/qxgbbBPNsXxc6/GzM
         2WJhZfbZPlmCC2OCXtqNtsml8Mpn+xsux8U2w=
Received: by 10.86.78.4 with SMTP id a4mr210130fgb.10.1234309252161;
        Tue, 10 Feb 2009 15:40:52 -0800 (PST)
Received: from localhost (host-78-15-9-200.cust-adsl.tiscali.it [78.15.9.200])
        by mx.google.com with ESMTPS id 4sm438433fge.24.2009.02.10.15.40.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Feb 2009 15:40:51 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.173.g5e148
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109347>

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

This is the other version of the patch, and it changes access to use th=
e
base address from the 8-bit, so the 16-bit routine is changed to access
the PREVIOUS byte for the LSB.

Choose whichever of the patches is deemed more correct 8-)

Note that both patches are based off Linus tree, so I don't know how
they cope with Pavel's "don't touch too much on init" one. I'll try to
work out a patch on top of that too.

 drivers/hwmon/lis3lv02d.c |   42 ++++++++++++++++++++++++++++++-------=
-----
 drivers/hwmon/lis3lv02d.h |   12 +++++++++++-
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
index 219d2d0..b6b2d4a 100644
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
@@ -64,12 +61,19 @@ static s16 lis3lv02d_read_16(acpi_handle handle, in=
t reg)
 {
 	u8 lo, hi;
=20
-	adev.read(handle, reg, &lo);
-	adev.read(handle, reg + 1, &hi);
+	adev.read(handle, reg - 1, &lo);
+	adev.read(handle, reg, &hi);
 	/* In "12 bit right justified" mode, bit 6, bit 7, bit 8 =3D bit 5 */
 	return (s16)((hi << 8) | lo);
 }
=20
+static s16 lis3lv02d_read_8(acpi_handle handle, int reg)
+{
+	u8 lo;
+	adev.read(handle, reg, &lo);
+	return *((s8*)(&lo));
+}
+
 /**
  * lis3lv02d_get_axis - For the given axis, give the value converted
  * @axis:      1,2,3 - can also be negative
@@ -98,9 +102,9 @@ static void lis3lv02d_get_xyz(acpi_handle handle, in=
t *x, int *y, int *z)
 {
 	int position[3];
=20
-	position[0] =3D lis3lv02d_read_16(handle, OUTX_L);
-	position[1] =3D lis3lv02d_read_16(handle, OUTY_L);
-	position[2] =3D lis3lv02d_read_16(handle, OUTZ_L);
+	position[0] =3D adev.lis3lv02d_read(handle, OUTX);
+	position[1] =3D adev.lis3lv02d_read(handle, OUTY);
+	position[2] =3D adev.lis3lv02d_read(handle, OUTZ);
=20
 	*x =3D lis3lv02d_get_axis(adev.ac.x, position);
 	*y =3D lis3lv02d_get_axis(adev.ac.y, position);
@@ -121,7 +125,21 @@ void lis3lv02d_poweron(acpi_handle handle)
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
@@ -231,9 +249,9 @@ int lis3lv02d_joystick_enable(void)
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
index 223f1c0..9d7d4a8 100644
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
@@ -44,10 +47,13 @@ enum lis3lv02d_reg {
 	STATUS_REG	=3D 0x27,
 	OUTX_L		=3D 0x28,
 	OUTX_H		=3D 0x29,
+	OUTX		=3D 0x29,
 	OUTY_L		=3D 0x2A,
 	OUTY_H		=3D 0x2B,
+	OUTY		=3D 0x2B,
 	OUTZ_L		=3D 0x2C,
 	OUTZ_H		=3D 0x2D,
+	OUTZ		=3D 0x2D,
 	FF_WU_CFG	=3D 0x30,
 	FF_WU_SRC	=3D 0x31,
 	FF_WU_ACK	=3D 0x32,
@@ -159,6 +165,10 @@ struct acpi_lis3lv02d {
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
