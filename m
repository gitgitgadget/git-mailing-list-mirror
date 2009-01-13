From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH] Simple update to bash completions to prevent unbound variable
 errors.
Date: Mon, 12 Jan 2009 21:44:19 -0500
Message-ID: <496C0003.7040909@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 03:45:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMZHo-0000Q8-G1
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 03:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756850AbZAMCoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 21:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756798AbZAMCoX
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 21:44:23 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:48622 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756431AbZAMCoW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 21:44:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 8979280D8022;
	Mon, 12 Jan 2009 21:38:39 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FXjcWMwyhtcX; Mon, 12 Jan 2009 21:38:39 -0500 (EST)
Received: from TedBook.local (cpe-76-181-62-78.columbus.res.rr.com [76.181.62.78])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id E93CC80D8008;
	Mon, 12 Jan 2009 21:38:38 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105445>

Below is a cleaner patch that prevents problems with unbound arguments
when bash is being operated under "set -u."

Some comments were added to remind callers about the requirements of
each __git* utility function.

Additionally, the completion call to bash has been modernized a bit.

A vim modeline has also been added for consistency.

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---
  contrib/completion/git-completion.bash |   70 
+++++++++++++++++++++++++-------
  1 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/contrib/completion/git-completion.bash 
b/contrib/completion/git-completion.bash
index 7b074d7..619e886 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -50,9 +50,11 @@ case "$COMP_WORDBREAKS" in
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
@@ -67,6 +69,8 @@ __gitdir ()
  	fi
  }

+# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
+# returns text to add to bash PS1 prompt (includes branch name)
  __git_ps1 ()
  {
  	local g="$(git rev-parse --git-dir 2>/dev/null)"
@@ -111,7 +115,7 @@ __git_ps1 ()
  			fi
  		fi

-		if [ -n "$1" ]; then
+		if [ $# -gt 0 ] && [ -n "$1" ]; then
  			printf "$1" "${b##refs/heads/}$r"
  		else
  			printf " (%s)" "${b##refs/heads/}$r"
@@ -119,6 +123,7 @@ __git_ps1 ()
  	fi
  }

+# __gitcomp_1 requires 2 arguments
  __gitcomp_1 ()
  {
  	local c IFS=' '$'\t'$'\n'
@@ -131,11 +136,22 @@ __gitcomp_1 ()
  	done
  }

+# __gitcomp accepts 1, 2, 3, or 4 arguments
+# generates completion reply with compgen
  __gitcomp ()
  {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
-	if [ $# -gt 2 ]; then
-		cur="$3"
+	local one two cur="${COMP_WORDS[COMP_CWORD]}" four
+	if [ $# -gt 0 ]; then
+		one="$1"
+		if [ $# -gt 1 ]; then
+			two="$2"
+			if [ $# -gt 2 ]; then
+				cur="$3"
+				if [ $# -gt 3 ]; then
+					four="$4"
+				fi
+			fi
+		fi
  	fi
  	case "$cur" in
  	--*=)
@@ -143,22 +159,27 @@ __gitcomp ()
  		;;
  	*)
  		local IFS=$'\n'
-		COMPREPLY=($(compgen -P "$2" \
-			-W "$(__gitcomp_1 "$1" "$4")" \
+		COMPREPLY=($(compgen -P "$two" \
+			-W "$(__gitcomp_1 "$one" "$four")" \
  			-- "$cur"))
  		;;
  	esac
  }

+# __git_heads accepts 0 or 1 arguments (to pass to __gitdir)
  __git_heads ()
  {
-	local cmd i is_hash=y dir="$(__gitdir "$1")"
+	local one
+	if [ $# -gt 0 ]; then
+		one="$1"
+	fi
+	local cmd i is_hash=y dir="$(__gitdir "$one")"
  	if [ -d "$dir" ]; then
  		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
  			refs/heads
  		return
  	fi
-	for i in $(git ls-remote "$1" 2>/dev/null); do
+	for i in $(git ls-remote "$one" 2>/dev/null); do
  		case "$is_hash,$i" in
  		y,*) is_hash=n ;;
  		n,*^{}) is_hash=y ;;
@@ -168,15 +189,20 @@ __git_heads ()
  	done
  }

+# __git_tags accepts 0 or 1 arguments (to pass to __gitdir)
  __git_tags ()
  {
-	local cmd i is_hash=y dir="$(__gitdir "$1")"
+	local one
+	if [ $# -gt 0 ]; then
+		one="$1"
+	fi
+	local cmd i is_hash=y dir="$(__gitdir "$one")"
  	if [ -d "$dir" ]; then
  		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
  			refs/tags
  		return
  	fi
-	for i in $(git ls-remote "$1" 2>/dev/null); do
+	for i in $(git ls-remote "$one" 2>/dev/null); do
  		case "$is_hash,$i" in
  		y,*) is_hash=n ;;
  		n,*^{}) is_hash=y ;;
@@ -186,9 +212,14 @@ __git_tags ()
  	done
  }

+# __git_refs accepts 0 or 1 arguments (to pass to __gitdir)
  __git_refs ()
  {
-	local i is_hash=y dir="$(__gitdir "$1")"
+	local one
+	if [ $# -gt 0 ]; then
+		one="$1"
+	fi
+	local i is_hash=y dir="$(__gitdir "$one")"
  	local cur="${COMP_WORDS[COMP_CWORD]}" format refs
  	if [ -d "$dir" ]; then
  		case "$cur" in
@@ -218,6 +249,7 @@ __git_refs ()
  	done
  }

+# __git_refs2 requires 1 argument (to pass to __git_refs)
  __git_refs2 ()
  {
  	local i
@@ -226,6 +258,7 @@ __git_refs2 ()
  	done
  }

+# __git_refs_remotes requires 1 argument (to pass to ls-remote)
  __git_refs_remotes ()
  {
  	local cmd i is_hash=y
@@ -470,6 +503,7 @@ __git_aliases ()
  	done
  }

+# __git_aliased_command requires 1 argument
  __git_aliased_command ()
  {
  	local word cmdline=$(git --git-dir="$(__gitdir)" \
@@ -482,6 +516,7 @@ __git_aliased_command ()
  	done
  }

+# __git_find_subcommand requires 1 argument
  __git_find_subcommand ()
  {
  	local word subcommand c=1
@@ -1766,13 +1801,18 @@ _gitk ()
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
+
+# vim:ft=sh:fdm=marker:ff=unix:noet:ts=4:sw=4
-- 
1.6.1.87.g15624
