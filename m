From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 16/16] Introduce portable_unset and use it to ensure proper && chaining
Date: Sun,  3 Oct 2010 14:00:14 -0600
Message-ID: <1286136014-7728-17-git-send-email-newren@gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 21:59:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Uig-0002yx-Pg
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 21:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754945Ab0JCT72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 15:59:28 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58678 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920Ab0JCT7W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 15:59:22 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so946630pwj.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 12:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pAqtvxsjQO23n8kPo0q0CXu5U1pdP54vpFpyOuR2J1M=;
        b=bneNdiWmM8YJxfD8ElY4bIUoL2NRvTQduUSNC6rSSEjpJ1EsIqLXWE3zOMnGV5Aw//
         DTL70H7uKGTsC+6T8+0PF+makgRUgKDZn0r9ZWFMj7pEDrATw8ZLWIa9Ci/0uhYgLVFl
         xeNeceCp8LAFYZgUW8SiKl9IttROtz7lAcnY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=N2QPD0rhwxAmBMy84jmC+IyvFc4Ns9PJQV349Z9t3wZBr638zh4V18boxJBTL9LjGz
         plkaN1p649jtamcnpakd2kV8KW7pV0bbIm9kUjt2pK5Jk0+cXk0CpBHWPaO5/avXTkfb
         ivIILk7HygfgiqN1d6bbMnqkPl/gON44UCiiE=
Received: by 10.114.131.19 with SMTP id e19mr10069172wad.147.1286135962342;
        Sun, 03 Oct 2010 12:59:22 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id d2sm7661138wam.14.2010.10.03.12.59.19
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 12:59:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286136014-7728-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157910>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/README          |   13 +++++--------
 t/t0001-init.sh   |   28 ++++++++++++++--------------
 t/t7006-pager.sh  |   10 +++++-----
 t/t7502-commit.sh |    4 ++--
 t/test-lib.sh     |   11 +++++++++++
 5 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/t/README b/t/README
index ee4c0cf..e10c0ce 100644
--- a/t/README
+++ b/t/README
@@ -259,14 +259,11 @@ Do:
 	test ...
 
    That way all of the commands in your tests will succeed or fail. If
-   you must ignore the return value of something (e.g., the return
-   after unsetting a variable that was already unset is unportable) it's
-   best to indicate so explicitly with a semicolon:
-
-	unset HLAGH;
-	git merge hla &&
-	git push gh &&
-	test ...
+   you must ignore the return value of something, consider using a
+   helper function (e.g. use portable_unset instead of unset, in order
+   to avoid unportable return value for unsetting a variable that was
+   already unset), or prepending the command with test_might_fail or
+   test_must_fail.
 
  - Check the test coverage for your tests. See the "Test coverage"
    below.
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 9d4539f..c1b6ac2 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -25,7 +25,7 @@ check_config () {
 
 test_expect_success 'plain' '
 	(
-		unset GIT_DIR GIT_WORK_TREE
+		portable_unset GIT_DIR GIT_WORK_TREE &&
 		mkdir plain &&
 		cd plain &&
 		git init
@@ -35,7 +35,7 @@ test_expect_success 'plain' '
 
 test_expect_success 'plain with GIT_WORK_TREE' '
 	if (
-		unset GIT_DIR
+		portable_unset GIT_DIR &&
 		mkdir plain-wt &&
 		cd plain-wt &&
 		GIT_WORK_TREE=$(pwd) git init
@@ -48,7 +48,7 @@ test_expect_success 'plain with GIT_WORK_TREE' '
 
 test_expect_success 'plain bare' '
 	(
-		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG
+		portable_unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
 		mkdir plain-bare-1 &&
 		cd plain-bare-1 &&
 		git --bare init
@@ -58,7 +58,7 @@ test_expect_success 'plain bare' '
 
 test_expect_success 'plain bare with GIT_WORK_TREE' '
 	if (
-		unset GIT_DIR GIT_CONFIG
+		portable_unset GIT_DIR GIT_CONFIG &&
 		mkdir plain-bare-2 &&
 		cd plain-bare-2 &&
 		GIT_WORK_TREE=$(pwd) git --bare init
@@ -72,7 +72,7 @@ test_expect_success 'plain bare with GIT_WORK_TREE' '
 test_expect_success 'GIT_DIR bare' '
 
 	(
-		unset GIT_CONFIG
+		portable_unset GIT_CONFIG &&
 		mkdir git-dir-bare.git &&
 		GIT_DIR=git-dir-bare.git git init
 	) &&
@@ -82,7 +82,7 @@ test_expect_success 'GIT_DIR bare' '
 test_expect_success 'init --bare' '
 
 	(
-		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG
+		portable_unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
 		mkdir init-bare.git &&
 		cd init-bare.git &&
 		git init --bare
@@ -93,7 +93,7 @@ test_expect_success 'init --bare' '
 test_expect_success 'GIT_DIR non-bare' '
 
 	(
-		unset GIT_CONFIG
+		portable_unset GIT_CONFIG &&
 		mkdir non-bare &&
 		cd non-bare &&
 		GIT_DIR=.git git init
@@ -104,7 +104,7 @@ test_expect_success 'GIT_DIR non-bare' '
 test_expect_success 'GIT_DIR & GIT_WORK_TREE (1)' '
 
 	(
-		unset GIT_CONFIG
+		portable_unset GIT_CONFIG &&
 		mkdir git-dir-wt-1.git &&
 		GIT_WORK_TREE=$(pwd) GIT_DIR=git-dir-wt-1.git git init
 	) &&
@@ -114,7 +114,7 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (1)' '
 test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
 
 	if (
-		unset GIT_CONFIG
+		portable_unset GIT_CONFIG &&
 		mkdir git-dir-wt-2.git &&
 		GIT_WORK_TREE=$(pwd) GIT_DIR=git-dir-wt-2.git git --bare init
 	)
@@ -127,7 +127,7 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
 test_expect_success 'reinit' '
 
 	(
-		unset GIT_CONFIG GIT_WORK_TREE GIT_CONFIG
+		portable_unset GIT_CONFIG GIT_WORK_TREE GIT_CONFIG &&
 
 		mkdir again &&
 		cd again &&
@@ -175,8 +175,8 @@ test_expect_success 'init with init.templatedir set' '
 		git config -f "$test_config"  init.templatedir "${HOME}/templatedir-source" &&
 		mkdir templatedir-set &&
 		cd templatedir-set &&
-		unset GIT_CONFIG_NOGLOBAL &&
-		unset GIT_TEMPLATE_DIR &&
+		portable_unset GIT_CONFIG_NOGLOBAL &&
+		portable_unset GIT_TEMPLATE_DIR &&
 		NO_SET_GIT_TEMPLATE_DIR=t &&
 		export NO_SET_GIT_TEMPLATE_DIR &&
 		git init
@@ -187,7 +187,7 @@ test_expect_success 'init with init.templatedir set' '
 test_expect_success 'init --bare/--shared overrides system/global config' '
 	(
 		test_config="$HOME"/.gitconfig &&
-		unset GIT_CONFIG_NOGLOBAL &&
+		portable_unset GIT_CONFIG_NOGLOBAL &&
 		git config -f "$test_config" core.bare false &&
 		git config -f "$test_config" core.sharedRepository 0640 &&
 		mkdir init-bare-shared-override &&
@@ -202,7 +202,7 @@ test_expect_success 'init --bare/--shared overrides system/global config' '
 test_expect_success 'init honors global core.sharedRepository' '
 	(
 		test_config="$HOME"/.gitconfig &&
-		unset GIT_CONFIG_NOGLOBAL &&
+		portable_unset GIT_CONFIG_NOGLOBAL &&
 		git config -f "$test_config" core.sharedRepository 0666 &&
 		mkdir shared-honor-global &&
 		cd shared-honor-global &&
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index fb744e3..4c5da2e 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -41,7 +41,7 @@ else
 fi
 
 test_expect_success 'setup' '
-	unset GIT_PAGER GIT_PAGER_IN_USE;
+	portable_unset GIT_PAGER GIT_PAGER_IN_USE &&
 	test_might_fail git config --unset core.pager &&
 
 	PAGER="cat >paginated.out" &&
@@ -254,7 +254,7 @@ test_default_pager() {
 	parse_args "$@"
 
 	$test_expectation SIMPLEPAGERTTY "$cmd - default pager is used by default" "
-		unset PAGER GIT_PAGER;
+		portable_unset PAGER GIT_PAGER &&
 		test_might_fail git config --unset core.pager &&
 		rm -f default_pager_used ||
 		cleanup_fail &&
@@ -277,7 +277,7 @@ test_PAGER_overrides() {
 	parse_args "$@"
 
 	$test_expectation TTY "$cmd - PAGER overrides default pager" "
-		unset GIT_PAGER;
+		portable_unset GIT_PAGER &&
 		test_might_fail git config --unset core.pager &&
 		rm -f PAGER_used ||
 		cleanup_fail &&
@@ -305,7 +305,7 @@ test_core_pager() {
 	parse_args "$@"
 
 	$test_expectation TTY "$cmd - repository-local core.pager setting $used_if_wanted" "
-		unset GIT_PAGER;
+		portable_unset GIT_PAGER &&
 		rm -f core.pager_used ||
 		cleanup_fail &&
 
@@ -333,7 +333,7 @@ test_pager_subdir_helper() {
 	parse_args "$@"
 
 	$test_expectation TTY "$cmd - core.pager $used_if_wanted from subdirectory" "
-		unset GIT_PAGER;
+		portable_unset GIT_PAGER &&
 		rm -f core.pager_used &&
 		rm -fr sub ||
 		cleanup_fail &&
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index b6b9802..028b101 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -252,8 +252,8 @@ test_expect_success 'committer is automatic' '
 
 	echo >>negative &&
 	(
-		unset GIT_COMMITTER_EMAIL
-		unset GIT_COMMITTER_NAME
+		portable_unset GIT_COMMITTER_EMAIL &&
+		portable_unset GIT_COMMITTER_NAME &&
 		# must fail because there is no change
 		test_must_fail git commit -e -m "sample"
 	) &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index d86edcd..b234c27 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -268,6 +268,17 @@ remove_cr () {
 	tr '\015' Q | sed -e 's/Q$//'
 }
 
+# In some bourne shell implementations, the "unset" builtin returns
+# nonzero status when a variable to be unset was not set in the first
+# place.
+#
+# Use portable_unset when that should not be considered an error.
+
+portable_unset () {
+	unset "$@"
+	return 0
+}
+
 test_tick () {
 	if test -z "${test_tick+set}"
 	then
-- 
1.7.3.1.66.gab790
