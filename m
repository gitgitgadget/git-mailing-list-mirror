Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B83C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7496B20829
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391469AbgE1SK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 14:10:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:18377 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391429AbgE1SKz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 14:10:55 -0400
IronPort-SDR: pDTQubUmHGWKAcrGDDz9uO0ZQGR6WNZatRxJQ6hHjQNoCNpFM5g4nVSSt+SxNpjUuo/41R5jrM
 RhcQsFRxzpCA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 11:10:52 -0700
IronPort-SDR: 0SpoJhka0RLSbMAMkb4d8k8BMW87E8RjC2w7Kl2rTBjj+euFruSue+RiIRmGDlVYyEpXSS2Io3
 uTEDA2ZwQMiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="267301353"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2020 11:10:51 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 08/16] completion: replace overloaded track term for __git_complete_refs
Date:   Thu, 28 May 2020 11:10:40 -0700
Message-Id: <20200528181048.3509470-9-jacob.e.keller@intel.com>
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

The __git_complete_refs uses the "--track" option to specify when to
enable listing of unique remote branches which are used by the DWIM
logic of git checkout and git switch.

Using the term '--track' here is confusing because the git commands
themselves have '--track' as an argument. Additionally, the completion
logic for _git_switch also checks for --track. Keeping the meaning of
track_opt and --track for __git_complete_refs straight from the --track
git switch and git checkout option is difficult when reading this code.

Use the option '--dwim' instead, indicating this is about enabling or
disabling logic related to DWIM mode. Also rename the local variable
track_opt to dwim_opt to further reduce the confusion when reading the
completion code for _git_switch.

Because it is plausible for users to have developed their own
completions which rely on __git_complete_ref, keep --track as a synonym
for --dwim, even though we no longer use it in any of the core git
completion logic. Add a comment explaining why it remains as an
alternative spelling for --dwim.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 contrib/completion/git-completion.bash | 28 ++++++++++++++------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 70ad04e1b2a8..2972df4cb4c9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -749,7 +749,7 @@ __git_refs ()
 # Usage: __git_complete_refs [<option>]...
 # --remote=<remote>: The remote to list refs from, can be the name of a
 #                    configured remote, a path, or a URL.
-# --track: List unique remote branches for 'git checkout's tracking DWIMery.
+# --dwim: List unique remote branches for 'git switch's tracking DWIMery.
 # --pfx=<prefix>: A prefix to be added to each ref.
 # --cur=<word>: The current ref to be completed.  Defaults to the current
 #               word to be completed.
@@ -757,12 +757,14 @@ __git_refs ()
 #                 space.
 __git_complete_refs ()
 {
-	local remote track pfx cur_="$cur" sfx=" "
+	local remote dwim pfx cur_="$cur" sfx=" "
 
 	while test $# != 0; do
 		case "$1" in
 		--remote=*)	remote="${1##--remote=}" ;;
-		--track)	track="yes" ;;
+		--dwim)		dwim="yes" ;;
+		# --track is an old spelling of --dwim
+		--track)	dwim="yes" ;;
 		--pfx=*)	pfx="${1##--pfx=}" ;;
 		--cur=*)	cur_="${1##--cur=}" ;;
 		--sfx=*)	sfx="${1##--sfx=}" ;;
@@ -771,7 +773,7 @@ __git_complete_refs ()
 		shift
 	done
 
-	__gitcomp_direct "$(__git_refs "$remote" "$track" "$pfx" "$cur_" "$sfx")"
+	__gitcomp_direct "$(__git_refs "$remote" "$dwim" "$pfx" "$cur_" "$sfx")"
 }
 
 # __git_refs2 requires 1 argument (to pass to __git_refs)
@@ -1370,12 +1372,12 @@ _git_checkout ()
 	*)
 		# check if --track, --no-track, or --no-guess was specified
 		# if so, disable DWIM mode
-		local flags="--track --no-track --no-guess" track_opt="--track"
+		local flags="--track --no-track --no-guess" dwim_opt="--dwim"
 		if [ "$GIT_COMPLETION_CHECKOUT_NO_GUESS" = "1" ] ||
 		   [ -n "$(__git_find_on_cmdline "$flags")" ]; then
-			track_opt=''
+			dwim_opt=''
 		fi
-		__git_complete_refs $track_opt
+		__git_complete_refs $dwim_opt
 		;;
 	esac
 }
@@ -2226,27 +2228,27 @@ _git_switch ()
 	*)
 		# check if --track, --no-track, or --no-guess was specified
 		# if so, disable DWIM mode
-		local track_opt="--track" only_local_ref=n
+		local dwim_opt="--dwim" only_local_ref=n
 		if [ "$GIT_COMPLETION_CHECKOUT_NO_GUESS" = "1" ] ||
 		   [ -n "$(__git_find_on_cmdline "--track --no-track --no-guess")" ]; then
-			track_opt=''
+			dwim_opt=''
 		fi
 		# explicit --guess enables DWIM mode regardless of
 		# $GIT_COMPLETION_CHECKOUT_NO_GUESS
 		if [ -n "$(__git_find_on_cmdline "--guess")" ]; then
-			track_opt='--track'
+			dwim_opt='--dwim'
 		fi
 		if [ -z "$(__git_find_on_cmdline "-d --detach")" ]; then
 			only_local_ref=y
 		else
 			# --guess --detach is invalid combination, no
 			# dwim will be done when --detach is specified
-			track_opt=
+			dwim_opt=
 		fi
-		if [ $only_local_ref = y -a -z "$track_opt" ]; then
+		if [ $only_local_ref = y -a -z "$dwim_opt" ]; then
 			__gitcomp_direct "$(__git_heads "" "$cur" " ")"
 		else
-			__git_complete_refs $track_opt
+			__git_complete_refs $dwim_opt
 		fi
 		;;
 	esac
-- 
2.25.2

