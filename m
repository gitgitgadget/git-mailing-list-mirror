Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FF651F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 19:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753936AbdKJTGZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 14:06:25 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:51746 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753709AbdKJTGC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 14:06:02 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAJ2v39017414;
        Fri, 10 Nov 2017 11:06:00 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e535n1cde-1;
        Fri, 10 Nov 2017 11:06:00 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 8F10A22F6287;
        Fri, 10 Nov 2017 11:06:00 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 8410B2CDEC3;
        Fri, 10 Nov 2017 11:06:00 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 12/30] directory rename detection: miscellaneous testcases to complete coverage
Date:   Fri, 10 Nov 2017 11:05:32 -0800
Message-Id: <20171110190550.27059-13-newren@gmail.com>
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
 t/t6043-merge-rename-directories.sh | 505 ++++++++++++++++++++++++++++++++++++
 1 file changed, 505 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index bdfd943c88..bb179b16c8 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -265,6 +265,7 @@ test_expect_failure '1d-check: Directory renames cause a rename/rename(2to1) con
 '
 
 # Testcase 1e, Renamed directory, with all filenames being renamed too
+#   (Related to testcases 9f & 9g)
 #   Commit A: z/{oldb,oldc}
 #   Commit B: y/{newb,newc}
 #   Commit C: z/{oldb,oldc,d}
@@ -2054,4 +2055,508 @@ test_expect_failure '8e-check: Both sides rename, one side adds to original dire
 	test_i18ngrep CONFLICT.*rename/rename.*z/b.*y/b.*w/b out
 '
 
+###########################################################################
+# SECTION 9: Other testcases
+#
+# I came up with the testcases in the first eight sections before coding up
+# the implementation.  The testcases in this section were mostly ones I
+# thought of while coding/debugging, and which I was too lazy to insert
+# into the previous sections because I didn't want to re-label with all the
+# testcase references.  :-)
+###########################################################################
+
+# Testcase 9a, Inner renamed directory within outer renamed directory
+#   (Related to testcase 1f)
+#   Commit A: z/{b,c,d/{e,f,g}}
+#   Commit B: y/{b,c}, x/w/{e,f,g}
+#   Commit C: z/{b,c,d/{e,f,g,h},i}
+#   Expected: y/{b,c,i}, x/w/{e,f,g,h}
+#   NOTE: The only reason this one is interesting is because when a directory
+#         is split into multiple other directories, we determine by the weight
+#         of which one had the most paths going to it.  A naive implementation
+#         of that could take the new file in commit C at z/i to x/w/i or x/i.
+
+test_expect_success '9a-setup: Inner renamed directory within outer renamed directory' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir -p z/d &&
+	echo b >z/b &&
+	echo c >z/c &&
+	echo e >z/d/e &&
+	echo f >z/d/f &&
+	echo g >z/d/g &&
+	git add z &&
+	test_tick &&
+	git commit -m "A" &&
+
+	git branch A &&
+	git branch B &&
+	git branch C &&
+
+	git checkout B &&
+	mkdir x &&
+	git mv z/d x/w &&
+	git mv z y &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	echo h >z/d/h &&
+	echo i >z/i &&
+	git add z &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '9a-check: Inner renamed directory within outer renamed directory' '
+	git checkout B^0 &&
+
+	git merge -s recursive C^0 &&
+
+	test 7 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse HEAD:y/b) = $(git rev-parse A:z/b) &&
+	test $(git rev-parse HEAD:y/c) = $(git rev-parse A:z/c) &&
+	test $(git rev-parse HEAD:y/i) = $(git rev-parse C:z/i) &&
+
+	test $(git rev-parse HEAD:x/w/e) = $(git rev-parse A:z/d/e) &&
+	test $(git rev-parse HEAD:x/w/f) = $(git rev-parse A:z/d/f) &&
+	test $(git rev-parse HEAD:x/w/g) = $(git rev-parse A:z/d/g) &&
+	test $(git rev-parse HEAD:x/w/h) = $(git rev-parse C:z/d/h)
+'
+
+# Testcase 9b, Transitive rename with content merge
+#   (Related to testcase 1c)
+#   Commit A: z/{b,c},   x/d_1
+#   Commit B: y/{b,c},   x/d_2
+#   Commit C: z/{b,c,d_3}
+#   Expected: y/{b,c,d_merged}
+
+test_expect_success '9b-setup: Transitive rename with content merge' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir z &&
+	echo b >z/b &&
+	echo c >z/c &&
+	mkdir x &&
+	test_seq 1 10 >x/d &&
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
+	test_seq 1 11 >x/d &&
+	git add x/d &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	test_seq 0 10 >x/d &&
+	git mv x/d z/d &&
+	git add z/d &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '9b-check: Transitive rename with content merge' '
+	git checkout B^0 &&
+
+	git merge -s recursive C^0 &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+
+	test $(git rev-parse HEAD:y/b) = $(git rev-parse A:z/b) &&
+	test $(git rev-parse HEAD:y/c) = $(git rev-parse A:z/c) &&
+	test_must_fail git rev-parse HEAD:x/d &&
+	test_must_fail git rev-parse HEAD:z/d &&
+	test ! -f z/d &&
+
+	test $(git rev-parse HEAD:y/d) != $(git rev-parse A:x/d) &&
+	test $(git rev-parse HEAD:y/d) != $(git rev-parse B:x/d) &&
+	test $(git rev-parse HEAD:y/d) != $(git rev-parse C:z/d) &&
+	test_seq 0 11 >expected &&
+	git add expected &&
+	test $(git rev-parse HEAD:y/d) = $(git rev-parse :0:expected) &&
+	test_cmp expected y/d
+'
+
+# Testcase 9c, Doubly transitive rename?
+#   (Related to testcase 1c, 7e, and 9d)
+#   Commit A: z/{b,c},     x/{d,e},    w/f
+#   Commit B: y/{b,c},     x/{d,e,f,g}
+#   Commit C: z/{b,c,d,e},             w/f
+#   Expected: y/{b,c,d,e}, x/{f,g}
+#
+#   NOTE: x/f and x/g may be slightly confusing here.  The rename from w/f to
+#         x/f is clear.  Let's look beyond that.  Here's the logic:
+#            Commit C renamed x/ -> z/
+#            Commit B renamed z/ -> y/
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
+	echo e >x/e &&
+	mkdir w &&
+	echo f >w/f &&
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
+	git mv w/f x/ &&
+	echo g >x/g &&
+	git add x/g &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	git mv x/d z/d &&
+	git mv x/e z/e &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '9c-check: Doubly transitive rename?' '
+	git checkout B^0 &&
+
+	git merge -s recursive C^0 >out &&
+	test_i18ngrep "WARNING: Avoiding applying x -> z rename to x/f" out &&
+
+	test 6 -eq $(git ls-files -s | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse HEAD:y/b) = $(git rev-parse A:z/b) &&
+	test $(git rev-parse HEAD:y/c) = $(git rev-parse A:z/c) &&
+	test $(git rev-parse HEAD:y/d) = $(git rev-parse A:x/d) &&
+	test $(git rev-parse HEAD:y/e) = $(git rev-parse A:x/e) &&
+	test $(git rev-parse HEAD:x/f) = $(git rev-parse A:w/f) &&
+	test $(git rev-parse HEAD:x/g) = $(git rev-parse B:x/g)
+'
+
+# Testcase 9d, N-fold transitive rename?
+#   (Related to testcase 9c...and 1c and 7e)
+#   Commit A: z/a, y/b, x/c, w/d, v/e, u/f
+#   Commit B:  y/{a,b},  w/{c,d},  u/{e,f}
+#   Commit C: z/{a,t}, x/{b,c}, v/{d,e}, u/f
+#   Expected: <see NOTE first>
+#
+#   NOTE: z/ -> y/ (in commit B)
+#         y/ -> x/ (in commit C)
+#         x/ -> w/ (in commit B)
+#         w/ -> v/ (in commit C)
+#         v/ -> u/ (in commit B)
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
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir z y x w v u &&
+	echo a >z/a &&
+	echo b >y/b &&
+	echo c >x/c &&
+	echo d >w/d &&
+	echo e >v/e &&
+	echo f >u/f &&
+	git add z y x w v u &&
+	test_tick &&
+	git commit -m "A" &&
+
+	git branch A &&
+	git branch B &&
+	git branch C &&
+
+	git checkout B &&
+	git mv z/a y/ &&
+	git mv x/c w/ &&
+	git mv v/e u/ &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	echo t >z/t &&
+	git mv y/b x/ &&
+	git mv w/d v/ &&
+	git add z/t &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '9d-check: N-way transitive rename?' '
+	git checkout B^0 &&
+
+	git merge -s recursive C^0 >out &&
+	test_i18ngrep "WARNING: Avoiding applying z -> y rename to z/t" out &&
+	test_i18ngrep "WARNING: Avoiding applying y -> x rename to y/a" out &&
+	test_i18ngrep "WARNING: Avoiding applying x -> w rename to x/b" out &&
+	test_i18ngrep "WARNING: Avoiding applying w -> v rename to w/c" out &&
+
+	test 7 -eq $(git ls-files -s | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse HEAD:z/t) = $(git rev-parse C:z/t) &&
+	test $(git rev-parse HEAD:y/a) = $(git rev-parse A:z/a) &&
+	test $(git rev-parse HEAD:x/b) = $(git rev-parse A:y/b) &&
+	test $(git rev-parse HEAD:w/c) = $(git rev-parse A:x/c) &&
+	test $(git rev-parse HEAD:u/d) = $(git rev-parse A:w/d) &&
+	test $(git rev-parse HEAD:u/e) = $(git rev-parse A:v/e) &&
+	test $(git rev-parse HEAD:u/f) = $(git rev-parse B:u/f)
+'
+
+# Testcase 9e, N-to-1 whammo
+#   (Related to testcase 9c...and 1c and 7e)
+#   Commit A: dir1/{a,b}, dir2/{d,e}, dir3/{g,h}, dirN/{j,k}
+#   Commit B: dir1/{a,b,c,yo}, dir2/{d,e,f,yo}, dir3/{g,h,i,yo}, dirN/{j,k,l,yo}
+#   Commit C: combined/{a,b,d,e,g,h,j,k}
+#   Expected: combined/{a,b,c,d,e,f,g,h,i,j,k,l}, CONFLICT(Nto1) warnings,
+#             dir1/yo, dir2/yo, dir3/yo, dirN/yo
+
+test_expect_success '9e-setup: N-to-1 whammo' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir dir1 dir2 dir3 dirN &&
+	echo a >dir1/a &&
+	echo b >dir1/b &&
+	echo d >dir2/d &&
+	echo e >dir2/e &&
+	echo g >dir3/g &&
+	echo h >dir3/h &&
+	echo j >dirN/j &&
+	echo k >dirN/k &&
+	git add dir* &&
+	test_tick &&
+	git commit -m "A" &&
+
+	git branch A &&
+	git branch B &&
+	git branch C &&
+
+	git checkout B &&
+	echo c  >dir1/c &&
+	echo yo >dir1/yo &&
+	echo f  >dir2/f &&
+	echo yo >dir2/yo &&
+	echo i  >dir3/i &&
+	echo yo >dir3/yo &&
+	echo l  >dirN/l &&
+	echo yo >dirN/yo &&
+	git add dir* &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	git mv dir1 combined &&
+	git mv dir2/* combined/ &&
+	git mv dir3/* combined/ &&
+	git mv dirN/* combined/ &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '9e-check: N-to-1 whammo' '
+	git checkout B^0 &&
+
+	test_must_fail git merge -s recursive C^0 >out &&
+	test_i18ngrep "CONFLICT (implicit dir rename): Cannot map more than one path to combined/yo" out >error_line &&
+	grep -q dir1/yo error_line &&
+	grep -q dir2/yo error_line &&
+	grep -q dir3/yo error_line &&
+	grep -q dirN/yo error_line &&
+
+	test 16 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -u | wc -l) &&
+	test 2 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :0:combined/a) = $(git rev-parse A:dir1/a) &&
+	test $(git rev-parse :0:combined/b) = $(git rev-parse A:dir1/b) &&
+	test $(git rev-parse :0:combined/c) = $(git rev-parse B:dir1/c) &&
+	test $(git rev-parse :0:combined/d) = $(git rev-parse A:dir2/d) &&
+	test $(git rev-parse :0:combined/e) = $(git rev-parse A:dir2/e) &&
+	test $(git rev-parse :0:combined/f) = $(git rev-parse B:dir2/f) &&
+	test $(git rev-parse :0:combined/g) = $(git rev-parse A:dir3/g) &&
+	test $(git rev-parse :0:combined/h) = $(git rev-parse A:dir3/h) &&
+	test $(git rev-parse :0:combined/i) = $(git rev-parse B:dir3/i) &&
+	test $(git rev-parse :0:combined/j) = $(git rev-parse A:dirN/j) &&
+	test $(git rev-parse :0:combined/k) = $(git rev-parse A:dirN/k) &&
+	test $(git rev-parse :0:combined/l) = $(git rev-parse B:dirN/l) &&
+
+	test $(git rev-parse :0:dir1/yo) = $(git rev-parse B:dir1/yo) &&
+	test $(git rev-parse :0:dir2/yo) = $(git rev-parse B:dir2/yo) &&
+	test $(git rev-parse :0:dir3/yo) = $(git rev-parse B:dir3/yo) &&
+	test $(git rev-parse :0:dirN/yo) = $(git rev-parse B:dirN/yo)
+'
+
+# Testcase 9f, Renamed directory that only contained immediate subdirs
+#   (Related to testcases 1e & 9g)
+#   Commit A: goal/{a,b}/$more_files
+#   Commit B: priority/{a,b}/$more_files
+#   Commit C: goal/{a,b}/$more_files, goal/c
+#   Expected: priority/{a,b}/$more_files, priority/c
+
+test_expect_success '9f-setup: Renamed directory that only contained immediate subdirs' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir -p goal/a &&
+	mkdir -p goal/b &&
+	echo foo >goal/a/foo &&
+	echo bar >goal/b/bar &&
+	echo baz >goal/b/baz &&
+	git add goal &&
+	test_tick &&
+	git commit -m "A" &&
+
+	git branch A &&
+	git branch B &&
+	git branch C &&
+
+	git checkout B &&
+	git mv goal/ priority &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	echo c >goal/c &&
+	git add goal/c &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '9f-check: Renamed directory that only contained immediate subdirs' '
+	git checkout B^0 &&
+
+	git merge -s recursive C^0 &&
+
+	test 4 -eq $(git ls-files -s | wc -l) &&
+
+	test $(git rev-parse HEAD:priority/a/foo) = $(git rev-parse A:goal/a/foo) &&
+	test $(git rev-parse HEAD:priority/b/bar) = $(git rev-parse A:goal/b/bar) &&
+	test $(git rev-parse HEAD:priority/b/baz) = $(git rev-parse A:goal/b/baz) &&
+	test $(git rev-parse HEAD:priority/c)     = $(git rev-parse C:goal/c) &&
+	test_must_fail git rev-parse HEAD:goal/c
+'
+
+# Testcase 9g, Renamed directory that only contained immediate subdirs, immediate subdirs renamed
+#   (Related to testcases 1e & 9f)
+#   Commit A: goal/{a,b}/$more_files
+#   Commit B: priority/{alpha,bravo}/$more_files
+#   Commit C: goal/{a,b}/$more_files, goal/c
+#   Expected: priority/{alpha,bravo}/$more_files, priority/c
+
+test_expect_success '9g-setup: Renamed directory that only contained immediate subdirs, immediate subdirs renamed' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir -p goal/a &&
+	mkdir -p goal/b &&
+	echo foo >goal/a/foo &&
+	echo bar >goal/b/bar &&
+	echo baz >goal/b/baz &&
+	git add goal &&
+	test_tick &&
+	git commit -m "A" &&
+
+	git branch A &&
+	git branch B &&
+	git branch C &&
+
+	git checkout B &&
+	mkdir priority &&
+	git mv goal/a/ priority/alpha &&
+	git mv goal/b/ priority/beta &&
+	rmdir goal/ &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	echo c >goal/c &&
+	git add goal/c &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '9g-check: Renamed directory that only contained immediate subdirs, immediate subdirs renamed' '
+	git checkout B^0 &&
+
+	git merge -s recursive C^0 &&
+
+	test 4 -eq $(git ls-files -s | wc -l) &&
+
+	test $(git rev-parse HEAD:priority/alpha/foo) = $(git rev-parse A:goal/a/foo) &&
+	test $(git rev-parse HEAD:priority/beta/bar) = $(git rev-parse A:goal/b/bar) &&
+	test $(git rev-parse HEAD:priority/beta/baz) = $(git rev-parse A:goal/b/baz) &&
+	test $(git rev-parse HEAD:priority/c)     = $(git rev-parse C:goal/c) &&
+	test_must_fail git rev-parse HEAD:goal/c
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
2.15.0.5.g9567be9905

