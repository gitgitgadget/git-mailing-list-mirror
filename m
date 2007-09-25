From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 5/5] rebase -i: avoid exporting GIT_AUTHOR_* variables
Date: Tue, 25 Sep 2007 16:43:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709251643310.28395@racer.site>
References: <Pine.LNX.4.64.0709251640360.28395@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 25 17:45:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaCbC-0002yY-Sk
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 17:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755826AbXIYPot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 11:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755845AbXIYPot
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 11:44:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:37493 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755763AbXIYPos (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 11:44:48 -0400
Received: (qmail invoked by alias); 25 Sep 2007 15:44:46 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp023) with SMTP; 25 Sep 2007 17:44:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lys4dJbRlwl9ZHIMTrlg0dmqKPzEdrFeTATdM/S
	6XTyLND6vfFuL0
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709251640360.28395@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59142>


It is somewhat unsafe to export the GIT_AUTHOR_* variables, since a later
call to git-commit or git-merge could pick them up inadvertently.

So avoid the export, using a recipe provided by Johannes Sixt.

Incidentally, this fixes authorship of merges with "rebase --preserve -i".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 445a299..e3e89dd 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -174,7 +174,11 @@ pick_one_preserving_merges () {
 			eval "$author_script"
 			msg="$(git cat-file commit $sha1 | sed -e '1,/^$/d')"
 			# NEEDSWORK: give rerere a chance
-			if ! output git merge $STRATEGY -m "$msg" $new_parents
+			if ! GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
+				GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
+				GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
+				output git merge $STRATEGY -m "$msg" \
+					$new_parents
 			then
 				printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
 				die Error redoing merge $sha1
@@ -281,7 +285,9 @@ do_next () {
 		f)
 			# This is like --amend, but with a different message
 			eval "$author_script"
-			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
+			GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
+			GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
+			GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
 			$USE_OUTPUT git commit -F "$MSG" $EDIT_COMMIT
 			;;
 		t)
-- 
1.5.3.2.1057.gf4dc1
