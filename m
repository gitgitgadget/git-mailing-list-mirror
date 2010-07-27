From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [PATCH] Fix git rebase --continue to work with touched files
Date: Tue, 27 Jul 2010 03:06:38 -0700
Message-ID: <1280225198-4539-1-git-send-email-ddkilzer@kilzer.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"David D. Kilzer" <ddkilzer@kilzer.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 27 12:06:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odh3o-00077B-E3
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 12:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047Ab0G0KGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 06:06:50 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:55348 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756032Ab0G0KGt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 06:06:49 -0400
Received: from relay15.apple.com (relay15.apple.com [17.128.113.54])
	by mail-out4.apple.com (Postfix) with ESMTP id 34591A58686D;
	Tue, 27 Jul 2010 03:06:48 -0700 (PDT)
X-AuditID: 11807136-b7cc9ae000004162-55-4c4eafb82480
Received: from ddkilzer.apple.com (ddkilzer.apple.com [17.202.32.26])
	by relay15.apple.com (Apple SCV relay) with SMTP id 81.9B.16738.8BFAE4C4; Tue, 27 Jul 2010 03:06:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1.36.g07b1c
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151923>

When performing a non-interactive rebase, sometimes
"git rebase --continue" will fail if an unmodified file is
touched in the working directory:

    You must edit all merge conflicts and then
    mark them as resolved using git add

This is caused by "git diff-files" reporting a difference
between the index and the filesystem:

    :100644 100644 d00491...... 000000...... M	file

The fix is to run "git update-index --refresh" before
"git diff-files" as is done in git-rebase--interactive.

Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>
---
The reason for the while loop in the test is that this bug only
reproduces about half of the time on my Mac Pro with Mac OS X
10.6.4.  I used 4 loops to make sure the test fails without the
fix.

I also put the test in a separate file since t3400-rebase.sh
changed a lot in e877a4c, and to make it clear what is required
to reproduce the bug.

 git-rebase.sh              |    1 +
 t/t3418-rebase-continue.sh |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 0 deletions(-)
 create mode 100755 t/t3418-rebase-continue.sh

diff --git a/git-rebase.sh b/git-rebase.sh
index ab4afa7..2d88742 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -208,6 +208,7 @@ do
 		test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply ||
 			die "No rebase in progress?"
 
+		git update-index --ignore-submodules --refresh &&
 		git diff-files --quiet --ignore-submodules || {
 			echo "You must edit all merge conflicts and then"
 			echo "mark them as resolved using git add"
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
new file mode 100755
index 0000000..435560c
--- /dev/null
+++ b/t/t3418-rebase-continue.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description='git rebase --continue should work with touched files'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo 1 >F1 &&
+	git add F1 &&
+	git commit -m "commit: new file F1" &&
+
+	echo 2 >F2 &&
+	git add F2 &&
+	git commit -m "commit: new file F2" &&
+
+	git checkout -b topic HEAD^ &&
+
+	echo 22 > F2 &&
+	git add F2 &&
+	git commit -m "commit: new file F2 on topic branch" &&
+
+	git checkout master
+'
+
+
+test_expect_success 'rebase --continue works with touched file' '
+	count=1
+	while test "$count" -le 4
+	do
+		git branch topic$count topic &&
+		test_must_fail git rebase --onto master master topic$count &&
+		echo "Resolved" >F2 &&
+		git add F2 &&
+		touch F1 &&
+		git rebase --continue || exit 1
+		count=$(($count + 1))
+	done
+'
+
+test_done
-- 
1.7.1.1.36.g07b1c
