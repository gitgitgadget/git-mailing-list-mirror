From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH] Update bash completions to prevent unbound variable errors.
Date: Mon, 12 Jan 2009 14:58:28 -0500
Message-ID: <496BA0E4.2040607@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 21:00:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMSx6-0008Pv-3E
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 21:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755607AbZALT6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 14:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755478AbZALT6e
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 14:58:34 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:34768 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755461AbZALT6d (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 14:58:33 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 4BCA080D8018;
	Mon, 12 Jan 2009 14:52:48 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ghAakph4dDT; Mon, 12 Jan 2009 14:52:48 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 28FB380D800F;
	Mon, 12 Jan 2009 14:52:48 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In bash, "set -u" gives an error when a variable is unbound. In this
case, the bash completion script included in the git/contrib directory
produces several errors.

The attached patch replaces things like

         if [ -z "$1" ]

with

         if [ -z "${1-}" ]

so that the unbound variable returns an empty value. Hence, the
completion script will now work even "set -u" set.

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---
  contrib/completion/git-completion.bash |   68 
++++++++++++++++----------------
  1 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/contrib/completion/git-completion.bash 
b/contrib/completion/git-completion.bash
index 7b074d7..50e345f 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -52,25 +52,25 @@ esac

  __gitdir ()
  {
-	if [ -z "$1" ]; then
-		if [ -n "$__git_dir" ]; then
+	if [ -z "${1-}" ]; then
+		if [ -n "${__git_dir-}" ]; then
  			echo "$__git_dir"
  		elif [ -d .git ]; then
  			echo .git
  		else
  			git rev-parse --git-dir 2>/dev/null
  		fi
-	elif [ -d "$1/.git" ]; then
-		echo "$1/.git"
+	elif [ -d "${1-}/.git" ]; then
+		echo "${1-}/.git"
  	else
-		echo "$1"
+		echo "${1-}"
  	fi
  }

  __git_ps1 ()
  {
  	local g="$(git rev-parse --git-dir 2>/dev/null)"
-	if [ -n "$g" ]; then
+	if [ -n "${g-}" ]; then
  		local r
  		local b
  		if [ -d "$g/rebase-apply" ]
@@ -111,8 +111,8 @@ __git_ps1 ()
  			fi
  		fi

-		if [ -n "$1" ]; then
-			printf "$1" "${b##refs/heads/}$r"
+		if [ -n "${1-}" ]; then
+			printf "${1-}" "${b##refs/heads/}$r"
  		else
  			printf " (%s)" "${b##refs/heads/}$r"
  		fi
@@ -122,11 +122,11 @@ __git_ps1 ()
  __gitcomp_1 ()
  {
  	local c IFS=' '$'\t'$'\n'
-	for c in $1; do
-		case "$c$2" in
-		--*=*) printf %s$'\n' "$c$2" ;;
-		*.)    printf %s$'\n' "$c$2" ;;
-		*)     printf %s$'\n' "$c$2 " ;;
+	for c in ${1-}; do
+		case "$c${2-}" in
+		--*=*) printf %s$'\n' "$c${2-}" ;;
+		*.)    printf %s$'\n' "$c${2-}" ;;
+		*)     printf %s$'\n' "$c${2-} " ;;
  		esac
  	done
  }
@@ -135,7 +135,7 @@ __gitcomp ()
  {
  	local cur="${COMP_WORDS[COMP_CWORD]}"
  	if [ $# -gt 2 ]; then
-		cur="$3"
+		cur="${3-}"
  	fi
  	case "$cur" in
  	--*=)
@@ -143,8 +143,8 @@ __gitcomp ()
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
@@ -152,13 +152,13 @@ __gitcomp ()

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
@@ -170,13 +170,13 @@ __git_heads ()

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
@@ -188,7 +188,7 @@ __git_tags ()

  __git_refs ()
  {
-	local i is_hash=y dir="$(__gitdir "$1")"
+	local i is_hash=y dir="$(__gitdir "${1-}")"
  	local cur="${COMP_WORDS[COMP_CWORD]}" format refs
  	if [ -d "$dir" ]; then
  		case "$cur" in
@@ -221,7 +221,7 @@ __git_refs ()
  __git_refs2 ()
  {
  	local i
-	for i in $(__git_refs "$1"); do
+	for i in $(__git_refs "${1-}"); do
  		echo "$i:$i"
  	done
  }
@@ -229,11 +229,11 @@ __git_refs2 ()
  __git_refs_remotes ()
  {
  	local cmd i is_hash=y
-	for i in $(git ls-remote "$1" 2>/dev/null); do
+	for i in $(git ls-remote "${1-}" 2>/dev/null); do
  		case "$is_hash,$i" in
  		n,refs/heads/*)
  			is_hash=y
-			echo "$i:refs/remotes/$1/${i#refs/heads/}"
+			echo "$i:refs/remotes/${1-}/${i#refs/heads/}"
  			;;
  		y,*) is_hash=n ;;
  		n,*^{}) is_hash=y ;;
@@ -264,7 +264,7 @@ __git_remotes ()

  __git_merge_strategies ()
  {
-	if [ -n "$__git_merge_strategylist" ]; then
+	if [ -n "${__git_merge_strategylist-}" ]; then
  		echo "$__git_merge_strategylist"
  		return
  	fi
@@ -350,7 +350,7 @@ __git_complete_revlist ()

  __git_all_commands ()
  {
-	if [ -n "$__git_all_commandlist" ]; then
+	if [ -n "${__git_all_commandlist-}" ]; then
  		echo "$__git_all_commandlist"
  		return
  	fi
@@ -368,7 +368,7 @@ __git_all_commandlist="$(__git_all_commands 
2>/dev/null)"

  __git_porcelain_commands ()
  {
-	if [ -n "$__git_porcelain_commandlist" ]; then
+	if [ -n "${__git_porcelain_commandlist-}" ]; then
  		echo "$__git_porcelain_commandlist"
  		return
  	fi
@@ -473,7 +473,7 @@ __git_aliases ()
  __git_aliased_command ()
  {
  	local word cmdline=$(git --git-dir="$(__gitdir)" \
-		config --get "alias.$1")
+		config --get "alias.${1-}")
  	for word in $cmdline; do
  		if [ "${word##-*}" ]; then
  			echo $word
@@ -488,7 +488,7 @@ __git_find_subcommand ()

  	while [ $c -lt $COMP_CWORD ]; do
  		word="${COMP_WORDS[c]}"
-		for subcommand in $1; do
+		for subcommand in ${1-}; do
  			if [ "$subcommand" = "$word" ]; then
  				echo "$subcommand"
  				return
@@ -599,7 +599,7 @@ _git_bisect ()

  	local subcommands="start bad good skip reset visualize replay log run"
  	local subcommand="$(__git_find_subcommand "$subcommands")"
-	if [ -z "$subcommand" ]; then
+	if [ -z "${subcommand-}" ]; then
  		__gitcomp "$subcommands"
  		return
  	fi
@@ -1371,7 +1371,7 @@ _git_remote ()
  {
  	local subcommands="add rm show prune update"
  	local subcommand="$(__git_find_subcommand "$subcommands")"
-	if [ -z "$subcommand" ]; then
+	if [ -z "${subcommand-}" ]; then
  		__gitcomp "$subcommands"
  		return
  	fi
@@ -1500,7 +1500,7 @@ _git_stash ()
  {
  	local subcommands='save list show apply clear drop pop create branch'
  	local subcommand="$(__git_find_subcommand "$subcommands")"
-	if [ -z "$subcommand" ]; then
+	if [ -z "${subcommand-}" ]; then
  		__gitcomp "$subcommands"
  	else
  		local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -1552,7 +1552,7 @@ _git_svn ()
  		proplist show-ignore show-externals
  		"
  	local subcommand="$(__git_find_subcommand "$subcommands")"
-	if [ -z "$subcommand" ]; then
+	if [ -z "${subcommand-}" ]; then
  		__gitcomp "$subcommands"
  	else
  		local remote_opts="--username= --config-dir= --no-auth-cache"
@@ -1672,7 +1672,7 @@ _git ()
  		c=$((++c))
  	done

-	if [ -z "$command" ]; then
+	if [ -z "${command-}" ]; then
  		case "${COMP_WORDS[COMP_CWORD]}" in
  		--*=*) COMPREPLY=() ;;
  		--*)   __gitcomp "
-- 
1.6.1.87.g15624
