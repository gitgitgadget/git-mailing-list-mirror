From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/13] wildmatch: remove static variable force_lower_case
Date: Mon, 15 Oct 2012 13:25:58 +0700
Message-ID: <1350282362-4505-9-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:27:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNe9F-00085Q-1p
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab2JOG1W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:27:22 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39239 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab2JOG1V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:27:21 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4542541pad.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=e7IsfGDhe5241pJ+cPK4an1Bezoy1qmaiSfglQaCZGw=;
        b=zGE0AvGN/VzS/RTeutGfmkG6hrMfNaGgRgK8bT0XStnflGcgmnu0WRcpUOs6wWaFAg
         ruEsTi6MzHn/skq4zdLXdL++gyu61QYKZokveb66Zz0kQ7nIm0Jcuqui5vOWNrFa0j1R
         scsNeKuETDqeECu2lr7fwwYm0jTayxVDAaKXerZKSzBw9jJhyU1ngvUmWbtfPWoqSYWB
         rNz1fDfbX8+qykkGbEkJeuiKVHJohBUtXfUYdk7HkWDp9SPxjGw7NUYhrgr8ab/IDGkQ
         ZiP9k/nHkjy6gfHOoNPq/0adm6JG+tZk5/kYnG3z2xRlmX9Ud5TQBMQYA+tYU3tA8vJE
         gVyg==
Received: by 10.68.247.196 with SMTP id yg4mr34841605pbc.167.1350282441432;
        Sun, 14 Oct 2012 23:27:21 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id oe5sm8582883pbb.8.2012.10.14.23.27.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:27:20 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:27:11 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207707>

One place less to worry about thread safety. Also combine wildmatch
and iwildmatch into one.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 test-wildmatch.c |  4 ++--
 wildmatch.c      | 21 +++++----------------
 wildmatch.h      |  3 +--
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/test-wildmatch.c b/test-wildmatch.c
index 77014e9..74c0864 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -4,9 +4,9 @@
 int main(int argc, char **argv)
 {
 	if (!strcmp(argv[1], "wildmatch"))
-		return !!wildmatch(argv[3], argv[2]);
+		return !!wildmatch(argv[3], argv[2], 0);
 	else if (!strcmp(argv[1], "iwildmatch"))
-		return !!iwildmatch(argv[3], argv[2]);
+		return !!wildmatch(argv[3], argv[2], FNM_CASEFOLD);
 	else if (!strcmp(argv[1], "fnmatch"))
 		return !!fnmatch(argv[3], argv[2], FNM_PATHNAME);
 	else
diff --git a/wildmatch.c b/wildmatch.c
index 6d992d3..eef7b13 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -59,10 +59,8 @@ typedef unsigned char uchar;
 #define ISUPPER(c) (ISASCII(c) && isupper(c))
 #define ISXDIGIT(c) (ISASCII(c) && isxdigit(c))
=20
-static int force_lower_case =3D 0;
-
 /* Match pattern "p" against "text" */
-static int dowild(const uchar *p, const uchar *text)
+static int dowild(const uchar *p, const uchar *text, int force_lower_c=
ase)
 {
 	uchar p_ch;
=20
@@ -106,7 +104,7 @@ static int dowild(const uchar *p, const uchar *text=
)
 			while (1) {
 				if (t_ch =3D=3D '\0')
 					break;
-				if ((matched =3D dowild(p, text)) !=3D NOMATCH) {
+				if ((matched =3D dowild(p, text,  force_lower_case)) !=3D NOMATCH)=
 {
 					if (!special || matched !=3D ABORT_TO_STARSTAR)
 						return matched;
 				} else if (!special && t_ch =3D=3D '/')
@@ -214,17 +212,8 @@ static int dowild(const uchar *p, const uchar *tex=
t)
 }
=20
 /* Match the "pattern" against the "text" string. */
-int wildmatch(const char *pattern, const char *text)
-{
-	return dowild((const uchar*)pattern, (const uchar*)text);
-}
-
-/* Match the "pattern" against the forced-to-lower-case "text" string.=
 */
-int iwildmatch(const char *pattern, const char *text)
+int wildmatch(const char *pattern, const char *text, int flags)
 {
-	int ret;
-	force_lower_case =3D 1;
-	ret =3D dowild((const uchar*)pattern, (const uchar*)text);
-	force_lower_case =3D 0;
-	return ret;
+	return dowild((const uchar*)pattern, (const uchar*)text,
+		      flags & FNM_CASEFOLD ? 1 :0);
 }
diff --git a/wildmatch.h b/wildmatch.h
index 562faa3..e974f9a 100644
--- a/wildmatch.h
+++ b/wildmatch.h
@@ -1,4 +1,3 @@
 /* wildmatch.h */
=20
-int wildmatch(const char *pattern, const char *text);
-int iwildmatch(const char *pattern, const char *text);
+int wildmatch(const char *pattern, const char *text, int flags);
--=20
1.8.0.rc0.29.g1fdd78f
