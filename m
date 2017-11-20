Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8486202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbdKTWCp (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:02:45 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38072 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751497AbdKTWCP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2017 17:02:15 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAKLxBma020083;
        Mon, 20 Nov 2017 14:02:11 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2eakkpb8qx-1;
        Mon, 20 Nov 2017 14:02:11 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 74FF722F4180;
        Mon, 20 Nov 2017 14:02:10 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 61AE12CDEB1;
        Mon, 20 Nov 2017 14:02:10 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 32/33] merge-recursive: avoid spurious rename/rename conflict from dir renames
Date:   Mon, 20 Nov 2017 14:02:08 -0800
Message-Id: <20171120220209.15111-33-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.323.g31fe956618
In-Reply-To: <20171120220209.15111-1-newren@gmail.com>
References: <20171120220209.15111-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-20_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711200295
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a file on one side of history was renamed, and merely modified on the
other side, then applying a directory rename to the modified side gives us
a rename/rename(1to2) conflict.  We should only apply directory renames to
pairs representing either adds or renames.

Making this change means that a directory rename testcase that was
previously reported as a rename/delete conflict will now be reported as a
modify/delete conflict.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   |  4 +--
 t/t6043-merge-rename-directories.sh | 55 +++++++++++++++++--------------------
 2 files changed, 27 insertions(+), 32 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 6974717719..33d2b5e55e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1952,7 +1952,7 @@ static void compute_collisions(struct hashmap *collisions,
 		char *new_path;
 		struct diff_filepair *pair = pairs->queue[i];
 
-		if (pair->status == 'D')
+		if (pair->status == 'D' || pair->status == 'M')
 			continue;
 		dir_rename_ent = check_dir_renamed(pair->two->path,
 						   dir_renames);
@@ -2180,7 +2180,7 @@ static struct string_list *get_renames(struct merge_options *o,
 		struct diff_filepair *pair = pairs->queue[i];
 		char *new_path; /* non-NULL only with directory renames */
 
-		if (pair->status == 'D') {
+		if (pair->status == 'D' || pair->status == 'M') {
 			diff_free_filepair(pair);
 			continue;
 		}
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 224d266695..119d7f5d70 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -2000,18 +2000,23 @@ test_expect_success '8b-check: Dual-directory rename, one into the others way, w
 	)
 '
 
-# Testcase 8c, rename+modify/delete
-#   (Related to testcases 5b and 8d)
+# Testcase 8c, modify/delete or rename+modify/delete?
+#   (Related to testcases 5b, 8d, and 9h)
 #   Commit O: z/{b,c,d}
 #   Commit A: y/{b,c}
 #   Commit B: z/{b,c,d_modified,e}
-#   Expected: y/{b,c,e}, CONFLICT(rename+modify/delete: x/d -> y/d or deleted)
+#   Expected: y/{b,c,e}, CONFLICT(modify/delete: on z/d)
 #
-#   Note: This testcase doesn't present any concerns for me...until you
-#         compare it with testcases 5b and 8d.  See notes in 8d for more
-#         details.
-
-test_expect_success '8c-setup: rename+modify/delete' '
+#   Note: It could easily be argued that the correct resolution here is
+#         y/{b,c,e}, CONFLICT(rename/delete: z/d -> y/d vs deleted)
+#         and that the modifed version of d should be present in y/ after
+#         the merge, just marked as conflicted.  Indeed, I previously did
+#         argue that.  But applying directory renames to the side of
+#         history where a file is merely modified results in spurious
+#         rename/rename(1to2) conflicts -- see testcase 9h.  See also
+#         notes in 8d.
+
+test_expect_success '8c-setup: modify/delete or rename+modify/delete?' '
 	test_create_repo 8c &&
 	(
 		cd 8c &&
@@ -2044,29 +2049,29 @@ test_expect_success '8c-setup: rename+modify/delete' '
 	)
 '
 
-test_expect_success '8c-check: rename+modify/delete' '
+test_expect_success '8c-check: modify/delete or rename+modify/delete' '
 	(
 		cd 8c &&
 
 		git checkout A^0 &&
 
 		test_must_fail git merge -s recursive B^0 >out &&
-		test_i18ngrep "CONFLICT (rename/delete).* z/d.*y/d" out &&
+		test_i18ngrep "CONFLICT (modify/delete).* z/d" out &&
 
-		test 4 -eq $(git ls-files -s | wc -l) &&
-		test 1 -eq $(git ls-files -u | wc -l) &&
+		test 5 -eq $(git ls-files -s | wc -l) &&
+		test 2 -eq $(git ls-files -u | wc -l) &&
 		test 1 -eq $(git ls-files -o | wc -l) &&
 
 		git rev-parse >actual \
-			:0:y/b :0:y/c :0:y/e :3:y/d &&
+			:0:y/b :0:y/c :0:y/e :1:z/d :3:z/d &&
 		git rev-parse >expect \
-			O:z/b O:z/c B:z/e B:z/d &&
+			O:z/b O:z/c B:z/e O:z/d B:z/d &&
 		test_cmp expect actual &&
 
-		test_must_fail git rev-parse :1:y/d &&
-		test_must_fail git rev-parse :2:y/d &&
-		git ls-files -s y/d | grep ^100755 &&
-		test -f y/d
+		test_must_fail git rev-parse :2:z/d &&
+		git ls-files -s z/d | grep ^100755 &&
+		test -f z/d &&
+		! test -f y/d
 	)
 '
 
@@ -2080,16 +2085,6 @@ test_expect_success '8c-check: rename+modify/delete' '
 #
 #   Note: It would also be somewhat reasonable to resolve this as
 #             y/{b,c,e}, CONFLICT(rename/delete: x/d -> y/d or deleted)
-#   The logic being that the only difference between this testcase and 8c
-#   is that there is no modification to d.  That suggests that instead of a
-#   rename/modify vs. delete conflict, we should just have a rename/delete
-#   conflict, otherwise we are being inconsistent.
-#
-#   However...as far as consistency goes, we didn't report a conflict for
-#   path d_1 in testcase 5b due to a different file being in the way.  So,
-#   we seem to be forced to have cases where users can change things
-#   slightly and get what they may perceive as inconsistent results.  It
-#   would be nice to avoid that, but I'm not sure I see how.
 #
 #   In this case, I'm leaning towards: commit A was the one that deleted z/d
 #   and it did the rename of z to y, so the two "conflicts" (rename vs.
@@ -2802,7 +2797,7 @@ test_expect_success '9h-setup: Avoid dir rename on merely modified path' '
 	)
 '
 
-test_expect_failure '9h-check: Avoid dir rename on merely modified path' '
+test_expect_success '9h-check: Avoid dir rename on merely modified path' '
 	(
 		cd 9h &&
 
@@ -3783,7 +3778,7 @@ test_expect_success '12c-setup: Moving one directory hierarchy into another w/ c
 	)
 '
 
-test_expect_failure '12c-check: Moving one directory hierarchy into another w/ content merge' '
+test_expect_success '12c-check: Moving one directory hierarchy into another w/ content merge' '
 	(
 		cd 12c &&
 
-- 
2.15.0.309.g00c152f825

