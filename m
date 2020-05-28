Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69765C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50DEB20829
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405693AbgE1SLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 14:11:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:18377 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391370AbgE1SK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 14:10:56 -0400
IronPort-SDR: Qv3kFCbylLvRZgOSEdJHves4F6gNU2wgLKTz59gwuPkv2Eaw2/vbk5elZIdC+VNxZnF0ng8vG8
 N/dRpVYbpnag==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 11:10:52 -0700
IronPort-SDR: kXkYYBe53eS2QZ5JGeZfxRyFDDy5MWBp8GszivmKVE9TQgjVffGOovZUWCl0eKb7i3XRWXKAPh
 ghcsZFiO2hRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="267301357"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2020 11:10:51 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 11/16] completion: improve handling of DWIM mode for switch/checkout
Date:   Thu, 28 May 2020 11:10:43 -0700
Message-Id: <20200528181048.3509470-12-jacob.e.keller@intel.com>
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

A new helper, __git_find_last_on_cmdline is introduced, similar to the
already existing __git_find_on_cmdline, but which operates in reverse,
finding the *last* matching word of the provided wordlist.

Use this in a new __git_checkout_default_dwim_mode() function that will
determine when to enable listing of DWIM remote branches.

The __git_find_last_on_cmdline() function is used to determine which
--guess or --no-guess is in effect. If either one is provided, then we
unconditionally enable or disable the DWIM mode based on the last
provided option.

If neither --guess nor --no-guess is provided, then we check for
--no-track, and finally for GIT_COMPLETION_CHECKOUT_NO_GUESS=1.

This function is then used in _git_switch and _git_checkout to improve
the handling for when we enable listing of these DWIM remote branches.

This new logic is more robust, as we will correctly identify superseded
options, and ensure that both _git_switch and _git_checkout enable DWIM
in similar ways.

We can now update a few tests to indicate they pass. A few of the tests
previously added to highlight issues with the old DWIM logic still fail.
This is because of a separate issue related to the default completion
behavior of git switch, which will be addressed in a future change.

Additionally, due to this change, a few tests for the -b/-B handling of
git checkout now fail. This is a minor regression, and will be fixed by
a following change that improves the overall handling of -b/-B. Mark
these tests as known breakages for now.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 contrib/completion/git-completion.bash | 95 ++++++++++++++++++++------
 t/t9902-completion.sh                  | 17 ++---
 2 files changed, 83 insertions(+), 29 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5c13d2cd0fde..54cd676fdc9d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1135,6 +1135,40 @@ __git_find_on_cmdline ()
 	done
 }
 
+# Similar to __git_find_on_cmdline, except that it loops backwards and thus
+# prints the *last* word found. Useful for finding which of two options that
+# supersede each other came last, such as "--guess" and "--no-guess".
+#
+# Usage: __git_find_last_on_cmdline [<option>]... "<wordlist>"
+# --show-idx: Optionally show the index of the found word in the $words array.
+__git_find_last_on_cmdline ()
+{
+	local word c=$cword show_idx
+
+	while test $# -gt 1; do
+		case "$1" in
+		--show-idx)	show_idx=y ;;
+		*)		return 1 ;;
+		esac
+		shift
+	done
+	local wordlist="$1"
+
+	while [ $c -gt 1 ]; do
+		((c--))
+		for word in $wordlist; do
+			if [ "$word" = "${words[c]}" ]; then
+				if [ -n "$show_idx" ]; then
+					echo "$c $word"
+				else
+					echo "$word"
+				fi
+				return
+			fi
+		done
+	done
+}
+
 # Echo the value of an option set on the command line or config
 #
 # $1: short option name
@@ -1389,6 +1423,46 @@ _git_bundle ()
 	esac
 }
 
+# Helper function to decide whether or not we should enable DWIM logic for
+# git-switch and git-checkout.
+#
+# To decide between the following rules in priority order
+# 1) the last provided of "--guess" or "--no-guess" explicitly enable or
+#    disable completion of DWIM logic respectively.
+# 2) If the --no-track option is provided, take this as a hint to disable the
+#    DWIM completion logic
+# 3) If GIT_COMPLETION_CHECKOUT_NO_GUESS is set, disable the DWIM completion
+#    logic, as requested by the user.
+# 4) Enable DWIM logic otherwise.
+#
+__git_checkout_default_dwim_mode ()
+{
+	local last_option dwim_opt="--dwim"
+
+	if [ "$GIT_COMPLETION_CHECKOUT_NO_GUESS" = "1" ]; then
+		dwim_opt=""
+	fi
+
+	# --no-track disables DWIM, but with lower priority than
+	# --guess/--no-guess
+	if [ -n "$(__git_find_on_cmdline "--no-track")" ]; then
+		dwim_opt=""
+	fi
+
+	# Find the last provided --guess or --no-guess
+	last_option="$(__git_find_last_on_cmdline "--guess --no-guess")"
+	case "$last_option" in
+		--guess)
+			dwim_opt="--dwim"
+			;;
+		--no-guess)
+			dwim_opt=""
+			;;
+	esac
+
+	echo "$dwim_opt"
+}
+
 _git_checkout ()
 {
 	__git_has_doubledash && return
@@ -1401,13 +1475,7 @@ _git_checkout ()
 		__gitcomp_builtin checkout
 		;;
 	*)
-		# check if --track, --no-track, or --no-guess was specified
-		# if so, disable DWIM mode
-		local flags="--track --no-track --no-guess" dwim_opt="--dwim"
-		if [ "$GIT_COMPLETION_CHECKOUT_NO_GUESS" = "1" ] ||
-		   [ -n "$(__git_find_on_cmdline "$flags")" ]; then
-			dwim_opt=''
-		fi
+		local dwim_opt="$(__git_checkout_default_dwim_mode)"
 		__git_complete_refs $dwim_opt
 		;;
 	esac
@@ -2257,18 +2325,7 @@ _git_switch ()
 		__gitcomp_builtin switch
 		;;
 	*)
-		# check if --track, --no-track, or --no-guess was specified
-		# if so, disable DWIM mode
-		local dwim_opt="--dwim" only_local_ref=n
-		if [ "$GIT_COMPLETION_CHECKOUT_NO_GUESS" = "1" ] ||
-		   [ -n "$(__git_find_on_cmdline "--track --no-track --no-guess")" ]; then
-			dwim_opt=''
-		fi
-		# explicit --guess enables DWIM mode regardless of
-		# $GIT_COMPLETION_CHECKOUT_NO_GUESS
-		if [ -n "$(__git_find_on_cmdline "--guess")" ]; then
-			dwim_opt='--dwim'
-		fi
+		local dwim_opt="$(__git_checkout_default_dwim_mode)" only_local_ref=n
 		if [ -z "$(__git_find_on_cmdline "-d --detach")" ]; then
 			only_local_ref=y
 		else
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index e4c48b20d39d..13d5a47e2912 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1277,7 +1277,6 @@ test_expect_success 'git switch - with GIT_COMPLETION_CHECKOUT_NO_GUESS=1, compl
 	EOF
 '
 
-#TODO: --guess/--no-guess ordering is not taken into account
 #TODO: git switch completion includes unexpected references
 test_expect_failure 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_GUESS=1, complete local branches and unique remote names for DWIM logic' '
 	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git switch --guess " <<-\EOF
@@ -1288,7 +1287,6 @@ test_expect_failure 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_G
 	EOF
 '
 
-#TODO: --guess/--no-guess ordering is not taken into account
 #TODO: git switch completion includes unexpected references
 test_expect_failure 'git switch - a later --guess overrides previous --no-guess, complete local and remote unique branches for DWIM' '
 	test_completion "git switch --no-guess --guess " <<-\EOF
@@ -1299,8 +1297,7 @@ test_expect_failure 'git switch - a later --guess overrides previous --no-guess,
 	EOF
 '
 
-#TODO: --guess/--no-guess ordering is not taken into account
-test_expect_failure 'git switch - a later --no-guess overrides previous --guess, complete only local branches' '
+test_expect_success 'git switch - a later --no-guess overrides previous --guess, complete only local branches' '
 	test_completion "git switch --guess --no-guess " <<-\EOF
 	master Z
 	matching-branch Z
@@ -1318,8 +1315,7 @@ test_expect_success 'git checkout - with GIT_COMPLETION_NO_GUESS=1 only complete
 	EOF
 '
 
-#TODO: git checkout does not override variable when --guess is provided
-test_expect_failure 'git checkout - --guess overrides GIT_COMPLETION_NO_GUESS=1, complete refs and unique remote branches for DWIM' '
+test_expect_success 'git checkout - --guess overrides GIT_COMPLETION_NO_GUESS=1, complete refs and unique remote branches for DWIM' '
 	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git checkout --guess " <<-\EOF
 	HEAD Z
 	branch-in-other Z
@@ -1343,8 +1339,7 @@ test_expect_success 'git checkout - with --no-guess, only completes refs' '
 	EOF
 '
 
-#TODO: --guess/--no-guess ordering is not taken into account
-test_expect_failure 'git checkout - a later --guess overrides previous --no-guess, complete refs and unique remote branches for DWIM' '
+test_expect_success 'git checkout - a later --guess overrides previous --no-guess, complete refs and unique remote branches for DWIM' '
 	test_completion "git checkout --no-guess --guess " <<-\EOF
 	HEAD Z
 	branch-in-other Z
@@ -1544,7 +1539,8 @@ test_expect_failure 'git checkout - with -B, complete all references' '
 	EOF
 '
 
-test_expect_success 'git checkout - with -b and --track, complete all references' '
+#TODO: completing the start point of -b/-B should not include DWIM references
+test_expect_failure 'git checkout - with -b and --track, complete all references' '
 	test_completion "git checkout -b new-branch --track " <<-EOF
 	HEAD Z
 	master Z
@@ -1555,7 +1551,8 @@ test_expect_success 'git checkout - with -b and --track, complete all references
 	EOF
 '
 
-test_expect_success 'git checkout - with -B and --track, complete all references' '
+#TODO: completing the start point of -b/-B should not include DWIM references
+test_expect_failure 'git checkout - with -B and --track, complete all references' '
 	test_completion "git checkout -B new-branch --track " <<-EOF
 	HEAD Z
 	master Z
-- 
2.25.2

