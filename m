X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/6] Take --git-dir into consideration during bash completion.
Date: Sun, 5 Nov 2006 06:21:57 -0500
Message-ID: <20061105112157.GD20495@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 11:22:17 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30968>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggg4l-0007An-1C for gcvg-git@gmane.org; Sun, 05 Nov
 2006 12:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932640AbWKELWC (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 06:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbWKELWB
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 06:22:01 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54400 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S932640AbWKELWA
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 06:22:00 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ggg4Z-0008Pg-A8; Sun, 05 Nov 2006 06:21:55 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 5506420E491; Sun,  5 Nov 2006 06:21:57 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

If the user has setup a command line of "git --git-dir=baz" then
anything we complete must be performed within the scope of "baz"
and not the current working directory.

This is useful with commands such as "git --git-dir=git.git log m"
to complete out "master" and view the log for the master branch of
the git.git repository.  As a nice side effect this also works for
aliases within the target repository, just as git would honor them.

Unfortunately because we still examine arguments by absolute position
in most of the more complex commands (e.g. git push) using --git-dir
with those commands will probably still cause completion to fail.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |  123 ++++++++++++++++++--------------
 1 files changed, 70 insertions(+), 53 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5f1be46..f258f2f 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -19,15 +19,20 @@
 #        source ~/.git-completion.sh
 #
 
+__gitdir ()
+{
+	echo "${__git_dir:-$(git rev-parse --git-dir 2>/dev/null)}"
+}
+
 __git_refs ()
 {
-	local cmd i is_hash=y
-	if [ -d "$1" ]; then
+	local cmd i is_hash=y dir="${1:-$(__gitdir)}"
+	if [ -d "$dir" ]; then
 		cmd=git-peek-remote
 	else
 		cmd=git-ls-remote
 	fi
-	for i in $($cmd "$1" 2>/dev/null); do
+	for i in $($cmd "$dir" 2>/dev/null); do
 		case "$is_hash,$i" in
 		y,*) is_hash=n ;;
 		n,*^{}) is_hash=y ;;
@@ -40,13 +45,13 @@ __git_refs ()
 
 __git_refs2 ()
 {
-	local cmd i is_hash=y
-	if [ -d "$1" ]; then
+	local cmd i is_hash=y dir="${1:-$(__gitdir)}"
+	if [ -d "$dir" ]; then
 		cmd=git-peek-remote
 	else
 		cmd=git-ls-remote
 	fi
-	for i in $($cmd "$1" 2>/dev/null); do
+	for i in $($cmd "$dir" 2>/dev/null); do
 		case "$is_hash,$i" in
 		y,*) is_hash=n ;;
 		n,*^{}) is_hash=y ;;
@@ -59,14 +64,14 @@ __git_refs2 ()
 
 __git_remotes ()
 {
-	local i ngoff IFS=$'\n'
+	local i ngoff IFS=$'\n' d="$(__gitdir)"
 	shopt -q nullglob || ngoff=1
 	shopt -s nullglob
-	for i in .git/remotes/*; do
-		echo ${i#.git/remotes/}
+	for i in "$d/remotes"/*; do
+		echo ${i#$d/remotes/}
 	done
 	[ "$ngoff" ] && shopt -u nullglob
-	for i in $(git repo-config --list); do
+	for i in $(git --git-dir="$d" repo-config --list); do
 		case "$i" in
 		remote.*.url=*)
 			i="${i#remote.}"
@@ -95,7 +100,7 @@ __git_complete_file ()
 			;;
 	    esac
 		COMPREPLY=($(compgen -P "$pfx" \
-			-W "$(git-ls-tree "$ls" \
+			-W "$(git --git-dir="$(__gitdir)" ls-tree "$ls" \
 				| sed '/^100... blob /s,^.*	,,
 				       /^040000 tree /{
 				           s,^.*	,,
@@ -105,7 +110,7 @@ __git_complete_file ()
 			-- "$cur"))
 		;;
 	*)
-		COMPREPLY=($(compgen -W "$(__git_refs .)" -- "$cur"))
+		COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
 		;;
 	esac
 }
@@ -113,7 +118,7 @@ __git_complete_file ()
 __git_aliases ()
 {
 	local i IFS=$'\n'
-	for i in $(git repo-config --list); do
+	for i in $(git --git-dir="$(__gitdir)" repo-config --list); do
 		case "$i" in
 		alias.*)
 			i="${i#alias.}"
@@ -125,7 +130,8 @@ __git_aliases ()
 
 __git_aliased_command ()
 {
-	local word cmdline=$(git repo-config --get "alias.$1")
+	local word cmdline=$(git --git-dir="$(__gitdir)" \
+		repo-config --get "alias.$1")
 	for word in $cmdline; do
 		if [ "${word##-*}" ]; then
 			echo $word
@@ -137,7 +143,7 @@ __git_aliased_command ()
 _git_branch ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
-	COMPREPLY=($(compgen -W "-l -f -d -D $(__git_refs .)" -- "$cur"))
+	COMPREPLY=($(compgen -W "-l -f -d -D $(__git_refs)" -- "$cur"))
 }
 
 _git_cat_file ()
@@ -159,7 +165,7 @@ _git_cat_file ()
 _git_checkout ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
-	COMPREPLY=($(compgen -W "-l -b $(__git_refs .)" -- "$cur"))
+	COMPREPLY=($(compgen -W "-l -b $(__git_refs)" -- "$cur"))
 }
 
 _git_diff ()
@@ -170,7 +176,7 @@ _git_diff ()
 _git_diff_tree ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
-	COMPREPLY=($(compgen -W "-r -p -M $(__git_refs .)" -- "$cur"))
+	COMPREPLY=($(compgen -W "-r -p -M $(__git_refs)" -- "$cur"))
 }
 
 _git_fetch ()
@@ -188,7 +194,7 @@ _git_fetch ()
 		case "$cur" in
 		*:*)
 	        cur=$(echo "$cur" | sed 's/^.*://')
-			COMPREPLY=($(compgen -W "$(__git_refs .)" -- "$cur"))
+			COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
 			;;
 		*)
 			local remote
@@ -221,10 +227,10 @@ _git_log ()
 	*..*)
 		local pfx=$(echo "$cur" | sed 's/\.\..*$/../')
 		cur=$(echo "$cur" | sed 's/^.*\.\.//')
-		COMPREPLY=($(compgen -P "$pfx" -W "$(__git_refs .)" -- "$cur"))
+		COMPREPLY=($(compgen -P "$pfx" -W "$(__git_refs)" -- "$cur"))
 		;;
 	*)
-		COMPREPLY=($(compgen -W "$(__git_refs .)" -- "$cur"))
+		COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
 		;;
 	esac
 }
@@ -232,7 +238,7 @@ _git_log ()
 _git_merge_base ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
-	COMPREPLY=($(compgen -W "$(__git_refs .)" -- "$cur"))
+	COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
 }
 
 _git_pull ()
@@ -280,7 +286,7 @@ _git_push ()
 			COMPREPLY=($(compgen -W "$(__git_refs "$remote")" -- "$cur"))
 			;;
 		*)
-			COMPREPLY=($(compgen -W "$(__git_refs2 .)" -- "$cur"))
+			COMPREPLY=($(compgen -W "$(__git_refs2)" -- "$cur"))
 			;;
 		esac
 		;;
@@ -291,56 +297,67 @@ _git_reset ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	local opt="--mixed --hard --soft"
-	COMPREPLY=($(compgen -W "$opt $(__git_refs .)" -- "$cur"))
+	COMPREPLY=($(compgen -W "$opt $(__git_refs)" -- "$cur"))
 }
 
 _git_show ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
-	COMPREPLY=($(compgen -W "$(__git_refs .)" -- "$cur"))
+	COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
 }
 
 _git ()
 {
-	if [ $COMP_CWORD = 1 ]; then
+	local i c=1 command __git_dir
+
+	while [ $c -lt $COMP_CWORD ]; do
+		i="${COMP_WORDS[c]}"
+		case "$i" in
+		--git-dir=*) __git_dir="${i#--git-dir=}" ;;
+		--bare)      __git_dir="." ;;
+		--version|--help|-p|--paginate) ;;
+		*) command="$i"; break ;;
+		esac
+		c=$((++c))
+	done
+
+	if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
 		COMPREPLY=($(compgen \
-			-W "--version $(git help -a|egrep '^ ') \
+			-W "--git-dir= --version \
+				$(git help -a|egrep '^ ') \
 			    $(__git_aliases)" \
 			-- "${COMP_WORDS[COMP_CWORD]}"))
-	else
-		local command="${COMP_WORDS[1]}"
-		local expansion=$(__git_aliased_command "$command")
+		return;
+	fi
 
-		if [ "$expansion" ]; then
-			command="$expansion"
-		fi
+	local expansion=$(__git_aliased_command "$command")
+	[ "$expansion" ] && command="$expansion"
 
-		case "$command" in
-		branch)      _git_branch ;;
-		cat-file)    _git_cat_file ;;
-		checkout)    _git_checkout ;;
-		diff)        _git_diff ;;
-		diff-tree)   _git_diff_tree ;;
-		fetch)       _git_fetch ;;
-		log)         _git_log ;;
-		ls-remote)   _git_ls_remote ;;
-		ls-tree)     _git_ls_tree ;;
-		merge-base)  _git_merge_base ;;
-		pull)        _git_pull ;;
-		push)        _git_push ;;
-		reset)       _git_reset ;;
-		show)        _git_show ;;
-		show-branch) _git_log ;;
-		whatchanged) _git_log ;;
-		*)           COMPREPLY=() ;;
-		esac
-	fi
+	case "$command" in
+	branch)      _git_branch ;;
+	cat-file)    _git_cat_file ;;
+	checkout)    _git_checkout ;;
+	diff)        _git_diff ;;
+	diff-tree)   _git_diff_tree ;;
+	fetch)       _git_fetch ;;
+	log)         _git_log ;;
+	ls-remote)   _git_ls_remote ;;
+	ls-tree)     _git_ls_tree ;;
+	merge-base)  _git_merge_base ;;
+	pull)        _git_pull ;;
+	push)        _git_push ;;
+	reset)       _git_reset ;;
+	show)        _git_show ;;
+	show-branch) _git_log ;;
+	whatchanged) _git_log ;;
+	*)           COMPREPLY=() ;;
+	esac
 }
 
 _gitk ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
-	COMPREPLY=($(compgen -W "--all $(__git_refs .)" -- "$cur"))
+	COMPREPLY=($(compgen -W "--all $(__git_refs)" -- "$cur"))
 }
 
 complete -o default -o nospace -F _git git
-- 
1.4.3.3.g9621
