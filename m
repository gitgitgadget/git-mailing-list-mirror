From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: [PATCH 1/2] Allow __git_ps1 to be used in PROMPT_COMMAND
Date: Fri, 5 Oct 2012 23:09:45 +0200
Message-ID: <20121005210945.GA4961@simaj.xs4all.nl>
References: <7v8vbo7hmd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: gitster@pobox.com, git@drmicha.warpmail.net, spearce@spearce.org,
	artagnon@gmail.com, schwab@linux-m68k.org, soosthoek@nieuwland.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 23:15:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKFFH-0001Bt-Pe
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 23:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737Ab2JEVPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 17:15:33 -0400
Received: from simaj.xs4all.nl ([83.160.71.26]:57208 "EHLO blacky"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932725Ab2JEVPb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2012 17:15:31 -0400
Received: by blacky (Postfix, from userid 1000)
	id E5D1040451; Fri,  5 Oct 2012 23:09:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v8vbo7hmd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207121>

changes __git_ps1 to not just allow use in setting PS1
with __git_ps1 in a command substitution, but also allows
__git_ps1 to be used as PROMPT_COMMAND in bash.
This has advantages for using color and I think it is more
elegant

Signed-off-by: Simon Oosthoek <soosthoek@nieuwland.nl>
---
 contrib/completion/git-prompt.sh |   51 +++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 29b1ec9..c50c94a 100644
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
+#        PROMPT_COMMAND="__git_ps1 '\u@\h:\w (' ')\$ '"
+#    3b) Alternatively change your PS1 to call __git_ps1 as
+#        command-substitution:
+#        Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
+#        ZSH:  PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
+#        the optional argument will be used as format string
 #
 # The argument to __git_ps1 will be displayed only if you are currently
 # in a git repository.  The %s token will be the name of the current
@@ -194,11 +199,41 @@ __git_ps1_show_upstream ()
 
 
 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
-# returns text to add to bash PS1 prompt (includes branch name)
+# when called from PS1 using command substitution
+# in this mode it returns text to add to bash PS1 prompt (includes branch name) or
+# __git_ps1 accepts 0 or 2 arguments when called from PROMPT_COMMAND
+# in that case it _sets_ PS1. The arguments are parts of a PS1 string.
+# when both arguments are given, the first is prepended and the second appended
+# to the state string when assigned to PS1, otherwise default start/end strings
+# are used.
 __git_ps1 ()
 {
+	local pcmode=yes
+	local ps1pc_start='\u@\h:\w '
+	local ps1pc_end='\$ '
+
+	case "$PROMPT_COMMAND" in
+		__git_ps1*)
+			if [ $# = 2 ]; then
+				ps1pc_start="$1"
+				ps1pc_end="$2"
+			fi
+			case "$PS1" in
+			*__git_ps1*)
+				echo '[31m__git_ps1: overwriting PS1 due to PROMPT_COMMAND[0m'
+			;;
+			esac
+		;;
+		*)  pcmode=no ;; #no output
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
@@ -284,6 +319,10 @@ __git_ps1 ()
 		fi
 
 		local f="$w$i$s$u"
-		printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
+		if [ $pcmode = yes ]; then
+			PS1="$ps1pc_start($c${b##refs/heads/}${f:+ $f}$r$p)$ps1pc_end"
+		elif [ $pcmode = no ]; then
+			printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
+		fi
 	fi
 }
-- 
1.7.9.5
