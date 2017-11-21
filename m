Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2509420954
	for <e@80x24.org>; Tue, 21 Nov 2017 08:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751123AbdKUICO (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 03:02:14 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:40590 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751332AbdKUIBj (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2017 03:01:39 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAL7wDtu001582;
        Tue, 21 Nov 2017 00:01:00 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2eajmr44rh-1;
        Tue, 21 Nov 2017 00:01:00 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 447952265E32;
        Tue, 21 Nov 2017 00:01:00 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 3B7E02CDEC1;
        Tue, 21 Nov 2017 00:01:00 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 08/33] directory rename detection: files/directories in the way of some renames
Date:   Tue, 21 Nov 2017 00:00:34 -0800
Message-Id: <20171121080059.32304-9-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.309.g62ce55426d
In-Reply-To: <20171121080059.32304-1-newren@gmail.com>
References: <20171121080059.32304-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-21_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711210110
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 320 ++++++++++++++++++++++++++++++=
++++++
 1 file changed, 320 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-d=
irectories.sh
index 1dcf010aa6..29b2af7f19 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -818,4 +818,324 @@ test_expect_success '4a-check: Directory split, wit=
h original directory still pr
 #   detection.)  But, sadly, see testcase 8b.
 ########################################################################=
###
=20
+
+########################################################################=
###
+# SECTION 5: Files/directories in the way of subset of to-be-renamed pat=
hs
+#
+# Implicitly renaming files due to a detected directory rename could run
+# into problems if there are files or directories in the way of the path=
s
+# we want to rename.  Explore such cases in this section.
+########################################################################=
###
+
+# Testcase 5a, Merge directories, other side adds files to original and =
target
+#   Commit O: z/{b,c},       y/d
+#   Commit A: z/{b,c,e_1,f}, y/{d,e_2}
+#   Commit B: y/{b,c,d}
+#   Expected: z/e_1, y/{b,c,d,e_2,f} + CONFLICT warning
+#   NOTE: While directory rename detection is active here causing z/f to
+#         become y/f, we did not apply this for z/e_1 because that would
+#         give us an add/add conflict for y/e_1 vs y/e_2.  This problem =
with
+#         this add/add, is that both versions of y/e are from the same s=
ide
+#         of history, giving us no way to represent this conflict in the
+#         index.
+
+test_expect_success '5a-setup: Merge directories, other side adds files =
to original and target' '
+	test_create_repo 5a &&
+	(
+		cd 5a &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		mkdir y &&
+		echo d >y/d &&
+		git add z y &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		echo e1 >z/e &&
+		echo f >z/f &&
+		echo e2 >y/e &&
+		git add z/e z/f y/e &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv z/b y/ &&
+		git mv z/c y/ &&
+		rmdir z &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '5a-check: Merge directories, other side adds files =
to original and target' '
+	(
+		cd 5a &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+
+		test 6 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 1 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			:0:y/b :0:y/c :0:y/d :0:y/e :0:z/e &&
+		git rev-parse >expect \
+			O:z/b O:z/c O:y/d A:y/e A:z/e &&
+		test_cmp expect actual &&
+
+		test $(git rev-parse :0:y/f) =3D $(git rev-parse A:z/f) &&
+
+		test_i18ngrep "CONFLICT.*implicit dir rename" out
+	)
+'
+
+# Testcase 5b, Rename/delete in order to get add/add/add conflict
+#   (Related to testcase 8d; these may appear slightly inconsistent to u=
sers;
+#    Also related to testcases 7d and 7e)
+#   Commit O: z/{b,c,d_1}
+#   Commit A: y/{b,c,d_2}
+#   Commit B: z/{b,c,d_1,e}, y/d_3
+#   Expected: y/{b,c,e}, CONFLICT(add/add: y/d_2 vs. y/d_3)
+#   NOTE: If z/d_1 in commit B were to be involved in dir rename detecti=
on, as
+#         we normaly would since z/ is being renamed to y/, then this wo=
uld be
+#         a rename/delete (z/d_1 -> y/d_1 vs. deleted) AND an add/add/ad=
d
+#         conflict of y/d_1 vs. y/d_2 vs. y/d_3.  Add/add/add is not
+#         representable in the index, so the existence of y/d_3 needs to
+#         cause us to bail on directory rename detection for that path, =
falling
+#         back to git behavior without the directory rename detection.
+
+test_expect_success '5b-setup: Rename/delete in order to get add/add/add=
 conflict' '
+	test_create_repo 5b &&
+	(
+		cd 5b &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		echo d1 >z/d &&
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
+		echo d2 >y/d &&
+		git add y/d &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		mkdir y &&
+		echo d3 >y/d &&
+		echo e >z/e &&
+		git add y/d z/e &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '5b-check: Rename/delete in order to get add/add/add=
 conflict' '
+	(
+		cd 5b &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep "CONFLICT (add/add).* y/d" out &&
+
+		test 5 -eq $(git ls-files -s | wc -l) &&
+		test 2 -eq $(git ls-files -u | wc -l) &&
+		test 1 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			:0:y/b :0:y/c :0:y/e :2:y/d :3:y/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:z/e A:y/d B:y/d &&
+		test_cmp expect actual &&
+
+		test_must_fail git rev-parse :1:y/d &&
+		test -f y/d
+	)
+'
+
+# Testcase 5c, Transitive rename would cause rename/rename/rename/add/ad=
d/add
+#   (Directory rename detection would result in transitive rename vs.
+#    rename/rename(1to2) and turn it into a rename/rename(1to3).  Furthe=
r,
+#    rename paths conflict with separate adds on the other side)
+#   (Related to testcases 3b and 7c)
+#   Commit O: z/{b,c}, x/d_1
+#   Commit A: y/{b,c,d_2}, w/d_1
+#   Commit B: z/{b,c,d_1,e}, w/d_3, y/d_4
+#   Expected: A mess, but only a rename/rename(1to2)/add/add mess.  Use =
the
+#             presence of y/d_4 in B to avoid doing transitive rename of
+#             x/d_1 -> z/d_1 -> y/d_1, so that the only paths we have at
+#             y/d are y/d_2 and y/d_4.  We still do the move from z/e to=
 y/e,
+#             though, because it doesn't have anything in the way.
+
+test_expect_success '5c-setup: Transitive rename would cause rename/rena=
me/rename/add/add/add' '
+	test_create_repo 5c &&
+	(
+		cd 5c &&
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
+		echo d2 >y/d &&
+		git add y/d &&
+		git mv x w &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv x/d z/ &&
+		mkdir w &&
+		mkdir y &&
+		echo d3 >w/d &&
+		echo d4 >y/d &&
+		echo e >z/e &&
+		git add w/ y/ z/e &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '5c-check: Transitive rename would cause rename/rena=
me/rename/add/add/add' '
+	(
+		cd 5c &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep "CONFLICT (rename/rename).*x/d.*w/d.*z/d" out &&
+		test_i18ngrep "CONFLICT (add/add).* y/d" out &&
+
+		test 9 -eq $(git ls-files -s | wc -l) &&
+		test 6 -eq $(git ls-files -u | wc -l) &&
+		test 3 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			:0:y/b :0:y/c :0:y/e &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:z/e &&
+		test_cmp expect actual &&
+
+		test_must_fail git rev-parse :1:y/d &&
+		git rev-parse >actual \
+			:2:w/d :3:w/d :1:x/d :2:y/d :3:y/d :3:z/d &&
+		git rev-parse >expect \
+			O:x/d B:w/d O:x/d A:y/d B:y/d O:x/d &&
+		test_cmp expect actual &&
+
+		git hash-object >actual \
+			w/d~HEAD w/d~B^0 &&
+		git rev-parse >expect \
+			O:x/d B:w/d &&
+		test_cmp expect actual &&
+		test ! -f x/d &&
+		test -f y/d &&
+		grep -q "<<<<" y/d &&  # conflict markers should be present
+		test $(git hash-object z/d) =3D $(git rev-parse O:x/d)
+	)
+'
+
+# Testcase 5d, Directory/file/file conflict due to directory rename
+#   Commit O: z/{b,c}
+#   Commit A: y/{b,c,d_1}
+#   Commit B: z/{b,c,d_2,f}, y/d/e
+#   Expected: y/{b,c,d/e,f}, z/d_2, CONFLICT(file/directory), y/d_1~HEAD
+#   Note: The fact that y/d/ exists in B makes us bail on directory rena=
me
+#         detection for z/d_2, but that doesn't prevent us from applying=
 the
+#         directory rename detection for z/f -> y/f.
+
+test_expect_success '5d-setup: Directory/file/file conflict due to direc=
tory rename' '
+	test_create_repo 5d &&
+	(
+		cd 5d &&
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
+		echo d1 >y/d &&
+		git add y/d &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		mkdir -p y/d &&
+		echo e >y/d/e &&
+		echo d2 >z/d &&
+		echo f >z/f &&
+		git add y/d/e z/d z/f &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '5d-check: Directory/file/file conflict due to direc=
tory rename' '
+	(
+		cd 5d &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep "CONFLICT (file/directory).*y/d" out &&
+
+		test 6 -eq $(git ls-files -s | wc -l) &&
+		test 1 -eq $(git ls-files -u | wc -l) &&
+		test 2 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			:0:y/b :0:y/c :0:z/d :0:y/f :2:y/d :0:y/d/e &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:z/d B:z/f A:y/d B:y/d/e &&
+		test_cmp expect actual &&
+
+		test $(git hash-object y/d~HEAD) =3D $(git rev-parse A:y/d)
+	)
+'
+
+########################################################################=
###
+# Rules suggested by section 5:
+#
+#   If a subset of to-be-renamed files have a file or directory in the w=
ay,
+#   "turn off" the directory rename for those specific sub-paths, fallin=
g
+#   back to old handling.  But, sadly, see testcases 8a and 8b.
+########################################################################=
###
+
 test_done
--=20
2.15.0.309.g62ce55426d

