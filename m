From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 07/12] wildmatch: remove static variable force_lower_case
Date: Wed, 10 Oct 2012 17:40:46 +0700
Message-ID: <1349865651-31889-8-git-send-email-pclouds@gmail.com>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 12:41:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLtji-0002sj-HZ
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 12:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614Ab2JJKls convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 06:41:48 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:49272 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755600Ab2JJKlr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 06:41:47 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so466174pad.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Cwaows+ZmQjUAh1+BK2zTHF2f7dTdgeM+YcdUPXZFhA=;
        b=l8HxbwkXz0AdE4cEmo3ZVeTIMyD641PMTYujf/+fWb77f6oDWXHpqJZ4rD209xkc26
         Uw9e1dc1ElIaG3hr6L+T6iSxskPYwsDgXlRys7cdzeDRw5dK1odCqSylQFoj/T3sd+wR
         GbFS993d2+1okj/4QYSjf1vm5zIJRn2SwriO8vUvGP1xmmW0mOHOiSx2n6Q56Bt+jPjD
         4PgCnHU7SbqOU8NsPmuViokl9WvGsGnFkc3i/75OCS5Lj4O/lI/vQ5QEMTDySG41EFl8
         +oK+TZeh/CZP9plbEw3mND2h8WE4Gug9tm/k7NMXCU8k/uxxIW35QItXd2uOexFK6kvP
         laWA==
Received: by 10.68.217.130 with SMTP id oy2mr71977426pbc.144.1349865707002;
        Wed, 10 Oct 2012 03:41:47 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id gj9sm850823pbc.16.2012.10.10.03.41.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 03:41:46 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Oct 2012 17:41:35 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207392>

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
index 596029c..d716852 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -4,9 +4,9 @@
 int main(int argc, char **argv)
 {
 	if (!strcmp(argv[1], "wildmatch"))
-		return wildmatch(argv[3], argv[2]);
+		return wildmatch(argv[3], argv[2], 0);
 	else if (!strcmp(argv[1], "iwildmatch"))
-		return iwildmatch(argv[3], argv[2]);
+		return wildmatch(argv[3], argv[2], FNM_CASEFOLD);
 	else if (!strcmp(argv[1], "fnmatch"))
 		return fnmatch(argv[3], argv[2], FNM_PATHNAME);
 	else
diff --git a/wildmatch.c b/wildmatch.c
index 7c180e3..d18d721 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -59,11 +59,9 @@ typedef unsigned char uchar;
 #define ISUPPER(c) (ISASCII(c) && isupper(c))
 #define ISXDIGIT(c) (ISASCII(c) && isxdigit(c))
=20
-static int force_lower_case =3D 0;
-
 /* Match pattern "p" against the a virtually-joined string consisting
  * of "text" and any strings in array "a". */
-static int dowild(const uchar *p, const uchar *text)
+static int dowild(const uchar *p, const uchar *text, int force_lower_c=
ase)
 {
     uchar p_ch;
=20
@@ -107,7 +105,7 @@ static int dowild(const uchar *p, const uchar *text=
)
 	    while (1) {
 		if (t_ch =3D=3D '\0')
 		    break;
-		if ((matched =3D dowild(p, text)) !=3D NOMATCH) {
+		if ((matched =3D dowild(p, text, force_lower_case)) !=3D NOMATCH) {
 		    if (!special || matched !=3D ABORT_TO_STARSTAR)
 			return matched;
 		} else if (!special && t_ch =3D=3D '/')
@@ -215,17 +213,8 @@ static int dowild(const uchar *p, const uchar *tex=
t)
 }
=20
 /* Match the "pattern" against the "text" string. */
-int wildmatch(const char *pattern, const char *text)
-{
-    return dowild((const uchar*)pattern, (const uchar*)text);
-}
-
-/* Match the "pattern" against the forced-to-lower-case "text" string.=
 */
-int iwildmatch(const char *pattern, const char *text)
+int wildmatch(const char *pattern, const char *text, int flags)
 {
-    int ret;
-    force_lower_case =3D 1;
-    ret =3D dowild((const uchar*)pattern, (const uchar*)text);
-    force_lower_case =3D 0;
-    return ret;
+    return dowild((const uchar*)pattern, (const uchar*)text,
+		  flags & FNM_CASEFOLD ? 1 : 0);
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
1.7.12.1.406.g6ab07c4
