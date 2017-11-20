Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56411202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbdKTWCq (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:02:46 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:58180 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751253AbdKTWCP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2017 17:02:15 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAKLw4MY028709;
        Mon, 20 Nov 2017 14:02:10 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2eajmr3cpf-1;
        Mon, 20 Nov 2017 14:02:09 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id AF77B22F41AB;
        Mon, 20 Nov 2017 14:02:09 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id A938E2CDE75;
        Mon, 20 Nov 2017 14:02:09 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 11/33] directory rename detection: testcases exploring possibly suboptimal merges
Date:   Mon, 20 Nov 2017 14:01:47 -0800
Message-Id: <20171120220209.15111-12-newren@gmail.com>
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
 t/t6043-merge-rename-directories.sh | 392 ++++++++++++++++++++++++++++++++++++
 1 file changed, 392 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 2c57a02c6d..b153468a5c 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -1840,4 +1840,396 @@ test_expect_failure '7e-check: transitive rename in rename/delete AND dirs in th
 	)
 '
 
+###########################################################################
+# SECTION 8: Suboptimal merges
+#
+# As alluded to in the last section, the ruleset we have built up for
+# detecting directory renames unfortunately has some special cases where it
+# results in slightly suboptimal or non-intuitive behavior.  This section
+# explores these cases.
+#
+# To be fair, we already had non-intuitive or suboptimal behavior for most
+# of these cases in git before introducing implicit directory rename
+# detection, but it'd be nice if there was a modified ruleset out there
+# that handled these cases a bit better.
+###########################################################################
+
+# Testcase 8a, Dual-directory rename, one into the others' way
+#   Commit O. x/{a,b},   y/{c,d}
+#   Commit A. x/{a,b,e}, y/{c,d,f}
+#   Commit B. y/{a,b},   z/{c,d}
+#
+# Possible Resolutions:
+#   w/o dir-rename detection: y/{a,b,f},   z/{c,d},   x/e
+#   Currently expected:       y/{a,b,e,f}, z/{c,d}
+#   Optimal:                  y/{a,b,e},   z/{c,d,f}
+#
+# Note: Both x and y got renamed and it'd be nice to detect both, and we do
+# better with directory rename detection than git did previously, but the
+# simple rule from section 5 prevents me from handling this as optimally as
+# we potentially could.
+
+test_expect_success '8a-setup: Dual-directory rename, one into the others way' '
+	test_create_repo 8a &&
+	(
+		cd 8a &&
+
+		mkdir x &&
+		mkdir y &&
+		echo a >x/a &&
+		echo b >x/b &&
+		echo c >y/c &&
+		echo d >y/d &&
+		git add x y &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		echo e >x/e &&
+		echo f >y/f &&
+		git add x/e y/f &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv y z &&
+		git mv x y &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '8a-check: Dual-directory rename, one into the others way' '
+	(
+		cd 8a &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 6 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/a HEAD:y/b HEAD:y/e HEAD:y/f HEAD:z/c HEAD:z/d &&
+		git rev-parse >expect \
+			O:x/a O:x/b A:x/e A:y/f O:y/c O:y/d &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 8b, Dual-directory rename, one into the others' way, with conflicting filenames
+#   Commit O. x/{a_1,b_1},     y/{a_2,b_2}
+#   Commit A. x/{a_1,b_1,e_1}, y/{a_2,b_2,e_2}
+#   Commit B. y/{a_1,b_1},     z/{a_2,b_2}
+#
+#   w/o dir-rename detection: y/{a_1,b_1,e_2}, z/{a_2,b_2}, x/e_1
+#   Currently expected:       <same>
+#   Scary:                    y/{a_1,b_1},     z/{a_2,b_2}, CONFLICT(add/add, e_1 vs. e_2)
+#   Optimal:                  y/{a_1,b_1,e_1}, z/{a_2,b_2,e_2}
+#
+# Note: Very similar to 8a, except instead of 'e' and 'f' in directories x and
+# y, both are named 'e'.  Without directory rename detection, neither file
+# moves directories.  Implement directory rename detection suboptimally, and
+# you get an add/add conflict, but both files were added in commit A, so this
+# is an add/add conflict where one side of history added both files --
+# something we can't represent in the index.  Obviously, we'd prefer the last
+# resolution, but our previous rules are too coarse to allow it.  Using both
+# the rules from section 4 and section 5 save us from the Scary resolution,
+# making us fall back to pre-directory-rename-detection behavior for both
+# e_1 and e_2.
+
+test_expect_success '8b-setup: Dual-directory rename, one into the others way, with conflicting filenames' '
+	test_create_repo 8b &&
+	(
+		cd 8b &&
+
+		mkdir x &&
+		mkdir y &&
+		echo a1 >x/a &&
+		echo b1 >x/b &&
+		echo a2 >y/a &&
+		echo b2 >y/b &&
+		git add x y &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		echo e1 >x/e &&
+		echo e2 >y/e &&
+		git add x/e y/e &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv y z &&
+		git mv x y &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '8b-check: Dual-directory rename, one into the others way, with conflicting filenames' '
+	(
+		cd 8b &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 6 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/a HEAD:y/b HEAD:z/a HEAD:z/b HEAD:x/e HEAD:y/e &&
+		git rev-parse >expect \
+			O:x/a O:x/b O:y/a O:y/b A:x/e A:y/e &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 8c, rename+modify/delete
+#   (Related to testcases 5b and 8d)
+#   Commit O: z/{b,c,d}
+#   Commit A: y/{b,c}
+#   Commit B: z/{b,c,d_modified,e}
+#   Expected: y/{b,c,e}, CONFLICT(rename+modify/delete: x/d -> y/d or deleted)
+#
+#   Note: This testcase doesn't present any concerns for me...until you
+#         compare it with testcases 5b and 8d.  See notes in 8d for more
+#         details.
+
+test_expect_success '8c-setup: rename+modify/delete' '
+	test_create_repo 8c &&
+	(
+		cd 8c &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		test_seq 1 10 >z/d &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git rm z/d &&
+		git mv z y &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo 11 >z/d &&
+		test_chmod +x z/d &&
+		echo e >z/e &&
+		git add z/d z/e &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '8c-check: rename+modify/delete' '
+	(
+		cd 8c &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep "CONFLICT (rename/delete).* z/d.*y/d" out &&
+
+		test 4 -eq $(git ls-files -s | wc -l) &&
+		test 1 -eq $(git ls-files -u | wc -l) &&
+		test 1 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			:0:y/b :0:y/c :0:y/e :3:y/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:z/e B:z/d &&
+		test_cmp expect actual &&
+
+		test_must_fail git rev-parse :1:y/d &&
+		test_must_fail git rev-parse :2:y/d &&
+		git ls-files -s y/d | grep ^100755 &&
+		test -f y/d
+	)
+'
+
+# Testcase 8d, rename/delete...or not?
+#   (Related to testcase 5b; these may appear slightly inconsistent to users;
+#    Also related to testcases 7d and 7e)
+#   Commit O: z/{b,c,d}
+#   Commit A: y/{b,c}
+#   Commit B: z/{b,c,d,e}
+#   Expected: y/{b,c,e}
+#
+#   Note: It would also be somewhat reasonable to resolve this as
+#             y/{b,c,e}, CONFLICT(rename/delete: x/d -> y/d or deleted)
+#   The logic being that the only difference between this testcase and 8c
+#   is that there is no modification to d.  That suggests that instead of a
+#   rename/modify vs. delete conflict, we should just have a rename/delete
+#   conflict, otherwise we are being inconsistent.
+#
+#   However...as far as consistency goes, we didn't report a conflict for
+#   path d_1 in testcase 5b due to a different file being in the way.  So,
+#   we seem to be forced to have cases where users can change things
+#   slightly and get what they may perceive as inconsistent results.  It
+#   would be nice to avoid that, but I'm not sure I see how.
+#
+#   In this case, I'm leaning towards: commit A was the one that deleted z/d
+#   and it did the rename of z to y, so the two "conflicts" (rename vs.
+#   delete) are both coming from commit A, which is illogical.  Conflicts
+#   during merging are supposed to be about opposite sides doing things
+#   differently.
+
+test_expect_success '8d-setup: rename/delete...or not?' '
+	test_create_repo 8d &&
+	(
+		cd 8d &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		test_seq 1 10 >z/d &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git rm z/d &&
+		git mv z y &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo e >z/e &&
+		git add z/e &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '8d-check: rename/delete...or not?' '
+	(
+		cd 8d &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 3 -eq $(git ls-files -s | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:y/e &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:z/e &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 8e, Both sides rename, one side adds to original directory
+#   Commit O: z/{b,c}
+#   Commit A: y/{b,c}
+#   Commit B: w/{b,c}, z/d
+#
+# Possible Resolutions:
+#   Previous git: z/d, CONFLICT(z/b -> y/b vs. w/b), CONFLICT(z/c -> y/c vs. w/c)
+#   Expected:     y/d, CONFLICT(z/b -> y/b vs. w/b), CONFLICT(z/c -> y/c vs. w/c)
+#   Preferred:    ??
+#
+# Notes: In commit A, directory z got renamed to y.  In commit B, directory z
+#        did NOT get renamed; the directory is still present; instead it is
+#        considered to have just renamed a subset of paths in directory z
+#        elsewhere.  Therefore, the directory rename done in commit A to z/
+#        applies to z/d and maps it to y/d.
+#
+#        It's possible that users would get confused about this, but what
+#        should we do instead?  Silently leaving at z/d seems just as bad or
+#        maybe even worse.  Perhaps we could print a big warning about z/d
+#        and how we're moving to y/d in this case, but when I started thinking
+#        about the ramifications of doing that, I didn't know how to rule out
+#        that opening other weird edge and corner cases so I just punted.
+
+test_expect_success '8e-setup: Both sides rename, one side adds to original directory' '
+	test_create_repo 8e &&
+	(
+		cd 8e &&
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
+		git mv z w &&
+		mkdir z &&
+		echo d >z/d &&
+		git add z/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '8e-check: Both sides rename, one side adds to original directory' '
+	(
+		cd 8e &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+
+		test 7 -eq $(git ls-files -s | wc -l) &&
+		test 6 -eq $(git ls-files -u | wc -l) &&
+		test 2 -eq $(git ls-files -o | wc -l) &&
+
+		test $(git rev-parse :0:y/d) = $(git rev-parse B:z/d) &&
+
+		git rev-parse >actual \
+			:1:z/b :2:y/b :3:w/b :1:z/c :2:y/c :3:w/c &&
+		git rev-parse >expect \
+			O:z/b O:z/b O:z/b O:z/c O:z/c O:z/c &&
+		test_cmp expect actual &&
+
+		git hash-object >actual \
+			y/b w/b y/c w/c &&
+		git rev-parse >expect \
+			O:z/b O:z/b O:z/c O:z/c &&
+		test_cmp expect actual &&
+
+		test ! -f z/b &&
+		test ! -f z/c &&
+
+		test_i18ngrep CONFLICT.*rename/rename.*z/c.*y/c.*w/c out &&
+		test_i18ngrep CONFLICT.*rename/rename.*z/b.*y/b.*w/b out
+	)
+'
+
 test_done
-- 
2.15.0.309.g00c152f825

