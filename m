Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BE87202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbdKTWCQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:02:16 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38026 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751343AbdKTWCN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2017 17:02:13 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAKLxADO020076;
        Mon, 20 Nov 2017 14:02:10 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2eakkpb8qj-1;
        Mon, 20 Nov 2017 14:02:09 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 90E4422F41A6;
        Mon, 20 Nov 2017 14:02:09 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 8C7C12CDE75;
        Mon, 20 Nov 2017 14:02:09 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 06/33] directory rename detection: testcases to avoid taking detection too far
Date:   Mon, 20 Nov 2017 14:01:42 -0800
Message-Id: <20171120220209.15111-7-newren@gmail.com>
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 150 ++++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 335aa1c145..0ccabed4a2 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -564,4 +564,154 @@ test_expect_success '2b-check: Directory split into two on one side, with equal
 #   messages are handled correctly.
 ###########################################################################
 
+
+###########################################################################
+# SECTION 3: Path in question is the source path for some rename already
+#
+# Combining cases from Section 1 and trying to handle them could lead to
+# directory renaming detection being over-applied.  So, this section
+# provides some good testcases to check that the implementation doesn't go
+# too far.
+###########################################################################
+
+# Testcase 3a, Avoid implicit rename if involved as source on other side
+#   (Related to testcases 1c and 1f)
+#   Commit O: z/{b,c,d}
+#   Commit A: z/{b,c,d} (no change)
+#   Commit B: y/{b,c}, x/d
+#   Expected: y/{b,c}, x/d
+test_expect_success '3a-setup: Avoid implicit rename if involved as source on other side' '
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
+test_expect_success '3a-check: Avoid implicit rename if involved as source on other side' '
+	(
+		cd 3a &&
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
+			O:z/b O:z/c O:z/d &&
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
+#   NOTE: We're particularly checking that since z/d is already involved as
+#         a source in a file rename on the same side of history, that we don't
+#         get it involved in directory rename detection.  If it were, we might
+#         end up with CONFLICT:(z/d -> y/d vs. x/d vs. w/d), i.e. a
+#         rename/rename/rename(1to3) conflict, which is just weird.
+test_expect_success '3b-setup: Avoid implicit rename if involved as source on current side' '
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
+test_expect_success '3b-check: Avoid implicit rename if involved as source on current side' '
+	(
+		cd 3b &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+
+		test 5 -eq $(git ls-files -s | wc -l) &&
+		test 3 -eq $(git ls-files -u | wc -l) &&
+		test 1 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			:0:y/b :0:y/c :1:z/d :2:x/d :3:w/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c O:z/d O:z/d O:z/d &&
+		test_cmp expect actual &&
+
+		test ! -f z/d &&
+		git hash-object >actual \
+			x/d w/d &&
+		git rev-parse >expect \
+			O:z/d O:z/d &&
+		test_cmp expect actual &&
+
+		test_i18ngrep CONFLICT.*rename/rename.*z/d.*x/d.*w/d out &&
+	! test_i18ngrep CONFLICT.*rename/rename.*y/d
+	)
+'
+
+###########################################################################
+# Rules suggested by section 3:
+#
+#   Avoid directory-rename-detection for a path, if that path is the source
+#   of a rename on either side of a merge.
+###########################################################################
+
 test_done
-- 
2.15.0.309.g00c152f825

