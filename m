From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/8] wildmatch: remove static variable force_lower_case
Date: Tue,  9 Oct 2012 10:09:03 +0700
Message-ID: <1349752147-13314-5-git-send-email-pclouds@gmail.com>
References: <1349752147-13314-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 05:09:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLQCe-00068p-0f
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 05:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227Ab2JIDJm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2012 23:09:42 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53735 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab2JIDJk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 23:09:40 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4603957pbb.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 20:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=w4ZcOUAsUcVIUl6ogfqF1OT8BtILS2GdsQ8qo7hwGxg=;
        b=EhowWOK0cqeC8MC40APRBC02IE6/fhnu4gf706ALwyuOl2PxARKCru97OMyu2R/lFd
         WUlIzUksp40vDKORoufPmM5qKi77XzOm3XessUMkWA3BQi+vWKUJQ+EdIJYgjVr0JS0s
         Z3WgM+zLSQ73o244JXksxLFTRBLeYjTojDjoFA0UfilOeSl8hfE8ZSQHoYY0w6sOGiBw
         Rr4J2XkW1zzyKVX8q3nFVrsdO7NqCE6adFgWAM71tgsf/aZRb418zVzv8i1Cn4/GVu12
         0kiqLApnK7Li5h8BZlTarVpZjSzERvZTwYCR2emvS7sqUVKSnwV87Wq21QE8akkok/mU
         kpJA==
Received: by 10.68.204.162 with SMTP id kz2mr11410696pbc.76.1349752180277;
        Mon, 08 Oct 2012 20:09:40 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id iu8sm3295183pbc.71.2012.10.08.20.09.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Oct 2012 20:09:39 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 09 Oct 2012 10:09:34 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1349752147-13314-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207291>

One place less to worry about thread safety. Also combine wildmatch
and iwildmatch into one.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 test-wildmatch.c |  4 ++--
 wildmatch.c      | 23 ++++++-----------------
 wildmatch.h      |  3 +--
 3 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/test-wildmatch.c b/test-wildmatch.c
index 08962d5..5c18cf8 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -4,9 +4,9 @@
 int main(int argc, char **argv)
 {
 	if (!strcmp(argv[1], "wildmatch"))
-		return wildmatch(argv[3], argv[2]) ? 0 : 1;
+		return wildmatch(argv[3], argv[2], 0) ? 0 : 1;
 	else if (!strcmp(argv[1], "iwildmatch"))
-		return iwildmatch(argv[3], argv[2]) ? 0 : 1;
+		return wildmatch(argv[3], argv[2], FNM_CASEFOLD) ? 0 : 1;
 	else if (!strcmp(argv[1], "fnmatch"))
 		return fnmatch(argv[3], argv[2], FNM_PATHNAME);
 	else
diff --git a/wildmatch.c b/wildmatch.c
index 7b64a6b..2382873 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -11,8 +11,8 @@
=20
 #include <stddef.h>
 #include <ctype.h>
-#include <string.h>
=20
+#include "cache.h"
 #include "wildmatch.h"
=20
 typedef unsigned char uchar;
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
-		if ((matched =3D dowild(p, text)) !=3D FALSE) {
+		if ((matched =3D dowild(p, text, force_lower_case)) !=3D FALSE) {
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
-    return dowild((const uchar*)pattern, (const uchar*)text) =3D=3D TR=
UE;
-}
-
-/* Match the "pattern" against the forced-to-lower-case "text" string.=
 */
-int iwildmatch(const char *pattern, const char *text)
+int wildmatch(const char *pattern, const char *text, int flags)
 {
-    int ret;
-    force_lower_case =3D 1;
-    ret =3D dowild((const uchar*)pattern, (const uchar*)text) =3D=3D T=
RUE;
-    force_lower_case =3D 0;
-    return ret;
+    return dowild((const uchar*)pattern, (const uchar*)text,
+		  flags & FNM_CASEFOLD ? 1 : 0) =3D=3D TRUE;
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
