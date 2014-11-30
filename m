From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/34] setup.c: convert is_git_directory() to use strbuf
Date: Sun, 30 Nov 2014 15:24:40 +0700
Message-ID: <1417335899-27307-16-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:28:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xuzrd-0008Cp-9u
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbaK3I2K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:28:10 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:57413 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbaK3I2I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:28:08 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so8922785pdb.36
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eM6VWDaFGt6/QElZtUaSkkNncyJ+cDfJ2ft5M0gjrHs=;
        b=iWyZCGfgail/oUWXuiCx1jDMyHBOLALEXzdUNNuX/0+WJ/lcPyaky4fIMbMhf2mcnv
         IwCVTke7b+VI5+2vz+iDrynxucHZWYeuUAl+okN16ypUZ3rWgZj1A4B3zX9ruWNv6O+b
         gE1cq8GBH97OivRRny73wCBMopO7Q2/9odMQAKEyGiVizlXB7BO8ORRQgV7Q55UFk+4d
         dZr8YzsaZXTiwEi+vMI2dvPEFQ98La5boQkBaTIdrl1nDibgfguBM2qRYUHxIzDKMHEw
         UNhkdfDwc2/CVmUsb1khSMZSaDDfnFwc9YwAeqkKNud/Dk8/5BGzOEuHPABX2/wWBj9W
         4xFA==
X-Received: by 10.68.130.136 with SMTP id oe8mr86680886pbb.121.1417336087839;
        Sun, 30 Nov 2014 00:28:07 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id xo4sm14257439pbc.45.2014.11.30.00.28.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:28:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:28:06 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260402>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/setup.c b/setup.c
index 979b13f..afd6742 100644
--- a/setup.c
+++ b/setup.c
@@ -238,31 +238,36 @@ void verify_non_filename(const char *prefix, cons=
t char *arg)
  */
 int is_git_directory(const char *suspect)
 {
-	char path[PATH_MAX];
-	size_t len =3D strlen(suspect);
+	struct strbuf path =3D STRBUF_INIT;
+	int ret =3D 0;
+	size_t len;
=20
-	if (PATH_MAX <=3D len + strlen("/objects"))
-		die("Too long path: %.*s", 60, suspect);
-	strcpy(path, suspect);
+	strbuf_addstr(&path, suspect);
+	len =3D path.len;
 	if (getenv(DB_ENVIRONMENT)) {
 		if (access(getenv(DB_ENVIRONMENT), X_OK))
-			return 0;
+			goto done;
 	}
 	else {
-		strcpy(path + len, "/objects");
-		if (access(path, X_OK))
-			return 0;
+		strbuf_addstr(&path, "/objects");
+		if (access(path.buf, X_OK))
+			goto done;
 	}
=20
-	strcpy(path + len, "/refs");
-	if (access(path, X_OK))
-		return 0;
+	strbuf_setlen(&path, len);
+	strbuf_addstr(&path, "/refs");
+	if (access(path.buf, X_OK))
+		goto done;
=20
-	strcpy(path + len, "/HEAD");
-	if (validate_headref(path))
-		return 0;
+	strbuf_setlen(&path, len);
+	strbuf_addstr(&path, "/HEAD");
+	if (validate_headref(path.buf))
+		goto done;
=20
-	return 1;
+	ret =3D 1;
+done:
+	strbuf_release(&path);
+	return ret;
 }
=20
 int is_inside_git_dir(void)
--=20
2.1.0.rc0.78.gc0d8480
