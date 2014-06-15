From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 08/14] merge: add t7613 for submodule updates
Date: Sun, 15 Jun 2014 19:01:41 +0200
Message-ID: <539DD175.5070005@web.de>
References: <539DD029.4030506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 15 19:01:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwDoZ-0003Ta-NP
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 19:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbaFORBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 13:01:52 -0400
Received: from mout.web.de ([212.227.15.14]:59566 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719AbaFORBv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 13:01:51 -0400
Received: from [192.168.178.41] ([84.132.144.103]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LgpVS-1WQlCC0Gd4-00oDDC; Sun, 15 Jun 2014 19:01:42
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539DD029.4030506@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:h9aXDEFMkZlUINjUCY+qqLGzdeRPGTOfrNoyW2e2yAOGXxZLStL
 9RdKDEDrgtb8YoS1ZyZZWGUSxBYgkmtfBoNFvaYdjyVTv5uJcKQGHFlJTFzzFoxJin9fZBm
 ENQzWxKb1ib2zekc2MJryFdhhNdUz/SkV9bd5fHPXvkCmeHweBk+siJnikw6M/nK27eE7Rx
 BWlDDo31sIH7IDfeXGoog==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251690>

Test that the merge command updates the work tree as expected (for
submodule changes which don't result in conflicts) when used without
arguments or with the '--ff', '--ff-only' and '--no-ff' flag.

Implement the KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR
switch to expect the known failure that --no-ff merges do not create the
empty submodule directory.

The KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES
switch is also implemented to expect the known failure that --no-ff
merges attempt to merge the new files in the former submodule directory
with those of the removed submodule.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 t/lib-submodule-update.sh  | 24 +++++++++++++++++++++---
 t/t7613-merge-submodule.sh | 19 +++++++++++++++++++
 2 files changed, 40 insertions(+), 3 deletions(-)
 create mode 100755 t/t7613-merge-submodule.sh

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index c6c842a..bc9415c 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -275,7 +275,16 @@ test_submodule_switch () {
 	'
 	# ... as does removing a directory with tracked files with a
 	# submodule.
-	test_expect_success "$command: replace directory with submodule" '
+	if test "$KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR" = 1
+	then
+		# Non fast-forward merges fail with "Directory sub1 doesn't
+		# exist. sub1" because the empty submodule directory is not
+		# created
+		RESULT="failure"
+	else
+		RESULT="success"
+	fi
+	test_expect_$RESULT "$command: replace directory with submodule" '
 		prolog &&
 		reset_work_tree_to replace_sub1_with_directory &&
 		(
@@ -318,7 +327,16 @@ test_submodule_switch () {
 	'
 	# Replacing a submodule with files in a directory must fail as the
 	# submodule work tree isn't removed ...
-	test_expect_success "$command: replace submodule with a directory must fail" '
+	if test "$KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES" = 1
+	then
+		# Non fast-forward merges attempt to merge the former
+		# submodule files with the newly checked out ones in the
+		# directory of the same name while it shouldn't.
+		RESULT="failure"
+	else
+		RESULT="success"
+	fi
+	test_expect_$RESULT "$command: replace submodule with a directory must fail" '
 		prolog &&
 		reset_work_tree_to add_sub1 &&
 		(
@@ -330,7 +348,7 @@ test_submodule_switch () {
 		)
 	'
 	# ... especially when it contains a .git directory.
-	test_expect_success "$command: replace submodule containing a .git directory with a directory must fail" '
+	test_expect_$RESULT "$command: replace submodule containing a .git directory with a directory must fail" '
 		prolog &&
 		reset_work_tree_to add_sub1 &&
 		(
diff --git a/t/t7613-merge-submodule.sh b/t/t7613-merge-submodule.sh
new file mode 100755
index 0000000..d1e9fcc
--- /dev/null
+++ b/t/t7613-merge-submodule.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description='merge can handle submodules'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-submodule-update.sh
+
+# merges without conflicts
+test_submodule_switch "git merge"
+
+test_submodule_switch "git merge --ff"
+
+test_submodule_switch "git merge --ff-only"
+
+KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
+KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
+test_submodule_switch "git merge --no-ff"
+
+test_done
-- 
2.0.0.275.gc479268
