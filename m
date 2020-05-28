Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C59EC433E1
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66808207D3
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405712AbgE1SLQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 14:11:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:20223 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405695AbgE1SLN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 14:11:13 -0400
IronPort-SDR: Zu4cEcmmLoroYaWy6BEWJZr6DPcKzl2XRA0feuxFRy+NmPyL/HP7qZY3LkY9YPm84wPQ2381XC
 /9p6z12bMtIw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 11:10:51 -0700
IronPort-SDR: qXgUYUU9OJln+vW8dRUTc+LDtAbBqVF4ZAQ9oWtaw6iBNSoNG3fCL4/h0AZnMPlj4N8v0J3o/Y
 fyXgrOZpTBjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="267301347"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2020 11:10:50 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 03/16] completion: add tests showing subar checkout --detach logic
Date:   Thu, 28 May 2020 11:10:35 -0700
Message-Id: <20200528181048.3509470-4-jacob.e.keller@intel.com>
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

When completing words for git switch, the completion function correctly
disables the DWIM remote branch names when in the '--detach' mode. These
DWIM remote branch names will not work when the --detach option is
specified, so it does not make sense to complete them.

git checkout, however, does not disable the completion of DWIM remote
branch names in this case.

Add test cases for both git switch and git checkout showing the expected
behavior.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t9902-completion.sh | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index ff234dee4da9..01aba598e7fc 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1368,6 +1368,52 @@ test_expect_success 'git checkout - a later --no-guess overrides previous --gues
 	EOF
 '
 
+test_expect_success 'git switch - with --detach, complete all references' '
+	test_completion "git switch --detach " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+#TODO: checkout --detach incorrectly includes DWIM remote branch names
+test_expect_failure 'git checkout - with --detach, complete only references' '
+	test_completion "git checkout --detach " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git switch - with -d, complete all references' '
+	test_completion "git switch -d " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+#TODO: checkout -d incorrectly includes DWIM remote branch names
+test_expect_failure 'git checkout - with -d, complete only references' '
+	test_completion "git checkout -d " <<-\EOF
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

