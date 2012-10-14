From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 07/12] wildmatch: make wildmatch's return value compatible with fnmatch
Date: Sun, 14 Oct 2012 09:35:05 +0700
Message-ID: <1350182110-25936-8-git-send-email-pclouds@gmail.com>
References: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 04:36:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNE45-0005hU-4I
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 04:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902Ab2JNCgR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Oct 2012 22:36:17 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37467 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2JNCgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 22:36:16 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3964144pbb.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 19:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DMwjccwaCTWrAJUyZYC0nvQlOKyLhpHOOfWvrLuZfIA=;
        b=slVh/daIPAbz3YCj48yzrJitBHFVhjPDvIloptIaOzMksxuWFsFIPAuurnf8gf7g3w
         Rb1UcxYzmcI+WRlGbSpg+ykwU/60DpAxODfkD0LZTAYrXFw3ZJbDp6SqlUlnA0y4QdcJ
         kl+pCmhpmzud4dJ/wdHUkeh0LFY6oJRmwdcoxa0ltFTjNLgjfJoIuRohgLJsUz2TzjIo
         gfBrWIrgQA/3PdwFbPVX9ZqC6AdBY6VPcAxypinKLLppuU1jyuZBZUu1TOR6AKizWuSK
         eOXGmHB3izrE79OohCz4w/Cb57pvj7BJLvCtgxTsKiBZJFSpEQhe9Xct121fcQovERs8
         uepg==
Received: by 10.68.200.231 with SMTP id jv7mr25769237pbc.140.1350182175863;
        Sat, 13 Oct 2012 19:36:15 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id py9sm6818981pbb.20.2012.10.13.19.36.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 13 Oct 2012 19:36:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Oct 2012 09:36:01 +0700
X-Mailer: git-send-email 1.8.0.rc2.11.g2b79d01
In-Reply-To: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207598>

wildmatch returns non-zero if matched, zero otherwise. This patch
makes it return zero if matches, non-zero otherwise, like fnmatch().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 test-wildmatch.c |  4 ++--
 wildmatch.c      | 21 ++++++++++++---------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/test-wildmatch.c b/test-wildmatch.c
index ac56420..77014e9 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -4,9 +4,9 @@
 int main(int argc, char **argv)
 {
 	if (!strcmp(argv[1], "wildmatch"))
-		return wildmatch(argv[3], argv[2]) ? 0 : 1;
+		return !!wildmatch(argv[3], argv[2]);
 	else if (!strcmp(argv[1], "iwildmatch"))
-		return iwildmatch(argv[3], argv[2]) ? 0 : 1;
+		return !!iwildmatch(argv[3], argv[2]);
 	else if (!strcmp(argv[1], "fnmatch"))
 		return !!fnmatch(argv[3], argv[2], FNM_PATHNAME);
 	else
diff --git a/wildmatch.c b/wildmatch.c
index d0b906a..e3ac6cc 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -20,6 +20,9 @@ typedef unsigned char uchar;
=20
 #define FALSE 0
 #define TRUE 1
+
+#define NOMATCH 1
+#define MATCH 0
 #define ABORT_ALL -1
 #define ABORT_TO_STARSTAR -2
=20
@@ -78,12 +81,12 @@ static int dowild(const uchar *p, const uchar *text=
)
 	    /* FALLTHROUGH */
 	  default:
 	    if (t_ch !=3D p_ch)
-		return FALSE;
+		return NOMATCH;
 	    continue;
 	  case '?':
 	    /* Match anything but '/'. */
 	    if (t_ch =3D=3D '/')
-		return FALSE;
+		return NOMATCH;
 	    continue;
 	  case '*':
 	    if (*++p =3D=3D '*') {
@@ -96,14 +99,14 @@ static int dowild(const uchar *p, const uchar *text=
)
 		 * only if there are no more slash characters. */
 		if (!special) {
 			if (strchr((char*)text, '/') !=3D NULL)
-			    return FALSE;
+			    return NOMATCH;
 		}
-		return TRUE;
+		return MATCH;
 	    }
 	    while (1) {
 		if (t_ch =3D=3D '\0')
 		    break;
-		if ((matched =3D dowild(p, text)) !=3D FALSE) {
+		if ((matched =3D dowild(p, text)) !=3D NOMATCH) {
 		    if (!special || matched !=3D ABORT_TO_STARSTAR)
 			return matched;
 		} else if (!special && t_ch =3D=3D '/')
@@ -202,18 +205,18 @@ static int dowild(const uchar *p, const uchar *te=
xt)
 		    matched =3D TRUE;
 	    } while (prev_ch =3D p_ch, (p_ch =3D *++p) !=3D ']');
 	    if (matched =3D=3D special || t_ch =3D=3D '/')
-		return FALSE;
+		return NOMATCH;
 	    continue;
 	}
     }
=20
-    return *text ? FALSE : TRUE;
+    return *text ? NOMATCH : MATCH;
 }
=20
 /* Match the "pattern" against the "text" string. */
 int wildmatch(const char *pattern, const char *text)
 {
-    return dowild((const uchar*)pattern, (const uchar*)text) =3D=3D TR=
UE;
+    return dowild((const uchar*)pattern, (const uchar*)text);
 }
=20
 /* Match the "pattern" against the forced-to-lower-case "text" string.=
 */
@@ -221,7 +224,7 @@ int iwildmatch(const char *pattern, const char *tex=
t)
 {
     int ret;
     force_lower_case =3D 1;
-    ret =3D dowild((const uchar*)pattern, (const uchar*)text) =3D=3D T=
RUE;
+    ret =3D dowild((const uchar*)pattern, (const uchar*)text);
     force_lower_case =3D 0;
     return ret;
 }
--=20
1.8.0.rc2.11.g2b79d01
