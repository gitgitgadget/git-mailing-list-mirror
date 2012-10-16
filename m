From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: [PATCH 3/3] Change colors to be based on git status -sb in color mode
Date: Tue, 16 Oct 2012 21:34:05 +0200
Message-ID: <20121016193405.GA12073@simaj.xs4all.nl>
References: <7vvceatnn4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@drmicha.warpmail.net, spearce@spearce.org,
	artagnon@gmail.com, schwab@linux-m68k.org, soosthoek@nieuwland.nl,
	junio@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 21:34:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOCuF-00016d-9c
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 21:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035Ab2JPTeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 15:34:10 -0400
Received: from simaj.xs4all.nl ([83.160.71.26]:49736 "EHLO simaj.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755367Ab2JPTeH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 15:34:07 -0400
Received: by simaj.xs4all.nl (Postfix, from userid 1000)
	id AD08A431B4; Tue, 16 Oct 2012 21:34:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vvceatnn4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207876>

Hi

Fixed the mistakes of the last one, and I'm now using the symbolic names "ok_color" and "bad_color".
The test for headless state is now more direct, and I hope it is still correct.

/Simon


this patch is an additional patch to the previous series of two.  It also
corrects the missing S and some minor details. The main point of this
one is changing the used colors to be more close to the color output of "git
status -sb" Mainly, the branchname stays green until it loses a HEAD, in
detached head state it becomes red.
The flags get their own color, either red or green for unstaged/staged and the
remaining flags get a different color or none at all.

Signed-off-by: Simon Oosthoek <s.oosthoek@xs4all.nl>
---
 contrib/completion/git-prompt.sh |   52 +++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 4fb998a..7dce319 100644
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
@@ -325,35 +323,47 @@ __git_ps1 ()
 
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
+				local bad_color=$c_red
+				local ok_color=$c_green
+				local branch_color="$c_clear"
+				local flags_color="$c_lblue"
 				local branchstring="$c${b##refs/heads/}"
-				local branch_color="$c_green"
-				local flags_color="$c_cyan"
 
-				if [ "$w" = "*" ]; then
-					branch_color="$c_red"
-				elif [ -n "$i" ]; then
-					branch_color="$c_yellow"
+				if git symbolic-ref HEAD 2>/dev/null 1>&2
+				then
+					branch_color="$ok_color"
+				else
+					branch_color="$bad_color"
 				fi
 
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
+					PS1="$PS1\[$bad_color\]$w"
+				fi
+				if [ -n "$i" ]; then
+					PS1="$PS1\[$ok_color\]$i"
+				fi
+				if [ -n "$s" ]; then
+					PS1="$PS1\[$flags_color\]$s"
+				fi
+				if [ -n "$u" ]; then
+					PS1="$PS1\[$bad_color\]$u"
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
