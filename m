From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/2] Minor cleanup and bugfixing in git-notes.sh
Date: Fri, 15 May 2009 02:12:12 +0200
Message-ID: <200905150212.12979.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 15 02:12:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4l2I-0003Xg-Lo
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 02:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754997AbZEOAMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 20:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755548AbZEOAMO
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 20:12:14 -0400
Received: from mx.getmail.no ([84.208.15.66]:54670 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755359AbZEOAMN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 20:12:13 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJN00E6ASKDLY40@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 15 May 2009 02:12:13 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJN00G9WSKDO970@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 15 May 2009 02:12:13 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.5.14.235538
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119239>

The following changes are made:
- Rename $MESSAGE to $MSG_FILE which better describes its purpose
- Make sure not only $MSG_FILE is removed upopn completion, but also
  $GIT_INDEX_FILE
- Remove stray "GIT_NOTES_REF=" in front of "git log ..." command

Signed-off-by: Johan Herland <johan@herland.net>
---
 git-notes.sh |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/git-notes.sh b/git-notes.sh
index 6ec33c9..7c3b8b9 100755
--- a/git-notes.sh
+++ b/git-notes.sh
@@ -20,15 +20,16 @@ edit)
 		die "Refusing to edit notes in $GIT_NOTES_REF (outside of refs/notes/)"
 	fi
 
-	MESSAGE="$GIT_DIR"/new-notes-$COMMIT
+	MSG_FILE="$GIT_DIR/new-notes-$COMMIT"
+	GIT_INDEX_FILE="MSG_FILE.idx"
+	export GIT_INDEX_FILE
+
 	trap '
-		test -f "$MESSAGE" && rm "$MESSAGE"
+		test -f "$MSG_FILE" && rm "$MSG_FILE"
+		test -f "$GIT_INDEX_FILE" && rm "$GIT_INDEX_FILE"
 	' 0
 
-	GIT_NOTES_REF= git log -1 $COMMIT | sed "s/^/#/" > "$MESSAGE"
-
-	GIT_INDEX_FILE="$MESSAGE".idx
-	export GIT_INDEX_FILE
+	git log -1 $COMMIT | sed "s/^/#/" > "$MSG_FILE"
 
 	CURRENT_HEAD=$(git show-ref "$GIT_NOTES_REF" | cut -f 1 -d ' ')
 	if [ -z "$CURRENT_HEAD" ]; then
@@ -36,16 +37,16 @@ edit)
 	else
 		PARENT="-p $CURRENT_HEAD"
 		git read-tree "$GIT_NOTES_REF" || die "Could not read index"
-		git cat-file blob :$COMMIT >> "$MESSAGE" 2> /dev/null
+		git cat-file blob :$COMMIT >> "$MSG_FILE" 2> /dev/null
 	fi
 
 	core_editor="$(git config core.editor)"
-	${GIT_EDITOR:-${core_editor:-${VISUAL:-${EDITOR:-vi}}}} "$MESSAGE"
+	${GIT_EDITOR:-${core_editor:-${VISUAL:-${EDITOR:-vi}}}} "$MSG_FILE"
 
-	grep -v ^# < "$MESSAGE" | git stripspace > "$MESSAGE".processed
-	mv "$MESSAGE".processed "$MESSAGE"
-	if [ -s "$MESSAGE" ]; then
-		BLOB=$(git hash-object -w "$MESSAGE") ||
+	grep -v ^# < "$MSG_FILE" | git stripspace > "$MSG_FILE".processed
+	mv "$MSG_FILE".processed "$MSG_FILE"
+	if [ -s "$MSG_FILE" ]; then
+		BLOB=$(git hash-object -w "$MSG_FILE") ||
 			die "Could not write into object database"
 		git update-index --add --cacheinfo 0644 $BLOB $COMMIT ||
 			die "Could not write index"
-- 
1.6.3.rc0.1.gf800



