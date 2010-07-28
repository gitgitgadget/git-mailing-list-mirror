From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [PATCH v2] Fix git rebase --continue to work with touched files
Date: Wed, 28 Jul 2010 01:20:16 -0700
Message-ID: <1280305216-59263-1-git-send-email-ddkilzer@kilzer.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"David D. Kilzer" <ddkilzer@kilzer.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 28 10:20:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe1sW-0007WC-L3
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 10:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065Ab0G1IUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 04:20:35 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:53388 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804Ab0G1IUb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 04:20:31 -0400
Received: from relay15.apple.com (relay15.apple.com [17.128.113.54])
	by mail-out4.apple.com (Postfix) with ESMTP id 25542A5BA9D5;
	Wed, 28 Jul 2010 01:20:31 -0700 (PDT)
X-AuditID: 11807136-b7cc9ae000004162-b7-4c4fe84fd1e7
Received: from ddkilzer.apple.com (ddkilzer.apple.com [17.202.32.26])
	by relay15.apple.com (Apple SCV relay) with SMTP id 03.26.16738.F48EF4C4; Wed, 28 Jul 2010 01:20:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.25.gd0768
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152056>

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
Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
Changes since v1:
- Updated test script based on list feedback.  Thanks!
  * Replaced while loop in original test with test-chmtime.
  * Switched to use test_commit.
- Added test case for the same issue in git-rebase--interactive
  that was already fixed, and verified that the test breaks when
  the fix is removed.

 git-rebase.sh              |    1 +
 t/t3418-rebase-continue.sh |   43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 0 deletions(-)
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
index 0000000..3b0d273
--- /dev/null
+++ b/t/t3418-rebase-continue.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='git rebase --continue tests'
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+set_fake_editor
+
+test_expect_success 'setup' '
+	test_commit "commit-new-file-F1" F1 1 &&
+	test_commit "commit-new-file-F2" F2 2 &&
+
+	git checkout -b topic HEAD^ &&
+	test_commit "commit-new-file-F2-on-topic-branch" F2 22 &&
+
+	git checkout master
+'
+
+test_expect_success 'interactive rebase --continue works with touched file' '
+	rm -fr .git/rebase-* &&
+	git reset --hard &&
+	git checkout master &&
+
+	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
+	test-chmtime =-60 F1 &&
+	git rebase --continue
+'
+
+test_expect_success 'non-interactive rebase --continue works with touched file' '
+	rm -fr .git/rebase-* &&
+	git reset --hard &&
+	git checkout master &&
+
+	test_must_fail git rebase --onto master master topic &&
+	echo "Resolved" >F2 &&
+	git add F2 &&
+	test-chmtime =-60 F1 &&
+	git rebase --continue
+'
+
+test_done
-- 
1.7.2.25.gd0768
