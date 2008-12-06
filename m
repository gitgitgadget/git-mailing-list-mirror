From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/6] builtin-checkout.c: refactor merge_working_tree()
Date: Fri,  5 Dec 2008 17:54:13 -0800
Message-ID: <1228528455-3089-5-git-send-email-gitster@pobox.com>
References: <1228528455-3089-1-git-send-email-gitster@pobox.com>
 <1228528455-3089-2-git-send-email-gitster@pobox.com>
 <1228528455-3089-3-git-send-email-gitster@pobox.com>
 <1228528455-3089-4-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 02:56:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8mP4-0005m7-EM
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 02:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567AbYLFByi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 20:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756036AbYLFByg
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 20:54:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61875 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755567AbYLFBya (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 20:54:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1A8471830E
	for <git@vger.kernel.org>; Fri,  5 Dec 2008 20:54:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E2FA4182CB for
 <git@vger.kernel.org>; Fri,  5 Dec 2008 20:54:28 -0500 (EST)
X-Mailer: git-send-email 1.6.1.rc1.72.ga5ce6
In-Reply-To: <1228528455-3089-4-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D212014E-C338-11DD-9401-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102437>

The logic to bring the index and the working tree from one commit to
another is a nontrivial amount of code in this function.  Separate it out
into its own function, so that other callers can call it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c |  172 +++++++++++++++++++++++++++-------------------------
 1 files changed, 89 insertions(+), 83 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index d88fce2..9c45c49 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -352,6 +352,87 @@ static int reset_tree(struct tree *tree, int quiet, int worktree, int *wt_error)
 	}
 }
 
+static int switch_trees(int merge, int quiet, int *wt_error,
+			struct commit *old_commit, const char *old_label,
+			struct commit *new_commit, const char *new_label)
+{
+	int ret;
+	struct tree_desc trees[2];
+	struct tree *tree;
+	struct unpack_trees_options topts;
+
+	memset(&topts, 0, sizeof(topts));
+	topts.head_idx = -1;
+	topts.src_index = &the_index;
+	topts.dst_index = &the_index;
+
+	topts.msgs.not_uptodate_file = "You have local changes to '%s'; cannot switch branches.";
+
+	refresh_cache(REFRESH_QUIET);
+
+	if (unmerged_cache()) {
+		error("you need to resolve your current index first");
+		return 1;
+	}
+
+	/* 2-way merge to the new branch */
+	topts.initial_checkout = is_cache_unborn();
+	topts.update = 1;
+	topts.merge = 1;
+	topts.gently = merge;
+	topts.verbose_update = !quiet;
+	topts.fn = twoway_merge;
+	topts.dir = xcalloc(1, sizeof(*topts.dir));
+	topts.dir->show_ignored = 1;
+	topts.dir->exclude_per_dir = ".gitignore";
+	tree = parse_tree_indirect(old_commit->object.sha1);
+	init_tree_desc(&trees[0], tree->buffer, tree->size);
+	tree = parse_tree_indirect(new_commit->object.sha1);
+	init_tree_desc(&trees[1], tree->buffer, tree->size);
+
+	ret = unpack_trees(2, trees, &topts);
+	if (ret == -1) {
+		/*
+		 * Unpack couldn't do a trivial merge; either give up
+		 * or do a real merge, depending on whether the merge
+		 * flag was used.
+		 */
+		struct tree *result;
+		struct tree *work;
+		struct merge_options o;
+		if (!merge)
+			return 1;
+		parse_commit(old_commit);
+
+		/* Do more real merge */
+
+		/*
+		 * We update the index fully, then write the tree from
+		 * the index, then merge the new branch with the
+		 * current tree, with the old branch as the base. Then
+		 * we reset the index (but not the working tree) to
+		 * the new branch, leaving the working tree as the
+		 * merged version, but skipping unmerged entries in
+		 * the index.
+		 */
+
+		add_files_to_cache(NULL, NULL, 0);
+		init_merge_options(&o);
+		o.verbosity = 0;
+		work = write_tree_from_memory(&o);
+
+		ret = reset_tree(new_commit->tree, quiet, 1, wt_error);
+		if (ret)
+			return ret;
+		o.branch1 = new_label;
+		o.branch2 = old_label;
+		merge_trees(&o, new_commit->tree, work,
+			    old_commit->tree, &result);
+		ret = reset_tree(new_commit->tree, quiet, 0, wt_error);
+	}
+	return ret;
+}
+
 struct branch_info {
 	const char *name; /* The short name used */
 	const char *path; /* The full name of a real branch */
@@ -376,91 +457,16 @@ static int merge_working_tree(struct checkout_opts *opts,
 	if (read_cache() < 0)
 		return error("corrupt index file");
 
-	if (opts->force) {
+	if (opts->force)
 		ret = reset_tree(new->commit->tree, opts->quiet, 1,
 				 &opts->writeout_error);
-		if (ret)
-			return ret;
-	} else {
-		struct tree_desc trees[2];
-		struct tree *tree;
-		struct unpack_trees_options topts;
-
-		memset(&topts, 0, sizeof(topts));
-		topts.head_idx = -1;
-		topts.src_index = &the_index;
-		topts.dst_index = &the_index;
-
-		topts.msgs.not_uptodate_file = "You have local changes to '%s'; cannot switch branches.";
-
-		refresh_cache(REFRESH_QUIET);
-
-		if (unmerged_cache()) {
-			error("you need to resolve your current index first");
-			return 1;
-		}
-
-		/* 2-way merge to the new branch */
-		topts.initial_checkout = is_cache_unborn();
-		topts.update = 1;
-		topts.merge = 1;
-		topts.gently = opts->merge;
-		topts.verbose_update = !opts->quiet;
-		topts.fn = twoway_merge;
-		topts.dir = xcalloc(1, sizeof(*topts.dir));
-		topts.dir->show_ignored = 1;
-		topts.dir->exclude_per_dir = ".gitignore";
-		tree = parse_tree_indirect(old->commit->object.sha1);
-		init_tree_desc(&trees[0], tree->buffer, tree->size);
-		tree = parse_tree_indirect(new->commit->object.sha1);
-		init_tree_desc(&trees[1], tree->buffer, tree->size);
-
-		ret = unpack_trees(2, trees, &topts);
-		if (ret == -1) {
-			/*
-			 * Unpack couldn't do a trivial merge; either
-			 * give up or do a real merge, depending on
-			 * whether the merge flag was used.
-			 */
-			struct tree *result;
-			struct tree *work;
-			struct merge_options o;
-			if (!opts->merge)
-				return 1;
-			parse_commit(old->commit);
-
-			/* Do more real merge */
-
-			/*
-			 * We update the index fully, then write the
-			 * tree from the index, then merge the new
-			 * branch with the current tree, with the old
-			 * branch as the base. Then we reset the index
-			 * (but not the working tree) to the new
-			 * branch, leaving the working tree as the
-			 * merged version, but skipping unmerged
-			 * entries in the index.
-			 */
-
-			add_files_to_cache(NULL, NULL, 0);
-			init_merge_options(&o);
-			o.verbosity = 0;
-			work = write_tree_from_memory(&o);
-
-			ret = reset_tree(new->commit->tree, opts->quiet, 1,
-					 &opts->writeout_error);
-			if (ret)
-				return ret;
-			o.branch1 = new->name;
-			o.branch2 = "local";
-			merge_trees(&o, new->commit->tree, work,
-				old->commit->tree, &result);
-			ret = reset_tree(new->commit->tree, opts->quiet, 0,
-					 &opts->writeout_error);
-			if (ret)
-				return ret;
-		}
-	}
+	else
+		ret = switch_trees(opts->merge, opts->quiet,
+				   &opts->writeout_error,
+				   old->commit, "local",
+				   new->commit, new->name);
+	if (ret)
+		return ret;
 
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    commit_locked_index(lock_file))
-- 
1.6.1.rc1.72.ga5ce6
