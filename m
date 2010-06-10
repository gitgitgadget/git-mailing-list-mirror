From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/2] bash completion: Support "divergence from upstream" warnings in __git_ps1
Date: Thu, 10 Jun 2010 13:47:24 +0200
Message-ID: <a798e1b7f5ce3872a794829555c7295e588e2c61.1276169807.git.trast@student.ethz.ch>
References: <cover.1276169807.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Shawn O. Pearce" <spearce@spearce.org>, <git@vger.kernel.org>,
	John Tapsell <johnflux@gmail.com>,
	Steven Michalske <smichalske@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Andrew Sayers <andrew-git@pileofstuff.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Thu Jun 10 13:47:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMgEm-0005uh-0F
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 13:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758804Ab0FJLrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 07:47:52 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:30564 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758786Ab0FJLrs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 07:47:48 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 13:47:47 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 13:47:26 +0200
X-Mailer: git-send-email 1.7.1.553.ga798e
In-Reply-To: <cover.1276169807.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148858>

From: Andrew Sayers <andrew-git@pileofstuff.org>

Add a notification in the command prompt specifying whether you're
ahead of or behind your upstream.  This is especially helpful in small
teams that (forget to) push to each other very frequently.

Support git-svn upstream detection as a special case, as migraters from
centralised version control systems are especially likely to forget to push.

Support for other types of upstream than SVN should be easy to add if anyone is
so inclined.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 contrib/completion/git-completion.bash |   57 +++++++++++++++++++++++++++++++-
 1 files changed, 56 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index de5e6c1..49253a1 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -42,6 +42,14 @@
 #       set GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're
 #       untracked files, then a '%' will be shown next to the branch name.
 #
+#       If you would like to see the difference bitween HEAD and its
+#       upstream, set GIT_PS1_SHOWUPSTREAM to a nonempty value.  The
+#       difference will be shown as, e.g., "u+7-5" meaning that you
+#       are 7 commits ahead of and 5 commits behind the upstream.  You
+#       can enable git-svn mode by setting GIT_PS1_SHOWUPSTREAM=svn
+#       and set the value per-repository with the bash.showUpstream
+#       variable.
+#
 # To submit patches:
 #
 #    *) Read Documentation/SubmittingPatches
@@ -132,6 +140,7 @@ __git_ps1 ()
 		local s
 		local u
 		local c
+		local p
 
 		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
 			if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
@@ -159,10 +168,56 @@ __git_ps1 ()
 			      u="%"
 			   fi
 			fi
+
+			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
+
+				# Note: 'p' is used as a temporary throughout this block,
+				# before finally being assigned its correct value
+
+				if p="$(git config --get bash.showUpstream)"
+				then
+					GIT_PS1_SHOWUPSTREAM="$p"
+				fi
+
+				local upstream
+
+				if [ "${GIT_PS1_SHOWUPSTREAM-}" = "svn" ]; then
+
+					# git-svn upstream checking
+					p="$( git config --get svn-remote.svn.url )"
+					upstream=( $( git log --first-parent -1 \
+						--grep="^git-svn-id: $p" ) )
+					upstream=${upstream[ ${#upstream[@]} - 2 ]}
+					upstream=${upstream%@*}
+					upstream=${upstream#*$p/}
+
+				else # git upstream checking
+					upstream="@{upstream}"
+				fi
+
+				p=$(git rev-list --count --left-right "$upstream"...HEAD 2>/dev/null)
+				debug_p="$p"
+				case "$p" in
+				"0	0"|"") # empty means no --count support or no upstream
+					p=
+					;;
+				"0	"*)
+					p="+${p#0	}"
+					;;
+				*"	0")
+					p="-${p%	0}"
+					;;
+				*)
+					p="+${p#*	}-${p%	*}"
+					;;
+				esac
+
+			fi
+
 		fi
 
 		local f="$w$i$s$u"
-		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r"
+		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r${p:+ u$p}"
 	fi
 }
 
-- 
1.7.1.553.ge4d5c.dirty
