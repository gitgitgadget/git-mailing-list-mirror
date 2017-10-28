Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A96EE20562
	for <e@80x24.org>; Sat, 28 Oct 2017 00:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbdJ1ACA (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 20:02:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:24715 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750962AbdJ1AB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 20:01:59 -0400
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2017 17:01:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.44,306,1505804400"; 
   d="scan'208";a="1030459807"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.177.230])
  by orsmga003.jf.intel.com with ESMTP; 27 Oct 2017 17:01:58 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] rebase: exec leaks GIT_DIR to environment
Date:   Fri, 27 Oct 2017 17:01:52 -0700
Message-Id: <20171028000152.2760-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.1.4.gad8c7cd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

I noticed a failure with git rebase interactive mode which causes "exec"
commands to be run with GIT_DIR set. When GIT_DIR is in the environment,
then any command which results in running a git command in
a subdirectory will fail because GIT_DIR=".git".

This unfortunately breaks one of my project's Makefiles, which uses
git-describe to find the version information, but does so from within
a sub directory.

I'm in the process of running a bisect to find where this got
introduced, but I suspect it's part of the rebase--helper changes that
happened a while ago.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t3404-rebase-interactive.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 3704dbb2ecf6..60ab5136f702 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -108,6 +108,17 @@ test_expect_success 'rebase -i with the exec command runs from tree root' '
 	rm -fr subdir
 '
 
+test_expect_failure 'rebase -i with the exec git commands in subdirs still work' '
+	test_when_finished "rm -ff subdir" &&
+	test_when_finished "git rebase --abort" &&
+	git checkout master &&
+	mkdir subdir && (cd subdir &&
+	set_fake_editor &&
+	FAKE_LINES="1 exec_>cd_subdir_&&_git_rev-parse_--is-inside-work-tree" \
+		git rebase -i HEAD^
+	)
+'
+
 test_expect_success 'rebase -i with the exec command checks tree cleanness' '
 	git checkout master &&
 	set_fake_editor &&
-- 
2.11.1.4.gad8c7cd

