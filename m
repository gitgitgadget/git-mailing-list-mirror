Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 340C81F51C
	for <e@80x24.org>; Sat, 19 May 2018 02:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeESCHN (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 22:07:13 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:59102 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752206AbeESCHF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 May 2018 22:07:05 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4J25NJ2023769;
        Fri, 18 May 2018 19:07:03 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2j23ryhmu2-1;
        Fri, 18 May 2018 19:07:03 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 17C4E229B0EC;
        Fri, 18 May 2018 19:07:03 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 114922CDEF1;
        Fri, 18 May 2018 19:07:03 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 4/5] merge-recursive: rename conflict_rename_*() family of functions
Date:   Fri, 18 May 2018 19:06:59 -0700
Message-Id: <20180519020700.2241-5-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.847.g20b8963732
In-Reply-To: <20180519020700.2241-1-newren@gmail.com>
References: <20180519020700.2241-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1805190021
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These functions were added because processing of these conflicts needed
to be deferred until process_entry() in order to get D/F conflicts and
such right.  The number of these has grown over time, and now include
some whose name is misleading:
  * conflict_rename_normal() is for handling normal file renames; a
    typical rename may need content merging, but we expect conflicts
    from that to be more the exception than the rule.
  * conflict_rename_via_dir() will not be a conflict; it was just an
    add that turned into a move due to directory rename detection.
    (If there was a file in the way of the move, that would have been
    detected and reported earlier.)
  * conflict_rename_rename_2to1 and conflict_rename_add (the latter
    of which doesn't exist yet but has been submitted before and I
    intend to resend) technically might not be conflicts if the
    colliding paths happen to match exactly.
Rename this family of functions to handle_rename_*().

Also rename handle_renames() to detect_and_process_renames() both to make
it clearer what it does, and to differentiate it as a pre-processing step
from all the handle_rename_*() functions which are called from
process_entry().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 86 +++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d30085d9c7..273ee79afa 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1224,10 +1224,10 @@ static int merge_file_one(struct merge_options *o,
 	return merge_file_1(o, &one, &a, &b, path, branch1, branch2, mfi);
 }
 
-static int conflict_rename_via_dir(struct merge_options *o,
-				   struct diff_filepair *pair,
-				   const char *rename_branch,
-				   const char *other_branch)
+static int handle_rename_via_dir(struct merge_options *o,
+				 struct diff_filepair *pair,
+				 const char *rename_branch,
+				 const char *other_branch)
 {
 	/*
 	 * Handle file adds that need to be renamed due to directory rename
@@ -1329,10 +1329,10 @@ static int handle_change_delete(struct merge_options *o,
 	return ret;
 }
 
-static int conflict_rename_delete(struct merge_options *o,
-				  struct diff_filepair *pair,
-				  const char *rename_branch,
-				  const char *delete_branch)
+static int handle_rename_delete(struct merge_options *o,
+				struct diff_filepair *pair,
+				const char *rename_branch,
+				const char *delete_branch)
 {
 	const struct diff_filespec *orig = pair->one;
 	const struct diff_filespec *dest = pair->two;
@@ -1434,8 +1434,8 @@ static int handle_file(struct merge_options *o,
 	return ret;
 }
 
-static int conflict_rename_rename_1to2(struct merge_options *o,
-				       struct rename_conflict_info *ci)
+static int handle_rename_rename_1to2(struct merge_options *o,
+				     struct rename_conflict_info *ci)
 {
 	/* One file was renamed in both branches, but to different names. */
 	struct diff_filespec *one = ci->pair1->one;
@@ -1496,8 +1496,8 @@ static int conflict_rename_rename_1to2(struct merge_options *o,
 	return 0;
 }
 
-static int conflict_rename_rename_2to1(struct merge_options *o,
-				       struct rename_conflict_info *ci)
+static int handle_rename_rename_2to1(struct merge_options *o,
+				     struct rename_conflict_info *ci)
 {
 	/* Two files, a & b, were renamed to the same thing, c. */
 	struct diff_filespec *a = ci->pair1->one;
@@ -2231,7 +2231,7 @@ static void apply_directory_rename_modifications(struct merge_options *o,
 	 * "NOTE" in update_stages(), doing so will modify the current
 	 * in-memory index which will break calls to would_lose_untracked()
 	 * that we need to make.  Instead, we need to just make sure that
-	 * the various conflict_rename_*() functions update the index
+	 * the various handle_rename_*() functions update the index
 	 * explicitly rather than relying on unpack_trees() to have done it.
 	 */
 	get_tree_entry(&tree->object.oid,
@@ -2635,12 +2635,12 @@ static void initial_cleanup_rename(struct diff_queue_struct *pairs,
 	free(pairs);
 }
 
-static int handle_renames(struct merge_options *o,
-			  struct tree *common,
-			  struct tree *head,
-			  struct tree *merge,
-			  struct string_list *entries,
-			  struct rename_info *ri)
+static int detect_and_process_renames(struct merge_options *o,
+				      struct tree *common,
+				      struct tree *head,
+				      struct tree *merge,
+				      struct string_list *entries,
+				      struct rename_info *ri)
 {
 	struct diff_queue_struct *head_pairs, *merge_pairs;
 	struct hashmap *dir_re_head, *dir_re_merge;
@@ -2911,12 +2911,12 @@ static int merge_content(struct merge_options *o,
 	return !is_dirty && mfi.clean;
 }
 
-static int conflict_rename_normal(struct merge_options *o,
-				  const char *path,
-				  struct object_id *o_oid, unsigned int o_mode,
-				  struct object_id *a_oid, unsigned int a_mode,
-				  struct object_id *b_oid, unsigned int b_mode,
-				  struct rename_conflict_info *ci)
+static int handle_rename_normal(struct merge_options *o,
+				const char *path,
+				struct object_id *o_oid, unsigned int o_mode,
+				struct object_id *a_oid, unsigned int a_mode,
+				struct object_id *b_oid, unsigned int b_mode,
+				struct rename_conflict_info *ci)
 {
 	/* Merge the content and write it out */
 	return merge_content(o, path, was_dirty(o, path),
@@ -2943,37 +2943,37 @@ static int process_entry(struct merge_options *o,
 		switch (conflict_info->rename_type) {
 		case RENAME_NORMAL:
 		case RENAME_ONE_FILE_TO_ONE:
-			clean_merge = conflict_rename_normal(o,
-							     path,
-							     o_oid, o_mode,
-							     a_oid, a_mode,
-							     b_oid, b_mode,
-							     conflict_info);
+			clean_merge = handle_rename_normal(o,
+							   path,
+							   o_oid, o_mode,
+							   a_oid, a_mode,
+							   b_oid, b_mode,
+							   conflict_info);
 			break;
 		case RENAME_VIA_DIR:
 			clean_merge = 1;
-			if (conflict_rename_via_dir(o,
-						    conflict_info->pair1,
-						    conflict_info->branch1,
-						    conflict_info->branch2))
+			if (handle_rename_via_dir(o,
+						  conflict_info->pair1,
+						  conflict_info->branch1,
+						  conflict_info->branch2))
 				clean_merge = -1;
 			break;
 		case RENAME_DELETE:
 			clean_merge = 0;
-			if (conflict_rename_delete(o,
-						   conflict_info->pair1,
-						   conflict_info->branch1,
-						   conflict_info->branch2))
+			if (handle_rename_delete(o,
+						 conflict_info->pair1,
+						 conflict_info->branch1,
+						 conflict_info->branch2))
 				clean_merge = -1;
 			break;
 		case RENAME_ONE_FILE_TO_TWO:
 			clean_merge = 0;
-			if (conflict_rename_rename_1to2(o, conflict_info))
+			if (handle_rename_rename_1to2(o, conflict_info))
 				clean_merge = -1;
 			break;
 		case RENAME_TWO_FILES_TO_ONE:
 			clean_merge = 0;
-			if (conflict_rename_rename_2to1(o, conflict_info))
+			if (handle_rename_rename_2to1(o, conflict_info))
 				clean_merge = -1;
 			break;
 		default:
@@ -3112,8 +3112,8 @@ int merge_trees(struct merge_options *o,
 		get_files_dirs(o, merge);
 
 		entries = get_unmerged();
-		clean = handle_renames(o, common, head, merge, entries,
-				       &re_info);
+		clean = detect_and_process_renames(o, common, head, merge,
+						   entries, &re_info);
 		record_df_conflict_files(o, entries);
 		if (clean < 0)
 			goto cleanup;
-- 
2.17.0.847.g20b8963732

