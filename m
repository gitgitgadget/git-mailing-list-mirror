Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E6B91F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 19:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753935AbdKJTGX (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 14:06:23 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:51754 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753725AbdKJTGC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 14:06:02 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAJ2vmt017416;
        Fri, 10 Nov 2017 11:06:00 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e535n1cdc-2;
        Fri, 10 Nov 2017 11:06:00 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 7913622F6281;
        Fri, 10 Nov 2017 11:06:00 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 69AFD2CDE6A;
        Fri, 10 Nov 2017 11:06:00 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 10/30] directory rename detection: more involved edge/corner testcases
Date:   Fri, 10 Nov 2017 11:05:30 -0800
Message-Id: <20171110190550.27059-11-newren@gmail.com>
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
 t/t6043-merge-rename-directories.sh | 347 ++++++++++++++++++++++++++++++++++++
 1 file changed, 347 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 157299105f..115d0d2622 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -1336,4 +1336,351 @@ test_expect_success '6e-check: Add/add from one side' '
 	test $(git rev-parse HEAD:z/d) = $(git rev-parse C:z/d)
 '
 
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
+#   Commit A: z/{b,c}
+#   Commit B: y/{b,c}
+#   Commit C: w/b, x/c, z/d
+#   Expected: y/d, CONFLICT(rename/rename for both z/b and z/c)
+#   NOTE: There's a rename of z/ here, y/ has more renames, so z/d -> y/d.
+
+test_expect_success '7a-setup: rename-dir vs. rename-dir (NOT split evenly) PLUS add-other-file' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir z &&
+	echo b >z/b &&
+	echo c >z/c &&
+	git add z &&
+	test_tick &&
+	git commit -m "A" &&
+
+	git branch A &&
+	git branch B &&
+	git branch C &&
+
+	git checkout B &&
+	git mv z y &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	mkdir w &&
+	mkdir x &&
+	git mv z/b w/ &&
+	git mv z/c x/ &&
+	echo d > z/d &&
+	git add z/d &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '7a-check: rename-dir vs. rename-dir (NOT split evenly) PLUS add-other-file' '
+	git checkout B^0 &&
+
+	test_must_fail git merge -s recursive C^0 >out &&
+	test_i18ngrep "CONFLICT (rename/rename).*z/b.*y/b.*w/b" out &&
+	test_i18ngrep "CONFLICT (rename/rename).*z/c.*y/c.*x/c" out &&
+
+	test 7 -eq $(git ls-files -s | wc -l) &&
+	test 6 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :0:y/d) = $(git rev-parse C:z/d) &&
+
+	test $(git rev-parse :1:z/b) = $(git rev-parse A:z/b) &&
+	test $(git rev-parse :2:y/b) = $(git rev-parse A:z/b) &&
+	test $(git rev-parse :3:w/b) = $(git rev-parse A:z/b) &&
+
+	test $(git rev-parse :1:z/c) = $(git rev-parse A:z/c) &&
+	test $(git rev-parse :2:y/c) = $(git rev-parse A:z/c) &&
+	test $(git rev-parse :3:x/c) = $(git rev-parse A:z/c) &&
+
+	test $(git hash-object y/b) = $(git rev-parse A:z/b) &&
+	test $(git hash-object w/b) = $(git rev-parse A:z/b) &&
+	test $(git hash-object y/c) = $(git rev-parse A:z/c) &&
+	test $(git hash-object x/c) = $(git rev-parse A:z/c)
+'
+
+# Testcase 7b, rename/rename(2to1), but only due to transitive rename
+#   (Related to testcase 1d)
+#   Commit A: z/{b,c},     x/d_1, w/d_2
+#   Commit B: y/{b,c,d_2}, x/d_1
+#   Commit C: z/{b,c,d_1},        w/d_2
+#   Expected: y/{b,c}, CONFLICT(rename/rename(2to1): x/d_1, w/d_2 -> y_d)
+
+test_expect_success '7b-setup: rename/rename(2to1), but only due to transitive rename' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir z &&
+	mkdir x &&
+	mkdir w &&
+	echo b >z/b &&
+	echo c >z/c &&
+	echo d1 > x/d &&
+	echo d2 > w/d &&
+	git add z x w &&
+	test_tick &&
+	git commit -m "A" &&
+
+	git branch A &&
+	git branch B &&
+	git branch C &&
+
+	git checkout B &&
+	git mv z y &&
+	git mv w/d y/ &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	git mv x/d z/ &&
+	rmdir x &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '7b-check: rename/rename(2to1), but only due to transitive rename' '
+	git checkout B^0 &&
+
+	test_must_fail git merge -s recursive C^0 >out &&
+	test_i18ngrep "CONFLICT (rename/rename)" out &&
+
+	test 4 -eq $(git ls-files -s | wc -l) &&
+	test 2 -eq $(git ls-files -u | wc -l) &&
+	test 3 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :0:y/b) = $(git rev-parse A:z/b) &&
+	test $(git rev-parse :0:y/c) = $(git rev-parse A:z/c) &&
+
+	test $(git rev-parse :2:y/d) = $(git rev-parse A:w/d) &&
+	test $(git rev-parse :3:y/d) = $(git rev-parse A:x/d) &&
+
+	test ! -f y/d &&
+	test -f y/d~HEAD &&
+	test -f y/d~C^0 &&
+
+	test $(git hash-object y/d~HEAD) = $(git rev-parse A:w/d) &&
+	test $(git hash-object y/d~C^0) = $(git rev-parse A:x/d)
+'
+
+# Testcase 7c, rename/rename(1to...2or3); transitive rename may add complexity
+#   (Related to testcases 3b and 5c)
+#   Commit A: z/{b,c}, x/d
+#   Commit B: y/{b,c}, w/d
+#   Commit C: z/{b,c,d}
+#   Expected: y/{b,c}, CONFLICT(x/d -> w/d vs. y/d)
+#   NOTE: z/ was renamed to y/ so we do not want to report
+#         either CONFLICT(x/d -> w/d vs. z/d)
+#         or CONFLiCT x/d -> w/d vs. y/d vs. z/d)
+
+test_expect_success '7c-setup: rename/rename(1to...2or3); transitive rename may add complexity' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir z &&
+	echo b >z/b &&
+	echo c >z/c &&
+	mkdir x &&
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
+	git mv z y &&
+	git mv x w &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	git mv x/d z/ &&
+	rmdir x &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '7c-check: rename/rename(1to...2or3); transitive rename may add complexity' '
+	git checkout B^0 &&
+
+	test_must_fail git merge -s recursive C^0 >out &&
+	test_i18ngrep "CONFLICT (rename/rename).*x/d.*w/d.*y/d" out &&
+
+	test 5 -eq $(git ls-files -s | wc -l) &&
+	test 3 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :0:y/b) = $(git rev-parse A:z/b) &&
+	test $(git rev-parse :0:y/c) = $(git rev-parse A:z/c) &&
+
+	test $(git rev-parse :1:x/d) = $(git rev-parse A:x/d) &&
+	test $(git rev-parse :2:w/d) = $(git rev-parse A:x/d) &&
+	test $(git rev-parse :3:y/d) = $(git rev-parse A:x/d)
+'
+
+# Testcase 7d, transitive rename involved in rename/delete; how is it reported?
+#   (Related somewhat to testcases 5b and 8d)
+#   Commit A: z/{b,c}, x/d
+#   Commit B: y/{b,c}
+#   Commit C: z/{b,c,d}
+#   Expected: y/{b,c}, CONFLICT(delete x/d vs rename to y/d)
+#   NOTE: z->y so NOT CONFLICT(delete x/d vs rename to z/d)
+
+test_expect_success '7d-setup: transitive rename involved in rename/delete; how is it reported?' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir z &&
+	echo b >z/b &&
+	echo c >z/c &&
+	mkdir x &&
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
+	git mv z y &&
+	git rm -rf x &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	git mv x/d z/ &&
+	rmdir x &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '7d-check: transitive rename involved in rename/delete; how is it reported?' '
+	git checkout B^0 &&
+
+	test_must_fail git merge -s recursive C^0 >out &&
+	test_i18ngrep "CONFLICT (rename/delete).*x/d.*y/d" out &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 1 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :0:y/b) = $(git rev-parse A:z/b) &&
+	test $(git rev-parse :0:y/c) = $(git rev-parse A:z/c) &&
+	test $(git rev-parse :3:y/d) = $(git rev-parse A:x/d)
+'
+
+# Testcase 7e, transitive rename in rename/delete AND dirs in the way
+#   (Very similar to 'both rename source and destination involved in D/F conflict' from t6022-merge-rename.sh)
+#   (Also related to testcases 9c and 9d)
+#   Commit A: z/{b,c},     x/d_1
+#   Commit B: y/{b,c,d/g}, x/d/f
+#   Commit C: z/{b,c,d_1}
+#   Expected: rename/delete(x/d_1->y/d_1 vs. None) + D/F conflict on y/d
+#             y/{b,c,d/g}, y/d_1~C^0, x/d/f
+#   NOTE: x/d/f may be slightly confusing here.  x/d_1 -> z/d_1 implies
+#         there is a directory rename from x/ -> z/, performed by commit C.
+#         However, on the side of commit B, it renamed z/ -> y/, thus
+#         making a rename from x/ -> z/ when it was getting rid of z/ seems
+#         non-sensical.  Further, putting x/d/f into y/d/f also doesn't
+#         make a lot of sense because commit B did the renaming of z to y
+#         and it created x/d/f, and it clearly made these things separate,
+#         so it doesn't make much sense to push these together.
+
+test_expect_success '7e-setup: transitive rename in rename/delete AND dirs in the way' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir z &&
+	echo b >z/b &&
+	echo c >z/c &&
+	mkdir x &&
+	echo d1 >x/d &&
+	git add z x &&
+	test_tick &&
+	git commit -m "A" &&
+
+	git branch A &&
+	git branch B &&
+	git branch C &&
+
+	git checkout B &&
+	git mv z y &&
+	git rm x/d &&
+	mkdir -p x/d &&
+	mkdir -p y/d &&
+	echo f >x/d/f &&
+	echo g >y/d/g &&
+	git add x/d/f y/d/g &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	git mv x/d z/ &&
+	rmdir x &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '7e-check: transitive rename in rename/delete AND dirs in the way' '
+	git checkout B^0 &&
+
+	test_must_fail git merge -s recursive C^0 >out &&
+	test_i18ngrep "CONFLICT (rename/delete).*x/d.*y/d" out &&
+
+	test 5 -eq $(git ls-files -s | wc -l) &&
+	test 1 -eq $(git ls-files -u | wc -l) &&
+	test 2 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :0:x/d/f) = $(git rev-parse B:x/d/f) &&
+	test $(git rev-parse :0:y/d/g) = $(git rev-parse B:y/d/g) &&
+
+	test $(git rev-parse :0:y/b) = $(git rev-parse A:z/b) &&
+	test $(git rev-parse :0:y/c) = $(git rev-parse A:z/c) &&
+	test $(git rev-parse :3:y/d) = $(git rev-parse A:x/d) &&
+
+	test $(git hash-object y/d~C^0) = $(git rev-parse A:x/d)
+'
+
 test_done
-- 
2.15.0.5.g9567be9905

