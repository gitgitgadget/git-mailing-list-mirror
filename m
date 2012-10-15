From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/13] wildmatch: adjust "**" behavior
Date: Mon, 15 Oct 2012 13:26:00 +0700
Message-ID: <1350282362-4505-11-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:27:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNe9U-0008KL-MZ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996Ab2JOG1i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:27:38 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39239 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab2JOG1h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:27:37 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4542541pad.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KfRRcCmZiggj/pIXlf1g5FJ7tci0dWS2gYHtrai4gcw=;
        b=Fs+E4mgBDKkuPbqqtIIWOPYmnOf2+dWLe3kCp/satzy/RjCtuOobo1eJ+frNt0y5n7
         FK8FK4y7XdMkkBYNuQiuSMWFjCUzzbw8SrKoIP2iZUSe51H+omEGhtfo1NxolXus1ge0
         Iq4AYGlrlz1bfyaqDDhBc5QHfPJujo8jYfXt2ftrcnnZH0lJSPrTY1/zzSsfwW/t/10F
         NRvVQljZ+lBAZV7HWO8Vs20Y0tOYXU80S1xq/lFo2mGJY5DKk3QFdSd4qRCxDIq7ix1s
         GPxmxbeJDu20LxB7IFBliV8Xq0HOho57b3sdlIYVXIPa7L9EK+iQfxXB3oxHwAsOPOUu
         itDw==
Received: by 10.68.225.68 with SMTP id ri4mr33938469pbc.115.1350282457534;
        Sun, 14 Oct 2012 23:27:37 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id o1sm8589048pax.21.2012.10.14.23.27.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:27:36 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:27:27 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207709>

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
index dd95b00..15848d5 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -46,7 +46,7 @@ match 0 0 foobar 'foo\*bar'
 match 1 1 'f\oo' 'f\\oo'
 match 1 1 ball '*[al]?'
 match 0 0 ten '[ten]'
-match 1 1 ten '**[!te]'
+match 0 1 ten '**[!te]'
 match 0 0 ten '**[!ten]'
 match 1 1 ten 't[a-g]n'
 match 0 0 ten 't[!a-g]n'
@@ -61,7 +61,8 @@ match 1 1 ']' ']'
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
index 5469866..85bc0df 100644
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
@@ -90,8 +85,14 @@ static int dowild(const uchar *p, const uchar *text,=
 int force_lower_case)
 			continue;
 		case '*':
 			if (*++p =3D=3D '*') {
+				const uchar *prev_p =3D p - 2;
 				while (*++p =3D=3D '*') {}
-				special =3D TRUE;
+				if ((prev_p =3D=3D text || *prev_p =3D=3D '/') ||
+				    (*p =3D=3D '\0' || *p =3D=3D '/' ||
+				     (p[0] =3D=3D '\\' && p[1] =3D=3D '/'))) {
+					special =3D TRUE;
+				} else
+					return ABORT_MALFORMED;
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
1.8.0.rc0.29.g1fdd78f
