Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD24B1F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbdL1EOj (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:14:39 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:46984 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753347AbdL1EOd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:33 -0500
Received: by mail-io0-f196.google.com with SMTP id x129so37156794iod.13
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hRAFPcIbtL764yln1kYmEOfAwMPpEoci3CdMkK8L16o=;
        b=uPXoL6+xyN9qOdRfnudwvotk9OdepNwIO6mYME+6jJ9QYUUIyKcNNnLcP3qZ872lqx
         utwJ9iNgxCe90Y5GgK3Z8r3sISRuNeUS/u5grYLouwK7Qyh+vcsc7TpuDvfsbjzzwSvQ
         /1IofLc1hN0XDJCxdMQ9UIPSLTgeHDLnT/LFvh6SLDEUgMsQOxlcvZsHMMKYFeYVc373
         h8sRX26oXKSQEl2K8xfMbba8GOABtLEqDFxS/+6nE93HUvFPmIY8+CptH2FlAdQpci9R
         jq3xiovD3xLdFcCssz0/3/U0WFXNqlRgE9aIfnvvWW94Xc/yUQV1/SslUY8zS0lCMoyM
         1/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hRAFPcIbtL764yln1kYmEOfAwMPpEoci3CdMkK8L16o=;
        b=sZhY5JInjYNgjkQ/bKh1ZMFH+DO3L3vQ2eQ2JjpDFDr6aRUR1EqScgsoPNSIQl7NNu
         coDNDJnN2/GAKbw9FkH85aXw9XYcPlnzS7XkaE1PgRq2yD+FpR9ms0c9X47/hBNOVEg3
         V8kSQ9TbSpWMOMUsiOUlDFv/bVtD5aHrzwMVu+6TiYGw0cD6n31Vw1XPDR5PFfYcQJ+a
         AWlkVegEFgsM6iLEt/vW851JUDU+lyQlLX4U9dXPE9ciLSjJkDYOKxp9Pm61iRE3zDEn
         +GmkUBPmr6NUQthAi0HZTrFpAZ5ZK+vZ84vnmBD7LfCdXFfrhnOwLy/8wj96+C7SLwRs
         sthg==
X-Gm-Message-State: AKGB3mLLHxgeuj8394fzYyzLmuXOpoa2syyC94HHnPnXdMCxyUNZwpOC
        NLMCTYX+JmmpVgAbaYgsrAqe/A==
X-Google-Smtp-Source: ACJfBotWEIcuDzorag22fH26PDYbwve8OMOBJWwc7vpLGI1ZTpwYuEBov/K+Vbij2+0lAUCpMmU6zA==
X-Received: by 10.107.111.13 with SMTP id k13mr21941094ioc.109.1514434471993;
        Wed, 27 Dec 2017 20:14:31 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:31 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 30/34] merge-recursive: fix overwriting dirty files involved in renames
Date:   Wed, 27 Dec 2017 20:13:48 -0800
Message-Id: <20171228041352.27880-31-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes an issue that existed before my directory rename detection
patches that affects both normal renames and renames implied by
directory rename detection.  Additional codepaths that only affect
overwriting of directy files that are involved in directory rename
detection will be added in a subsequent commit.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 85 ++++++++++++++++++++++++++++---------
 merge-recursive.h                   |  2 +
 t/t3501-revert-cherry-pick.sh       |  2 +-
 t/t6043-merge-rename-directories.sh |  2 +-
 t/t7607-merge-overwrite.sh          |  2 +-
 unpack-trees.c                      |  4 +-
 unpack-trees.h                      |  4 ++
 7 files changed, 77 insertions(+), 24 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index e77d2b043..2b8a5ca03 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -334,32 +334,37 @@ static void init_tree_desc_from_tree(struct tree_desc *desc, struct tree *tree)
 	init_tree_desc(desc, tree->buffer, tree->size);
 }
 
-static int git_merge_trees(int index_only,
+static int git_merge_trees(struct merge_options *o,
 			   struct tree *common,
 			   struct tree *head,
 			   struct tree *merge)
 {
 	int rc;
 	struct tree_desc t[3];
-	struct unpack_trees_options opts;
 
-	memset(&opts, 0, sizeof(opts));
-	if (index_only)
-		opts.index_only = 1;
+	memset(&o->unpack_opts, 0, sizeof(o->unpack_opts));
+	if (o->call_depth)
+		o->unpack_opts.index_only = 1;
 	else
-		opts.update = 1;
-	opts.merge = 1;
-	opts.head_idx = 2;
-	opts.fn = threeway_merge;
-	opts.src_index = &the_index;
-	opts.dst_index = &the_index;
-	setup_unpack_trees_porcelain(&opts, "merge");
+		o->unpack_opts.update = 1;
+	o->unpack_opts.merge = 1;
+	o->unpack_opts.head_idx = 2;
+	o->unpack_opts.fn = threeway_merge;
+	o->unpack_opts.src_index = &the_index;
+	o->unpack_opts.dst_index = &the_index;
+	setup_unpack_trees_porcelain(&o->unpack_opts, "merge");
 
 	init_tree_desc_from_tree(t+0, common);
 	init_tree_desc_from_tree(t+1, head);
 	init_tree_desc_from_tree(t+2, merge);
 
-	rc = unpack_trees(3, t, &opts);
+	rc = unpack_trees(3, t, &o->unpack_opts);
+	/*
+	 * unpack_trees NULLifies src_index, but it's used in verify_uptodate,
+	 * so set to the new index which will usually have modification
+	 * timestamp info copied over.
+	 */
+	o->unpack_opts.src_index = &the_index;
 	cache_tree_free(&active_cache_tree);
 	return rc;
 }
@@ -792,6 +797,20 @@ static int would_lose_untracked(const char *path)
 	return !was_tracked(path) && file_exists(path);
 }
 
+static int was_dirty(struct merge_options *o, const char *path)
+{
+	struct cache_entry *ce;
+	int dirty = 1;
+
+	if (o->call_depth || !was_tracked(path))
+		return !dirty;
+
+	ce = cache_file_exists(path, strlen(path), ignore_case);
+	dirty = (ce->ce_stat_data.sd_mtime.sec > 0 &&
+		 verify_uptodate(ce, &o->unpack_opts) != 0);
+	return dirty;
+}
+
 static int make_room_for_path(struct merge_options *o, const char *path)
 {
 	int status, i;
@@ -2645,6 +2664,7 @@ static int handle_modify_delete(struct merge_options *o,
 
 static int merge_content(struct merge_options *o,
 			 const char *path,
+			 int file_in_way,
 			 struct object_id *o_oid, int o_mode,
 			 struct object_id *a_oid, int a_mode,
 			 struct object_id *b_oid, int b_mode,
@@ -2719,7 +2739,7 @@ static int merge_content(struct merge_options *o,
 				return -1;
 	}
 
-	if (df_conflict_remains) {
+	if (df_conflict_remains || file_in_way) {
 		char *new_path;
 		if (o->call_depth) {
 			remove_file_from_cache(path);
@@ -2753,6 +2773,30 @@ static int merge_content(struct merge_options *o,
 	return mfi.clean;
 }
 
+static int conflict_rename_normal(struct merge_options *o,
+				  const char *path,
+				  struct object_id *o_oid, unsigned int o_mode,
+				  struct object_id *a_oid, unsigned int a_mode,
+				  struct object_id *b_oid, unsigned int b_mode,
+				  struct rename_conflict_info *ci)
+{
+	int clean_merge;
+	int file_in_the_way = 0;
+
+	if (was_dirty(o, path)) {
+		file_in_the_way = 1;
+		output(o, 1, _("Refusing to lose dirty file at %s"), path);
+	}
+
+	/* Merge the content and write it out */
+	clean_merge = merge_content(o, path, file_in_the_way,
+				    o_oid, o_mode, a_oid, a_mode, b_oid, b_mode,
+				    ci);
+	if (clean_merge > 0 && file_in_the_way)
+		clean_merge = 0;
+	return clean_merge;
+}
+
 /* Per entry merge function */
 static int process_entry(struct merge_options *o,
 			 const char *path, struct stage_data *entry)
@@ -2772,9 +2816,12 @@ static int process_entry(struct merge_options *o,
 		switch (conflict_info->rename_type) {
 		case RENAME_NORMAL:
 		case RENAME_ONE_FILE_TO_ONE:
-			clean_merge = merge_content(o, path,
-						    o_oid, o_mode, a_oid, a_mode, b_oid, b_mode,
-						    conflict_info);
+			clean_merge = conflict_rename_normal(o,
+							     path,
+							     o_oid, o_mode,
+							     a_oid, a_mode,
+							     b_oid, b_mode,
+							     conflict_info);
 			break;
 		case RENAME_DIR:
 			clean_merge = 1;
@@ -2870,7 +2917,7 @@ static int process_entry(struct merge_options *o,
 	} else if (a_oid && b_oid) {
 		/* Case C: Added in both (check for same permissions) and */
 		/* case D: Modified in both, but differently. */
-		clean_merge = merge_content(o, path,
+		clean_merge = merge_content(o, path, 0 /* file_in_way */,
 					    o_oid, o_mode, a_oid, a_mode, b_oid, b_mode,
 					    NULL);
 	} else if (!o_oid && !a_oid && !b_oid) {
@@ -2904,7 +2951,7 @@ int merge_trees(struct merge_options *o,
 		return 1;
 	}
 
-	code = git_merge_trees(o->call_depth, common, head, merge);
+	code = git_merge_trees(o, common, head, merge);
 
 	if (code != 0) {
 		if (show(o, 4) || o->call_depth)
diff --git a/merge-recursive.h b/merge-recursive.h
index e1be27f57..a557201a5 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -1,6 +1,7 @@
 #ifndef MERGE_RECURSIVE_H
 #define MERGE_RECURSIVE_H
 
+#include "unpack-trees.h"
 #include "string-list.h"
 
 struct merge_options {
@@ -27,6 +28,7 @@ struct merge_options {
 	struct strbuf obuf;
 	struct hashmap current_file_dir_set;
 	struct string_list df_conflict_file_set;
+	struct unpack_trees_options unpack_opts;
 };
 
 struct dir_rename_entry {
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 783bdbf59..0d89f6d0f 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -141,7 +141,7 @@ test_expect_success 'cherry-pick "-" works with arguments' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'cherry-pick works with dirty renamed file' '
+test_expect_success 'cherry-pick works with dirty renamed file' '
 	test_commit to-rename &&
 	git checkout -b unrelated &&
 	test_commit unrelated &&
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index dd9b94266..86c215e13 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -3157,7 +3157,7 @@ test_expect_success '11a-setup: Avoid losing dirty contents with simple rename'
 	)
 '
 
-test_expect_failure '11a-check: Avoid losing dirty contents with simple rename' '
+test_expect_success '11a-check: Avoid losing dirty contents with simple rename' '
 	(
 		cd 11a &&
 
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index 00617dadf..e44fb5017 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -92,7 +92,7 @@ test_expect_success 'will not overwrite removed file with staged changes' '
 	test_cmp important c1.c
 '
 
-test_expect_failure 'will not overwrite unstaged changes in renamed file' '
+test_expect_success 'will not overwrite unstaged changes in renamed file' '
 	git reset --hard c1 &&
 	git mv c1.c other.c &&
 	git commit -m rename &&
diff --git a/unpack-trees.c b/unpack-trees.c
index bf8b60290..5b922c193 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1486,8 +1486,8 @@ static int verify_uptodate_1(const struct cache_entry *ce,
 		add_rejected_path(o, error_type, ce->name);
 }
 
-static int verify_uptodate(const struct cache_entry *ce,
-			   struct unpack_trees_options *o)
+int verify_uptodate(const struct cache_entry *ce,
+		    struct unpack_trees_options *o)
 {
 	if (!o->skip_sparse_checkout && (ce->ce_flags & CE_NEW_SKIP_WORKTREE))
 		return 0;
diff --git a/unpack-trees.h b/unpack-trees.h
index 6c48117b8..41178ada9 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -1,6 +1,7 @@
 #ifndef UNPACK_TREES_H
 #define UNPACK_TREES_H
 
+#include "tree-walk.h"
 #include "string-list.h"
 
 #define MAX_UNPACK_TREES 8
@@ -78,6 +79,9 @@ struct unpack_trees_options {
 extern int unpack_trees(unsigned n, struct tree_desc *t,
 		struct unpack_trees_options *options);
 
+int verify_uptodate(const struct cache_entry *ce,
+		    struct unpack_trees_options *o);
+
 int threeway_merge(const struct cache_entry * const *stages,
 		   struct unpack_trees_options *o);
 int twoway_merge(const struct cache_entry * const *src,
-- 
2.15.0.408.g8e199d483

