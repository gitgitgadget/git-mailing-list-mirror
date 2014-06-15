From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 13/14] stash: add t3906 for submodule updates
Date: Sun, 15 Jun 2014 19:04:25 +0200
Message-ID: <539DD219.40108@web.de>
References: <539DD029.4030506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 15 19:04:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwDr9-0005b7-Dz
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 19:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbaFOREc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 13:04:32 -0400
Received: from mout.web.de ([212.227.15.4]:52311 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517AbaFOREb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 13:04:31 -0400
Received: from [192.168.178.41] ([84.132.144.103]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MN4Kq-1Wpc8o0YVE-006iTJ; Sun, 15 Jun 2014 19:04:26
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539DD029.4030506@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:B/pYGB8CgVn0Fh74oxZ2uKY2bx0pUCiOA/3n9wkBFyrVa8DBeVB
 TWvXaYAlEglzP220KY0VqQ99poSdAv+b3YTOpJbVeOnbzibxmdlD+hIyOF4ZnVMV2tsJjhf
 I8kK4oHgSfzRBefIfL79L6CCSHw0KGkHglXjYUjydAAREwq0ugBCvbMsG3UfLsL3fqiW1AR
 9y+Su9EnbFp8ZOOvF7aJw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251695>

Test that the stash apply command updates the work tree as expected for
changes which don't result in conflicts. To make that work add a helper
function that uses read-tree to apply the changes of the target commit
to the work tree, then stashes these changes and at last applies that
stash.

Implement the KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES switch
and reuse two other already present switches to expect the known
failure that stash does ignore submodule changes.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 t/lib-submodule-update.sh  | 23 ++++++++++++++++++-----
 t/t3906-stash-submodule.sh | 24 ++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 5 deletions(-)
 create mode 100755 t/t3906-stash-submodule.sh

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 95e041b..9901b45 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -217,7 +217,14 @@ test_submodule_switch () {
 	command="$1"
 	######################### Appearing submodule #########################
 	# Switching to a commit letting a submodule appear creates empty dir ...
-	test_expect_success "$command: added submodule creates empty directory" '
+	if test "$KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES" = 1
+	then
+		# Restoring stash fails to restore submodule index entry
+		RESULT="failure"
+	else
+		RESULT="success"
+	fi
+	test_expect_$RESULT "$command: added submodule creates empty directory" '
 		prolog &&
 		reset_work_tree_to no_submodule &&
 		(
@@ -231,7 +238,7 @@ test_submodule_switch () {
 		)
 	'
 	# ... and doesn't care if it already exists ...
-	test_expect_success "$command: added submodule leaves existing empty directory alone" '
+	test_expect_$RESULT "$command: added submodule leaves existing empty directory alone" '
 		prolog &&
 		reset_work_tree_to no_submodule &&
 		(
@@ -260,7 +267,7 @@ test_submodule_switch () {
 	'
 	# Replacing a tracked file with a submodule produces an empty
 	# directory ...
-	test_expect_success "$command: replace tracked file with submodule creates empty directory" '
+	test_expect_$RESULT "$command: replace tracked file with submodule creates empty directory" '
 		prolog &&
 		reset_work_tree_to replace_sub1_with_file &&
 		(
@@ -300,7 +307,13 @@ test_submodule_switch () {

 	######################## Disappearing submodule #######################
 	# Removing a submodule doesn't remove its work tree ...
-	test_expect_success "$command: removed submodule leaves submodule directory and its contents in place" '
+	if test "$KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES" = 1
+	then
+		RESULT="failure"
+	else
+		RESULT="success"
+	fi
+	test_expect_$RESULT "$command: removed submodule leaves submodule directory and its contents in place" '
 		prolog &&
 		reset_work_tree_to add_sub1 &&
 		(
@@ -312,7 +325,7 @@ test_submodule_switch () {
 		)
 	'
 	# ... especially when it contains a .git directory.
-	test_expect_success "$command: removed submodule leaves submodule containing a .git directory alone" '
+	test_expect_$RESULT "$command: removed submodule leaves submodule containing a .git directory alone" '
 		prolog &&
 		reset_work_tree_to add_sub1 &&
 		(
diff --git a/t/t3906-stash-submodule.sh b/t/t3906-stash-submodule.sh
new file mode 100755
index 0000000..aaee424
--- /dev/null
+++ b/t/t3906-stash-submodule.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+test_description='stash apply can handle submodules'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-submodule-update.sh
+
+git_stash () {
+	git status -su >expected &&
+	ls -1pR * >>expected &&
+	git read-tree -u -m "$1" &&
+	git stash &&
+	git status -su >actual &&
+	ls -1pR * >>actual &&
+	test_cmp expected actual &&
+	git stash apply
+}
+
+KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES=1
+KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
+KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
+test_submodule_switch "git_stash"
+
+test_done
-- 
2.0.0.275.gc479268
