From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH 3/4] completion: Better __git_ps1 support when not in working directory
Date: Wed, 11 Feb 2009 13:54:38 -0500
Message-ID: <1234378479-29304-4-git-send-email-ted@tedpavlic.com>
References: <7v63jgg7st.fsf@gitster.siamese.dyndns.org>
 <1234378479-29304-1-git-send-email-ted@tedpavlic.com>
 <1234378479-29304-2-git-send-email-ted@tedpavlic.com>
 <1234378479-29304-3-git-send-email-ted@tedpavlic.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ted Pavlic <ted@tedpavlic.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Feb 11 19:56:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXKG0-0002sJ-Jc
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756426AbZBKSyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756781AbZBKSyz
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:54:55 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:44566 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754193AbZBKSyv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 13:54:51 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 4BF1F80D808C;
	Wed, 11 Feb 2009 13:48:20 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1lUoXIYiM36H; Wed, 11 Feb 2009 13:48:20 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 2D3D780D808E;
	Wed, 11 Feb 2009 13:48:20 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.390.gba743
In-Reply-To: <1234378479-29304-3-git-send-email-ted@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109502>

If .git/HEAD is not readable, __git_ps1 does nothing.

If --is-in-git-dir, __git_ps1 returns " (GIT_DIR!)" as a cautionary
note. The previous behavior would show the branch name (and would
optionally attempt to determine the dirtyState of the directory, which
was impossible because a "git diff" was used).

If --is-in-work-tree, __git_ps1 returns the branch name. Additionally,
if showDirtyState is on, the dirty state is displayed.

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
Acked-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   37 +++++++++++++++++++------------
 1 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e729944..3d48a65 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -108,7 +108,9 @@ __git_ps1 ()
 			fi
 			if ! b="$(git symbolic-ref HEAD 2>/dev/null)"; then
 				if ! b="$(git describe --exact-match HEAD 2>/dev/null)"; then
-					b="$(cut -c1-7 "$g/HEAD")..."
+					if [ -r "$g/HEAD" ]; then
+						b="$(cut -c1-7 "$g/HEAD")..."
+					fi
 				fi
 			fi
 		fi
@@ -116,23 +118,30 @@ __git_ps1 ()
 		local w
 		local i
 
-		if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
-			if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
-				git diff --no-ext-diff --ignore-submodules \
-					--quiet --exit-code || w="*"
-				if git rev-parse --quiet --verify HEAD >/dev/null; then
-					git diff-index --cached --quiet \
-						--ignore-submodules HEAD -- || i="+"
-				else
-					i="#"
+		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
+			b="GIT_DIR!"
+            r=""
+		elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
+			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
+				if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
+					git diff --no-ext-diff --ignore-submodules \
+						--quiet --exit-code || w="*"
+					if git rev-parse --quiet --verify HEAD >/dev/null; then
+						git diff-index --cached --quiet \
+							--ignore-submodules HEAD -- || i="+"
+					else
+						i="#"
+					fi
 				fi
 			fi
 		fi
 
-		if [ -n "${1-}" ]; then
-			printf "$1" "${b##refs/heads/}$w$i$r"
-		else
-			printf " (%s)" "${b##refs/heads/}$w$i$r"
+		if [ -n "$b" ]; then
+			if [ -n "${1-}" ]; then
+				printf "$1" "${b##refs/heads/}$w$i$r"
+			else
+				printf " (%s)" "${b##refs/heads/}$w$i$r"
+			fi
 		fi
 	fi
 }
-- 
1.6.1.2.390.gba743
