From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/18] rebase -i: Introduce a constant AMEND
Date: Thu, 14 Jan 2010 06:54:47 +0100
Message-ID: <1c21ffc3b11bbba91822af52950056da8b6eff9a.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 06:56:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVIgd-0002Vo-8n
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755639Ab0ANFzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755301Ab0ANFz3
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:55:29 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58611 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755527Ab0ANFzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:55:25 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (p4FC1EBF4.dip.t-dialin.net [79.193.235.244])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0E5t4bN001912;
	Thu, 14 Jan 2010 06:55:20 +0100
X-Mailer: git-send-email 1.6.6
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136937>

Add a constant AMEND holding the filename of the $DOTEST/amend file,
and document how this temporary file is used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-rebase--interactive.sh |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6fcc00e..2c7f3ec 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -81,6 +81,14 @@ DROPPED="$DOTEST"/dropped
 # being rebased.
 AUTHOR_SCRIPT="$DOTEST"/author-script
 
+# When an "edit" rebase command is being processed, the SHA1 of the
+# commit to be edited is recorded in this file.  When "git rebase
+# --continue" is executed, if there are any staged changes then they
+# will be amended to the HEAD commit, but only provided the HEAD
+# commit is still the commit to be edited.  When any other rebase
+# command is processed, this file is deleted.
+AMEND="$DOTEST"/amend
+
 PRESERVE_MERGES=
 STRATEGY=
 ONTO=
@@ -383,7 +391,7 @@ peek_next_command () {
 }
 
 do_next () {
-	rm -f "$MSG" "$AUTHOR_SCRIPT" "$DOTEST"/amend || exit
+	rm -f "$MSG" "$AUTHOR_SCRIPT" "$AMEND" || exit
 	read command sha1 rest < "$TODO"
 	case "$command" in
 	'#'*|''|noop)
@@ -411,7 +419,7 @@ do_next () {
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
 		make_patch $sha1
-		git rev-parse --verify HEAD > "$DOTEST"/amend
+		git rev-parse --verify HEAD > "$AMEND"
 		warn "Stopped at $sha1... $rest"
 		warn "You can amend the commit now, with"
 		warn
@@ -639,10 +647,10 @@ do
 			. "$AUTHOR_SCRIPT" ||
 				die "Cannot find the author identity"
 			amend=
-			if test -f "$DOTEST"/amend
+			if test -f "$AMEND"
 			then
 				amend=$(git rev-parse --verify HEAD)
-				test "$amend" = $(cat "$DOTEST"/amend) ||
+				test "$amend" = $(cat "$AMEND") ||
 				die "\
 You have uncommitted changes in your working tree. Please, commit them
 first and then run 'git rebase --continue' again."
-- 
1.6.6
