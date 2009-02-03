From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3] bash: offer to show (un)staged changes
Date: Tue,  3 Feb 2009 10:20:54 +0100
Message-ID: <1233652854-29306-1-git-send-email-trast@student.ethz.ch>
References: <20090201222937.GP26880@spearce.org>
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 03 10:22:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUHUA-0003a9-2U
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 10:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbZBCJU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 04:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbZBCJU7
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 04:20:59 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:34649 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976AbZBCJU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 04:20:57 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 3 Feb 2009 10:20:55 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 3 Feb 2009 10:20:55 +0100
X-Mailer: git-send-email 1.6.1.2.513.g04677
In-Reply-To: <20090201222937.GP26880@spearce.org>
X-OriginalArrivalTime: 03 Feb 2009 09:20:55.0273 (UTC) FILETIME=[B7641D90:01C985E0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108169>

Add a bit of code to __git_ps1 that lets it append '*' to the branch
name if there are any unstaged changes, and '+' if there are any
staged changes.

Since this is a rather expensive operation and will force a lot of
data into the cache whenever you first enter a repository, you have to
enable it manually by setting GIT_PS1_SHOWDIRTYSTATE to a nonempty
value.  The configuration variable bash.showDirtyState can then be
used to disable it again for some repositories.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Shawn O. Pearce wrote:
> But I'm a bit worried about the config --bool test in the prompt.
> Its a new fork+exec we weren't doing before.  I wonder if we should
> use a shell variable to consider whether or not this should even
> be executed and try to shortcut out if not.

Ok, why not.  I changed the default of bash.showDirtyState to true
since the user already opts in via GIT_PS1_SHOWDIRTYSTATE.


 contrib/completion/git-completion.bash |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f8b845a..13cae8d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -34,6 +34,12 @@
 #       are currently in a git repository.  The %s token will be
 #       the name of the current branch.
 #
+#	In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty
+#	value, unstaged (*) and staged (+) changes will be shown next
+#	to the branch name.  You can configure this per-repository
+#	with the bash.showDirtyState variable, which defaults to true
+#	once GIT_PS1_SHOWDIRTYSTATE is enabled.
+#
 # To submit patches:
 #
 #    *) Read Documentation/SubmittingPatches
@@ -116,10 +122,26 @@ __git_ps1 ()
 			fi
 		fi
 
+		local w
+		local i
+
+		if test -n "$GIT_PS1_SHOWDIRTYSTATE"; then
+			if test "$(git config --bool bash.showDirtyState)" != "false"; then
+				git diff --no-ext-diff --ignore-submodules \
+					--quiet --exit-code || w="*"
+				if git rev-parse --quiet --verify HEAD >/dev/null; then
+					git diff-index --cached --quiet \
+						--ignore-submodules HEAD -- || i="+"
+				else
+					i="#"
+				fi
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
