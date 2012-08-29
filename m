From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/3] checkout: pass "struct checkout_opts *" as const pointer
Date: Wed, 29 Aug 2012 20:55:22 +0700
Message-ID: <1346248524-11616-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8Cjbg2tb_E+D7hMwPZNFWhvEF1eNpf5HUBzJnBoQQaMAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 16:02:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6iqH-0006os-JD
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 16:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708Ab2H2OBy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Aug 2012 10:01:54 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45785 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab2H2OBx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 10:01:53 -0400
Received: by pbbrr13 with SMTP id rr13so1274461pbb.19
        for <git@vger.kernel.org>; Wed, 29 Aug 2012 07:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1Plho4DHvf38EwdnSXT52NqgrUcV1oGKhHgdxaCGYso=;
        b=BSeH3w8A4quAHm5hA60QY9sJ/RURPQhGiNFU/lV8ZoyQGSly4+lwGcvt23nlO6B2NV
         WbH8TZMPQq93SKJaui4aM2WKeNU7MvZ1CI3dlaRAg4jFEgeQHwiTEDnB0Qp9kWXhGZyP
         hOeCVWmHZlwIR4CsAhYDQyh5BApemlKdd4+Xkkb6RzwnmOjyMyfslEDcY6nxMKrYsiK2
         LCvsLqhcVqOLJtiUzhjtUFJPQxUr1V7J8rs2BqOldsGX2aFkYuqUON/5ot/AhiV8BFAR
         SwQa4F5e/uhWYBXqFvRxruX2HKaqPqX5PdTP3OzLjAcFEJF0WfsglDkOnk/B46JnF0pd
         nytg==
Received: by 10.68.241.226 with SMTP id wl2mr5136149pbc.62.1346248912599;
        Wed, 29 Aug 2012 07:01:52 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.49.176])
        by mx.google.com with ESMTPS id wf7sm19406119pbc.34.2012.08.29.07.01.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Aug 2012 07:01:50 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 29 Aug 2012 20:55:30 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <CACsJy8Cjbg2tb_E+D7hMwPZNFWhvEF1eNpf5HUBzJnBoQQaMAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204478>

This struct contains various switches to system and it feels somewhat
safer to have the compiler reassure us that nowhere else changes it.

One field that is changed, writeout_error, is split out and passed as
another argument.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7d922c6..3e3f086 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -33,7 +33,6 @@ struct checkout_opts {
 	int force;
 	int force_detach;
 	int writeout_stage;
-	int writeout_error;
 	int overwrite_ignore;
=20
 	/* not set by parse_options */
@@ -216,7 +215,7 @@ static int checkout_merged(int pos, struct checkout=
 *state)
 }
=20
 static int checkout_paths(struct tree *source_tree, const char **paths=
pec,
-			  const char *prefix, struct checkout_opts *opts)
+			  const char *prefix, const struct checkout_opts *opts)
 {
 	int pos;
 	struct checkout state;
@@ -309,7 +308,8 @@ static int checkout_paths(struct tree *source_tree,=
 const char **pathspec,
 	return errs;
 }
=20
-static void show_local_changes(struct object *head, struct diff_option=
s *opts)
+static void show_local_changes(struct object *head,
+			       const struct diff_options *opts)
 {
 	struct rev_info rev;
 	/* I think we want full paths, even if we're in a subdirectory. */
@@ -331,7 +331,8 @@ static void describe_detached_head(const char *msg,=
 struct commit *commit)
 	strbuf_release(&sb);
 }
=20
-static int reset_tree(struct tree *tree, struct checkout_opts *o, int =
worktree)
+static int reset_tree(struct tree *tree, const struct checkout_opts *o=
,
+		      int worktree, int *writeout_error)
 {
 	struct unpack_trees_options opts;
 	struct tree_desc tree_desc;
@@ -350,7 +351,7 @@ static int reset_tree(struct tree *tree, struct che=
ckout_opts *o, int worktree)
 	init_tree_desc(&tree_desc, tree->buffer, tree->size);
 	switch (unpack_trees(1, &tree_desc, &opts)) {
 	case -2:
-		o->writeout_error =3D 1;
+		*writeout_error =3D 1;
 		/*
 		 * We return 0 nevertheless, as the index is all right
 		 * and more importantly we have made best efforts to
@@ -381,8 +382,10 @@ static void setup_branch_path(struct branch_info *=
branch)
 	branch->path =3D strbuf_detach(&buf, NULL);
 }
=20
-static int merge_working_tree(struct checkout_opts *opts,
-			      struct branch_info *old, struct branch_info *new)
+static int merge_working_tree(const struct checkout_opts *opts,
+			      struct branch_info *old,
+			      struct branch_info *new,
+			      int *writeout_error)
 {
 	int ret;
 	struct lock_file *lock_file =3D xcalloc(1, sizeof(struct lock_file));
@@ -393,7 +396,7 @@ static int merge_working_tree(struct checkout_opts =
*opts,
=20
 	resolve_undo_clear();
 	if (opts->force) {
-		ret =3D reset_tree(new->commit->tree, opts, 1);
+		ret =3D reset_tree(new->commit->tree, opts, 1, writeout_error);
 		if (ret)
 			return ret;
 	} else {
@@ -479,7 +482,8 @@ static int merge_working_tree(struct checkout_opts =
*opts,
 			o.verbosity =3D 0;
 			work =3D write_tree_from_memory(&o);
=20
-			ret =3D reset_tree(new->commit->tree, opts, 1);
+			ret =3D reset_tree(new->commit->tree, opts, 1,
+					 writeout_error);
 			if (ret)
 				return ret;
 			o.ancestor =3D old->name;
@@ -487,7 +491,8 @@ static int merge_working_tree(struct checkout_opts =
*opts,
 			o.branch2 =3D "local";
 			merge_trees(&o, new->commit->tree, work,
 				old->commit->tree, &result);
-			ret =3D reset_tree(new->commit->tree, opts, 0);
+			ret =3D reset_tree(new->commit->tree, opts, 0,
+					 writeout_error);
 			if (ret)
 				return ret;
 		}
@@ -514,7 +519,7 @@ static void report_tracking(struct branch_info *new=
)
 	strbuf_release(&sb);
 }
=20
-static void update_refs_for_switch(struct checkout_opts *opts,
+static void update_refs_for_switch(const struct checkout_opts *opts,
 				   struct branch_info *old,
 				   struct branch_info *new)
 {
@@ -701,13 +706,13 @@ static void orphaned_commit_warning(struct commit=
 *old, struct commit *new)
 	free(refs.objects);
 }
=20
-static int switch_branches(struct checkout_opts *opts, struct branch_i=
nfo *new)
+static int switch_branches(const struct checkout_opts *opts, struct br=
anch_info *new)
 {
 	int ret =3D 0;
 	struct branch_info old;
 	void *path_to_free;
 	unsigned char rev[20];
-	int flag;
+	int flag, writeout_error =3D 0;
 	memset(&old, 0, sizeof(old));
 	old.path =3D path_to_free =3D resolve_refdup("HEAD", rev, 0, &flag);
 	old.commit =3D lookup_commit_reference_gently(rev, 1);
@@ -725,7 +730,7 @@ static int switch_branches(struct checkout_opts *op=
ts, struct branch_info *new)
 		parse_commit(new->commit);
 	}
=20
-	ret =3D merge_working_tree(opts, &old, new);
+	ret =3D merge_working_tree(opts, &old, new, &writeout_error);
 	if (ret) {
 		free(path_to_free);
 		return ret;
@@ -738,7 +743,7 @@ static int switch_branches(struct checkout_opts *op=
ts, struct branch_info *new)
=20
 	ret =3D post_checkout_hook(old.commit, new->commit, 1);
 	free(path_to_free);
-	return ret || opts->writeout_error;
+	return ret || writeout_error;
 }
=20
 static int git_checkout_config(const char *var, const char *value, voi=
d *cb)
@@ -910,7 +915,7 @@ static int parse_branchname_arg(int argc, const cha=
r **argv,
 	return argcount;
 }
=20
-static int switch_unborn_to_new_branch(struct checkout_opts *opts)
+static int switch_unborn_to_new_branch(const struct checkout_opts *opt=
s)
 {
 	int status;
 	struct strbuf branch_ref =3D STRBUF_INIT;
--=20
1.7.12.rc2.18.g61b472e
