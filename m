Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA89C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 18:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5257A613AE
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 18:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbhFASc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 14:32:57 -0400
Received: from botech.co.uk ([81.187.226.106]:46308 "EHLO chimp.botech.co.uk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233397AbhFASc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 14:32:56 -0400
Received: from botech.co.uk ([81.187.226.106] helo=rhino.botech.co.uk)
        by chimp.botech.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <tpr.ll@botech.co.uk>)
        id 1lo9AT-0007pE-O8; Tue, 01 Jun 2021 19:31:09 +0100
From:   Tim Renouf <tpr.ll@botech.co.uk>
To:     newren@gmail.com, dstolee@microsoft.com, git@vger.kernel.org
Cc:     Tim Renouf <tpr.ll@botech.co.uk>
Subject: [PATCH] unpack-trees: add core.sparseCheckoutRmFiles config
Date:   Tue,  1 Jun 2021 19:31:06 +0100
Message-Id: <20210601183106.3084008-1-tpr.ll@botech.co.uk>
X-Mailer: git-send-email 2.32.0.rc2.3.g151f456769
In-Reply-To: <CABPp-BGUxHiYLjVcqBc0qpaHpd5MZCN_6S0YpH8tKcP3GSV2Pw@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When doing a checkout (or other index merge from a tree) causes the
removal of a path that is outside sparse-checkout, the file is removed
from the working tree, even if it is dirty.

That is probably what you want if the file got there by being
materialized in a merge conflict. But it is not what you want if you
deliberately put the file there.

This commit adds the above config item, defaulting to "true" to get the
old behavior. Set it to "false" to avoid removing such a file from the
worktree.

Signed-off-by: Tim Renouf <tpr.ll@botech.co.uk>
---
Here is a fix for my problem, hidden under a config option as it might
not be what everyone wants (there are a few tests that rely on the
existing behavior). I realize this is a bit of a piecemeal approach.
Hopefully it will be superseded by the sparse-index work when that
arrives.

 Documentation/git-sparse-checkout.txt | 11 ++++++++
 cache.h                               |  1 +
 config.c                              |  5 ++++
 environment.c                         |  1 +
 t/t1011-read-tree-sparse-checkout.sh  | 36 +++++++++++++++++++++++++++
 unpack-trees.c                        | 14 ++++++++---
 6 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index a0eeaeb02e..31adb38b1d 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -111,6 +111,17 @@ the sparse-checkout file.
 To repopulate the working directory with all files, use the
 `git sparse-checkout disable` command.
 
+The `core.sparseCheckoutRmFiles` config setting determines what to do when a
+checkout (or other index merge from a tree) causes the removal of a path that
+is outside the sparse-checkout patterns but the file exists in the worktree
+anyway. The default is `true`, which causes such a file to be removed from the
+worktree, which is probably what you want to remove outside-sparse-checkout
+files that were materialized by a merge conflict. Setting it to `false` means
+that such a file is not removed, which is probably what you want if you
+deliberately have files in the outside-sparse-checkout part of a worktree.
+
+The behavior with regard to worktree files that are outside sparse-checkout
+patterns is likely to change in the future.
 
 FULL PATTERN SET
 ----------------
diff --git a/cache.h b/cache.h
index 6fda8091f1..19ee1cfc02 100644
--- a/cache.h
+++ b/cache.h
@@ -964,6 +964,7 @@ extern const char *core_fsmonitor;
 
 extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
+extern int core_sparse_checkout_rm_files;
 
 /*
  * Include broken refs in all ref iterations, which will
diff --git a/config.c b/config.c
index 6428393a41..dd24e753a8 100644
--- a/config.c
+++ b/config.c
@@ -1552,6 +1552,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.sparsecheckoutrmfiles")) {
+		core_sparse_checkout_rm_files = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.precomposeunicode")) {
 		precomposed_unicode = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 2f27008424..cff6bbbe62 100644
--- a/environment.c
+++ b/environment.c
@@ -70,6 +70,7 @@ char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
 int core_sparse_checkout_cone;
+int core_sparse_checkout_rm_files = 1;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 24092c09a9..67690b31c3 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -280,4 +280,40 @@ test_expect_success 'checkout with --ignore-skip-worktree-bits' '
 	git diff --exit-code HEAD
 '
 
+test_expect_success 'core.sparseCheckoutRmFiles checkout that would remove file outside sparse-checkout removes file from disk' '
+	git config core.sparseCheckout false &&
+	git checkout -f top &&
+	echo added3 >added3 &&
+	git add added3 &&
+	git commit -madded3 &&
+	git checkout top &&
+	test_path_is_missing added3 &&
+	git config core.sparseCheckout true &&
+	git config core.sparseCheckoutRmFiles true &&
+	echo init.t >.git/info/sparse-checkout &&
+	git checkout HEAD@{1} &&
+	test_path_is_missing added3 &&
+	echo dirty >added3 &&
+	git checkout top &&
+	test_path_is_missing added3
+'
+
+test_expect_success '!core.sparseCheckoutRmFiles checkout that would remove file outside sparse-checkout does not remove file from disk' '
+	git config core.sparseCheckout false &&
+	git checkout -f top &&
+	echo added4 >added4 &&
+	git add added4 &&
+	git commit -madded4 &&
+	git checkout top &&
+	test_path_is_missing added4 &&
+	git config core.sparseCheckout true &&
+	git config core.sparseCheckoutRmFiles false &&
+	echo init.t >.git/info/sparse-checkout &&
+	git checkout HEAD@{1} &&
+	test_path_is_missing added4 &&
+	echo dirty >added4 &&
+	git checkout top &&
+	test_path_is_file added4
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 9298fe1d9b..cdc3915974 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1528,7 +1528,9 @@ static void mark_new_skip_worktree(struct pattern_list *pl,
 
 	/*
 	 * 1. Pretend the narrowest worktree: only unmerged entries
-	 * are checked out
+	 * are checked out. If core.sparseCheckoutRmFiles is off, then
+	 * treat a file being removed as merged, so it does not get
+	 * removed from the worktree.
 	 */
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
@@ -1536,7 +1538,8 @@ static void mark_new_skip_worktree(struct pattern_list *pl,
 		if (select_flag && !(ce->ce_flags & select_flag))
 			continue;
 
-		if (!ce_stage(ce) && !(ce->ce_flags & CE_CONFLICTED))
+		if ((!ce_stage(ce) && !(ce->ce_flags & CE_CONFLICTED)) ||
+		    ((ce->ce_flags & CE_REMOVE) && !core_sparse_checkout_rm_files))
 			ce->ce_flags |= skip_wt_flag;
 		else
 			ce->ce_flags &= ~skip_wt_flag;
@@ -1681,12 +1684,15 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	if (!o->skip_sparse_checkout) {
 		/*
-		 * Sparse checkout loop #2: set NEW_SKIP_WORKTREE on entries not in loop #1
+		 * Sparse checkout loop #2: set NEW_SKIP_WORKTREE on entries not in loop #1.
+		 * If !core.sparseCheckoutRmFiles, include files being removed so ones
+		 * outside sparse-checkout patterns do not get removed from the worktree.
 		 * If they will have NEW_SKIP_WORKTREE, also set CE_SKIP_WORKTREE
 		 * so apply_sparse_checkout() won't attempt to remove it from worktree
 		 */
+		int mask = core_sparse_checkout_rm_files ? CE_ADDED : CE_ADDED | CE_REMOVE;
 		mark_new_skip_worktree(o->pl, &o->result,
-				       CE_ADDED, CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE,
+				       mask, CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE,
 				       o->verbose_update);
 
 		ret = 0;
-- 
2.32.0.rc2.3.g151f456769

