From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/1] Add support for an optional .nextmsg file to git-commit-script
Date: Tue, 14 Jun 2005 21:42:43 +1000
Message-ID: <20050614114243.12267.qmail@blackcubes.dyndns.org>
Cc: jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 14 13:38:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Di9jy-0006iw-TW
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 13:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVFNLmu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 07:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVFNLmu
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 07:42:50 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:27008 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261190AbVFNLmq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2005 07:42:46 -0400
Received: (qmail 12277 invoked by uid 500); 14 Jun 2005 11:42:43 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This change allows a commit message to be prepared prior to git-commit-script being
invoked. During git commit the user is then given an opportunity to edit the
existing message, if any, and must confirm the commit by deleting a sentinel
line from the top of the edit buffer.

If the user does not delete the sentinel line, the commit is aborted and the
text of the message is saved for future editing.

The purpose of this change is to enable undo/redo tools to repopulate a commit
message from a previous commit that has been undone and then allow the user to
make small edits to the previous commit message prior recommitting the change.

If the .nextmsg file does not exist, git-commit-script behaves as before.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 git-commit-script |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/git-commit-script b/git-commit-script
--- a/git-commit-script
+++ b/git-commit-script
@@ -1,5 +1,12 @@
 #!/bin/sh
+SENTINEL="*** delete this line to confirm the commit ***"
 : ${GIT_DIR=.git}
+:> .editmsg
+
+if [ -f .nextmsg ]
+then
+    cat .nextmsg   >>.editmsg
+fi
 PARENTS="HEAD"
 if [ -f $GIT_DIR/MERGE_HEAD ]; then
 	echo "#"
@@ -9,17 +16,31 @@ if [ -f $GIT_DIR/MERGE_HEAD ]; then
 	echo "# and try again"
 	echo "#"
 	PARENTS="HEAD -p MERGE_HEAD"
-fi > .editmsg
+fi >> .editmsg
 git-status-script >> .editmsg
 if [ "$?" != "0" ]
 then
 	cat .editmsg
 	exit 1
 fi
+if [ -f .nextmsg ]
+then
+    echo "$SENTINEL" >>.editmsg
+fi
 ${VISUAL:-${EDITOR:-vi}} .editmsg
-grep -v '^#' < .editmsg | git-stripspace > .cmitmsg
+if [ -f .nextmsg ]
+then
+    egrep -v "(^#|\\$SENTINEL)" < .editmsg > .nextmsg
+    if grep "\\$SENTINEL" < .editmsg >/dev/null
+    then
+	:> .editmsg
+	echo "commit aborted - to confirm, delete the sentinel line in the message"
+    fi
+fi
+egrep -v "^#|$SENTINEL" < .editmsg | git-stripspace > .cmitmsg
 [ -s .cmitmsg ] || exit 1
 tree=$(git-write-tree) || exit 1
 commit=$(cat .cmitmsg | git-commit-tree $tree -p $PARENTS) || exit 1
 echo $commit > $GIT_DIR/HEAD
 rm -f -- $GIT_DIR/MERGE_HEAD
+[ -f .nextmsg ] && rm .nextmsg
------------
