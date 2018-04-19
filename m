Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05E711F404
	for <e@80x24.org>; Thu, 19 Apr 2018 17:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeDSR66 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 13:58:58 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:41726 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752804AbeDSR6i (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Apr 2018 13:58:38 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3JHnDip028655;
        Thu, 19 Apr 2018 10:58:30 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hdryeas79-1;
        Thu, 19 Apr 2018 10:58:29 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 3657522175D4;
        Thu, 19 Apr 2018 10:58:29 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 2B9062CDE6F;
        Thu, 19 Apr 2018 10:58:29 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        torvalds@linux-foundation.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH v10 23/36] merge-recursive: apply necessary modifications for directory renames
Date:   Thu, 19 Apr 2018 10:58:10 -0700
Message-Id: <20180419175823.7946-24-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.290.ge988e9ce2a
In-Reply-To: <20180419175823.7946-1-newren@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804190156
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit hooks together all the directory rename logic by making the
necessary changes to the rename struct, it's dst_entry, and the
diff_filepair under consideration.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c                   | 187 +++++++++++++++++++++++++++-
 t/t6043-merge-rename-directories.sh |  50 ++++----
 2 files changed, 211 insertions(+), 26 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d569e3e893..ec0bbcc3f4 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -180,6 +180,7 @@ static int oid_eq(const struct object_id *a, const struct object_id *b)
 
 enum rename_type {
 	RENAME_NORMAL = 0,
+	RENAME_DIR,
 	RENAME_DELETE,
 	RENAME_ONE_FILE_TO_ONE,
 	RENAME_ONE_FILE_TO_TWO,
@@ -610,6 +611,7 @@ struct rename {
 	 */
 	struct stage_data *src_entry;
 	struct stage_data *dst_entry;
+	unsigned add_turned_into_rename:1;
 	unsigned processed:1;
 };
 
@@ -644,6 +646,27 @@ static int update_stages(struct merge_options *opt, const char *path,
 	return 0;
 }
 
+static int update_stages_for_stage_data(struct merge_options *opt,
+					const char *path,
+					const struct stage_data *stage_data)
+{
+	struct diff_filespec o, a, b;
+
+	o.mode = stage_data->stages[1].mode;
+	oidcpy(&o.oid, &stage_data->stages[1].oid);
+
+	a.mode = stage_data->stages[2].mode;
+	oidcpy(&a.oid, &stage_data->stages[2].oid);
+
+	b.mode = stage_data->stages[3].mode;
+	oidcpy(&b.oid, &stage_data->stages[3].oid);
+
+	return update_stages(opt, path,
+			     is_null_oid(&o.oid) ? NULL : &o,
+			     is_null_oid(&a.oid) ? NULL : &a,
+			     is_null_oid(&b.oid) ? NULL : &b);
+}
+
 static void update_entry(struct stage_data *entry,
 			 struct diff_filespec *o,
 			 struct diff_filespec *a,
@@ -1121,6 +1144,18 @@ static int merge_file_one(struct merge_options *o,
 	return merge_file_1(o, &one, &a, &b, branch1, branch2, mfi);
 }
 
+static int conflict_rename_dir(struct merge_options *o,
+			       struct diff_filepair *pair,
+			       const char *rename_branch,
+			       const char *other_branch)
+{
+	const struct diff_filespec *dest = pair->two;
+
+	if (update_file(o, 1, &dest->oid, dest->mode, dest->path))
+		return -1;
+	return 0;
+}
+
 static int handle_change_delete(struct merge_options *o,
 				 const char *path, const char *old_path,
 				 const struct object_id *o_oid, int o_mode,
@@ -1390,6 +1425,24 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
 		if (!ret)
 			ret = update_file(o, 0, &mfi_c2.oid, mfi_c2.mode,
 					  new_path2);
+		/*
+		 * unpack_trees() actually populates the index for us for
+		 * "normal" rename/rename(2to1) situtations so that the
+		 * correct entries are at the higher stages, which would
+		 * make the call below to update_stages_for_stage_data
+		 * unnecessary.  However, if either of the renames came
+		 * from a directory rename, then unpack_trees() will not
+		 * have gotten the right data loaded into the index, so we
+		 * need to do so now.  (While it'd be tempting to move this
+		 * call to update_stages_for_stage_data() to
+		 * apply_directory_rename_modifications(), that would break
+		 * our intermediate calls to would_lose_untracked() since
+		 * those rely on the current in-memory index.  See also the
+		 * big "NOTE" in update_stages()).
+		 */
+		if (update_stages_for_stage_data(o, path, ci->dst_entry1))
+			ret = -1;
+
 		free(new_path2);
 		free(new_path1);
 	}
@@ -1952,6 +2005,111 @@ static char *check_for_directory_rename(struct merge_options *o,
 	return new_path;
 }
 
+static void apply_directory_rename_modifications(struct merge_options *o,
+						 struct diff_filepair *pair,
+						 char *new_path,
+						 struct rename *re,
+						 struct tree *tree,
+						 struct tree *o_tree,
+						 struct tree *a_tree,
+						 struct tree *b_tree,
+						 struct string_list *entries,
+						 int *clean)
+{
+	struct string_list_item *item;
+	int stage = (tree == a_tree ? 2 : 3);
+
+	/*
+	 * In all cases where we can do directory rename detection,
+	 * unpack_trees() will have read pair->two->path into the
+	 * index and the working copy.  We need to remove it so that
+	 * we can instead place it at new_path.  It is guaranteed to
+	 * not be untracked (unpack_trees() would have errored out
+	 * saying the file would have been overwritten), but it might
+	 * be dirty, though.
+	 */
+	remove_file(o, 1, pair->two->path, 0 /* no_wd */);
+
+	/* Find or create a new re->dst_entry */
+	item = string_list_lookup(entries, new_path);
+	if (item) {
+		/*
+		 * Since we're renaming on this side of history, and it's
+		 * due to a directory rename on the other side of history
+		 * (which we only allow when the directory in question no
+		 * longer exists on the other side of history), the
+		 * original entry for re->dst_entry is no longer
+		 * necessary...
+		 */
+		re->dst_entry->processed = 1;
+
+		/*
+		 * ...because we'll be using this new one.
+		 */
+		re->dst_entry = item->util;
+	} else {
+		/*
+		 * re->dst_entry is for the before-dir-rename path, and we
+		 * need it to hold information for the after-dir-rename
+		 * path.  Before creating a new entry, we need to mark the
+		 * old one as unnecessary (...unless it is shared by
+		 * src_entry, i.e. this didn't use to be a rename, in which
+		 * case we can just allow the normal processing to happen
+		 * for it).
+		 */
+		if (pair->status == 'R')
+			re->dst_entry->processed = 1;
+
+		re->dst_entry = insert_stage_data(new_path,
+						  o_tree, a_tree, b_tree,
+						  entries);
+		item = string_list_insert(entries, new_path);
+		item->util = re->dst_entry;
+	}
+
+	/*
+	 * Update the stage_data with the information about the path we are
+	 * moving into place.  That slot will be empty and available for us
+	 * to write to because of the collision checks in
+	 * handle_path_level_conflicts().  In other words,
+	 * re->dst_entry->stages[stage].oid will be the null_oid, so it's
+	 * open for us to write to.
+	 *
+	 * It may be tempting to actually update the index at this point as
+	 * well, using update_stages_for_stage_data(), but as per the big
+	 * "NOTE" in update_stages(), doing so will modify the current
+	 * in-memory index which will break calls to would_lose_untracked()
+	 * that we need to make.  Instead, we need to just make sure that
+	 * the various conflict_rename_*() functions update the index
+	 * explicitly rather than relying on unpack_trees() to have done it.
+	 */
+	get_tree_entry(&tree->object.oid,
+		       pair->two->path,
+		       &re->dst_entry->stages[stage].oid,
+		       &re->dst_entry->stages[stage].mode);
+
+	/* Update pair status */
+	if (pair->status == 'A') {
+		/*
+		 * Recording rename information for this add makes it look
+		 * like a rename/delete conflict.  Make sure we can
+		 * correctly handle this as an add that was moved to a new
+		 * directory instead of reporting a rename/delete conflict.
+		 */
+		re->add_turned_into_rename = 1;
+	}
+	/*
+	 * We don't actually look at pair->status again, but it seems
+	 * pedagogically correct to adjust it.
+	 */
+	pair->status = 'R';
+
+	/*
+	 * Finally, record the new location.
+	 */
+	pair->two->path = new_path;
+}
+
 /*
  * Get information of all renames which occurred in 'pairs', making use of
  * any implicit directory renames inferred from the other side of history.
@@ -2001,6 +2159,7 @@ static struct string_list *get_renames(struct merge_options *o,
 
 		re = xmalloc(sizeof(*re));
 		re->processed = 0;
+		re->add_turned_into_rename = 0;
 		re->pair = pair;
 		item = string_list_lookup(entries, re->pair->one->path);
 		if (!item)
@@ -2017,6 +2176,12 @@ static struct string_list *get_renames(struct merge_options *o,
 			re->dst_entry = item->util;
 		item = string_list_insert(renames, pair->one->path);
 		item->util = re;
+		if (new_path)
+			apply_directory_rename_modifications(o, pair, new_path,
+							     re, tree, o_tree,
+							     a_tree, b_tree,
+							     entries,
+							     clean_merge);
 	}
 
 	hashmap_iter_init(&collisions, &iter);
@@ -2186,7 +2351,19 @@ static int process_renames(struct merge_options *o,
 			dst_other.mode = ren1->dst_entry->stages[other_stage].mode;
 			try_merge = 0;
 
-			if (oid_eq(&src_other.oid, &null_oid)) {
+			if (oid_eq(&src_other.oid, &null_oid) &&
+			    ren1->add_turned_into_rename) {
+				setup_rename_conflict_info(RENAME_DIR,
+							   ren1->pair,
+							   NULL,
+							   branch1,
+							   branch2,
+							   ren1->dst_entry,
+							   NULL,
+							   o,
+							   NULL,
+							   NULL);
+			} else if (oid_eq(&src_other.oid, &null_oid)) {
 				setup_rename_conflict_info(RENAME_DELETE,
 							   ren1->pair,
 							   NULL,
@@ -2603,6 +2780,14 @@ static int process_entry(struct merge_options *o,
 						    o_oid, o_mode, a_oid, a_mode, b_oid, b_mode,
 						    conflict_info);
 			break;
+		case RENAME_DIR:
+			clean_merge = 1;
+			if (conflict_rename_dir(o,
+						conflict_info->pair1,
+						conflict_info->branch1,
+						conflict_info->branch2))
+				clean_merge = -1;
+			break;
 		case RENAME_DELETE:
 			clean_merge = 0;
 			if (conflict_rename_delete(o,
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index b24562b849..3525c54bb4 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -69,7 +69,7 @@ test_expect_success '1a-setup: Simple directory rename detection' '
 	)
 '
 
-test_expect_failure '1a-check: Simple directory rename detection' '
+test_expect_success '1a-check: Simple directory rename detection' '
 	(
 		cd 1a &&
 
@@ -136,7 +136,7 @@ test_expect_success '1b-setup: Merge a directory with another' '
 	)
 '
 
-test_expect_failure '1b-check: Merge a directory with another' '
+test_expect_success '1b-check: Merge a directory with another' '
 	(
 		cd 1b &&
 
@@ -194,7 +194,7 @@ test_expect_success '1c-setup: Transitive renaming' '
 	)
 '
 
-test_expect_failure '1c-check: Transitive renaming' '
+test_expect_success '1c-check: Transitive renaming' '
 	(
 		cd 1c &&
 
@@ -263,7 +263,7 @@ test_expect_success '1d-setup: Directory renames cause a rename/rename(2to1) con
 	)
 '
 
-test_expect_failure '1d-check: Directory renames cause a rename/rename(2to1) conflict' '
+test_expect_success '1d-check: Directory renames cause a rename/rename(2to1) conflict' '
 	(
 		cd 1d &&
 
@@ -342,7 +342,7 @@ test_expect_success '1e-setup: Renamed directory, with all files being renamed t
 	)
 '
 
-test_expect_failure '1e-check: Renamed directory, with all files being renamed too' '
+test_expect_success '1e-check: Renamed directory, with all files being renamed too' '
 	(
 		cd 1e &&
 
@@ -408,7 +408,7 @@ test_expect_success '1f-setup: Split a directory into two other directories' '
 	)
 '
 
-test_expect_failure '1f-check: Split a directory into two other directories' '
+test_expect_success '1f-check: Split a directory into two other directories' '
 	(
 		cd 1f &&
 
@@ -907,7 +907,7 @@ test_expect_success '5a-setup: Merge directories, other side adds files to origi
 	)
 '
 
-test_expect_failure '5a-check: Merge directories, other side adds files to original and target' '
+test_expect_success '5a-check: Merge directories, other side adds files to original and target' '
 	(
 		cd 5a &&
 
@@ -981,7 +981,7 @@ test_expect_success '5b-setup: Rename/delete in order to get add/add/add conflic
 	)
 '
 
-test_expect_failure '5b-check: Rename/delete in order to get add/add/add conflict' '
+test_expect_success '5b-check: Rename/delete in order to get add/add/add conflict' '
 	(
 		cd 5b &&
 
@@ -1061,7 +1061,7 @@ test_expect_success '5c-setup: Transitive rename would cause rename/rename/renam
 	)
 '
 
-test_expect_failure '5c-check: Transitive rename would cause rename/rename/rename/add/add/add' '
+test_expect_success '5c-check: Transitive rename would cause rename/rename/rename/add/add/add' '
 	(
 		cd 5c &&
 
@@ -1145,7 +1145,7 @@ test_expect_success '5d-setup: Directory/file/file conflict due to directory ren
 	)
 '
 
-test_expect_failure '5d-check: Directory/file/file conflict due to directory rename' '
+test_expect_success '5d-check: Directory/file/file conflict due to directory rename' '
 	(
 		cd 5d &&
 
@@ -1583,7 +1583,7 @@ test_expect_success '7a-setup: rename-dir vs. rename-dir (NOT split evenly) PLUS
 	)
 '
 
-test_expect_failure '7a-check: rename-dir vs. rename-dir (NOT split evenly) PLUS add-other-file' '
+test_expect_success '7a-check: rename-dir vs. rename-dir (NOT split evenly) PLUS add-other-file' '
 	(
 		cd 7a &&
 
@@ -1655,7 +1655,7 @@ test_expect_success '7b-setup: rename/rename(2to1), but only due to transitive r
 	)
 '
 
-test_expect_failure '7b-check: rename/rename(2to1), but only due to transitive rename' '
+test_expect_success '7b-check: rename/rename(2to1), but only due to transitive rename' '
 	(
 		cd 7b &&
 
@@ -1731,7 +1731,7 @@ test_expect_success '7c-setup: rename/rename(1to...2or3); transitive rename may
 	)
 '
 
-test_expect_failure '7c-check: rename/rename(1to...2or3); transitive rename may add complexity' '
+test_expect_success '7c-check: rename/rename(1to...2or3); transitive rename may add complexity' '
 	(
 		cd 7c &&
 
@@ -1795,7 +1795,7 @@ test_expect_success '7d-setup: transitive rename involved in rename/delete; how
 	)
 '
 
-test_expect_failure '7d-check: transitive rename involved in rename/delete; how is it reported?' '
+test_expect_success '7d-check: transitive rename involved in rename/delete; how is it reported?' '
 	(
 		cd 7d &&
 
@@ -1885,7 +1885,7 @@ test_expect_success '7e-setup: transitive rename in rename/delete AND dirs in th
 	)
 '
 
-test_expect_failure '7e-check: transitive rename in rename/delete AND dirs in the way' '
+test_expect_success '7e-check: transitive rename in rename/delete AND dirs in the way' '
 	(
 		cd 7e &&
 
@@ -1976,7 +1976,7 @@ test_expect_success '8a-setup: Dual-directory rename, one into the others way' '
 	)
 '
 
-test_expect_failure '8a-check: Dual-directory rename, one into the others way' '
+test_expect_success '8a-check: Dual-directory rename, one into the others way' '
 	(
 		cd 8a &&
 
@@ -2121,7 +2121,7 @@ test_expect_success '8c-setup: rename+modify/delete' '
 	)
 '
 
-test_expect_failure '8c-check: rename+modify/delete' '
+test_expect_success '8c-check: rename+modify/delete' '
 	(
 		cd 8c &&
 
@@ -2208,7 +2208,7 @@ test_expect_success '8d-setup: rename/delete...or not?' '
 	)
 '
 
-test_expect_failure '8d-check: rename/delete...or not?' '
+test_expect_success '8d-check: rename/delete...or not?' '
 	(
 		cd 8d &&
 
@@ -2283,7 +2283,7 @@ test_expect_success '8e-setup: Both sides rename, one side adds to original dire
 	)
 '
 
-test_expect_failure '8e-check: Both sides rename, one side adds to original directory' '
+test_expect_success '8e-check: Both sides rename, one side adds to original directory' '
 	(
 		cd 8e &&
 
@@ -2370,7 +2370,7 @@ test_expect_success '9a-setup: Inner renamed directory within outer renamed dire
 	)
 '
 
-test_expect_failure '9a-check: Inner renamed directory within outer renamed directory' '
+test_expect_success '9a-check: Inner renamed directory within outer renamed directory' '
 	(
 		cd 9a &&
 
@@ -2440,7 +2440,7 @@ test_expect_success '9b-setup: Transitive rename with content merge' '
 	)
 '
 
-test_expect_failure '9b-check: Transitive rename with content merge' '
+test_expect_success '9b-check: Transitive rename with content merge' '
 	(
 		cd 9b &&
 
@@ -2530,7 +2530,7 @@ test_expect_success '9c-setup: Doubly transitive rename?' '
 	)
 '
 
-test_expect_failure '9c-check: Doubly transitive rename?' '
+test_expect_success '9c-check: Doubly transitive rename?' '
 	(
 		cd 9c &&
 
@@ -2618,7 +2618,7 @@ test_expect_success '9d-setup: N-way transitive rename?' '
 	)
 '
 
-test_expect_failure '9d-check: N-way transitive rename?' '
+test_expect_success '9d-check: N-way transitive rename?' '
 	(
 		cd 9d &&
 
@@ -2700,7 +2700,7 @@ test_expect_success '9e-setup: N-to-1 whammo' '
 	)
 '
 
-test_expect_failure C_LOCALE_OUTPUT '9e-check: N-to-1 whammo' '
+test_expect_success C_LOCALE_OUTPUT '9e-check: N-to-1 whammo' '
 	(
 		cd 9e &&
 
@@ -2778,7 +2778,7 @@ test_expect_success '9f-setup: Renamed directory that only contained immediate s
 	)
 '
 
-test_expect_failure '9f-check: Renamed directory that only contained immediate subdirs' '
+test_expect_success '9f-check: Renamed directory that only contained immediate subdirs' '
 	(
 		cd 9f &&
 
-- 
2.17.0.290.ge988e9ce2a

