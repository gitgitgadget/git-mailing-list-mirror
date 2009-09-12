From: Johan Herland <johan@herland.net>
Subject: [PATCHv6 14/14] Add test cases for various date-based fanouts
Date: Sat, 12 Sep 2009 18:08:48 +0200
Message-ID: <1252771728-27206-15-git-send-email-johan@herland.net>
References: <200909121752.07523.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Sep 12 18:10:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmVBF-0000GY-Qq
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 18:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797AbZILQJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 12:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754782AbZILQJu
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 12:09:50 -0400
Received: from smtp.getmail.no ([84.208.15.66]:65334 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754657AbZILQJl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 12:09:41 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPV001KC8W7W220@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 12 Sep 2009 18:09:43 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPV0048W8V0EM30@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 12 Sep 2009 18:09:43 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.9.12.155718
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <200909121752.07523.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128270>

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3303-notes-subtrees.sh |   64 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/t/t3303-notes-subtrees.sh b/t/t3303-notes-subtrees.sh
index d24203e..d3cbf6d 100755
--- a/t/t3303-notes-subtrees.sh
+++ b/t/t3303-notes-subtrees.sh
@@ -134,4 +134,68 @@ test_expect_success 'verify notes in 4/36-fanout overriding 2/38-fanout' 'verify
 test_expect_success 'test notes in 2/38-fanout overriding 2/2/36-fanout' 'test_preferred "s|^..|&/|" "s|^\(..\)\(..\)|\1/\2/|"'
 test_expect_success 'verify notes in 2/38-fanout overriding 2/2/36-fanout' 'verify_notes'
 
+test_date_based () {
+	(
+		start_note_commit &&
+		nr=$number_of_commits &&
+		git log --format="%H %ct" refs/heads/master |
+		while read sha1 date_t; do
+			date=$(date -u -d "@$date_t" +"$1")
+			note_path="$date/$(echo "$sha1" | sed "$2")"
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
+test_expect_success 'test notes in y/40-fanout' 'test_date_based "y%Y" ""'
+test_expect_success 'verify notes in y/40-fanout' 'verify_notes'
+
+test_expect_success 'test notes in y/2/38-fanout' 'test_date_based "y%Y" "s|^..|&/|"'
+test_expect_success 'verify notes in y/2/38-fanout' 'verify_notes'
+
+test_expect_success 'test notes in ym/40-fanout' 'test_date_based "y%Ym%m" ""'
+test_expect_success 'verify notes in ym/40-fanout' 'verify_notes'
+
+test_expect_success 'test notes in ym/2/38-fanout' 'test_date_based "y%Ym%m" "s|^..|&/|"'
+test_expect_success 'verify notes in ym/2/38-fanout' 'verify_notes'
+
+test_expect_success 'test notes in ymd/40-fanout' 'test_date_based "y%Ym%md%d" ""'
+test_expect_success 'verify notes in ymd/40-fanout' 'verify_notes'
+
+test_expect_success 'test notes in ymd/2/38-fanout' 'test_date_based "y%Ym%md%d" "s|^..|&/|"'
+test_expect_success 'verify notes in ymd/2/38-fanout' 'verify_notes'
+
+test_expect_success 'test notes in y/m/40-fanout' 'test_date_based "y%Y/m%m" ""'
+test_expect_success 'verify notes in y/m/40-fanout' 'verify_notes'
+
+test_expect_success 'test notes in y/m/2/38-fanout' 'test_date_based "y%Y/m%m" "s|^..|&/|"'
+test_expect_success 'verify notes in y/m/2/38-fanout' 'verify_notes'
+
+test_expect_success 'test notes in y/md/40-fanout' 'test_date_based "y%Y/m%md%d" ""'
+test_expect_success 'verify notes in y/md/40-fanout' 'verify_notes'
+
+test_expect_success 'test notes in y/md/2/38-fanout' 'test_date_based "y%Y/m%md%d" "s|^..|&/|"'
+test_expect_success 'verify notes in y/md/2/38-fanout' 'verify_notes'
+
+test_expect_success 'test notes in ym/d/40-fanout' 'test_date_based "y%Ym%m/d%d" ""'
+test_expect_success 'verify notes in ym/d/40-fanout' 'verify_notes'
+
+test_expect_success 'test notes in ym/d/2/38-fanout' 'test_date_based "y%Ym%m/d%d" "s|^..|&/|"'
+test_expect_success 'verify notes in ym/d/2/38-fanout' 'verify_notes'
+
+test_expect_success 'test notes in y/m/d/40-fanout' 'test_date_based "y%Y/m%m/d%d" ""'
+test_expect_success 'verify notes in y/m/d/40-fanout' 'verify_notes'
+
+test_expect_success 'test notes in y/m/d/2/38-fanout' 'test_date_based "y%Y/m%m/d%d" "s|^..|&/|"'
+test_expect_success 'verify notes in y/m/d/2/38-fanout' 'verify_notes'
+
 test_done
-- 
1.6.4.304.g1365c.dirty
