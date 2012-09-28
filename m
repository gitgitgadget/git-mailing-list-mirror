From: Simon Oosthoek <soosthoek@nieuwland.nl>
Subject: [PATCH] Add __git_ps1_pc to use as PROMPT_COMMAND
Date: Fri, 28 Sep 2012 13:40:11 +0200
Message-ID: <50658C9B.6030809@nieuwland.nl>
References: <5064140E.50007@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: s.oosthoek@xs4all.nl, Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	schwab@linux-m68k.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 13:40:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THYvt-0005cM-Sa
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 13:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757095Ab2I1Lk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 07:40:28 -0400
Received: from mail.nieuwland.nl ([87.251.35.136]:44474 "HELO nieuwland.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753844Ab2I1Lk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 07:40:27 -0400
Received: (qmail 18254 invoked by uid 453); 28 Sep 2012 11:40:15 -0000
X-Virus-Checked: Checked by ClamAV on nieuwland.nl
Received: from Unknown (HELO [192.168.216.232]) (192.168.216.232)
  (smtp-auth username soosthoek, mechanism plain)
  by nieuwland.nl (qpsmtpd/0.83) with (AES256-SHA encrypted) ESMTPSA; Fri, 28 Sep 2012 13:40:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <5064140E.50007@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206555>

Hi again

After the previous comments, I decided to attempt it using 
PROMPT_COMMAND rather than calling a function from command substitution 
in PS1. This new code works and doesn't have the wrapping issue anymore.
I've simplified some of the coloring stuff and for now there's no 
parameters to customize the PS1. Users will have to customize the 
function itself for now...
As a small observation, I think it's more logical to use PROMPT_COMMAND, 
since that explicitly uses a function, rather than using command 
substitution when setting PS1.
Obviously, as I didn't remove __git_ps1, the older use is unchanged, but 
now there is about 80% duplication of code between __git_ps1 and 
__git-ps1_pc
And AFAICT zsh is not supported here due to different escape characters 
(\ in bash, % in zsh)
Please let me know if and how this can/should be integrated!

Cheers

Simon




The function can set the PS1 varible optionally with
Colored hints about the state of the tree when
GIT_PS1_SHOWCOLORHINTS is set to a nonempty value.
This version doesn't accept arguments to customize the
prompt. And it has not been tested with zsh.

Signed-off-by: Simon Oosthoek <soosthoek@nieuwland.nl>
---
  contrib/completion/git-prompt.sh |  135 
++++++++++++++++++++++++++++++++++++++
  1 file changed, 135 insertions(+)

diff --git a/contrib/completion/git-prompt.sh 
b/contrib/completion/git-prompt.sh
index 29b1ec9..8ed6b84 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -48,6 +48,16 @@
  # find one, or @{upstream} otherwise.  Once you have set
  # GIT_PS1_SHOWUPSTREAM, you can override it on a per-repository basis by
  # setting the bash.showUpstream config variable.
+#
+# If you would like colored hints in the branchname shown in the prompt
+# you can set PROMPT_COMMAND (bash) to __git_ps1_pc and export the +# 
variables GIT_PS1_SHOWDIRTYSTATE and GIT_PS1_SHOWCOLORHINT:
+# example:
+# export GIT_PS1_SHOWDIRTYSTATE=true
+# export GIT_PS1_SHOWCOLORHINT=true
+# export PROMPT_COMMAND=__git_ps1_pc
+# The prompt command function will directly set PS1, in order to +# 
insert color commands in a way that doesn't mess up wrapping.
   # __gitdir accepts 0 or 1 arguments (i.e., location)
  # returns location of .git repo
@@ -287,3 +297,128 @@ __git_ps1 ()
  		printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
  	fi
  }
+
+
+# __git_ps1_pc accepts 0 arguments (for now)
+# It is meant to be used as PROMPT_COMMAND, it sets PS1
+__git_ps1_pc ()
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
+			if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; 
then
+				c="BARE:"
+			else
+				b="GIT_DIR!"
+			fi
+		elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" 
]; then
+			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
+				if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
+					git diff --no-ext-diff --quiet || w="*"
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
+				if [ -n "$(git ls-files --others --exclude-standard)" ]; then
+					u="%"
+				fi
+			fi
+
+			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
+				__git_ps1_show_upstream
+			fi
+		fi
+
+		PS1='\u@\h:\w ('
+		if [ -n "${GIT_PS1_SHOWCOLORHINT-}" ]; then
+			local c_red='\e[31m'
+			local c_green='\e[32m'
+			local c_yellow='\e[33m'
+			local c_lblue='\e[1;34m'
+			local c_purple='\e[35m'
+			local c_cyan='\e[36m'
+			local c_clear='\e[0m'
+			local branchstring="$c${b##refs/heads/}"
+			local branch_color="$c_green"
+			local flags_color="$c_cyan"
+
+			if [ "$w" = "*" ]; then
+				branch_color="$c_red"
+			elif [ -n "$i" ]; then
+				branch_color="$c_yellow"
+			fi
+			
+			# Setting PS1 directly with \[ and \] around colors
+			# is necessary to prevent wrapping issues!
+			PS1="$PS1\[$branch_color\]$branchstring\[$c_clear\]"
+			if [ -n "$w$i$s$u" ]; then
+				PS1="$PS1 \[$flags_color\]$w$i$s$u\[$c_clear\]"
+			fi
+		else
+			local f="$w$i$s$u"
+			PS1="$PS1$c${b##refs/heads/}${f:+ $f}$r$p"
+		fi
+		PS1="$PS1)\$ "
+
+	fi
+}
-- 
1.7.9.5
