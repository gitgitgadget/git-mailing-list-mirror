Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9CEC433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 11:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73CA3207D3
	for <git@archiver.kernel.org>; Wed, 27 May 2020 11:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgE0Lir (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 07:38:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:3342 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730085AbgE0Lig (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 07:38:36 -0400
IronPort-SDR: XPVTqD+YjARHeM623Sgo8v1OX+o5ecsATkYYJKPAJR1fK8hVpN1bahaAHxPz6+rFdKZ8nYg7P6
 BuCWcIHeMRig==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 04:38:34 -0700
IronPort-SDR: OOXt+TCAXAKjg0DkbdIFgWJ8BHY0W9QuJOJ88HLluup93v1wM6TnQ63R1IHH+LFyMBzpmXhEZ0
 W9iMYiEcJs3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="scan'208";a="302431796"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga008.jf.intel.com with ESMTP; 27 May 2020 04:38:34 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 2/9] completion: improve handling of DWIM mode for switch/checkout
Date:   Wed, 27 May 2020 04:38:24 -0700
Message-Id: <20200527113831.3294409-3-jacob.e.keller@intel.com>
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

Both git switch and git checkout can "Do What I Mean" by interpreting
a name of unique remote branch as "please create and switch to a local
branch named after and tracking this remote branch".

Completion supports this DWIM mode by allowing to complete these unique
remote branch names. The current logic for when we decide to enable this
DWIM mode is not consistent between git checkout and git switch.

In both cases, this logic is enabled by default. Then, if any of
'--track', '--no-track', or '--no-guess' are provided on the command
line, then we disable it. Additionally, this logic is disabled when
GIT_COMPLETION_CHECKOUT_NO_GUESS is set to 1. For _git_switch, we also
unconditionally enable this logic if "--guess" is provided on the
command line.

The rules for when to enable or disable DWIM have gotten quite
complicated, so its time to refactor these into a function,
__git_checkout_default_dwim_mode().

First, the default is to enable DWIM logic. Then, if '--no-track' is
provided or if the GIT_COMPLETION_CHECKOUT_NO_GUESS variable is set, we
change to default to disabled.

A new helper, __git_find_last_on_cmdline is introduced, similar to the
already existing __git_find_on_cmdline, but which operates in reverse,
finding the *last* matching word of the provided wordlist.

This is then used to find the last --guess or --no-guess. In this way,
if --guess was last specified (and thus git option parsing will think
--guess is enabled), we will unconditionally enable DWIM mode. If
--no-guess is provided last, then we will unconditionally disable DWIM
mode. Finally, if neither are specified, we use the default.

This new logic is more robust, as we will correctly identify superseded
options, and ensure that both _git_switch and _git_checkout enable DWIM
in similar ways.

Add several tests which demonstrate the new expected behavior. Note that
some of the git switch tests are marked as failures because the default
git switch completion with --guess is sub-par as discussed in a previous
commit. This will be fixed in a future change.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 contrib/completion/git-completion.bash | 95 ++++++++++++++++++++-----
 t/t9902-completion.sh                  | 98 ++++++++++++++++++++++++++
 2 files changed, 174 insertions(+), 19 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2972df4cb4c9..ed966f5e2991 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1104,6 +1104,40 @@ __git_find_on_cmdline ()
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
@@ -1358,6 +1392,46 @@ _git_bundle ()
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
@@ -1370,13 +1444,7 @@ _git_checkout ()
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
@@ -2226,18 +2294,7 @@ _git_switch ()
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
index 3c44af694015..6d90d19d9fe5 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1240,6 +1240,104 @@ test_expect_success '__git_complete_fetch_refspecs - fully qualified & prefix' '
 	test_cmp expected out
 '
 
+test_expect_success 'git switch - with --no-guess, complete only local branches' '
+	test_completion "git switch --no-guess " <<-\EOF
+	master Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git switch - with GIT_COMPLETION_CHECKOUT_NO_GUESS=1, complete only local branches' '
+	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git switch " <<-\EOF
+	master Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_failure 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_GUESS=1, complete local branches and unique remote names for DWIM logic' '
+	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git switch --guess " <<-\EOF
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_failure 'git switch - a later --guess overrides previous --no-guess, complete local and remote unique branches for DWIM' '
+	test_completion "git switch --no-guess --guess " <<-\EOF
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git switch - a later --no-guess overrides previous --guess, complete only local branches' '
+	test_completion "git switch --guess --no-guess " <<-\EOF
+	master Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git checkout - with GIT_COMPLETION_NO_GUESS=1 only completes refs' '
+	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git checkout " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - --guess overrides GIT_COMPLETION_NO_GUESS=1, complete refs and unique remote branches for DWIM' '
+	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git checkout --guess " <<-\EOF
+	HEAD Z
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - with --no-guess, only completes refs' '
+	test_completion "git checkout --no-guess " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - a later --guess overrides previous --no-guess, complete refs and unique remote branches for DWIM' '
+	test_completion "git checkout --no-guess --guess " <<-\EOF
+	HEAD Z
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - a later --no-guess overrides previous --guess, complete only refs' '
+	test_completion "git checkout --guess --no-guess " <<-\EOF
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

