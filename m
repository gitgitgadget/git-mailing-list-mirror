Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3420C1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 19:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753914AbdKJTGP (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 14:06:15 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:51770 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753777AbdKJTGD (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 14:06:03 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAJ2vmv017416;
        Fri, 10 Nov 2017 11:06:01 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e535n1cdj-1;
        Fri, 10 Nov 2017 11:06:01 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 6266622F6296;
        Fri, 10 Nov 2017 11:06:01 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 574F92CDEB4;
        Fri, 10 Nov 2017 11:06:01 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 27/30] merge-recursive: Apply necessary modifications for directory renames
Date:   Fri, 10 Nov 2017 11:05:47 -0800
Message-Id: <20171110190550.27059-28-newren@gmail.com>
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

This commit hooks together all the directory rename logic by making the
necessary changes to the rename struct, it's dst_entry, and the
diff_filepair under consideration.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 195 +++++++++++++++++++++++++++++++++++-
 t/t6043-merge-rename-directories.sh |  50 ++++-----
 2 files changed, 219 insertions(+), 26 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 2a7258f6bb..838bfd32ec 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -166,6 +166,7 @@ static int oid_eq(const struct object_id *a, const struct object_id *b)
 
 enum rename_type {
 	RENAME_NORMAL = 0,
+	RENAME_DIR,
 	RENAME_DELETE,
 	RENAME_ONE_FILE_TO_ONE,
 	RENAME_ONE_FILE_TO_TWO,
@@ -599,6 +600,7 @@ struct rename {
 	 */
 	struct stage_data *src_entry;
 	struct stage_data *dst_entry;
+	unsigned add_turned_into_rename:1;
 	unsigned processed:1;
 };
 
@@ -633,6 +635,26 @@ static int update_stages(struct merge_options *opt, const char *path,
 	return 0;
 }
 
+static int update_stages_for_stage_data(struct merge_options *opt,
+					const char *path,
+					const struct stage_data *stage_data)
+{
+	struct diff_filespec o, a, b;
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
+			     is_null_sha1(o.oid.hash) ? NULL : &o,
+			     is_null_sha1(a.oid.hash) ? NULL : &a,
+			     is_null_sha1(b.oid.hash) ? NULL : &b);
+}
+
 static void update_entry(struct stage_data *entry,
 			 struct diff_filespec *o,
 			 struct diff_filespec *a,
@@ -1100,6 +1122,18 @@ static int merge_file_one(struct merge_options *o,
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
@@ -1369,6 +1403,24 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
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
@@ -1888,6 +1940,120 @@ static char *check_for_directory_rename(struct merge_options *o,
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
+		if (!strcmp(pair->one->path, pair->two->path)) {
+			/*
+			 * Paths should only match if this was initially a
+			 * non-rename that is being turned into one by
+			 * directory rename detection.
+			 */
+			assert(pair->status != 'R');
+		} else {
+			assert(pair->status == 'R');
+			re->dst_entry->processed = 1;
+			//string_list_remove(entries, pair->two->path, 0);
+		}
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
+	 * handle_path_level_conflicts().
+	 *
+	 * It may be tempting to actually update the index at this point as
+	 * well, using update_stages_for_stage_data(), but as per the big
+	 * "NOTE" in update_stages(), doing so will modify the current
+	 * in-memory index which will break calls to would_lose_untracked()
+	 * that we need to make.  Instead, we need to just make sure that
+	 * the various conflict_rename_*() functions update the index
+	 * explicitly rather than relying on unpack_trees() to have done it.
+	 */
+	assert(is_null_oid(&re->dst_entry->stages[stage].oid));
+	get_tree_entry(tree->object.oid.hash,
+		       pair->two->path,
+		       re->dst_entry->stages[stage].oid.hash,
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
@@ -1937,6 +2103,7 @@ static struct string_list *get_renames(struct merge_options *o,
 
 		re = xmalloc(sizeof(*re));
 		re->processed = 0;
+		re->add_turned_into_rename = 0;
 		re->pair = pair;
 		item = string_list_lookup(entries, re->pair->one->path);
 		if (!item)
@@ -1953,6 +2120,12 @@ static struct string_list *get_renames(struct merge_options *o,
 			re->dst_entry = item->util;
 		item = string_list_insert(renames, pair->one->path);
 		item->util = re;
+		if (new_path)
+			  apply_directory_rename_modifications(o, pair, new_path,
+							       re, tree, o_tree,
+							       a_tree, b_tree,
+							       entries,
+							       clean_merge);
 	}
 
 	hashmap_iter_init(&collisions, &iter);
@@ -2122,7 +2295,19 @@ static int process_renames(struct merge_options *o,
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
@@ -2546,6 +2731,14 @@ static int process_entry(struct merge_options *o,
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
index 858d83016a..e737bad2c5 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -64,7 +64,7 @@ test_expect_success '1a-setup: Simple directory rename detection' '
 	git commit -m "C"
 '
 
-test_expect_failure '1a-check: Simple directory rename detection' '
+test_expect_success '1a-check: Simple directory rename detection' '
 	git checkout B^0 &&
 
 	git merge -s recursive C^0 &&
@@ -121,7 +121,7 @@ test_expect_success '1b-setup: Merge a directory with another' '
 	git commit -m "C"
 '
 
-test_expect_failure '1b-check: Merge a directory with another' '
+test_expect_success '1b-check: Merge a directory with another' '
 	git checkout B^0 &&
 
 	git merge -s recursive C^0 &&
@@ -173,7 +173,7 @@ test_expect_success '1c-setup: Transitive renaming' '
 	git commit -m "C"
 '
 
-test_expect_failure '1c-check: Transitive renaming' '
+test_expect_success '1c-check: Transitive renaming' '
 	git checkout B^0 &&
 
 	git merge -s recursive C^0 &&
@@ -235,7 +235,7 @@ test_expect_success '1d-setup: Directory renames cause a rename/rename(2to1) con
 	git commit -m "C"
 '
 
-test_expect_failure '1d-check: Directory renames cause a rename/rename(2to1) conflict' '
+test_expect_success '1d-check: Directory renames cause a rename/rename(2to1) conflict' '
 	git checkout B^0 &&
 
 	test_must_fail git merge -s recursive C^0 >out &&
@@ -302,7 +302,7 @@ test_expect_success '1e-setup: Renamed directory, with all files being renamed t
 	git commit -m "C"
 '
 
-test_expect_failure '1e-check: Renamed directory, with all files being renamed too' '
+test_expect_success '1e-check: Renamed directory, with all files being renamed too' '
 	git checkout B^0 &&
 
 	git merge -s recursive C^0 &&
@@ -361,7 +361,7 @@ test_expect_success '1f-setup: Split a directory into two other directories' '
 	git commit -m "C"
 '
 
-test_expect_failure '1f-check: Split a directory into two other directories' '
+test_expect_success '1f-check: Split a directory into two other directories' '
 	git checkout B^0 &&
 
 	git merge -s recursive C^0 &&
@@ -807,7 +807,7 @@ test_expect_success '5a-setup: Merge directories, other side adds files to origi
 	git commit -m "C"
 '
 
-test_expect_failure '5a-check: Merge directories, other side adds files to original and target' '
+test_expect_success '5a-check: Merge directories, other side adds files to original and target' '
 	git checkout B^0 &&
 
 	test_must_fail git merge -s recursive C^0 >out &&
@@ -878,7 +878,7 @@ test_expect_success '5b-setup: Rename/delete in order to get add/add/add conflic
 	git commit -m "C"
 '
 
-test_expect_failure '5b-check: Rename/delete in order to get add/add/add conflict' '
+test_expect_success '5b-check: Rename/delete in order to get add/add/add conflict' '
 	git checkout B^0 &&
 
 	test_must_fail git merge -s recursive C^0 >out &&
@@ -951,7 +951,7 @@ test_expect_success '5c-setup: Transitive rename would cause rename/rename/renam
 	git commit -m "C"
 '
 
-test_expect_failure '5c-check: Transitive rename would cause rename/rename/rename/add/add/add' '
+test_expect_success '5c-check: Transitive rename would cause rename/rename/rename/add/add/add' '
 	git checkout B^0 &&
 
 	test_must_fail git merge -s recursive C^0 >out &&
@@ -1025,7 +1025,7 @@ test_expect_success '5d-setup: Directory/file/file conflict due to directory ren
 	git commit -m "C"
 '
 
-test_expect_failure '5d-check: Directory/file/file conflict due to directory rename' '
+test_expect_success '5d-check: Directory/file/file conflict due to directory rename' '
 	git checkout B^0 &&
 
 	test_must_fail git merge -s recursive C^0 >out &&
@@ -1403,7 +1403,7 @@ test_expect_success '7a-setup: rename-dir vs. rename-dir (NOT split evenly) PLUS
 	git commit -m "C"
 '
 
-test_expect_failure '7a-check: rename-dir vs. rename-dir (NOT split evenly) PLUS add-other-file' '
+test_expect_success '7a-check: rename-dir vs. rename-dir (NOT split evenly) PLUS add-other-file' '
 	git checkout B^0 &&
 
 	test_must_fail git merge -s recursive C^0 >out &&
@@ -1471,7 +1471,7 @@ test_expect_success '7b-setup: rename/rename(2to1), but only due to transitive r
 	git commit -m "C"
 '
 
-test_expect_failure '7b-check: rename/rename(2to1), but only due to transitive rename' '
+test_expect_success '7b-check: rename/rename(2to1), but only due to transitive rename' '
 	git checkout B^0 &&
 
 	test_must_fail git merge -s recursive C^0 >out &&
@@ -1537,7 +1537,7 @@ test_expect_success '7c-setup: rename/rename(1to...2or3); transitive rename may
 	git commit -m "C"
 '
 
-test_expect_failure '7c-check: rename/rename(1to...2or3); transitive rename may add complexity' '
+test_expect_success '7c-check: rename/rename(1to...2or3); transitive rename may add complexity' '
 	git checkout B^0 &&
 
 	test_must_fail git merge -s recursive C^0 >out &&
@@ -1595,7 +1595,7 @@ test_expect_success '7d-setup: transitive rename involved in rename/delete; how
 	git commit -m "C"
 '
 
-test_expect_failure '7d-check: transitive rename involved in rename/delete; how is it reported?' '
+test_expect_success '7d-check: transitive rename involved in rename/delete; how is it reported?' '
 	git checkout B^0 &&
 
 	test_must_fail git merge -s recursive C^0 >out &&
@@ -1664,7 +1664,7 @@ test_expect_success '7e-setup: transitive rename in rename/delete AND dirs in th
 	git commit -m "C"
 '
 
-test_expect_failure '7e-check: transitive rename in rename/delete AND dirs in the way' '
+test_expect_success '7e-check: transitive rename in rename/delete AND dirs in the way' '
 	git checkout B^0 &&
 
 	test_must_fail git merge -s recursive C^0 >out &&
@@ -1748,7 +1748,7 @@ test_expect_success '8a-setup: Dual-directory rename, one into the others way' '
 	git commit -m "C"
 '
 
-test_expect_failure '8a-check: Dual-directory rename, one into the others way' '
+test_expect_success '8a-check: Dual-directory rename, one into the others way' '
 	git checkout B^0 &&
 
 	git merge -s recursive C^0 &&
@@ -1881,7 +1881,7 @@ test_expect_success '8c-setup: rename+modify/delete' '
 	git commit -m "C"
 '
 
-test_expect_failure '8c-check: rename+modify/delete' '
+test_expect_success '8c-check: rename+modify/delete' '
 	git checkout B^0 &&
 
 	test_must_fail git merge -s recursive C^0 >out &&
@@ -1960,7 +1960,7 @@ test_expect_success '8d-setup: rename/delete...or not?' '
 	git commit -m "C"
 '
 
-test_expect_failure '8d-check: rename/delete...or not?' '
+test_expect_success '8d-check: rename/delete...or not?' '
 	git checkout B^0 &&
 
 	git merge -s recursive C^0 &&
@@ -2026,7 +2026,7 @@ test_expect_success '8e-setup: Both sides rename, one side adds to original dire
 	git commit -m "C"
 '
 
-test_expect_failure '8e-check: Both sides rename, one side adds to original directory' '
+test_expect_success '8e-check: Both sides rename, one side adds to original directory' '
 	git checkout B^0 &&
 
 	test_must_fail git merge -s recursive C^0 >out 2>err &&
@@ -2111,7 +2111,7 @@ test_expect_success '9a-setup: Inner renamed directory within outer renamed dire
 	git commit -m "C"
 '
 
-test_expect_failure '9a-check: Inner renamed directory within outer renamed directory' '
+test_expect_success '9a-check: Inner renamed directory within outer renamed directory' '
 	git checkout B^0 &&
 
 	git merge -s recursive C^0 &&
@@ -2171,7 +2171,7 @@ test_expect_success '9b-setup: Transitive rename with content merge' '
 	git commit -m "C"
 '
 
-test_expect_failure '9b-check: Transitive rename with content merge' '
+test_expect_success '9b-check: Transitive rename with content merge' '
 	git checkout B^0 &&
 
 	git merge -s recursive C^0 &&
@@ -2254,7 +2254,7 @@ test_expect_success '9c-setup: Doubly transitive rename?' '
 	git commit -m "C"
 '
 
-test_expect_failure '9c-check: Doubly transitive rename?' '
+test_expect_success '9c-check: Doubly transitive rename?' '
 	git checkout B^0 &&
 
 	git merge -s recursive C^0 >out &&
@@ -2337,7 +2337,7 @@ test_expect_success '9d-setup: N-way transitive rename?' '
 	git commit -m "C"
 '
 
-test_expect_failure '9d-check: N-way transitive rename?' '
+test_expect_success '9d-check: N-way transitive rename?' '
 	git checkout B^0 &&
 
 	git merge -s recursive C^0 >out &&
@@ -2411,7 +2411,7 @@ test_expect_success '9e-setup: N-to-1 whammo' '
 	git commit -m "C"
 '
 
-test_expect_failure '9e-check: N-to-1 whammo' '
+test_expect_success '9e-check: N-to-1 whammo' '
 	git checkout B^0 &&
 
 	test_must_fail git merge -s recursive C^0 >out &&
@@ -2482,7 +2482,7 @@ test_expect_success '9f-setup: Renamed directory that only contained immediate s
 	git commit -m "C"
 '
 
-test_expect_failure '9f-check: Renamed directory that only contained immediate subdirs' '
+test_expect_success '9f-check: Renamed directory that only contained immediate subdirs' '
 	git checkout B^0 &&
 
 	git merge -s recursive C^0 &&
-- 
2.15.0.5.g9567be9905

