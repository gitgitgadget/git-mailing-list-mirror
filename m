X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 5/10] Teach bash how to complete git-format-patch.
Date: Mon, 27 Nov 2006 03:41:43 -0500
Message-ID: <20061127084143.GE19745@spearce.org>
References: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 08:41:59 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32395>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goc3i-0007dL-Ki for gcvg-git@gmane.org; Mon, 27 Nov
 2006 09:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757419AbWK0Ilr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 03:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757420AbWK0Ilr
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 03:41:47 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:3980 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1757419AbWK0Ilq
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 03:41:46 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Goc3b-0004Sz-9L; Mon, 27 Nov 2006 03:41:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 C103820FB7F; Mon, 27 Nov 2006 03:41:43 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Provide completion for currently known long options supported by
git-format-patch as well as the revision list specification argument,
which is generally either a refname or in the form a..b.

Since _git_log was the only code that knew how to complete a..b, but
we want to start adding option support to _git_log also refactor the
a..b completion logic out into its own function.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   60 +++++++++++++++++++++++--------
 1 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a740d05..729e5a9 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -144,6 +144,26 @@ __git_complete_file ()
 	esac
 }
 
+__git_complete_revlist ()
+{
+	local pfx cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	*...*)
+		pfx="${cur%...*}..."
+		cur="${cur#*...}"
+		COMPREPLY=($(compgen -P "$pfx" -W "$(__git_refs)" -- "$cur"))
+		;;
+	*..*)
+		pfx="${cur%..*}.."
+		cur="${cur#*..}"
+		COMPREPLY=($(compgen -P "$pfx" -W "$(__git_refs)" -- "$cur"))
+		;;
+	*)
+		COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
+		;;
+	esac
+}
+
 __git_commands ()
 {
 	local i IFS=" "$'\n'
@@ -290,6 +310,26 @@ _git_fetch ()
 	esac
 }
 
+_git_format_patch ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		COMPREPLY=($(compgen -W "
+			--stdout --attach --thread
+			--output-directory
+			--numbered --start-number
+			--keep-subject
+			--signoff
+			--in-repy-to=
+			--full-index --binary
+			" -- "$cur"))
+		return
+		;;
+	esac
+	__git_complete_revlist
+}
+
 _git_ls_remote ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -303,22 +343,7 @@ _git_ls_tree ()
 
 _git_log ()
 {
-	local pfx cur="${COMP_WORDS[COMP_CWORD]}"
-	case "$cur" in
-	*...*)
-		pfx="${cur%...*}..."
-		cur="${cur#*...}"
-		COMPREPLY=($(compgen -P "$pfx" -W "$(__git_refs)" -- "$cur"))
-		;;
-	*..*)
-		pfx="${cur%..*}.."
-		cur="${cur#*..}"
-		COMPREPLY=($(compgen -P "$pfx" -W "$(__git_refs)" -- "$cur"))
-		;;
-	*)
-		COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
-		;;
-	esac
+	__git_complete_revlist
 }
 
 _git_merge ()
@@ -450,6 +475,7 @@ _git ()
 	diff)        _git_diff ;;
 	diff-tree)   _git_diff_tree ;;
 	fetch)       _git_fetch ;;
+	format-patch) _git_format_patch ;;
 	log)         _git_log ;;
 	ls-remote)   _git_ls_remote ;;
 	ls-tree)     _git_ls_tree ;;
@@ -480,6 +506,7 @@ complete -o default            -F _git_checkout git-checkout
 complete -o default -o nospace -F _git_diff git-diff
 complete -o default            -F _git_diff_tree git-diff-tree
 complete -o default -o nospace -F _git_fetch git-fetch
+complete -o default -o nospace -F _git_format_patch git-format-patch
 complete -o default -o nospace -F _git_log git-log
 complete -o default            -F _git_ls_remote git-ls-remote
 complete -o default -o nospace -F _git_ls_tree git-ls-tree
@@ -503,6 +530,7 @@ complete -o default            -F _git_branch git-branch.exe
 complete -o default -o nospace -F _git_cat_file git-cat-file.exe
 complete -o default -o nospace -F _git_diff git-diff.exe
 complete -o default -o nospace -F _git_diff_tree git-diff-tree.exe
+complete -o default -o nospace -F _git_format_patch git-format-patch.exe
 complete -o default -o nospace -F _git_log git-log.exe
 complete -o default -o nospace -F _git_ls_tree git-ls-tree.exe
 complete -o default            -F _git_merge_base git-merge-base.exe
-- 
1.4.4.1.ge3fb
