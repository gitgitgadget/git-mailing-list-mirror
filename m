Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02B491F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 19:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbdKJTG3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 14:06:29 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:51736 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753688AbdKJTGB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 14:06:01 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAJ2vms017416;
        Fri, 10 Nov 2017 11:06:00 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e535n1cdc-1;
        Fri, 10 Nov 2017 11:06:00 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id F21B422F6280;
        Fri, 10 Nov 2017 11:05:59 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id EAE812CDE6A;
        Fri, 10 Nov 2017 11:05:59 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 06/30] directory rename detection: testcases to avoid taking detection too far
Date:   Fri, 10 Nov 2017 11:05:26 -0800
Message-Id: <20171110190550.27059-7-newren@gmail.com>
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
 t/t6043-merge-rename-directories.sh | 137 ++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 00811f512a..021513ec00 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -513,4 +513,141 @@ test_expect_success '2b-check: Directory split into two on one side, with equal
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
+#   Commit A: z/{b,c,d}
+#   Commit B: z/{b,c,d} (no change)
+#   Commit C: y/{b,c}, x/d
+#   Expected: y/{b,c}, x/d
+test_expect_success '3a-setup: Avoid implicit rename if involved as source on other side' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir z &&
+	echo b >z/b &&
+	echo c >z/c &&
+	echo d >z/d &&
+	git add z &&
+	test_tick &&
+	git commit -m "A" &&
+
+	git branch A &&
+	git branch B &&
+	git branch C &&
+
+	git checkout B &&
+	test_tick &&
+	git commit --allow-empty -m "B" &&
+
+	git checkout C &&
+	mkdir y &&
+	mkdir x &&
+	git mv z/b y/ &&
+	git mv z/c y/ &&
+	git mv z/d x/ &&
+	rmdir z &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_success '3a-check: Avoid implicit rename if involved as source on other side' '
+	git checkout B^0 &&
+
+	git merge -s recursive C^0 &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+
+	test $(git rev-parse HEAD:y/b) = $(git rev-parse A:z/b) &&
+	test $(git rev-parse HEAD:y/c) = $(git rev-parse A:z/c) &&
+	test $(git rev-parse HEAD:x/d) = $(git rev-parse A:z/d)
+'
+
+# Testcase 3b, Avoid implicit rename if involved as source on other side
+#   (Related to testcases 5c and 7c, also kind of 1e and 1f)
+#   Commit A: z/{b,c,d}
+#   Commit B: y/{b,c}, x/d
+#   Commit C: z/{b,c}, w/d
+#   Expected: y/{b,c}, CONFLICT:(z/d -> x/d vs. w/d)
+#   NOTE: We're particularly checking that since z/d is already involved as
+#         a source in a file rename on the same side of history, that we don't
+#         get it involved in directory rename detection.  If it were, we might
+#         end up with CONFLICT:(z/d -> y/d vs. x/d vs. w/d), i.e. a
+#         rename/rename/rename(1to3) conflict, which is just weird.
+test_expect_success '3b-setup: Avoid implicit rename if involved as source on current side' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir z &&
+	echo b >z/b &&
+	echo c >z/c &&
+	echo d >z/d &&
+	git add z &&
+	test_tick &&
+	git commit -m "A" &&
+
+	git branch A &&
+	git branch B &&
+	git branch C &&
+
+	git checkout B &&
+	mkdir y &&
+	mkdir x &&
+	git mv z/b y/ &&
+	git mv z/c y/ &&
+	git mv z/d x/ &&
+	rmdir z &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	mkdir w &&
+	git mv z/d w/ &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_success '3b-check: Avoid implicit rename if involved as source on current side' '
+	git checkout B^0 &&
+
+	test_must_fail git merge -s recursive C^0 >out &&
+
+	test 5 -eq $(git ls-files -s | wc -l) &&
+	test 3 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :0:y/b) = $(git rev-parse A:z/b) &&
+	test $(git rev-parse :0:y/c) = $(git rev-parse A:z/c) &&
+
+	test $(git rev-parse :1:z/d) = $(git rev-parse A:z/d) &&
+	test $(git rev-parse :2:x/d) = $(git rev-parse A:z/d) &&
+	test $(git rev-parse :3:w/d) = $(git rev-parse A:z/d) &&
+	test ! -f z/d &&
+	test $(git hash-object x/d) = $(git rev-parse A:z/d) &&
+	test $(git hash-object w/d) = $(git rev-parse A:z/d) &&
+
+	test_i18ngrep CONFLICT.*rename/rename.*z/d.*x/d.*w/d out &&
+	! test_i18ngrep CONFLICT.*rename/rename.*y/d
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
2.15.0.5.g9567be9905

