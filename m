From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 15/21] checkout: convert read_tree_some to take struct pathspec
Date: Fri, 11 Jan 2013 18:21:09 +0700
Message-ID: <1357903275-16804-16-git-send-email-pclouds@gmail.com>
References: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 12:23:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtchM-0007ju-Sv
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 12:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555Ab3AKLWh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 06:22:37 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:38541 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891Ab3AKLWg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 06:22:36 -0500
Received: by mail-pa0-f53.google.com with SMTP id hz1so963970pad.12
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 03:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=blHDIW+qZ6nN4HBiblp28fftz/0aIs2RAaZZ0HrbtsA=;
        b=joaG+qecLBTBf36c9bik5pH5clrRG5UvPouIqpzlQtNi/bSakkwpoWGo5v4env/t8t
         DBq7IBaq4pXKn3pzOCJDm3uMW45IxnMlgr5lJqn00LgkEJIjvdHdVZKY9jkHRXOhP90X
         6LGnnToNknE6Z3xZxPt30DU9f/gb48KsRd6msk1sQ4B+oPy8Q+6AbXrGRSCceKsrR3e5
         Ed36iy991MkPfBuJMrUd8OKpqZ9glIE1E9By1J8wrE9N7LZ3ezBb/lbkAkrLabtRz9/o
         ZP8wAng2ZWq06aWKgULS+00MH/Z1TFAihnM9R2I3hd8nDsZjMg3AaeZmE2j+ODxZrkav
         4azA==
X-Received: by 10.68.212.200 with SMTP id nm8mr231413910pbc.4.1357903355707;
        Fri, 11 Jan 2013 03:22:35 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id tq4sm2635815pbc.50.2013.01.11.03.22.32
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 03:22:35 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 18:22:50 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213208>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 9 +++------
 tree.c             | 4 ++--
 tree.h             | 2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index aa399d6..a7ddb35 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -82,12 +82,9 @@ static int update_some(const unsigned char *sha1, co=
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
@@ -265,7 +262,7 @@ static int checkout_paths(const struct checkout_opt=
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
1.8.0.rc2.23.g1fb49df
