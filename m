From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Contributed bash completion support for core Git tools.
Date: Sun, 17 Sep 2006 20:48:31 -0400
Message-ID: <20060918004831.GA19851@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 18 02:48:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP7JO-0002p3-VS
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 02:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965181AbWIRAsg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 20:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbWIRAsg
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 20:48:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:3229 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965181AbWIRAsf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 20:48:35 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GP7J8-0001OU-42
	for git@vger.kernel.org; Sun, 17 Sep 2006 20:48:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3A15B20FB1F; Sun, 17 Sep 2006 20:48:31 -0400 (EDT)
To: git@vger.kernel.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27218>

This is a set of bash completion routines for many of the
popular core Git tools.  I wrote these routines from scratch
after reading the git-compl and git-compl-lib routines available
from the gitcompletion package at http://gitweb.hawaga.org.uk/
and found those to be lacking in functionality for some commands.
Consequently there may be some similarities but many differences.

Since these are completion routines only for tools shipped with
core Git and since bash is a popular shell on many of the native
core Git platforms (Linux, Mac OS X, Solaris, BSD) including these
routines as part of the stock package would probably be convienent
for many users.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 I put this together rather quickly today so although I find it
 to work well for me and be useful, others might not.  User be
 warned.

 In particular I have found the completion of remote refs and
 paths within 'ref:foo/path' style arguments to be very useful,
 even if there is some (mild) latency involved.

 contrib/bash-git-completion.sh |  330 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 330 insertions(+), 0 deletions(-)

diff --git a/contrib/bash-git-completion.sh b/contrib/bash-git-completion.sh
new file mode 100644
index 0000000..4800185
--- /dev/null
+++ b/contrib/bash-git-completion.sh
@@ -0,0 +1,330 @@
+#
+# bash completion support for core Git.
+#
+# Copyright (C) 2006 Shawn Pearce
+# Conceptually based on gitcompletion (http://gitweb.hawaga.org.uk/).
+#
+# The contained completion routines provide support for completing:
+#
+#    *) local and remote branch names
+#    *) local and remote tag names
+#    *) .git/remotes file names
+#    *) git 'subcommands'
+#    *) tree paths within 'ref:path/to/file' expressions
+# 
+# To use these routines:
+#
+#    1) Copy this file to somewhere (e.g. ~/.git-completion.sh).
+#    2) Added the following line to your .bashrc:
+#        source ~/.git-completion.sh
+#
+
+__git_refs ()
+{
+	local cmd i is_hash=y
+	if [ -d "$1" ]; then
+		cmd=git-peek-remote
+	else
+		cmd=git-ls-remote
+	fi
+	for i in $($cmd "$1" 2>/dev/null); do
+		case "$is_hash,$i" in
+		y,*) is_hash=n ;;
+		n,*^{}) is_hash=y ;;
+		n,refs/tags/*) is_hash=y; echo "${i#refs/tags/}" ;;
+		n,refs/heads/*) is_hash=y; echo "${i#refs/heads/}" ;;
+		n,*) is_hash=y; echo "$i" ;;
+		esac
+	done
+}
+
+__git_refs2 ()
+{
+	local cmd i is_hash=y
+	if [ -d "$1" ]; then
+		cmd=git-peek-remote
+	else
+		cmd=git-ls-remote
+	fi
+	for i in $($cmd "$1" 2>/dev/null); do
+		case "$is_hash,$i" in
+		y,*) is_hash=n ;;
+		n,*^{}) is_hash=y ;;
+		n,refs/tags/*) is_hash=y; echo "${i#refs/tags/}:${i#refs/tags/}" ;;
+		n,refs/heads/*) is_hash=y; echo "${i#refs/heads/}:${i#refs/heads/}" ;;
+		n,*) is_hash=y; echo "$i:$i" ;;
+		esac
+	done
+}
+
+__git_remotes ()
+{
+	local i REVERTGLOB=$(shopt -p nullglob)
+	shopt -s nullglob
+	for i in .git/remotes/*; do
+		echo ${i#.git/remotes/}
+	done
+	$REVERTGLOB
+}
+
+__git_complete_file ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	?*:*)
+		local pfx ls ref="$(echo "$cur" | sed 's,:.*$,,')"
+		cur="$(echo "$cur" | sed 's,^.*:,,')"
+		case "$cur" in
+		?*/*)
+			pfx="$(echo "$cur" | sed 's,/[^/]*$,,')"
+			cur="$(echo "$cur" | sed 's,^.*/,,')"
+			ls="$ref:$pfx"
+			pfx="$pfx/"
+			;;
+		*)
+			ls="$ref"
+			;;
+	    esac	    
+		COMPREPLY=($(compgen -P "$pfx" \
+			-W "$(git-ls-tree "$ls" \
+				| sed '/^100... blob /s,^.*	,,
+				       /^040000 tree /{
+				           s,^.*	,,
+				           s,$,/,
+				       }
+				       s/^.*	//')" \
+			-- "$cur"))
+		;;
+	*)
+		COMPREPLY=($(compgen -W "$(__git_refs .)" -- "$cur"))
+		;;
+	esac
+}
+
+_git_branch ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	COMPREPLY=($(compgen -W "-l -f -d -D $(__git_refs .)" -- "$cur"))
+}
+
+_git_cat_file ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "${COMP_WORDS[0]},$COMP_CWORD" in
+	git-cat-file*,1)
+		COMPREPLY=($(compgen -W "-p -t blob tree commit tag" -- "$cur"))
+		;;
+	git,2)
+		COMPREPLY=($(compgen -W "-p -t blob tree commit tag" -- "$cur"))
+		;;
+	*)
+		__git_complete_file
+		;;
+	esac
+}
+
+_git_checkout ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	COMPREPLY=($(compgen -W "-l -b $(__git_refs .)" -- "$cur"))
+}
+
+_git_diff ()
+{
+	__git_complete_file
+}
+
+_git_diff_tree ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	COMPREPLY=($(compgen -W "-r -p -M $(__git_refs .)" -- "$cur"))
+}
+
+_git_fetch ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	case "${COMP_WORDS[0]},$COMP_CWORD" in
+	git-fetch*,1)
+		COMPREPLY=($(compgen -W "$(__git_remotes)" -- "$cur"))
+		;;
+	git,2)
+		COMPREPLY=($(compgen -W "$(__git_remotes)" -- "$cur"))
+		;;
+	*)
+		case "$cur" in
+		*:*)
+	        cur=$(echo "$cur" | sed 's/^.*://')
+			COMPREPLY=($(compgen -W "$(__git_refs .)" -- "$cur"))
+			;;
+		*)
+			local remote
+			case "${COMP_WORDS[0]}" in
+			git-fetch) remote="${COMP_WORDS[1]}" ;;
+			git)       remote="${COMP_WORDS[2]}" ;;
+			esac
+			COMPREPLY=($(compgen -W "$(__git_refs2 "$remote")" -- "$cur"))
+			;;
+		esac
+		;;
+	esac
+}
+
+_git_ls_remote ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	COMPREPLY=($(compgen -W "$(__git_remotes)" -- "$cur"))
+}
+
+_git_ls_tree ()
+{
+	__git_complete_file
+}
+
+_git_log ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	*..*)
+		local pfx=$(echo "$cur" | sed 's/\.\..*$/../')
+		cur=$(echo "$cur" | sed 's/^.*\.\.//')
+		COMPREPLY=($(compgen -P "$pfx" -W "$(__git_refs .)" -- "$cur"))
+		;;
+	*)
+		COMPREPLY=($(compgen -W "$(__git_refs .)" -- "$cur"))
+		;;
+	esac
+}
+
+_git_merge_base ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	COMPREPLY=($(compgen -W "$(__git_refs .)" -- "$cur"))
+}
+
+_git_pull ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	case "${COMP_WORDS[0]},$COMP_CWORD" in
+	git-pull*,1)
+		COMPREPLY=($(compgen -W "$(__git_remotes)" -- "$cur"))
+		;;
+	git,2)
+		COMPREPLY=($(compgen -W "$(__git_remotes)" -- "$cur"))
+		;;
+	*)
+		local remote
+		case "${COMP_WORDS[0]}" in
+		git-pull)  remote="${COMP_WORDS[1]}" ;;
+		git)       remote="${COMP_WORDS[2]}" ;;
+		esac
+		COMPREPLY=($(compgen -W "$(__git_refs "$remote")" -- "$cur"))
+		;;
+	esac
+}
+
+_git_push ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	case "${COMP_WORDS[0]},$COMP_CWORD" in
+	git-push*,1)
+		COMPREPLY=($(compgen -W "$(__git_remotes)" -- "$cur"))
+		;;
+	git,2)
+		COMPREPLY=($(compgen -W "$(__git_remotes)" -- "$cur"))
+		;;
+	*)
+		case "$cur" in
+		*:*)
+			local remote
+			case "${COMP_WORDS[0]}" in
+			git-push)  remote="${COMP_WORDS[1]}" ;;
+			git)       remote="${COMP_WORDS[2]}" ;;
+			esac
+	        cur=$(echo "$cur" | sed 's/^.*://')
+			COMPREPLY=($(compgen -W "$(__git_refs "$remote")" -- "$cur"))
+			;;
+		*)
+			COMPREPLY=($(compgen -W "$(__git_refs2 .)" -- "$cur"))
+			;;
+		esac
+		;;
+	esac
+}
+
+_git_whatchanged ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	*..*)
+		local pfx=$(echo "$cur" | sed 's/\.\..*$/../')
+		cur=$(echo "$cur" | sed 's/^.*\.\.//')
+		COMPREPLY=($(compgen -P "$pfx" -W "$(__git_refs .)" -- "$cur"))
+		;;
+	*)
+		COMPREPLY=($(compgen -W "$(__git_refs .)" -- "$cur"))
+		;;
+	esac
+}
+
+_git ()
+{
+	if [ $COMP_CWORD = 1 ]; then
+		COMPREPLY=($(compgen \
+			-W "--version $(git help -a|egrep '^ ')" \
+			-- "${COMP_WORDS[COMP_CWORD]}"))
+	else
+		case "${COMP_WORDS[1]}" in
+		branch)      _git_branch ;;
+		cat-file)    _git_cat_file ;;
+		checkout)    _git_checkout ;;
+		diff)        _git_diff ;;
+		diff-tree)   _git_diff_tree ;;
+		fetch)       _git_fetch ;;
+		log)         _git_log ;;
+		ls-remote)   _git_ls_remote ;;
+		ls-tree)     _git_ls_tree ;;
+		pull)        _git_pull ;;
+		push)        _git_push ;;
+		whatchanged) _git_whatchanged ;;
+		*)           COMPREPLY=() ;;
+		esac
+	fi
+}
+
+_gitk ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	COMPREPLY=($(compgen -W "--all $(__git_refs .)" -- "$cur"))
+}
+
+complete -o default -o nospace -F _git git
+complete -o default            -F _gitk gitk
+complete -o default            -F _git_branch git-branch
+complete -o default -o nospace -F _git_cat_file git-cat-file
+complete -o default            -F _git_checkout git-checkout
+complete -o default -o nospace -F _git_diff git-diff
+complete -o default            -F _git_diff_tree git-diff-tree
+complete -o default -o nospace -F _git_fetch git-fetch
+complete -o default -o nospace -F _git_log git-log
+complete -o default            -F _git_ls_remote git-ls-remote
+complete -o default -o nospace -F _git_ls_tree git-ls-tree
+complete -o default            -F _git_merge_base git-merge-base
+complete -o default -o nospace -F _git_pull git-pull
+complete -o default -o nospace -F _git_push git-push
+complete -o default -o nospace -F _git_whatchanged git-whatchanged
+
+# The following are necessary only for Cygwin, and only are needed
+# when the user has tab-completed the executable name and consequently
+# included the '.exe' suffix.
+#
+complete -o default -o nospace -F _git_cat_file git-cat-file.exe
+complete -o default -o nospace -F _git_diff git-diff.exe
+complete -o default -o nospace -F _git_diff_tree git-diff-tree.exe
+complete -o default -o nospace -F _git_log git-log.exe
+complete -o default -o nospace -F _git_ls_tree git-ls-tree.exe
+complete -o default            -F _git_merge_base git-merge-base.exe
+complete -o default -o nospace -F _git_push git-push.exe
+complete -o default -o nospace -F _git_whatchanged git-whatchanged.exe
-- 
1.4.2.1.ga817
