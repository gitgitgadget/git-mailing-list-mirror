Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E75AC55197
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 02:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76F122084D
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 02:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDYCU5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 22:20:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:47710 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgDYCU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 22:20:56 -0400
IronPort-SDR: xI5Lc+6Qc9Ts0g9g8esNLtDX5PQymiIGLQGFMpe34u4wgwgkL991fEayRnt7RexmdmYjg3fpEG
 8kHk/9O6kt4w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 19:20:53 -0700
IronPort-SDR: fG+7iaQltaxS0S9XcVvucNTawOZZ3rEnROWIP90hpSH/no6dsmggRCtck6zPg+kmtnbqfru3cZ
 rCZ00/drhAzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,314,1583222400"; 
   d="scan'208";a="281056788"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by fmsmga004.fm.intel.com with ESMTP; 24 Apr 2020 19:20:53 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 09/11] completion: fix completion for git switch with no options
Date:   Fri, 24 Apr 2020 19:20:43 -0700
Message-Id: <20200425022045.1089291-11-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200425022045.1089291-1-jacob.e.keller@intel.com>
References: <20200425022045.1089291-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Add a new --mode option to __git_complete_refs, which allows changing
the behavior to call __git_heads instead of __git_refs.

By passing --mode=heads, __git_complete_refs will only output local
branches. This enables using "--mode=heads --dwim" to enable listing
local branches or the remote unique branch names for DWIM.

Refactor completion support in _git_switch() to decide whether to use
this mode instead of calling __git_heads directly.

While doing this, cleanup the function so that it is a little less
confusing.

We can simplify this a little by moving the check for
GIT_COMPLETION_CHECKOUT_NO_GUESS first, so that we do not get weird
interactions by re-enabling --dwim after checking for other options that
might disable it.

If --track, --no-track, --no-guess, -d, or --detach are provided, we
will disable --dwim, as these DWIM branch names won't work in these
modes.

Choose the --mode to specify to __git_complete_refs by also checking
command line parameters. Default to using --mode=heads, to list only
local branches.

If -d or --detach are provided, switch to --mode=refs, so that we
display all references.

In this way, the basic support for completing just "git switch <TAB>"
will result in only local branches and remote unique names for DWIM, so
switch this test to test_expect_success.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 contrib/completion/git-completion.bash | 59 ++++++++++++++++----------
 t/t9902-completion.sh                  |  6 +--
 2 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c582e070711f..0384b136763a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -782,9 +782,12 @@ __git_refs ()
 #               word to be completed.
 # --sfx=<suffix>: A suffix to be appended to each ref instead of the default
 #                 space.
+# --mode=<mode>: What set of refs to complete, one of 'refs' (the default) to
+#                complete all refs, or 'heads' to complete only branches. Note
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
@@ -2256,7 +2269,7 @@ _git_switch ()
 		__gitcomp_builtin switch
 		;;
 	*)
-		local dwim_opt="--dwim" only_local_ref=n
+		local dwim_opt="--dwim" mode="heads"
 
 		# --orphan is used to create a branch disconnected from the
 		# current history, based on the empty tree. Since the only
@@ -2266,29 +2279,31 @@ _git_switch ()
 			return
 		fi
 
-		# check if --track, --no-track, or --no-guess was specified
-		# if so, disable DWIM mode
-		if [ "$GIT_COMPLETION_CHECKOUT_NO_GUESS" = "1" ] ||
-		   [ -n "$(__git_find_on_cmdline "--track --no-track --no-guess")" ]; then
+		# By default, git switch will DWIM with remote branch names by
+		# allowing these to expand into creating a local tracking
+		# branch of the same name. Completion for this can be disabled
+		# via GIT_COMPLETION_CHECKOUT_NO_GUESS, unless the user
+		# explicitly asked this behavior with --guess
+		if [ "$GIT_COMPLETION_CHECKOUT_NO_GUESS" = "1" ] &&
+		   [ -z "$(__git_find_on_cmdline "--guess")" ]; then
 			dwim_opt=''
 		fi
-		# explicit --guess enables DWIM mode regardless of
-		# $GIT_COMPLETION_CHECKOUT_NO_GUESS
-		if [ -n "$(__git_find_on_cmdline "--guess")" ]; then
-			dwim_opt='--dwim'
+
+		# Certain combinations of options also disable this DWIM mode,
+		# so we should not complete such names in these cases.
+		if [ -n "$(__git_find_on_cmdline "--track --no-track --no-guess -d --detach")" ]; then
+			dwim_opt=''
 		fi
-		if [ -z "$(__git_find_on_cmdline "-d --detach")" ]; then
-			only_local_ref=y
-		else
-			# --guess --detach is invalid combination, no
-			# dwim will be done when --detach is specified
-			dwim_opt=
-		fi
-		if [ $only_local_ref = y -a -z "$dwim_opt" ]; then
-			__gitcomp_direct "$(__git_heads "" "$cur" " ")"
-		else
-			__git_complete_refs $dwim_opt
+
+		# By default, git switch will only allow switching between
+		# local branches, or DWIM with remote branch names. However,
+		# certain options for creating branches or detaching should
+		# complete all references.
+		if [ -n "$(__git_find_on_cmdline "-d --detach")" ]; then
+			mode="refs"
 		fi
+
+		__git_complete_refs $dwim_opt --mode=$mode
 		;;
 	esac
 }
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 9d02de167219..cfd27e4857b7 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1240,11 +1240,7 @@ test_expect_success '__git_complete_fetch_refspecs - fully qualified & prefix' '
 	test_cmp expected out
 '
 
-# TODO: git switch by default should only include local branches and anything which
-# would be understood by the DWIM logic. Currently it will complete most
-# references including pseudorefs like HEAD and FETCH_HEAD, as well as tags.
-# These should not be completed unless certain options have been enabled.
-test_expect_failure 'git switch - with no options, complete local branches and unique remote branch names for DWIM logic' '
+test_expect_success 'git switch - with no options, complete local branches and unique remote branch names for DWIM logic' '
 	test_completion "git switch " <<-\EOF
 	branch-in-other Z
 	master Z
-- 
2.25.2

