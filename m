From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/18] rebase -i: Document how temporary files are used
Date: Thu, 14 Jan 2010 06:54:45 +0100
Message-ID: <ec177b9d2b2354c446793df42525b4f7377bc413.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 06:56:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVIgh-0002Vo-RW
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755794Ab0ANFz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755558Ab0ANFz2
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:55:28 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58603 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755467Ab0ANFzX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:55:23 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (p4FC1EBF4.dip.t-dialin.net [79.193.235.244])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0E5t4bL001912;
	Thu, 14 Jan 2010 06:55:19 +0100
X-Mailer: git-send-email 1.6.6
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136943>

Add documentation, inferred by reverse-engineering, about how
git-rebase--interactive.sh uses many of its temporary files.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-rebase--interactive.sh |   41 ++++++++++++++++++++++++++++++++++-------
 1 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b7e8189..77e5773 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -35,11 +35,45 @@ autosquash         move commits that begin with squash!/fixup! under -i
 require_work_tree
 
 DOTEST="$GIT_DIR/rebase-merge"
+
+# The file containing rebase commands, comments, and empty lines.
+# This file is created by "git rebase -i" then edited by the user.  As
+# the lines are processed, they are removed from the front of this
+# file and written to the tail of $DONE.
 TODO="$DOTEST"/git-rebase-todo
+
+# The rebase command lines that have already been processed.  A line
+# is moved here when it is first handled, before any associated user
+# actions.
 DONE="$DOTEST"/done
+
+# The commit message that is planned to be used for any changes that
+# need to be committed following a user interaction.
 MSG="$DOTEST"/message
+
+# The file into which is accumulated the suggested commit message for
+# squash/fixup commands.  When the first of a series of squash/fixups
+# is seen, the file is created and the commit message from the
+# previous commit and from the first squash/fixup commit are written
+# to it.  The commit message for each subsequent squash/fixup commit
+# is appended to the file as it is processed.
+#
+# The first line of the file is of the form
+#     # This is a combination of $COUNT commits.
+# where $COUNT is the number of commits whose messages have been
+# written to the file so far (including the initial "pick" commit).
+# Each time that a commit message is processed, this line is read and
+# updated.  It is deleted just before the combined commit is made.
 SQUASH_MSG="$DOTEST"/message-squash
+
+# $REWRITTEN is the name of a directory containing files for each
+# commit that is reachable by at least one merge base of $HEAD and
+# $UPSTREAM. They are not necessarily rewritten, but their children
+# might be.  This ensures that commits on merged, but otherwise
+# unrelated side branches are left alone. (Think "X" in the man page's
+# example.)
 REWRITTEN="$DOTEST"/rewritten
+
 DROPPED="$DOTEST"/dropped
 PRESERVE_MERGES=
 STRATEGY=
@@ -738,13 +772,6 @@ first and then run 'git rebase --continue' again."
 		test t = "$VERBOSE" && : > "$DOTEST"/verbose
 		if test t = "$PRESERVE_MERGES"
 		then
-			# $REWRITTEN contains files for each commit that is
-			# reachable by at least one merge base of $HEAD and
-			# $UPSTREAM. They are not necessarily rewritten, but
-			# their children might be.
-			# This ensures that commits on merged, but otherwise
-			# unrelated side branches are left alone. (Think "X"
-			# in the man page's example.)
 			if test -z "$REBASE_ROOT"
 			then
 				mkdir "$REWRITTEN" &&
-- 
1.6.6
