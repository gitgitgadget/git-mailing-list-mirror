Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1035F1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 16:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732192AbeISVxQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 17:53:16 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:51604 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732152AbeISVxP (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 Sep 2018 17:53:15 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8JGEYo6016664;
        Wed, 19 Sep 2018 09:14:38 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2mgyxh7en8-1;
        Wed, 19 Sep 2018 09:14:38 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 1CA8C228A055;
        Wed, 19 Sep 2018 09:14:38 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 4/4] merge-recursive: rename merge_file_1() and merge_content()
Date:   Wed, 19 Sep 2018 09:14:34 -0700
Message-Id: <20180919161434.3272-5-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.12.gc6760fd9a9
In-Reply-To: <20180919161434.3272-1-newren@gmail.com>
References: <20180919161434.3272-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809190158
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Summary:
  merge_file_1()  -> merge_mode_and_contents()
  merge_content() -> handle_content_merge()

merge_file_1() is a very unhelpful name.  Rename it to
merge_mode_and_contents() to reflect what it does.

merge_content() calls merge_mode_and_contents() to do the main part of
its work, but most of this function was about higher level stuff, e.g.
printing out conflict messages, updating skip_worktree bits, checking
for ability to avoid updating the working tree or for D/F conflicts
being in the way, etc.  Since there are several handle_*() functions for
similar levels of checking and handling in merge-recursive.c (e.g.
handle_change_delete(), handle_rename_rename_2to1()), let's rename this
function to handle_content_merge().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 66 ++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 2654a8a485..5206d6cfb6 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1274,14 +1274,14 @@ static int merge_submodule(struct merge_options *o,
 	return 0;
 }
 
-static int merge_file_1(struct merge_options *o,
-			const struct diff_filespec *one,
-			const struct diff_filespec *a,
-			const struct diff_filespec *b,
-			const char *filename,
-			const char *branch1,
-			const char *branch2,
-			struct merge_file_info *result)
+static int merge_mode_and_contents(struct merge_options *o,
+				   const struct diff_filespec *one,
+				   const struct diff_filespec *a,
+				   const struct diff_filespec *b,
+				   const char *filename,
+				   const char *branch1,
+				   const char *branch2,
+				   struct merge_file_info *result)
 {
 	result->merge = 0;
 	result->clean = 1;
@@ -1609,8 +1609,8 @@ static int handle_rename_rename_1to2(struct merge_options *o,
 		struct merge_file_info mfi;
 		struct diff_filespec other;
 		struct diff_filespec *add;
-		if (merge_file_1(o, one, a, b, one->path,
-				 ci->branch1, ci->branch2, &mfi))
+		if (merge_mode_and_contents(o, one, a, b, one->path,
+					    ci->branch1, ci->branch2, &mfi))
 			return -1;
 
 		/*
@@ -1676,10 +1676,10 @@ static int handle_rename_rename_2to1(struct merge_options *o,
 
 	path_side_1_desc = xstrfmt("%s (was %s)", path, a->path);
 	path_side_2_desc = xstrfmt("%s (was %s)", path, b->path);
-	if (merge_file_1(o, a, c1, &ci->ren1_other, path_side_1_desc,
-			 o->branch1, o->branch2, &mfi_c1) ||
-	    merge_file_1(o, b, &ci->ren2_other, c2, path_side_2_desc,
-			 o->branch1, o->branch2, &mfi_c2))
+	if (merge_mode_and_contents(o, a, c1, &ci->ren1_other, path_side_1_desc,
+				    o->branch1, o->branch2, &mfi_c1) ||
+	    merge_mode_and_contents(o, b, &ci->ren2_other, c2, path_side_2_desc,
+				    o->branch1, o->branch2, &mfi_c2))
 		return -1;
 	free(path_side_1_desc);
 	free(path_side_2_desc);
@@ -2723,9 +2723,9 @@ static int process_renames(struct merge_options *o,
 					b.mode = dst_other.mode;
 					b.path = one.path;
 
-					if (merge_file_1(o, &one, &a, &b, ren1_dst,
-							 branch1, branch2,
-							 &mfi)) {
+					if (merge_mode_and_contents(o, &one, &a, &b, ren1_dst,
+								    branch1, branch2,
+								    &mfi)) {
 						clean_merge = -1;
 						goto cleanup_and_return;
 					}
@@ -2975,13 +2975,13 @@ static int handle_modify_delete(struct merge_options *o,
 				    _("modify"), _("modified"));
 }
 
-static int merge_content(struct merge_options *o,
-			 const char *path,
-			 int is_dirty,
-			 struct object_id *o_oid, int o_mode,
-			 struct object_id *a_oid, int a_mode,
-			 struct object_id *b_oid, int b_mode,
-			 struct rename_conflict_info *rename_conflict_info)
+static int handle_content_merge(struct merge_options *o,
+				const char *path,
+				int is_dirty,
+				struct object_id *o_oid, int o_mode,
+				struct object_id *a_oid, int a_mode,
+				struct object_id *b_oid, int b_mode,
+				struct rename_conflict_info *rename_conflict_info)
 {
 	const char *reason = _("content");
 	const char *path1 = NULL, *path2 = NULL;
@@ -3021,8 +3021,8 @@ static int merge_content(struct merge_options *o,
 			       S_ISGITLINK(pair1->two->mode)))
 			df_conflict_remains = 1;
 	}
-	if (merge_file_1(o, &one, &a, &b, path,
-			 o->branch1, o->branch2, &mfi))
+	if (merge_mode_and_contents(o, &one, &a, &b, path,
+				    o->branch1, o->branch2, &mfi))
 		return -1;
 
 	/*
@@ -3113,9 +3113,9 @@ static int handle_rename_normal(struct merge_options *o,
 				struct rename_conflict_info *ci)
 {
 	/* Merge the content and write it out */
-	return merge_content(o, path, was_dirty(o, path),
-			     o_oid, o_mode, a_oid, a_mode, b_oid, b_mode,
-			     ci);
+	return handle_content_merge(o, path, was_dirty(o, path),
+				    o_oid, o_mode, a_oid, a_mode, b_oid, b_mode,
+				    ci);
 }
 
 /* Per entry merge function */
@@ -3239,9 +3239,11 @@ static int process_entry(struct merge_options *o,
 		/* Case C: Added in both (check for same permissions) and */
 		/* case D: Modified in both, but differently. */
 		int is_dirty = 0; /* unpack_trees would have bailed if dirty */
-		clean_merge = merge_content(o, path, is_dirty,
-					    o_oid, o_mode, a_oid, a_mode, b_oid, b_mode,
-					    NULL);
+		clean_merge = handle_content_merge(o, path, is_dirty,
+						   o_oid, o_mode,
+						   a_oid, a_mode,
+						   b_oid, b_mode,
+						   NULL);
 	} else if (!o_oid && !a_oid && !b_oid) {
 		/*
 		 * this entry was deleted altogether. a_mode == 0 means
-- 
2.19.0.12.gc6760fd9a9

