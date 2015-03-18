From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 2/8] Move reset_tree from builtin/checkout.c to unpack-trees.c
Date: Wed, 18 Mar 2015 16:55:41 +0700
Message-ID: <1426672547-11369-3-git-send-email-pclouds@gmail.com>
References: <1426672547-11369-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 10:56:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYAiA-0002e3-2C
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 10:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755760AbbCRJ4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 05:56:21 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34182 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933182AbbCRJ4R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 05:56:17 -0400
Received: by pdbni2 with SMTP id ni2so38490738pdb.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 02:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rl6NiCt+pV/z7/fUD5YxBFbz1a71ny/p5Ym5yq08HxU=;
        b=M6GTeOF+uelVjljax/JsizUYzsyCg4NjGZvdtRIsnMnMEtPG2gqnhZQ5A0F/b2/VQ/
         nNUFq6UdUY9UIGyWU6w/KUQBMVueOp7unCde4WAYxN6HFRP3PNxr7TSefOl4eWdQ7D+E
         wwHfkqlbXpQtfhQX8tr55ViQXmfOcBfm+PrAK6qOedgMu0SbrZfbkRw8ScMuwnCFJKkn
         yD0Zp8LYLQS4oaMKirqvnORzeuOw6ttTwN0tyZrVhWRoVA6Xo4XZhXz6UAFzBoSuoxbY
         Bcgueh/V08/CwKyeNbcMWNGQZ6UcwbFqxWP+NgywneZct7dJ9UnGjqqCWoVbRmEgMrLY
         Aq4g==
X-Received: by 10.66.55.74 with SMTP id q10mr161076808pap.94.1426672576969;
        Wed, 18 Mar 2015 02:56:16 -0700 (PDT)
Received: from lanh ([115.73.252.85])
        by mx.google.com with ESMTPSA id dr5sm26627139pdb.48.2015.03.18.02.56.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2015 02:56:16 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Mar 2015 16:56:13 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1426672547-11369-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265704>

---
 builtin/checkout.c | 40 +++-------------------------------------
 builtin/merge.c    | 29 +++++++----------------------
 unpack-trees.c     | 33 +++++++++++++++++++++++++++++++++
 unpack-trees.h     |  4 ++++
 4 files changed, 47 insertions(+), 59 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a9c1b5a..93b18ad 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -362,40 +362,6 @@ static void describe_detached_head(const char *msg, struct commit *commit)
 	strbuf_release(&sb);
 }
 
-static int reset_tree(struct tree *tree, const struct checkout_opts *o,
-		      int worktree, int *writeout_error)
-{
-	struct unpack_trees_options opts;
-	struct tree_desc tree_desc;
-
-	memset(&opts, 0, sizeof(opts));
-	opts.head_idx = -1;
-	opts.update = worktree;
-	opts.skip_unmerged = !worktree;
-	opts.reset = 1;
-	opts.merge = 1;
-	opts.fn = oneway_merge;
-	opts.verbose_update = !o->quiet && isatty(2);
-	opts.src_index = &the_index;
-	opts.dst_index = &the_index;
-	parse_tree(tree);
-	init_tree_desc(&tree_desc, tree->buffer, tree->size);
-	switch (unpack_trees(1, &tree_desc, &opts)) {
-	case -2:
-		*writeout_error = 1;
-		/*
-		 * We return 0 nevertheless, as the index is all right
-		 * and more importantly we have made best efforts to
-		 * update paths in the work tree, and we cannot revert
-		 * them.
-		 */
-	case 0:
-		return 0;
-	default:
-		return 128;
-	}
-}
-
 struct branch_info {
 	const char *name; /* The short name used */
 	const char *path; /* The full name of a real branch */
@@ -427,7 +393,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 
 	resolve_undo_clear();
 	if (opts->force) {
-		ret = reset_tree(new->commit->tree, opts, 1, writeout_error);
+		ret = reset_tree(new->commit->tree, opts->quiet, 1, writeout_error);
 		if (ret)
 			return ret;
 	} else {
@@ -513,7 +479,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			o.verbosity = 0;
 			work = write_tree_from_memory(&o);
 
-			ret = reset_tree(new->commit->tree, opts, 1,
+			ret = reset_tree(new->commit->tree, opts->quiet, 1,
 					 writeout_error);
 			if (ret)
 				return ret;
@@ -522,7 +488,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			o.branch2 = "local";
 			merge_trees(&o, new->commit->tree, work,
 				old->commit->tree, &result);
-			ret = reset_tree(new->commit->tree, opts, 0,
+			ret = reset_tree(new->commit->tree, opts->quiet, 0,
 					 writeout_error);
 			if (ret)
 				return ret;
diff --git a/builtin/merge.c b/builtin/merge.c
index 6babf39..c51e4f5 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -269,33 +269,18 @@ static void read_empty(unsigned const char *sha1, int verbose)
 		die(_("read-tree failed"));
 }
 
-static void reset_hard(unsigned const char *sha1, int verbose)
-{
-	int i = 0;
-	const char *args[6];
-
-	args[i++] = "read-tree";
-	if (verbose)
-		args[i++] = "-v";
-	args[i++] = "--reset";
-	args[i++] = "-u";
-	args[i++] = sha1_to_hex(sha1);
-	args[i] = NULL;
-
-	if (run_command_v_opt(args, RUN_GIT_CMD))
-		die(_("read-tree failed"));
-}
-
-static void restore_state(const unsigned char *head,
+static void restore_state(struct commit *head_commit,
 			  const unsigned char *stash)
 {
 	struct strbuf sb = STRBUF_INIT;
 	const char *args[] = { "stash", "apply", NULL, NULL };
+	int error = 0;
 
 	if (is_null_sha1(stash))
 		return;
 
-	reset_hard(head, 1);
+	if (reset_tree(head_commit->tree, 0, 1, &error) || error)
+		die(_("read-tree failed"));
 
 	args[2] = sha1_to_hex(stash);
 
@@ -1409,7 +1394,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		int ret;
 		if (i) {
 			printf(_("Rewinding the tree to pristine...\n"));
-			restore_state(head_commit->object.sha1, stash);
+			restore_state(head_commit, stash);
 		}
 		if (use_strategies_nr != 1)
 			printf(_("Trying merge strategy %s...\n"),
@@ -1475,7 +1460,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * it up.
 	 */
 	if (!best_strategy) {
-		restore_state(head_commit->object.sha1, stash);
+		restore_state(head_commit, stash);
 		if (use_strategies_nr > 1)
 			fprintf(stderr,
 				_("No merge strategy handled the merge.\n"));
@@ -1488,7 +1473,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		; /* We already have its result in the working tree. */
 	else {
 		printf(_("Rewinding the tree to pristine...\n"));
-		restore_state(head_commit->object.sha1, stash);
+		restore_state(head_commit, stash);
 		printf(_("Using the %s to prepare resolving by hand.\n"),
 			best_strategy);
 		try_merge_strategy(best_strategy, common, remoteheads,
diff --git a/unpack-trees.c b/unpack-trees.c
index 0e1a196..3c24a4d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1847,3 +1847,36 @@ int oneway_merge(struct cache_entry **src, struct unpack_trees_options *o)
 	}
 	return merged_entry(a, old, o);
 }
+
+int reset_tree(struct tree *tree, int quiet, int worktree, int *writeout_error)
+{
+	struct unpack_trees_options opts;
+	struct tree_desc tree_desc;
+
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = -1;
+	opts.update = worktree;
+	opts.skip_unmerged = !worktree;
+	opts.reset = 1;
+	opts.merge = 1;
+	opts.fn = oneway_merge;
+	opts.verbose_update = !quiet && isatty(2);
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
+	parse_tree(tree);
+	init_tree_desc(&tree_desc, tree->buffer, tree->size);
+	switch (unpack_trees(1, &tree_desc, &opts)) {
+	case -2:
+		*writeout_error = 1;
+		/*
+		 * We return 0 nevertheless, as the index is all right
+		 * and more importantly we have made best efforts to
+		 * update paths in the work tree, and we cannot revert
+		 * them.
+		 */
+	case 0:
+		return 0;
+	default:
+		return 128;
+	}
+}
diff --git a/unpack-trees.h b/unpack-trees.h
index ec74a9f..f0850bb 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -83,4 +83,8 @@ int twoway_merge(struct cache_entry **src, struct unpack_trees_options *o);
 int bind_merge(struct cache_entry **src, struct unpack_trees_options *o);
 int oneway_merge(struct cache_entry **src, struct unpack_trees_options *o);
 
+
+struct tree;
+extern int reset_tree(struct tree *tree, int quiet,
+		      int worktree, int *writeout_error);
 #endif
-- 
2.3.0.rc1.137.g477eb31
