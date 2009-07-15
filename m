From: Mike Ralphson <mike@abacus.co.uk>
Subject: [RFC PATCH] cvsexportcommit: reorder tests to quiet intermittent failure
Date: Wed, 15 Jul 2009 15:34:24 +0100
Message-ID: <1247668464-20813-1-git-send-email-mike@abacus.co.uk>
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>,
	Nick Woolley <nickwoolley@yahoo.co.uk>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 16:49:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR5np-00079V-GJ
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 16:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbZGOOtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 10:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbZGOOtm
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 10:49:42 -0400
Received: from [82.109.193.99] ([82.109.193.99]:57362 "EHLO orson.abacus.co.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752525AbZGOOtm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 10:49:42 -0400
X-Greylist: delayed 1109 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jul 2009 10:49:42 EDT
Received: by orson.abacus.co.uk (Postfix, from userid 1006)
	id 3DA09195EBB; Wed, 15 Jul 2009 15:34:24 +0100 (BST)
X-Mailer: git-send-email 1.6.3.1.54.g99dd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123317>

Reorder tests introduced in fef3a7cc and 54d5cc0e so an intermittent but
unimportant failure on the CVS side related to the former does not interfere
with what is actually being tested.

Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
---

Background is at http://thread.gmane.org/gmane.comp.version-control.git/120241/focus=121339
Just chucking this out as a possibility so 1.6.4 doesn't ship with a test
which fails unpredictably.

 t/t9200-git-cvsexportcommit.sh |   41 +++++++++++++++++++++------------------
 1 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index ef1f8d2..fc3795d 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -288,6 +288,27 @@ test_expect_success 'check files before directories' '
 
 '
 
+test_expect_success 're-commit a removed filename which remains in CVS attic' '
+
+    (cd "$CVSWORK" &&
+     echo >attic_gremlin &&
+     cvs -Q add attic_gremlin &&
+     cvs -Q ci -m "added attic_gremlin" &&
+     rm attic_gremlin &&
+     cvs -Q rm attic_gremlin &&
+     cvs -Q ci -m "removed attic_gremlin") &&
+
+    echo > attic_gremlin &&
+    git add attic_gremlin &&
+    git commit -m "Added attic_gremlin" &&
+	git cvsexportcommit -w "$CVSWORK" -c HEAD &&
+    (cd "$CVSWORK"; cvs -Q update -d) &&
+    test -f "$CVSWORK/attic_gremlin"
+'
+
+# the state of the CVS sandbox may be indeterminate for ' space'
+# after this test on some platforms / with some versions of CVS
+# consider adding new tests above this point
 test_expect_success 'commit a file with leading spaces in the name' '
 
 	echo space > " space" &&
@@ -295,7 +316,7 @@ test_expect_success 'commit a file with leading spaces in the name' '
 	git commit -m "Add a file with a leading space" &&
 	id=$(git rev-parse HEAD) &&
 	git cvsexportcommit -w "$CVSWORK" -c $id &&
-	check_entries "$CVSWORK" " space/1.1/|DS/1.1/|release-notes/1.2/" &&
+	check_entries "$CVSWORK" " space/1.1/|DS/1.1/|attic_gremlin/1.3/|release-notes/1.2/" &&
 	test_cmp "$CVSWORK/ space" " space"
 
 '
@@ -317,22 +338,4 @@ test_expect_success 'use the same checkout for Git and CVS' '
 
 '
 
-test_expect_success 're-commit a removed filename which remains in CVS attic' '
-
-    (cd "$CVSWORK" &&
-     echo >attic_gremlin &&
-     cvs -Q add attic_gremlin &&
-     cvs -Q ci -m "added attic_gremlin" &&
-     rm attic_gremlin &&
-     cvs -Q rm attic_gremlin &&
-     cvs -Q ci -m "removed attic_gremlin") &&
-
-    echo > attic_gremlin &&
-    git add attic_gremlin &&
-    git commit -m "Added attic_gremlin" &&
-	git cvsexportcommit -w "$CVSWORK" -c HEAD &&
-    (cd "$CVSWORK"; cvs -Q update -d) &&
-    test -f "$CVSWORK/attic_gremlin"
-'
-
 test_done
-- 
1.6.3.1.54.g99dd
