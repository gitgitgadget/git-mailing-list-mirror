Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDD9D202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbdKTWEf (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:04:35 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38028 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751344AbdKTWCN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2017 17:02:13 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAKLxBmX020083;
        Mon, 20 Nov 2017 14:02:10 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2eakkpb8qk-1;
        Mon, 20 Nov 2017 14:02:09 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id A7E2922F41A9;
        Mon, 20 Nov 2017 14:02:09 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 9D15C2CDEB1;
        Mon, 20 Nov 2017 14:02:09 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 09/33] directory rename detection: testcases checking which side did the rename
Date:   Mon, 20 Nov 2017 14:01:45 -0800
Message-Id: <20171120220209.15111-10-newren@gmail.com>
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
 t/t6043-merge-rename-directories.sh | 321 ++++++++++++++++++++++++++++++++++++
 1 file changed, 321 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 29b2af7f19..5db2986de8 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -1138,4 +1138,325 @@ test_expect_failure '5d-check: Directory/file/file conflict due to directory ren
 #   back to old handling.  But, sadly, see testcases 8a and 8b.
 ###########################################################################
 
+
+###########################################################################
+# SECTION 6: Same side of the merge was the one that did the rename
+#
+# It may sound obvious that you only want to apply implicit directory
+# renames to directories if the _other_ side of history did the renaming.
+# If you did make an implementation that didn't explicitly enforce this
+# rule, the majority of cases that would fall under this section would
+# also be solved by following the rules from the above sections.  But
+# there are still a few that stick out, so this section covers them just
+# to make sure we also get them right.
+###########################################################################
+
+# Testcase 6a, Tricky rename/delete
+#   Commit O: z/{b,c,d}
+#   Commit A: z/b
+#   Commit B: y/{b,c}, z/d
+#   Expected: y/b, CONFLICT(rename/delete, z/c -> y/c vs. NULL)
+#   Note: We're just checking here that the rename of z/b and z/c to put
+#         them under y/ doesn't accidentally catch z/d and make it look like
+#         it is also involved in a rename/delete conflict.
+
+test_expect_success '6a-setup: Tricky rename/delete' '
+	test_create_repo 6a &&
+	(
+		cd 6a &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		echo d >z/d &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git rm z/c &&
+		git rm z/d &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		mkdir y &&
+		git mv z/b y/ &&
+		git mv z/c y/ &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '6a-check: Tricky rename/delete' '
+	(
+		cd 6a &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep "CONFLICT (rename/delete).*z/c.*y/c" out &&
+
+		test 2 -eq $(git ls-files -s | wc -l) &&
+		test 1 -eq $(git ls-files -u | wc -l) &&
+		test 1 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			:0:y/b :3:y/c &&
+		git rev-parse >expect \
+			O:z/b O:z/c &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 6b, Same rename done on both sides
+#   (Related to testcases 6c and 8e)
+#   Commit O: z/{b,c}
+#   Commit A: y/{b,c}
+#   Commit B: y/{b,c}, z/d
+#   Expected: y/{b,c}, z/d
+#   Note: If we did directory rename detection here, we'd move z/d into y/,
+#         but B did that rename and still decided to put the file into z/,
+#         so we probably shouldn't apply directory rename detection for it.
+
+test_expect_success '6b-setup: Same rename done on both sides' '
+	test_create_repo 6b &&
+	(
+		cd 6b &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv z y &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv z y &&
+		mkdir z &&
+		echo d >z/d &&
+		git add z/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '6b-check: Same rename done on both sides' '
+	(
+		cd 6b &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 3 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:z/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:z/d &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 6c, Rename only done on same side
+#   (Related to testcases 6b and 8e)
+#   Commit O: z/{b,c}
+#   Commit A: z/{b,c} (no change)
+#   Commit B: y/{b,c}, z/d
+#   Expected: y/{b,c}, z/d
+#   NOTE: Seems obvious, but just checking that the implementation doesn't
+#         "accidentally detect a rename" and give us y/{b,c,d}.
+
+test_expect_success '6c-setup: Rename only done on same side' '
+	test_create_repo 6c &&
+	(
+		cd 6c &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		test_tick &&
+		git commit --allow-empty -m "A" &&
+
+		git checkout B &&
+		git mv z y &&
+		mkdir z &&
+		echo d >z/d &&
+		git add z/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '6c-check: Rename only done on same side' '
+	(
+		cd 6c &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 3 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:z/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:z/d &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 6d, We don't always want transitive renaming
+#   (Related to testcase 1c)
+#   Commit O: z/{b,c}, x/d
+#   Commit A: z/{b,c}, x/d (no change)
+#   Commit B: y/{b,c}, z/d
+#   Expected: y/{b,c}, z/d
+#   NOTE: Again, this seems obvious but just checking that the implementation
+#         doesn't "accidentally detect a rename" and give us y/{b,c,d}.
+
+test_expect_success '6d-setup: We do not always want transitive renaming' '
+	test_create_repo 6d &&
+	(
+		cd 6d &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		mkdir x &&
+		echo d >x/d &&
+		git add z x &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		test_tick &&
+		git commit --allow-empty -m "A" &&
+
+		git checkout B &&
+		git mv z y &&
+		git mv x z &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '6d-check: We do not always want transitive renaming' '
+	(
+		cd 6d &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 3 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:z/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c O:x/d &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 6e, Add/add from one-side
+#   Commit O: z/{b,c}
+#   Commit A: z/{b,c} (no change)
+#   Commit B: y/{b,c,d_1}, z/d_2
+#   Expected: y/{b,c,d_1}, z/d_2
+#   NOTE: Again, this seems obvious but just checking that the implementation
+#         doesn't "accidentally detect a rename" and give us y/{b,c} +
+#         add/add conflict on y/d_1 vs y/d_2.
+
+test_expect_success '6e-setup: Add/add from one side' '
+	test_create_repo 6e &&
+	(
+		cd 6e &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		test_tick &&
+		git commit --allow-empty -m "A" &&
+
+		git checkout B &&
+		git mv z y &&
+		echo d1 > y/d &&
+		mkdir z &&
+		echo d2 > z/d &&
+		git add y/d z/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '6e-check: Add/add from one side' '
+	(
+		cd 6e &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 4 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:y/d HEAD:z/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:y/d B:z/d &&
+		test_cmp expect actual
+	)
+'
+
+###########################################################################
+# Rules suggested by section 6:
+#
+#   Only apply implicit directory renames to directories if the other
+#   side of history is the one doing the renaming.
+###########################################################################
+
 test_done
-- 
2.15.0.309.g00c152f825

