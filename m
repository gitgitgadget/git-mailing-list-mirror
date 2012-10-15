From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/13] ctype: support iscntrl, ispunct, isxdigit and isprint
Date: Mon, 15 Oct 2012 13:25:51 +0700
Message-ID: <1350282362-4505-2-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:26:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNe8H-0007FZ-2P
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923Ab2JOG0W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:26:22 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39239 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803Ab2JOG0W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:26:22 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4542541pad.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7OjUZlrrLwnoVhxFCym3TyvPBz+jHEhJL1r+9NOuXxo=;
        b=BAuXijCVDKS247r6SzwPzuhyEhcjw2ejxjWiw3bmyB/pYHtlH7VXpjJfAUwrBGQLZp
         pN8dHpaTcsRJNNH8aINAgmrGRhWTbuApNRAdyAgXW0CDafpdvxA9UsBGfdnj8xA0gtL2
         9B92wUG+d0vOjvRUb0h+DUSyUM8ds3DUDULrCkvRZpA6EjZMi3nDGUqHx43AgudErzfx
         IfBFACtvkUUZzn970x52n5PVwxGoZLz540QVHOW8pL3CSgGFtVesCaV0NoLsUqZniQqq
         RxqINCeDuxVptzlHp3wKgnbxQds3JP8v+OK2M9GlOs8YQ+jU6YomH6nfbHxhrVfck2Zb
         CupA==
Received: by 10.68.222.231 with SMTP id qp7mr34246811pbc.7.1350282381740;
        Sun, 14 Oct 2012 23:26:21 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id o5sm8582922paz.32.2012.10.14.23.26.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:26:20 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:26:11 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207700>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 ctype.c           | 13 ++++++++-----
 git-compat-util.h | 13 +++++++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/ctype.c b/ctype.c
index faeaf34..0bfebb4 100644
--- a/ctype.c
+++ b/ctype.c
@@ -11,18 +11,21 @@ enum {
 	D =3D GIT_DIGIT,
 	G =3D GIT_GLOB_SPECIAL,	/* *, ?, [, \\ */
 	R =3D GIT_REGEX_SPECIAL,	/* $, (, ), +, ., ^, {, | */
-	P =3D GIT_PATHSPEC_MAGIC  /* other non-alnum, except for ] and } */
+	P =3D GIT_PATHSPEC_MAGIC, /* other non-alnum, except for ] and } */
+	X =3D GIT_CNTRL,
+	U =3D GIT_PUNCT,
+	Z =3D GIT_CNTRL | GIT_SPACE
 };
=20
 const unsigned char sane_ctype[256] =3D {
-	0, 0, 0, 0, 0, 0, 0, 0, 0, S, S, 0, 0, S, 0, 0,		/*   0.. 15 */
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,		/*  16.. 31 */
+	X, X, X, X, X, X, X, X, X, Z, Z, X, X, Z, X, X,		/*   0.. 15 */
+	X, X, X, X, X, X, X, X, X, X, X, X, X, X, X, X,		/*  16.. 31 */
 	S, P, P, P, R, P, P, P, R, R, G, R, P, P, R, P,		/*  32.. 47 */
 	D, D, D, D, D, D, D, D, D, D, P, P, P, P, P, G,		/*  48.. 63 */
 	P, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  64.. 79 */
-	A, A, A, A, A, A, A, A, A, A, A, G, G, 0, R, P,		/*  80.. 95 */
+	A, A, A, A, A, A, A, A, A, A, A, G, G, U, R, P,		/*  80.. 95 */
 	P, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  96..111 */
-	A, A, A, A, A, A, A, A, A, A, A, R, R, 0, P, 0,		/* 112..127 */
+	A, A, A, A, A, A, A, A, A, A, A, R, R, U, P, X,		/* 112..127 */
 	/* Nothing in the 128.. range */
 };
=20
diff --git a/git-compat-util.h b/git-compat-util.h
index 80767ff..02f48f6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -470,6 +470,10 @@ extern const char tolower_trans_tbl[256];
 #undef isupper
 #undef tolower
 #undef toupper
+#undef iscntrl
+#undef ispunct
+#undef isxdigit
+#undef isprint
 extern const unsigned char sane_ctype[256];
 #define GIT_SPACE 0x01
 #define GIT_DIGIT 0x02
@@ -477,6 +481,8 @@ extern const unsigned char sane_ctype[256];
 #define GIT_GLOB_SPECIAL 0x08
 #define GIT_REGEX_SPECIAL 0x10
 #define GIT_PATHSPEC_MAGIC 0x20
+#define GIT_CNTRL 0x40
+#define GIT_PUNCT 0x80
 #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask))=
 !=3D 0)
 #define isascii(x) (((x) & ~0x7f) =3D=3D 0)
 #define isspace(x) sane_istest(x,GIT_SPACE)
@@ -487,6 +493,13 @@ extern const unsigned char sane_ctype[256];
 #define isupper(x) sane_iscase(x, 0)
 #define is_glob_special(x) sane_istest(x,GIT_GLOB_SPECIAL)
 #define is_regex_special(x) sane_istest(x,GIT_GLOB_SPECIAL | GIT_REGEX=
_SPECIAL)
+#define iscntrl(x) (sane_istest(x,GIT_CNTRL))
+#define ispunct(x) sane_istest(x, GIT_PUNCT | GIT_REGEX_SPECIAL | \
+		GIT_GLOB_SPECIAL | GIT_PATHSPEC_MAGIC)
+#define isxdigit(x) (hexval_table[x] !=3D -1)
+#define isprint(x) (sane_istest(x, GIT_ALPHA | GIT_DIGIT | GIT_SPACE |=
 \
+		GIT_PUNCT | GIT_REGEX_SPECIAL | GIT_GLOB_SPECIAL | \
+		GIT_PATHSPEC_MAGIC))
 #define tolower(x) sane_case((unsigned char)(x), 0x20)
 #define toupper(x) sane_case((unsigned char)(x), 0)
 #define is_pathspec_magic(x) sane_istest(x,GIT_PATHSPEC_MAGIC)
--=20
1.8.0.rc0.29.g1fdd78f
