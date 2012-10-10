From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: [PATCH 1/2] Allow __git_ps1 to be used in PROMPT_COMMAND
Date: Wed, 10 Oct 2012 21:37:51 +0200
Message-ID: <20121010193750.GA7155@simaj.xs4all.nl>
References: <7v7gr0k6jv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@drmicha.warpmail.net, spearce@spearce.org,
	artagnon@gmail.com, schwab@linux-m68k.org, soosthoek@nieuwland.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 21:38:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM26V-0005cX-0O
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 21:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756163Ab2JJThw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 15:37:52 -0400
Received: from simaj.xs4all.nl ([83.160.71.26]:45652 "EHLO simaj.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977Ab2JJThw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 15:37:52 -0400
Received: by simaj.xs4all.nl (Postfix, from userid 1000)
	id 12E8A411E9; Wed, 10 Oct 2012 21:37:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v7gr0k6jv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207431>

Apologies if you receive this e-mail multiple times, my MTA was misconfigured...


Changes __git_ps1 to allow its use as PROMPT_COMMAND in bash
in addition to setting PS1 with __git_ps1 in a command substitution.
PROMPT_COMMAND has advantages for using color without running
into prompt-wrapping issues. Only by assigning \[ and \] to PS1
directly can bash know that these and the enclosed zero-width codes in
between don't count in the length of the prompt.

Signed-off-by: Simon Oosthoek <s.oosthoek@xs4all.nl>
---
 contrib/completion/git-prompt.sh |   51 +++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 29b1ec9..4fbc1e6 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -10,9 +10,14 @@
 #    1) Copy this file to somewhere (e.g. ~/.git-prompt.sh).
 #    2) Add the following line to your .bashrc/.zshrc:
 #        source ~/.git-prompt.sh
-#    3) Change your PS1 to also show the current branch:
-#         Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
-#         ZSH:  PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
+#    3a) In ~/.bashrc set PROMPT_COMMAND=__git_ps1
+#        To customize the prompt, provide start/end arguments
+#        PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
+#    3b) Alternatively change your PS1 to call __git_ps1 as
+#        command-substitution:
+#        Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
+#        ZSH:  PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
+#        the optional argument will be used as format string
 #
 # The argument to __git_ps1 will be displayed only if you are currently
 # in a git repository.  The %s token will be the name of the current
@@ -194,11 +199,39 @@ __git_ps1_show_upstream ()
 
 
 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
-# returns text to add to bash PS1 prompt (includes branch name)
+# when called from PS1 using command substitution
+# in this mode it prints text to add to bash PS1 prompt (includes branch name)
+#
+# __git_ps1 requires 2 arguments when called from PROMPT_COMMAND (pc)
+# in that case it _sets_ PS1. The arguments are parts of a PS1 string.
+# when both arguments are given, the first is prepended and the second appended
+# to the state string when assigned to PS1.
 __git_ps1 ()
 {
+	local pcmode=no
+	#defaults/examples:
+	local ps1pc_start='\u@\h:\w '
+	local ps1pc_end='\$ '
+	local printf_format='(%s)'
+
+	case "$#" in
+		2)	pcmode=yes
+			ps1pc_start="$1"
+			ps1pc_end="$2"
+		;;
+		0|1)	printf_format="${1:-$printf_format}"
+		;;
+		*)	return
+		;;
+	esac
+
 	local g="$(__gitdir)"
-	if [ -n "$g" ]; then
+	if [ -z "$g" ]; then
+		if [ $pcmode = yes ]; then
+			#In PC mode PS1 always needs to be set
+			PS1="$ps1pc_start$ps1pc_end"
+		fi
+	else
 		local r=""
 		local b=""
 		if [ -f "$g/rebase-merge/interactive" ]; then
@@ -284,6 +317,12 @@ __git_ps1 ()
 		fi
 
 		local f="$w$i$s$u"
-		printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
+		if [ $pcmode = yes ]; then
+			PS1="$ps1pc_start("
+			PS1="$PS1$c${b##refs/heads/}${f:+ $f}$r$p"
+			PS1="$PS1)$ps1pc_end"
+		else
+			printf -- "$printf_format" "$c${b##refs/heads/}${f:+ $f}$r$p"
+		fi
 	fi
 }
-- 
1.7.9.5
