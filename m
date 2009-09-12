From: Johan Herland <johan@herland.net>
Subject: [PATCHv6 12/14] Selftests verifying semantics when loading notes trees
 with various fanouts
Date: Sat, 12 Sep 2009 18:08:46 +0200
Message-ID: <1252771728-27206-13-git-send-email-johan@herland.net>
References: <200909121752.07523.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Sep 12 18:09:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmVAe-0008SS-QM
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 18:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772AbZILQJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 12:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754782AbZILQJo
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 12:09:44 -0400
Received: from smtp.getmail.no ([84.208.15.66]:39558 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754659AbZILQJe (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 12:09:34 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPV003C18W0QZ70@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sat, 12 Sep 2009 18:09:36 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPV0048W8V0EM30@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 12 Sep 2009 18:09:36 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.9.12.155718
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <200909121752.07523.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128262>

Add selftests verifying:
- that we are able to parse notes trees with various fanout schemes
- that notes trees with conflicting fanout schemes are parsed as expected

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3303-notes-subtrees.sh |  137 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 137 insertions(+), 0 deletions(-)
 create mode 100755 t/t3303-notes-subtrees.sh

diff --git a/t/t3303-notes-subtrees.sh b/t/t3303-notes-subtrees.sh
new file mode 100755
index 0000000..d24203e
--- /dev/null
+++ b/t/t3303-notes-subtrees.sh
@@ -0,0 +1,137 @@
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
+test_expect_success "setup: create $number_of_commits commits" '
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
+test_sha1_based () {
+	(
+		start_note_commit &&
+		nr=$number_of_commits &&
+		git rev-list refs/heads/master |
+		while read sha1; do
+			note_path=$(echo "$sha1" | sed "$1")
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
+}
+
+test_expect_success 'test notes in 2/38-fanout' 'test_sha1_based "s|^..|&/|"'
+test_expect_success 'verify notes in 2/38-fanout' 'verify_notes'
+
+test_expect_success 'test notes in 4/36-fanout' 'test_sha1_based "s|^....|&/|"'
+test_expect_success 'verify notes in 4/36-fanout' 'verify_notes'
+
+test_expect_success 'test notes in 2/2/36-fanout' 'test_sha1_based "s|^\(..\)\(..\)|\1/\2/|"'
+test_expect_success 'verify notes in 2/2/36-fanout' 'verify_notes'
+
+test_preferred () {
+	(
+		start_note_commit &&
+		nr=$number_of_commits &&
+		git rev-list refs/heads/master |
+		while read sha1; do
+			preferred_note_path=$(echo "$sha1" | sed "$1")
+			ignored_note_path=$(echo "$sha1" | sed "$2")
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
+}
+
+test_expect_success 'test notes in 4/36-fanout overriding 2/38-fanout' 'test_preferred "s|^....|&/|" "s|^..|&/|"'
+test_expect_success 'verify notes in 4/36-fanout overriding 2/38-fanout' 'verify_notes'
+
+test_expect_success 'test notes in 2/38-fanout overriding 2/2/36-fanout' 'test_preferred "s|^..|&/|" "s|^\(..\)\(..\)|\1/\2/|"'
+test_expect_success 'verify notes in 2/38-fanout overriding 2/2/36-fanout' 'verify_notes'
+
+test_done
-- 
1.6.4.304.g1365c.dirty
