Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F1DB20954
	for <e@80x24.org>; Tue, 21 Nov 2017 08:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbdKUICN (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 03:02:13 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:40614 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751346AbdKUIBm (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2017 03:01:42 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAL7wDu2001582;
        Tue, 21 Nov 2017 00:01:02 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2eajmr44rk-2;
        Tue, 21 Nov 2017 00:01:01 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 80F012266DDC;
        Tue, 21 Nov 2017 00:01:01 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 749AE2CDE75;
        Tue, 21 Nov 2017 00:01:01 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 31/33] directory rename detection: new testcases showcasing a pair of bugs
Date:   Tue, 21 Nov 2017 00:00:57 -0800
Message-Id: <20171121080059.32304-32-newren@gmail.com>
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

Add a testcase showing spurious rename/rename(1to2) conflicts occurring
due to directory rename detection.

Also add a pair of testcases dealing with moving directory hierarchies
around that were suggested by Stefan Beller as "food for thought" during
his review of an earlier patch series, but which actually uncovered a
bug.  Round things out with a test that is a cross between the two
testcases that showed existing bugs in order to make sure we aren't
merely addressing problems in isolation but in general.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 284 ++++++++++++++++++++++++++++++=
++++++
 1 file changed, 284 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-d=
irectories.sh
index e48d5443c5..224d266695 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -153,6 +153,7 @@ test_expect_success '1b-check: Merge a directory with=
 another' '
 # Testcase 1c, Transitive renaming
 #   (Related to testcases 3a and 6d -- when should a transitive rename a=
pply?)
 #   (Related to testcases 9c and 9d -- can transitivity repeat?)
+#   (Related to testcase 12b -- joint-transitivity?)
 #   Commit O: z/{b,c},   x/d
 #   Commit A: y/{b,c},   x/d
 #   Commit B: z/{b,c,d}
@@ -2758,6 +2759,67 @@ test_expect_failure '9g-check: Renamed directory t=
hat only contained immediate s
 	)
 '
=20
+# Testcase 9h, Avoid implicit rename if involved as source on other side
+#   (Extremely closely related to testcase 3a)
+#   Commit O: z/{b,c,d_1}
+#   Commit A: z/{b,c,d_2}
+#   Commit B: y/{b,c}, x/d_1
+#   Expected: y/{b,c}, x/d_2
+#   NOTE: If we applied the z/ -> y/ rename to z/d, then we'd end up wit=
h
+#         a rename/rename(1to2) conflict (z/d -> y/d vs. x/d)
+test_expect_success '9h-setup: Avoid dir rename on merely modified path'=
 '
+	test_create_repo 9h &&
+	(
+		cd 9h &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		printf "1\n2\n3\n4\n5\n6\n7\n8\nd\n" >z/d &&
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
+		echo more >>z/d &&
+		git add z/d &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		mkdir y &&
+		mkdir x &&
+		git mv z/b y/ &&
+		git mv z/c y/ &&
+		git mv z/d x/ &&
+		rmdir z &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '9h-check: Avoid dir rename on merely modified path'=
 '
+	(
+		cd 9h &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 3 -eq $(git ls-files -s | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:x/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c A:z/d &&
+		test_cmp expect actual
+	)
+'
+
 ########################################################################=
###
 # Rules suggested by section 9:
 #
@@ -3539,4 +3601,226 @@ test_expect_success '11f-check: Avoid deleting no=
t-uptodate with dir rename/rena
 	)
 '
=20
+########################################################################=
###
+# SECTION 12: Everything else
+#
+# Tests suggested by others.  Tests added after implementation completed
+# and submitted.  Grab bag.
+########################################################################=
###
+
+# Testcase 12a, Moving one directory hierarchy into another
+#   (Related to testcase 9a)
+#   Commit O: node1/{leaf1,leaf2}, node2/{leaf3,leaf4}
+#   Commit A: node1/{leaf1,leaf2,node2/{leaf3,leaf4}}
+#   Commit B: node1/{leaf1,leaf2,leaf5}, node2/{leaf3,leaf4,leaf6}
+#   Expected: node1/{leaf1,leaf2,leaf5,node2/{leaf3,leaf4,leaf6}}
+
+test_expect_success '12a-setup: Moving one directory hierarchy into anot=
her' '
+	test_create_repo 12a &&
+	(
+		cd 12a &&
+
+		mkdir -p node1 node2 &&
+		echo leaf1 >node1/leaf1 &&
+		echo leaf2 >node1/leaf2 &&
+		echo leaf3 >node2/leaf3 &&
+		echo leaf4 >node2/leaf4 &&
+		git add node1 node2 &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv node2/ node1/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo leaf5 >node1/leaf5 &&
+		echo leaf6 >node2/leaf6 &&
+		git add node1 node2 &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '12a-check: Moving one directory hierarchy into anot=
her' '
+	(
+		cd 12a &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 6 -eq $(git ls-files -s | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:node1/leaf1 HEAD:node1/leaf2 HEAD:node1/leaf5 HEAD:node1/node2/l=
eaf3 HEAD:node1/node2/leaf4 HEAD:node1/node2/leaf6 &&
+		git rev-parse >expect \
+			O:node1/leaf1 O:node1/leaf2 B:node1/leaf5 O:node2/leaf3 O:node2/leaf4=
 B:node2/leaf6 &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 12b, Moving two directory hierarchies into each other
+#   (Related to testcases 1c and 12c)
+#   Commit O: node1/{leaf1, leaf2}, node2/{leaf3, leaf4}
+#   Commit A: node1/{leaf1, leaf2, node2/{leaf3, leaf4}}
+#   Commit B: node2/{leaf3, leaf4, node1/{leaf1, leaf2}}
+#   Expected: node1/node2/node1/{leaf1, leaf2},
+#             node2/node1/node2/{leaf3, leaf4}
+#   NOTE: Without directory renames, we would expect
+#                   node2/node1/{leaf1, leaf2},
+#                   node1/node2/{leaf3, leaf4}
+#         with directory rename detection, we note that
+#             commit A renames node2/ -> node1/node2/
+#             commit B renames node1/ -> node2/node1/
+#         therefore, applying those directory renames to the initial res=
ult
+#         (making all four paths experience a transitive renaming), yiel=
ds
+#         the expected result.
+#
+#         You may ask, is it weird to have two directories rename each o=
ther?
+#         To which, I can do no more than shrug my shoulders and say tha=
t
+#         even simple rules give weird results when given weird inputs.
+
+test_expect_success '12b-setup: Moving one directory hierarchy into anot=
her' '
+	test_create_repo 12b &&
+	(
+		cd 12b &&
+
+		mkdir -p node1 node2 &&
+		echo leaf1 >node1/leaf1 &&
+		echo leaf2 >node1/leaf2 &&
+		echo leaf3 >node2/leaf3 &&
+		echo leaf4 >node2/leaf4 &&
+		git add node1 node2 &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv node2/ node1/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv node1/ node2/ &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '12b-check: Moving one directory hierarchy into anot=
her' '
+	(
+		cd 12b &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 4 -eq $(git ls-files -s | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:node1/node2/node1/leaf1 \
+			HEAD:node1/node2/node1/leaf2 \
+			HEAD:node2/node1/node2/leaf3 \
+			HEAD:node2/node1/node2/leaf4 &&
+		git rev-parse >expect \
+			O:node1/leaf1 O:node1/leaf2 \
+			O:node2/leaf3 O:node2/leaf4 &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 12c, Moving two directory hierarchies into each other w/ cont=
ent merge
+#   (Related to testcase 12b)
+#   Commit O: node1/{       leaf1_1, leaf2_1}, node2/{leaf3_1, leaf4_1}
+#   Commit A: node1/{       leaf1_2, leaf2_2,  node2/{leaf3_2, leaf4_2}}
+#   Commit B: node2/{node1/{leaf1_3, leaf2_3},        leaf3_3, leaf4_3}
+#   Expected: Content merge conflicts for each of:
+#               node1/node2/node1/{leaf1, leaf2},
+#               node2/node1/node2/{leaf3, leaf4}
+#   NOTE: This is *exactly* like 12c, except that every path is modified=
 on
+#         each side of the merge.
+
+test_expect_success '12c-setup: Moving one directory hierarchy into anot=
her w/ content merge' '
+	test_create_repo 12c &&
+	(
+		cd 12c &&
+
+		mkdir -p node1 node2 &&
+		printf "1\n2\n3\n4\n5\n6\n7\n8\nleaf1\n" >node1/leaf1 &&
+		printf "1\n2\n3\n4\n5\n6\n7\n8\nleaf2\n" >node1/leaf2 &&
+		printf "1\n2\n3\n4\n5\n6\n7\n8\nleaf3\n" >node2/leaf3 &&
+		printf "1\n2\n3\n4\n5\n6\n7\n8\nleaf4\n" >node2/leaf4 &&
+		git add node1 node2 &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv node2/ node1/ &&
+		for i in `git ls-files`; do echo side A >>$i; done &&
+		git add -u &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv node1/ node2/ &&
+		for i in `git ls-files`; do echo side B >>$i; done &&
+		git add -u &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '12c-check: Moving one directory hierarchy into anot=
her w/ content merge' '
+	(
+		cd 12c &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 &&
+
+		test 12 -eq $(git ls-files -u | wc -l) &&
+
+		git rev-parse >actual \
+			:1:node1/node2/node1/leaf1 \
+			:1:node1/node2/node1/leaf2 \
+			:1:node2/node1/node2/leaf3 \
+			:1:node2/node1/node2/leaf4 \
+			:2:node1/node2/node1/leaf1 \
+			:2:node1/node2/node1/leaf2 \
+			:2:node2/node1/node2/leaf3 \
+			:2:node2/node1/node2/leaf4 \
+			:3:node1/node2/node1/leaf1 \
+			:3:node1/node2/node1/leaf2 \
+			:3:node2/node1/node2/leaf3 \
+			:3:node2/node1/node2/leaf4 &&
+		git rev-parse >expect \
+			O:node1/leaf1 \
+			O:node1/leaf2 \
+			O:node2/leaf3 \
+			O:node2/leaf4 \
+			A:node1/leaf1 \
+			A:node1/leaf2 \
+			A:node1/node2/leaf3 \
+			A:node1/node2/leaf4 \
+			B:node2/node1/leaf1 \
+			B:node2/node1/leaf2 \
+			B:node2/leaf3 \
+			B:node2/leaf4 &&
+		test_cmp expect actual
+	)
+'
+
 test_done
--=20
2.15.0.309.g62ce55426d

