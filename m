Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206A6C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF5F207D3
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405682AbgE1SLA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 14:11:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:18371 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391464AbgE1SK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 14:10:56 -0400
IronPort-SDR: aL9N5oQrz8+ZRCpBTb+MIl862pPUj0fiS2G/bGbiZohnOCaSecodvrJNYx2UFBpol0OKDU4pCd
 pnrz4dfbfM4w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 11:10:52 -0700
IronPort-SDR: RdMrkMiQWTbTiJSaYXjFgxCQ4J7D/an5NBzV93NBeNWsR95+frRLd88Zv+dJGgR9pUWRfqbjRn
 Nunx0aoTNA3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="267301358"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2020 11:10:51 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 12/16] completion: improve completion for git switch with no options
Date:   Thu, 28 May 2020 11:10:44 -0700
Message-Id: <20200528181048.3509470-13-jacob.e.keller@intel.com>
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
will result in only local branches and remote unique names for DWIM.

The basic no-options tests for git switch, as well as several of the
-c/-C tests now pass, so remove the known breakage tags.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 contrib/completion/git-completion.bash | 33 ++++++++++++++++----------
 t/t9902-completion.sh                  | 19 ++++++---------
 2 files changed, 27 insertions(+), 25 deletions(-)

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
index 13d5a47e2912..f4f3a3ca3d55 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1240,8 +1240,7 @@ test_expect_success '__git_complete_fetch_refspecs - fully qualified & prefix' '
 	test_cmp expected out
 '
 
-#TODO: git switch completion includes unexpected references
-test_expect_failure 'git switch - with no options, complete local branches and unique remote branch names for DWIM logic' '
+test_expect_success 'git switch - with no options, complete local branches and unique remote branch names for DWIM logic' '
 	test_completion "git switch " <<-\EOF
 	branch-in-other Z
 	master Z
@@ -1277,8 +1276,8 @@ test_expect_success 'git switch - with GIT_COMPLETION_CHECKOUT_NO_GUESS=1, compl
 	EOF
 '
 
-#TODO: git switch completion includes unexpected references
-test_expect_failure 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_GUESS=1, complete local branches and unique remote names for DWIM logic' '
+
+test_expect_success 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_GUESS=1, complete local branches and unique remote names for DWIM logic' '
 	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git switch --guess " <<-\EOF
 	branch-in-other Z
 	master Z
@@ -1287,8 +1286,7 @@ test_expect_failure 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_G
 	EOF
 '
 
-#TODO: git switch completion includes unexpected references
-test_expect_failure 'git switch - a later --guess overrides previous --no-guess, complete local and remote unique branches for DWIM' '
+test_expect_success 'git switch - a later --guess overrides previous --no-guess, complete local and remote unique branches for DWIM' '
 	test_completion "git switch --no-guess --guess " <<-\EOF
 	branch-in-other Z
 	master Z
@@ -1585,8 +1583,7 @@ test_expect_success 'git checkout - with -B and --no-track, complete all referen
 	EOF
 '
 
-#TODO: -c/-C argument completion should not include all references
-test_expect_failure 'git switch - for -c, complete local branches and unique remote branches' '
+test_expect_success 'git switch - for -c, complete local branches and unique remote branches' '
 	test_completion "git switch -c " <<-\EOF
 	branch-in-other Z
 	master Z
@@ -1595,8 +1592,7 @@ test_expect_failure 'git switch - for -c, complete local branches and unique rem
 	EOF
 '
 
-#TODO: -c/-C argument completion should not include all references
-test_expect_failure 'git switch - for -C, complete local branches and unique remote branches' '
+test_expect_success 'git switch - for -C, complete local branches and unique remote branches' '
 	test_completion "git switch -C " <<-\EOF
 	branch-in-other Z
 	master Z
@@ -1685,8 +1681,7 @@ test_expect_failure 'git checkout - for -B with --no-track, complete local branc
 	EOF
 '
 
-#TODO: --orphan argument completion should not include all references
-test_expect_failure 'git switch - with --orphan completes local branch names and unique remote branch names' '
+test_expect_success 'git switch - with --orphan completes local branch names and unique remote branch names' '
 	test_completion "git switch --orphan " <<-\EOF
 	branch-in-other Z
 	master Z
-- 
2.25.2

