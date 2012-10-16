From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: [PATCH 3/3] Change colors to be based on git status -sb in color mode
Date: Tue, 16 Oct 2012 07:32:57 +0200
Message-ID: <20121016053257.GA8366@simaj.xs4all.nl>
References: <7vlif7wqqb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@drmicha.warpmail.net, spearce@spearce.org,
	artagnon@gmail.com, schwab@linux-m68k.org, soosthoek@nieuwland.nl,
	junio@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 07:33:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNzmD-0007Ym-EU
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 07:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350Ab2JPFdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 01:33:01 -0400
Received: from simaj.xs4all.nl ([83.160.71.26]:48641 "EHLO simaj.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823Ab2JPFdA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 01:33:00 -0400
Received: by simaj.xs4all.nl (Postfix, from userid 1000)
	id DE44F40C6E; Tue, 16 Oct 2012 07:32:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vlif7wqqb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207802>

Hi

this patch is an additional patch to the previous series of two.  It also
corrects the missing S and some minor details. The main point of this
one is changing the used colors to be more close to the color output of "git
status -sb" Mainly, the branchname stays green until it loses a HEAD, in
detached head state it becomes red.
The flags get their own color, either red or green for unstaged/staged and the
remaining flags get a different color or none at all.

Cheers

Simon

The color in the prompt now follows the colors used by
git itself when showing colors. The branch name is only
colored red if the tree has a detached HEAD.

Signed-off-by: Simon Oosthoek <s.oosthoek@xs4all.nl>
---
 contrib/completion/git-prompt.sh |   52 ++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 4fb998a..ff69bbc 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -55,11 +55,9 @@
 # setting the bash.showUpstream config variable.
 #
 # If you would like a colored hint about the current dirty state, set
-# GIT_PS1_SHOWCOLORHINTS to a nonempty value. When tracked files are
-# modified, the branch name turns red, when all modifications are staged
-# the branch name turns yellow and when all changes are checked in, the
-# color changes to green. The colors are currently hardcoded in the function.
-
+# GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on 
+# the colored output of "git status -sb".
+#
 # __gitdir accepts 0 or 1 arguments (i.e., location)
 # returns location of .git repo
 __gitdir ()
@@ -325,35 +323,45 @@ __git_ps1 ()
 
 		local f="$w$i$s$u"
 		if [ $pcmode = yes ]; then
-			PS1="$ps1pc_start("
-			if [ -n "${GIT_PS1_SHOWCOLORHINT-}" ]; then
+			if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
 				local c_red='\e[31m'
 				local c_green='\e[32m'
-				local c_yellow='\e[33m'
 				local c_lblue='\e[1;34m'
-				local c_purple='\e[35m'
-				local c_cyan='\e[36m'
 				local c_clear='\e[0m'
 				local branchstring="$c${b##refs/heads/}"
-				local branch_color="$c_green"
-				local flags_color="$c_cyan"
+				local branch_color="$c_clear"
+				local flags_color="$c_lblue"
 
-				if [ "$w" = "*" ]; then
-					branch_color="$c_red"
-				elif [ -n "$i" ]; then
-					branch_color="$c_yellow"
-				fi
+				case "$b" in 
+					\(*\))	branch_color="$c_red"
+					;;
+					*)	local branch_color="$c_green"
+					;;
+				esac
 
 				# Setting PS1 directly with \[ and \] around colors
 				# is necessary to prevent wrapping issues!
-				PS1="$PS1\[$branch_color\]$branchstring\[$c_clear\]"
-				if [ -n "$f" ]; then
-					PS1="$PS1 \[$flags_color\]$f\[$c_clear\]"
+				PS1="$ps1pc_start (\[$branch_color\]$branchstring\[$c_clear\]"
+
+				if [ -n "$w$i$s$u$r$p" ]; then
+					PS1="$PS1 "
+				fi
+				if [ "$w" = "*" ]; then
+					PS1="$PS1\[$c_red\]$w"
+				fi
+				if [ -n "$i" ]; then
+					PS1="$PS1\[$c_green\]$i"
+				fi
+				if [ -n "$s" ]; then
+					PS1="$PS1\[$flags_color\]$s"
+				fi
+				if [ -n "$u" ]; then
+					PS1="$PS1\[$c_red\]$u"
 				fi
+				PS1="$PS1\[$c_clear\]$r$p)$ps1pc_end"
 			else
-				PS1="$PS1$c${b##refs/heads/}${f:+ $f}$r$p"
+				PS1="$ps1pc_start ($c${b##refs/heads/}${f:+ $f}$r$p)$ps1pc_end"
 			fi
-			PS1="$PS1)$ps1pc_end"
 		else
 			# NO color option unless in PROMPT_COMMAND mode
 			printf -- "$printf_format" "$c${b##refs/heads/}${f:+ $f}$r$p"
-- 
1.7.9.5
