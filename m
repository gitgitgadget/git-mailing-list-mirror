Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756A1C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6708F207D3
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405714AbgE1SLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 14:11:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:20263 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405703AbgE1SLM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 14:11:12 -0400
IronPort-SDR: GansAO7Rrjv0qTdzaF5ax2F4T/a+grhqkBUwyn3SFexhrd1NB7hZg86zluwBglDSzvddRqixxb
 TsYVYmYzhLog==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 11:10:51 -0700
IronPort-SDR: qat4QfBtO6srlGnW/i6HwEtiOtx79GLcLAlP8LuxUAAvzUfevZTwSatcXdx2ECjwcHYQCYgFjI
 tEkFrWEjQaVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="267301348"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2020 11:10:50 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 04/16] completion: add tests showing subpar switch/checkout --track logic
Date:   Thu, 28 May 2020 11:10:36 -0700
Message-Id: <20200528181048.3509470-5-jacob.e.keller@intel.com>
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

When the --track option is provided to git switch or git checkout, and
no branch is specified by -c or -b, git will interpret the tracking
branch to determine the local branch name to use. This "Do What I Mean"
logic is similar but distinct from the default DWIM logic of
interpreting a unique remote branch name as a request to create and
track that branch.

For example, `git switch --track origin/master` is interpreted as
a request to create a local branch named master that is tracking
origin/master.

The current completion for git checkout in this regard is only somewhat
poor:

 $git checkout --track <TAB>
 HEAD
 master
 matching-branch
 matching-tag
 other/branch-in-other
 other/master-in-other

At least it still includes remote references. The clutter from including
all references isn't too bad.

However, git switch completion is terrible:

 $git switch --track <TAB>
 master
 matching-branch

It only shows local branches, not even allowing any form of completion
of the remote references!

Add tests which highlight the expected behavior of completing --track on
its own.

Note that when -c/-C or -b/-B are provided we do expect completing more
references, but this will be discussed in a future change that addresses
these options specifically.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t9902-completion.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 01aba598e7fc..8a3995f82f38 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1414,6 +1414,40 @@ test_expect_failure 'git checkout - with -d, complete only references' '
 	EOF
 '
 
+#TODO: --track should only complete fully specified remote branches
+test_expect_failure 'git switch - with --track, complete only remote branches' '
+	test_completion "git switch --track " <<-\EOF
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+#TODO: --track should only complete fully specified remote branches
+test_expect_failure 'git checkout - with --track, complete only remote branches' '
+	test_completion "git checkout --track " <<-\EOF
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git switch - with --no-track, complete only local branch names' '
+	test_completion "git switch --no-track " <<-\EOF
+	master Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git checkout - with --no-track, complete only local references' '
+	test_completion "git checkout --no-track " <<-\EOF
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

