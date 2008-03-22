From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH 2/3] Change rebase with preserver merges to pick up the right new HEAD
Date: Sat, 22 Mar 2008 22:44:25 +0100
Message-ID: <1206222266-29179-2-git-send-email-joerg@alea.gnuu.de>
References: <1206222266-29179-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: B.Steinbrink@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 23:00:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdBlS-0000JT-EP
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 23:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754317AbYCVV7v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Mar 2008 17:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754809AbYCVV7u
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 17:59:50 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1314 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753984AbYCVV7o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 17:59:44 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 06DDC488034; Sat, 22 Mar 2008 22:59:42 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JdBVu-0003Po-0P; Sat, 22 Mar 2008 22:44:34 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JdBVr-0007b1-JE; Sat, 22 Mar 2008 22:44:27 +0100
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1206222266-29179-1-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77856>

The assumtion that the new HEAD is the rewritten old head is wrong. The
new HEAD is the (maybe rewritten) last commit in the list.

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 git-rebase--interactive.sh |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 8aa7371..dec18a3 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -20,6 +20,7 @@ require_work_tree
 DOTEST=3D"$GIT_DIR/.dotest-merge"
 TODO=3D"$DOTEST"/git-rebase-todo
 DONE=3D"$DOTEST"/done
+LAST_SHA1=3D"$DOTEST"/last_sha1
 MSG=3D"$DOTEST"/message
 SQUASH_MSG=3D"$DOTEST"/message-squash
 REWRITTEN=3D"$DOTEST"/rewritten
@@ -251,6 +252,7 @@ do_next () {
 	pick|p)
 		comment_for_reflog pick
=20
+		echo $sha1 > "$LAST_SHA1"
 		mark_action_done
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
@@ -258,6 +260,7 @@ do_next () {
 	edit|e)
 		comment_for_reflog edit
=20
+		echo $sha1 > "$LAST_SHA1"
 		mark_action_done
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
@@ -280,6 +283,7 @@ do_next () {
 		has_action "$DONE" ||
 			die "Cannot 'squash' without a previous commit"
=20
+		echo $sha1 > "$LAST_SHA1"
 		mark_action_done
 		make_squash_message $sha1 > "$MSG"
 		case "$(peek_next_command)" in
@@ -333,11 +337,12 @@ do_next () {
 		test -f "$DOTEST"/current-commit &&
 			current_commit=3D$(cat "$DOTEST"/current-commit) &&
 			git rev-parse HEAD > "$REWRITTEN"/$current_commit
-		if test -f "$REWRITTEN"/$OLDHEAD
+		last_sha1=3D$(git rev-parse $(cat "$LAST_SHA1"))
+		if test -f "$REWRITTEN"/$last_sha1
 		then
-			NEWHEAD=3D$(cat "$REWRITTEN"/$OLDHEAD)
+			NEWHEAD=3D$(cat "$REWRITTEN"/$last_sha1)
 		else
-			NEWHEAD=3D$OLDHEAD
+			NEWHEAD=3D$last_sha1
 		fi
 	else
 		NEWHEAD=3D$(git rev-parse HEAD)
--=20
1.5.4.4
