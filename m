X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/4] Support --strategy=x completion in addition to --strategy x.
Date: Mon, 27 Nov 2006 15:10:42 -0500
Message-ID: <20061127201041.GA7308@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 20:12:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32443>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GomoS-0000jL-Ve for gcvg-git@gmane.org; Mon, 27 Nov
 2006 21:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758549AbWK0UKq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 15:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758552AbWK0UKq
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 15:10:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41887 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1758549AbWK0UKp
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 15:10:45 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GomoF-0006KC-PT; Mon, 27 Nov 2006 15:10:35 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 27DA120FB7F; Mon, 27 Nov 2006 15:10:42 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Because git-merge and git-rebase both accept -s, --strategy or --strategy=
we should recognize all three formats in the bash completion functions and
issue back all merge strategies on demand.

I also moved the prior word testing to be before the current word testing,
as the current word cannot be completed with -- if the prior word was an
option which requires a parameter, such as -s or --strategy.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a957165..e53f040 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -455,18 +455,23 @@ _git_log ()
 _git_merge ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "${COMP_WORDS[COMP_CWORD-1]}" in
+	-s|--strategy)
+		COMPREPLY=($(compgen -W "$(__git_merge_strategies)" -- "$cur"))
+		return
+	esac
 	case "$cur" in
+	--strategy=*)
+		COMPREPLY=($(compgen -W "$(__git_merge_strategies)" \
+			-- "${cur##--strategy=}"))
+		return
+		;;
 	--*)
 		COMPREPLY=($(compgen -W "
 			--no-commit --no-summary --squash --strategy
 			" -- "$cur"))
 		return
 	esac
-	case "${COMP_WORDS[COMP_CWORD-1]}" in
-	-s|--strategy)
-		COMPREPLY=($(compgen -W "$(__git_merge_strategies)" -- "$cur"))
-		return
-	esac
 	COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
 }
 
@@ -543,18 +548,23 @@ _git_rebase ()
 			" -- "$cur"))
 		return
 	fi
+	case "${COMP_WORDS[COMP_CWORD-1]}" in
+	-s|--strategy)
+		COMPREPLY=($(compgen -W "$(__git_merge_strategies)" -- "$cur"))
+		return
+	esac
 	case "$cur" in
+	--strategy=*)
+		COMPREPLY=($(compgen -W "$(__git_merge_strategies)" \
+			-- "${cur##--strategy=}"))
+		return
+		;;
 	--*)
 		COMPREPLY=($(compgen -W "
 			--onto --merge --strategy
 			" -- "$cur"))
 		return
 	esac
-	case "${COMP_WORDS[COMP_CWORD-1]}" in
-	-s|--strategy)
-		COMPREPLY=($(compgen -W "$(__git_merge_strategies)" -- "$cur"))
-		return
-	esac
 	COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
 }
 
-- 
1.4.4.1.ge3fb
