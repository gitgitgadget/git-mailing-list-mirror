Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 737D020437
	for <e@80x24.org>; Tue, 31 Oct 2017 23:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932423AbdJaXHg (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 19:07:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:6119 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753881AbdJaXHf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 19:07:35 -0400
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2017 16:07:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.44,326,1505804400"; 
   d="scan'208";a="169684826"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.177.230])
  by fmsmga005.fm.intel.com with ESMTP; 31 Oct 2017 16:07:35 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] sequencer: pass absolute GIT_DIR to exec commands
Date:   Tue, 31 Oct 2017 16:07:33 -0700
Message-Id: <20171031230733.18949-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.1.4.gad8c7cd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

When we replaced the old shell script based interactive rebase in
commmit 18633e1a22a6 ("rebase -i: use the rebase--helper builtin",
2017-02-09) we introduced a regression of functionality in that the
GIT_DIR would be sent to the environment of the exec command as-is.

This generally meant that it would be passed as "GIT_DIR=.git", which
causes problems for any exec command that wants to run git commands in
a subdirectory.

This isn't a very large regression, since it is not that likely that the
exec command will run a git command, and even less likely that it will
need to do so in a subdir. This regression was discovered by a build
system which uses git-describe to find the current version of the build
system, and happened to do so from the src/ sub directory of the
project.

Fix this by passing in the absolute path of the git directory into the
child environment.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 sequencer.c                   |  7 ++++++-
 t/t3404-rebase-interactive.sh | 11 +++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index f2a10cc4f24c..332a383b037d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1862,12 +1862,15 @@ static int error_failed_squash(struct commit *commit,
 
 static int do_exec(const char *command_line)
 {
+	struct argv_array child_env = ARGV_ARRAY_INIT;
 	const char *child_argv[] = { NULL, NULL };
 	int dirty, status;
 
 	fprintf(stderr, "Executing: %s\n", command_line);
 	child_argv[0] = command_line;
-	status = run_command_v_opt(child_argv, RUN_USING_SHELL);
+	argv_array_pushf(&child_env, "GIT_DIR=%s", absolute_path(get_git_dir()));
+	status = run_command_v_opt_cd_env(child_argv, RUN_USING_SHELL, NULL,
+					  child_env.argv);
 
 	/* force re-reading of the cache */
 	if (discard_cache() < 0 || read_cache() < 0)
@@ -1897,6 +1900,8 @@ static int do_exec(const char *command_line)
 		status = 1;
 	}
 
+	argv_array_clear(&child_env);
+
 	return status;
 }
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 3704dbb2ecf6..6a82d1ed876d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -108,6 +108,17 @@ test_expect_success 'rebase -i with the exec command runs from tree root' '
 	rm -fr subdir
 '
 
+test_expect_success 'rebase -i with exec allows git commands in subdirs' '
+	test_when_finished "rm -rf subdir" &&
+	test_when_finished "git rebase --abort ||:" &&
+	git checkout master &&
+	mkdir subdir && (cd subdir &&
+	set_fake_editor &&
+	FAKE_LINES="1 exec_cd_subdir_&&_git_rev-parse_--is-inside-work-tree" \
+		git rebase -i HEAD^
+	)
+'
+
 test_expect_success 'rebase -i with the exec command checks tree cleanness' '
 	git checkout master &&
 	set_fake_editor &&
-- 
2.11.1.4.gad8c7cd

