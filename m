Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455F6C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EF63207D3
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391465AbgE1SLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 14:11:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:18377 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391470AbgE1SK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 14:10:57 -0400
IronPort-SDR: zcr/UwEZJ+g/B4WHioZxwsYiGcfG7gBciE3UYBmiAXIdVu12NERQNqYYplKFwD+k66/DqGyhlJ
 HS3brIfYELAQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 11:10:52 -0700
IronPort-SDR: duPwXiQZzvlkzBeDXdGFtuM7B72YZAcsSSvAtTSN2zfHn9fylxTDCvH7l2ACRp7r31HC5IUFmk
 HZuWZKFlGxsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="267301364"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2020 11:10:51 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 16/16] completion: improve handling of --orphan option of switch/checkout
Date:   Thu, 28 May 2020 11:10:48 -0700
Message-Id: <20200528181048.3509470-17-jacob.e.keller@intel.com>
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

The --orphan option is used to create a local branch which is detached
from the current history. In git switch, it always resets to the empty
tree, and thus the only completion we can provide is a branch name.
Follow the same rules for -c/-C (and -b/-B) when completing the argument
to --orphan.

In the case of git switch, after we complete the argument, there is
nothing more we can complete for git switch, so do not even try. Nothing
else would be valid.

In the case of git checkout, --orphan takes a start point which it uses
to determine the checked out tree, even though it created orphaned
history.

Update the previously added test cases as they are now passing.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 contrib/completion/git-completion.bash | 21 ++++++++++++++-------
 t/t9902-completion.sh                  |  9 +++------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 60666429dba4..de85b84f8116 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1508,7 +1508,7 @@ _git_checkout ()
 		local prevword prevword="${words[cword-1]}"
 
 		case "$prevword" in
-			-b|-B)
+			-b|-B|--orphan)
 				# Complete local branches (and DWIM branch
 				# remote branch names) for an option argument
 				# specifying a new branch name. This is for
@@ -1522,14 +1522,14 @@ _git_checkout ()
 		esac
 
 		# At this point, we've already handled special completion for
-		# the arguments to -b/-B. There are 3 main things left we can
-		# possibly complete:
-		# 1) a start-point for -b/-B or -d/--detach
+		# the arguments to -b/-B, and --orphan. There are 3 main
+		# things left we can possibly complete:
+		# 1) a start-point for -b/-B, -d/--detach, or --orphan
 		# 2) a remote head, for --track
 		# 3) an arbitrary reference, possibly including DWIM names
 		#
 
-		if [ -n "$(__git_find_on_cmdline "-b -B -d --detach")" ]; then
+		if [ -n "$(__git_find_on_cmdline "-b -B -d --detach --orphan")" ]; then
 			__git_complete_refs --mode="refs"
 		elif [ -n "$(__git_find_on_cmdline "--track")" ]; then
 			__git_complete_refs --mode="remote-heads"
@@ -2388,7 +2388,7 @@ _git_switch ()
 		local prevword prevword="${words[cword-1]}"
 
 		case "$prevword" in
-			-c|-C)
+			-c|-C|--orphan)
 				# Complete local branches (and DWIM branch
 				# remote branch names) for an option argument
 				# specifying a new branch name. This is for
@@ -2401,8 +2401,15 @@ _git_switch ()
 				;;
 		esac
 
+		# Unlike in git checkout, git switch --orphan does not take
+		# a start point. Thus we really have nothing to complete after
+		# the branch name.
+		if [ -n "$(__git_find_on_cmdline "--orphan")" ]; then
+			return
+		fi
+
 		# At this point, we've already handled special completion for
-		# -c/-C. There are 3 main things left to
+		# -c/-C, and --orphan. There are 3 main things left to
 		# complete:
 		# 1) a start-point for -c/-C or -d/--detach
 		# 2) a remote head, for --track
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 810661b10b33..d42b4191b9cb 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1670,15 +1670,13 @@ test_expect_success 'git switch - with --orphan completes local branch names and
 	EOF
 '
 
-#TODO: switch --orphan does not take a start-point and thus has nothing to complete
-test_expect_failure 'git switch - --orphan with branch already provided completes nothing else' '
+test_expect_success 'git switch - --orphan with branch already provided completes nothing else' '
 	test_completion "git switch --orphan master " <<-\EOF
 
 	EOF
 '
 
-#TODO: --orphan argument completion should not include all references
-test_expect_failure 'git checkout - with --orphan completes local branch names and unique remote branch names' '
+test_expect_success 'git checkout - with --orphan completes local branch names and unique remote branch names' '
 	test_completion "git checkout --orphan " <<-\EOF
 	branch-in-other Z
 	master Z
@@ -1687,8 +1685,7 @@ test_expect_failure 'git checkout - with --orphan completes local branch names a
 	EOF
 '
 
-#TODO: checkout --orphan start-point completion should not included DWIM remote unique branch names
-test_expect_failure 'git checkout - --orphan with branch already provided completes local refs for a start-point' '
+test_expect_success 'git checkout - --orphan with branch already provided completes local refs for a start-point' '
 	test_completion "git checkout --orphan master " <<-\EOF
 	HEAD Z
 	master Z
-- 
2.25.2

