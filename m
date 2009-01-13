From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH] Simplest update to bash completions to prevent unbounded
 variable errors
Date: Mon, 12 Jan 2009 23:58:07 -0500
Message-ID: <496C1F5F.9020604@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 05:59:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMbNG-0000KW-Ld
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 05:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbZAME6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 23:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbZAME6L
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 23:58:11 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:45869 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752042AbZAME6K (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 23:58:10 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 33EBB80D8022;
	Mon, 12 Jan 2009 23:52:27 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oQTherzi+Zsm; Mon, 12 Jan 2009 23:52:27 -0500 (EST)
Received: from TedBook.local (cpe-76-181-62-78.columbus.res.rr.com [76.181.62.78])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 9E8B880D8015;
	Mon, 12 Jan 2009 23:52:26 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105455>

Another try at fixing bash completions in "set -u" environments.

Here, I've gone back to changing $# to ${#-}, but only where necessary.

Additionally added some comments and omitted things like Vim modelines.


Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---
  contrib/completion/git-completion.bash |   42 
++++++++++++++++++++++---------
  1 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/contrib/completion/git-completion.bash 
b/contrib/completion/git-completion.bash
index 7b074d7..323829e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1,3 +1,4 @@
+#!bash
  #
  # bash completion support for core Git.
  #
@@ -50,9 +51,11 @@ case "$COMP_WORDBREAKS" in
  *)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
  esac

+# __gitdir accepts 0 or 1 arguments (i.e., location)
+# returns location of .git repo
  __gitdir ()
  {
-	if [ -z "$1" ]; then
+	if [ $# -eq 0 ] || [ -z "$1" ]; then
  		if [ -n "$__git_dir" ]; then
  			echo "$__git_dir"
  		elif [ -d .git ]; then
@@ -67,6 +70,8 @@ __gitdir ()
  	fi
  }

+# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
+# returns text to add to bash PS1 prompt (includes branch name)
  __git_ps1 ()
  {
  	local g="$(git rev-parse --git-dir 2>/dev/null)"
@@ -111,7 +116,7 @@ __git_ps1 ()
  			fi
  		fi

-		if [ -n "$1" ]; then
+		if [ $# -gt 0 ] && [ -n "$1" ]; then
  			printf "$1" "${b##refs/heads/}$r"
  		else
  			printf " (%s)" "${b##refs/heads/}$r"
@@ -119,6 +124,7 @@ __git_ps1 ()
  	fi
  }

+# __gitcomp_1 requires 2 arguments
  __gitcomp_1 ()
  {
  	local c IFS=' '$'\t'$'\n'
@@ -131,6 +137,8 @@ __gitcomp_1 ()
  	done
  }

+# __gitcomp accepts 1, 2, 3, or 4 arguments
+# generates completion reply with compgen
  __gitcomp ()
  {
  	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -143,22 +151,23 @@ __gitcomp ()
  		;;
  	*)
  		local IFS=$'\n'
-		COMPREPLY=($(compgen -P "$2" \
-			-W "$(__gitcomp_1 "$1" "$4")" \
+		COMPREPLY=($(compgen -P "${2-}" \
+			-W "$(__gitcomp_1 "${1-}" "${4-}")" \
  			-- "$cur"))
  		;;
  	esac
  }

+# __git_heads accepts 0 or 1 arguments (to pass to __gitdir)
  __git_heads ()
  {
-	local cmd i is_hash=y dir="$(__gitdir "$1")"
+	local cmd i is_hash=y dir="$(__gitdir "${1-}")"
  	if [ -d "$dir" ]; then
  		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
  			refs/heads
  		return
  	fi
-	for i in $(git ls-remote "$1" 2>/dev/null); do
+	for i in $(git ls-remote "${1-}" 2>/dev/null); do
  		case "$is_hash,$i" in
  		y,*) is_hash=n ;;
  		n,*^{}) is_hash=y ;;
@@ -168,15 +177,16 @@ __git_heads ()
  	done
  }

+# __git_tags accepts 0 or 1 arguments (to pass to __gitdir)
  __git_tags ()
  {
-	local cmd i is_hash=y dir="$(__gitdir "$1")"
+	local cmd i is_hash=y dir="$(__gitdir "${1-}")"
  	if [ -d "$dir" ]; then
  		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
  			refs/tags
  		return
  	fi
-	for i in $(git ls-remote "$1" 2>/dev/null); do
+	for i in $(git ls-remote "${1-}" 2>/dev/null); do
  		case "$is_hash,$i" in
  		y,*) is_hash=n ;;
  		n,*^{}) is_hash=y ;;
@@ -186,9 +196,10 @@ __git_tags ()
  	done
  }

+# __git_refs accepts 0 or 1 arguments (to pass to __gitdir)
  __git_refs ()
  {
-	local i is_hash=y dir="$(__gitdir "$1")"
+	local i is_hash=y dir="$(__gitdir "${1-}")"
  	local cur="${COMP_WORDS[COMP_CWORD]}" format refs
  	if [ -d "$dir" ]; then
  		case "$cur" in
@@ -218,6 +229,7 @@ __git_refs ()
  	done
  }

+# __git_refs2 requires 1 argument (to pass to __git_refs)
  __git_refs2 ()
  {
  	local i
@@ -226,6 +238,7 @@ __git_refs2 ()
  	done
  }

+# __git_refs_remotes requires 1 argument (to pass to ls-remote)
  __git_refs_remotes ()
  {
  	local cmd i is_hash=y
@@ -470,6 +483,7 @@ __git_aliases ()
  	done
  }

+# __git_aliased_command requires 1 argument
  __git_aliased_command ()
  {
  	local word cmdline=$(git --git-dir="$(__gitdir)" \
@@ -482,6 +496,7 @@ __git_aliased_command ()
  	done
  }

+# __git_find_subcommand requires 1 argument
  __git_find_subcommand ()
  {
  	local word subcommand c=1
@@ -1766,13 +1781,16 @@ _gitk ()
  	__git_complete_revlist
  }

-complete -o default -o nospace -F _git git
-complete -o default -o nospace -F _gitk gitk
+complete -o bashdefault -o default -o nospace -F _git git 2>/dev/null \
+	|| complete -o default -o nospace -F _git git
+complete -o bashdefault -o default -o nospace -F _gitk gitk 2>/dev/null \
+	|| complete -o default -o nospace -F _gitk gitk

  # The following are necessary only for Cygwin, and only are needed
  # when the user has tab-completed the executable name and consequently
  # included the '.exe' suffix.
  #
  if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
-complete -o default -o nospace -F _git git.exe
+complete -o bashdefault -o default -o nospace -F _git git.exe 2>/dev/null \
+	|| complete -o default -o nospace -F _git git.exe
  fi
-- 
1.6.1.87.g15624
