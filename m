Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA43C202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbdKTWDf (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:03:35 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38032 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751359AbdKTWCO (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2017 17:02:14 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAKLxARr020073;
        Mon, 20 Nov 2017 14:02:10 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2eakkpb8qm-1;
        Mon, 20 Nov 2017 14:02:09 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id B67FC22F41AC;
        Mon, 20 Nov 2017 14:02:09 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id AFBAD2CDEB1;
        Mon, 20 Nov 2017 14:02:09 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 12/33] directory rename detection: miscellaneous testcases to complete coverage
Date:   Mon, 20 Nov 2017 14:01:48 -0800
Message-Id: <20171120220209.15111-13-newren@gmail.com>
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

I came up with the testcases in the first eight sections before coding up
the implementation.  The testcases in this section were mostly ones I
thought of while coding/debugging, and which I was too lazy to insert
into the previous sections because I didn't want to re-label with all the
testcase references.  :-)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 536 +++++++++++++++++++++++++++++++++++-
 1 file changed, 535 insertions(+), 1 deletion(-)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index b153468a5c..9e00a26c69 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -295,6 +295,7 @@ test_expect_failure '1d-check: Directory renames cause a rename/rename(2to1) con
 '
 
 # Testcase 1e, Renamed directory, with all filenames being renamed too
+#   (Related to testcases 9f & 9g)
 #   Commit O: z/{oldb,oldc}
 #   Commit A: y/{newb,newc}
 #   Commit B: z/{oldb,oldc,d}
@@ -575,7 +576,7 @@ test_expect_success '2b-check: Directory split into two on one side, with equal
 ###########################################################################
 
 # Testcase 3a, Avoid implicit rename if involved as source on other side
-#   (Related to testcases 1c and 1f)
+#   (Related to testcases 1c, 1f, and 9h)
 #   Commit O: z/{b,c,d}
 #   Commit A: z/{b,c,d} (no change)
 #   Commit B: y/{b,c}, x/d
@@ -2232,4 +2233,537 @@ test_expect_failure '8e-check: Both sides rename, one side adds to original dire
 	)
 '
 
+###########################################################################
+# SECTION 9: Other testcases
+#
+# This section consists of miscellaneous testcases I thought of during
+# the implementation which round out the testing.
+###########################################################################
+
+# Testcase 9a, Inner renamed directory within outer renamed directory
+#   (Related to testcase 1f)
+#   Commit O: z/{b,c,d/{e,f,g}}
+#   Commit A: y/{b,c}, x/w/{e,f,g}
+#   Commit B: z/{b,c,d/{e,f,g,h},i}
+#   Expected: y/{b,c,i}, x/w/{e,f,g,h}
+#   NOTE: The only reason this one is interesting is because when a directory
+#         is split into multiple other directories, we determine by the weight
+#         of which one had the most paths going to it.  A naive implementation
+#         of that could take the new file in commit B at z/i to x/w/i or x/i.
+
+test_expect_success '9a-setup: Inner renamed directory within outer renamed directory' '
+	test_create_repo 9a &&
+	(
+		cd 9a &&
+
+		mkdir -p z/d &&
+		echo b >z/b &&
+		echo c >z/c &&
+		echo e >z/d/e &&
+		echo f >z/d/f &&
+		echo g >z/d/g &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		mkdir x &&
+		git mv z/d x/w &&
+		git mv z y &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo h >z/d/h &&
+		echo i >z/i &&
+		git add z &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '9a-check: Inner renamed directory within outer renamed directory' '
+	(
+		cd 9a &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 7 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:y/i &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:z/i &&
+		test_cmp expect actual &&
+
+		git rev-parse >actual \
+			HEAD:x/w/e HEAD:x/w/f HEAD:x/w/g HEAD:x/w/h &&
+		git rev-parse >expect \
+			O:z/d/e O:z/d/f O:z/d/g B:z/d/h &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 9b, Transitive rename with content merge
+#   (Related to testcase 1c)
+#   Commit O: z/{b,c},   x/d_1
+#   Commit A: y/{b,c},   x/d_2
+#   Commit B: z/{b,c,d_3}
+#   Expected: y/{b,c,d_merged}
+
+test_expect_success '9b-setup: Transitive rename with content merge' '
+	test_create_repo 9b &&
+	(
+		cd 9b &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		mkdir x &&
+		test_seq 1 10 >x/d &&
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
+		test_seq 1 11 >x/d &&
+		git add x/d &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		test_seq 0 10 >x/d &&
+		git mv x/d z/d &&
+		git add z/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '9b-check: Transitive rename with content merge' '
+	(
+		cd 9b &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 3 -eq $(git ls-files -s | wc -l) &&
+
+		test_seq 0 11 >expected &&
+		git add expected &&
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:y/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c :0:expected &&
+		test_cmp expect actual &&
+		test_must_fail git rev-parse HEAD:x/d &&
+		test_must_fail git rev-parse HEAD:z/d &&
+		test ! -f z/d &&
+
+		test $(git rev-parse HEAD:y/d) != $(git rev-parse O:x/d) &&
+		test $(git rev-parse HEAD:y/d) != $(git rev-parse A:x/d) &&
+		test $(git rev-parse HEAD:y/d) != $(git rev-parse B:z/d) &&
+		test_cmp expected y/d
+	)
+'
+
+# Testcase 9c, Doubly transitive rename?
+#   (Related to testcase 1c, 7e, and 9d)
+#   Commit O: z/{b,c},     x/{d,e},    w/f
+#   Commit A: y/{b,c},     x/{d,e,f,g}
+#   Commit B: z/{b,c,d,e},             w/f
+#   Expected: y/{b,c,d,e}, x/{f,g}
+#
+#   NOTE: x/f and x/g may be slightly confusing here.  The rename from w/f to
+#         x/f is clear.  Let's look beyond that.  Here's the logic:
+#            Commit B renamed x/ -> z/
+#            Commit A renamed z/ -> y/
+#         So, we could possibly further rename x/f to z/f to y/f, a doubly
+#         transient rename.  However, where does it end?  We can chain these
+#         indefinitely (see testcase 9d).  What if there is a D/F conflict
+#         at z/f/ or y/f/?  Or just another file conflict at one of those
+#         paths?  In the case of an N-long chain of transient renamings,
+#         where do we "abort" the rename at?  Can the user make sense of
+#         the resulting conflict and resolve it?
+#
+#         To avoid this confusion I use the simple rule that if the other side
+#         of history did a directory rename to a path that your side renamed
+#         away, then ignore that particular rename from the other side of
+#         history for any implicit directory renames.
+
+test_expect_success '9c-setup: Doubly transitive rename?' '
+	test_create_repo 9c &&
+	(
+		cd 9c &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		mkdir x &&
+		echo d >x/d &&
+		echo e >x/e &&
+		mkdir w &&
+		echo f >w/f &&
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
+		git mv w/f x/ &&
+		echo g >x/g &&
+		git add x/g &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv x/d z/d &&
+		git mv x/e z/e &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '9c-check: Doubly transitive rename?' '
+	(
+		cd 9c &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 >out &&
+		test_i18ngrep "WARNING: Avoiding applying x -> z rename to x/f" out &&
+
+		test 6 -eq $(git ls-files -s | wc -l) &&
+		test 1 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:y/d HEAD:y/e HEAD:x/f HEAD:x/g &&
+		git rev-parse >expect \
+			O:z/b O:z/c O:x/d O:x/e O:w/f A:x/g &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 9d, N-fold transitive rename?
+#   (Related to testcase 9c...and 1c and 7e)
+#   Commit O: z/a, y/b, x/c, w/d, v/e, u/f
+#   Commit A:  y/{a,b},  w/{c,d},  u/{e,f}
+#   Commit B: z/{a,t}, x/{b,c}, v/{d,e}, u/f
+#   Expected: <see NOTE first>
+#
+#   NOTE: z/ -> y/ (in commit A)
+#         y/ -> x/ (in commit B)
+#         x/ -> w/ (in commit A)
+#         w/ -> v/ (in commit B)
+#         v/ -> u/ (in commit A)
+#         So, if we add a file to z, say z/t, where should it end up?  In u?
+#         What if there's another file or directory named 't' in one of the
+#         intervening directories and/or in u itself?  Also, shouldn't the
+#         same logic that places 't' in u/ also move ALL other files to u/?
+#         What if there are file or directory conflicts in any of them?  If
+#         we attempted to do N-way (N-fold? N-ary? N-uple?) transitive renames
+#         like this, would the user have any hope of understanding any
+#         conflicts or how their working tree ended up?  I think not, so I'm
+#         ruling out N-ary transitive renames for N>1.
+#
+#   Therefore our expected result is:
+#     z/t, y/a, x/b, w/c, u/d, u/e, u/f
+#   The reason that v/d DOES get transitively renamed to u/d is that u/ isn't
+#   renamed somewhere.  A slightly sub-optimal result, but it uses fairly
+#   simple rules that are consistent with what we need for all the other
+#   testcases and simplifies things for the user.
+
+test_expect_success '9d-setup: N-way transitive rename?' '
+	test_create_repo 9d &&
+	(
+		cd 9d &&
+
+		mkdir z y x w v u &&
+		echo a >z/a &&
+		echo b >y/b &&
+		echo c >x/c &&
+		echo d >w/d &&
+		echo e >v/e &&
+		echo f >u/f &&
+		git add z y x w v u &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv z/a y/ &&
+		git mv x/c w/ &&
+		git mv v/e u/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo t >z/t &&
+		git mv y/b x/ &&
+		git mv w/d v/ &&
+		git add z/t &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '9d-check: N-way transitive rename?' '
+	(
+		cd 9d &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 >out &&
+		test_i18ngrep "WARNING: Avoiding applying z -> y rename to z/t" out &&
+		test_i18ngrep "WARNING: Avoiding applying y -> x rename to y/a" out &&
+		test_i18ngrep "WARNING: Avoiding applying x -> w rename to x/b" out &&
+		test_i18ngrep "WARNING: Avoiding applying w -> v rename to w/c" out &&
+
+		test 7 -eq $(git ls-files -s | wc -l) &&
+		test 1 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:z/t HEAD:y/a HEAD:x/b HEAD:w/c HEAD:u/d HEAD:u/e HEAD:u/f &&
+		git rev-parse >expect \
+			B:z/t O:z/a O:y/b O:x/c O:w/d O:v/e A:u/f &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 9e, N-to-1 whammo
+#   (Related to testcase 9c...and 1c and 7e)
+#   Commit O: dir1/{a,b}, dir2/{d,e}, dir3/{g,h}, dirN/{j,k}
+#   Commit A: dir1/{a,b,c,yo}, dir2/{d,e,f,yo}, dir3/{g,h,i,yo}, dirN/{j,k,l,yo}
+#   Commit B: combined/{a,b,d,e,g,h,j,k}
+#   Expected: combined/{a,b,c,d,e,f,g,h,i,j,k,l}, CONFLICT(Nto1) warnings,
+#             dir1/yo, dir2/yo, dir3/yo, dirN/yo
+
+test_expect_success '9e-setup: N-to-1 whammo' '
+	test_create_repo 9e &&
+	(
+		cd 9e &&
+
+		mkdir dir1 dir2 dir3 dirN &&
+		echo a >dir1/a &&
+		echo b >dir1/b &&
+		echo d >dir2/d &&
+		echo e >dir2/e &&
+		echo g >dir3/g &&
+		echo h >dir3/h &&
+		echo j >dirN/j &&
+		echo k >dirN/k &&
+		git add dir* &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		echo c  >dir1/c &&
+		echo yo >dir1/yo &&
+		echo f  >dir2/f &&
+		echo yo >dir2/yo &&
+		echo i  >dir3/i &&
+		echo yo >dir3/yo &&
+		echo l  >dirN/l &&
+		echo yo >dirN/yo &&
+		git add dir* &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv dir1 combined &&
+		git mv dir2/* combined/ &&
+		git mv dir3/* combined/ &&
+		git mv dirN/* combined/ &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '9e-check: N-to-1 whammo' '
+	(
+		cd 9e &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep "CONFLICT (implicit dir rename): Cannot map more than one path to combined/yo" out >error_line &&
+		grep -q dir1/yo error_line &&
+		grep -q dir2/yo error_line &&
+		grep -q dir3/yo error_line &&
+		grep -q dirN/yo error_line &&
+
+		test 16 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 2 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			:0:combined/a :0:combined/b :0:combined/c \
+			:0:combined/d :0:combined/e :0:combined/f \
+			:0:combined/g :0:combined/h :0:combined/i \
+			:0:combined/j :0:combined/k :0:combined/l &&
+		git rev-parse >expect \
+			O:dir1/a O:dir1/b A:dir1/c \
+			O:dir2/d O:dir2/e A:dir2/f \
+			O:dir3/g O:dir3/h A:dir3/i \
+			O:dirN/j O:dirN/k A:dirN/l &&
+		test_cmp expect actual &&
+
+		git rev-parse >actual \
+			:0:dir1/yo :0:dir2/yo :0:dir3/yo :0:dirN/yo &&
+		git rev-parse >expect \
+			A:dir1/yo A:dir2/yo A:dir3/yo A:dirN/yo &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 9f, Renamed directory that only contained immediate subdirs
+#   (Related to testcases 1e & 9g)
+#   Commit O: goal/{a,b}/$more_files
+#   Commit A: priority/{a,b}/$more_files
+#   Commit B: goal/{a,b}/$more_files, goal/c
+#   Expected: priority/{a,b}/$more_files, priority/c
+
+test_expect_success '9f-setup: Renamed directory that only contained immediate subdirs' '
+	test_create_repo 9f &&
+	(
+		cd 9f &&
+
+		mkdir -p goal/a &&
+		mkdir -p goal/b &&
+		echo foo >goal/a/foo &&
+		echo bar >goal/b/bar &&
+		echo baz >goal/b/baz &&
+		git add goal &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv goal/ priority &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo c >goal/c &&
+		git add goal/c &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '9f-check: Renamed directory that only contained immediate subdirs' '
+	(
+		cd 9f &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 4 -eq $(git ls-files -s | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:priority/a/foo HEAD:priority/b/bar HEAD:priority/b/baz HEAD:priority/c &&
+		git rev-parse >expect \
+			O:goal/a/foo O:goal/b/bar O:goal/b/baz B:goal/c &&
+		test_cmp expect actual &&
+		test_must_fail git rev-parse HEAD:goal/c
+	)
+'
+
+# Testcase 9g, Renamed directory that only contained immediate subdirs, immediate subdirs renamed
+#   (Related to testcases 1e & 9f)
+#   Commit O: goal/{a,b}/$more_files
+#   Commit A: priority/{alpha,bravo}/$more_files
+#   Commit B: goal/{a,b}/$more_files, goal/c
+#   Expected: priority/{alpha,bravo}/$more_files, priority/c
+
+test_expect_success '9g-setup: Renamed directory that only contained immediate subdirs, immediate subdirs renamed' '
+	test_create_repo 9g &&
+	(
+		cd 9g &&
+
+		mkdir -p goal/a &&
+		mkdir -p goal/b &&
+		echo foo >goal/a/foo &&
+		echo bar >goal/b/bar &&
+		echo baz >goal/b/baz &&
+		git add goal &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		mkdir priority &&
+		git mv goal/a/ priority/alpha &&
+		git mv goal/b/ priority/beta &&
+		rmdir goal/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo c >goal/c &&
+		git add goal/c &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '9g-check: Renamed directory that only contained immediate subdirs, immediate subdirs renamed' '
+	(
+		cd 9g &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 4 -eq $(git ls-files -s | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:priority/alpha/foo HEAD:priority/beta/bar HEAD:priority/beta/baz HEAD:priority/c &&
+		git rev-parse >expect \
+			O:goal/a/foo O:goal/b/bar O:goal/b/baz B:goal/c &&
+		test_cmp expect actual &&
+		test_must_fail git rev-parse HEAD:goal/c
+	)
+'
+
+###########################################################################
+# Rules suggested by section 9:
+#
+#   If the other side of history did a directory rename to a path that your
+#   side renamed away, then ignore that particular rename from the other
+#   side of history for any implicit directory renames.
+###########################################################################
+
 test_done
-- 
2.15.0.309.g00c152f825

