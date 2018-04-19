Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D2151F404
	for <e@80x24.org>; Thu, 19 Apr 2018 17:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752903AbeDSR6m (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 13:58:42 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:42130 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752511AbeDSR6g (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Apr 2018 13:58:36 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3JHw6il014678;
        Thu, 19 Apr 2018 10:58:30 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hdry1au8b-1;
        Thu, 19 Apr 2018 10:58:30 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 540AA22175B9;
        Thu, 19 Apr 2018 10:58:29 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 4DDA72CDEED;
        Thu, 19 Apr 2018 10:58:29 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        torvalds@linux-foundation.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH v10 26/36] merge-recursive: fix remaining directory rename + dirty overwrite cases
Date:   Thu, 19 Apr 2018 10:58:13 -0700
Message-Id: <20180419175823.7946-27-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.290.ge988e9ce2a
In-Reply-To: <20180419175823.7946-1-newren@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804190157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c                   | 25 ++++++++++++++++++++++---
 t/t6043-merge-rename-directories.sh |  8 ++++----
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 7fdcba4f22..238711b038 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1324,11 +1324,22 @@ static int handle_file(struct merge_options *o,
 
 	add = filespec_from_entry(&other, dst_entry, stage ^ 1);
 	if (add) {
+		int ren_src_was_dirty = was_dirty(o, rename->path);
 		char *add_name = unique_path(o, rename->path, other_branch);
 		if (update_file(o, 0, &add->oid, add->mode, add_name))
 			return -1;
 
-		remove_file(o, 0, rename->path, 0);
+		if (ren_src_was_dirty) {
+			output(o, 1, _("Refusing to lose dirty file at %s"),
+			       rename->path);
+		}
+		/*
+		 * Because the double negatives somehow keep confusing me...
+		 *    1) update_wd iff !ren_src_was_dirty.
+		 *    2) no_wd iff !update_wd
+		 *    3) so, no_wd == !!ren_src_was_dirty == ren_src_was_dirty
+		 */
+		remove_file(o, 0, rename->path, ren_src_was_dirty);
 		dst_name = unique_path(o, rename->path, cur_branch);
 	} else {
 		if (dir_in_way(rename->path, !o->call_depth, 0)) {
@@ -1466,7 +1477,10 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
 		char *new_path2 = unique_path(o, path, ci->branch2);
 		output(o, 1, _("Renaming %s to %s and %s to %s instead"),
 		       a->path, new_path1, b->path, new_path2);
-		if (would_lose_untracked(path))
+		if (was_dirty(o, path))
+			output(o, 1, _("Refusing to lose dirty file at %s"),
+			       path);
+		else if (would_lose_untracked(path))
 			/*
 			 * Only way we get here is if both renames were from
 			 * a directory rename AND user had an untracked file
@@ -2075,6 +2089,7 @@ static void apply_directory_rename_modifications(struct merge_options *o,
 {
 	struct string_list_item *item;
 	int stage = (tree == a_tree ? 2 : 3);
+	int update_wd;
 
 	/*
 	 * In all cases where we can do directory rename detection,
@@ -2085,7 +2100,11 @@ static void apply_directory_rename_modifications(struct merge_options *o,
 	 * saying the file would have been overwritten), but it might
 	 * be dirty, though.
 	 */
-	remove_file(o, 1, pair->two->path, 0 /* no_wd */);
+	update_wd = !was_dirty(o, pair->two->path);
+	if (!update_wd)
+		output(o, 1, _("Refusing to lose dirty file at %s"),
+		       pair->two->path);
+	remove_file(o, 1, pair->two->path, !update_wd);
 
 	/* Find or create a new re->dst_entry */
 	item = string_list_lookup(entries, new_path);
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index b94ba066fe..33e2649824 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -3370,7 +3370,7 @@ test_expect_success '11b-setup: Avoid losing dirty file involved in directory re
 	)
 '
 
-test_expect_failure '11b-check: Avoid losing dirty file involved in directory rename' '
+test_expect_success '11b-check: Avoid losing dirty file involved in directory rename' '
 	(
 		cd 11b &&
 
@@ -3512,7 +3512,7 @@ test_expect_success '11d-setup: Avoid losing not-uptodate with rename + D/F conf
 	)
 '
 
-test_expect_failure '11d-check: Avoid losing not-uptodate with rename + D/F conflict' '
+test_expect_success '11d-check: Avoid losing not-uptodate with rename + D/F conflict' '
 	(
 		cd 11d &&
 
@@ -3591,7 +3591,7 @@ test_expect_success '11e-setup: Avoid deleting not-uptodate with dir rename/rena
 	)
 '
 
-test_expect_failure '11e-check: Avoid deleting not-uptodate with dir rename/rename(1to2)/add' '
+test_expect_success '11e-check: Avoid deleting not-uptodate with dir rename/rename(1to2)/add' '
 	(
 		cd 11e &&
 
@@ -3667,7 +3667,7 @@ test_expect_success '11f-setup: Avoid deleting not-uptodate with dir rename/rena
 	)
 '
 
-test_expect_failure '11f-check: Avoid deleting not-uptodate with dir rename/rename(2to1)' '
+test_expect_success '11f-check: Avoid deleting not-uptodate with dir rename/rename(2to1)' '
 	(
 		cd 11f &&
 
-- 
2.17.0.290.ge988e9ce2a

