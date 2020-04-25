Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C01C54FD0
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 02:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 892592084D
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 02:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgDYCVE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 22:21:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:47710 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgDYCUz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 22:20:55 -0400
IronPort-SDR: Fc64hngB+75q7ZCNpsEhepqueYbabjFnbT+T/eUJ3rWqcqUw+KO59r/WiC8v2ZJ8bRCpzaLgxe
 w10U9NazzDkw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 19:20:53 -0700
IronPort-SDR: Y6Yi3Xr9q57IqYAX9ZgWL64u04XYb1KkVYrlRIxg4vrPijhXlQZe3c3f9Rxr6P8XIbPjJqrMoT
 h5kKYM+Kj+lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,314,1583222400"; 
   d="scan'208";a="281056783"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by fmsmga004.fm.intel.com with ESMTP; 24 Apr 2020 19:20:53 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 06/11] completion: rename --track option of __git_complete_refs
Date:   Fri, 24 Apr 2020 19:20:40 -0700
Message-Id: <20200425022045.1089291-8-jacob.e.keller@intel.com>
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

The __git_complete_refs uses the "--track" option to specify when to
enable listing of unique remote branches which could be used by the
DWIMery of git checkout and git switch.

This is confusing, because both git checkout and git switch have
a --track option. This makes looking at the completion code for these
two functions confusing.

Rename this parameter to --dwim. Because it is plausible for users to
have developed their own completions which rely on __git_complete_ref,
keep --track as a synonym for --dwim, but do not use it in our own
completion code.

This reduces the confusion when seeing --track in the _git_switch() and
_git_checkout() completion functions.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 contrib/completion/git-completion.bash | 28 ++++++++++++++------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 08d3406cf3e4..02dc1203559c 100644
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
@@ -2223,7 +2225,7 @@ _git_switch ()
 		__gitcomp_builtin switch
 		;;
 	*)
-		local track_opt="--track" only_local_ref=n
+		local dwim_opt="--dwim" only_local_ref=n
 
 		# --orphan is used to create a branch disconnected from the
 		# current history, based on the empty tree. Since the only
@@ -2237,24 +2239,24 @@ _git_switch ()
 		# if so, disable DWIM mode
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

