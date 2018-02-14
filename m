Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B3A21F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162417AbeBNSyH (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:54:07 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38968 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1162346AbeBNSwh (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Feb 2018 13:52:37 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1EInBTG002752;
        Wed, 14 Feb 2018 10:52:08 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2g1yfs779y-1;
        Wed, 14 Feb 2018 10:52:08 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id D55D2225EDEF;
        Wed, 14 Feb 2018 10:52:07 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id CA3B72CDE88;
        Wed, 14 Feb 2018 10:52:07 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v8 25/29] merge-recursive: fix overwriting dirty files involved in renames
Date:   Wed, 14 Feb 2018 10:52:02 -0800
Message-Id: <20180214185206.15492-26-newren@gmail.com>
X-Mailer: git-send-email 2.16.1.232.g28d5be9217
In-Reply-To: <20180214185206.15492-1-newren@gmail.com>
References: <20180214185206.15492-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1802140219
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes an issue that existed before my directory rename detection
patches that affects both normal renames and renames implied by
directory rename detection.  Additional codepaths that only affect
overwriting of dirty files that are involved in directory rename
detection will be added in a subsequent commit.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 85 ++++++++++++++++++++++++++++---=
------
 merge-recursive.h                   |  2 +
 t/t3501-revert-cherry-pick.sh       |  2 +-
 t/t6043-merge-rename-directories.sh |  2 +-
 t/t7607-merge-overwrite.sh          |  2 +-
 unpack-trees.c                      |  4 +-
 unpack-trees.h                      |  4 ++
 7 files changed, 77 insertions(+), 24 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index cd91eef805..4532b982a4 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -337,32 +337,37 @@ static void init_tree_desc_from_tree(struct tree_de=
sc *desc, struct tree *tree)
 	init_tree_desc(desc, tree->buffer, tree->size);
 }
=20
-static int git_merge_trees(int index_only,
+static int git_merge_trees(struct merge_options *o,
 			   struct tree *common,
 			   struct tree *head,
 			   struct tree *merge)
 {
 	int rc;
 	struct tree_desc t[3];
-	struct unpack_trees_options opts;
=20
-	memset(&opts, 0, sizeof(opts));
-	if (index_only)
-		opts.index_only =3D 1;
+	memset(&o->unpack_opts, 0, sizeof(o->unpack_opts));
+	if (o->call_depth)
+		o->unpack_opts.index_only =3D 1;
 	else
-		opts.update =3D 1;
-	opts.merge =3D 1;
-	opts.head_idx =3D 2;
-	opts.fn =3D threeway_merge;
-	opts.src_index =3D &the_index;
-	opts.dst_index =3D &the_index;
-	setup_unpack_trees_porcelain(&opts, "merge");
+		o->unpack_opts.update =3D 1;
+	o->unpack_opts.merge =3D 1;
+	o->unpack_opts.head_idx =3D 2;
+	o->unpack_opts.fn =3D threeway_merge;
+	o->unpack_opts.src_index =3D &the_index;
+	o->unpack_opts.dst_index =3D &the_index;
+	setup_unpack_trees_porcelain(&o->unpack_opts, "merge");
=20
 	init_tree_desc_from_tree(t+0, common);
 	init_tree_desc_from_tree(t+1, head);
 	init_tree_desc_from_tree(t+2, merge);
=20
-	rc =3D unpack_trees(3, t, &opts);
+	rc =3D unpack_trees(3, t, &o->unpack_opts);
+	/*
+	 * unpack_trees NULLifies src_index, but it's used in verify_uptodate,
+	 * so set to the new index which will usually have modification
+	 * timestamp info copied over.
+	 */
+	o->unpack_opts.src_index =3D &the_index;
 	cache_tree_free(&active_cache_tree);
 	return rc;
 }
@@ -795,6 +800,20 @@ static int would_lose_untracked(const char *path)
 	return !was_tracked(path) && file_exists(path);
 }
=20
+static int was_dirty(struct merge_options *o, const char *path)
+{
+	struct cache_entry *ce;
+	int dirty =3D 1;
+
+	if (o->call_depth || !was_tracked(path))
+		return !dirty;
+
+	ce =3D cache_file_exists(path, strlen(path), ignore_case);
+	dirty =3D (ce->ce_stat_data.sd_mtime.sec > 0 &&
+		 verify_uptodate(ce, &o->unpack_opts) !=3D 0);
+	return dirty;
+}
+
 static int make_room_for_path(struct merge_options *o, const char *path)
 {
 	int status, i;
@@ -2686,6 +2705,7 @@ static int handle_modify_delete(struct merge_option=
s *o,
=20
 static int merge_content(struct merge_options *o,
 			 const char *path,
+			 int file_in_way,
 			 struct object_id *o_oid, int o_mode,
 			 struct object_id *a_oid, int a_mode,
 			 struct object_id *b_oid, int b_mode,
@@ -2760,7 +2780,7 @@ static int merge_content(struct merge_options *o,
 				return -1;
 	}
=20
-	if (df_conflict_remains) {
+	if (df_conflict_remains || file_in_way) {
 		char *new_path;
 		if (o->call_depth) {
 			remove_file_from_cache(path);
@@ -2794,6 +2814,30 @@ static int merge_content(struct merge_options *o,
 	return mfi.clean;
 }
=20
+static int conflict_rename_normal(struct merge_options *o,
+				  const char *path,
+				  struct object_id *o_oid, unsigned int o_mode,
+				  struct object_id *a_oid, unsigned int a_mode,
+				  struct object_id *b_oid, unsigned int b_mode,
+				  struct rename_conflict_info *ci)
+{
+	int clean_merge;
+	int file_in_the_way =3D 0;
+
+	if (was_dirty(o, path)) {
+		file_in_the_way =3D 1;
+		output(o, 1, _("Refusing to lose dirty file at %s"), path);
+	}
+
+	/* Merge the content and write it out */
+	clean_merge =3D merge_content(o, path, file_in_the_way,
+				    o_oid, o_mode, a_oid, a_mode, b_oid, b_mode,
+				    ci);
+	if (clean_merge > 0 && file_in_the_way)
+		clean_merge =3D 0;
+	return clean_merge;
+}
+
 /* Per entry merge function */
 static int process_entry(struct merge_options *o,
 			 const char *path, struct stage_data *entry)
@@ -2813,9 +2857,12 @@ static int process_entry(struct merge_options *o,
 		switch (conflict_info->rename_type) {
 		case RENAME_NORMAL:
 		case RENAME_ONE_FILE_TO_ONE:
-			clean_merge =3D merge_content(o, path,
-						    o_oid, o_mode, a_oid, a_mode, b_oid, b_mode,
-						    conflict_info);
+			clean_merge =3D conflict_rename_normal(o,
+							     path,
+							     o_oid, o_mode,
+							     a_oid, a_mode,
+							     b_oid, b_mode,
+							     conflict_info);
 			break;
 		case RENAME_DIR:
 			clean_merge =3D 1;
@@ -2911,7 +2958,7 @@ static int process_entry(struct merge_options *o,
 	} else if (a_oid && b_oid) {
 		/* Case C: Added in both (check for same permissions) and */
 		/* case D: Modified in both, but differently. */
-		clean_merge =3D merge_content(o, path,
+		clean_merge =3D merge_content(o, path, 0 /* file_in_way */,
 					    o_oid, o_mode, a_oid, a_mode, b_oid, b_mode,
 					    NULL);
 	} else if (!o_oid && !a_oid && !b_oid) {
@@ -2952,7 +2999,7 @@ int merge_trees(struct merge_options *o,
 		return 1;
 	}
=20
-	code =3D git_merge_trees(o->call_depth, common, head, merge);
+	code =3D git_merge_trees(o, common, head, merge);
=20
 	if (code !=3D 0) {
 		if (show(o, 4) || o->call_depth)
diff --git a/merge-recursive.h b/merge-recursive.h
index 50a4e6af4e..d863cf8867 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -1,6 +1,7 @@
 #ifndef MERGE_RECURSIVE_H
 #define MERGE_RECURSIVE_H
=20
+#include "unpack-trees.h"
 #include "string-list.h"
=20
 struct merge_options {
@@ -27,6 +28,7 @@ struct merge_options {
 	struct strbuf obuf;
 	struct hashmap current_file_dir_set;
 	struct string_list df_conflict_file_set;
+	struct unpack_trees_options unpack_opts;
 };
=20
 /*
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.s=
h
index 783bdbf59d..0d89f6d0f6 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -141,7 +141,7 @@ test_expect_success 'cherry-pick "-" works with argum=
ents' '
 	test_cmp expect actual
 '
=20
-test_expect_failure 'cherry-pick works with dirty renamed file' '
+test_expect_success 'cherry-pick works with dirty renamed file' '
 	test_commit to-rename &&
 	git checkout -b unrelated &&
 	test_commit unrelated &&
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-d=
irectories.sh
index 0b60eb8053..b94ba066fe 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -3298,7 +3298,7 @@ test_expect_success '11a-setup: Avoid losing dirty =
contents with simple rename'
 	)
 '
=20
-test_expect_failure '11a-check: Avoid losing dirty contents with simple =
rename' '
+test_expect_success '11a-check: Avoid losing dirty contents with simple =
rename' '
 	(
 		cd 11a &&
=20
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index 9c422bcd7c..dd8ab7ede1 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -92,7 +92,7 @@ test_expect_success 'will not overwrite removed file wi=
th staged changes' '
 	test_cmp important c1.c
 '
=20
-test_expect_failure 'will not overwrite unstaged changes in renamed file=
' '
+test_expect_success 'will not overwrite unstaged changes in renamed file=
' '
 	git reset --hard c1 &&
 	git mv c1.c other.c &&
 	git commit -m rename &&
diff --git a/unpack-trees.c b/unpack-trees.c
index e6a15bbe44..30d762bd71 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1508,8 +1508,8 @@ static int verify_uptodate_1(const struct cache_ent=
ry *ce,
 		add_rejected_path(o, error_type, ce->name);
 }
=20
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
=20
+#include "tree-walk.h"
 #include "string-list.h"
=20
 #define MAX_UNPACK_TREES 8
@@ -78,6 +79,9 @@ struct unpack_trees_options {
 extern int unpack_trees(unsigned n, struct tree_desc *t,
 		struct unpack_trees_options *options);
=20
+int verify_uptodate(const struct cache_entry *ce,
+		    struct unpack_trees_options *o);
+
 int threeway_merge(const struct cache_entry * const *stages,
 		   struct unpack_trees_options *o);
 int twoway_merge(const struct cache_entry * const *src,
--=20
2.16.1.232.g28d5be9217

