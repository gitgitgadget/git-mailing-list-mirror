From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 13/14] stash: add t3906 for submodule updates
Date: Thu, 19 Jun 2014 22:12:54 +0200
Message-ID: <53A34446.5080009@web.de>
References: <539DD029.4030506@web.de> <539DD219.40108@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 22:13:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxihs-0006fa-Oc
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 22:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757336AbaFSUNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 16:13:00 -0400
Received: from mout.web.de ([212.227.15.4]:55100 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757289AbaFSUM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 16:12:59 -0400
Received: from [192.168.178.41] ([79.193.64.138]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LlWFD-1WOvyq1R0Z-00bHcW; Thu, 19 Jun 2014 22:12:55
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539DD219.40108@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:EIu8dQHMVqFsvBxzAYQ/CEsJEChX6VLuSeNUInx6ExfOOgNqH6F
 yN4UoCk1V/+o+9akvGJVU5oAAnYjZKrgPQTcXpt1ZFA/WWXoNyttkouDf5I+Yn69xIjm+/v
 mwwa/kdx5D5GzDZ/DNyCu7XN+YPI/MlDeFXP/aG+ZwY+XzOgAlvjSpslx9hn8NwkXSP8AqA
 /HGgD89R31qm2ImoQcAPw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252178>

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


Changes to v1:

*) use "expect" instead of "expected"


 t/lib-submodule-update.sh  | 23 ++++++++++++++++++-----
 t/t3906-stash-submodule.sh | 24 ++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 5 deletions(-)
 create mode 100755 t/t3906-stash-submodule.sh

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index a38cf52..2a504b2 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -219,7 +219,14 @@ test_submodule_switch () {
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
@@ -233,7 +240,7 @@ test_submodule_switch () {
 		)
 	'
 	# ... and doesn't care if it already exists ...
-	test_expect_success "$command: added submodule leaves existing empty directory alone" '
+	test_expect_$RESULT "$command: added submodule leaves existing empty directory alone" '
 		prolog &&
 		reset_work_tree_to no_submodule &&
 		(
@@ -262,7 +269,7 @@ test_submodule_switch () {
 	'
 	# Replacing a tracked file with a submodule produces an empty
 	# directory ...
-	test_expect_success "$command: replace tracked file with submodule creates empty directory" '
+	test_expect_$RESULT "$command: replace tracked file with submodule creates empty directory" '
 		prolog &&
 		reset_work_tree_to replace_sub1_with_file &&
 		(
@@ -302,7 +309,13 @@ test_submodule_switch () {

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
@@ -314,7 +327,7 @@ test_submodule_switch () {
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
index 0000000..d7219d6
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
+	git status -su >expect &&
+	ls -1pR * >>expect &&
+	git read-tree -u -m "$1" &&
+	git stash &&
+	git status -su >actual &&
+	ls -1pR * >>actual &&
+	test_cmp expect actual &&
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
2.0.0.406.gf4dce28
