X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/10] Teach git-completion.bash how to complete git-merge.
Date: Mon, 27 Nov 2006 03:40:47 -0500
Message-ID: <20061127084047.GA19745@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 08:41:06 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32391>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goc2r-0007R1-1m for gcvg-git@gmane.org; Mon, 27 Nov
 2006 09:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757409AbWK0Ikw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 03:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757410AbWK0Ikw
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 03:40:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60043 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1757409AbWK0Ikw
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 03:40:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Goc2i-0004Nu-1x; Mon, 27 Nov 2006 03:40:48 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 10BF420FB7F; Mon, 27 Nov 2006 03:40:48 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Now that git-merge is high-level Porcelain users are going to expect
to be able to use it from the command line, in which case we really
should also be able to complete ref names as parameters.

I'm also including completion support for the merge strategies
that are supported by git-merge.sh, should the user wish to use a
different strategy than their default.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a43a177..28bd0e3 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -81,6 +81,16 @@ __git_remotes ()
 	done
 }
 
+__git_merge_strategies ()
+{
+	sed -n "/^all_strategies='/{
+		s/^all_strategies='//
+		s/'//
+		p
+		q
+		}" "$(git --exec-path)/git-merge"
+}
+
 __git_complete_file ()
 {
 	local pfx ls ref cur="${COMP_WORDS[COMP_CWORD]}"
@@ -240,6 +250,24 @@ _git_log ()
 	esac
 }
 
+_git_merge ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		COMPREPLY=($(compgen -W "
+			--no-commit --no-summary --squash
+			" -- "$cur"))
+		return
+	esac
+	if [ $COMP_CWORD -gt 1 -a X-s = "X${COMP_WORDS[COMP_CWORD-1]}" ]
+	then
+		COMPREPLY=($(compgen -W "$(__git_merge_strategies)" -- "$cur"))
+	else
+		COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
+	fi
+}
+
 _git_merge_base ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -348,6 +376,7 @@ _git ()
 	log)         _git_log ;;
 	ls-remote)   _git_ls_remote ;;
 	ls-tree)     _git_ls_tree ;;
+	merge)       _git_merge;;
 	merge-base)  _git_merge_base ;;
 	pull)        _git_pull ;;
 	push)        _git_push ;;
@@ -376,6 +405,7 @@ complete -o default -o nospace -F _git_fetch git-fetch
 complete -o default -o nospace -F _git_log git-log
 complete -o default            -F _git_ls_remote git-ls-remote
 complete -o default -o nospace -F _git_ls_tree git-ls-tree
+complete -o default            -F _git_merge git-merge
 complete -o default            -F _git_merge_base git-merge-base
 complete -o default -o nospace -F _git_pull git-pull
 complete -o default -o nospace -F _git_push git-push
-- 
1.4.4.1.ge3fb
