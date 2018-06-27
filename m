Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66F4D1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 07:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932761AbeF0HXx (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 03:23:53 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:36896 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932537AbeF0HXj (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Jun 2018 03:23:39 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5R7N2cm023642;
        Wed, 27 Jun 2018 00:23:22 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ju94mtgp6-1;
        Wed, 27 Jun 2018 00:23:22 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id DDF2E22FD1A8;
        Wed, 27 Jun 2018 00:23:21 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id D28FF2CDE86;
        Wed, 27 Jun 2018 00:23:21 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 8/9] t3401: add directory rename testcases for rebase and am
Date:   Wed, 27 Jun 2018 00:23:18 -0700
Message-Id: <20180627072319.31356-9-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.9.g431b2c36d5
In-Reply-To: <20180627072319.31356-1-newren@gmail.com>
References: <20180625161300.26060-1-newren@gmail.com>
 <20180627072319.31356-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270087
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a simple directory rename testcase, in conjunction with each of the
types of rebases:
  git-rebase--interactive
  git-rebase--am
  git-rebase--merge
and also use the same testcase for
  git am --3way

This demonstrates a difference in behavior between the different rebase
backends in regards to directory rename detection.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3401-rebase-and-am-rename.sh | 105 ++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100755 t/t3401-rebase-and-am-rename.sh

diff --git a/t/t3401-rebase-and-am-rename.sh b/t/t3401-rebase-and-am-rename.sh
new file mode 100755
index 0000000000..8f832957fc
--- /dev/null
+++ b/t/t3401-rebase-and-am-rename.sh
@@ -0,0 +1,105 @@
+#!/bin/sh
+
+test_description='git rebase + directory rename tests'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_expect_success 'setup testcase' '
+	test_create_repo dir-rename &&
+	(
+		cd dir-rename &&
+
+		mkdir x &&
+		test_seq  1 10 >x/a &&
+		test_seq 11 20 >x/b &&
+		test_seq 21 30 >x/c &&
+		test_write_lines a b c d e f g h i >l &&
+		git add x l &&
+		git commit -m "Initial" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv x y &&
+		git mv l letters &&
+		git commit -m "Rename x to y, l to letters" &&
+
+		git checkout B &&
+		echo j >>l &&
+		test_seq 31 40 >x/d &&
+		git add l x/d &&
+		git commit -m "Modify l, add x/d"
+	)
+'
+
+test_expect_success 'rebase --interactive: directory rename detected' '
+	(
+		cd dir-rename &&
+
+		git checkout B^0 &&
+
+		set_fake_editor &&
+		FAKE_LINES="1" git rebase --interactive A &&
+
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+
+		test_path_is_file y/d &&
+		test_path_is_missing x/d
+	)
+'
+
+test_expect_failure 'rebase (am): directory rename detected' '
+	(
+		cd dir-rename &&
+
+		git checkout B^0 &&
+
+		git rebase A &&
+
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+
+		test_path_is_file y/d &&
+		test_path_is_missing x/d
+	)
+'
+
+test_expect_success 'rebase --merge: directory rename detected' '
+	(
+		cd dir-rename &&
+
+		git checkout B^0 &&
+
+		git rebase --merge A &&
+
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+
+		test_path_is_file y/d &&
+		test_path_is_missing x/d
+	)
+'
+
+test_expect_failure 'am: directory rename detected' '
+	(
+		cd dir-rename &&
+
+		git checkout A^0 &&
+
+		git format-patch -1 B &&
+
+		git am --3way 0001*.patch &&
+
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+
+		test_path_is_file y/d &&
+		test_path_is_missing x/d
+	)
+'
+
+test_done
-- 
2.18.0.9.g431b2c36d5

