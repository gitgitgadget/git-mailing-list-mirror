Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3FC21F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 19:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753863AbdKJTG2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 14:06:28 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:48722 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753690AbdKJTGB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 14:06:01 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAJ4HCv002784;
        Fri, 10 Nov 2017 11:06:00 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e53631bgr-1;
        Fri, 10 Nov 2017 11:06:00 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 0F1E822F6281;
        Fri, 10 Nov 2017 11:06:00 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 083A32CDE6A;
        Fri, 10 Nov 2017 11:06:00 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 08/30] directory rename detection: files/directories in the way of some renames
Date:   Fri, 10 Nov 2017 11:05:28 -0800
Message-Id: <20171110190550.27059-9-newren@gmail.com>
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
 t/t6043-merge-rename-directories.sh | 303 ++++++++++++++++++++++++++++++++++++
 1 file changed, 303 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index ec054b210a..d15153c652 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -750,4 +750,307 @@ test_expect_success '4a-check: Directory split, with original directory still pr
 #   detection.)  But, sadly, see testcase 8b.
 ###########################################################################
 
+
+###########################################################################
+# SECTION 5: Files/directories in the way of subset of to-be-renamed paths
+#
+# Implicitly renaming files due to a detected directory rename could run
+# into problems if there are files or directories in the way of the paths
+# we want to rename.  Explore such cases in this section.
+###########################################################################
+
+# Testcase 5a, Merge directories, other side adds files to original and target
+#   Commit A: z/{b,c},       y/d
+#   Commit B: z/{b,c,e_1,f}, y/{d,e_2}
+#   Commit C: y/{b,c,d}
+#   Expected: z/e_1, y/{b,c,d,e_2,f} + CONFLICT warning
+#   NOTE: While directory rename detection is active here causing z/f to
+#         become y/f, we did not apply this for z/e_1 because that would
+#         give us an add/add conflict for y/e_1 vs y/e_2.  This problem with
+#         this add/add, is that both versions of y/e are from the same side
+#         of history, giving us no way to represent this conflict in the
+#         index.
+
+test_expect_success '5a-setup: Merge directories, other side adds files to original and target' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir z &&
+	echo b >z/b &&
+	echo c >z/c &&
+	mkdir y &&
+	echo d >y/d &&
+	git add z y &&
+	test_tick &&
+	git commit -m "A" &&
+
+	git branch A &&
+	git branch B &&
+	git branch C &&
+
+	git checkout B &&
+	echo e1 >z/e &&
+	echo f >z/f &&
+	echo e2 >y/e &&
+	git add z/e z/f y/e &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	git mv z/b y/ &&
+	git mv z/c y/ &&
+	rmdir z &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '5a-check: Merge directories, other side adds files to original and target' '
+	git checkout B^0 &&
+
+	test_must_fail git merge -s recursive C^0 >out &&
+
+	test 6 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :0:y/b) = $(git rev-parse A:z/b) &&
+	test $(git rev-parse :0:y/c) = $(git rev-parse A:z/c) &&
+	test $(git rev-parse :0:y/d) = $(git rev-parse A:y/d) &&
+
+	test $(git rev-parse :0:y/e) = $(git rev-parse B:y/e) &&
+	test $(git rev-parse :0:z/e) = $(git rev-parse B:z/e) &&
+
+	test $(git rev-parse :0:y/f) = $(git rev-parse B:z/f) &&
+
+	test_i18ngrep "CONFLICT.*implicit dir rename" out
+'
+
+# Testcase 5b, Rename/delete in order to get add/add/add conflict
+#   (Related to testcase 8d; these may appear slightly inconsistent to users;
+#    Also related to testcases 7d and 7e)
+#   Commit A: z/{b,c,d_1}
+#   Commit B: y/{b,c,d_2}
+#   Commit C: z/{b,c,d_1,e}, y/d_3
+#   Expected: y/{b,c,e}, CONFLICT(add/add: y/d_2 vs. y/d_3)
+#   NOTE: If z/d_1 in commit C were to be involved in dir rename detection, as
+#         we normaly would since z/ is being renamed to y/, then this would be
+#         a rename/delete (z/d_1 -> y/d_1 vs. deleted) AND an add/add/add
+#         conflict of y/d_1 vs. y/d_2 vs. y/d_3.  Add/add/add is not
+#         representable in the index, so the existence of y/d_3 needs to
+#         cause us to bail on directory rename detection for that path, falling
+#         back to git behavior without the directory rename detection.
+
+test_expect_success '5b-setup: Rename/delete in order to get add/add/add conflict' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir z &&
+	echo b >z/b &&
+	echo c >z/c &&
+	echo d1 >z/d &&
+	git add z &&
+	test_tick &&
+	git commit -m "A" &&
+
+	git branch A &&
+	git branch B &&
+	git branch C &&
+
+	git checkout B &&
+	git rm z/d &&
+	git mv z y &&
+	echo d2 >y/d &&
+	git add y/d &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	mkdir y &&
+	echo d3 >y/d &&
+	echo e >z/e &&
+	git add y/d z/e &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '5b-check: Rename/delete in order to get add/add/add conflict' '
+	git checkout B^0 &&
+
+	test_must_fail git merge -s recursive C^0 >out &&
+	test_i18ngrep "CONFLICT (add/add).* y/d" out &&
+
+	test 5 -eq $(git ls-files -s | wc -l) &&
+	test 2 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :0:y/b) = $(git rev-parse A:z/b) &&
+	test $(git rev-parse :0:y/c) = $(git rev-parse A:z/c) &&
+	test $(git rev-parse :0:y/e) = $(git rev-parse C:z/e) &&
+
+	test_must_fail git rev-parse :1:y/d &&
+	test $(git rev-parse :2:y/d) = $(git rev-parse B:y/d) &&
+	test $(git rev-parse :3:y/d) = $(git rev-parse C:y/d) &&
+	test -f y/d
+'
+
+# Testcase 5c, Transitive rename would cause rename/rename/rename/add/add/add
+#   (Directory rename detection would result in transitive rename vs.
+#    rename/rename(1to2) and turn it into a rename/rename(1to3).  Further,
+#    rename paths conflict with separate adds on the other side)
+#   (Related to testcases 3b and 7c)
+#   Commit A: z/{b,c}, x/d_1
+#   Commit B: y/{b,c,d_2}, w/d_1
+#   Commit C: z/{b,c,d_1,e}, w/d_3, y/d_4
+#   Expected: A mess, but only a rename/rename(1to2)/add/add mess.  Use the
+#             presence of y/d_4 in C to avoid doing transitive rename of
+#             x/d_1 -> z/d_1 -> y/d_1, so that the only paths we have at
+#             y/d are y/d_2 and y/d_4.  We still do the move from z/e to y/e,
+#             though, because it doesn't have anything in the way.
+
+test_expect_success '5c-setup: Transitive rename would cause rename/rename/rename/add/add/add' '
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
+	echo d2 >y/d &&
+	git add y/d &&
+	git mv x w &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	git mv x/d z/ &&
+	mkdir w &&
+	mkdir y &&
+	echo d3 >w/d &&
+	echo d4 >y/d &&
+	echo e >z/e &&
+	git add w/ y/ z/e &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '5c-check: Transitive rename would cause rename/rename/rename/add/add/add' '
+	git checkout B^0 &&
+
+	test_must_fail git merge -s recursive C^0 >out &&
+	test_i18ngrep "CONFLICT (rename/rename).*x/d.*w/d.*z/d" out &&
+	test_i18ngrep "CONFLICT (add/add).* y/d" out &&
+
+	test 9 -eq $(git ls-files -s | wc -l) &&
+	test 6 -eq $(git ls-files -u | wc -l) &&
+	test 3 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :0:y/b) = $(git rev-parse A:z/b) &&
+	test $(git rev-parse :0:y/c) = $(git rev-parse A:z/c) &&
+	test $(git rev-parse :0:y/e) = $(git rev-parse C:z/e) &&
+
+	test_must_fail git rev-parse :1:y/d &&
+	test $(git rev-parse :2:w/d) = $(git rev-parse A:x/d) &&
+	test $(git rev-parse :3:w/d) = $(git rev-parse C:w/d) &&
+	test $(git rev-parse :1:x/d) = $(git rev-parse A:x/d) &&
+	test $(git rev-parse :2:y/d) = $(git rev-parse B:y/d) &&
+	test $(git rev-parse :3:y/d) = $(git rev-parse C:y/d) &&
+	test $(git rev-parse :3:z/d) = $(git rev-parse A:x/d) &&
+
+	test $(git hash-object w/d~HEAD) = $(git rev-parse A:x/d) &&
+	test $(git hash-object w/d~C^0) = $(git rev-parse C:w/d) &&
+	test ! -f x/d &&
+	test -f y/d &&
+	grep -q "<<<<" y/d &&  # conflict markers should be present
+	test $(git hash-object z/d) = $(git rev-parse A:x/d)
+'
+
+# Testcase 5d, Directory/file/file conflict due to directory rename
+#   Commit A: z/{b,c}
+#   Commit B: y/{b,c,d_1}
+#   Commit C: z/{b,c,d_2,f}, y/d/e
+#   Expected: y/{b,c,d/e,f}, z/d_2, CONFLICT(file/directory), y/d_1~HEAD
+#   Note: The fact that y/d/ exists in C makes us bail on directory rename
+#         detection for z/d_2, but that doesn't prevent us from applying the
+#         directory rename detection for z/f -> y/f.
+
+test_expect_success '5d-setup: Directory/file/file conflict due to directory rename' '
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
+	echo d1 >y/d &&
+	git add y/d &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	mkdir -p y/d &&
+	echo e >y/d/e &&
+	echo d2 >z/d &&
+	echo f >z/f &&
+	git add y/d/e z/d z/f &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '5d-check: Directory/file/file conflict due to directory rename' '
+	git checkout B^0 &&
+
+	test_must_fail git merge -s recursive C^0 >out &&
+	test_i18ngrep "CONFLICT (file/directory).*y/d" out &&
+
+	test 6 -eq $(git ls-files -s | wc -l) &&
+	test 1 -eq $(git ls-files -u | wc -l) &&
+	test 2 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :0:y/b) = $(git rev-parse A:z/b) &&
+	test $(git rev-parse :0:y/c) = $(git rev-parse A:z/c) &&
+	test $(git rev-parse :0:z/d) = $(git rev-parse C:z/d) &&
+	test $(git rev-parse :0:y/f) = $(git rev-parse C:z/f) &&
+
+	test $(git rev-parse :2:y/d) = $(git rev-parse B:y/d) &&
+	test $(git rev-parse :0:y/d/e) = $(git rev-parse C:y/d/e) &&
+
+	test $(git hash-object y/d~HEAD) = $(git rev-parse B:y/d)
+'
+
+###########################################################################
+# Rules suggested by section 5:
+#
+#   If a subset of to-be-renamed files have a file or directory in the way,
+#   "turn off" the directory rename for those specific sub-paths, falling
+#   back to old handling.  But, sadly, see testcases 8a and 8b.
+###########################################################################
+
 test_done
-- 
2.15.0.5.g9567be9905

