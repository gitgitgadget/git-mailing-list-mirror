From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/4] Add a testsuite framework copied from git-core
Date: Thu, 13 Apr 2006 23:44:24 +0200
Message-ID: <20060413214424.8806.84103.stgit@gandelf.nowhere.earth>
References: <20060413213819.8806.53300.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 23:42:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FU9Zz-0001hd-1e
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 23:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWDMVmP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 17:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWDMVmP
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 17:42:15 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:12210 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S964981AbWDMVmO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Apr 2006 17:42:14 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 5095E9AABA;
	Thu, 13 Apr 2006 23:42:13 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FU9j2-0008WQ-3g; Thu, 13 Apr 2006 23:51:40 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20060413213819.8806.53300.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18672>

From: Yann Dirson <ydirson@altern.org>

See git's t/README for details on how to use this framework.

There is no integration yet in the toplevel Makefile, I'll let
python masters take care of this.  Use "make -C t" to run the
tests for now.

A patch-naming policy should be defined for stgit, since the
git one does not apply.
---

 TODO             |    2 -
 t/Makefile       |   25 ++++++
 t/t0000-dummy.sh |   19 +++++
 t/test-lib.sh    |  208 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 253 insertions(+), 1 deletions(-)

diff --git a/TODO b/TODO
index e5affe0..d97ffd1 100644
--- a/TODO
+++ b/TODO
@@ -6,7 +6,7 @@ The TODO list until 1.0:
 - debian package support
 - man page
 - code execution allowed from templates
-- regression tests
+- more regression tests
 - release 1.0
 
 
diff --git a/t/Makefile b/t/Makefile
new file mode 100644
index 0000000..d5d7b6f
--- /dev/null
+++ b/t/Makefile
@@ -0,0 +1,25 @@
+# Run tests
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+#GIT_TEST_OPTS=--verbose --debug
+SHELL_PATH ?= $(SHELL)
+TAR ?= $(TAR)
+
+# Shell quote;
+SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
+
+T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
+
+all: $(T) clean
+
+$(T):
+	@echo "*** $@ ***"; '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
+
+clean:
+	rm -fr trash
+
+.PHONY: $(T) clean
+.NOPARALLEL:
+
diff --git a/t/t0000-dummy.sh b/t/t0000-dummy.sh
new file mode 100755
index 0000000..8dc25d3
--- /dev/null
+++ b/t/t0000-dummy.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Yann Dirson
+#
+
+test_description='Dummy test.
+
+Only to test the testing environment.
+'
+
+. ./test-lib.sh
+
+test_stg_init
+
+test_expect_success \
+    'check stgit can be run' \
+    'stg version'
+
+test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
new file mode 100755
index 0000000..2580bcc
--- /dev/null
+++ b/t/test-lib.sh
@@ -0,0 +1,208 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+# Copyright (c) 2006 Yann Dirson
+#
+
+# For repeatability, reset the environment to known value.
+LANG=C
+LC_ALL=C
+PAGER=cat
+TZ=UTC
+export LANG LC_ALL PAGER TZ
+unset AUTHOR_DATE
+unset AUTHOR_EMAIL
+unset AUTHOR_NAME
+unset COMMIT_AUTHOR_EMAIL
+unset COMMIT_AUTHOR_NAME
+unset GIT_ALTERNATE_OBJECT_DIRECTORIES
+unset GIT_AUTHOR_DATE
+GIT_AUTHOR_EMAIL=author@example.com
+GIT_AUTHOR_NAME='A U Thor'
+unset GIT_COMMITTER_DATE
+GIT_COMMITTER_EMAIL=committer@example.com
+GIT_COMMITTER_NAME='C O Mitter'
+unset GIT_DIFF_OPTS
+unset GIT_DIR
+unset GIT_EXTERNAL_DIFF
+unset GIT_INDEX_FILE
+unset GIT_OBJECT_DIRECTORY
+unset SHA1_FILE_DIRECTORIES
+unset SHA1_FILE_DIRECTORY
+export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
+export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
+
+# Each test should start with something like this, after copyright notices:
+#
+# test_description='Description of this test...
+# This test checks if command xyzzy does the right thing...
+# '
+# . ./test-lib.sh
+
+error () {
+	echo "* error: $*"
+	trap - exit
+	exit 1
+}
+
+say () {
+	echo "* $*"
+}
+
+test "${test_description}" != "" ||
+error "Test script did not set test_description."
+
+while test "$#" -ne 0
+do
+	case "$1" in
+	-d|--d|--de|--deb|--debu|--debug)
+		debug=t; shift ;;
+	-i|--i|--im|--imm|--imme|--immed|--immedi|--immedia|--immediat|--immediate)
+		immediate=t; shift ;;
+	-h|--h|--he|--hel|--help)
+		echo "$test_description"
+		exit 0 ;;
+	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
+		verbose=t; shift ;;
+	*)
+		break ;;
+	esac
+done
+
+exec 5>&1
+if test "$verbose" = "t"
+then
+	exec 4>&2 3>&1
+else
+	exec 4>/dev/null 3>/dev/null
+fi
+
+test_failure=0
+test_count=0
+
+trap 'echo >&5 "FATAL: Unexpected exit with code $?"; exit 1' exit
+
+
+# You are not expected to call test_ok_ and test_failure_ directly, use
+# the text_expect_* functions instead.
+
+test_ok_ () {
+	test_count=$(expr "$test_count" + 1)
+	say "  ok $test_count: $@"
+}
+
+test_failure_ () {
+	test_count=$(expr "$test_count" + 1)
+	test_failure=$(expr "$test_failure" + 1);
+	say "FAIL $test_count: $1"
+	shift
+	echo "$@" | sed -e 's/^/	/'
+	test "$immediate" = "" || { trap - exit; exit 1; }
+}
+
+
+test_debug () {
+	test "$debug" = "" || eval "$1"
+}
+
+test_run_ () {
+	eval >&3 2>&4 "$1"
+	eval_ret="$?"
+	return 0
+}
+
+test_expect_failure () {
+	test "$#" = 2 ||
+	error "bug in the test script: not 2 parameters to test-expect-failure"
+	say >&3 "expecting failure: $2"
+	test_run_ "$2"
+	if [ "$?" = 0 -a "$eval_ret" != 0 ]
+	then
+		test_ok_ "$1"
+	else
+		test_failure_ "$@"
+	fi
+}
+
+test_expect_success () {
+	test "$#" = 2 ||
+	error "bug in the test script: not 2 parameters to test-expect-success"
+	say >&3 "expecting success: $2"
+	test_run_ "$2"
+	if [ "$?" = 0 -a "$eval_ret" = 0 ]
+	then
+		test_ok_ "$1"
+	else
+		test_failure_ "$@"
+	fi
+}
+
+test_expect_code () {
+	test "$#" = 3 ||
+	error "bug in the test script: not 3 parameters to test-expect-code"
+	say >&3 "expecting exit code $1: $3"
+	test_run_ "$3"
+	if [ "$?" = 0 -a "$eval_ret" = "$1" ]
+	then
+		test_ok_ "$2"
+	else
+		test_failure_ "$@"
+	fi
+}
+
+# Most tests can use the created repository, but some amy need to create more.
+# Usage: test_create_repo <directory>
+test_create_repo () {
+	test "$#" = 1 ||
+	error "bug in the test script: not 1 parameter to test-create-repo"
+	owd=`pwd`
+	repo="$1"
+	mkdir "$repo"
+	cd "$repo" || error "Cannot setup test environment"
+	git-init-db 2>/dev/null ||
+	error "cannot run git-init-db -- have you installed git-core?"
+	mv .git/hooks .git/hooks-disabled
+	cd "$owd"
+}
+
+test_stg_init () {
+	echo "empty start" |
+	git-commit-tree `git-write-tree` >.git/refs/heads/master 2>/dev/null ||
+	error "cannot run git-commit -- is your git-core funtionning?"
+	stg init ||
+	error "cannot run stg init -- have you built things yet?"
+}
+
+test_done () {
+	trap - exit
+	case "$test_failure" in
+	0)
+		# We could:
+		# cd .. && rm -fr trash
+		# but that means we forbid any tests that use their own
+		# subdirectory from calling test_done without coming back
+		# to where they started from.
+		# The Makefile provided will clean this test area so
+		# we will leave things as they are.
+
+		say "passed all $test_count test(s)"
+		exit 0 ;;
+
+	*)
+		say "failed $test_failure among $test_count test(s)"
+		exit 1 ;;
+
+	esac
+}
+
+# Test the binaries we have just built.  The tests are kept in
+# t/ subdirectory and are run in trash subdirectory.
+PATH=$(pwd)/..:$PATH
+export PATH
+
+
+# Test repository
+test=trash
+rm -fr "$test"
+test_create_repo $test
+cd "$test"
