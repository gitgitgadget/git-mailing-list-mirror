From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH] __git_ps1: migrate out of contrib/completion
Date: Thu, 25 Oct 2012 00:45:49 -0700
Message-ID: <20121025074549.GC15790@elie.Belkin>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
 <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
 <20121025005106.GA9112@elie.Belkin>
 <3B606942-D194-4148-AF6E-1F3283C983ED@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Anders Kaseorg <andersk@MIT.EDU>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ted Pavlic <ted@tedpavlic.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Dan McGee <dan@archlinux.org>
To: Danny Yates <mail4danny@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 09:46:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRI8m-0008K8-08
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 09:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272Ab2JYHpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 03:45:55 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:41831 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469Ab2JYHpy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 03:45:54 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so657451dak.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 00:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=iXTdL8k+lL2goK/zGWKTmcdfOr0dTK7yLLlygQx0yl4=;
        b=z9kms7R+kDvmp4C9HXDQkufm5LEHGxwsN0rJ8GVtsw7R+I+AFIU++uxmDFNdf0yAgp
         fnCgAthVyqTg1G8fiQXmj8DQPJhjaxf1hqGUtyjLzAWTd+xHcA2ZgDQeyDgvObWim8ze
         G2LuiRGCpJyKu/9MUvWlBCNd7t7mVTj1u01aeAHrWmOm5GvV1+vI0KgTR1Q6tXED5O43
         xj6F9CPq4QgB/ECv6R+KLGEM86gQHnylE1ZyAPh5tq8lh/F0EIdaAxOImQ4q8mD+P3QV
         OCmF/qWep2tqidfatJg6bhAG7RSgiCMnYiXxPH8LEmRNISwzY8p8KiWo3Efsl2qpPqum
         29DA==
Received: by 10.66.85.227 with SMTP id k3mr50771743paz.79.1351151153620;
        Thu, 25 Oct 2012 00:45:53 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id gl9sm10802711pbc.51.2012.10.25.00.45.52
        (version=SSLv3 cipher=OTHER);
        Thu, 25 Oct 2012 00:45:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3B606942-D194-4148-AF6E-1F3283C983ED@googlemail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208359>

Different installers put the git-prompt.sh shell library at different
places on the installed system, so there is no shared location users
can count on:

  Fedora - /etc/profile.d/git-prompt.sh
  Gentoo - /usr/share/bash-completion/git-prompt
  Arch - /usr/share/git/git-prompt.sh

The __git_ps1 helper doesn't have anything to do with bash completion
in principle, but because it was written in the context of that
project, its sources are kept in contrib/completion/git-prompt.sh.
Let's make it a first-class shell library in the toplevel and install
it to $(gitexecdir) alongside git-sh-setup and git-sh-i18n, where it
can be easily found.

Keep a symlink in contrib/completion/ to avoid breaking setups where
this library is used directly from the source tree.

Now you can put the following in your ~/.bashrc:

	if test "${BASH+set}" && test "${PS1+set}"	# interactive!
	then
		gitexecdir=$(git --exec-path)
		if test -r "$gitexecdir/git-sh-prompt)"
		then
			. "$gitexecdir/git-sh-prompt"
		fi
		if type -t __git_ps1 >/dev/null
		then
			PS1='\w$(__git_ps1)\$ '
		fi
	fi

and the shell prompt will show the current branch name in git
repositories when on a machine with a new enough version of git.

Reported-by: Danny Yates <mail4danny@googlemail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Danny Yates wrote:

> Would that not give the impression of "git sh-prompt" being a core
> command? If so, that would be poor, IMHO. 

Not any more than $(git --exec-path)/git-sh-setup and git-sh-i18n. :)

> When I was investigating this last night, I expected to find it
> (git-prompt.sh) in contrib, although that doesn't make an enormous
> amount of sense. Ideally, the full path to wherever it's installed
> should be mentioned in the bash completion file (which is where I
> went to look when __git_ps1 stopped working),

Yes, certainly.

>                                               but that would mean
> modifying a file from upstream and I'm not sure if that's easy/"the
> done thing".

We're talking on the upstream list now, so that's not an issue.

Thanks,
Jonathan

 Documentation/git-sh-prompt.txt                    |  79 ++++++
 Makefile                                           |   1 +
 contrib/completion/git-completion.bash             |   2 +-
 contrib/completion/git-prompt.sh                   | 291 +--------------------
 .../completion/git-prompt.sh => git-sh-prompt.sh   |   0
 5 files changed, 82 insertions(+), 291 deletions(-)
 create mode 100644 Documentation/git-sh-prompt.txt
 rewrite contrib/completion/git-prompt.sh (100%)
 mode change 100644 => 120000
 rename contrib/completion/git-prompt.sh => git-sh-prompt.sh (100%)

diff --git a/Documentation/git-sh-prompt.txt b/Documentation/git-sh-prompt.txt
new file mode 100644
index 00000000..2c705fef
--- /dev/null
+++ b/Documentation/git-sh-prompt.txt
@@ -0,0 +1,79 @@
+git-sh-prompt(1)
+================
+
+NAME
+----
+git-sh-prompt - Functions to describe repository in bash or zsh prompt
+
+SYNOPSIS
+--------
+[verse]
+'. "$(git --exec-path)/git-sh-prompt"'
+
+DESCRIPTION
+-----------
+This script allows you to see the current branch in your bash prompt.
+
+To enable:
+
+1. Add the following line to your .bashrc and .zshrc:
+
+	. "$(git --exec-path)/git-sh-prompt"
+
+2. Change your PS1 to also show the current branch:
+
+	Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
+	Zsh:  PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
+
+The argument to __git_ps1 will only be displayed if you are currently
+in a git repository.  The %s token is replaced by the name of the current
+branch.
+
+In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty value,
+unstaged (`*`) and staged (`+`) changes are indicated next to the branch
+name. You can configure this per repository with the `bash.showDirtyState`
+variable, which defaults to `true` once GIT_PS1_SHOWDIRTYSTATE is enabled.
+
+You can also see if something is currently stashed, by setting
+GIT_PS1_SHOWSTASHSTATE to a nonempty value. If something is stashed,
+then a '$' is shown next to the branch name.
+
+If you would like to see if there are untracked files, set
+GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value.  If there are untracked
+files, a '%' is shown next to the branch name.
+
+If you would like to see the difference between HEAD and its upstream,
+set GIT_PS1_SHOWUPSTREAM=auto.  A '<' indicates the current branch is
+behind, '>' indicates it is ahead, '<>' indicates it has diverged, and
+'=' indicates no difference.  You can further control behavior by
+setting GIT_PS1_SHOWUPSTREAM to a space-separated list of values:
+
+verbose::
+	show number of commits ahead of/behind (+/-) upstream
+legacy::
+	don't use the '--count' option available in recent versions
+	of git-rev-list
+git::
+	always compare HEAD to `@{upstream}`
+svn::
+	always compare HEAD to your 'git svn' upstream
+
+By default, __git_ps1 compares HEAD to your 'git svn' upstream if it can
+find one, or `@{upstream}` otherwise.  Once you have set GIT_PS1_SHOWUPSTREAM,
+you can override it on a per-repository basis by setting the `bash.showUpstream`
+config variable.
+
+FUNCTIONS
+---------
+
+'__gitdir' [<directory>]::
+	Print the path to the git repository (`.git` directory).  This is
+	similar to `git rev-parse --git-dir` but it is faster because it avoids
+	forking a new process when possible.
+
+'__git_ps1_show_upstream'::
+	Internal function.
+
+'__git_ps1 [<format>]'::
+	Print text to add to the shell's PS1 prompt, including the current
+	branch name.  If <format> is not specified, it defaults to " (%s)".
diff --git a/Makefile b/Makefile
index f69979e3..c12d973b 100644
--- a/Makefile
+++ b/Makefile
@@ -459,6 +459,7 @@ SCRIPT_LIB += git-rebase--interactive
 SCRIPT_LIB += git-rebase--merge
 SCRIPT_LIB += git-sh-setup
 SCRIPT_LIB += git-sh-i18n
+SCRIPT_LIB += git-sh-prompt
 
 SCRIPT_PERL += git-add--interactive.perl
 SCRIPT_PERL += git-difftool.perl
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index be800e09..01238588 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -21,7 +21,7 @@
 #    2) Add the following line to your .bashrc/.zshrc:
 #        source ~/.git-completion.sh
 #    3) Consider changing your PS1 to also show the current branch,
-#       see git-prompt.sh for details.
+#       see git-sh-prompt(1) for details.
 
 if [[ -n ${ZSH_VERSION-} ]]; then
 	autoload -U +X bashcompinit && bashcompinit
diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
deleted file mode 100644
index bf20491e..00000000
--- a/contrib/completion/git-prompt.sh
+++ /dev/null
@@ -1,290 +0,0 @@
-# bash/zsh git prompt support
-#
-# Copyright (C) 2006,2007 Shawn O. Pearce <spearce@spearce.org>
-# Distributed under the GNU General Public License, version 2.0.
-#
-# This script allows you to see the current branch in your prompt.
-#
-# To enable:
-#
-#    1) Copy this file to somewhere (e.g. ~/.git-prompt.sh).
-#    2) Add the following line to your .bashrc/.zshrc:
-#        source ~/.git-prompt.sh
-#    3) Change your PS1 to also show the current branch:
-#         Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
-#         ZSH:  PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
-#
-# The argument to __git_ps1 will be displayed only if you are currently
-# in a git repository.  The %s token will be the name of the current
-# branch.
-#
-# In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty value,
-# unstaged (*) and staged (+) changes will be shown next to the branch
-# name.  You can configure this per-repository with the
-# bash.showDirtyState variable, which defaults to true once
-# GIT_PS1_SHOWDIRTYSTATE is enabled.
-#
-# You can also see if currently something is stashed, by setting
-# GIT_PS1_SHOWSTASHSTATE to a nonempty value. If something is stashed,
-# then a '$' will be shown next to the branch name.
-#
-# If you would like to see if there're untracked files, then you can set
-# GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're untracked
-# files, then a '%' will be shown next to the branch name.
-#
-# If you would like to see the difference between HEAD and its upstream,
-# set GIT_PS1_SHOWUPSTREAM="auto".  A "<" indicates you are behind, ">"
-# indicates you are ahead, "<>" indicates you have diverged and "="
-# indicates that there is no difference. You can further control
-# behaviour by setting GIT_PS1_SHOWUPSTREAM to a space-separated list
-# of values:
-#
-#     verbose       show number of commits ahead/behind (+/-) upstream
-#     legacy        don't use the '--count' option available in recent
-#                   versions of git-rev-list
-#     git           always compare HEAD to @{upstream}
-#     svn           always compare HEAD to your SVN upstream
-#
-# By default, __git_ps1 will compare HEAD to your SVN upstream if it can
-# find one, or @{upstream} otherwise.  Once you have set
-# GIT_PS1_SHOWUPSTREAM, you can override it on a per-repository basis by
-# setting the bash.showUpstream config variable.
-
-# __gitdir accepts 0 or 1 arguments (i.e., location)
-# returns location of .git repo
-__gitdir ()
-{
-	# Note: this function is duplicated in git-completion.bash
-	# When updating it, make sure you update the other one to match.
-	if [ -z "${1-}" ]; then
-		if [ -n "${__git_dir-}" ]; then
-			echo "$__git_dir"
-		elif [ -n "${GIT_DIR-}" ]; then
-			test -d "${GIT_DIR-}" || return 1
-			echo "$GIT_DIR"
-		elif [ -d .git ]; then
-			echo .git
-		else
-			git rev-parse --git-dir 2>/dev/null
-		fi
-	elif [ -d "$1/.git" ]; then
-		echo "$1/.git"
-	else
-		echo "$1"
-	fi
-}
-
-# stores the divergence from upstream in $p
-# used by GIT_PS1_SHOWUPSTREAM
-__git_ps1_show_upstream ()
-{
-	local key value
-	local svn_remote svn_url_pattern count n
-	local upstream=git legacy="" verbose=""
-
-	svn_remote=()
-	# get some config options from git-config
-	local output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
-	while read -r key value; do
-		case "$key" in
-		bash.showupstream)
-			GIT_PS1_SHOWUPSTREAM="$value"
-			if [[ -z "${GIT_PS1_SHOWUPSTREAM}" ]]; then
-				p=""
-				return
-			fi
-			;;
-		svn-remote.*.url)
-			svn_remote[ $((${#svn_remote[@]} + 1)) ]="$value"
-			svn_url_pattern+="\\|$value"
-			upstream=svn+git # default upstream is SVN if available, else git
-			;;
-		esac
-	done <<< "$output"
-
-	# parse configuration values
-	for option in ${GIT_PS1_SHOWUPSTREAM}; do
-		case "$option" in
-		git|svn) upstream="$option" ;;
-		verbose) verbose=1 ;;
-		legacy)  legacy=1  ;;
-		esac
-	done
-
-	# Find our upstream
-	case "$upstream" in
-	git)    upstream="@{upstream}" ;;
-	svn*)
-		# get the upstream from the "git-svn-id: ..." in a commit message
-		# (git-svn uses essentially the same procedure internally)
-		local svn_upstream=($(git log --first-parent -1 \
-					--grep="^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null))
-		if [[ 0 -ne ${#svn_upstream[@]} ]]; then
-			svn_upstream=${svn_upstream[ ${#svn_upstream[@]} - 2 ]}
-			svn_upstream=${svn_upstream%@*}
-			local n_stop="${#svn_remote[@]}"
-			for ((n=1; n <= n_stop; n++)); do
-				svn_upstream=${svn_upstream#${svn_remote[$n]}}
-			done
-
-			if [[ -z "$svn_upstream" ]]; then
-				# default branch name for checkouts with no layout:
-				upstream=${GIT_SVN_ID:-git-svn}
-			else
-				upstream=${svn_upstream#/}
-			fi
-		elif [[ "svn+git" = "$upstream" ]]; then
-			upstream="@{upstream}"
-		fi
-		;;
-	esac
-
-	# Find how many commits we are ahead/behind our upstream
-	if [[ -z "$legacy" ]]; then
-		count="$(git rev-list --count --left-right \
-				"$upstream"...HEAD 2>/dev/null)"
-	else
-		# produce equivalent output to --count for older versions of git
-		local commits
-		if commits="$(git rev-list --left-right "$upstream"...HEAD 2>/dev/null)"
-		then
-			local commit behind=0 ahead=0
-			for commit in $commits
-			do
-				case "$commit" in
-				"<"*) ((behind++)) ;;
-				*)    ((ahead++))  ;;
-				esac
-			done
-			count="$behind	$ahead"
-		else
-			count=""
-		fi
-	fi
-
-	# calculate the result
-	if [[ -z "$verbose" ]]; then
-		case "$count" in
-		"") # no upstream
-			p="" ;;
-		"0	0") # equal to upstream
-			p="=" ;;
-		"0	"*) # ahead of upstream
-			p=">" ;;
-		*"	0") # behind upstream
-			p="<" ;;
-		*)	    # diverged from upstream
-			p="<>" ;;
-		esac
-	else
-		case "$count" in
-		"") # no upstream
-			p="" ;;
-		"0	0") # equal to upstream
-			p=" u=" ;;
-		"0	"*) # ahead of upstream
-			p=" u+${count#0	}" ;;
-		*"	0") # behind upstream
-			p=" u-${count%	0}" ;;
-		*)	    # diverged from upstream
-			p=" u+${count#*	}-${count%	*}" ;;
-		esac
-	fi
-
-}
-
-
-# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
-# returns text to add to bash PS1 prompt (includes branch name)
-__git_ps1 ()
-{
-	local g="$(__gitdir)"
-	if [ -n "$g" ]; then
-		local r=""
-		local b=""
-		if [ -f "$g/rebase-merge/interactive" ]; then
-			r="|REBASE-i"
-			b="$(cat "$g/rebase-merge/head-name")"
-		elif [ -d "$g/rebase-merge" ]; then
-			r="|REBASE-m"
-			b="$(cat "$g/rebase-merge/head-name")"
-		else
-			if [ -d "$g/rebase-apply" ]; then
-				if [ -f "$g/rebase-apply/rebasing" ]; then
-					r="|REBASE"
-				elif [ -f "$g/rebase-apply/applying" ]; then
-					r="|AM"
-				else
-					r="|AM/REBASE"
-				fi
-			elif [ -f "$g/MERGE_HEAD" ]; then
-				r="|MERGING"
-			elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
-				r="|CHERRY-PICKING"
-			elif [ -f "$g/BISECT_LOG" ]; then
-				r="|BISECTING"
-			fi
-
-			b="$(git symbolic-ref HEAD 2>/dev/null)" || {
-
-				b="$(
-				case "${GIT_PS1_DESCRIBE_STYLE-}" in
-				(contains)
-					git describe --contains HEAD ;;
-				(branch)
-					git describe --contains --all HEAD ;;
-				(describe)
-					git describe HEAD ;;
-				(* | default)
-					git describe --tags --exact-match HEAD ;;
-				esac 2>/dev/null)" ||
-
-				b="$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
-				b="unknown"
-				b="($b)"
-			}
-		fi
-
-		local w=""
-		local i=""
-		local s=""
-		local u=""
-		local c=""
-		local p=""
-
-		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
-			if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
-				c="BARE:"
-			else
-				b="GIT_DIR!"
-			fi
-		elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
-			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
-				if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
-					git diff --no-ext-diff --quiet --exit-code || w="*"
-					if git rev-parse --quiet --verify HEAD >/dev/null; then
-						git diff-index --cached --quiet HEAD -- || i="+"
-					else
-						i="#"
-					fi
-				fi
-			fi
-			if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
-				git rev-parse --verify refs/stash >/dev/null 2>&1 && s="$"
-			fi
-
-			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
-				if [ -n "$(git ls-files --others --exclude-standard)" ]; then
-					u="%"
-				fi
-			fi
-
-			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
-				__git_ps1_show_upstream
-			fi
-		fi
-
-		local f="$w$i$s$u"
-		printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
-	fi
-}
diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
new file mode 120000
index 00000000..a4fbb216
--- /dev/null
+++ b/contrib/completion/git-prompt.sh
@@ -0,0 +1 @@
+../../git-sh-prompt.sh
\ No newline at end of file
diff --git a/contrib/completion/git-prompt.sh b/git-sh-prompt.sh
similarity index 100%
rename from contrib/completion/git-prompt.sh
rename to git-sh-prompt.sh
-- 
1.8.0
