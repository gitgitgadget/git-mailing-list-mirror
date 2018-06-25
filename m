Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 474EB1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754733AbeFYQN0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:13:26 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:39946 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752203AbeFYQNX (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Jun 2018 12:13:23 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PGCct0000752;
        Mon, 25 Jun 2018 09:13:10 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jt01t2c67-1;
        Mon, 25 Jun 2018 09:13:10 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 54725226E7FB;
        Mon, 25 Jun 2018 09:13:10 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 474F02CDE65;
        Mon, 25 Jun 2018 09:13:10 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 3/9] t3422: new testcases for checking when incompatible options passed
Date:   Mon, 25 Jun 2018 09:12:54 -0700
Message-Id: <20180625161300.26060-4-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.9.g431b2c36d5
In-Reply-To: <20180625161300.26060-1-newren@gmail.com>
References: <20180621150023.23533-1-newren@gmail.com>
 <20180625161300.26060-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250188
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git rebase is split into three types: am, merge, and interactive.  Various
options imply different types, and which mode we are using determine which
sub-script (git-rebase--$type) is executed to finish the work.  Not all
options work with all types, so add tests for combinations where we expect
to receive an error rather than having options be silently ignored.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3422-rebase-incompatible-options.sh | 88 ++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100755 t/t3422-rebase-incompatible-options.sh

diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
new file mode 100755
index 0000000000..2687a85254
--- /dev/null
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -0,0 +1,88 @@
+#!/bin/sh
+
+test_description='test if rebase detects and aborts on incompatible options'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_seq 2 9 >foo &&
+	git add foo &&
+	git commit -m orig &&
+
+	git branch A &&
+	git branch B &&
+
+	git checkout A &&
+	test_seq 1 9 >foo &&
+	git add foo &&
+	git commit -m A &&
+
+	git checkout B &&
+	echo "q qfoo();" | q_to_tab >>foo &&
+	git add foo &&
+	git commit -m B
+'
+
+#
+# Rebase has lots of useful options like --whitepsace=fix, which are
+# actually all built in terms of flags to git-am.  Since neither
+# --merge nor --interactive (nor any options that imply those two) use
+# git-am, using them together will result in flags like --whitespace=fix
+# being ignored.  Make sure rebase warns the user and aborts instead.
+#
+
+test_rebase_am_only () {
+	opt=$1
+	shift
+	test_expect_failure "$opt incompatible with --merge" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --merge A
+	"
+
+	test_expect_failure "$opt incompatible with --strategy=ours" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --strategy=ours A
+	"
+
+	test_expect_failure "$opt incompatible with --strategy-option=ours" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --strategy=ours A
+	"
+
+	test_expect_failure "$opt incompatible with --interactive" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --interactive A
+	"
+
+	test_expect_failure "$opt incompatible with --exec" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --exec 'true' A
+	"
+
+}
+
+test_rebase_am_only --whitespace=fix
+test_rebase_am_only --ignore-whitespace
+test_rebase_am_only --committer-date-is-author-date
+test_rebase_am_only -C4
+
+test_expect_success '--preserve-merges incompatible with --signoff' '
+	git checkout B^0 &&
+	test_must_fail git rebase --preserve-merges --signoff A
+'
+
+test_expect_failure '--preserve-merges incompatible with --rebase-merges' '
+	git checkout B^0 &&
+	test_must_fail git rebase --preserve-merges --rebase-merges A
+'
+
+test_expect_failure '--rebase-merges incompatible with --strategy' '
+	git checkout B^0 &&
+	test_must_fail git rebase --rebase-merges -s resolve A
+'
+
+test_expect_failure '--rebase-merges incompatible with --strategy-option' '
+	git checkout B^0 &&
+	test_must_fail git rebase --rebase-merges -Xignore-space-change A
+'
+
+test_done
-- 
2.18.0.9.g678597d97e

