From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 06/13] utf8.c: add utf8_strnwidth() with the ability to skip ansi sequences
Date: Tue, 16 Apr 2013 18:24:55 +1000
Message-ID: <1366100702-31745-7-git-send-email-pclouds@gmail.com>
References: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1366100702-31745-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 16 10:26:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US1Dq-0006HN-L2
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 10:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935658Ab3DPI0d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 04:26:33 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:34979 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147Ab3DPI0b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 04:26:31 -0400
Received: by mail-pb0-f53.google.com with SMTP id un15so168724pbc.12
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 01:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=e5ypeQdfm61u7QPoMfw6i21K9V/wy9o/xFHOiInOeZQ=;
        b=cLXilrE0XlqQvgK9ZfoS/vVmUBb5tBDiBmfQj1F61Cfyzbuln1rDjdgdx4BYGhZlE1
         6gGviYb4Kv3YOuD+Hh/uyOO/QRkFPCE4W8WWzcidao0eGhOhvSWfvku0OZsahNO0XZ6M
         54zmnvcHx1UPY3qYXEbnafTASq2dyIyFA/ej1ebclo0TGo/5FWdbmr1/m/0GgVG25cF3
         ur0ZkjCbIL1G65n67soFa/7vBSPnJ6FQpuePUsa+T71K42VBqoBBKZvanKc6QwjvTWWx
         qYv0pqv3xMlsZsXgnDpl67ufFulGzSilnPyX1BkpFAzJK6dmcX/TxX9w4Yn+CxOpNG7G
         xlwA==
X-Received: by 10.68.170.3 with SMTP id ai3mr1693546pbc.206.1366100791148;
        Tue, 16 Apr 2013 01:26:31 -0700 (PDT)
Received: from pclouds@gmail.com (xinyep.lnk.telstra.net. [110.143.18.114])
        by mx.google.com with ESMTPS id li15sm1785030pab.2.2013.04.16.01.26.27
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Apr 2013 01:26:30 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Apr 2013 18:26:17 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1366100702-31745-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221385>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 utf8.c | 20 ++++++++++++++------
 utf8.h |  1 +
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/utf8.c b/utf8.c
index 6ed93c3..9df087f 100644
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
index 1f8ecad..d3da96f 100644
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
1.8.2.82.gc24b958
