From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 12/14] Selftests verifying semantics when loading notes trees
 with various fanouts
Date: Tue, 08 Sep 2009 04:27:00 +0200
Message-ID: <1252376822-6138-13-git-send-email-johan@herland.net>
References: <1252376822-6138-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 08 04:28:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkqRe-0005lE-Hi
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 04:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbZIHC1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 22:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753494AbZIHC1i
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 22:27:38 -0400
Received: from smtp.getmail.no ([84.208.15.66]:34077 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753443AbZIHC1e (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2009 22:27:34 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPM00CZIS60LI90@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Sep 2009 04:27:36 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPM0072GS5GQN30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Sep 2009 04:27:36 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.9.8.21525
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1252376822-6138-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127959>

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
