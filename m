Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA66B1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 17:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbeDSR6n (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 13:58:43 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:42128 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752507AbeDSR6g (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Apr 2018 13:58:36 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3JHw3B0014663;
        Thu, 19 Apr 2018 10:58:29 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hdry1au84-1;
        Thu, 19 Apr 2018 10:58:28 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 8572E22175BD;
        Thu, 19 Apr 2018 10:58:28 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 7CAB02CDE6F;
        Thu, 19 Apr 2018 10:58:28 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        torvalds@linux-foundation.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH v10 07/36] directory rename detection: more involved edge/corner testcases
Date:   Thu, 19 Apr 2018 10:57:54 -0700
Message-Id: <20180419175823.7946-8-newren@gmail.com>
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
 t/t6043-merge-rename-directories.sh | 396 ++++++++++++++++++++++++++++
 1 file changed, 396 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 9ae245a522..6db1439675 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -1516,4 +1516,400 @@ test_expect_success '6e-check: Add/add from one side' '
 #   side of history is the one doing the renaming.
 ###########################################################################
 
+
+###########################################################################
+# SECTION 7: More involved Edge/Corner cases
+#
+# The ruleset we have generated in the above sections seems to provide
+# well-defined merges.  But can we find edge/corner cases that either (a)
+# are harder for users to understand, or (b) have a resolution that is
+# non-intuitive or suboptimal?
+#
+# The testcases in this section dive into cases that I've tried to craft in
+# a way to find some that might be surprising to users or difficult for
+# them to understand (the next section will look at non-intuitive or
+# suboptimal merge results).  Some of the testcases are similar to ones
+# from past sections, but have been simplified to try to highlight error
+# messages using a "modified" path (due to the directory rename).  Are
+# users okay with these?
+#
+# In my opinion, testcases that are difficult to understand from this
+# section is due to difficulty in the testcase rather than the directory
+# renaming (similar to how t6042 and t6036 have difficult resolutions due
+# to the problem setup itself being complex).  And I don't think the
+# error messages are a problem.
+#
+# On the other hand, the testcases in section 8 worry me slightly more...
+###########################################################################
+
+# Testcase 7a, rename-dir vs. rename-dir (NOT split evenly) PLUS add-other-file
+#   Commit O: z/{b,c}
+#   Commit A: y/{b,c}
+#   Commit B: w/b, x/c, z/d
+#   Expected: y/d, CONFLICT(rename/rename for both z/b and z/c)
+#   NOTE: There's a rename of z/ here, y/ has more renames, so z/d -> y/d.
+
+test_expect_success '7a-setup: rename-dir vs. rename-dir (NOT split evenly) PLUS add-other-file' '
+	test_create_repo 7a &&
+	(
+		cd 7a &&
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
+		mkdir w &&
+		mkdir x &&
+		git mv z/b w/ &&
+		git mv z/c x/ &&
+		echo d > z/d &&
+		git add z/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '7a-check: rename-dir vs. rename-dir (NOT split evenly) PLUS add-other-file' '
+	(
+		cd 7a &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep "CONFLICT (rename/rename).*z/b.*y/b.*w/b" out &&
+		test_i18ngrep "CONFLICT (rename/rename).*z/c.*y/c.*x/c" out &&
+
+		git ls-files -s >out &&
+		test_line_count = 7 out &&
+		git ls-files -u >out &&
+		test_line_count = 6 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >actual \
+			:1:z/b :2:y/b :3:w/b :1:z/c :2:y/c :3:x/c :0:y/d &&
+		git rev-parse >expect \
+			 O:z/b  O:z/b  O:z/b  O:z/c  O:z/c  O:z/c  B:z/d &&
+		test_cmp expect actual &&
+
+		git hash-object >actual \
+			y/b   w/b   y/c   x/c &&
+		git rev-parse >expect \
+			O:z/b O:z/b O:z/c O:z/c &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 7b, rename/rename(2to1), but only due to transitive rename
+#   (Related to testcase 1d)
+#   Commit O: z/{b,c},     x/d_1, w/d_2
+#   Commit A: y/{b,c,d_2}, x/d_1
+#   Commit B: z/{b,c,d_1},        w/d_2
+#   Expected: y/{b,c}, CONFLICT(rename/rename(2to1): x/d_1, w/d_2 -> y_d)
+
+test_expect_success '7b-setup: rename/rename(2to1), but only due to transitive rename' '
+	test_create_repo 7b &&
+	(
+		cd 7b &&
+
+		mkdir z &&
+		mkdir x &&
+		mkdir w &&
+		echo b >z/b &&
+		echo c >z/c &&
+		echo d1 > x/d &&
+		echo d2 > w/d &&
+		git add z x w &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv z y &&
+		git mv w/d y/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv x/d z/ &&
+		rmdir x &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '7b-check: rename/rename(2to1), but only due to transitive rename' '
+	(
+		cd 7b &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep "CONFLICT (rename/rename)" out &&
+
+		git ls-files -s >out &&
+		test_line_count = 4 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+		git ls-files -o >out &&
+		test_line_count = 3 out &&
+
+		git rev-parse >actual \
+			:0:y/b :0:y/c :2:y/d :3:y/d &&
+		git rev-parse >expect \
+			 O:z/b  O:z/c  O:w/d  O:x/d &&
+		test_cmp expect actual &&
+
+		test_path_is_missing y/d &&
+		test_path_is_file y/d~HEAD &&
+		test_path_is_file y/d~B^0 &&
+
+		git hash-object >actual \
+			y/d~HEAD y/d~B^0 &&
+		git rev-parse >expect \
+			O:w/d    O:x/d &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 7c, rename/rename(1to...2or3); transitive rename may add complexity
+#   (Related to testcases 3b and 5c)
+#   Commit O: z/{b,c}, x/d
+#   Commit A: y/{b,c}, w/d
+#   Commit B: z/{b,c,d}
+#   Expected: y/{b,c}, CONFLICT(x/d -> w/d vs. y/d)
+#   NOTE: z/ was renamed to y/ so we do want to report
+#         neither CONFLICT(x/d -> w/d vs. z/d)
+#         nor CONFLiCT x/d -> w/d vs. y/d vs. z/d)
+
+test_expect_success '7c-setup: rename/rename(1to...2or3); transitive rename may add complexity' '
+	test_create_repo 7c &&
+	(
+		cd 7c &&
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
+		git mv z y &&
+		git mv x w &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv x/d z/ &&
+		rmdir x &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '7c-check: rename/rename(1to...2or3); transitive rename may add complexity' '
+	(
+		cd 7c &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep "CONFLICT (rename/rename).*x/d.*w/d.*y/d" out &&
+
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+		git ls-files -u >out &&
+		test_line_count = 3 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >actual \
+			:0:y/b :0:y/c :1:x/d :2:w/d :3:y/d &&
+		git rev-parse >expect \
+			 O:z/b  O:z/c  O:x/d  O:x/d  O:x/d &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 7d, transitive rename involved in rename/delete; how is it reported?
+#   (Related somewhat to testcases 5b and 8d)
+#   Commit O: z/{b,c}, x/d
+#   Commit A: y/{b,c}
+#   Commit B: z/{b,c,d}
+#   Expected: y/{b,c}, CONFLICT(delete x/d vs rename to y/d)
+#   NOTE: z->y so NOT CONFLICT(delete x/d vs rename to z/d)
+
+test_expect_success '7d-setup: transitive rename involved in rename/delete; how is it reported?' '
+	test_create_repo 7d &&
+	(
+		cd 7d &&
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
+		git mv z y &&
+		git rm -rf x &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv x/d z/ &&
+		rmdir x &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '7d-check: transitive rename involved in rename/delete; how is it reported?' '
+	(
+		cd 7d &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep "CONFLICT (rename/delete).*x/d.*y/d" out &&
+
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 1 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >actual \
+			:0:y/b :0:y/c :3:y/d &&
+		git rev-parse >expect \
+			 O:z/b  O:z/c  O:x/d &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 7e, transitive rename in rename/delete AND dirs in the way
+#   (Very similar to 'both rename source and destination involved in D/F conflict' from t6022-merge-rename.sh)
+#   (Also related to testcases 9c and 9d)
+#   Commit O: z/{b,c},     x/d_1
+#   Commit A: y/{b,c,d/g}, x/d/f
+#   Commit B: z/{b,c,d_1}
+#   Expected: rename/delete(x/d_1->y/d_1 vs. None) + D/F conflict on y/d
+#             y/{b,c,d/g}, y/d_1~B^0, x/d/f
+
+#   NOTE: The main path of interest here is d_1 and where it ends up, but
+#         this is actually a case that has two potential directory renames
+#         involved and D/F conflict(s), so it makes sense to walk through
+#         each step.
+#
+#         Commit A renames z/ -> y/.  Thus everything that B adds to z/
+#         should be instead moved to y/.  This gives us the D/F conflict on
+#         y/d because x/d_1 -> z/d_1 -> y/d_1 conflicts with y/d/g.
+#
+#         Further, commit B renames x/ -> z/, thus everything A adds to x/
+#         should instead be moved to z/...BUT we removed z/ and renamed it
+#         to y/, so maybe everything should move not from x/ to z/, but
+#         from x/ to z/ to y/.  Doing so might make sense from the logic so
+#         far, but note that commit A had both an x/ and a y/; it did the
+#         renaming of z/ to y/ and created x/d/f and it clearly made these
+#         things separate, so it doesn't make much sense to push these
+#         together.  Doing so is what I'd call a doubly transitive rename;
+#         see testcases 9c and 9d for further discussion of this issue and
+#         how it's resolved.
+
+test_expect_success '7e-setup: transitive rename in rename/delete AND dirs in the way' '
+	test_create_repo 7e &&
+	(
+		cd 7e &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		mkdir x &&
+		echo d1 >x/d &&
+		git add z x &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv z y &&
+		git rm x/d &&
+		mkdir -p x/d &&
+		mkdir -p y/d &&
+		echo f >x/d/f &&
+		echo g >y/d/g &&
+		git add x/d/f y/d/g &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv x/d z/ &&
+		rmdir x &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '7e-check: transitive rename in rename/delete AND dirs in the way' '
+	(
+		cd 7e &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep "CONFLICT (rename/delete).*x/d.*y/d" out &&
+
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+		git ls-files -u >out &&
+		test_line_count = 1 out &&
+		git ls-files -o >out &&
+		test_line_count = 2 out &&
+
+		git rev-parse >actual \
+			:0:x/d/f :0:y/d/g :0:y/b :0:y/c :3:y/d &&
+		git rev-parse >expect \
+			 A:x/d/f  A:y/d/g  O:z/b  O:z/c  O:x/d &&
+		test_cmp expect actual &&
+
+		git hash-object y/d~B^0 >actual &&
+		git rev-parse O:x/d >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.17.0.290.ge988e9ce2a

