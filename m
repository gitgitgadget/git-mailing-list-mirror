From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 08/12] wildmatch: remove static variable force_lower_case
Date: Sun, 14 Oct 2012 09:35:06 +0700
Message-ID: <1350182110-25936-9-git-send-email-pclouds@gmail.com>
References: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 04:36:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNE49-0005oo-H3
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 04:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929Ab2JNCgW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Oct 2012 22:36:22 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:49097 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab2JNCgV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 22:36:21 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1977549dak.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 19:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UJpwruKx7aGHsDcWqkhFfaB5QO+2x7ewW3SqT+jbNjI=;
        b=DeCygG7NoNs5TSPqD/kpAR9siSwV4x6oDbBuV/C44IH7axDVvoED6n2cmL9sajc8E8
         VDv2RK80mGVlwhtMHOoOsMIssEFkQhEDT55ZH1rW1n2rj5DqjV8yIPF7cZuuKIm6X9fI
         vIUympuOb45YUdHROtUVLEjzHErUe4SS8nSYkFKIuzh4BXf1sS8QI2FQBMhRM9plF8HU
         1+Vdx1F+iYvN7RagRcILKGCptH3jTMbWfMAntFO/cx122iRY4EuLGMemMOewFBq/jJuI
         D9mrczVTbjmYzGk/92bqYuphq+wQcMD5BkawzeWKh6BblbmoEa/ymuB5I8yCLnD6JM5R
         0Pyw==
Received: by 10.68.132.40 with SMTP id or8mr26063833pbb.63.1350182181560;
        Sat, 13 Oct 2012 19:36:21 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id pl2sm1323981pbb.66.2012.10.13.19.36.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 13 Oct 2012 19:36:20 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Oct 2012 09:36:07 +0700
X-Mailer: git-send-email 1.8.0.rc2.11.g2b79d01
In-Reply-To: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207599>

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
index e3ac6cc..20c5ef6 100644
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
-		if ((matched =3D dowild(p, text)) !=3D NOMATCH) {
+		if ((matched =3D dowild(p, text, force_lower_case)) !=3D NOMATCH) {
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
1.8.0.rc2.11.g2b79d01
