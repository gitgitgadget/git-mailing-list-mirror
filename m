From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH nd/wildmatch] Correct Git's version of isprint and isspace
Date: Tue, 13 Nov 2012 17:46:12 +0700
Message-ID: <1352803572-14547-1-git-send-email-pclouds@gmail.com>
References: <507E9FDE.7080706@cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, schnhrr@cs.tu-berlin.de,
	rene.scharfe@lsrfire.ath.cx,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 11:46:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYE0w-0007f5-3Y
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 11:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818Ab2KMKq2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2012 05:46:28 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60785 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783Ab2KMKq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 05:46:27 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so5034484pbb.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 02:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eO0GjkhN564NfMysrGL8Zy1opBeKh/oF1KysW2+HtuM=;
        b=ezr/G0DIkY2hII6O665f5gXFBls8hjSKJPbpOglmX3iZ3MQP/1DqxkjUAK2WUIL+4i
         KOb2sRxKBJRq/2savV9ffrlHcHc2wsOe3CDeq8i4oRw6z0oBV8jBzmLYJP96JhNFHayM
         bb0B9RVQDhl9HVitW5W4SjJTGmLoDJBIVJ5Mj7Sb1VIxC1RgcBZij8hE2xFBGxrNbK8K
         IyDTadE/uQGimhowZMkK0Mt0DXL7B31oxAC7uW7sUtEZ19rEUkr4Rmam9KtAobbW2nkB
         bRM7VOlcqA7H5FFFmb02qPTdkoedWXiv8OkOIOZZiKQJCkpuiRTipSnA5Ro9sZ5fDBDD
         UNwQ==
Received: by 10.68.136.135 with SMTP id qa7mr65914085pbb.157.1352803587139;
        Tue, 13 Nov 2012 02:46:27 -0800 (PST)
Received: from lanh ([115.74.37.170])
        by mx.google.com with ESMTPS id ty4sm5791672pbc.57.2012.11.13.02.46.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 02:46:26 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 13 Nov 2012 17:46:29 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <507E9FDE.7080706@cs.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209596>

Git's ispace does not include 11 and 12. Git's isprint includes
control space characters (10-13). According to glibc-2.14.1 on C
locale on Linux, this is wrong. This patch fixes it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I wrote a small C program to compare the result of all is* functions
 that Git replaces against the libc version. These are the only ones th=
at
 differ. Which matches what Jan Sch=C3=B6nherr commented.

 ctype.c           |  6 +++---
 git-compat-util.h | 11 ++++++-----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/ctype.c b/ctype.c
index 0bfebb4..71311a3 100644
--- a/ctype.c
+++ b/ctype.c
@@ -14,11 +14,11 @@ enum {
 	P =3D GIT_PATHSPEC_MAGIC, /* other non-alnum, except for ] and } */
 	X =3D GIT_CNTRL,
 	U =3D GIT_PUNCT,
-	Z =3D GIT_CNTRL | GIT_SPACE
+	Z =3D GIT_CNTRL_SPACE
 };
=20
-const unsigned char sane_ctype[256] =3D {
-	X, X, X, X, X, X, X, X, X, Z, Z, X, X, Z, X, X,		/*   0.. 15 */
+const unsigned int sane_ctype[256] =3D {
+	X, X, X, X, X, X, X, X, X, Z, Z, Z, Z, Z, X, X,		/*   0.. 15 */
 	X, X, X, X, X, X, X, X, X, X, X, X, X, X, X, X,		/*  16.. 31 */
 	S, P, P, P, R, P, P, P, R, R, G, R, P, P, R, P,		/*  32.. 47 */
 	D, D, D, D, D, D, D, D, D, D, P, P, P, P, P, G,		/*  48.. 63 */
diff --git a/git-compat-util.h b/git-compat-util.h
index 02f48f6..4ed3f94 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -474,8 +474,8 @@ extern const char tolower_trans_tbl[256];
 #undef ispunct
 #undef isxdigit
 #undef isprint
-extern const unsigned char sane_ctype[256];
-#define GIT_SPACE 0x01
+extern const unsigned int sane_ctype[256];
+#define GIT_CNTRL_SPACE 0x01
 #define GIT_DIGIT 0x02
 #define GIT_ALPHA 0x04
 #define GIT_GLOB_SPECIAL 0x08
@@ -483,9 +483,10 @@ extern const unsigned char sane_ctype[256];
 #define GIT_PATHSPEC_MAGIC 0x20
 #define GIT_CNTRL 0x40
 #define GIT_PUNCT 0x80
-#define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask))=
 !=3D 0)
+#define GIT_SPACE 0x100
+#define sane_istest(x,mask) ((sane_ctype[(unsigned int)(x)] & (mask)) =
!=3D 0)
 #define isascii(x) (((x) & ~0x7f) =3D=3D 0)
-#define isspace(x) sane_istest(x,GIT_SPACE)
+#define isspace(x) sane_istest(x,GIT_SPACE | GIT_CNTRL_SPACE)
 #define isdigit(x) sane_istest(x,GIT_DIGIT)
 #define isalpha(x) sane_istest(x,GIT_ALPHA)
 #define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
@@ -493,7 +494,7 @@ extern const unsigned char sane_ctype[256];
 #define isupper(x) sane_iscase(x, 0)
 #define is_glob_special(x) sane_istest(x,GIT_GLOB_SPECIAL)
 #define is_regex_special(x) sane_istest(x,GIT_GLOB_SPECIAL | GIT_REGEX=
_SPECIAL)
-#define iscntrl(x) (sane_istest(x,GIT_CNTRL))
+#define iscntrl(x) (sane_istest(x,GIT_CNTRL | GIT_CNTRL_SPACE))
 #define ispunct(x) sane_istest(x, GIT_PUNCT | GIT_REGEX_SPECIAL | \
 		GIT_GLOB_SPECIAL | GIT_PATHSPEC_MAGIC)
 #define isxdigit(x) (hexval_table[x] !=3D -1)
--=20
1.8.0.rc2.23.g1fb49df
