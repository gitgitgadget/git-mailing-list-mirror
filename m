Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17521202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751146AbdKTWCU (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:02:20 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38062 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751454AbdKTWCP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2017 17:02:15 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAKLxBmZ020083;
        Mon, 20 Nov 2017 14:02:10 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2eakkpb8qk-3;
        Mon, 20 Nov 2017 14:02:10 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 5781522F41AC;
        Mon, 20 Nov 2017 14:02:10 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 4E48B2CDEC1;
        Mon, 20 Nov 2017 14:02:10 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 30/33] merge-recursive: fix remaining directory rename + dirty overwrite cases
Date:   Mon, 20 Nov 2017 14:02:06 -0800
Message-Id: <20171120220209.15111-31-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.323.g31fe956618
In-Reply-To: <20171120220209.15111-1-newren@gmail.com>
References: <20171120220209.15111-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-20_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711200295
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 26 +++++++++++++++++++++++---
 t/t6043-merge-rename-directories.sh |  8 ++++----
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 828861803c..6974717719 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1311,11 +1311,23 @@ static int handle_file(struct merge_options *o,
 
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
+		 * Stupid double negatives in remove_file; it somehow manages
+		 * to repeatedly mess me up.  So, just for myself:
+		 *    1) update_wd iff !ren_src_was_dirty.
+		 *    2) no_wd iff !update_wd
+		 *    3) so, no_wd == !!ren_src_was_dirty == ren_src_was_dirty
+		 */
+		remove_file(o, 0, rename->path, ren_src_was_dirty);
 		dst_name = unique_path(o, rename->path, cur_branch);
 	} else {
 		if (dir_in_way(rename->path, !o->call_depth, 0)) {
@@ -1453,7 +1465,10 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
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
@@ -2035,6 +2050,7 @@ static void apply_directory_rename_modifications(struct merge_options *o,
 {
 	struct string_list_item *item;
 	int stage = (tree == a_tree ? 2 : 3);
+	int update_wd;
 
 	/*
 	 * In all cases where we can do directory rename detection,
@@ -2045,7 +2061,11 @@ static void apply_directory_rename_modifications(struct merge_options *o,
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
index 8c2faeb342..e48d5443c5 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -3222,7 +3222,7 @@ test_expect_success '11b-setup: Avoid losing dirty file involved in directory re
 	)
 '
 
-test_expect_failure '11b-check: Avoid losing dirty file involved in directory rename' '
+test_expect_success '11b-check: Avoid losing dirty file involved in directory rename' '
 	(
 		cd 11b &&
 
@@ -3356,7 +3356,7 @@ test_expect_success '11d-setup: Avoid losing not-uptodate with rename + D/F conf
 	)
 '
 
-test_expect_failure '11d-check: Avoid losing not-uptodate with rename + D/F conflict' '
+test_expect_success '11d-check: Avoid losing not-uptodate with rename + D/F conflict' '
 	(
 		cd 11d &&
 
@@ -3430,7 +3430,7 @@ test_expect_success '11e-setup: Avoid deleting not-uptodate with dir rename/rena
 	)
 '
 
-test_expect_failure '11e-check: Avoid deleting not-uptodate with dir rename/rename(1to2)/add' '
+test_expect_success '11e-check: Avoid deleting not-uptodate with dir rename/rename(1to2)/add' '
 	(
 		cd 11e &&
 
@@ -3504,7 +3504,7 @@ test_expect_success '11f-setup: Avoid deleting not-uptodate with dir rename/rena
 	)
 '
 
-test_expect_failure '11f-check: Avoid deleting not-uptodate with dir rename/rename(2to1)' '
+test_expect_success '11f-check: Avoid deleting not-uptodate with dir rename/rename(2to1)' '
 	(
 		cd 11f &&
 
-- 
2.15.0.309.g00c152f825

