From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: [PATCH] Refactor git-completion to allow ZSH usage of PS1 functions
Date: Tue, 26 Apr 2011 08:24:48 -0500
Message-ID: <1303824288-15591-1-git-send-email-mstormo@gmail.com>
Cc: git@vger.kernel.org, Marius Storm-Olsen <mstormo@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 15:25:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEiGM-0004GV-UD
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 15:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755787Ab1DZNZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 09:25:05 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35921 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755904Ab1DZNZD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 09:25:03 -0400
Received: by wwa36 with SMTP id 36so694815wwa.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 06:25:01 -0700 (PDT)
Received: by 10.216.81.69 with SMTP id l47mr4507181wee.78.1303824301519;
        Tue, 26 Apr 2011 06:25:01 -0700 (PDT)
Received: from localhost.localdomain (24-155-176-18.dyn.grandenetworks.net [24.155.176.18])
        by mx.google.com with ESMTPS id b20sm3847202wbb.33.2011.04.26.06.24.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Apr 2011 06:25:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc2.4.g4d8b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172093>

The PS1 functions in git-completion are simple functions which
work just as well for ZSH as for Bash. So, refactoring them out
allows ZSH users to also use them, 'standardizing' the prompt\
for Git.

The only thing not supported by ZSH is the
    __git_ps1_show_upstream
function, so this functionality is simply forced disabled there.

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 This patch is mainly just moving the two functions
     __gitdir
     __git_ps1
 out into a new file. However, the most "nasty" is the way this
 file is then included from the original git-completion.bash
 file, with
     GIT_COMPLETION_BASH_ONLY=1
     source $(dirname ${BASH_SOURCE[0]})/git-prompt-functions
 where the variable ensures that only Bash will include the
     __git_ps1_show_upstream
 function call, and then the PS1 functions are loaded via a
 dirname'd BASH_SOURCE[0]. I am by no means a Bash guru, so
 others will have to evaluate the compatability of using this
 technique outside of Bash on Linux. Relying on $0 at least,
 does not work.

 Someone will also have to verify the RPM part at the bottom.


 contrib/completion/git-completion.bash  |  117 +-----------------------
 contrib/completion/git-prompt-functions |  149 +++++++++++++++++++++++++++++++
 git.spec.in                             |    1 +
 3 files changed, 153 insertions(+), 114 deletions(-)
 create mode 100755 contrib/completion/git-prompt-functions

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 840ae38..417cb0a 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -82,25 +82,6 @@ case "$COMP_WORDBREAKS" in
 *)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
 esac
 
-# __gitdir accepts 0 or 1 arguments (i.e., location)
-# returns location of .git repo
-__gitdir ()
-{
-	if [ -z "${1-}" ]; then
-		if [ -n "${__git_dir-}" ]; then
-			echo "$__git_dir"
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
 # stores the divergence from upstream in $p
 # used by GIT_PS1_SHOWUPSTREAM
 __git_ps1_show_upstream ()
@@ -220,101 +201,9 @@ __git_ps1_show_upstream ()
 
 }
 
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
-			        git rev-parse --verify refs/stash >/dev/null 2>&1 && s="$"
-			fi
-
-			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
-			   if [ -n "$(git ls-files --others --exclude-standard)" ]; then
-			      u="%"
-			   fi
-			fi
-
-			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
-				__git_ps1_show_upstream
-			fi
-		fi
-
-		local f="$w$i$s$u"
-		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
-	fi
-}
+# load the __git_ps1 functionality
+GIT_COMPLETION_BASH_ONLY=1
+source $(dirname ${BASH_SOURCE[0]})/git-prompt-functions
 
 # __gitcomp_1 requires 2 arguments
 __gitcomp_1 ()
diff --git a/contrib/completion/git-prompt-functions b/contrib/completion/git-prompt-functions
new file mode 100755
index 0000000..89d9449
--- /dev/null
+++ b/contrib/completion/git-prompt-functions
@@ -0,0 +1,149 @@
+#!bash
+#
+# bash/zsh prompt functions for core Git.
+#
+# Copyright (C) 2006,2007 Shawn O. Pearce <spearce@spearce.org>
+#
+# This code was originially in git-completion.bash. However,
+# since this code works just fine also for ZSH, it was refactored
+# out, to allow ZSH users to source only the prompt functionality,
+# given that ZSH already comes with git completion of its own.
+#
+# Bash users might consider setting
+#     PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
+# while the ZSH equivalent would be
+#     PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
+#
+# You may set the following values to tweak the output of the
+# __git_ps1() function:
+#
+#  GIT_PS1_SHOWDIRTYSTATE=true
+#     Reports if in a dirty state
+#      '*' means modified file(s)
+#      '+' means added file(s)
+#
+#  GIT_PS1_SHOWSTASHSTATE=true
+#     Reports the current stash state
+#
+#  GIT_PS1_SHOWUNTRACKEDFILES=true
+#     Reports if there are untracked files in the repo
+#
+#  GIT_PS1_SHOWUPSTREAM=auto
+#     Places the divergence of repo against upstream, in variable 'p'
+#     (Use $p in Bash prompts. Not available in ZSH prompts)
+#
+# See git-completion.bash for other details
+
+# __gitdir accepts 0 or 1 arguments (i.e., location)
+# returns location of .git repo
+__gitdir ()
+{
+	if [ -z "${1-}" ]; then
+		if [ -n "${__git_dir-}" ]; then
+			echo "$__git_dir"
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
+# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
+# returns text to add to bash PS1 prompt (includes branch name)
+__git_ps1 ()
+{
+	local g="$(__gitdir)"
+	if [ -n "$g" ]; then
+		local r=""
+		local b=""
+		if [ -f "$g/rebase-merge/interactive" ]; then
+			r="|REBASE-i"
+			b="$(cat "$g/rebase-merge/head-name")"
+		elif [ -d "$g/rebase-merge" ]; then
+			r="|REBASE-m"
+			b="$(cat "$g/rebase-merge/head-name")"
+		else
+			if [ -d "$g/rebase-apply" ]; then
+				if [ -f "$g/rebase-apply/rebasing" ]; then
+					r="|REBASE"
+				elif [ -f "$g/rebase-apply/applying" ]; then
+					r="|AM"
+				else
+					r="|AM/REBASE"
+				fi
+			elif [ -f "$g/MERGE_HEAD" ]; then
+				r="|MERGING"
+			elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
+				r="|CHERRY-PICKING"
+			elif [ -f "$g/BISECT_LOG" ]; then
+				r="|BISECTING"
+			fi
+
+			b="$(git symbolic-ref HEAD 2>/dev/null)" || {
+
+				b="$(
+				case "${GIT_PS1_DESCRIBE_STYLE-}" in
+				(contains)
+					git describe --contains HEAD ;;
+				(branch)
+					git describe --contains --all HEAD ;;
+				(describe)
+					git describe HEAD ;;
+				(* | default)
+					git describe --tags --exact-match HEAD ;;
+				esac 2>/dev/null)" ||
+
+				b="$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
+				b="unknown"
+				b="($b)"
+			}
+		fi
+
+		local w=""
+		local i=""
+		local s=""
+		local u=""
+		local c=""
+		local p=""
+
+		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
+			if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
+				c="BARE:"
+			else
+				b="GIT_DIR!"
+			fi
+		elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
+			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
+				if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
+					git diff --no-ext-diff --quiet --exit-code || w="*"
+					if git rev-parse --quiet --verify HEAD >/dev/null; then
+						git diff-index --cached --quiet HEAD -- || i="+"
+					else
+						i="#"
+					fi
+				fi
+			fi
+			if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
+				git rev-parse --verify refs/stash >/dev/null 2>&1 && s="$"
+			fi
+
+			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
+			   if [ -n "$(git ls-files --others --exclude-standard)" ]; then
+			      u="%"
+			   fi
+			fi
+
+			if [ -n "${GIT_COMPLETION_BASH_ONLY-}" ] && [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
+				__git_ps1_show_upstream
+			fi
+		fi
+
+		local f="$w$i$s$u"
+		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
+	fi
+}
diff --git a/git.spec.in b/git.spec.in
index 91c8462..c81385e 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -137,6 +137,7 @@ rm -rf $RPM_BUILD_ROOT%{_mandir}
 
 mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/bash_completion.d
 install -m 644 -T contrib/completion/git-completion.bash $RPM_BUILD_ROOT%{_sysconfdir}/bash_completion.d/git
+install -m 644 -T contrib/completion/git-prompt-functions $RPM_BUILD_ROOT%{_sysconfdir}/bash_completion.d/git-prompt-functions
 
 %clean
 rm -rf $RPM_BUILD_ROOT
-- 
1.7.5.rc2.4.g4d8b3
