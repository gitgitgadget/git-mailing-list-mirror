Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E02C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38FDF207D3
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391436AbgE1SKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 14:10:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:18371 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391368AbgE1SKw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 14:10:52 -0400
IronPort-SDR: vMYFGKBjI/X9JmUWdgHiII6ObfeffszL2SW5s9CA8dP99rWKKp4S2PcKqrE15HaZP7EnkDXCGi
 aif4iZXmf5Kg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 11:10:52 -0700
IronPort-SDR: ZylF4I/4058/udv7NQlNmxAzB3wjrzFCSmuPEmWlAOWOmxh5vs/ezRA3oFop7tWUM258OdS2YE
 /db78+cXMdJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="267301352"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2020 11:10:51 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 07/16] completion: add tests showing subpar switch/checkout --orphan logic
Date:   Thu, 28 May 2020 11:10:39 -0700
Message-Id: <20200528181048.3509470-8-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200528181048.3509470-1-jacob.e.keller@intel.com>
References: <20200528181048.3509470-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Similar to -c/-C, --orphan takes an argument which is the branch name to
use. We ought to complete this branch name using similar rules as to how
we complete new branch names for -c/-C and -b/-B. Namely, limit the
total number of options provided by completing to the local branches.

Additionally, git switch --orphan does not take any start point and will
always create using the empty-tree. Thus, after the branch name is
completed, git switch --orphan should not complete any references.

Add test cases showing the expected behavior of --orphan, for both the
argument and starting point.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t9902-completion.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 63daf43b89ec..e4c48b20d39d 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1688,6 +1688,45 @@ test_expect_failure 'git checkout - for -B with --no-track, complete local branc
 	EOF
 '
 
+#TODO: --orphan argument completion should not include all references
+test_expect_failure 'git switch - with --orphan completes local branch names and unique remote branch names' '
+	test_completion "git switch --orphan " <<-\EOF
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	EOF
+'
+
+#TODO: switch --orphan does not take a start-point and thus has nothing to complete
+test_expect_failure 'git switch - --orphan with branch already provided completes nothing else' '
+	test_completion "git switch --orphan master " <<-\EOF
+
+	EOF
+'
+
+#TODO: --orphan argument completion should not include all references
+test_expect_failure 'git checkout - with --orphan completes local branch names and unique remote branch names' '
+	test_completion "git checkout --orphan " <<-\EOF
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	EOF
+'
+
+#TODO: checkout --orphan start-point completion should not included DWIM remote unique branch names
+test_expect_failure 'git checkout - --orphan with branch already provided completes local refs for a start-point' '
+	test_completion "git checkout --orphan master " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
 test_expect_success 'teardown after ref completion' '
 	git branch -d matching-branch &&
 	git tag -d matching-tag &&
-- 
2.25.2

