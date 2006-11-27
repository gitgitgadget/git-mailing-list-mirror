X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 7/10] Teach bash how to complete git-rebase.
Date: Mon, 27 Nov 2006 03:42:07 -0500
Message-ID: <20061127084207.GG19745@spearce.org>
References: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 08:42:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32397>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goc47-0007gc-Sh for gcvg-git@gmane.org; Mon, 27 Nov
 2006 09:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757422AbWK0ImM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 03:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757425AbWK0ImM
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 03:42:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:8588 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1757422AbWK0ImK
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 03:42:10 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Goc3z-0004Ub-0h; Mon, 27 Nov 2006 03:42:07 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 81EE620FB7F; Mon, 27 Nov 2006 03:42:07 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

As git-rebase is a popular command bash should know how to complete
reference names and its long options.  We only support completions
which make sense given the current state of the repository, that
way users don't get shown --continue/--skip/--abort on the first
execution.

Also added support for long option --strategy to git-merge, as I
missed that option earlier and just noticed it while implementing
git-rebase.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   38 ++++++++++++++++++++++++++-----
 1 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 02a60a0..a61b6b9 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -367,16 +367,16 @@ _git_merge ()
 	case "$cur" in
 	--*)
 		COMPREPLY=($(compgen -W "
-			--no-commit --no-summary --squash
+			--no-commit --no-summary --squash --strategy
 			" -- "$cur"))
 		return
 	esac
-	if [ $COMP_CWORD -gt 1 -a X-s = "X${COMP_WORDS[COMP_CWORD-1]}" ]
-	then
+	case "${COMP_WORDS[COMP_CWORD-1]}" in
+	-s|--strategy)
 		COMPREPLY=($(compgen -W "$(__git_merge_strategies)" -- "$cur"))
-	else
-		COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
-	fi
+		return
+	esac
+	COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
 }
 
 _git_merge_base ()
@@ -443,6 +443,30 @@ _git_push ()
 	esac
 }
 
+_git_rebase ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	if [ -d .dotest ]; then
+		COMPREPLY=($(compgen -W "
+			--continue --skip --abort
+			" -- "$cur"))
+		return
+	fi
+	case "$cur" in
+	--*)
+		COMPREPLY=($(compgen -W "
+			--onto --merge --strategy
+			" -- "$cur"))
+		return
+	esac
+	case "${COMP_WORDS[COMP_CWORD-1]}" in
+	-s|--strategy)
+		COMPREPLY=($(compgen -W "$(__git_merge_strategies)" -- "$cur"))
+		return
+	esac
+	COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
+}
+
 _git_reset ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -500,6 +524,7 @@ _git ()
 	name-rev)    _git_name_rev ;;
 	pull)        _git_pull ;;
 	push)        _git_push ;;
+	rebase)      _git_rebase ;;
 	reset)       _git_reset ;;
 	show)        _git_show ;;
 	show-branch) _git_log ;;
@@ -532,6 +557,7 @@ complete -o default            -F _git_merge_base git-merge-base
 complete -o default            -F _git_name_rev git-name-rev
 complete -o default -o nospace -F _git_pull git-pull
 complete -o default -o nospace -F _git_push git-push
+complete -o default            -F _git_rebase git-rebase
 complete -o default            -F _git_reset git-reset
 complete -o default            -F _git_show git-show
 complete -o default -o nospace -F _git_log git-show-branch
-- 
1.4.4.1.ge3fb
