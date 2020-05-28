Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A010C433E3
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4399C207D3
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405717AbgE1SLm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 14:11:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:18378 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391468AbgE1SLE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 14:11:04 -0400
IronPort-SDR: YcyKmGeUpqT1Zul58NrR/R/xldazNhZCjLCwIPTZajQK1Cr5Ks6aObtKYmUrC7nS/TpfoaAjkH
 bvNG29dXZEhQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 11:10:52 -0700
IronPort-SDR: ztuCeCMdpktHs+kk+umkFxxV3mpRRoFWk284puiY4KyfE0YT5LVIz2esgZzugL7JENr8s8g4HJ
 dqEhPuDJVp5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="267301363"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2020 11:10:51 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 15/16] completion: improve handling of -c/-C and -b/-B in switch/checkout
Date:   Thu, 28 May 2020 11:10:47 -0700
Message-Id: <20200528181048.3509470-16-jacob.e.keller@intel.com>
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

A previous commit added several test cases highlighting the subpar
completion logic for -c/-C and -b/-B when completing git switch and git
checkout.

In order to distinguish completing the argument vs the start-point for
this option, we now use the wordlist to determine the previous full word
on the command line.

If it's -c or -C (-b/-B for checkout), then we know that we are
completing the argument for the branch name.

Given that a user who already knows the branch name they want to
complete will simply not use completion, it makes sense to complete the
small subset of local branches when completing the argument for -c/-C.

In all other cases, if -c/-C are on the command line but are not the
most recent option, then we must be completing a start-point, and should
allow completing against all references.

Update the -c/-C and -b/-B tests to indicate they now pass.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 contrib/completion/git-completion.bash | 49 ++++++++++++++++++++++++--
 t/t9902-completion.sh                  | 48 +++++++++----------------
 2 files changed, 63 insertions(+), 34 deletions(-)

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
index f8319868080f..810661b10b33 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1437,8 +1437,7 @@ test_expect_success 'git checkout - with --no-track, complete only local referen
 	EOF
 '
 
-#TODO: completing the start point of -c/-C should not include DWIM references
-test_expect_failure 'git switch - with -c, complete all references' '
+test_expect_success 'git switch - with -c, complete all references' '
 	test_completion "git switch -c new-branch " <<-\EOF
 	HEAD Z
 	master Z
@@ -1449,8 +1448,7 @@ test_expect_failure 'git switch - with -c, complete all references' '
 	EOF
 '
 
-#TODO: completing the start point of -c/-C should not include DWIM references
-test_expect_failure 'git switch - with -C, complete all references' '
+test_expect_success 'git switch - with -C, complete all references' '
 	test_completion "git switch -C new-branch " <<-\EOF
 	HEAD Z
 	master Z
@@ -1461,8 +1459,7 @@ test_expect_failure 'git switch - with -C, complete all references' '
 	EOF
 '
 
-#TODO: completing the start point of -c/-C should include all references, not just local branches
-test_expect_failure 'git switch - with -c and --track, complete all references' '
+test_expect_success 'git switch - with -c and --track, complete all references' '
 	test_completion "git switch -c new-branch --track " <<-EOF
 	HEAD Z
 	master Z
@@ -1473,8 +1470,7 @@ test_expect_failure 'git switch - with -c and --track, complete all references'
 	EOF
 '
 
-#TODO: completing the start point of -c/-C should include all references, not just local branches
-test_expect_failure 'git switch - with -C and --track, complete all references' '
+test_expect_success 'git switch - with -C and --track, complete all references' '
 	test_completion "git switch -C new-branch --track " <<-EOF
 	HEAD Z
 	master Z
@@ -1485,8 +1481,7 @@ test_expect_failure 'git switch - with -C and --track, complete all references'
 	EOF
 '
 
-#TODO: completing the start point of -c/-C should include all references, not just local branches
-test_expect_failure 'git switch - with -c and --no-track, complete all references' '
+test_expect_success 'git switch - with -c and --no-track, complete all references' '
 	test_completion "git switch -c new-branch --no-track " <<-\EOF
 	HEAD Z
 	master Z
@@ -1497,8 +1492,7 @@ test_expect_failure 'git switch - with -c and --no-track, complete all reference
 	EOF
 '
 
-#TODO: completing the start point of -c/-C should include all references, not just local branches
-test_expect_failure 'git switch - with -C and --no-track, complete all references' '
+test_expect_success 'git switch - with -C and --no-track, complete all references' '
 	test_completion "git switch -C new-branch --no-track " <<-\EOF
 	HEAD Z
 	master Z
@@ -1509,8 +1503,7 @@ test_expect_failure 'git switch - with -C and --no-track, complete all reference
 	EOF
 '
 
-#TODO: completing the start point of -b/-B should not include DWIM references
-test_expect_failure 'git checkout - with -b, complete all references' '
+test_expect_success 'git checkout - with -b, complete all references' '
 	test_completion "git checkout -b new-branch " <<-\EOF
 	HEAD Z
 	master Z
@@ -1521,8 +1514,7 @@ test_expect_failure 'git checkout - with -b, complete all references' '
 	EOF
 '
 
-#TODO: completing the start point of -b/-B should not include DWIM references
-test_expect_failure 'git checkout - with -B, complete all references' '
+test_expect_success 'git checkout - with -B, complete all references' '
 	test_completion "git checkout -B new-branch " <<-\EOF
 	HEAD Z
 	master Z
@@ -1533,8 +1525,7 @@ test_expect_failure 'git checkout - with -B, complete all references' '
 	EOF
 '
 
-#TODO: completing the start point of -b/-B should not include DWIM references
-test_expect_failure 'git checkout - with -b and --track, complete all references' '
+test_expect_success 'git checkout - with -b and --track, complete all references' '
 	test_completion "git checkout -b new-branch --track " <<-EOF
 	HEAD Z
 	master Z
@@ -1545,8 +1536,7 @@ test_expect_failure 'git checkout - with -b and --track, complete all references
 	EOF
 '
 
-#TODO: completing the start point of -b/-B should not include DWIM references
-test_expect_failure 'git checkout - with -B and --track, complete all references' '
+test_expect_success 'git checkout - with -B and --track, complete all references' '
 	test_completion "git checkout -B new-branch --track " <<-EOF
 	HEAD Z
 	master Z
@@ -1625,8 +1615,7 @@ test_expect_success 'git switch - for -C with --no-track, complete local branche
 	EOF
 '
 
-#TODO: -b/-B argument completion should not include all references
-test_expect_failure 'git checkout - for -b, complete local branches and unique remote branches' '
+test_expect_success 'git checkout - for -b, complete local branches and unique remote branches' '
 	test_completion "git checkout -b " <<-\EOF
 	branch-in-other Z
 	master Z
@@ -1635,8 +1624,7 @@ test_expect_failure 'git checkout - for -b, complete local branches and unique r
 	EOF
 '
 
-#TODO: -b/-B argument completion should not include all references
-test_expect_failure 'git checkout - for -B, complete local branches and unique remote branches' '
+test_expect_success 'git checkout - for -B, complete local branches and unique remote branches' '
 	test_completion "git checkout -B " <<-\EOF
 	branch-in-other Z
 	master Z
@@ -1645,32 +1633,28 @@ test_expect_failure 'git checkout - for -B, complete local branches and unique r
 	EOF
 '
 
-#TODO: -b/-B argument completion should not include all references
-test_expect_failure 'git checkout - for -b with --no-guess, complete local branches only' '
+test_expect_success 'git checkout - for -b with --no-guess, complete local branches only' '
 	test_completion "git checkout --no-guess -b " <<-\EOF
 	master Z
 	matching-branch Z
 	EOF
 '
 
-#TODO: -b/-B argument completion should not include all references
-test_expect_failure 'git checkout - for -B with --no-guess, complete local branches only' '
+test_expect_success 'git checkout - for -B with --no-guess, complete local branches only' '
 	test_completion "git checkout --no-guess -B " <<-\EOF
 	master Z
 	matching-branch Z
 	EOF
 '
 
-#TODO: -b/-B argument completion should not include all references
-test_expect_failure 'git checkout - for -b with --no-track, complete local branches only' '
+test_expect_success 'git checkout - for -b with --no-track, complete local branches only' '
 	test_completion "git checkout --no-track -b " <<-\EOF
 	master Z
 	matching-branch Z
 	EOF
 '
 
-#TODO: -b/-B argument completion should not include all references
-test_expect_failure 'git checkout - for -B with --no-track, complete local branches only' '
+test_expect_success 'git checkout - for -B with --no-track, complete local branches only' '
 	test_completion "git checkout --no-track -B " <<-\EOF
 	master Z
 	matching-branch Z
-- 
2.25.2

