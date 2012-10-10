From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: [PATCH 2/2] show color hints based on state of the git tree
Date: Wed, 10 Oct 2012 21:38:14 +0200
Message-ID: <20121010193814.GA7186@simaj.xs4all.nl>
References: <7v7gr0k6jv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@drmicha.warpmail.net, spearce@spearce.org,
	artagnon@gmail.com, schwab@linux-m68k.org, soosthoek@nieuwland.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 21:38:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM26s-0005rH-4n
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 21:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756208Ab2JJTiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 15:38:16 -0400
Received: from simaj.xs4all.nl ([83.160.71.26]:45662 "EHLO simaj.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977Ab2JJTiP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 15:38:15 -0400
Received: by simaj.xs4all.nl (Postfix, from userid 1000)
	id 6FB6C411E9; Wed, 10 Oct 2012 21:38:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v7gr0k6jv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207432>

By setting GIT_PS1_SHOW_COLORHINTS when using __git_ps1
as PROMPT_COMMAND, you will get color hints in addition to
a different character (*+% etc.) to indicate the state of
the tree.

Signed-off-by: Simon Oosthoek <s.oosthoek@xs4all.nl>
---
 contrib/completion/git-prompt.sh |   36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 4fbc1e6..a693565 100644
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
@@ -206,6 +212,7 @@ __git_ps1_show_upstream ()
 # in that case it _sets_ PS1. The arguments are parts of a PS1 string.
 # when both arguments are given, the first is prepended and the second appended
 # to the state string when assigned to PS1.
+# In this mode you can request colored hints using GIT_PS1_SHOWCOLORHINTS=true
 __git_ps1 ()
 {
 	local pcmode=no
@@ -319,9 +326,36 @@ __git_ps1 ()
 		local f="$w$i$s$u"
 		if [ $pcmode = yes ]; then
 			PS1="$ps1pc_start("
-			PS1="$PS1$c${b##refs/heads/}${f:+ $f}$r$p"
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
 			PS1="$PS1)$ps1pc_end"
 		else
+			# NO color option unless in PROMPT_COMMAND mode
 			printf -- "$printf_format" "$c${b##refs/heads/}${f:+ $f}$r$p"
 		fi
 	fi
-- 
1.7.9.5
