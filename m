From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] bash: offer to show (un)staged changes
Date: Sun, 18 Jan 2009 01:56:24 +0100
Message-ID: <1232240184-10906-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 18 01:57:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOLyt-0000kX-7D
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 01:57:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757501AbZARA4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 19:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757354AbZARA4P
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 19:56:15 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:27061 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757271AbZARA4O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 19:56:14 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 18 Jan 2009 01:56:13 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 18 Jan 2009 01:56:13 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
X-OriginalArrivalTime: 18 Jan 2009 00:56:13.0370 (UTC) FILETIME=[8F5C69A0:01C97907]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106122>

Add a bit of code to __git_ps1 that lets it append '*' to the branch
name if there are any uncommitted changes, and '+' if there are any
staged changes.

Since this is a rather expensive operation and will force a lot of
data into the cache whenever you first enter a repository, you have to
enable it manually by setting GIT_PS1_EXPENSIVE to something nonempty.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I came up with this after sending two incomplete patches on the same
night, and really like it.  Perhaps others might find it useful.

Of course it would be brilliant if there were a way to ask the kernel
if a certain directory is cached, but I couldn't find one, let alone
one accessible from the shell.


 contrib/completion/git-completion.bash |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f8b845a..36ea528 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -34,6 +34,10 @@
 #       are currently in a git repository.  The %s token will be
 #       the name of the current branch.
 #
+#	In addition, if you set GIT_PS1_EXPENSIVE to a nonempty value,
+#	unstaged (*) and staged (+) changes will be shown next to the
+#	branch name.
+#
 # To submit patches:
 #
 #    *) Read Documentation/SubmittingPatches
@@ -116,10 +120,23 @@ __git_ps1 ()
 			fi
 		fi
 
+		local w
+		local i
+
+		if test ! -z "$GIT_PS1_EXPENSIVE"; then
+			git update-index --refresh >/dev/null 2>&1 || w="*"
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
