From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/6] utf8.c: add utf8_strnwidth() with the ability to skip ansi sequences
Date: Sat, 22 Sep 2012 11:22:18 +0700
Message-ID: <1348287739-12128-6-git-send-email-pclouds@gmail.com>
References: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 22 06:23:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFHFB-0003Pi-36
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 06:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460Ab2IVEWp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Sep 2012 00:22:45 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61105 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab2IVEWj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 00:22:39 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3905556pbb.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 21:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=a5NmWLU7PG/8gMlbpvD8U5b3vXJdCR/u1wahERFg2h0=;
        b=RzciBsyacy42e7scfrjdJ8HnPQ8FdNdyJHoEY1Oj8s7tJsxZJ7+yT4baD4bKVge5Qv
         /iuM4iJuC8eBJdFHrMNcZO9XmJz9rRNMWhKdnRPx0vuKSMxrhpxTsR+4R3j0W47ZiRqY
         o6Dd2MFQ08UHCqhnTh0asnk/fjm2lmdbGsAv6GzSt9On87fmkVOVYZmao0f72JVclbx/
         uyBN8DnKswWWEZtInjM4jP0yS/K6FEnqr6sz22Bz7bH8JnAgGvvh0DwWMqG1g9dw75Zv
         OqfOOa0RTSCcJ0VaZ1k4AtgM2GXHgIxyVjgrIT3ksvCnXAgkjpN4qw4iCjYf0Q5zZeQv
         qhdA==
Received: by 10.68.229.138 with SMTP id sq10mr20654381pbc.126.1348287759047;
        Fri, 21 Sep 2012 21:22:39 -0700 (PDT)
Received: from lanh ([115.74.43.144])
        by mx.google.com with ESMTPS id it6sm6107685pbc.14.2012.09.21.21.22.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Sep 2012 21:22:38 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Sep 2012 11:22:49 +0700
X-Mailer: git-send-email 1.7.12.1.384.g7b808e7
In-Reply-To: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206184>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 utf8.c | 20 ++++++++++++++------
 utf8.h |  1 +
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/utf8.c b/utf8.c
index 18a4d9c..791499e 100644
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
index 3c0ae76..58d5b6b 100644
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
1.7.12.1.384.g7b808e7
