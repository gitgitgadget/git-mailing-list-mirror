From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 11/14] cherry-pick: add t3512 for submodule updates
Date: Sun, 15 Jun 2014 19:03:18 +0200
Message-ID: <539DD1D6.6000509@web.de>
References: <539DD029.4030506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 15 19:03:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwDqE-0004pd-0h
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 19:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbaFORDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 13:03:34 -0400
Received: from mout.web.de ([212.227.17.11]:52814 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbaFORDe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 13:03:34 -0400
Received: from [192.168.178.41] ([84.132.144.103]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MGABv-1WzosC0WBD-00FC8i; Sun, 15 Jun 2014 19:03:19
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539DD029.4030506@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:+g5dX+Bz9d9nuUzL6No5Hjz7tqNpcR8mlGVuHXHXhSfOTg7K8N4
 10jMMtx2OQUYg+/cOPH/vhxnhqVvcdgo3m1ILmihLcsFOt7OiExYTp/mqzdWVuoPbJ3CyiI
 hSPQcba2X9hRCBA88DQD/aXFyXKGIAaQrN6oL4WtS58BCh9ji1s/N312irL5Ssry4yMucSi
 GGUTgNnv3NdIA5D6Y6jZw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251693>

Test that the cherry-pick command updates the work tree as expected (for
submodule changes which don't result in conflicts).

Set KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES
and KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR to
document that cherry-pick has the same --no-ff known failures merge has.

Implement the KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT switch to expect
the known failure that while cherry picking just a SHA-1 update for an
ignored submodule the commit incorrectly fails with "The previous
cherry-pick is now empty, possibly due to conflict resolution.".

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 t/lib-submodule-update.sh        | 15 ++++++++++++---
 t/t3512-cherry-pick-submodule.sh | 13 +++++++++++++
 2 files changed, 25 insertions(+), 3 deletions(-)
 create mode 100755 t/t3512-cherry-pick-submodule.sh

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index bc9415c..95e041b 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -392,7 +392,16 @@ test_submodule_switch () {

 	########################## Modified submodule #########################
 	# Updating a submodule sha1 doesn't update the submodule's work tree
-	test_expect_success "$command: modified submodule does not update submodule work tree" '
+	if test "$KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT" = 1
+	then
+		# When cherry picking a SHA-1 update for an ignored submodule
+		# the commit incorrectly fails with "The previous cherry-pick
+		# is now empty, possibly due to conflict resolution."
+		RESULT="failure"
+	else
+		RESULT="success"
+	fi
+	test_expect_$RESULT "$command: modified submodule does not update submodule work tree" '
 		prolog &&
 		reset_work_tree_to add_sub1 &&
 		(
@@ -408,7 +417,7 @@ test_submodule_switch () {

 	# Updating a submodule to an invalid sha1 doesn't update the
 	# submodule's work tree, subsequent update will fail
-	test_expect_success "$command: modified submodule does not update submodule work tree to invalid commit" '
+	test_expect_$RESULT "$command: modified submodule does not update submodule work tree to invalid commit" '
 		prolog &&
 		reset_work_tree_to add_sub1 &&
 		(
@@ -423,7 +432,7 @@ test_submodule_switch () {
 	'
 	# Updating a submodule from an invalid sha1 doesn't update the
 	# submodule's work tree, subsequent update will succeed
-	test_expect_success "$command: modified submodule does not update submodule work tree from invalid commit" '
+	test_expect_$RESULT "$command: modified submodule does not update submodule work tree from invalid commit" '
 		prolog &&
 		reset_work_tree_to invalid_sub1 &&
 		(
diff --git a/t/t3512-cherry-pick-submodule.sh b/t/t3512-cherry-pick-submodule.sh
new file mode 100755
index 0000000..6863b7b
--- /dev/null
+++ b/t/t3512-cherry-pick-submodule.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+
+test_description='cherry-pick can handle submodules'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-submodule-update.sh
+
+KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
+KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
+KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
+test_submodule_switch "git cherry-pick"
+
+test_done
-- 
2.0.0.275.gc479268
