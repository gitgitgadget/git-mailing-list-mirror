From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: [PATCH 2/2] show color hints based on state of the git tree
Date: Fri, 5 Oct 2012 23:10:30 +0200
Message-ID: <20121005211030.GA5414@simaj.xs4all.nl>
References: <7v8vbo7hmd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@drmicha.warpmail.net, spearce@spearce.org,
	artagnon@gmail.com, schwab@linux-m68k.org, soosthoek@nieuwland.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 23:15:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKFFH-0001Bt-A5
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 23:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932731Ab2JEVPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 17:15:32 -0400
Received: from simaj.xs4all.nl ([83.160.71.26]:57209 "EHLO blacky"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932275Ab2JEVPb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 17:15:31 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Oct 2012 17:15:31 EDT
Received: by blacky (Postfix, from userid 1000)
	id 300A441038; Fri,  5 Oct 2012 23:10:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v8vbo7hmd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207120>

By setting GIT_PS1_SHOW_COLORHINTS when using __git_ps1
as PROMPT_COMMAND, you will get color hints in addition to
a different character (*+% etc.)

Signed-off-by: Simon Oosthoek <soosthoek@nieuwland.nl>
---
 contrib/completion/git-prompt.sh |   42 +++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index c50c94a..51285d7 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -53,6 +53,12 @@
 # find one, or @{upstream} otherwise.  Once you have set
 # GIT_PS1_SHOWUPSTREAM, you can override it on a per-repository basis by
 # setting the bash.showUpstream config variable.
+#
+# If you would like a colored hint about the current dirty state, set
+# GIT_PS1_SHOWCOLORHINTS to a nonempty value. When tracked files are
+# modified, the branch name turns red, when all modifications are staged
+# the branch name turns yellow and when all changes are checked in, the
+# color changes to green. The colors are currently hardcoded in the function.
 
 # __gitdir accepts 0 or 1 arguments (i.e., location)
 # returns location of .git repo
@@ -201,11 +207,12 @@ __git_ps1_show_upstream ()
 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
 # when called from PS1 using command substitution
 # in this mode it returns text to add to bash PS1 prompt (includes branch name) or
-# __git_ps1 accepts 0 or 2 arguments when called from PROMPT_COMMAND
+# __git_ps1 accepts 0 or 2 arguments when called from PROMPT_COMMAND (pc)
 # in that case it _sets_ PS1. The arguments are parts of a PS1 string.
 # when both arguments are given, the first is prepended and the second appended
 # to the state string when assigned to PS1, otherwise default start/end strings
 # are used.
+# In pcmode you can request colored hints using GIT_PS1_SHOWCOLORHINTS=true
 __git_ps1 ()
 {
 	local pcmode=yes
@@ -320,8 +327,37 @@ __git_ps1 ()
 
 		local f="$w$i$s$u"
 		if [ $pcmode = yes ]; then
-			PS1="$ps1pc_start($c${b##refs/heads/}${f:+ $f}$r$p)$ps1pc_end"
-		elif [ $pcmode = no ]; then
+			PS1="$ps1pc_start("
+			if [ -n "${GIT_PS1_SHOWCOLORHINT-}" ]; then
+				local c_red='\e[31m'
+				local c_green='\e[32m'
+				local c_yellow='\e[33m'
+				local c_lblue='\e[1;34m'
+				local c_purple='\e[35m'
+				local c_cyan='\e[36m'
+				local c_clear='\e[0m'
+				local branchstring="$c${b##refs/heads/}"
+				local branch_color="$c_green"
+				local flags_color="$c_cyan"
+
+				if [ "$w" = "*" ]; then
+					branch_color="$c_red"
+				elif [ -n "$i" ]; then
+					branch_color="$c_yellow"
+				fi
+
+				# Setting PS1 directly with \[ and \] around colors
+				# is necessary to prevent wrapping issues!
+				PS1="$PS1\[$branch_color\]$branchstring\[$c_clear\]"
+				if [ -n "$f" ]; then
+					PS1="$PS1 \[$flags_color\]$f\[$c_clear\]"
+				fi
+			else
+				PS1="$PS1$c${b##refs/heads/}${f:+ $f}$r$p"
+			fi
+			PS1="$PS1)$ps1pc_end"
+		else
+			# NO color option unless in PROMPT_COMMAND mode
 			printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
 		fi
 	fi
-- 
1.7.9.5
