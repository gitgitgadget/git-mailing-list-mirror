From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 29/45] checkout: convert read_tree_some to take struct pathspec
Date: Sun,  9 Jun 2013 13:26:02 +0700
Message-ID: <1370759178-1709-30-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:28:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ6f-0001Eu-Do
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579Ab3FIG15 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:27:57 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:35392 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab3FIG14 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:27:56 -0400
Received: by mail-pb0-f51.google.com with SMTP id um15so6115857pbc.24
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1ebXXhwCmVJR6pSPEPyQwUj7PgaEkpfF7u1T+W3E4OY=;
        b=uEGeAOqXH98PFhS2OJpoMOUMMRMtIb2IVYif436N2D+1HoJi4aIhqiF8zRlVaCdB67
         nEGQ1SSAL7TS59k+U1Y9pAmonk13fLoHJdXwtj3c34wEMI4F9x6M2FQ9XN3J2O5m8vGf
         CKNS6yyJZLg/UtrbxAU8MZueXjbmH3TaQTtlyeoFBP1uT6ZwbGqSHuET1kuRkSEIbEsS
         fZOZy88DrFwSIfkMeovxRjHk23RWHi2tc8khtoFWYCphTGAVB77snBSARl+N7EvlrVR/
         5E0FGuKtoHfDP1DCpqtxoUUatqw7dO5szfBjncyAIgZbwAmQRJWMW3zf5EDw7r6JTXB4
         GLfA==
X-Received: by 10.68.1.226 with SMTP id 2mr5173884pbp.150.1370759276424;
        Sat, 08 Jun 2013 23:27:56 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id wi6sm5528898pbc.22.2013.06.08.23.27.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:27:55 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:29:27 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226921>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 9 +++------
 tree.c             | 4 ++--
 tree.h             | 2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0e93af0..be08061 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -83,12 +83,9 @@ static int update_some(const unsigned char *sha1, co=
nst char *base, int baselen,
 	return 0;
 }
=20
-static int read_tree_some(struct tree *tree, const char **pathspec)
+static int read_tree_some(struct tree *tree, const struct pathspec *pa=
thspec)
 {
-	struct pathspec ps;
-	init_pathspec(&ps, pathspec);
-	read_tree_recursive(tree, "", 0, 0, &ps, update_some, NULL);
-	free_pathspec(&ps);
+	read_tree_recursive(tree, "", 0, 0, pathspec, update_some, NULL);
=20
 	/* update the index with the given tree's info
 	 * for all args, expanding wildcards, and exit
@@ -266,7 +263,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 		return error(_("corrupt index file"));
=20
 	if (opts->source_tree)
-		read_tree_some(opts->source_tree, opts->pathspec.raw);
+		read_tree_some(opts->source_tree, &opts->pathspec);
=20
 	ps_matched =3D xcalloc(1, opts->pathspec.nr);
=20
diff --git a/tree.c b/tree.c
index 62fed63..ff72f67 100644
--- a/tree.c
+++ b/tree.c
@@ -47,7 +47,7 @@ static int read_one_entry_quick(const unsigned char *=
sha1, const char *base, int
 }
=20
 static int read_tree_1(struct tree *tree, struct strbuf *base,
-		       int stage, struct pathspec *pathspec,
+		       int stage, const struct pathspec *pathspec,
 		       read_tree_fn_t fn, void *context)
 {
 	struct tree_desc desc;
@@ -116,7 +116,7 @@ static int read_tree_1(struct tree *tree, struct st=
rbuf *base,
=20
 int read_tree_recursive(struct tree *tree,
 			const char *base, int baselen,
-			int stage, struct pathspec *pathspec,
+			int stage, const struct pathspec *pathspec,
 			read_tree_fn_t fn, void *context)
 {
 	struct strbuf sb =3D STRBUF_INIT;
diff --git a/tree.h b/tree.h
index 69bcb5e..9dc90ba 100644
--- a/tree.h
+++ b/tree.h
@@ -25,7 +25,7 @@ typedef int (*read_tree_fn_t)(const unsigned char *, =
const char *, int, const ch
=20
 extern int read_tree_recursive(struct tree *tree,
 			       const char *base, int baselen,
-			       int stage, struct pathspec *pathspec,
+			       int stage, const struct pathspec *pathspec,
 			       read_tree_fn_t fn, void *context);
=20
 extern int read_tree(struct tree *tree, int stage, struct pathspec *pa=
thspec);
--=20
1.8.2.83.gc99314b
