Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C2CC433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 11:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0B120873
	for <git@archiver.kernel.org>; Wed, 27 May 2020 11:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbgE0Lil (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 07:38:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:3345 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730078AbgE0Lii (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 07:38:38 -0400
IronPort-SDR: 355c11rd5OjmIN08Y5sANVJ2ljGa9ZCuvrtYmatuMhiZYZdKpRJijoPCEUc42FXKFbrQBrClQv
 iRz7cKZYOD5g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 04:38:34 -0700
IronPort-SDR: lO3A1YgpWsBJ88Kmq9PKGF0a0+O0Ro2rAia7n9TjSScgA5Rnk9wfq009YYIpPxXk9EZIyp0vuQ
 nEpWiS3edFgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="scan'208";a="302431803"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga008.jf.intel.com with ESMTP; 27 May 2020 04:38:34 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 9/9] completion: improve handling of --orphan option of switch/checkout
Date:   Wed, 27 May 2020 04:38:31 -0700
Message-Id: <20200527113831.3294409-10-jacob.e.keller@intel.com>
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

Add test cases which cover this completion behavior.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 contrib/completion/git-completion.bash | 21 ++++++++++------
 t/t9902-completion.sh                  | 35 ++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 7 deletions(-)

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
index 14ebd175dfa5..8f434a0931e5 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1660,6 +1660,41 @@ test_expect_success 'git checkout - for -B with --no-track, complete local branc
 	EOF
 '
 
+test_expect_success 'git switch - with --orphan completes local branch names and unique remote branch names' '
+	test_completion "git switch --orphan " <<-\EOF
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git switch - --orphan with branch already provided completes nothing else' '
+	test_completion "git switch --orphan master " <<-\EOF
+
+	EOF
+'
+
+test_expect_success 'git checkout - with --orphan completes local branch names and unique remote branch names' '
+	test_completion "git checkout --orphan " <<-\EOF
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git checkout - --orphan with branch already provided completes local refs for a start-point' '
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

