From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/3] t3400-rebase: Move detached HEAD check earlier
Date: Sun,  1 Mar 2009 11:20:03 +0100
Message-ID: <1235902803-32528-1-git-send-email-j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 11:21:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldinh-0000Nf-VJ
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 11:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbZCAKUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 05:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbZCAKUK
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 05:20:10 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:38222 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843AbZCAKUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 05:20:09 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C84A22C4009;
	Sun,  1 Mar 2009 11:20:03 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 8AB8C1D219;
	Sun,  1 Mar 2009 11:20:03 +0100 (CET)
X-Mailer: git-send-email 1.6.2.rc1.27.g29e57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111836>

Short story: There is a section in t3400 that tests fundamental rebase
properties.  3ec7371f (Add two extra tests for git rebase, 2009-02-09)
added a check that rebase works on a detached HEAD, but the test was put
near the end of the file.  This moves it to a more suitable place.

Long story: The test that preceded the one in question tests that a
rebased commit degrades from a content change with mode change to a
mere mode change.  But on Windows, where we have core.filemode=false,
the original commit did not record the mode change, and so the rebase
operation did not rebase anything.  This caused the subsequent detached
HEAD test to fail.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t3400-rebase.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 8c0c5f5..be7ae5a 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -48,6 +48,10 @@ test_expect_success \
     'the rebase operation should not have destroyed author information' \
     '! (git log | grep "Author:" | grep "<>")'
 
+test_expect_success 'HEAD was detached during rebase' '
+     test $(git rev-parse HEAD@{1}) != $(git rev-parse my-topic-branch@{1})
+'
+
 test_expect_success 'rebase after merge master' '
      git reset --hard topic &&
      git merge master &&
@@ -85,10 +89,6 @@ test_expect_success 'rebase a single mode change' '
      GIT_TRACE=1 git rebase master
 '
 
-test_expect_success 'HEAD was detached during rebase' '
-     test $(git rev-parse HEAD@{1}) != $(git rev-parse modechange@{1})
-'
-
 test_expect_success 'Show verbose error when HEAD could not be detached' '
      : > B &&
      test_must_fail git rebase topic 2> output.err > output.out &&
-- 
1.6.2.rc1.27.g29e57
