Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFF411F424
	for <e@80x24.org>; Thu, 21 Dec 2017 19:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755168AbdLUTU2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 14:20:28 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:53688 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755117AbdLUTU0 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Dec 2017 14:20:26 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBLJITZs001389;
        Thu, 21 Dec 2017 11:19:08 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ew18q872j-1;
        Thu, 21 Dec 2017 11:19:07 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 8FC29220F5E9;
        Thu, 21 Dec 2017 11:19:07 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 85F202CDE6C;
        Thu, 21 Dec 2017 11:19:07 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     a.krey@gmx.de, Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/3] t6044: recursive can silently incorporate dirty changes in a merge
Date:   Thu, 21 Dec 2017 11:19:05 -0800
Message-Id: <20171221191907.4251-1-newren@gmail.com>
X-Mailer: git-send-email 2.15.1.436.g63a861020b
In-Reply-To: <CABPp-BGy3_RyVQfCm+9O_AAfKA0_CZ5ajJE7NuLbToERWyWmqQ@mail.gmail.com>
References: <CABPp-BGy3_RyVQfCm+9O_AAfKA0_CZ5ajJE7NuLbToERWyWmqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-12-21_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=808 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1712210263
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recursive merge strategy has some special handling when the tree for
the merge branch exactly matches the merge base, but that code path is
missing checks for the index having changes relative to HEAD.  Add a
testcase covering this scenario.

Reported-by: Andreas Krey <a.krey@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6044-merge-unrelated-index-changes.sh | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unr=
elated-index-changes.sh
index 01023486c5..5e472be92b 100755
--- a/t/t6044-merge-unrelated-index-changes.sh
+++ b/t/t6044-merge-unrelated-index-changes.sh
@@ -6,18 +6,21 @@ test_description=3D"merges with unrelated index changes=
"
=20
 # Testcase for some simple merges
 #   A
-#   o-----o B
+#   o-------o B
 #    \
-#     \---o C
+#     \-----o C
 #      \
-#       \-o D
+#       \---o D
 #        \
-#         o E
+#         \-o E
+#          \
+#           o F
 #   Commit A: some file a
 #   Commit B: adds file b, modifies end of a
 #   Commit C: adds file c
 #   Commit D: adds file d, modifies beginning of a
 #   Commit E: renames a->subdir/a, adds subdir/e
+#   Commit F: empty commit
=20
 test_expect_success 'setup trivial merges' '
 	test_seq 1 10 >a &&
@@ -29,6 +32,7 @@ test_expect_success 'setup trivial merges' '
 	git branch C &&
 	git branch D &&
 	git branch E &&
+	git branch F &&
=20
 	git checkout B &&
 	echo b >b &&
@@ -52,7 +56,10 @@ test_expect_success 'setup trivial merges' '
 	git mv a subdir/a &&
 	echo e >subdir/e &&
 	git add subdir &&
-	test_tick && git commit -m E
+	test_tick && git commit -m E &&
+
+	git checkout F &&
+	test_tick && git commit --allow-empty -m F
 '
=20
 test_expect_success 'ff update' '
@@ -105,6 +112,15 @@ test_expect_success 'recursive' '
 	test_must_fail git merge -s recursive C^0
 '
=20
+test_expect_failure 'recursive, when merge branch matches merge base' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	touch random_file && git add random_file &&
+
+	test_must_fail git merge -s recursive F^0
+'
+
 test_expect_success 'octopus, unrelated file touched' '
 	git reset --hard &&
 	git checkout B^0 &&
--=20
2.15.1.436.g63a861020b

