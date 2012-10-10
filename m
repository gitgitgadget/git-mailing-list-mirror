From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 09/12] wildmatch: adjust "**" behavior
Date: Wed, 10 Oct 2012 17:40:48 +0700
Message-ID: <1349865651-31889-10-git-send-email-pclouds@gmail.com>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 12:42:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLtjv-0002zo-0j
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 12:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683Ab2JJKmA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 06:42:00 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:49272 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755674Ab2JJKl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 06:41:58 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so466174pad.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ohYHMtUtHC0XIngP7wLjl/yn4GikjdCGlw5VvtOik/c=;
        b=gBb1jW/jzvfzlNtzFu1QRK8qqB1WUzL20P+Mj8l3kuG4Pz3zzlKXDR3TsyBVpVsCVd
         ZxOYJg4kArl9Oyk6nGP47+FhOW4VDbXRgDnWSWCJLjkYY3OlAlU0bnjugyJVDymB9W7h
         334kJUjAEkTi5lMPDnGI5a94+jWMopaQ/U2QAuafbcvI9ank1qlTVDgA4bZQCPGPf4np
         XqhtN21r0K9012xWRi9Bn3mbwKcyyAaZas1Hx29Be03lDG4L2sIGZHz/1dxzqarIN6yh
         yvnZGcox1UH/lPIAmL4OwB8HeYYhbw56Br55LDDv1XFVXovo8yekJn7nzUk4iFwxMNjG
         jDAg==
Received: by 10.66.73.6 with SMTP id h6mr60635076pav.69.1349865718621;
        Wed, 10 Oct 2012 03:41:58 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id yi9sm500490pbc.39.2012.10.10.03.41.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 03:41:58 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Oct 2012 17:41:50 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207394>

Standard wildmatch() sees consecutive asterisks as "*" that can also
match slashes. But that may be hard to explain to users as
"abc/**/def" can match "abcdef", "abcxyzdef", "abc/def", "abc/x/def",
"abc/x/y/def"...

This patch changes wildmatch so that users can do

- "**/def" -> all paths ending with file/directory 'def'
- "abc/**" - equivalent to "/abc/"
- "abc/**/def" -> "abc/x/def", "abc/x/y/def"...
- otherwise consider the pattern malformed if "**" is found

Basically the magic of "**" only remains if it's wrapped around by
slashes.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t3070-wildmatch.sh |  5 +++--
 wildmatch.c          | 13 +++++++------
 wildmatch.h          |  6 ++++++
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index bb92f8d..f6c64be 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -36,7 +36,7 @@ match 0 0 foobar 'foo\*bar'
 match 1 1 'f\oo' 'f\\oo'
 match 1 1 ball '*[al]?'
 match 0 0 ten '[ten]'
-match 1 1 ten '**[!te]'
+match 0 1 ten '**[!te]'
 match 0 0 ten '**[!ten]'
 match 1 1 ten 't[a-g]n'
 match 0 0 ten 't[!a-g]n'
@@ -51,7 +51,8 @@ match 1 1 ']' ']'
=20
 # Extended slash-matching features
 match 0 0 'foo/baz/bar' 'foo*bar'
-match 1 0 'foo/baz/bar' 'foo**bar'
+match 0 0 'foo/baz/bar' 'foo**bar'
+match 0 1 'foobazbar' 'foo**bar'
 match 0 0 'foo/bar' 'foo?bar'
 match 0 0 'foo/bar' 'foo[/]bar'
 match 0 0 'foo/bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
diff --git a/wildmatch.c b/wildmatch.c
index b700631..e09a459 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -21,11 +21,6 @@ typedef unsigned char uchar;
 #define FALSE 0
 #define TRUE 1
=20
-#define NOMATCH 1
-#define MATCH 0
-#define ABORT_ALL -1
-#define ABORT_TO_STARSTAR -2
-
 #define CC_EQ(class, len, litmatch) ((len) =3D=3D sizeof (litmatch)-1 =
\
 				    && *(class) =3D=3D *(litmatch) \
 				    && strncmp((char*)class, litmatch, len) =3D=3D 0)
@@ -91,8 +86,14 @@ static int dowild(const uchar *p, const uchar *text,=
 int force_lower_case)
 	    continue;
 	  case '*':
 	    if (*++p =3D=3D '*') {
+		const uchar *prev_p =3D p - 2;
 		while (*++p =3D=3D '*') {}
-		special =3D TRUE;
+		if ((prev_p =3D=3D text || *prev_p =3D=3D '/') ||
+		    (*p =3D=3D '\0' || *p =3D=3D '/' ||
+		     (p[0] =3D=3D '\\' && p[1] =3D=3D '/'))) {
+		    special =3D TRUE;
+		} else
+		    return ABORT_MALFORMED;
 	    } else
 		special =3D FALSE;
 	    if (*p =3D=3D '\0') {
diff --git a/wildmatch.h b/wildmatch.h
index e974f9a..984a38c 100644
--- a/wildmatch.h
+++ b/wildmatch.h
@@ -1,3 +1,9 @@
 /* wildmatch.h */
=20
+#define ABORT_MALFORMED 2
+#define NOMATCH 1
+#define MATCH 0
+#define ABORT_ALL -1
+#define ABORT_TO_STARSTAR -2
+
 int wildmatch(const char *pattern, const char *text, int flags);
--=20
1.7.12.1.406.g6ab07c4
