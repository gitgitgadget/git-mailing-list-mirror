X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/4] Teach bash about git-commit's options.
Date: Mon, 27 Nov 2006 15:11:10 -0500
Message-ID: <20061127201110.GB7308@spearce.org>
References: <139669072795537547ec26b69115509100dcd7ec.1164658223.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 20:13:08 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32445>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gomov-0000pQ-1X for gcvg-git@gmane.org; Mon, 27 Nov
 2006 21:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758553AbWK0ULO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 15:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758554AbWK0ULO
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 15:11:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47263 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1758553AbWK0ULN
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 15:11:13 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gomoi-0006Me-2M; Mon, 27 Nov 2006 15:11:04 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 CBE3C20FB7F; Mon, 27 Nov 2006 15:11:10 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Not only can we complete the long options for git-commit, but now we
can also complete author strings by looking up all prior author names
in all branches and offering them up as possible completions.  This
is similiar to the support used by the --author= option to git-log.

Unfortunately this changes names which use ' within their string.
It seems to be bash's fault here, the ' is being passed out by sed
but is getting removed during the completion generation.  Fortunately
' appears in only one name in git.git so the damage is likely to be
rather low.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e53f040..d4eb138 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -332,6 +332,32 @@ _git_cherry_pick ()
 	esac
 }
 
+_git_commit ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--author=*)
+		local IFS=$'\n'
+		cur="${cur##--author=}"
+		COMPREPLY=($(compgen -P \' -S \' \
+			-W "$(git log --pretty=raw --all \
+			| sed -n -e "/^author /{
+				s/^author //
+				s/>.*/>/
+				p
+			}")" -- "${cur##\'}"))
+		return
+		;;
+	--*)
+		COMPREPLY=($(compgen -W "
+			--all --author=\' --signoff --verify --no-verify
+			--edit --amend --include --only
+			" -- "$cur"))
+		return
+	esac
+	COMPREPLY=()
+}
+
 _git_diff ()
 {
 	__git_complete_file
@@ -720,6 +746,7 @@ _git ()
 	cat-file)    _git_cat_file ;;
 	checkout)    _git_checkout ;;
 	cherry-pick) _git_cherry_pick ;;
+	commit)      _git_commit ;;
 	diff)        _git_diff ;;
 	diff-tree)   _git_diff_tree ;;
 	fetch)       _git_fetch ;;
@@ -754,6 +781,7 @@ complete -o default            -F _git_branch git-branch
 complete -o default -o nospace -F _git_cat_file git-cat-file
 complete -o default            -F _git_checkout git-checkout
 complete -o default            -F _git_cherry_pick git-cherry-pick
+complete -o default            -F _git_commit git-commit
 complete -o default -o nospace -F _git_diff git-diff
 complete -o default            -F _git_diff_tree git-diff-tree
 complete -o default -o nospace -F _git_fetch git-fetch
-- 
1.4.4.1.ge3fb
