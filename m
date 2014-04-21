From: Richard Hansen <rhansen@bbn.com>
Subject: [SECURITY PATCH] git-prompt.sh: don't put unsanitized branch names in $PS1
Date: Mon, 21 Apr 2014 15:07:28 -0400
Message-ID: <1398107248-32140-1-git-send-email-rhansen@bbn.com>
Cc: sitaramc@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 21:52:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcKG7-00057I-KX
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 21:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542AbaDUTwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 15:52:03 -0400
Received: from smtp.bbn.com ([128.33.1.81]:29540 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891AbaDUTwC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 15:52:02 -0400
X-Greylist: delayed 2662 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Apr 2014 15:52:02 EDT
Received: from socket.bbn.com ([192.1.120.102]:42568)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WcJZC-0004cR-UK; Mon, 21 Apr 2014 15:07:47 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 4B6CA3FF81
X-Mailer: git-send-email 1.9.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246629>

Both bash and zsh subject the value of PS1 to parameter expansion,
command substitution, and arithmetic expansion.  Rather than include
the raw, unescaped branch name in PS1 when running in two- or
three-argument mode, construct PS1 to reference a variable that holds
the branch name.  Because the shells do not recursively expand, this
avoids arbitrary code execution by specially-crafted branch names such
as '$(IFS=_;cmd=sudo_rm_-rf_/;$cmd)'.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
To see the vulnerability in action, follow the instructions at:
    https://github.com/richardhansen/clonepwn

 contrib/completion/git-prompt.sh | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 7b732d2..bd7ff29 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -207,7 +207,18 @@ __git_ps1_show_upstream ()
 			p=" u+${count#*	}-${count%	*}" ;;
 		esac
 		if [[ -n "$count" && -n "$name" ]]; then
-			p="$p $(git rev-parse --abbrev-ref "$upstream" 2>/dev/null)"
+			__git_ps1_upstream_name=$(git rev-parse \
+				--abbrev-ref "$upstream" 2>/dev/null)
+			if [ $pcmode = yes ]; then
+				# see the comments around the
+				# __git_ps1_branch_name variable below
+				p="$p \${__git_ps1_upstream_name}"
+			else
+				p="$p ${__git_ps1_upstream_name}"
+				# not needed anymore; keep user's
+				# environment clean
+				unset __git_ps1_upstream_name
+			fi
 		fi
 	fi
 
@@ -438,8 +449,27 @@ __git_ps1 ()
 		__git_ps1_colorize_gitstring
 	fi
 
+	b=${b##refs/heads/}
+	if [ $pcmode = yes ]; then
+		# In pcmode (and only pcmode) the contents of
+		# $gitstring are subject to expansion by the shell.
+		# Avoid putting the raw ref name in the prompt to
+		# protect the user from arbitrary code execution via
+		# specially crafted ref names (e.g., a ref named
+		# '$(IFS=_;cmd=sudo_rm_-rf_/;$cmd)' would execute
+		# 'sudo rm -rf /' when the prompt is drawn).  Instead,
+		# put the ref name in a new global variable (in the
+		# __git_ps1_* namespace to avoid colliding with the
+		# user's environment) and reference that variable from
+		# PS1.
+		__git_ps1_branch_name=$b
+		# note that the $ is escaped -- the variable will be
+		# expanded later (when it's time to draw the prompt)
+		b="\${__git_ps1_branch_name}"
+	fi
+
 	local f="$w$i$s$u"
-	local gitstring="$c${b##refs/heads/}${f:+$z$f}$r$p"
+	local gitstring="$c$b${f:+$z$f}$r$p"
 
 	if [ $pcmode = yes ]; then
 		if [ "${__git_printf_supports_v-}" != yes ]; then
-- 
1.9.2
