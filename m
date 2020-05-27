Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CC6C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 11:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9AEA207D3
	for <git@archiver.kernel.org>; Wed, 27 May 2020 11:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbgE0Lil (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 07:38:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:3342 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730091AbgE0Lih (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 07:38:37 -0400
IronPort-SDR: dBWvZ5vJghku6hQ8sfJU0VnstjzQIQVhWM4bfXnhXD0qmvJnhAllpnkijQ9FmJ0HsevvC95gGf
 QYoCHE6LWzNA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 04:38:34 -0700
IronPort-SDR: IHyMFsGwk6m0TBFTRtMYXLachuQ/vA3MUoNWYfvIyoBs55yoQBHcXjgUb0NGP+8UI3ILpW7F9b
 cKQsR/+Qticw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="scan'208";a="302431802"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga008.jf.intel.com with ESMTP; 27 May 2020 04:38:34 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 8/9] completion: improve handling of -c/-C and -b/-B in switch/checkout
Date:   Wed, 27 May 2020 04:38:30 -0700
Message-Id: <20200527113831.3294409-9-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200527113831.3294409-1-jacob.e.keller@intel.com>
References: <20200527113831.3294409-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Currently, completion for git switch and git checkout do not take into
account the branch creation options, -c/-C and -b/-B respectively.

The form of git switch with -c or -C is to take a branch name followed
by a starting point. For this reason, when completing -c or -C, we ought
to be able to complete the start point as any arbitrary reference.

However, we probably do not want to complete the actual argument for
these options with any reference, as this would provide too many
unexpected items.

Use the wordlist to determine the previous word on the command line. If
it's -c or -C (-b/-B for checkout), then we know that we are completing
the argument for the branch name. One possible assumption is that we
have no valid completion. But consider that in many cases a user may
wish to complete a branch by editing the name of a pre-existing branch.

Given that a user who already knows the branch name they want to
complete will simply not use completion, it makes sense to complete the
small subset of local branches when completing the argument for -c/-C.

In all other cases, if -c/-C are on the command line but are not the
most recent option, then we must be completing a start-point, and should
allow completing against all references.

Add many tests to cover various behavior and interaction around enabling
or disabling DWIM mode.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 contrib/completion/git-completion.bash |  49 +++++-
 t/t9902-completion.sh                  | 224 +++++++++++++++++++++++++
 2 files changed, 271 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4cdf09987725..60666429dba4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1505,8 +1505,31 @@ _git_checkout ()
 		;;
 	*)
 		local dwim_opt="$(__git_checkout_default_dwim_mode)"
+		local prevword prevword="${words[cword-1]}"
 
-		if [ -n "$(__git_find_on_cmdline "-d --detach")" ]; then
+		case "$prevword" in
+			-b|-B)
+				# Complete local branches (and DWIM branch
+				# remote branch names) for an option argument
+				# specifying a new branch name. This is for
+				# convenience, assuming new branches are
+				# possibly based on pre-existing branch names.
+				__git_complete_refs $dwim_opt --mode="heads"
+				return
+				;;
+			*)
+				;;
+		esac
+
+		# At this point, we've already handled special completion for
+		# the arguments to -b/-B. There are 3 main things left we can
+		# possibly complete:
+		# 1) a start-point for -b/-B or -d/--detach
+		# 2) a remote head, for --track
+		# 3) an arbitrary reference, possibly including DWIM names
+		#
+
+		if [ -n "$(__git_find_on_cmdline "-b -B -d --detach")" ]; then
 			__git_complete_refs --mode="refs"
 		elif [ -n "$(__git_find_on_cmdline "--track")" ]; then
 			__git_complete_refs --mode="remote-heads"
@@ -2362,8 +2385,30 @@ _git_switch ()
 		;;
 	*)
 		local dwim_opt="$(__git_checkout_default_dwim_mode)"
+		local prevword prevword="${words[cword-1]}"
 
-		if [ -n "$(__git_find_on_cmdline "-d --detach")" ]; then
+		case "$prevword" in
+			-c|-C)
+				# Complete local branches (and DWIM branch
+				# remote branch names) for an option argument
+				# specifying a new branch name. This is for
+				# convenience, assuming new branches are
+				# possibly based on pre-existing branch names.
+				__git_complete_refs $dwim_opt --mode="heads"
+				return
+				;;
+			*)
+				;;
+		esac
+
+		# At this point, we've already handled special completion for
+		# -c/-C. There are 3 main things left to
+		# complete:
+		# 1) a start-point for -c/-C or -d/--detach
+		# 2) a remote head, for --track
+		# 3) a branch name, possibly including DWIM remote branches
+
+		if [ -n "$(__git_find_on_cmdline "-c -C -d --detach")" ]; then
 			__git_complete_refs --mode="refs"
 		elif [ -n "$(__git_find_on_cmdline "--track")" ]; then
 			__git_complete_refs --mode="remote-heads"
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index b09eb498d175..14ebd175dfa5 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1436,6 +1436,230 @@ test_expect_success 'git checkout - with --no-track, complete only local referen
 	EOF
 '
 
+test_expect_success 'git switch - with -c, complete all references' '
+	test_completion "git switch -c new-branch " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git switch - with -C, complete all references' '
+	test_completion "git switch -C new-branch " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git switch - with -c and --track, complete all references' '
+	test_completion "git switch -c new-branch --track " <<-EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git switch - with -C and --track, complete all references' '
+	test_completion "git switch -C new-branch --track " <<-EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git switch - with -c and --no-track, complete all references' '
+	test_completion "git switch -c new-branch --no-track " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git switch - with -C and --no-track, complete all references' '
+	test_completion "git switch -C new-branch --no-track " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - with -b, complete all references' '
+	test_completion "git checkout -b new-branch " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - with -B, complete all references' '
+	test_completion "git checkout -B new-branch " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - with -b and --track, complete all references' '
+	test_completion "git checkout -b new-branch --track " <<-EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - with -B and --track, complete all references' '
+	test_completion "git checkout -B new-branch --track " <<-EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - with -b and --no-track, complete all references' '
+	test_completion "git checkout -b new-branch --no-track " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - with -B and --no-track, complete all references' '
+	test_completion "git checkout -B new-branch --no-track " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git switch - for -c, complete local branches and unique remote branches' '
+	test_completion "git switch -c " <<-\EOF
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git switch - for -C, complete local branches and unique remote branches' '
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
+test_expect_success 'git checkout - for -b, complete local branches and unique remote branches' '
+	test_completion "git checkout -b " <<-\EOF
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git checkout - for -B, complete local branches and unique remote branches' '
+	test_completion "git checkout -B " <<-\EOF
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git checkout - for -b with --no-guess, complete local branches only' '
+	test_completion "git checkout --no-guess -b " <<-\EOF
+	master Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git checkout - for -B with --no-guess, complete local branches only' '
+	test_completion "git checkout --no-guess -B " <<-\EOF
+	master Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git checkout - for -b with --no-track, complete local branches only' '
+	test_completion "git checkout --no-track -b " <<-\EOF
+	master Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git checkout - for -B with --no-track, complete local branches only' '
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

