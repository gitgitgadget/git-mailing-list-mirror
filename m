Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCE141F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162415AbeBNSyG (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:54:06 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:37050 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1162342AbeBNSwh (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Feb 2018 13:52:37 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1EIm5f7011989;
        Wed, 14 Feb 2018 10:52:08 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2g1xgry8kb-1;
        Wed, 14 Feb 2018 10:52:07 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 0641C225963B;
        Wed, 14 Feb 2018 10:52:07 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id F16B12CDEB7;
        Wed, 14 Feb 2018 10:52:06 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v8 10/29] directory rename detection: tests for handling overwriting untracked files
Date:   Wed, 14 Feb 2018 10:51:47 -0800
Message-Id: <20180214185206.15492-11-newren@gmail.com>
X-Mailer: git-send-email 2.16.1.232.g28d5be9217
In-Reply-To: <20180214185206.15492-1-newren@gmail.com>
References: <20180214185206.15492-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1802140219
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 367 ++++++++++++++++++++++++++++++=
++++++
 1 file changed, 367 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-d=
irectories.sh
index cbbb949014..a6cd38336c 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -2879,4 +2879,371 @@ test_expect_failure '9g-check: Renamed directory =
that only contained immediate s
 #   side of history for any implicit directory renames.
 ########################################################################=
###
=20
+########################################################################=
###
+# SECTION 10: Handling untracked files
+#
+# unpack_trees(), upon which the recursive merge algorithm is based, abo=
rts
+# the operation if untracked or dirty files would be deleted or overwrit=
ten
+# by the merge.  Unfortunately, unpack_trees() does not understand renam=
es,
+# and if it doesn't abort, then it muddies up the working directory befo=
re
+# we even get to the point of detecting renames, so we need some special
+# handling, at least in the case of directory renames.
+########################################################################=
###
+
+# Testcase 10a, Overwrite untracked: normal rename/delete
+#   Commit O: z/{b,c_1}
+#   Commit A: z/b + untracked z/c + untracked z/d
+#   Commit B: z/{b,d_1}
+#   Expected: Aborted Merge +
+#       ERROR_MSG(untracked working tree files would be overwritten by m=
erge)
+
+test_expect_success '10a-setup: Overwrite untracked with normal rename/d=
elete' '
+	test_create_repo 10a &&
+	(
+		cd 10a &&
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
+		git rm z/c &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv z/c z/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '10a-check: Overwrite untracked with normal rename/d=
elete' '
+	(
+		cd 10a &&
+
+		git checkout A^0 &&
+		echo very >z/c &&
+		echo important >z/d &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep "The following untracked working tree files would be ove=
rwritten by merge" err &&
+
+		git ls-files -s >out &&
+		test_line_count =3D 1 out &&
+		git ls-files -o >out &&
+		test_line_count =3D 4 out &&
+
+		echo very >expect &&
+		test_cmp expect z/c &&
+
+		echo important >expect &&
+		test_cmp expect z/d &&
+
+		git rev-parse HEAD:z/b >actual &&
+		git rev-parse O:z/b >expect &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 10b, Overwrite untracked: dir rename + delete
+#   Commit O: z/{b,c_1}
+#   Commit A: y/b + untracked y/{c,d,e}
+#   Commit B: z/{b,d_1,e}
+#   Expected: Failed Merge; y/b + untracked y/c + untracked y/d on disk =
+
+#             z/c_1 -> z/d_1 rename recorded at stage 3 for y/d +
+#       ERROR_MSG(refusing to lose untracked file at 'y/d')
+
+test_expect_success '10b-setup: Overwrite untracked with dir rename + de=
lete' '
+	test_create_repo 10b &&
+	(
+		cd 10b &&
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
+		git rm z/c &&
+		git mv z/ y/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv z/c z/d &&
+		echo e >z/e &&
+		git add z/e &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '10b-check: Overwrite untracked with dir rename + de=
lete' '
+	(
+		cd 10b &&
+
+		git checkout A^0 &&
+		echo very >y/c &&
+		echo important >y/d &&
+		echo contents >y/e &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep "CONFLICT (rename/delete).*Version B\^0 of y/d left in t=
ree at y/d~B\^0" out &&
+		test_i18ngrep "Error: Refusing to lose untracked file at y/e; writing =
to y/e~B\^0 instead" out &&
+
+		git ls-files -s >out &&
+		test_line_count =3D 3 out &&
+		git ls-files -u >out &&
+		test_line_count =3D 2 out &&
+		git ls-files -o >out &&
+		test_line_count =3D 5 out &&
+
+		git rev-parse >actual \
+			:0:y/b :3:y/d :3:y/e &&
+		git rev-parse >expect \
+			O:z/b  O:z/c  B:z/e &&
+		test_cmp expect actual &&
+
+		echo very >expect &&
+		test_cmp expect y/c &&
+
+		echo important >expect &&
+		test_cmp expect y/d &&
+
+		echo contents >expect &&
+		test_cmp expect y/e
+	)
+'
+
+# Testcase 10c, Overwrite untracked: dir rename/rename(1to2)
+#   Commit O: z/{a,b}, x/{c,d}
+#   Commit A: y/{a,b}, w/c, x/d + different untracked y/c
+#   Commit B: z/{a,b,c}, x/d
+#   Expected: Failed Merge; y/{a,b} + x/d + untracked y/c +
+#             CONFLICT(rename/rename) x/c -> w/c vs y/c +
+#             y/c~B^0 +
+#             ERROR_MSG(Refusing to lose untracked file at y/c)
+
+test_expect_success '10c-setup: Overwrite untracked with dir rename/rena=
me(1to2)' '
+	test_create_repo 10c &&
+	(
+		cd 10c &&
+
+		mkdir z x &&
+		echo a >z/a &&
+		echo b >z/b &&
+		echo c >x/c &&
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
+		mkdir w &&
+		git mv x/c w/c &&
+		git mv z/ y/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv x/c z/ &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '10c-check: Overwrite untracked with dir rename/rena=
me(1to2)' '
+	(
+		cd 10c &&
+
+		git checkout A^0 &&
+		echo important >y/c &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep "CONFLICT (rename/rename)" out &&
+		test_i18ngrep "Refusing to lose untracked file at y/c; adding as y/c~B=
\^0 instead" out &&
+
+		git ls-files -s >out &&
+		test_line_count =3D 6 out &&
+		git ls-files -u >out &&
+		test_line_count =3D 3 out &&
+		git ls-files -o >out &&
+		test_line_count =3D 3 out &&
+
+		git rev-parse >actual \
+			:0:y/a :0:y/b :0:x/d :1:x/c :2:w/c :3:y/c &&
+		git rev-parse >expect \
+			 O:z/a  O:z/b  O:x/d  O:x/c  O:x/c  O:x/c &&
+		test_cmp expect actual &&
+
+		git hash-object y/c~B^0 >actual &&
+		git rev-parse O:x/c >expect &&
+		test_cmp expect actual &&
+
+		echo important >expect &&
+		test_cmp expect y/c
+	)
+'
+
+# Testcase 10d, Delete untracked w/ dir rename/rename(2to1)
+#   Commit O: z/{a,b,c_1},        x/{d,e,f_2}
+#   Commit A: y/{a,b},            x/{d,e,f_2,wham_1} + untracked y/wham
+#   Commit B: z/{a,b,c_1,wham_2}, y/{d,e}
+#   Expected: Failed Merge; y/{a,b,d,e} + untracked y/{wham,wham~B^0,wha=
m~HEAD}+
+#             CONFLICT(rename/rename) z/c_1 vs x/f_2 -> y/wham
+#             ERROR_MSG(Refusing to lose untracked file at y/wham)
+
+test_expect_success '10d-setup: Delete untracked with dir rename/rename(=
2to1)' '
+	test_create_repo 10d &&
+	(
+		cd 10d &&
+
+		mkdir z x &&
+		echo a >z/a &&
+		echo b >z/b &&
+		echo c >z/c &&
+		echo d >x/d &&
+		echo e >x/e &&
+		echo f >x/f &&
+		git add z x &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv z/c x/wham &&
+		git mv z/ y/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv x/f z/wham &&
+		git mv x/ y/ &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '10d-check: Delete untracked with dir rename/rename(=
2to1)' '
+	(
+		cd 10d &&
+
+		git checkout A^0 &&
+		echo important >y/wham &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep "CONFLICT (rename/rename)" out &&
+		test_i18ngrep "Refusing to lose untracked file at y/wham" out &&
+
+		git ls-files -s >out &&
+		test_line_count =3D 6 out &&
+		git ls-files -u >out &&
+		test_line_count =3D 2 out &&
+		git ls-files -o >out &&
+		test_line_count =3D 4 out &&
+
+		git rev-parse >actual \
+			:0:y/a :0:y/b :0:y/d :0:y/e :2:y/wham :3:y/wham &&
+		git rev-parse >expect \
+			 O:z/a  O:z/b  O:x/d  O:x/e  O:z/c     O:x/f &&
+		test_cmp expect actual &&
+
+		test_must_fail git rev-parse :1:y/wham &&
+
+		echo important >expect &&
+		test_cmp expect y/wham &&
+
+		git hash-object >actual \
+			y/wham~B^0 y/wham~HEAD &&
+		git rev-parse >expect \
+			O:x/f      O:z/c &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 10e, Does git complain about untracked file that's not in the=
 way?
+#   Commit O: z/{a,b}
+#   Commit A: y/{a,b} + untracked z/c
+#   Commit B: z/{a,b,c}
+#   Expected: y/{a,b,c} + untracked z/c
+
+test_expect_success '10e-setup: Does git complain about untracked file t=
hat is not really in the way?' '
+	test_create_repo 10e &&
+	(
+		cd 10e &&
+
+		mkdir z &&
+		echo a >z/a &&
+		echo b >z/b &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv z/ y/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo c >z/c &&
+		git add z/c &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '10e-check: Does git complain about untracked file t=
hat is not really in the way?' '
+	(
+		cd 10e &&
+
+		git checkout A^0 &&
+		mkdir z &&
+		echo random >z/c &&
+
+		git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep ! "following untracked working tree files would be overw=
ritten by merge" err &&
+
+		git ls-files -s >out &&
+		test_line_count =3D 3 out &&
+		git ls-files -u >out &&
+		test_line_count =3D 0 out &&
+		git ls-files -o >out &&
+		test_line_count =3D 3 out &&
+
+		git rev-parse >actual \
+			:0:y/a :0:y/b :0:y/c &&
+		git rev-parse >expect \
+			 O:z/a  O:z/b  B:z/c &&
+		test_cmp expect actual &&
+
+		echo random >expect &&
+		test_cmp expect z/c
+	)
+'
+
 test_done
--=20
2.16.1.232.g28d5be9217

