Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFFB31F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 19:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753938AbdKJTGZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 14:06:25 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:51768 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753782AbdKJTGD (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 14:06:03 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAJ2v3C017414;
        Fri, 10 Nov 2017 11:06:01 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e535n1cdk-1;
        Fri, 10 Nov 2017 11:06:01 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 7637D22F6290;
        Fri, 10 Nov 2017 11:06:01 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 6ABFD2CDE6A;
        Fri, 10 Nov 2017 11:06:01 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 29/30] merge-recursive: Fix overwriting dirty files involved in renames
Date:   Fri, 10 Nov 2017 11:05:49 -0800
Message-Id: <20171110190550.27059-30-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.5.g9567be9905
In-Reply-To: <20171110190550.27059-1-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711100261
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
Seems kinda hacky, in multiple different ways.  It seems like there
should be a better way to handle lots of different things about this
patch, though I have a hard time seeing how without doing a bigger
rewrite of the whole interface between unpack_trees and
merge-recursive (possibly rewriting them so there isn't an interface
but some piece of code that does both functions).  Alternate simpler
suggestions?


 merge-recursive.c                   | 81 ++++++++++++++++++++++++++++---------
 merge-recursive.h                   |  2 +
 t/t3501-revert-cherry-pick.sh       |  2 +-
 t/t6043-merge-rename-directories.sh |  2 +-
 t/t7607-merge-overwrite.sh          |  2 +-
 unpack-trees.c                      |  4 +-
 unpack-trees.h                      |  4 ++
 7 files changed, 73 insertions(+), 24 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1b3ee5b9fb..86ddb89727 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -323,32 +323,32 @@ static void init_tree_desc_from_tree(struct tree_desc *desc, struct tree *tree)
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
+	o->unpack_opts.src_index = &the_index; // unpack_trees NULLifies src_index, but it's used in verify_uptodate, so set it back
 	cache_tree_free(&active_cache_tree);
 	return rc;
 }
@@ -783,6 +783,20 @@ static int would_lose_untracked(const char *path)
 	return !was_tracked(path) && file_exists(path);
 }
 
+static int was_dirty(struct merge_options *o, const char *path)
+{
+	struct cache_entry *ce;
+
+	int dirty = 1;
+	if (o->call_depth || !was_tracked(path))
+	  return !dirty;
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
@@ -2635,6 +2649,7 @@ static int handle_modify_delete(struct merge_options *o,
 
 static int merge_content(struct merge_options *o,
 			 const char *path,
+			 int file_in_way,
 			 struct object_id *o_oid, int o_mode,
 			 struct object_id *a_oid, int a_mode,
 			 struct object_id *b_oid, int b_mode,
@@ -2709,7 +2724,7 @@ static int merge_content(struct merge_options *o,
 				return -1;
 	}
 
-	if (df_conflict_remains) {
+	if (df_conflict_remains || file_in_way) {
 		char *new_path;
 		if (o->call_depth) {
 			remove_file_from_cache(path);
@@ -2743,6 +2758,31 @@ static int merge_content(struct merge_options *o,
 	return mfi.clean;
 }
 
+static int conflict_rename_normal(struct merge_options *o,
+				  const char *path,
+				  struct object_id *o_oid, unsigned o_mode,
+				  struct object_id *a_oid, unsigned a_mode,
+				  struct object_id *b_oid, unsigned b_mode,
+				  struct rename_conflict_info *ci)
+{
+	int clean_merge;
+	int file_in_the_way = 0;
+
+	if (was_dirty(o, path)) {
+			file_in_the_way = 1;
+			output(o, 1, _("Refusing to lose dirty file at %s"),
+			       path);
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
@@ -2762,9 +2802,12 @@ static int process_entry(struct merge_options *o,
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
@@ -2859,7 +2902,7 @@ static int process_entry(struct merge_options *o,
 	} else if (a_oid && b_oid) {
 		/* Case C: Added in both (check for same permissions) and */
 		/* case D: Modified in both, but differently. */
-		clean_merge = merge_content(o, path,
+		clean_merge = merge_content(o, path, 0 /* file_in_way */,
 					    o_oid, o_mode, a_oid, a_mode, b_oid, b_mode,
 					    NULL);
 	} else if (!o_oid && !a_oid && !b_oid) {
@@ -2893,7 +2936,7 @@ int merge_trees(struct merge_options *o,
 		return 1;
 	}
 
-	code = git_merge_trees(o->call_depth, common, head, merge);
+	code = git_merge_trees(o, common, head, merge);
 
 	if (code != 0) {
 		if (show(o, 4) || o->call_depth)
diff --git a/merge-recursive.h b/merge-recursive.h
index e02c1e1243..591b824a98 100644
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
index 783bdbf59d..0d89f6d0f6 100755
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
index 6db764a1b6..02c97c9823 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -2925,7 +2925,7 @@ test_expect_success '11a-setup: Avoid losing dirty contents with simple rename'
 	git commit -m "C"
 '
 
-test_expect_failure '11a-check: Avoid losing dirty contents with simple rename' '
+test_expect_success '11a-check: Avoid losing dirty contents with simple rename' '
 	git checkout B^0 &&
 	echo stuff >>z/c &&
 
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index 00617dadf8..e44fb50173 100755
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
index 71b70ccb12..71826edfb6 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1484,8 +1484,8 @@ static int verify_uptodate_1(const struct cache_entry *ce,
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
index 6c48117b84..41178ada94 100644
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
2.15.0.5.g9567be9905

