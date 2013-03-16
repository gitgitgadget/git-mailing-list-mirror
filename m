From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/12] utf8.c: add utf8_strnwidth() with the ability to skip ansi sequences
Date: Sat, 16 Mar 2013 09:24:35 +0700
Message-ID: <1363400683-14813-5-git-send-email-pclouds@gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 16 03:25:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGgoe-0002QR-PG
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 03:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150Ab3CPCZS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 22:25:18 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:37525 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755031Ab3CPCZR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 22:25:17 -0400
Received: by mail-pb0-f50.google.com with SMTP id up1so4521076pbc.9
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 19:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=FAmjmXAptSd+1e2IK74W1oZ1YEeBa+KB9oyT+1DvsG4=;
        b=tRgqwRUVmSWD5VrDwdOeyd6KGUxJ3I2jCvlL8MGNqnzuh0lWM0Sulke5gyeoysqU63
         IVPOzm2R8DO6rw8W3OC6ID/vPoHDhSgPw/NEB5B4RUL5ZT2K87offKr0r8xMjVDm87QG
         u16rz1Be/bCxHvdFrT2MvGz+ium2PkP6IaQC9SK5eLnuKWCPm7kimXrpCfn3LXYWdl24
         9o1e03xDYEdEQjdz2RXhkHR5Xsz6ULp5NmIS6QLhxrllUTdP5h50gOXF8b9XX1Cbqp3x
         1Y0gyA5geHrITtuOEgnVzE9pKFrVaSGDVfO5Mdr624Kss3b+Iz8K5rCHC6l7xiOtFn4K
         wZnA==
X-Received: by 10.68.213.7 with SMTP id no7mr21016527pbc.48.1363400716661;
        Fri, 15 Mar 2013 19:25:16 -0700 (PDT)
Received: from lanh ([115.74.58.84])
        by mx.google.com with ESMTPS id iv3sm11490693pbc.40.2013.03.15.19.25.13
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Mar 2013 19:25:15 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 16 Mar 2013 09:25:11 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218276>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 utf8.c | 20 ++++++++++++++------
 utf8.h |  1 +
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/utf8.c b/utf8.c
index 82c2ddf..38322a1 100644
--- a/utf8.c
+++ b/utf8.c
@@ -266,18 +266,26 @@ int utf8_width(const char **start, size_t *remain=
der_p)
  * string, assuming that the string is utf8.  Returns strlen() instead
  * if the string does not look like a valid utf8 string.
  */
-int utf8_strwidth(const char *string)
+int utf8_strnwidth(const char *string, int len, int skip_ansi)
 {
 	int width =3D 0;
 	const char *orig =3D string;
=20
-	while (1) {
-		if (!string)
-			return strlen(orig);
-		if (!*string)
-			return width;
+	if (len =3D=3D -1)
+		len =3D strlen(string);
+	while (string && string < orig + len) {
+		int skip;
+		while (skip_ansi &&
+		       (skip =3D display_mode_esc_sequence_len(string)))
+			string +=3D skip;
 		width +=3D utf8_width(&string, NULL);
 	}
+	return string ? width : len;
+}
+
+int utf8_strwidth(const char *string)
+{
+	return utf8_strnwidth(string, -1, 0);
 }
=20
 int is_utf8(const char *text)
diff --git a/utf8.h b/utf8.h
index 501b2bd..a556932 100644
--- a/utf8.h
+++ b/utf8.h
@@ -4,6 +4,7 @@
 typedef unsigned int ucs_char_t;  /* assuming 32bit int */
=20
 int utf8_width(const char **start, size_t *remainder_p);
+int utf8_strnwidth(const char *string, int len, int skip_ansi);
 int utf8_strwidth(const char *string);
 int is_utf8(const char *text);
 int is_encoding_utf8(const char *name);
--=20
1.8.2.83.gc99314b
