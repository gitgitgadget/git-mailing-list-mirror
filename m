From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 06/13] utf8.c: add utf8_strnwidth() with the ability to skip ansi sequences
Date: Fri, 19 Apr 2013 09:08:45 +1000
Message-ID: <1366326532-28517-7-git-send-email-pclouds@gmail.com>
References: <1366100702-31745-1-git-send-email-pclouds@gmail.com>
 <1366326532-28517-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 01:09:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USxxe-0007f9-6g
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 01:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598Ab3DRXJq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Apr 2013 19:09:46 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:53597 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab3DRXJp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 19:09:45 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so1850989pde.37
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 16:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=plqGAMZh1QtluPKtK/aSiCnCcjIIuZFSgmxlaheaDI8=;
        b=xgLh7VJzo3e9+lBqwJ5G9AkXoJkwM8OZWSPNIbNHUdeyMC7EoYDiZMFrvlAutmuM1M
         HpOFgIY11Ghexpxm/mjLRymCAAbWKbHX+A8N8MjXlXBWRUdkw9oWR9v+BfLV+EMhoMcf
         4K3gThfyd5OqvwfEcX5lyChrKcQM7NlpgAgs8caMmxuQB5CRuLA7901xx1g33B8KVeBV
         dKZSw3BX5cs7pNAHxic2iIMwhGJSdWDmKmhYBgcWEaVcryj+WsoBdhS30ZK/j3mcX22S
         XfI+wKE2t3GzYYqsW3kYwdsNz8D0XUQs3QDFrtP4omcn2tUK7brUPqKXwPwQbMb2Vmld
         5LVQ==
X-Received: by 10.68.172.5 with SMTP id ay5mr15770249pbc.73.1366326585192;
        Thu, 18 Apr 2013 16:09:45 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id ra9sm12357892pab.16.2013.04.18.16.09.41
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 16:09:44 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 19 Apr 2013 09:09:35 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1366326532-28517-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221708>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 utf8.c | 20 ++++++++++++++------
 utf8.h |  1 +
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/utf8.c b/utf8.c
index 6ed93c3..e7ba33c 100644
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
+		       (skip =3D display_mode_esc_sequence_len(string)) !=3D 0)
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
