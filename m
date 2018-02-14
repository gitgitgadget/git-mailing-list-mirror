Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8C961F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162397AbeBNSx0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:53:26 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:39164 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1162383AbeBNSxX (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Feb 2018 13:53:23 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1EInBTD002752;
        Wed, 14 Feb 2018 10:52:08 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2g1yfs779v-1;
        Wed, 14 Feb 2018 10:52:07 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 10165225D6A4;
        Wed, 14 Feb 2018 10:52:07 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 06F8D2CDEC1;
        Wed, 14 Feb 2018 10:52:07 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v8 11/29] directory rename detection: tests for handling overwriting dirty files
Date:   Wed, 14 Feb 2018 10:51:48 -0800
Message-Id: <20180214185206.15492-12-newren@gmail.com>
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
 t/t6043-merge-rename-directories.sh | 458 ++++++++++++++++++++++++++++++=
++++++
 1 file changed, 458 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-d=
irectories.sh
index a6cd38336c..8ea9ec49bc 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -3246,4 +3246,462 @@ test_expect_failure '10e-check: Does git complain=
 about untracked file that is n
 	)
 '
=20
+########################################################################=
###
+# SECTION 11: Handling dirty (not up-to-date) files
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
+# handling.  This was true even of normal renames, but there are additio=
nal
+# codepaths that need special handling with directory renames.  Add
+# testcases for both renamed-by-directory-rename-detection and standard
+# rename cases.
+########################################################################=
###
+
+# Testcase 11a, Avoid losing dirty contents with simple rename
+#   Commit O: z/{a,b_v1},
+#   Commit A: z/{a,c_v1}, and z/c_v1 has uncommitted mods
+#   Commit B: z/{a,b_v2}
+#   Expected: ERROR_MSG(Refusing to lose dirty file at z/c) +
+#             z/a, staged version of z/c has sha1sum matching B:z/b_v2,
+#             z/c~HEAD with contents of B:z/b_v2,
+#             z/c with uncommitted mods on top of A:z/c_v1
+
+test_expect_success '11a-setup: Avoid losing dirty contents with simple =
rename' '
+	test_create_repo 11a &&
+	(
+		cd 11a &&
+
+		mkdir z &&
+		echo a >z/a &&
+		test_seq 1 10 >z/b &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv z/b z/c &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo 11 >>z/b &&
+		git add z/b &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '11a-check: Avoid losing dirty contents with simple =
rename' '
+	(
+		cd 11a &&
+
+		git checkout A^0 &&
+		echo stuff >>z/c &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep "Refusing to lose dirty file at z/c" out &&
+
+		test_seq 1 10 >expected &&
+		echo stuff >>expected &&
+		test_cmp expected z/c &&
+
+		git ls-files -s >out &&
+		test_line_count =3D 2 out &&
+		git ls-files -u >out &&
+		test_line_count =3D 1 out &&
+		git ls-files -o >out &&
+		test_line_count =3D 4 out &&
+
+		git rev-parse >actual \
+			:0:z/a :2:z/c &&
+		git rev-parse >expect \
+			 O:z/a  B:z/b &&
+		test_cmp expect actual &&
+
+		git hash-object z/c~HEAD >actual &&
+		git rev-parse B:z/b >expect &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 11b, Avoid losing dirty file involved in directory rename
+#   Commit O: z/a,         x/{b,c_v1}
+#   Commit A: z/{a,c_v1},  x/b,       and z/c_v1 has uncommitted mods
+#   Commit B: y/a,         x/{b,c_v2}
+#   Expected: y/{a,c_v2}, x/b, z/c_v1 with uncommitted mods untracked,
+#             ERROR_MSG(Refusing to lose dirty file at z/c)
+
+
+test_expect_success '11b-setup: Avoid losing dirty file involved in dire=
ctory rename' '
+	test_create_repo 11b &&
+	(
+		cd 11b &&
+
+		mkdir z x &&
+		echo a >z/a &&
+		echo b >x/b &&
+		test_seq 1 10 >x/c &&
+		git add z x &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv x/c z/c &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv z y &&
+		echo 11 >>x/c &&
+		git add x/c &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '11b-check: Avoid losing dirty file involved in dire=
ctory rename' '
+	(
+		cd 11b &&
+
+		git checkout A^0 &&
+		echo stuff >>z/c &&
+
+		git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep "Refusing to lose dirty file at z/c" out &&
+
+		grep -q stuff z/c &&
+		test_seq 1 10 >expected &&
+		echo stuff >>expected &&
+		test_cmp expected z/c &&
+
+		git ls-files -s >out &&
+		test_line_count =3D 3 out &&
+		git ls-files -u >out &&
+		test_line_count =3D 0 out &&
+		git ls-files -m >out &&
+		test_line_count =3D 0 out &&
+		git ls-files -o >out &&
+		test_line_count =3D 4 out &&
+
+		git rev-parse >actual \
+			:0:x/b :0:y/a :0:y/c &&
+		git rev-parse >expect \
+			 O:x/b  O:z/a  B:x/c &&
+		test_cmp expect actual &&
+
+		git hash-object y/c >actual &&
+		git rev-parse B:x/c >expect &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 11c, Avoid losing not-up-to-date with rename + D/F conflict
+#   Commit O: y/a,         x/{b,c_v1}
+#   Commit A: y/{a,c_v1},  x/b,       and y/c_v1 has uncommitted mods
+#   Commit B: y/{a,c/d},   x/{b,c_v2}
+#   Expected: Abort_msg("following files would be overwritten by merge")=
 +
+#             y/c left untouched (still has uncommitted mods)
+
+test_expect_success '11c-setup: Avoid losing not-uptodate with rename + =
D/F conflict' '
+	test_create_repo 11c &&
+	(
+		cd 11c &&
+
+		mkdir y x &&
+		echo a >y/a &&
+		echo b >x/b &&
+		test_seq 1 10 >x/c &&
+		git add y x &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv x/c y/c &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		mkdir y/c &&
+		echo d >y/c/d &&
+		echo 11 >>x/c &&
+		git add x/c y/c/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '11c-check: Avoid losing not-uptodate with rename + =
D/F conflict' '
+	(
+		cd 11c &&
+
+		git checkout A^0 &&
+		echo stuff >>y/c &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep "following files would be overwritten by merge" err &&
+
+		grep -q stuff y/c &&
+		test_seq 1 10 >expected &&
+		echo stuff >>expected &&
+		test_cmp expected y/c &&
+
+		git ls-files -s >out &&
+		test_line_count =3D 3 out &&
+		git ls-files -u >out &&
+		test_line_count =3D 0 out &&
+		git ls-files -m >out &&
+		test_line_count =3D 1 out &&
+		git ls-files -o >out &&
+		test_line_count =3D 3 out
+	)
+'
+
+# Testcase 11d, Avoid losing not-up-to-date with rename + D/F conflict
+#   Commit O: z/a,         x/{b,c_v1}
+#   Commit A: z/{a,c_v1},  x/b,       and z/c_v1 has uncommitted mods
+#   Commit B: y/{a,c/d},   x/{b,c_v2}
+#   Expected: D/F: y/c_v2 vs y/c/d) +
+#             Warning_Msg("Refusing to lose dirty file at z/c) +
+#             y/{a,c~HEAD,c/d}, x/b, now-untracked z/c_v1 with uncommitt=
ed mods
+
+test_expect_success '11d-setup: Avoid losing not-uptodate with rename + =
D/F conflict' '
+	test_create_repo 11d &&
+	(
+		cd 11d &&
+
+		mkdir z x &&
+		echo a >z/a &&
+		echo b >x/b &&
+		test_seq 1 10 >x/c &&
+		git add z x &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv x/c z/c &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv z y &&
+		mkdir y/c &&
+		echo d >y/c/d &&
+		echo 11 >>x/c &&
+		git add x/c y/c/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '11d-check: Avoid losing not-uptodate with rename + =
D/F conflict' '
+	(
+		cd 11d &&
+
+		git checkout A^0 &&
+		echo stuff >>z/c &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep "Refusing to lose dirty file at z/c" out &&
+
+		grep -q stuff z/c &&
+		test_seq 1 10 >expected &&
+		echo stuff >>expected &&
+		test_cmp expected z/c
+
+		git ls-files -s >out &&
+		test_line_count =3D 4 out &&
+		git ls-files -u >out &&
+		test_line_count =3D 1 out &&
+		git ls-files -o >out &&
+		test_line_count =3D 5 out &&
+
+		git rev-parse >actual \
+			:0:x/b :0:y/a :0:y/c/d :3:y/c &&
+		git rev-parse >expect \
+			 O:x/b  O:z/a  B:y/c/d  B:x/c &&
+		test_cmp expect actual &&
+
+		git hash-object y/c~HEAD >actual &&
+		git rev-parse B:x/c >expect &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 11e, Avoid deleting not-up-to-date with dir rename/rename(1to=
2)/add
+#   Commit O: z/{a,b},      x/{c_1,d}
+#   Commit A: y/{a,b,c_2},  x/d, w/c_1, and y/c_2 has uncommitted mods
+#   Commit B: z/{a,b,c_1},  x/d
+#   Expected: Failed Merge; y/{a,b} + x/d +
+#             CONFLICT(rename/rename) x/c_1 -> w/c_1 vs y/c_1 +
+#             ERROR_MSG(Refusing to lose dirty file at y/c)
+#             y/c~B^0 has O:x/c_1 contents
+#             y/c~HEAD has A:y/c_2 contents
+#             y/c has dirty file from before merge
+
+test_expect_success '11e-setup: Avoid deleting not-uptodate with dir ren=
ame/rename(1to2)/add' '
+	test_create_repo 11e &&
+	(
+		cd 11e &&
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
+		git mv z/ y/ &&
+		echo different >y/c &&
+		mkdir w &&
+		git mv x/c w/ &&
+		git add y/c &&
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
+test_expect_failure '11e-check: Avoid deleting not-uptodate with dir ren=
ame/rename(1to2)/add' '
+	(
+		cd 11e &&
+
+		git checkout A^0 &&
+		echo mods >>y/c &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep "CONFLICT (rename/rename)" out &&
+		test_i18ngrep "Refusing to lose dirty file at y/c" out &&
+
+		git ls-files -s >out &&
+		test_line_count =3D 7 out &&
+		git ls-files -u >out &&
+		test_line_count =3D 4 out &&
+		git ls-files -o >out &&
+		test_line_count =3D 4 out &&
+
+		echo different >expected &&
+		echo mods >>expected &&
+		test_cmp expected y/c &&
+
+		git rev-parse >actual \
+			:0:y/a :0:y/b :0:x/d :1:x/c :2:w/c :2:y/c :3:y/c &&
+		git rev-parse >expect \
+			 O:z/a  O:z/b  O:x/d  O:x/c  O:x/c  A:y/c  O:x/c &&
+		test_cmp expect actual &&
+
+		git hash-object >actual \
+			y/c~B^0 y/c~HEAD &&
+		git rev-parse >expect \
+			O:x/c   A:y/c &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 11f, Avoid deleting not-up-to-date w/ dir rename/rename(2to1)
+#   Commit O: z/{a,b},        x/{c_1,d_2}
+#   Commit A: y/{a,b,wham_1}, x/d_2, except y/wham has uncommitted mods
+#   Commit B: z/{a,b,wham_2}, x/c_1
+#   Expected: Failed Merge; y/{a,b} + untracked y/{wham~B^0,wham~B^HEAD}=
 +
+#             y/wham with dirty changes from before merge +
+#             CONFLICT(rename/rename) x/c vs x/d -> y/wham
+#             ERROR_MSG(Refusing to lose dirty file at y/wham)
+
+test_expect_success '11f-setup: Avoid deleting not-uptodate with dir ren=
ame/rename(2to1)' '
+	test_create_repo 11f &&
+	(
+		cd 11f &&
+
+		mkdir z x &&
+		echo a >z/a &&
+		echo b >z/b &&
+		test_seq 1 10 >x/c &&
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
+		git mv z/ y/ &&
+		git mv x/c y/wham &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv x/d z/wham &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '11f-check: Avoid deleting not-uptodate with dir ren=
ame/rename(2to1)' '
+	(
+		cd 11f &&
+
+		git checkout A^0 &&
+		echo important >>y/wham &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+		test_i18ngrep "CONFLICT (rename/rename)" out &&
+		test_i18ngrep "Refusing to lose dirty file at y/wham" out &&
+
+		git ls-files -s >out &&
+		test_line_count =3D 4 out &&
+		git ls-files -u >out &&
+		test_line_count =3D 2 out &&
+		git ls-files -o >out &&
+		test_line_count =3D 4 out &&
+
+		test_seq 1 10 >expected &&
+		echo important >>expected &&
+		test_cmp expected y/wham &&
+
+		test_must_fail git rev-parse :1:y/wham &&
+		git hash-object >actual \
+			y/wham~B^0 y/wham~HEAD &&
+		git rev-parse >expect \
+			O:x/d      O:x/c &&
+		test_cmp expect actual &&
+
+		git rev-parse >actual \
+			:0:y/a :0:y/b :2:y/wham :3:y/wham &&
+		git rev-parse >expect \
+			 O:z/a  O:z/b  O:x/c     O:x/d &&
+		test_cmp expect actual
+	)
+'
+
 test_done
--=20
2.16.1.232.g28d5be9217

