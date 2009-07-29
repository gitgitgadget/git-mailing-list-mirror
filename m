From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 8/8] t3302-notes-index-expensive: Speed up create_repo()
Date: Wed, 29 Jul 2009 04:25:26 +0200
Message-ID: <1248834326-31488-9-git-send-email-johan@herland.net>
References: <1248834326-31488-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org, Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 29 04:28:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVytv-0008BB-JQ
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 04:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756225AbZG2C2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 22:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756214AbZG2C2P
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 22:28:15 -0400
Received: from mx.getmail.no ([84.208.15.66]:43062 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756181AbZG2C2O (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2009 22:28:14 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNI00KGEUV2KY60@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Jul 2009 04:28:14 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNI004NXUQPO310@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Jul 2009 04:28:13 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.7.29.21516
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <1248834326-31488-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124301>

Creating repos with 10/100/1000/10000 commits and notes takes a lot of time.
However, using git-fast-import to do the job is a lot more efficient than
using plumbing commands to do the same.

This patch decreases the overall run-time of this test on my machine from
~3 to ~1 minutes.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3302-notes-index-expensive.sh |   74 ++++++++++++++++++++++++--------------
 1 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-expensive.sh
index 0ef3e95..ee84fc4 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -16,30 +16,50 @@ test -z "$GIT_NOTES_TIMING_TESTS" && {
 create_repo () {
 	number_of_commits=$1
 	nr=0
-	parent=
 	test -d .git || {
 	git init &&
-	tree=$(git write-tree) &&
-	while [ $nr -lt $number_of_commits ]; do
-		test_tick &&
-		commit=$(echo $nr | git commit-tree $tree $parent) ||
-			return
-		parent="-p $commit"
-		nr=$(($nr+1))
-	done &&
-	git update-ref refs/heads/master $commit &&
-	{
-		GIT_INDEX_FILE=.git/temp; export GIT_INDEX_FILE;
-		git rev-list HEAD | cat -n | sed "s/^[ 	][ 	]*/ /g" |
-		while read nr sha1; do
-			blob=$(echo note $nr | git hash-object -w --stdin) &&
-			echo $sha1 | sed "s/^/0644 $blob 0	/"
-		done | git update-index --index-info &&
-		tree=$(git write-tree) &&
+	(
+		while [ $nr -lt $number_of_commits ]; do
+			nr=$(($nr+1))
+			mark=$(($nr+$nr))
+			notemark=$(($mark+1))
+			test_tick &&
+			cat <<INPUT_END &&
+commit refs/heads/master
+mark :$mark
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+commit #$nr
+COMMIT
+
+M 644 inline file
+data <<EOF
+file in commit #$nr
+EOF
+
+blob
+mark :$notemark
+data <<EOF
+note for commit #$nr
+EOF
+
+INPUT_END
+
+			echo "N :$notemark :$mark" >> note_commit
+		done &&
 		test_tick &&
-		commit=$(echo notes | git commit-tree $tree) &&
-		git update-ref refs/notes/commits $commit
-	} &&
+		cat <<INPUT_END &&
+commit refs/notes/commits
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+notes
+COMMIT
+
+INPUT_END
+
+		cat note_commit
+	) |
+	git fast-import --quiet &&
 	git config core.notesRef refs/notes/commits
 	}
 }
@@ -48,13 +68,13 @@ test_notes () {
 	count=$1 &&
 	git config core.notesRef refs/notes/commits &&
 	git log | grep "^    " > output &&
-	i=1 &&
-	while [ $i -le $count ]; do
-		echo "    $(($count-$i))" &&
-		echo "    note $i" &&
-		i=$(($i+1));
+	i=$count &&
+	while [ $i -gt 0 ]; do
+		echo "    commit #$i" &&
+		echo "    note for commit #$i" &&
+		i=$(($i-1));
 	done > expect &&
-	git diff expect output
+	test_cmp expect output
 }
 
 cat > time_notes << \EOF
-- 
1.6.4.rc3.138.ga6b98.dirty
