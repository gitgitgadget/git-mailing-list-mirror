From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv7 14/22] Add selftests verifying concatenation of multiple
 notes for the same commit
Date: Fri, 09 Oct 2009 12:22:10 +0200
Message-ID: <1255083738-23263-16-git-send-email-johan@herland.net>
References: <1255083738-23263-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 12:32:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwClU-0004PL-JB
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 12:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760702AbZJIKY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 06:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760695AbZJIKY0
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 06:24:26 -0400
Received: from smtp.getmail.no ([84.208.15.66]:58515 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760698AbZJIKYZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 06:24:25 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800BTLSU88I20@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:22:56 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800IEJST91V00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:22:56 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.9.101220
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1255083738-23263-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129775>

Also verify that multiple references to the _same_ note blob are _not_
concatenated.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3303-notes-subtrees.sh |   84 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/t/t3303-notes-subtrees.sh b/t/t3303-notes-subtrees.sh
index cbb9d35..edc4bc8 100755
--- a/t/t3303-notes-subtrees.sh
+++ b/t/t3303-notes-subtrees.sh
@@ -101,4 +101,88 @@ test_expect_success 'verify notes in 4/36-fanout' 'verify_notes'
 test_expect_success 'test notes in 2/2/36-fanout' 'test_sha1_based "s|^\(..\)\(..\)|\1/\2/|"'
 test_expect_success 'verify notes in 2/2/36-fanout' 'verify_notes'
 
+test_same_notes () {
+	(
+		start_note_commit &&
+		nr=$number_of_commits &&
+		git rev-list refs/heads/master |
+		while read sha1; do
+			first_note_path=$(echo "$sha1" | sed "$1")
+			second_note_path=$(echo "$sha1" | sed "$2")
+			cat <<INPUT_END &&
+M 100644 inline $second_note_path
+data <<EOF
+note for commit #$nr
+EOF
+
+M 100644 inline $first_note_path
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
+test_expect_success 'test same notes in 4/36-fanout and 2/38-fanout' 'test_same_notes "s|^..|&/|" "s|^....|&/|"'
+test_expect_success 'verify same notes in 4/36-fanout and 2/38-fanout' 'verify_notes'
+
+test_expect_success 'test same notes in 2/38-fanout and 2/2/36-fanout' 'test_same_notes "s|^\(..\)\(..\)|\1/\2/|" "s|^..|&/|"'
+test_expect_success 'verify same notes in 2/38-fanout and 2/2/36-fanout' 'verify_notes'
+
+test_expect_success 'test same notes in 4/36-fanout and 2/2/36-fanout' 'test_same_notes "s|^\(..\)\(..\)|\1/\2/|" "s|^....|&/|"'
+test_expect_success 'verify same notes in 4/36-fanout and 2/2/36-fanout' 'verify_notes'
+
+test_concatenated_notes () {
+	(
+		start_note_commit &&
+		nr=$number_of_commits &&
+		git rev-list refs/heads/master |
+		while read sha1; do
+			first_note_path=$(echo "$sha1" | sed "$1")
+			second_note_path=$(echo "$sha1" | sed "$2")
+			cat <<INPUT_END &&
+M 100644 inline $second_note_path
+data <<EOF
+second note for commit #$nr
+EOF
+
+M 100644 inline $first_note_path
+data <<EOF
+first note for commit #$nr
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
+verify_concatenated_notes () {
+    git log | grep "^    " > output &&
+    i=$number_of_commits &&
+    while [ $i -gt 0 ]; do
+        echo "    commit #$i" &&
+        echo "    first note for commit #$i" &&
+        echo "    second note for commit #$i" &&
+        i=$(($i-1));
+    done > expect &&
+    test_cmp expect output
+}
+
+test_expect_success 'test notes in 4/36-fanout concatenated with 2/38-fanout' 'test_concatenated_notes "s|^..|&/|" "s|^....|&/|"'
+test_expect_success 'verify notes in 4/36-fanout concatenated with 2/38-fanout' 'verify_concatenated_notes'
+
+test_expect_success 'test notes in 2/38-fanout concatenated with 2/2/36-fanout' 'test_concatenated_notes "s|^\(..\)\(..\)|\1/\2/|" "s|^..|&/|"'
+test_expect_success 'verify notes in 2/38-fanout concatenated with 2/2/36-fanout' 'verify_concatenated_notes'
+
+test_expect_success 'test notes in 4/36-fanout concatenated with 2/2/36-fanout' 'test_concatenated_notes "s|^\(..\)\(..\)|\1/\2/|" "s|^....|&/|"'
+test_expect_success 'verify notes in 4/36-fanout concatenated with 2/2/36-fanout' 'verify_concatenated_notes'
+
 test_done
-- 
1.6.4.304.g1365c.dirty
