From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 09/12] Selftests verifying semantics when loading notes trees
 with various fanouts
Date: Thu, 27 Aug 2009 03:43:54 +0200
Message-ID: <1251337437-16947-10-git-send-email-johan@herland.net>
References: <1251337437-16947-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 27 03:45:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgU2t-0004PF-Mh
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 03:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbZH0Bop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 21:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbZH0Bom
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 21:44:42 -0400
Received: from smtp.getmail.no ([84.208.15.66]:52466 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932098AbZH0Boh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Aug 2009 21:44:37 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP0002B3I6FTPA0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 27 Aug 2009 03:44:39 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP000MW0I5F4H50@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 27 Aug 2009 03:44:39 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.27.13316
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1251337437-16947-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127139>

Add selftests verifying:
- that we are able to parse notes trees with various fanout schemes
- that notes trees with conflicting fanout schemes are parsed as expected

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3303-notes-subtrees.sh |  206 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 206 insertions(+), 0 deletions(-)
 create mode 100755 t/t3303-notes-subtrees.sh

diff --git a/t/t3303-notes-subtrees.sh b/t/t3303-notes-subtrees.sh
new file mode 100755
index 0000000..40bb3f4
--- /dev/null
+++ b/t/t3303-notes-subtrees.sh
@@ -0,0 +1,206 @@
+#!/bin/sh
+
+test_description='Test commit notes organized in subtrees'
+
+. ./test-lib.sh
+
+number_of_commits=100
+
+start_note_commit () {
+	test_tick &&
+	cat <<INPUT_END
+commit refs/notes/commits
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+notes
+COMMIT
+
+from refs/notes/commits^0
+deleteall
+INPUT_END
+
+}
+
+verify_notes () {
+	git log | grep "^    " > output &&
+	i=$number_of_commits &&
+	while [ $i -gt 0 ]; do
+		echo "    commit #$i" &&
+		echo "    note for commit #$i" &&
+		i=$(($i-1));
+	done > expect &&
+	test_cmp expect output
+}
+
+test_expect_success 'setup: create $number_of_commits commits' '
+
+	(
+		nr=0 &&
+		while [ $nr -lt $number_of_commits ]; do
+			nr=$(($nr+1)) &&
+			test_tick &&
+			cat <<INPUT_END
+commit refs/heads/master
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
+INPUT_END
+
+		done &&
+		test_tick &&
+		cat <<INPUT_END
+commit refs/notes/commits
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+no notes
+COMMIT
+
+deleteall
+
+INPUT_END
+
+	) |
+	git fast-import --quiet &&
+	git config core.notesRef refs/notes/commits
+'
+
+test_expect_success 'test notes in 2/38-fanout' '
+
+	(
+		start_note_commit &&
+		nr=$number_of_commits &&
+		git rev-list refs/heads/master |
+		while read sha1; do
+			note_path=$(echo "$sha1" | sed "s|^..|&/|")
+			cat <<INPUT_END &&
+M 100644 inline $note_path
+data <<EOF
+note for commit #$nr
+EOF
+
+INPUT_END
+
+			nr=$(($nr-1))
+		done
+	) |
+	git fast-import --quiet
+'
+
+test_expect_success 'verify notes in 2/38-fanout' 'verify_notes'
+
+test_expect_success 'test notes in 4/36-fanout' '
+
+	(
+		start_note_commit &&
+		nr=$number_of_commits &&
+		git rev-list refs/heads/master |
+		while read sha1; do
+			note_path=$(echo "$sha1" | sed "s|^....|&/|")
+			cat <<INPUT_END &&
+M 100644 inline $note_path
+data <<EOF
+note for commit #$nr
+EOF
+
+INPUT_END
+
+			nr=$(($nr-1))
+		done
+	) |
+	git fast-import --quiet
+'
+
+test_expect_success 'verify notes in 4/36-fanout' 'verify_notes'
+
+test_expect_success 'test notes in 4/36-fanout overriding 2/38-fanout' '
+
+	(
+		start_note_commit &&
+		nr=$number_of_commits &&
+		git rev-list refs/heads/master |
+		while read sha1; do
+			ignored_note_path=$(echo "$sha1" | sed "s|^..|&/|")
+			preferred_note_path=$(echo "$sha1" | sed "s|^....|&/|")
+			cat <<INPUT_END &&
+M 100644 inline $ignored_note_path
+data <<EOF
+IGNORED note for commit #$nr
+EOF
+
+M 100644 inline $preferred_note_path
+data <<EOF
+note for commit #$nr
+EOF
+
+INPUT_END
+
+			nr=$(($nr-1))
+		done
+	) |
+	git fast-import --quiet
+'
+
+test_expect_success 'verify notes in 4/36-fanout overriding 2/38-fanout' 'verify_notes'
+
+test_expect_success 'test notes in 2/2/36-fanout' '
+
+	(
+		start_note_commit &&
+		nr=$number_of_commits &&
+		git rev-list refs/heads/master |
+		while read sha1; do
+			note_path=$(echo "$sha1" | sed "s|^\(..\)\(..\)|\1/\2/|")
+			cat <<INPUT_END &&
+M 100644 inline $note_path
+data <<EOF
+note for commit #$nr
+EOF
+
+INPUT_END
+
+			nr=$(($nr-1))
+		done
+	) |
+	git fast-import --quiet
+'
+
+test_expect_success 'verify notes in 2/2/36-fanout' 'verify_notes'
+
+test_expect_success 'test notes in 2/38-fanout overriding 2/2/36-fanout' '
+
+	(
+		start_note_commit &&
+		nr=$number_of_commits &&
+		git rev-list refs/heads/master |
+		while read sha1; do
+			ignored_note_path=$(echo "$sha1" | sed "s|^\(..\)\(..\)|\1/\2/|")
+			preferred_note_path=$(echo "$sha1" | sed "s|^..|&/|")
+			cat <<INPUT_END &&
+M 100644 inline $ignored_note_path
+data <<EOF
+IGNORED note for commit #$nr
+EOF
+
+M 100644 inline $preferred_note_path
+data <<EOF
+note for commit #$nr
+EOF
+
+INPUT_END
+
+			nr=$(($nr-1))
+		done
+	) |
+	git fast-import --quiet
+'
+
+test_expect_success 'verify notes in 2/38-fanout overriding 2/2/36-fanout' 'verify_notes'
+
+test_done
-- 
1.6.4.304.g1365c.dirty
