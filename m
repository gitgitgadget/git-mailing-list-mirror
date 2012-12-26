From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: [PATCH] make __git_ps1 accept a third parameter in pcmode
Date: Wed, 26 Dec 2012 20:15:05 +0100
Message-ID: <20121226191505.GA29210@simaj.xs4all.nl>
References: <7vvcbpp846.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: s.oosthoek@xs4all.nl, piotr.krukowiecki@gmail.com,
	git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 26 20:20:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnwWj-0006h9-0t
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 20:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564Ab2LZTUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 14:20:10 -0500
Received: from simaj.xs4all.nl ([83.160.71.26]:48463 "EHLO simaj.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319Ab2LZTUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 14:20:09 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Dec 2012 14:20:08 EST
Received: by simaj.xs4all.nl (Postfix, from userid 1000)
	id AC7B540C7B; Wed, 26 Dec 2012 20:15:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vvcbpp846.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212144>

The optional third parameter when __git_ps1 is used in
PROMPT_COMMAND mode as format string for printf to further
customize the way the git status string is embedded in the
user's PS1 prompt.

Signed-off-by: Simon Oosthoek <s.oosthoek@xs4all.nl>
---
 contrib/completion/git-prompt.sh |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 9b074e1..2922bb3 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -24,6 +24,8 @@
 #        will show username, at-sign, host, colon, cwd, then
 #        various status string, followed by dollar and SP, as
 #        your prompt.
+#        Optionally, you can supply a third argument with a printf
+#        format string to finetune the output of the branch status
 #
 # The argument to __git_ps1 will be displayed only if you are currently
 # in a git repository.  The %s token will be the name of the current
@@ -222,10 +224,12 @@ __git_ps1_show_upstream ()
 # when called from PS1 using command substitution
 # in this mode it prints text to add to bash PS1 prompt (includes branch name)
 #
-# __git_ps1 requires 2 arguments when called from PROMPT_COMMAND (pc)
+# __git_ps1 requires 2 or 3 arguments when called from PROMPT_COMMAND (pc)
 # in that case it _sets_ PS1. The arguments are parts of a PS1 string.
-# when both arguments are given, the first is prepended and the second appended
+# when two arguments are given, the first is prepended and the second appended
 # to the state string when assigned to PS1.
+# The optional third parameter will be used as printf format string to further
+# customize the output of the git-status string.
 # In this mode you can request colored hints using GIT_PS1_SHOWCOLORHINTS=true
 __git_ps1 ()
 {
@@ -236,9 +240,10 @@ __git_ps1 ()
 	local printf_format=' (%s)'
 
 	case "$#" in
-		2)	pcmode=yes
+		2|3)	pcmode=yes
 			ps1pc_start="$1"
 			ps1pc_end="$2"
+			printf_format="${3:-$printf_format}"
 		;;
 		0|1)	printf_format="${1:-$printf_format}"
 		;;
@@ -339,6 +344,7 @@ __git_ps1 ()
 
 		local f="$w$i$s$u"
 		if [ $pcmode = yes ]; then
+			local gitstring=
 			if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
 				local c_red='\e[31m'
 				local c_green='\e[32m'
@@ -356,29 +362,31 @@ __git_ps1 ()
 					branch_color="$bad_color"
 				fi
 
-				# Setting PS1 directly with \[ and \] around colors
+				# Setting gitstring directly with \[ and \] around colors
 				# is necessary to prevent wrapping issues!
-				PS1="$ps1pc_start (\[$branch_color\]$branchstring\[$c_clear\]"
+				gitstring="\[$branch_color\]$branchstring\[$c_clear\]"
 
 				if [ -n "$w$i$s$u$r$p" ]; then
-					PS1="$PS1 "
+					gitstring="$gitstring "					
 				fi
 				if [ "$w" = "*" ]; then
-					PS1="$PS1\[$bad_color\]$w"
+					gitstring="$gitstring\[$bad_color\]$w"
 				fi
 				if [ -n "$i" ]; then
-					PS1="$PS1\[$ok_color\]$i"
+					gitstring="$gitstring\[$ok_color\]$i"
 				fi
 				if [ -n "$s" ]; then
-					PS1="$PS1\[$flags_color\]$s"
+					gitstring="$gitstring\[$flags_color\]$s"
 				fi
 				if [ -n "$u" ]; then
-					PS1="$PS1\[$bad_color\]$u"
+					gitstring="$gitstring\[$bad_color\]$u"
 				fi
-				PS1="$PS1\[$c_clear\]$r$p)$ps1pc_end"
+				gitstring="$gitstring\[$c_clear\]$r$p"
 			else
-				PS1="$ps1pc_start ($c${b##refs/heads/}${f:+ $f}$r$p)$ps1pc_end"
+				gitstring="$c${b##refs/heads/}${f:+ $f}$r$p"
 			fi
+			gitstring=$(printf -- "$printf_format" "$gitstring")
+			PS1="$ps1pc_start$gitstring$ps1pc_end"
 		else
 			# NO color option unless in PROMPT_COMMAND mode
 			printf -- "$printf_format" "$c${b##refs/heads/}${f:+ $f}$r$p"
-- 
1.7.9.5

PS, I was surprised that this worked, because I was under the impression that the \[ \] special characters needed to be put in PS1 directly. This is apparently not exactly the case, but I'm now more confused than before ;-)
