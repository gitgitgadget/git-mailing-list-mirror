Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C06B41F404
	for <e@80x24.org>; Tue, 30 Jan 2018 23:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932236AbeA3XqD (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 18:46:03 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:58666 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932206AbeA3XpU (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Jan 2018 18:45:20 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0UNN50S025761;
        Tue, 30 Jan 2018 15:25:34 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2frq6qw4dj-1;
        Tue, 30 Jan 2018 15:25:34 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 31583221A567;
        Tue, 30 Jan 2018 15:25:34 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 219622CDE88;
        Tue, 30 Jan 2018 15:25:34 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com, szeder.dev@gmail.com,
        jrnieder@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 02/31] directory rename detection: directory splitting testcases
Date:   Tue, 30 Jan 2018 15:25:04 -0800
Message-Id: <20180130232533.25846-3-newren@gmail.com>
X-Mailer: git-send-email 2.16.1.106.gf69932adfe
In-Reply-To: <20180130232533.25846-1-newren@gmail.com>
References: <20180130232533.25846-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=991 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1801300286
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 143 ++++++++++++++++++++++++++++++=
++++++
 1 file changed, 143 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-d=
irectories.sh
index d045f0e31e..b22a9052b3 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -439,4 +439,147 @@ test_expect_failure '1f-check: Split a directory in=
to two other directories' '
 #   in section 2, plus testcases 3a and 4a.
 ########################################################################=
###
=20
+
+########################################################################=
###
+# SECTION 2: Split into multiple directories, with equal number of paths
+#
+# Explore the splitting-a-directory rules a bit; what happens in the
+# edge cases?
+#
+# Note that there is a closely related case of a directory not being
+# split on either side of history, but being renamed differently on
+# each side.  See testcase 8e for that.
+########################################################################=
###
+
+# Testcase 2a, Directory split into two on one side, with equal numbers =
of paths
+#   Commit O: z/{b,c}
+#   Commit A: y/b, w/c
+#   Commit B: z/{b,c,d}
+#   Expected: y/b, w/c, z/d, with warning about z/ -> (y/ vs. w/) confli=
ct
+test_expect_success '2a-setup: Directory split into two on one side, wit=
h equal numbers of paths' '
+	test_create_repo 2a &&
+	(
+		cd 2a &&
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
+		mkdir y &&
+		mkdir w &&
+		git mv z/b y/ &&
+		git mv z/c w/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo d >z/d &&
+		git add z/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '2a-check: Directory split into two on one side, wit=
h equal numbers of paths' '
+	(
+		cd 2a &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep "CONFLICT.*directory rename split" out &&
+
+		git ls-files -s >out &&
+		test_line_count =3D 3 out &&
+		git ls-files -u >out &&
+		test_line_count =3D 0 out &&
+		git ls-files -o >out &&
+		test_line_count =3D 1 out &&
+
+		git rev-parse >actual \
+			:0:y/b :0:w/c :0:z/d &&
+		git rev-parse >expect \
+			 O:z/b  O:z/c  B:z/d &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 2b, Directory split into two on one side, with equal numbers =
of paths
+#   Commit O: z/{b,c}
+#   Commit A: y/b, w/c
+#   Commit B: z/{b,c}, x/d
+#   Expected: y/b, w/c, x/d; No warning about z/ -> (y/ vs. w/) conflict
+test_expect_success '2b-setup: Directory split into two on one side, wit=
h equal numbers of paths' '
+	test_create_repo 2b &&
+	(
+		cd 2b &&
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
+		mkdir y &&
+		mkdir w &&
+		git mv z/b y/ &&
+		git mv z/c w/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		mkdir x &&
+		echo d >x/d &&
+		git add x/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '2b-check: Directory split into two on one side, wit=
h equal numbers of paths' '
+	(
+		cd 2b &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 >out &&
+
+		git ls-files -s >out &&
+		test_line_count =3D 3 out &&
+		git ls-files -u >out &&
+		test_line_count =3D 0 out &&
+		git ls-files -o >out &&
+		test_line_count =3D 1 out &&
+
+		git rev-parse >actual \
+			:0:y/b :0:w/c :0:x/d &&
+		git rev-parse >expect \
+			 O:z/b  O:z/c  B:x/d &&
+		test_cmp expect actual &&
+		test_i18ngrep ! "CONFLICT.*directory rename split" out
+	)
+'
+
+########################################################################=
###
+# Rules suggested by section 2:
+#
+#   None; the rule was already covered in section 1.  These testcases ar=
e
+#   here just to make sure the conflict resolution and necessary warning
+#   messages are handled correctly.
+########################################################################=
###
+
 test_done
--=20
2.16.1.106.gf69932adfe

