Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BBC61F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 19:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753701AbdKJTG1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 14:06:27 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:48724 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753692AbdKJTGB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 14:06:01 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAJ4PS8002816;
        Fri, 10 Nov 2017 11:06:00 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e53631bgq-1;
        Fri, 10 Nov 2017 11:06:00 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id EA0B722F6287;
        Fri, 10 Nov 2017 11:05:59 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id E3BD22CDEB4;
        Fri, 10 Nov 2017 11:05:59 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 05/30] directory rename detection: directory splitting testcases
Date:   Fri, 10 Nov 2017 11:05:25 -0800
Message-Id: <20171110190550.27059-6-newren@gmail.com>
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
 t/t6043-merge-rename-directories.sh | 125 ++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index b737b0a105..00811f512a 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -388,4 +388,129 @@ test_expect_failure '1f-check: Split a directory into two other directories' '
 #   in section 2, plus testcases 3a and 4a.
 ###########################################################################
 
+
+###########################################################################
+# SECTION 2: Split into multiple directories, with equal number of paths
+#
+# Explore the splitting-a-directory rules a bit; what happens in the
+# edge cases?
+#
+# Note that there is a closely related case of a directory not being
+# split on either side of history, but being renamed differently on
+# each side.  See testcase 8e for that.
+###########################################################################
+
+# Testcase 2a, Directory split into two on one side, with equal numbers of paths
+#   Commit A: z/{b,c}
+#   Commit B: y/b, w/c
+#   Commit C: z/{b,c,d}
+#   Expected: y/b, w/c, z/d, with warning about z/ -> (y/ vs. w/) conflict
+test_expect_success '2a-setup: Directory split into two on one side, with equal numbers of paths' '
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
+	mkdir y &&
+	mkdir w &&
+	git mv z/b y/ &&
+	git mv z/c w/ &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	echo d >z/d &&
+	git add z/d &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_failure '2a-check: Directory split into two on one side, with equal numbers of paths' '
+	git checkout B^0 &&
+
+	test_must_fail git merge -s recursive C^0 >out &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :0:y/b) = $(git rev-parse A:z/b) &&
+	test $(git rev-parse :0:w/c) = $(git rev-parse A:z/c) &&
+	test $(git rev-parse :0:z/d) = $(git rev-parse C:z/d) &&
+	test_i18ngrep "CONFLICT.*directory rename split" out
+'
+
+# Testcase 2b, Directory split into two on one side, with equal numbers of paths
+#   Commit A: z/{b,c}
+#   Commit B: y/b, w/c
+#   Commit C: z/{b,c}, x/d
+#   Expected: y/b, w/c, x/d; No warning about z/ -> (y/ vs. w/) conflict
+test_expect_success '2b-setup: Directory split into two on one side, with equal numbers of paths' '
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
+	mkdir y &&
+	mkdir w &&
+	git mv z/b y/ &&
+	git mv z/c w/ &&
+	test_tick &&
+	git commit -m "B" &&
+
+	git checkout C &&
+	mkdir x &&
+	echo d >x/d &&
+	git add x/d &&
+	test_tick &&
+	git commit -m "C"
+'
+
+test_expect_success '2b-check: Directory split into two on one side, with equal numbers of paths' '
+	git checkout B^0 &&
+
+	git merge -s recursive C^0 >out &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :0:y/b) = $(git rev-parse A:z/b) &&
+	test $(git rev-parse :0:w/c) = $(git rev-parse A:z/c) &&
+	test $(git rev-parse :0:x/d) = $(git rev-parse C:x/d) &&
+	! test_i18ngrep "CONFLICT.*directory rename split" out
+'
+
+###########################################################################
+# Rules suggested by section 2:
+#
+#   None; the rule was already covered in section 1.  These testcases are
+#   here just to make sure the conflict resolution and necessary warning
+#   messages are handled correctly.
+###########################################################################
+
 test_done
-- 
2.15.0.5.g9567be9905

