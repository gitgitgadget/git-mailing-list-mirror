X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/4] Teach bash about git-am/git-apply and their whitespace options.
Date: Mon, 27 Nov 2006 15:12:03 -0500
Message-ID: <20061127201203.GD7308@spearce.org>
References: <139669072795537547ec26b69115509100dcd7ec.1164658223.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 20:13:09 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <139669072795537547ec26b69115509100dcd7ec.1164658223.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32446>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gompn-0000zl-LY for gcvg-git@gmane.org; Mon, 27 Nov
 2006 21:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758557AbWK0UMI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 15:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758556AbWK0UMI
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 15:12:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59807 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1758557AbWK0UMG
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 15:12:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GompY-0006Qu-P6; Mon, 27 Nov 2006 15:11:57 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 8793520FB7F; Mon, 27 Nov 2006 15:12:03 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   53 ++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ba3adb6..5b7d9d3 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -307,6 +307,54 @@ __git_aliased_command ()
 	done
 }
 
+__git_whitespacelist="nowarn warn error error-all strip"
+
+_git_am ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	if [ -d .dotest ]; then
+		COMPREPLY=($(compgen -W "
+			--skip --resolved
+			" -- "$cur"))
+		return
+	fi
+	case "$cur" in
+	--whitespace=*)
+		COMPREPLY=($(compgen -W "$__git_whitespacelist" \
+			-- "${cur##--whitespace=}"))
+		return
+		;;
+	--*)
+		COMPREPLY=($(compgen -W "
+			--signoff --utf8 --binary --3way --interactive
+			--whitespace=
+			" -- "$cur"))
+		return
+	esac
+	COMPREPLY=()
+}
+
+_git_apply ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--whitespace=*)
+		COMPREPLY=($(compgen -W "$__git_whitespacelist" \
+			-- "${cur##--whitespace=}"))
+		return
+		;;
+	--*)
+		COMPREPLY=($(compgen -W "
+			--stat --numstat --summary --check --index
+			--cached --index-info --reverse --reject --unidiff-zero
+			--apply --no-add --exclude=
+			--whitespace= --inaccurate-eof --verbose
+			" -- "$cur"))
+		return
+	esac
+	COMPREPLY=()
+}
+
 _git_branch ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -760,6 +808,8 @@ _git ()
 	[ "$expansion" ] && command="$expansion"
 
 	case "$command" in
+	am)          _git_am ;;
+	apply)       _git_apply ;;
 	branch)      _git_branch ;;
 	cat-file)    _git_cat_file ;;
 	checkout)    _git_checkout ;;
@@ -795,6 +845,8 @@ _gitk ()
 
 complete -o default -o nospace -F _git git
 complete -o default            -F _gitk gitk
+complete -o default            -F _git_am git-am
+complete -o default            -F _git_apply git-apply
 complete -o default            -F _git_branch git-branch
 complete -o default -o nospace -F _git_cat_file git-cat-file
 complete -o default            -F _git_checkout git-checkout
@@ -824,6 +876,7 @@ complete -o default -o nospace -F _git_log git-whatchanged
 # included the '.exe' suffix.
 #
 if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
+complete -o default            -F _git_apply git-apply.exe
 complete -o default -o nospace -F _git git.exe
 complete -o default            -F _git_branch git-branch.exe
 complete -o default -o nospace -F _git_cat_file git-cat-file.exe
-- 
