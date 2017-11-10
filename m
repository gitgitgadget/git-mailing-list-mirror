Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2F731F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 19:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753843AbdKJTGW (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 14:06:22 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:48744 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753738AbdKJTGC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 14:06:02 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAJ4GGZ002780;
        Fri, 10 Nov 2017 11:06:01 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e53631bgt-1;
        Fri, 10 Nov 2017 11:06:00 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id CFA8B22F628A;
        Fri, 10 Nov 2017 11:06:00 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id BDC182CDEC3;
        Fri, 10 Nov 2017 11:06:00 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 14/30] directory rename detection: tests for handling overwriting dirty files
Date:   Fri, 10 Nov 2017 11:05:34 -0800
Message-Id: <20171110190550.27059-15-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.5.g9567be9905
In-Reply-To: <20171110190550.27059-1-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711100261
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 401 ++++++++++++++++++++++++++++++++++++
 1 file changed, 401 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 7af8962512..4066b08767 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -2873,4 +2873,405 @@ test_expect_failure '10e-check: Does git complain about untracked file that is n
 	test "random" = "$(cat z/c)"
 '
 
+###########################################################################
+# SECTION 11: Handling dirty (not up-to-date) files
+#
+# unpack_trees(), upon which the recursive merge algorithm is based, aborts
+# the operation if untracked or dirty files would be deleted or overwritten
+# by the merge.  Unfortunately, unpack_trees() does not understand renames,
+# and if it doesn't abort, then it muddies up the working directory before
+# we even get to the point of detecting renames, so we need some special
+# handling.  This was true even of normal renames, but there are additional
+# codepaths that need special handling with directory renames.  Add
+# testcases for both renamed-by-directory-rename-detection and standard
+# rename cases.
+###########################################################################
+
+# Testcase 11a, Avoid losing dirty contents with simple rename
+#   Commit A: z/{a,b_v1},
+#   Commit B: z/{a,c_v1}, and z/c_v1 has uncommitted mods
+#   Commit C: z/{a,b_v2}
+#   Expected: ERROR_MSG(Refusing to lose dirty file at z/c) +
+#             z/a, staged version of z/c has sha1sum matching C:z/b_v2,
+#             z/c~HEAD with contents of C:z/b_v2,
+#             z/c with uncommitted mods on top of B:z/c_v1
+
+test_expect_success '11a-setup: Avoid losing dirty contents with simple rename' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir z &&
+	echo a >z/a &&
+	test_seq 1 10 >z/b &&
+	git add z &&
+	test_tick &&
+	git commit -m "A" &&
+
+	git branch A &&
+	git branch B &&
+	git branch C &&
+
+	git checkout B &&
+	git mv z/b z/c &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	echo 11 >>z/b &&
+	git add z/b &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '11a-check: Avoid losing dirty contents with simple rename' '
+	git checkout B^0 &&
+	echo stuff >>z/c &&
+
+	test_must_fail git merge -s recursive C^0 >out 2>err &&
+	test_i18ngrep "Refusing to lose dirty file at z/c" out &&
+
+	test_seq 1 10 >expected &&
+	echo stuff >>expected &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 1 -eq $(git ls-files -u | wc -l) &&
+	test 4 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :0:z/a) = $(git rev-parse A:z/a) &&
+	test $(git rev-parse :2:z/c) = $(git rev-parse C:z/b) &&
+
+	test "$(git hash-object z/c~HEAD)" = $(git rev-parse C:z/b) &&
+	test_cmp expected z/c
+'
+
+# Testcase 11b, Avoid losing dirty file involved in directory rename
+#   Commit A: z/a,         x/{b,c_v1}
+#   Commit B: z/{a,c_v1},  x/b,       and z/c_v1 has uncommitted mods
+#   Commit C: y/a,         x/{b,c_v2}
+#   Expected: y/{a,c_v2}, x/b, z/c_v1 with uncommited mods untracked,
+#             ERROR_MSG(Refusing to lose dirty file at z/c)
+
+
+test_expect_success '11b-setup: Avoid losing dirty file involved in directory rename' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir z x &&
+	echo a >z/a &&
+	echo b >x/b &&
+	test_seq 1 10 >x/c &&
+	git add z x &&
+	test_tick &&
+	git commit -m "A" &&
+
+	git branch A &&
+	git branch B &&
+	git branch C &&
+
+	git checkout B &&
+	git mv x/c z/c &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	git mv z y &&
+	echo 11 >>x/c &&
+	git add x/c &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '11b-check: Avoid losing dirty file involved in directory rename' '
+	git checkout B^0 &&
+	echo stuff >>z/c &&
+
+	git merge -s recursive C^0 >out 2>err &&
+	test_i18ngrep "Refusing to lose dirty file at z/c" out &&
+
+	grep -q stuff */* &&
+	test_seq 1 10 >expected &&
+	echo stuff >>expected &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -m | wc -l) &&
+	test 4 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :0:x/b) = $(git rev-parse A:x/b) &&
+	test $(git rev-parse :0:y/a) = $(git rev-parse A:z/a) &&
+	test $(git rev-parse :0:y/c) = $(git rev-parse C:x/c) &&
+
+	test "$(git hash-object y/c)" = $(git rev-parse C:x/c) &&
+	test_cmp expected z/c
+'
+
+# Testcase 11c, Avoid losing not-up-to-date with rename + D/F conflict
+#   Commit A: y/a,         x/{b,c_v1}
+#   Commit B: y/{a,c_v1},  x/b,       and y/c_v1 has uncommitted mods
+#   Commit C: y/{a,c/d},   x/{b,c_v2}
+#   Expected: Abort_msg("following files would be overwritten by merge") +
+#             y/c left untouched (still has uncommitted mods)
+
+test_expect_success '11c-setup: Avoid losing not-uptodate with rename + D/F conflict' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir y x &&
+	echo a >y/a &&
+	echo b >x/b &&
+	test_seq 1 10 >x/c &&
+	git add y x &&
+	test_tick &&
+	git commit -m "A" &&
+
+	git branch A &&
+	git branch B &&
+	git branch C &&
+
+	git checkout B &&
+	git mv x/c y/c &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	mkdir y/c &&
+	echo d >y/c/d &&
+	echo 11 >>x/c &&
+	git add x/c y/c/d &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_success '11c-check: Avoid losing not-uptodate with rename + D/F conflict' '
+	git checkout B^0 &&
+	echo stuff >>y/c &&
+
+	test_must_fail git merge -s recursive C^0 >out 2>err &&
+	test_i18ngrep "following files would be overwritten by merge" err &&
+
+	grep -q stuff */* &&
+	test_seq 1 10 >expected &&
+	echo stuff >>expected &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -m | wc -l) &&
+	test 3 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse HEAD) = $(git rev-parse B) &&
+	test_cmp expected y/c
+'
+
+# Testcase 11d, Avoid losing not-up-to-date with rename + D/F conflict
+#   Commit A: z/a,         x/{b,c_v1}
+#   Commit B: z/{a,c_v1},  x/b,       and z/c_v1 has uncommitted mods
+#   Commit C: y/{a,c/d},   x/{b,c_v2}
+#   Expected: D/F: y/c_v2 vs y/c/d) +
+#             Warning_Msg("Refusing to lose dirty file at z/c) +
+#             y/{a,c~HEAD,c/d}, x/b, now-untracked z/c_v1 with uncommited mods
+
+test_expect_success '11d-setup: Avoid losing not-uptodate with rename + D/F conflict' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir z x &&
+	echo a >z/a &&
+	echo b >x/b &&
+	test_seq 1 10 >x/c &&
+	git add z x &&
+	test_tick &&
+	git commit -m "A" &&
+
+	git branch A &&
+	git branch B &&
+	git branch C &&
+
+	git checkout B &&
+	git mv x/c z/c &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	git mv z y &&
+	mkdir y/c &&
+	echo d >y/c/d &&
+	echo 11 >>x/c &&
+	git add x/c y/c/d &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '11d-check: Avoid losing not-uptodate with rename + D/F conflict' '
+	git checkout B^0 &&
+	echo stuff >>z/c &&
+
+	test_must_fail git merge -s recursive C^0 >out 2>err &&
+	test_i18ngrep "Refusing to lose dirty file at z/c" out &&
+
+	grep -q stuff */* &&
+	test_seq 1 10 >expected &&
+	echo stuff >>expected &&
+
+	test 4 -eq $(git ls-files -s | wc -l) &&
+	test 1 -eq $(git ls-files -u | wc -l) &&
+	test 5 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :0:x/b) = $(git rev-parse A:x/b) &&
+	test $(git rev-parse :0:y/a) = $(git rev-parse A:z/a) &&
+	test $(git rev-parse :0:y/c/d) = $(git rev-parse C:y/c/d) &&
+	test $(git rev-parse :3:y/c) = $(git rev-parse C:x/c) &&
+
+	test "$(git hash-object y/c~HEAD)" = $(git rev-parse C:x/c) &&
+	test_cmp expected z/c
+'
+
+# Testcase 11e, Avoid deleting not-up-to-date with dir rename/rename(1to2)/add
+#   Commit A: z/{a,b},      x/{c_1,d}
+#   Commit B: y/{a,b,c_2},  x/d, w/c_1, and y/c_2 has uncommitted mods
+#   Commit C: z/{a,b,c_1},  x/d
+#   Expected: Failed Merge; y/{a,b} + x/d +
+#             CONFLICT(rename/rename) x/c_1 -> w/c_1 vs y/c_1 +
+#             ERROR_MSG(Refusing to lose dirty file at y/c)
+#             y/c~C^0 has A:x/c_1 contents
+#             y/c~HEAD has B:y/c_2 contents
+#             y/c has dirty file from before merge
+
+test_expect_success '11e-setup: Avoid deleting not-uptodate with dir rename/rename(1to2)/add' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir z x &&
+	echo a >z/a &&
+	echo b >z/b &&
+	echo c >x/c &&
+	echo d >x/d &&
+	git add z x &&
+	test_tick &&
+	git commit -m "A" &&
+
+	git branch A &&
+	git branch B &&
+	git branch C &&
+
+	git checkout B &&
+	git mv z/ y/ &&
+	echo different >y/c &&
+	mkdir w &&
+	git mv x/c w/ &&
+	git add y/c &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	git mv x/c z/ &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '11e-check: Avoid deleting not-uptodate with dir rename/rename(1to2)/add' '
+	git checkout B^0 &&
+	echo mods >>y/c &&
+
+	test_must_fail git merge -s recursive C^0 >out 2>err &&
+	test_i18ngrep "CONFLICT (rename/rename)" out &&
+	test_i18ngrep "Refusing to lose dirty file at y/c" out &&
+
+	test 7 -eq $(git ls-files -s | wc -l) &&
+	test 4 -eq $(git ls-files -u | wc -l) &&
+	test 4 -eq $(git ls-files -o | wc -l) &&
+
+	echo different >expected &&
+	echo mods >>expected &&
+
+	test $(git rev-parse :0:y/a) = $(git rev-parse A:z/a) &&
+	test $(git rev-parse :0:y/b) = $(git rev-parse A:z/b) &&
+	test $(git rev-parse :0:x/d) = $(git rev-parse A:x/d) &&
+
+	test $(git rev-parse :1:x/c) = $(git rev-parse A:x/c) &&
+	test $(git rev-parse :2:w/c) = $(git rev-parse A:x/c) &&
+	test $(git rev-parse :2:y/c) = $(git rev-parse B:y/c) &&
+	test $(git rev-parse :3:y/c) = $(git rev-parse A:x/c) &&
+
+	test "$(git hash-object y/c~C^0)" = $(git rev-parse A:x/c) &&
+	test "$(git hash-object y/c~HEAD)" = $(git rev-parse B:y/c) &&
+	test_cmp expected y/c
+'
+
+# Testcase 11f, Avoid deleting not-up-to-date w/ dir rename/rename(2to1)
+#   Commit A: z/{a,b},        x/{c_1,d_2}
+#   Commit B: y/{a,b,wham_1}, x/d_2, except y/wham has uncommitted mods
+#   Commit C: z/{a,b,wham_2}, x/c_1
+#   Expected: Failed Merge; y/{a,b} + untracked y/{wham~C^0,wham~C^HEAD} +
+#             y/wham with dirty changes from before merge +
+#             CONFLICT(rename/rename) x/c vs x/d -> y/wham
+#             ERROR_MSG(Refusing to lose dirty file at y/wham)
+
+test_expect_success '11f-setup: Avoid deleting not-uptodate with dir rename/rename(2to1)' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir z x &&
+	echo a >z/a &&
+	echo b >z/b &&
+	test_seq 1 10 >x/c &&
+	echo d >x/d &&
+	git add z x &&
+	test_tick &&
+	git commit -m "A" &&
+
+	git branch A &&
+	git branch B &&
+	git branch C &&
+
+	git checkout B &&
+	git mv z/ y/ &&
+	git mv x/c y/wham &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	git mv x/d z/wham &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '11f-check: Avoid deleting not-uptodate with dir rename/rename(2to1)' '
+	git checkout B^0 &&
+	echo important >>y/wham &&
+
+	test_must_fail git merge -s recursive C^0 >out 2>err &&
+	test_i18ngrep "CONFLICT (rename/rename)" out &&
+	test_i18ngrep "Refusing to lose dirty file at y/wham" out &&
+
+	test 4 -eq $(git ls-files -s | wc -l) &&
+	test 2 -eq $(git ls-files -u | wc -l) &&
+	test 4 -eq $(git ls-files -o | wc -l) &&
+
+	test_seq 1 10 >expected &&
+	echo important >>expected &&
+
+	test $(git rev-parse :0:y/a) = $(git rev-parse A:z/a) &&
+	test $(git rev-parse :0:y/b) = $(git rev-parse A:z/b) &&
+
+	test_must_fail git rev-parse :1:y/wham &&
+	test $(git rev-parse :2:y/wham) = $(git rev-parse A:x/c) &&
+	test $(git rev-parse :3:y/wham) = $(git rev-parse A:x/d) &&
+
+	test_cmp expected y/wham &&
+	test $(git hash-object y/wham~C^0)  = $(git rev-parse A:x/d) &&
+	test $(git hash-object y/wham~HEAD) = $(git rev-parse A:x/c)
+'
+
 test_done
-- 
2.15.0.5.g9567be9905

