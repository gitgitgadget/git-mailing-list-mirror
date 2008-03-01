From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] t3407-rebase-abort.sh: Enhance existing tests, and add test for rebase --merge
Date: Sat,  1 Mar 2008 12:12:13 +0100
Message-ID: <1204369933-3040-1-git-send-email-mh@glandium.org>
References: <Signed-off-by: Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 01 12:09:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVPan-0006ER-GQ
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 12:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678AbYCALIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 06:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754662AbYCALIr
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 06:08:47 -0500
Received: from vuizook.err.no ([194.24.252.247]:50973 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754571AbYCALIr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 06:08:47 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JVPa2-0007Qk-6i; Sat, 01 Mar 2008 12:08:45 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JVPdV-0000nP-F1; Sat, 01 Mar 2008 12:12:13 +0100
X-Mailer: git-send-email 1.5.4.3.344.g6fd65.dirty
In-Reply-To: <Signed-off-by: Mike Hommey <mh@glandium.org>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75656>

Removing .dotest should actually not be needed, so just test the directory
don't exist after --abort, but exists after starting the rebase.

Also, execute the same tests with rebase --merge, which uses a different code
path.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 t/t3407-rebase-abort.sh |   68 +++++++++++++++++++++++++++-------------------
 1 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 3417138..37944c3 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -23,37 +23,49 @@ test_expect_success setup '
 	git branch pre-rebase
 '
 
-test_expect_success 'rebase --abort' '
-	test_must_fail git rebase master &&
-	git rebase --abort &&
-	test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase)
-'
+testrebase() {
+	type=$1
+	dotest=$2
 
-test_expect_success 'rebase --abort after --skip' '
-	# Clean up the state from the previous one
-	git reset --hard pre-rebase
-	rm -rf .dotest
+	test_expect_success "rebase$type --abort" '
+		# Clean up the state from the previous one
+		git reset --hard pre-rebase
+		test_must_fail git rebase'"$type"' master &&
+		test -d '$dotest' &&
+		git rebase --abort &&
+		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
+		test ! -d '$dotest'
+	'
 
-	test_must_fail git rebase master &&
-	test_must_fail git rebase --skip &&
-	test $(git rev-parse HEAD) = $(git rev-parse master) &&
-	git rebase --abort &&
-	test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase)
-'
+	test_expect_success "rebase$type --abort after --skip" '
+		# Clean up the state from the previous one
+		git reset --hard pre-rebase
+		test_must_fail git rebase'"$type"' master &&
+		test -d '$dotest' &&
+		test_must_fail git rebase --skip &&
+		test $(git rev-parse HEAD) = $(git rev-parse master) &&
+		git-rebase --abort &&
+		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
+		test ! -d '$dotest'
+	'
 
-test_expect_success 'rebase --abort after --continue' '
-	# Clean up the state from the previous one
-	git reset --hard pre-rebase
-	rm -rf .dotest
+	test_expect_success "rebase$type --abort after --continue" '
+		# Clean up the state from the previous one
+		git reset --hard pre-rebase
+		test_must_fail git rebase'"$type"' master &&
+		test -d '$dotest' &&
+		echo c > a &&
+		echo d >> a &&
+		git add a &&
+		test_must_fail git rebase --continue &&
+		test $(git rev-parse HEAD) != $(git rev-parse master) &&
+		git rebase --abort &&
+		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
+		test ! -d '$dotest'
+	'
+}
 
-	test_must_fail git rebase master &&
-	echo c > a &&
-	echo d >> a &&
-	git add a &&
-	test_must_fail git rebase --continue &&
-	test $(git rev-parse HEAD) != $(git rev-parse master) &&
-	git rebase --abort &&
-	test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase)
-'
+testrebase "" .dotest
+testrebase " --merge" .git/.dotest-merge
 
 test_done
-- 
1.5.4.3.344.g6fd65.dirty

