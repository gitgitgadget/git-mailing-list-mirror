From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 7/8] bash: Support unique completion when possible.
Date: Sun, 4 Feb 2007 02:38:43 -0500
Message-ID: <20070204073843.GG17603@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 08:38:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDbxa-0007Y3-SN
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 08:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbXBDHit (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 02:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbXBDHis
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 02:38:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55534 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbXBDHir (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 02:38:47 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDbxT-00005a-T6; Sun, 04 Feb 2007 02:38:44 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 74C9520FBAE; Sun,  4 Feb 2007 02:38:43 -0500 (EST)
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
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38661>

Because our use of -o nospace prevents bash from adding a trailing space
when a completion is unique and has been fully completed, we need to
perform this addition on our own.  This (large) change converts all
existing uses of compgen to our wrapper __gitcomp which attempts to
handle this by tacking a trailing space onto the end of each offered
option.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |  190 +++++++++++++++-----------------
 1 files changed, 91 insertions(+), 99 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 38d6121..3b1f100 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -65,7 +65,7 @@ __gitcomp ()
 {
 	local all c s=$'\n' IFS=' '$'\t'$'\n'
 	local cur="${COMP_WORDS[COMP_CWORD]}"
-	if [ -n "$2" ]; then
+	if [ $# -gt 2 ]; then
 		cur="$3"
 	fi
 	for c in $1; do
@@ -219,7 +219,7 @@ __git_complete_file ()
 			-- "$cur"))
 		;;
 	*)
-		COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
+		__gitcomp "$(__git_refs)"
 		;;
 	esac
 }
@@ -231,15 +231,18 @@ __git_complete_revlist ()
 	*...*)
 		pfx="${cur%...*}..."
 		cur="${cur#*...}"
-		COMPREPLY=($(compgen -P "$pfx" -W "$(__git_refs)" -- "$cur"))
+		__gitcomp "$(__git_refs)" "$pfx" "$cur"
 		;;
 	*..*)
 		pfx="${cur%..*}.."
 		cur="${cur#*..}"
-		COMPREPLY=($(compgen -P "$pfx" -W "$(__git_refs)" -- "$cur"))
+		__gitcomp "$(__git_refs)" "$pfx" "$cur"
+		;;
+	*.)
+		__gitcomp "$cur."
 		;;
 	*)
-		COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
+		__gitcomp "$(__git_refs)"
 		;;
 	esac
 }
@@ -353,22 +356,19 @@ _git_am ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	if [ -d .dotest ]; then
-		COMPREPLY=($(compgen -W "
-			--skip --resolved
-			" -- "$cur"))
+		__gitcomp "--skip --resolved"
 		return
 	fi
 	case "$cur" in
 	--whitespace=*)
-		COMPREPLY=($(compgen -W "$__git_whitespacelist" \
-			-- "${cur##--whitespace=}"))
+		__gitcomp "$__git_whitespacelist" "" "${cur##--whitespace=}"
 		return
 		;;
 	--*)
-		COMPREPLY=($(compgen -W "
+		__gitcomp "
 			--signoff --utf8 --binary --3way --interactive
 			--whitespace=
-			" -- "$cur"))
+			"
 		return
 	esac
 	COMPREPLY=()
@@ -379,17 +379,16 @@ _git_apply ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--whitespace=*)
-		COMPREPLY=($(compgen -W "$__git_whitespacelist" \
-			-- "${cur##--whitespace=}"))
+		__gitcomp "$__git_whitespacelist" "" "${cur##--whitespace=}"
 		return
 		;;
 	--*)
-		COMPREPLY=($(compgen -W "
+		__gitcomp "
 			--stat --numstat --summary --check --index
 			--cached --index-info --reverse --reject --unidiff-zero
 			--apply --no-add --exclude=
 			--whitespace= --inaccurate-eof --verbose
-			" -- "$cur"))
+			"
 		return
 	esac
 	COMPREPLY=()
@@ -400,9 +399,7 @@ _git_add ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--*)
-		COMPREPLY=($(compgen -W "
-			--interactive
-			" -- "$cur"))
+		__gitcomp "--interactive"
 		return
 	esac
 	COMPREPLY=()
@@ -410,14 +407,12 @@ _git_add ()
 
 _git_branch ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
-	COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
+	__gitcomp "$(__git_refs)"
 }
 
 _git_checkout ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
-	COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
+	__gitcomp "$(__git_refs)"
 }
 
 _git_cherry_pick ()
@@ -425,12 +420,10 @@ _git_cherry_pick ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--*)
-		COMPREPLY=($(compgen -W "
-			--edit --no-commit
-			" -- "$cur"))
+		__gitcomp "--edit --no-commit"
 		;;
 	*)
-		COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
+		__gitcomp "$(__git_refs)"
 		;;
 	esac
 }
@@ -440,10 +433,10 @@ _git_commit ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--*)
-		COMPREPLY=($(compgen -W "
+		__gitcomp "
 			--all --author= --signoff --verify --no-verify
 			--edit --amend --include --only
-			" -- "$cur"))
+			"
 		return
 	esac
 	COMPREPLY=()
@@ -456,8 +449,7 @@ _git_diff ()
 
 _git_diff_tree ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
-	COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
+	__gitcomp "$(__git_refs)"
 }
 
 _git_fetch ()
@@ -466,16 +458,15 @@ _git_fetch ()
 
 	case "${COMP_WORDS[0]},$COMP_CWORD" in
 	git-fetch*,1)
-		COMPREPLY=($(compgen -W "$(__git_remotes)" -- "$cur"))
+		__gitcomp "$(__git_remotes)"
 		;;
 	git,2)
-		COMPREPLY=($(compgen -W "$(__git_remotes)" -- "$cur"))
+		__gitcomp "$(__git_remotes)"
 		;;
 	*)
 		case "$cur" in
 		*:*)
-			cur="${cur#*:}"
-			COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
+			__gitcomp "$(__git_refs)" "" "${cur#*:}"
 			;;
 		*)
 			local remote
@@ -483,7 +474,7 @@ _git_fetch ()
 			git-fetch) remote="${COMP_WORDS[1]}" ;;
 			git)       remote="${COMP_WORDS[2]}" ;;
 			esac
-			COMPREPLY=($(compgen -W "$(__git_refs2 "$remote")" -- "$cur"))
+			__gitcomp "$(__git_refs2 "$remote")"
 			;;
 		esac
 		;;
@@ -495,7 +486,7 @@ _git_format_patch ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--*)
-		COMPREPLY=($(compgen -W "
+		__gitcomp "
 			--stdout --attach --thread
 			--output-directory
 			--numbered --start-number
@@ -503,7 +494,7 @@ _git_format_patch ()
 			--signoff
 			--in-reply-to=
 			--full-index --binary
-			" -- "$cur"))
+			"
 		return
 		;;
 	esac
@@ -512,8 +503,7 @@ _git_format_patch ()
 
 _git_ls_remote ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
-	COMPREPLY=($(compgen -W "$(__git_remotes)" -- "$cur"))
+	__gitcomp "$(__git_remotes)"
 }
 
 _git_ls_tree ()
@@ -526,13 +516,13 @@ _git_log ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--pretty=*)
-		COMPREPLY=($(compgen -W "
+		__gitcomp "
 			oneline short medium full fuller email raw
-			" -- "${cur##--pretty=}"))
+			" "" "${cur##--pretty=}"
 		return
 		;;
 	--*)
-		COMPREPLY=($(compgen -W "
+		__gitcomp "
 			--max-count= --max-age= --since= --after=
 			--min-age= --before= --until=
 			--root --not --topo-order --date-order
@@ -542,7 +532,7 @@ _git_log ()
 			--author= --committer= --grep=
 			--all-match
 			--pretty= --name-status --name-only
-			" -- "$cur"))
+			"
 		return
 		;;
 	esac
@@ -554,34 +544,31 @@ _git_merge ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "${COMP_WORDS[COMP_CWORD-1]}" in
 	-s|--strategy)
-		COMPREPLY=($(compgen -W "$(__git_merge_strategies)" -- "$cur"))
+		__gitcomp "$(__git_merge_strategies)"
 		return
 	esac
 	case "$cur" in
 	--strategy=*)
-		COMPREPLY=($(compgen -W "$(__git_merge_strategies)" \
-			-- "${cur##--strategy=}"))
+		__gitcomp "$(__git_merge_strategies)" "" "${cur##--strategy=}"
 		return
 		;;
 	--*)
-		COMPREPLY=($(compgen -W "
+		__gitcomp "
 			--no-commit --no-summary --squash --strategy
-			" -- "$cur"))
+			"
 		return
 	esac
-	COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
+	__gitcomp "$(__git_refs)"
 }
 
 _git_merge_base ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
-	COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
+	__gitcomp "$(__git_refs)"
 }
 
 _git_name_rev ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
-	COMPREPLY=($(compgen -W "--tags --all --stdin" -- "$cur"))
+	__gitcomp "--tags --all --stdin"
 }
 
 _git_pull ()
@@ -590,10 +577,10 @@ _git_pull ()
 
 	case "${COMP_WORDS[0]},$COMP_CWORD" in
 	git-pull*,1)
-		COMPREPLY=($(compgen -W "$(__git_remotes)" -- "$cur"))
+		__gitcomp "$(__git_remotes)"
 		;;
 	git,2)
-		COMPREPLY=($(compgen -W "$(__git_remotes)" -- "$cur"))
+		__gitcomp "$(__git_remotes)"
 		;;
 	*)
 		local remote
@@ -601,7 +588,7 @@ _git_pull ()
 		git-pull)  remote="${COMP_WORDS[1]}" ;;
 		git)       remote="${COMP_WORDS[2]}" ;;
 		esac
-		COMPREPLY=($(compgen -W "$(__git_refs "$remote")" -- "$cur"))
+		__gitcomp "$(__git_refs "$remote")"
 		;;
 	esac
 }
@@ -612,10 +599,10 @@ _git_push ()
 
 	case "${COMP_WORDS[0]},$COMP_CWORD" in
 	git-push*,1)
-		COMPREPLY=($(compgen -W "$(__git_remotes)" -- "$cur"))
+		__gitcomp "$(__git_remotes)"
 		;;
 	git,2)
-		COMPREPLY=($(compgen -W "$(__git_remotes)" -- "$cur"))
+		__gitcomp "$(__git_remotes)"
 		;;
 	*)
 		case "$cur" in
@@ -625,11 +612,10 @@ _git_push ()
 			git-push)  remote="${COMP_WORDS[1]}" ;;
 			git)       remote="${COMP_WORDS[2]}" ;;
 			esac
-			cur="${cur#*:}"
-			COMPREPLY=($(compgen -W "$(__git_refs "$remote")" -- "$cur"))
+			__gitcomp "$(__git_refs "$remote")" "" "${cur#*:}"
 			;;
 		*)
-			COMPREPLY=($(compgen -W "$(__git_refs2)" -- "$cur"))
+			__gitcomp "$(__git_refs2)"
 			;;
 		esac
 		;;
@@ -640,29 +626,24 @@ _git_rebase ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	if [ -d .dotest ]; then
-		COMPREPLY=($(compgen -W "
-			--continue --skip --abort
-			" -- "$cur"))
+		__gitcomp "--continue --skip --abort"
 		return
 	fi
 	case "${COMP_WORDS[COMP_CWORD-1]}" in
 	-s|--strategy)
-		COMPREPLY=($(compgen -W "$(__git_merge_strategies)" -- "$cur"))
+		__gitcomp "$(__git_merge_strategies)"
 		return
 	esac
 	case "$cur" in
 	--strategy=*)
-		COMPREPLY=($(compgen -W "$(__git_merge_strategies)" \
-			-- "${cur##--strategy=}"))
+		__gitcomp "$(__git_merge_strategies)" "" "${cur##--strategy=}"
 		return
 		;;
 	--*)
-		COMPREPLY=($(compgen -W "
-			--onto --merge --strategy
-			" -- "$cur"))
+		__gitcomp "--onto --merge --strategy"
 		return
 	esac
-	COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
+	__gitcomp "$(__git_refs)"
 }
 
 _git_config ()
@@ -824,8 +805,13 @@ _git_config ()
 _git_reset ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
-	local opt="--mixed --hard --soft"
-	COMPREPLY=($(compgen -W "$opt $(__git_refs)" -- "$cur"))
+	case "$cur" in
+	--*)
+		__gitcomp "--mixed --hard --soft"
+		return
+		;;
+	esac
+	__gitcomp "$(__git_refs)"
 }
 
 _git_show ()
@@ -833,13 +819,13 @@ _git_show ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--pretty=*)
-		COMPREPLY=($(compgen -W "
+		__gitcomp "
 			oneline short medium full fuller email raw
-			" -- "${cur##--pretty=}"))
+			" "" "${cur##--pretty=}"
 		return
 		;;
 	--*)
-		COMPREPLY=($(compgen -W "--pretty=" -- "$cur"))
+		__gitcomp "--pretty="
 		return
 		;;
 	esac
@@ -906,32 +892,38 @@ _git ()
 _gitk ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
-	COMPREPLY=($(compgen -W "--all $(__git_refs)" -- "$cur"))
+	case "$cur" in
+	--*)
+		__gitcomp "--not --all"
+		return
+		;;
+	esac
+	__gitcomp "$(__git_refs)"
 }
 
 complete -o default -o nospace -F _git git
-complete -o default            -F _gitk gitk
-complete -o default            -F _git_am git-am
-complete -o default            -F _git_apply git-apply
-complete -o default            -F _git_branch git-branch
-complete -o default            -F _git_checkout git-checkout
-complete -o default            -F _git_cherry_pick git-cherry-pick
-complete -o default            -F _git_commit git-commit
+complete -o default -o nospace -F _gitk gitk
+complete -o default -o nospace -F _git_am git-am
+complete -o default -o nospace -F _git_apply git-apply
+complete -o default -o nospace -F _git_branch git-branch
+complete -o default -o nospace -F _git_checkout git-checkout
+complete -o default -o nospace -F _git_cherry_pick git-cherry-pick
+complete -o default -o nospace -F _git_commit git-commit
 complete -o default -o nospace -F _git_diff git-diff
-complete -o default            -F _git_diff_tree git-diff-tree
+complete -o default -o nospace -F _git_diff_tree git-diff-tree
 complete -o default -o nospace -F _git_fetch git-fetch
 complete -o default -o nospace -F _git_format_patch git-format-patch
 complete -o default -o nospace -F _git_log git-log
-complete -o default            -F _git_ls_remote git-ls-remote
+complete -o default -o nospace -F _git_ls_remote git-ls-remote
 complete -o default -o nospace -F _git_ls_tree git-ls-tree
-complete -o default            -F _git_merge git-merge
-complete -o default            -F _git_merge_base git-merge-base
-complete -o default            -F _git_name_rev git-name-rev
+complete -o default -o nospace -F _git_merge git-merge
+complete -o default -o nospace -F _git_merge_base git-merge-base
+complete -o default -o nospace -F _git_name_rev git-name-rev
 complete -o default -o nospace -F _git_pull git-pull
 complete -o default -o nospace -F _git_push git-push
-complete -o default            -F _git_rebase git-rebase
-complete -o default            -F _git_config git-config
-complete -o default            -F _git_reset git-reset
+complete -o default -o nospace -F _git_rebase git-rebase
+complete -o default -o nospace -F _git_config git-config
+complete -o default -o nospace -F _git_reset git-reset
 complete -o default -o nospace -F _git_show git-show
 complete -o default -o nospace -F _git_log git-show-branch
 complete -o default -o nospace -F _git_log git-whatchanged
@@ -941,19 +933,19 @@ complete -o default -o nospace -F _git_log git-whatchanged
 # included the '.exe' suffix.
 #
 if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
-complete -o default            -F _git_add git-add.exe
-complete -o default            -F _git_apply git-apply.exe
+complete -o default -o nospace -F _git_add git-add.exe
+complete -o default -o nospace -F _git_apply git-apply.exe
 complete -o default -o nospace -F _git git.exe
-complete -o default            -F _git_branch git-branch.exe
+complete -o default -o nospace -F _git_branch git-branch.exe
 complete -o default -o nospace -F _git_diff git-diff.exe
 complete -o default -o nospace -F _git_diff_tree git-diff-tree.exe
 complete -o default -o nospace -F _git_format_patch git-format-patch.exe
 complete -o default -o nospace -F _git_log git-log.exe
 complete -o default -o nospace -F _git_ls_tree git-ls-tree.exe
-complete -o default            -F _git_merge_base git-merge-base.exe
-complete -o default            -F _git_name_rev git-name-rev.exe
+complete -o default -o nospace -F _git_merge_base git-merge-base.exe
+complete -o default -o nospace -F _git_name_rev git-name-rev.exe
 complete -o default -o nospace -F _git_push git-push.exe
-complete -o default            -F _git_config git-config
+complete -o default -o nospace -F _git_config git-config
 complete -o default -o nospace -F _git_show git-show.exe
 complete -o default -o nospace -F _git_log git-show-branch.exe
 complete -o default -o nospace -F _git_log git-whatchanged.exe
-- 
1.5.0.rc3.22.g5057
