From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] bash: offer to show (un)staged changes
Date: Sun,  1 Feb 2009 23:13:43 +0100
Message-ID: <1233526423-30694-1-git-send-email-trast@student.ethz.ch>
References: <1232401089-27512-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 01 23:15:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTkbL-00010k-Af
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 23:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbZBAWOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 17:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752323AbZBAWOJ
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 17:14:09 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:25130 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453AbZBAWOI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 17:14:08 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 1 Feb 2009 23:14:06 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 1 Feb 2009 23:14:06 +0100
X-Mailer: git-send-email 1.6.1.2.495.g43b51
In-Reply-To: <1232401089-27512-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 01 Feb 2009 22:14:06.0811 (UTC) FILETIME=[66138AB0:01C984BA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108012>

Add a bit of code to __git_ps1 that lets it append '*' to the branch
name if there are any unstaged changes, and '+' if there are any
staged changes.

Since this is a rather expensive operation and will force a lot of
data into the cache whenever you first enter a repository, you have to
enable it manually by setting bash.showDirtyState to a true value.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This got no replies... was there anything wrong with v2?


 contrib/completion/git-completion.bash |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f8b845a..7864ca7 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -34,6 +34,10 @@
 #       are currently in a git repository.  The %s token will be
 #       the name of the current branch.
 #
+#	In addition, if you set bash.showDirtyState to a true value,
+#	unstaged (*) and staged (+) changes will be shown next to the
+#	branch name.
+#
 # To submit patches:
 #
 #    *) Read Documentation/SubmittingPatches
@@ -116,10 +120,24 @@ __git_ps1 ()
 			fi
 		fi
 
+		local w
+		local i
+
+		if test "$(git config --bool bash.showDirtyState)" = "true"; then
+			git diff --no-ext-diff --ignore-submodules \
+				--quiet --exit-code || w="*"
+			if git rev-parse --quiet --verify HEAD >/dev/null; then
+				git diff-index --cached --quiet \
+					--ignore-submodules HEAD -- || i="+"
+			else
+				i="#"
+			fi
+		fi
+
 		if [ -n "${1-}" ]; then
-			printf "$1" "${b##refs/heads/}$r"
+			printf "$1" "${b##refs/heads/}$w$i$r"
 		else
-			printf " (%s)" "${b##refs/heads/}$r"
+			printf " (%s)" "${b##refs/heads/}$w$i$r"
 		fi
 	fi
 }
-- 
tg: (7bbd8d6..) t/ps1-dirty-state (depends on: origin/master)
