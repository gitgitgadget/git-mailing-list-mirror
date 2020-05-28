Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98DCC433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 975B2207D3
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405734AbgE1SL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 14:11:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:20263 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405708AbgE1SLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 14:11:16 -0400
IronPort-SDR: ZHtdFhEJsC/HxAmj1c8Ii8coA6cBd7aOzxUl10kvNALUVGcpY//ak6F2zGVBd2t8pL7qHAHl9B
 yd5vVo/Ie8EA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 11:10:52 -0700
IronPort-SDR: EUFkT005ZntxEkJVTc1HbVVyZTdBXindaQPH93K3HyOPMEflEv4CO27ZfB5vMankNtu1O+pIHr
 BOgF1Evrh4Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="267301351"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2020 11:10:50 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 06/16] completion: add tests showing subpar -c/C argument completion
Date:   Thu, 28 May 2020 11:10:38 -0700
Message-Id: <20200528181048.3509470-7-jacob.e.keller@intel.com>
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

When using the branch creation argument for git switch or git checkout
(-c/-C or -b/-B), the commands switch to a different mode: `git switch
-c <branch> <some-referance>` means to create a branch named <branch> at
the commit referred to by <some-reference>.

When completing git switch or git checkout, it makes sense to complete
the branch name differently from the start point.

When completing a branch, one might consider that we do not have
anything worth completing. After all, a new branch must have an entirely
new name. Consider, however, that if a user names branches using some
similar scheme, they might wish to name a new branch by modifying the
name of an existing branch.

To avoid overloading completion for the argument, it seems reasonable to
complete only the local branch names and the valid "Do What I Mean"
remote branch names.

Add tests for the completion of the argument to -c/-C and -b/-B,
highlighting this preferred completion behavior.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t9902-completion.sh | 100 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 609981244e9b..63daf43b89ec 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1588,6 +1588,106 @@ test_expect_success 'git checkout - with -B and --no-track, complete all referen
 	EOF
 '
 
+#TODO: -c/-C argument completion should not include all references
+test_expect_failure 'git switch - for -c, complete local branches and unique remote branches' '
+	test_completion "git switch -c " <<-\EOF
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	EOF
+'
+
+#TODO: -c/-C argument completion should not include all references
+test_expect_failure 'git switch - for -C, complete local branches and unique remote branches' '
+	test_completion "git switch -C " <<-\EOF
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git switch - for -c with --no-guess, complete local branches only' '
+	test_completion "git switch --no-guess -c " <<-\EOF
+	master Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git switch - for -C with --no-guess, complete local branches only' '
+	test_completion "git switch --no-guess -C " <<-\EOF
+	master Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git switch - for -c with --no-track, complete local branches only' '
+	test_completion "git switch --no-track -c " <<-\EOF
+	master Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git switch - for -C with --no-track, complete local branches only' '
+	test_completion "git switch --no-track -C " <<-\EOF
+	master Z
+	matching-branch Z
+	EOF
+'
+
+#TODO: -b/-B argument completion should not include all references
+test_expect_failure 'git checkout - for -b, complete local branches and unique remote branches' '
+	test_completion "git checkout -b " <<-\EOF
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	EOF
+'
+
+#TODO: -b/-B argument completion should not include all references
+test_expect_failure 'git checkout - for -B, complete local branches and unique remote branches' '
+	test_completion "git checkout -B " <<-\EOF
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	EOF
+'
+
+#TODO: -b/-B argument completion should not include all references
+test_expect_failure 'git checkout - for -b with --no-guess, complete local branches only' '
+	test_completion "git checkout --no-guess -b " <<-\EOF
+	master Z
+	matching-branch Z
+	EOF
+'
+
+#TODO: -b/-B argument completion should not include all references
+test_expect_failure 'git checkout - for -B with --no-guess, complete local branches only' '
+	test_completion "git checkout --no-guess -B " <<-\EOF
+	master Z
+	matching-branch Z
+	EOF
+'
+
+#TODO: -b/-B argument completion should not include all references
+test_expect_failure 'git checkout - for -b with --no-track, complete local branches only' '
+	test_completion "git checkout --no-track -b " <<-\EOF
+	master Z
+	matching-branch Z
+	EOF
+'
+
+#TODO: -b/-B argument completion should not include all references
+test_expect_failure 'git checkout - for -B with --no-track, complete local branches only' '
+	test_completion "git checkout --no-track -B " <<-\EOF
+	master Z
+	matching-branch Z
+	EOF
+'
+
 test_expect_success 'teardown after ref completion' '
 	git branch -d matching-branch &&
 	git tag -d matching-tag &&
-- 
2.25.2

