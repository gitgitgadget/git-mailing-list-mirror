Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8DFC433E1
	for <git@archiver.kernel.org>; Wed, 27 May 2020 11:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A1E20888
	for <git@archiver.kernel.org>; Wed, 27 May 2020 11:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgE0Lip (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 07:38:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:3342 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgE0Lij (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 07:38:39 -0400
IronPort-SDR: JevHuNV5TwR7ZwWOlYpSUqyCpVn8huNoqosD02qayzWZYMgVR/jsnZ4I6caB73h3eHzUnjhm7n
 uZjzkISt7u7g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 04:38:34 -0700
IronPort-SDR: gwxrt5KwRp+VJ4GqiR9FMXN2cLrJhkFo+pVOGH5BqskO/0bqSedA20+FmZXjQe9XXVr1AsXTdm
 ABEb/JIg+bQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="scan'208";a="302431799"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga008.jf.intel.com with ESMTP; 27 May 2020 04:38:34 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 5/9] completion: improve completion for git switch with no options
Date:   Wed, 27 May 2020 04:38:27 -0700
Message-Id: <20200527113831.3294409-6-jacob.e.keller@intel.com>
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

The current default behavior of completion for git switch is
sub-optimal. Unlike checkout, git switch by default focuses on switching
branches. It does not allow detaching HEAD without the --detach option.
By default, git switch accepts only branch names. If a unique remote
branch name is given, then it will "Do What I Mean" and automatically
create a local branch tracking that remote branch.

However, "git switch <TAB>" will complete more than just branch names!
It actually completes all local references, including tags and fully
specified remote branch names.

As an example, today completion will provide the following words:

  $git switch <TAB>
  branch-in-other
  master
  master-in-other
  matching-branch
  matching-tag
  other/branch-in-other
  other/master-in-other

This includes many options which are invalid, such as tags, and fully
specified remote branches. Avoid completing these.

Add a new --mode option to __git_complete_refs, which allows changing
the behavior to call __git_heads instead of __git_refs.

By passing --mode=heads, __git_complete_refs will only output local
branches. This enables using "--mode=heads --dwim" to enable listing
local branches and the remote unique branch names for DWIM.

Refactor completion support to use the new mode option, rather than
calling __git_heads directly. This has the advantage that we can now
correctly allow local branches along with suitable DWIM refs, rather
than only allowing DWIM when we complete all references.

Choose what mode it uses when calling __git_complete_refs. If -d or
--detach have been provided, then simply complete all refs, but
*without* the DWIM option as these DWIM names won't work properly in
--detach mode.

Otherwise, call __git_complete_refs with the default dwim_opt value and
use the new "heads" mode.

In this way, the basic support for completing just "git switch <TAB>"
will result in only local branches and remote unique names for DWIM, so
switch this test to test_expect_success.

Add new test cases that cover the default behavior of completion for git
switch and git checkout with no options.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 contrib/completion/git-completion.bash | 33 ++++++++++++++++----------
 t/t9902-completion.sh                  | 26 ++++++++++++++++++--
 2 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 54cd676fdc9d..53afd72d0e4e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -782,9 +782,12 @@ __git_refs ()
 #               word to be completed.
 # --sfx=<suffix>: A suffix to be appended to each ref instead of the default
 #                 space.
+# --mode=<mode>: What set of refs to complete, one of 'refs' (the default) to
+#                complete all refs, 'heads' to complete only branches. Note
+#                that --remote is only compatible with --mode=refs.
 __git_complete_refs ()
 {
-	local remote dwim pfx cur_="$cur" sfx=" "
+	local remote dwim pfx cur_="$cur" sfx=" " mode="refs"
 
 	while test $# != 0; do
 		case "$1" in
@@ -795,13 +798,23 @@ __git_complete_refs ()
 		--pfx=*)	pfx="${1##--pfx=}" ;;
 		--cur=*)	cur_="${1##--cur=}" ;;
 		--sfx=*)	sfx="${1##--sfx=}" ;;
+		--mode=*)	mode="${1##--mode=}" ;;
 		*)		return 1 ;;
 		esac
 		shift
 	done
 
-	__gitcomp_direct "$(__git_refs "$remote" "" "$pfx" "$cur_" "$sfx")"
+	# complete references based on the specified mode
+	case "$mode" in
+		refs)
+			__gitcomp_direct "$(__git_refs "$remote" "" "$pfx" "$cur_" "$sfx")" ;;
+		heads)
+			__gitcomp_direct "$(__git_heads "$pfx" "$cur_" "$sfx")" ;;
+		*)
+			return 1 ;;
+	esac
 
+	# Append DWIM remote branch names if requested
 	if [ "$dwim" = "yes" ]; then
 		__gitcomp_direct_append "$(__git_dwim_remote_heads "$pfx" "$cur_" "$sfx")"
 	fi
@@ -2325,18 +2338,12 @@ _git_switch ()
 		__gitcomp_builtin switch
 		;;
 	*)
-		local dwim_opt="$(__git_checkout_default_dwim_mode)" only_local_ref=n
-		if [ -z "$(__git_find_on_cmdline "-d --detach")" ]; then
-			only_local_ref=y
+		local dwim_opt="$(__git_checkout_default_dwim_mode)"
+
+		if [ -n "$(__git_find_on_cmdline "-d --detach")" ]; then
+			__git_complete_refs --mode="refs"
 		else
-			# --guess --detach is invalid combination, no
-			# dwim will be done when --detach is specified
-			dwim_opt=
-		fi
-		if [ $only_local_ref = y -a -z "$dwim_opt" ]; then
-			__gitcomp_direct "$(__git_heads "" "$cur" " ")"
-		else
-			__git_complete_refs $dwim_opt
+			__git_complete_refs $dwim_opt --mode="heads"
 		fi
 		;;
 	esac
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 6d90d19d9fe5..ec9437688cd7 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1240,6 +1240,28 @@ test_expect_success '__git_complete_fetch_refspecs - fully qualified & prefix' '
 	test_cmp expected out
 '
 
+test_expect_success 'git switch - with no options, complete local branches and unique remote branch names for DWIM logic' '
+	test_completion "git switch " <<-\EOF
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
+	test_completion "git checkout " <<-\EOF
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
 test_expect_success 'git switch - with --no-guess, complete only local branches' '
 	test_completion "git switch --no-guess " <<-\EOF
 	master Z
@@ -1254,7 +1276,7 @@ test_expect_success 'git switch - with GIT_COMPLETION_CHECKOUT_NO_GUESS=1, compl
 	EOF
 '
 
-test_expect_failure 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_GUESS=1, complete local branches and unique remote names for DWIM logic' '
+test_expect_success 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_GUESS=1, complete local branches and unique remote names for DWIM logic' '
 	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git switch --guess " <<-\EOF
 	branch-in-other Z
 	master Z
@@ -1263,7 +1285,7 @@ test_expect_failure 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_G
 	EOF
 '
 
-test_expect_failure 'git switch - a later --guess overrides previous --no-guess, complete local and remote unique branches for DWIM' '
+test_expect_success 'git switch - a later --guess overrides previous --no-guess, complete local and remote unique branches for DWIM' '
 	test_completion "git switch --no-guess --guess " <<-\EOF
 	branch-in-other Z
 	master Z
-- 
2.25.2

