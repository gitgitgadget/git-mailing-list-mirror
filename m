From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH] Update test-lib.sh from current git.
Date: Thu, 14 Jun 2007 23:15:27 +0200
Message-ID: <20070614211527.7877.62502.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 23:15:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hywf5-0006Or-TX
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 23:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbXFNVPW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 17:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbXFNVPW
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 17:15:22 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:37883 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbXFNVPV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 17:15:21 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id C27155A246;
	Thu, 14 Jun 2007 23:15:19 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id D5D801F08A;
	Thu, 14 Jun 2007 23:15:27 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50220>

Updated with changes to git up to rev
664368886781b7c070233c002597b84628eec571, including:

* GIT_SKIP_TESTS support, useful to run the testsuite bypassing tests
known to fail
* test_tick utility function to forge realistic commit dates
* deprecation of git-init-db in favor of git-init
* more environment safety cleanups

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 t/test-lib.sh |  128 ++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 107 insertions(+), 21 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
old mode 100755
new mode 100644
index d50a3ba..4bb00fb
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -10,11 +10,14 @@ LC_ALL=C
 PAGER=cat
 TZ=UTC
 export LANG LC_ALL PAGER TZ
+EDITOR=:
+VISUAL=:
 unset AUTHOR_DATE
 unset AUTHOR_EMAIL
 unset AUTHOR_NAME
 unset COMMIT_AUTHOR_EMAIL
 unset COMMIT_AUTHOR_NAME
+unset EMAIL
 unset GIT_ALTERNATE_OBJECT_DIRECTORIES
 unset GIT_AUTHOR_DATE
 #GIT_AUTHOR_EMAIL=author@example.com
@@ -29,8 +32,24 @@ unset GIT_INDEX_FILE
 unset GIT_OBJECT_DIRECTORY
 unset SHA1_FILE_DIRECTORIES
 unset SHA1_FILE_DIRECTORY
+GIT_MERGE_VERBOSITY=5
+export GIT_MERGE_VERBOSITY
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
+export EDITOR VISUAL
+
+# Protect ourselves from common misconfiguration to export
+# CDPATH into the environment
+unset CDPATH
+
+case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
+	1|2|true)
+		echo "* warning: Some tests will not work if GIT_TRACE" \
+			"is set as to trace on STDERR ! *"
+		echo "* warning: Please set GIT_TRACE to something" \
+			"other than 1, 2 or true ! *"
+		;;
+esac
 
 # Each test should start with something like this, after copyright notices:
 #
@@ -83,6 +102,17 @@ test_count=0
 
 trap 'echo >&5 "FATAL: Unexpected exit with code $?"; exit 1' exit
 
+test_tick () {
+	if test -z "${test_tick+set}"
+	then
+		test_tick=1112911993
+	else
+		test_tick=$(($test_tick + 60))
+	fi
+	GIT_COMMITTER_DATE="$test_tick -0700"
+	GIT_AUTHOR_DATE="$test_tick -0700"
+	export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
+}
 
 # You are not expected to call test_ok_ and test_failure_ directly, use
 # the text_expect_* functions instead.
@@ -112,43 +142,79 @@ test_run_ () {
 	return 0
 }
 
+test_skip () {
+	this_test=$(expr "./$0" : '.*/\(t[0-9]*\)-[^/]*$')
+	this_test="$this_test.$(expr "$test_count" + 1)"
+	to_skip=
+	for skp in $GIT_SKIP_TESTS
+	do
+		case "$this_test" in
+		$skp)
+			to_skip=t
+		esac
+	done
+	case "$to_skip" in
+	t)
+		say >&3 "skipping test: $@"
+		test_count=$(expr "$test_count" + 1)
+		say "skip $test_count: $1"
+		: true
+		;;
+	*)
+		false
+		;;
+	esac
+}
+
 test_expect_failure () {
 	test "$#" = 2 ||
 	error "bug in the test script: not 2 parameters to test-expect-failure"
-	say >&3 "expecting failure: $2"
-	test_run_ "$2"
-	if [ "$?" = 0 -a "$eval_ret" != 0 ]
+	if ! test_skip "$@"
 	then
-		test_ok_ "$1"
-	else
-		test_failure_ "$@"
+		say >&3 "expecting failure: $2"
+		test_run_ "$2"
+		if [ "$?" = 0 -a "$eval_ret" != 0 -a "$eval_ret" -lt 129 ]
+		then
+			test_ok_ "$1"
+		else
+			test_failure_ "$@"
+		fi
 	fi
+	echo >&3 ""
 }
 
 test_expect_success () {
 	test "$#" = 2 ||
 	error "bug in the test script: not 2 parameters to test-expect-success"
-	say >&3 "expecting success: $2"
-	test_run_ "$2"
-	if [ "$?" = 0 -a "$eval_ret" = 0 ]
+	if ! test_skip "$@"
 	then
-		test_ok_ "$1"
-	else
-		test_failure_ "$@"
+		say >&3 "expecting success: $2"
+		test_run_ "$2"
+		if [ "$?" = 0 -a "$eval_ret" = 0 ]
+		then
+			test_ok_ "$1"
+		else
+			test_failure_ "$@"
+		fi
 	fi
+	echo >&3 ""
 }
 
 test_expect_code () {
 	test "$#" = 3 ||
 	error "bug in the test script: not 3 parameters to test-expect-code"
-	say >&3 "expecting exit code $1: $3"
-	test_run_ "$3"
-	if [ "$?" = 0 -a "$eval_ret" = "$1" ]
+	if ! test_skip "$@"
 	then
-		test_ok_ "$2"
-	else
-		test_failure_ "$@"
+		say >&3 "expecting exit code $1: $3"
+		test_run_ "$3"
+		if [ "$?" = 0 -a "$eval_ret" = "$1" ]
+		then
+			test_ok_ "$2"
+		else
+			test_failure_ "$@"
+		fi
 	fi
+	echo >&3 ""
 }
 
 # Most tests can use the created repository, but some amy need to create more.
@@ -160,8 +226,8 @@ test_create_repo () {
 	repo="$1"
 	mkdir "$repo"
 	cd "$repo" || error "Cannot setup test environment"
-	git-init-db >&3 2>&4 ||
-	error "cannot run git-init-db -- have you installed git-core?"
+	git-init >/dev/null 2>&1 ||
+	error "cannot run git-init -- have you installed git-core?"
 	mv .git/hooks .git/hooks-disabled
 	echo "empty start" |
 	git-commit-tree `git-write-tree` >.git/refs/heads/master 2>&4 ||
@@ -195,7 +261,8 @@ test_done () {
 # t/ subdirectory and are run in trash subdirectory.
 PATH=$(pwd)/..:$PATH
 HOME=$(pwd)/trash
-export PATH HOME
+GIT_CONFIG=.git/config
+export PATH HOME GIT_CONFIG
 
 
 # Test repository
@@ -203,3 +270,22 @@ test=trash
 rm -fr "$test"
 test_create_repo $test
 cd "$test"
+
+this_test=$(expr "./$0" : '.*/\(t[0-9]*\)-[^/]*$')
+for skp in $GIT_SKIP_TESTS
+do
+	to_skip=
+	for skp in $GIT_SKIP_TESTS
+	do
+		case "$this_test" in
+		$skp)
+			to_skip=t
+		esac
+	done
+	case "$to_skip" in
+	t)
+		say >&3 "skipping test $this_test altogether"
+		say "skip all tests in $this_test"
+		test_done
+	esac
+done
