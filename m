From: Jonas Fonseca <fonseca@diku.dk>
Subject: [TG RFC PATCH] Add bash completion script for TopGit
Date: Thu, 25 Sep 2008 13:06:56 +0200
Message-ID: <20080925110656.GB12949@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 13:08:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kiohi-0007AE-9w
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 13:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbYIYLHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 07:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753044AbYIYLHE
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 07:07:04 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:56384 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753175AbYIYLHC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 07:07:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 6347519BB58;
	Thu, 25 Sep 2008 13:07:00 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 23404-16; Thu, 25 Sep 2008 13:06:57 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 16A1319BB2A;
	Thu, 25 Sep 2008 13:06:57 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 78BD96DFD26; Thu, 25 Sep 2008 13:06:23 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id F10331DC3D5; Thu, 25 Sep 2008 13:06:56 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96746>

The script is based on git's bash completion script.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 contrib/tg-completion.bash |  438 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 438 insertions(+), 0 deletions(-)
 create mode 100755 contrib/tg-completion.bash

 I have RFC'd this because I am still a topgit noob.
 
diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
new file mode 100755
index 0000000..35eabe9
--- /dev/null
+++ b/contrib/tg-completion.bash
@@ -0,0 +1,438 @@
+#
+# bash completion support for TopGit.
+#
+# Copyright (C) 2008 Jonas Fonseca <fonseca@diku.dk>
+# Copyright (C) 2006,2007 Shawn O. Pearce <spearce@spearce.org>
+# Based git's git-completion.sh: http://repo.or.cz/w/git/fastimport.git
+# Conceptually based on gitcompletion (http://gitweb.hawaga.org.uk/).
+# Distributed under the GNU General Public License, version 2.0.
+#
+# The contained completion routines provide support for completing:
+#
+#    *) local and remote branch names
+#    *) local and remote tag names
+#    *) .git/remotes file names
+#    *) git 'subcommands'
+#    *) tree paths within 'ref:path/to/file' expressions
+#    *) common --long-options
+#
+# To use these routines:
+#
+#    1) Copy this file to somewhere (e.g. ~/.git-completion.sh).
+#    2) Added the following line to your .bashrc:
+#        source ~/.git-completion.sh
+#
+#    3) You may want to make sure the git executable is available
+#       in your PATH before this script is sourced, as some caching
+#       is performed while the script loads.  If git isn't found
+#       at source time then all lookups will be done on demand,
+#       which may be slightly slower.
+#
+#    4) Consider changing your PS1 to also show the current branch:
+#        PS1='[\u@\h \W$(__tg_ps1 " (%s)")]\$ '
+#
+#       The argument to __tg_ps1 will be displayed only if you
+#       are currently in a git repository.  The %s token will be
+
+case "$COMP_WORDBREAKS" in
+*:*) : great ;;
+*)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
+esac
+
+### {{{ Utilities
+
+__tgdir ()
+{
+	if [ -z "$1" ]; then
+		if [ -n "$__tg_dir" ]; then
+			echo "$__tg_dir"
+		elif [ -d .git ]; then
+			echo .git
+		else
+			git rev-parse --git-dir 2>/dev/null
+		fi
+	elif [ -d "$1/.git" ]; then
+		echo "$1/.git"
+	else
+		echo "$1"
+	fi
+}
+
+__tgcomp_1 ()
+{
+	local c IFS=' '$'\t'$'\n'
+	for c in $1; do
+		case "$c$2" in
+		--*=*) printf %s$'\n' "$c$2" ;;
+		*.)    printf %s$'\n' "$c$2" ;;
+		*)     printf %s$'\n' "$c$2 " ;;
+		esac
+	done
+}
+
+__tgcomp ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	if [ $# -gt 2 ]; then
+		cur="$3"
+	fi
+	case "$cur" in
+	--*=)
+		COMPREPLY=()
+		;;
+	*)
+		local IFS=$'\n'
+		COMPREPLY=($(compgen -P "$2" \
+			-W "$(__tgcomp_1 "$1" "$4")" \
+			-- "$cur"))
+		;;
+	esac
+}
+
+__tg_heads ()
+{
+	local cmd i is_hash=y dir="$(__tgdir "$1")"
+	if [ -d "$dir" ]; then
+		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
+			refs/heads
+		return
+	fi
+	for i in $(git ls-remote "$1" 2>/dev/null); do
+		case "$is_hash,$i" in
+		y,*) is_hash=n ;;
+		n,*^{}) is_hash=y ;;
+		n,refs/heads/*) is_hash=y; echo "${i#refs/heads/}" ;;
+		n,*) is_hash=y; echo "$i" ;;
+		esac
+	done
+}
+
+__tg_refs ()
+{
+	local cmd i is_hash=y dir="$(__tgdir "$1")"
+	if [ -d "$dir" ]; then
+		if [ -e "$dir/HEAD" ]; then echo HEAD; fi
+		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
+			refs/tags refs/heads refs/remotes
+		return
+	fi
+	for i in $(git ls-remote "$dir" 2>/dev/null); do
+		case "$is_hash,$i" in
+		y,*) is_hash=n ;;
+		n,*^{}) is_hash=y ;;
+		n,refs/tags/*) is_hash=y; echo "${i#refs/tags/}" ;;
+		n,refs/heads/*) is_hash=y; echo "${i#refs/heads/}" ;;
+		n,refs/remotes/*) is_hash=y; echo "${i#refs/remotes/}" ;;
+		n,*) is_hash=y; echo "$i" ;;
+		esac
+	done
+}
+
+__tg_refs2 ()
+{
+	local i
+	for i in $(__tg_refs "$1"); do
+		echo "$i:$i"
+	done
+}
+
+__tg_refs_remotes ()
+{
+	local cmd i is_hash=y
+	for i in $(git ls-remote "$1" 2>/dev/null); do
+		case "$is_hash,$i" in
+		n,refs/heads/*)
+			is_hash=y
+			echo "$i:refs/remotes/$1/${i#refs/heads/}"
+			;;
+		y,*) is_hash=n ;;
+		n,*^{}) is_hash=y ;;
+		n,refs/tags/*) is_hash=y;;
+		n,*) is_hash=y; ;;
+		esac
+	done
+}
+
+__tg_remotes ()
+{
+	local i ngoff IFS=$'\n' d="$(__tgdir)"
+	shopt -q nullglob || ngoff=1
+	shopt -s nullglob
+	for i in "$d/remotes"/*; do
+		echo ${i#$d/remotes/}
+	done
+	[ "$ngoff" ] && shopt -u nullglob
+	for i in $(git --git-dir="$d" config --list); do
+		case "$i" in
+		remote.*.url=*)
+			i="${i#remote.}"
+			echo "${i/.url=*/}"
+			;;
+		esac
+	done
+}
+
+__tg_complete_revlist ()
+{
+	local pfx cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	*...*)
+		pfx="${cur%...*}..."
+		cur="${cur#*...}"
+		__tgcomp "$(__tg_refs)" "$pfx" "$cur"
+		;;
+	*..*)
+		pfx="${cur%..*}.."
+		cur="${cur#*..}"
+		__tgcomp "$(__tg_refs)" "$pfx" "$cur"
+		;;
+	*)
+		__tgcomp "$(__tg_refs)"
+		;;
+	esac
+}
+
+__tg_topics ()
+{
+	tg summary | cut -f 2
+}
+
+__tg_commands ()
+{
+	if [ -n "$__tg_all_commandlist" ]; then
+		echo "$__tg_all_commandlist"
+		return
+	fi
+	local i IFS=" "$'\n'
+	for i in $(tg help | sed -n 's/^Usage:.*(\(.*\)).*/\1/p' | tr '|' ' ')
+	do
+		case $i in
+		*--*)             : helper pattern;;
+		*) echo $i;;
+		esac
+	done
+}
+__tg_all_commandlist=
+__tg_all_commandlist="$(__tg_commands 2>/dev/null)"
+
+__tg_complete_arg ()
+{
+	if [ $COMP_CWORD -gt 2 ] && [ "${COMP_WORDS[$COMP_CWORD - 1]}" = "$1" ]; then
+		return 0
+	fi
+	return 1
+}
+
+### }}}
+### {{{ Commands
+
+_tg_create ()
+{
+	local cmd="$1"
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	# Name must be the first arg after the create command
+	if [ $((cmd + 1)) = $COMP_CWORD ]; then
+		__tgcomp "$(__tg_topics)"
+		return
+	fi
+
+	__tg_complete_arg "-r" && {
+		__tgcomp "$(__tg_remotes)"
+		return
+	}
+
+	case "$cur" in
+	-*)
+		__tgcomp "
+			-r
+		"
+		;;
+	*)
+		__tgcomp "$(__tg_refs)"
+	esac
+}
+
+_tg_delete ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	case "$cur" in
+	-*)
+		__tgcomp "
+			-f
+		"
+		;;
+	*)
+		__tgcomp "$(__tg_topics)"
+	esac
+}
+
+_tg_export ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	__tg_complete_arg "--collapse" && {
+		__tgcomp "$(__tg_heads)"
+		return
+	}
+
+	__tg_complete_arg "--quilt" && {
+		return
+	}
+
+	case "$cur" in
+	*)
+		__tgcomp "
+			--collapse
+			--quilt
+		"
+	esac
+}
+
+_tg_help ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	-*)
+		COMPREPLY=()
+		return
+		;;
+	esac
+	__tgcomp "$(__tg_commands)"
+}
+
+_tg_import ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	__tg_complete_arg "-p" && {
+		COMPREPLY=()
+		return
+	}
+
+	case "$cur" in
+	-*)
+		__tgcomp "
+			-p
+		"
+		;;
+	*)
+		__tg_complete_revlist
+	esac
+}
+
+_tg_info ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	case "$cur" in
+	*)
+		__tgcomp "$(__tg_topics)"
+	esac
+}
+
+_tg_mail ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	case "$cur" in
+	*)
+		__tgcomp "$(__tg_topics)"
+	esac
+}
+
+_tg_patch ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	case "$cur" in
+	*)
+		__tgcomp "$(__tg_topics)"
+	esac
+}
+
+_tg_remote ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	case "$cur" in
+	*)
+		__tgcomp "$(__tg_remotes)"
+	esac
+}
+
+_tg_summary ()
+{
+	COMPREPLY=()
+}
+
+_tg_update ()
+{
+	COMPREPLY=()
+}
+
+### }}}
+### {{{ tg completion
+
+_tg ()
+{
+	local i c=1 command __tg_dir
+
+	while [ $c -lt $COMP_CWORD ]; do
+		i="${COMP_WORDS[c]}"
+		case "$i" in
+		-r) 
+			c=$((++c))
+			if [ $c -lt $COMP_CWORD ]; then
+				__tgcomp "$(__tg_remotes)"
+				return
+			fi
+			;;
+		-h|--help) command="help"; break ;;
+		*) command="$i"; break ;;
+		esac
+		c=$((++c))
+	done
+
+	if [ -z "$command" ]; then
+		case "${COMP_WORDS[COMP_CWORD]}" in
+		-*)	__tgcomp "
+				-r
+				-h
+				--help
+			"
+			;;
+		*)     __tgcomp "$(__tg_commands)" ;;
+		esac
+		return
+	fi
+
+	case "$command" in
+	create)      _tg_create "$c" ;;
+	delete)      _tg_delete ;;
+	export)      _tg_export ;;
+	help)        _tg_help ;;
+	import)      _tg_import ;;
+	info)        _tg_info ;;
+	mail)        _tg_mail ;;
+	patch)       _tg_patch ;;
+	remote)      _tg_remote ;;
+	summary)     _tg_summary ;;
+	update)      _tg_update ;;
+	*)           COMPREPLY=() ;;
+	esac
+}
+
+### }}}
+
+	__tgcomp "$(__tg_refs top-bases)"
+complete -o default -o nospace -F _tg tg
+
+# The following are necessary only for Cygwin, and only are needed
+# when the user has tab-completed the executable name and consequently
+# included the '.exe' suffix.
+#
+if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
+complete -o default -o nospace -F _tg tg.exe
+fi
-- 
1.6.0.2.471.g47a76.dirty


-- 
Jonas Fonseca
