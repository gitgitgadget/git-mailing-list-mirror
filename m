From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 2/2] bash completion: Support "divergence from upstream" warnings in __git_ps1
Date: Sat, 12 Jun 2010 11:59:11 +0200
Message-ID: <93842467ca22405712cab23a9b3920c106df0f17.1276336602.git.trast@student.ethz.ch>
References: <cover.1276336602.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Shawn O. Pearce" <spearce@spearce.org>, <git@vger.kernel.org>,
	John Tapsell <johnflux@gmail.com>,
	Steven Michalske <smichalske@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Andrew Sayers <andrew-git@pileofstuff.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Sat Jun 12 11:59:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONNVE-0006mV-Vh
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 11:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602Ab0FLJ7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 05:59:39 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:30849 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753737Ab0FLJ7g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 05:59:36 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 12 Jun
 2010 11:59:35 +0200
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 12 Jun
 2010 11:59:12 +0200
X-Mailer: git-send-email 1.7.1.561.g94582
In-Reply-To: <cover.1276336602.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148999>

From: Andrew Sayers <andrew-git@pileofstuff.org>

Add a notification in the command prompt specifying whether you're
ahead of or behind your upstream.  This is especially helpful in small
teams that (forget to) push to each other very frequently.

Support git-svn upstream detection as a special case, as migrators
from centralised version control systems are especially likely to
forget to push.

Also provide ways for the user to specify a custom upstream, or code
that figures out the upstream.

Support for other types of upstream than SVN should be easy to add if
anyone is so inclined.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 contrib/completion/git-completion.bash |   89 +++++++++++++++++++++++++++++++-
 1 files changed, 88 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 57245a8..a6cb435 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -42,6 +42,17 @@
 #       set GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're
 #       untracked files, then a '%' will be shown next to the branch name.
 #
+#       If you would like to see the difference between HEAD and its upstream,
+#       set GIT_PS1_SHOWUPSTREAM to one of the following:
+#           git          use @{upstream}
+#           svn          attempt to DWIM svn upstream for normal and --stdlayout
+#           ref <ref>    unconditionally use <ref>
+#           eval <code>  evaluate <code> which should print the commit to use
+#       Any other value DWIMs either svn or git, preferring svn if configured.
+#
+#       The difference will be shown as, e.g., "u+7-5" meaning that you are 7
+#       commits ahead of and 5 commits behind the upstream.
+#
 # To submit patches:
 #
 #    *) Read Documentation/SubmittingPatches
@@ -78,6 +89,77 @@ __gitdir ()
 	fi
 }
 
+__git_ps1_divergence_from_upstream ()
+{
+	local cfg
+	if cfg="$(git config --get bash.showUpstream)"
+	then
+		GIT_PS1_SHOWUPSTREAM="$cfg"
+	fi
+	if [ -n "${GIT_PS1_SHOWUPSTREAM}" ]; then
+		local upstream count
+		case "${GIT_PS1_SHOWUPSTREAM}" in
+		svn|git|"ref "*|"eval "*)
+			;;
+		*)
+			# try to dwim the type
+			if git config --get svn-remote.svn.url >/dev/null; then
+				GIT_PS1_SHOWUPSTREAM=svn
+			else
+				GIT_PS1_SHOWUPSTREAM=git
+			fi
+			;;
+		esac
+		case "${GIT_PS1_SHOWUPSTREAM}" in
+		git)
+			upstream="@{upstream}"
+			;;
+		svn)
+			local url
+			# git-svn upstream checking: if it has a
+			# remotes/git-svn, that is probably the upstream.
+			# Otherwise try to figure out the branch for
+			# --stdlayout repos.
+			if ! upstream="$(git rev-parse remotes/git-svn 2>/dev/null)"; then
+				url="$(git config --get svn-remote.svn.url)"
+				upstream=( $(git log --first-parent -1 \
+						 --grep="^git-svn-id: $url") )
+				if [ -n "$upstream" ]; then
+					upstream=${upstream[ ${#upstream[@]} - 2 ]}
+					upstream=${upstream%@*}
+					upstream=${upstream#*$url/}
+				fi
+			fi
+			;;
+		"eval "*)
+			# custom shell command that determines upstream
+			upstream="$(eval "${GIT_PS1_SHOWUPSTREAM#eval }")"
+			;;
+		"ref "*)
+			upstream="${GIT_PS1_SHOWUPSTREAM#ref }"
+			;;
+		esac
+
+		count=$(git rev-list --count --left-right \
+				"$upstream"...HEAD 2>/dev/null)
+		case "$count" in
+		"0	0"|"")
+			# empty = no upstream or no --count
+			;;
+		"0	"*)
+			echo "+${count#0	}"
+			;;
+		*"	0")
+			echo "-${count%	0}"
+			;;
+		*)
+			echo "+${count#*	}-${count%	*}"
+			;;
+		esac
+	fi
+}
+
+
 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
 # returns text to add to bash PS1 prompt (includes branch name)
 __git_ps1 ()
@@ -132,6 +214,7 @@ __git_ps1 ()
 		local s
 		local u
 		local c
+		local p
 
 		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
 			if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
@@ -159,10 +242,14 @@ __git_ps1 ()
 			      u="%"
 			   fi
 			fi
+
+			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
+				p="$(__git_ps1_divergence_from_upstream)"
+			fi
 		fi
 
 		local f="$w$i$s$u"
-		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r"
+		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r${p:+ u$p}"
 	fi
 }
 
-- 
1.7.1.561.g94582
