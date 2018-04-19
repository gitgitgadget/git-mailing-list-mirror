Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6974C1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 18:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753150AbeDSR64 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 13:58:56 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:42144 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752829AbeDSR6i (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Apr 2018 13:58:38 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3JHw4P5014666;
        Thu, 19 Apr 2018 10:58:31 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hdry1au8c-1;
        Thu, 19 Apr 2018 10:58:30 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 6574222175C7;
        Thu, 19 Apr 2018 10:58:29 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 5ED942CDEF0;
        Thu, 19 Apr 2018 10:58:29 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        torvalds@linux-foundation.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH v10 28/36] merge-recursive: avoid spurious rename/rename conflict from dir renames
Date:   Thu, 19 Apr 2018 10:58:15 -0700
Message-Id: <20180419175823.7946-29-newren@gmail.com>
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
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804190157
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

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c                   |  4 +--
 t/t6043-merge-rename-directories.sh | 55 +++++++++++++----------------
 2 files changed, 27 insertions(+), 32 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 238711b038..27278d51bb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1992,7 +1992,7 @@ static void compute_collisions(struct hashmap *collisions,
 		char *new_path;
 		struct diff_filepair *pair = pairs->queue[i];
 
-		if (pair->status == 'D')
+		if (pair->status != 'A' && pair->status != 'R')
 			continue;
 		dir_rename_ent = check_dir_renamed(pair->two->path,
 						   dir_renames);
@@ -2219,7 +2219,7 @@ static struct string_list *get_renames(struct merge_options *o,
 		struct diff_filepair *pair = pairs->queue[i];
 		char *new_path; /* non-NULL only with directory renames */
 
-		if (pair->status == 'D') {
+		if (pair->status != 'A' && pair->status != 'R') {
 			diff_free_filepair(pair);
 			continue;
 		}
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 5b84591445..45f620633f 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -2078,18 +2078,23 @@ test_expect_success '8b-check: Dual-directory rename, one into the others way, w
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
@@ -2122,32 +2127,32 @@ test_expect_success '8c-setup: rename+modify/delete' '
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
 
 		git ls-files -s >out &&
-		test_line_count = 4 out &&
+		test_line_count = 5 out &&
 		git ls-files -u >out &&
-		test_line_count = 1 out &&
+		test_line_count = 2 out &&
 		git ls-files -o >out &&
 		test_line_count = 1 out &&
 
 		git rev-parse >actual \
-			:0:y/b :0:y/c :0:y/e :3:y/d &&
+			:0:y/b :0:y/c :0:y/e :1:z/d :3:z/d &&
 		git rev-parse >expect \
-			 O:z/b  O:z/c  B:z/e  B:z/d &&
+			 O:z/b  O:z/c  B:z/e  O:z/d  B:z/d &&
 		test_cmp expect actual &&
 
-		test_must_fail git rev-parse :1:y/d &&
-		test_must_fail git rev-parse :2:y/d &&
-		git ls-files -s y/d | grep ^100755 &&
-		test_path_is_file y/d
+		test_must_fail git rev-parse :2:z/d &&
+		git ls-files -s z/d | grep ^100755 &&
+		test_path_is_file z/d &&
+		test_path_is_missing y/d
 	)
 '
 
@@ -2161,16 +2166,6 @@ test_expect_success '8c-check: rename+modify/delete' '
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
@@ -2915,7 +2910,7 @@ test_expect_success '9h-setup: Avoid dir rename on merely modified path' '
 	)
 '
 
-test_expect_failure '9h-check: Avoid dir rename on merely modified path' '
+test_expect_success '9h-check: Avoid dir rename on merely modified path' '
 	(
 		cd 9h &&
 
@@ -3959,7 +3954,7 @@ test_expect_success '12c-setup: Moving one directory hierarchy into another w/ c
 	)
 '
 
-test_expect_failure '12c-check: Moving one directory hierarchy into another w/ content merge' '
+test_expect_success '12c-check: Moving one directory hierarchy into another w/ content merge' '
 	(
 		cd 12c &&
 
-- 
2.17.0.290.ge988e9ce2a

