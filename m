From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 1/3] t9301: Fix testcase covering up a bug in fast-import's
 notes fanout handling
Date: Fri, 25 Nov 2011 01:09:45 +0100
Message-ID: <1322179787-4422-2-git-send-email-johan@herland.net>
References: <Pine.GSO.4.63.1111231137350.5099@shipon.roxen.com>
 <1322179787-4422-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, jrnieder@gmail.com, johan@herland.net
To: grubba@grubba.org
X-From: git-owner@vger.kernel.org Fri Nov 25 02:10:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTkIz-0006dq-65
	for gcvg-git-2@lo.gmane.org; Fri, 25 Nov 2011 02:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730Ab1KYBKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 20:10:06 -0500
Received: from smtp.getmail.no ([84.208.15.66]:55121 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752995Ab1KYBKF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 20:10:05 -0500
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Nov 2011 20:10:04 EST
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LV600HD1WGOGC60@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 25 Nov 2011 01:10:00 +0100 (MET)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 7DF1B1799092_ECEDCD8B	for <git@vger.kernel.org>; Fri,
 25 Nov 2011 00:10:00 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 1B8F2179628E_ECEDCD8F	for <git@vger.kernel.org>; Fri,
 25 Nov 2011 00:10:00 +0000 (GMT)
Received: from alpha.herland ([84.208.177.71]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LV600D70WGNSC30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 25 Nov 2011 01:10:00 +0100 (MET)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1322179787-4422-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185919>

There is a bug in fast-import where the fanout levels of an existing notes
tree being loaded into the fast-import machinery is disregarded. Instead, any
tree loaded is assumed to have a fanout level of 0. If the true fanout level
is deeper, any attempt to remove a note from that tree will silently fail
(as the note will not be found at fanout level 0).

However, this bug was covered up by the way in which the t9301 testcase was
written: When generating the fast-import commands to test mass removal of
notes, we appended these commands to an already existing 'input' file which
happened to already contain the fast-import commands used in the previous
subtest to generate the very same notes tree. This would normally be harmless
(but suboptimal) as the notes created were identical to the notes already
present in the notes tree. But the act of repeating all the notes additions
caused the internal fast-import data structures to recalculate the fanout,
instead of hanging on to the initial (incorrect) fanout (that causes the bug
described above). Thus, the subsequent removal of notes in the same 'input'
file would succeed, thereby covering up the bug described above.

This patch creates a new 'input' file instead of appending to the file from
the previous subtest. Thus, we end up properly testing removal of notes that
were added by a previous fast-import command. As a side effect, the notes
removal can no longer refer to commits using the marks set by the previous
fast-import run, instead the commits names must be referenced directly.

The underlying fast-import bug is still present after this patch, but now we
have at least uncovered it. Therefore, the affected subtests are labeled as
expected failures until the underlying bug is fixed.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t9301-fast-import-notes.sh |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index 463254c..fd08161 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -507,7 +507,7 @@ test_expect_success 'verify that non-notes are untouched by a fanout change' '
 '
 remaining_notes=10
 test_tick
-cat >>input <<INPUT_END
+cat >input <<INPUT_END
 commit refs/notes/many_notes
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -516,12 +516,11 @@ COMMIT
 from refs/notes/many_notes^0
 INPUT_END
 
-i=$remaining_notes
-while test $i -lt $num_commits
+i=$(($num_commits - $remaining_notes))
+for sha1 in $(git rev-list -n $i refs/heads/many_commits)
 do
-	i=$(($i + 1))
 	cat >>input <<INPUT_END
-N 0000000000000000000000000000000000000000 :$i
+N 0000000000000000000000000000000000000000 $sha1
 INPUT_END
 done
 
@@ -541,7 +540,7 @@ EXPECT_END
 	i=$(($i - 1))
 done
 
-test_expect_success 'remove lots of notes' '
+test_expect_failure 'remove lots of notes' '
 
 	git fast-import <input &&
 	GIT_NOTES_REF=refs/notes/many_notes git log refs/heads/many_commits |
@@ -550,7 +549,7 @@ test_expect_success 'remove lots of notes' '
 
 '
 
-test_expect_success 'verify that removing notes trigger fanout consolidation' '
+test_expect_failure 'verify that removing notes trigger fanout consolidation' '
 
 	# All entries in the top-level notes tree should be a full SHA1
 	git ls-tree --name-only -r refs/notes/many_notes |
-- 
1.7.5.rc1.3.g4d7b
