Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FA1F1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162413AbeBNSxs (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:53:48 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:39146 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1162361AbeBNSxW (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Feb 2018 13:53:22 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1EInD7s002757;
        Wed, 14 Feb 2018 10:52:07 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2g1yfs779p-1;
        Wed, 14 Feb 2018 10:52:06 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id A8F3422595E9;
        Wed, 14 Feb 2018 10:52:06 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id A279F2CDEB4;
        Wed, 14 Feb 2018 10:52:06 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v8 03/29] directory rename detection: testcases to avoid taking detection too far
Date:   Wed, 14 Feb 2018 10:51:40 -0800
Message-Id: <20180214185206.15492-4-newren@gmail.com>
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
 t/t6043-merge-rename-directories.sh | 153 ++++++++++++++++++++++++++++++=
++++++
 1 file changed, 153 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-d=
irectories.sh
index b22a9052b3..8049ed5fc9 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -582,4 +582,157 @@ test_expect_success '2b-check: Directory split into=
 two on one side, with equal
 #   messages are handled correctly.
 ########################################################################=
###
=20
+
+########################################################################=
###
+# SECTION 3: Path in question is the source path for some rename already
+#
+# Combining cases from Section 1 and trying to handle them could lead to
+# directory renaming detection being over-applied.  So, this section
+# provides some good testcases to check that the implementation doesn't =
go
+# too far.
+########################################################################=
###
+
+# Testcase 3a, Avoid implicit rename if involved as source on other side
+#   (Related to testcases 1c and 1f)
+#   Commit O: z/{b,c,d}
+#   Commit A: z/{b,c,d} (no change)
+#   Commit B: y/{b,c}, x/d
+#   Expected: y/{b,c}, x/d
+test_expect_success '3a-setup: Avoid implicit rename if involved as sour=
ce on other side' '
+	test_create_repo 3a &&
+	(
+		cd 3a &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		echo d >z/d &&
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
+		git commit --allow-empty -m "A" &&
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
+test_expect_success '3a-check: Avoid implicit rename if involved as sour=
ce on other side' '
+	(
+		cd 3a &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		git ls-files -s >out &&
+		test_line_count =3D 3 out &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:x/d &&
+		git rev-parse >expect \
+			O:z/b    O:z/c    O:z/d &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 3b, Avoid implicit rename if involved as source on other side
+#   (Related to testcases 5c and 7c, also kind of 1e and 1f)
+#   Commit O: z/{b,c,d}
+#   Commit A: y/{b,c}, x/d
+#   Commit B: z/{b,c}, w/d
+#   Expected: y/{b,c}, CONFLICT:(z/d -> x/d vs. w/d)
+#   NOTE: We're particularly checking that since z/d is already involved=
 as
+#         a source in a file rename on the same side of history, that we=
 don't
+#         get it involved in directory rename detection.  If it were, we=
 might
+#         end up with CONFLICT:(z/d -> y/d vs. x/d vs. w/d), i.e. a
+#         rename/rename/rename(1to3) conflict, which is just weird.
+test_expect_success '3b-setup: Avoid implicit rename if involved as sour=
ce on current side' '
+	test_create_repo 3b &&
+	(
+		cd 3b &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		echo d >z/d &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		mkdir y &&
+		mkdir x &&
+		git mv z/b y/ &&
+		git mv z/c y/ &&
+		git mv z/d x/ &&
+		rmdir z &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		mkdir w &&
+		git mv z/d w/ &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '3b-check: Avoid implicit rename if involved as sour=
ce on current side' '
+	(
+		cd 3b &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep CONFLICT.*rename/rename.*z/d.*x/d.*w/d out &&
+		test_i18ngrep ! CONFLICT.*rename/rename.*y/d out &&
+
+		git ls-files -s >out &&
+		test_line_count =3D 5 out &&
+		git ls-files -u >out &&
+		test_line_count =3D 3 out &&
+		git ls-files -o >out &&
+		test_line_count =3D 1 out &&
+
+		git rev-parse >actual \
+			:0:y/b :0:y/c :1:z/d :2:x/d :3:w/d &&
+		git rev-parse >expect \
+			 O:z/b  O:z/c  O:z/d  O:z/d  O:z/d &&
+		test_cmp expect actual &&
+
+		test_path_is_missing z/d &&
+		git hash-object >actual \
+			x/d   w/d &&
+		git rev-parse >expect \
+			O:z/d O:z/d &&
+		test_cmp expect actual
+	)
+'
+
+########################################################################=
###
+# Rules suggested by section 3:
+#
+#   Avoid directory-rename-detection for a path, if that path is the sou=
rce
+#   of a rename on either side of a merge.
+########################################################################=
###
+
 test_done
--=20
2.16.1.232.g28d5be9217

