From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 04/12] utf8.c: add utf8_strnwidth() with the ability to skip ansi sequences
Date: Sat, 30 Mar 2013 16:35:04 +0700
Message-ID: <1364636112-15065-5-git-send-email-pclouds@gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 30 10:36:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULsCf-0002g2-F5
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 10:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756206Ab3C3Jfd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Mar 2013 05:35:33 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:38193 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756030Ab3C3Jfc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 05:35:32 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb10so655479pad.25
        for <git@vger.kernel.org>; Sat, 30 Mar 2013 02:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=FAmjmXAptSd+1e2IK74W1oZ1YEeBa+KB9oyT+1DvsG4=;
        b=HRO4wyxkkgkk6EW1iFAzUpCjQEfJIHA/uoDq/n8HyQdP9cvhnJWJnFFInVdJ8rl+0u
         VhmqsluumCvtFKADw3xz1arkf/gid5Ki66ojESY7gAH9UApFjCuLNacu2CrQCod59L9m
         t+USUd2YreQ7w6QI1pdg7unNPjqotMthgLdnWKiyrU7aQt0Z+3JeBx5UecaTYyf1v8G1
         xNFYZWmHnDbjQtAC06/Uc6Uegq8tMiU/mHgQnpnE8M7pJAyCwIF9w3dFxlV1YxskQNt3
         DAviksKCZwNB9jchN4glgld26THF8d9mNKGusjpowcZFkbL1k58JkGfH3ttpI1PsolRR
         CsXg==
X-Received: by 10.66.156.68 with SMTP id wc4mr8690395pab.58.1364636132148;
        Sat, 30 Mar 2013 02:35:32 -0700 (PDT)
Received: from lanh ([115.74.55.89])
        by mx.google.com with ESMTPS id ve7sm6831434pab.11.2013.03.30.02.35.29
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 30 Mar 2013 02:35:31 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Mar 2013 16:35:37 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219573>


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
