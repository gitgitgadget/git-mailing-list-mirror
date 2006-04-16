From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/9] Add a testsuite framework copied from git-core
Date: Sun, 16 Apr 2006 12:52:28 +0200
Message-ID: <20060416105228.9884.52480.stgit@gandelf.nowhere.earth>
References: <20060416104144.9884.28167.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 12:50:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FV4ph-0001Gt-Ia
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 12:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWDPKuP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 06:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWDPKuN
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 06:50:13 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:64178 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750705AbWDPKuL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 06:50:11 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 86FD75479C;
	Sun, 16 Apr 2006 12:50:09 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FV4yo-0004AH-CJ; Sun, 16 Apr 2006 12:59:46 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20060416104144.9884.28167.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18779>


See git's t/README for details on how to use this framework.

There is no integration yet in the toplevel Makefile, I'll let
python masters take care of this.  Use "make -C t" to run the
tests for now.

A patch-naming policy should be defined for stgit, since the
git one does not apply.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 TODO             |    2 -
 t/Makefile       |   25 ++++++
 t/README         |  210 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t0000-dummy.sh |   17 ++++
 t/test-lib.sh    |  203 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 456 insertions(+), 1 deletions(-)

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
diff --git a/t/README b/t/README
new file mode 100644
index 0000000..d88bad2
--- /dev/null
+++ b/t/README
@@ -0,0 +1,210 @@
+Core GIT Tests
+==============
+
+This directory holds many test scripts for core GIT tools.  The
+first part of this short document describes how to run the tests
+and read their output.
+
+When fixing the tools or adding enhancements, you are strongly
+encouraged to add tests in this directory to cover what you are
+trying to fix or enhance.  The later part of this short document
+describes how your test scripts should be organized.
+
+The mechanism that powers this testsuite is directly imported from the
+Core GIT Tests, in directory t/ of the git repository.  Files are base
+on Core GIT version 1.3.0.rc4.g5069.
+
+
+Running Tests
+-------------
+
+The easiest way to run tests is to say "make -C t".  This runs all
+the tests.
+
+    *** t0000-basic.sh ***
+    *   ok 1: .git/objects should be empty after git-init-db in an empty repo.
+    *   ok 2: .git/objects should have 256 subdirectories.
+    *   ok 3: git-update-index without --add should fail adding.
+    ...
+    *   ok 23: no diff after checkout and git-update-index --refresh.
+    * passed all 23 test(s)
+    *** t0100-environment-names.sh ***
+    *   ok 1: using old names should issue warnings.
+    *   ok 2: using old names but having new names should not issue warnings.
+    ...
+
+Or you can run each test individually from command line, like
+this:
+
+    $ sh ./t3001-ls-files-killed.sh
+    *   ok 1: git-update-index --add to add various paths.
+    *   ok 2: git-ls-files -k to show killed files.
+    *   ok 3: validate git-ls-files -k output.
+    * passed all 3 test(s)
+
+You can pass --verbose (or -v), --debug (or -d), and --immediate
+(or -i) command line argument to the test.
+
+--verbose::
+	This makes the test more verbose.  Specifically, the
+	command being run and their output if any are also
+	output.
+
+--debug::
+	This may help the person who is developing a new test.
+	It causes the command defined with test_debug to run.
+
+--immediate::
+	This causes the test to immediately exit upon the first
+	failed test.
+
+
+Naming Tests
+------------
+
+The test files are named as:
+
+	tNNNN-commandname-details.sh
+
+where N is a decimal digit.
+
+Here is a proposal for numbering, loosely based on the Core GIT
+numbering conventions.
+
+First two digit tells the particular command we are testing:
+
+	00 - stgit itself
+	10 - branch
+	11 - clone
+	12 - push
+
+Third and fourth digit (optionally) tells the particular switch or
+group of switches we are testing.
+
+If you create files under t/ directory (i.e. here) that is not
+the top-level test script, never name the file to match the above
+pattern.  The Makefile here considers all such files as the
+top-level test script and tries to run all of them.  A care is
+especially needed if you are creating a common test library
+file, similar to test-lib.sh, because such a library file may
+not be suitable for standalone execution.
+
+
+Writing Tests
+-------------
+
+The test script is written as a shell script.  It should start
+with the standard "#!/bin/sh" with copyright notices, and an
+assignment to variable 'test_description', like this:
+
+	#!/bin/sh
+	#
+	# Copyright (c) 2005 Junio C Hamano
+	#
+
+	test_description='xxx test (option --frotz)
+
+	This test registers the following structure in the cache
+	and tries to run git-ls-files with option --frotz.'
+
+
+Source 'test-lib.sh'
+--------------------
+
+After assigning test_description, the test script should source
+test-lib.sh like this:
+
+	. ./test-lib.sh
+
+This test harness library does the following things:
+
+ - If the script is invoked with command line argument --help
+   (or -h), it shows the test_description and exits.
+
+ - Creates an empty test directory with an empty .git/objects
+   database and chdir(2) into it.  This directory is 't/trash'
+   if you must know, but I do not think you care.
+
+ - Defines standard test helper functions for your scripts to
+   use.  These functions are designed to make all scripts behave
+   consistently when command line arguments --verbose (or -v),
+   --debug (or -d), and --immediate (or -i) is given.
+
+
+End with test_done
+------------------
+
+Your script will be a sequence of tests, using helper functions
+from the test harness library.  At the end of the script, call
+'test_done'.
+
+
+Test harness library
+--------------------
+
+There are a handful helper functions defined in the test harness
+library for your script to use.
+
+ - test_expect_success <message> <script>
+
+   This takes two strings as parameter, and evaluates the
+   <script>.  If it yields success, test is considered
+   successful.  <message> should state what it is testing.
+
+   Example:
+
+	test_expect_success \
+	    'git-write-tree should be able to write an empty tree.' \
+	    'tree=$(git-write-tree)'
+
+ - test_expect_failure <message> <script>
+
+   This is the opposite of test_expect_success.  If <script>
+   yields success, test is considered a failure.
+
+   Example:
+
+	test_expect_failure \
+	    'git-update-index without --add should fail adding.' \
+	    'git-update-index should-be-empty'
+
+ - test_debug <script>
+
+   This takes a single argument, <script>, and evaluates it only
+   when the test script is started with --debug command line
+   argument.  This is primarily meant for use during the
+   development of a new test script.
+
+ - test_done
+
+   Your test script must have test_done at the end.  Its purpose
+   is to summarize successes and failures in the test script and
+   exit with an appropriate error code.
+
+
+Tips for Writing Tests
+----------------------
+
+As with any programming projects, existing programs are the best
+source of the information.  However, do _not_ emulate
+t0000-basic.sh when writing your tests.  The test is special in
+that it tries to validate the very core of GIT.  For example, it
+knows that there will be 256 subdirectories under .git/objects/,
+and it knows that the object ID of an empty tree is a certain
+40-byte string.  This is deliberately done so in t0000-basic.sh
+because the things the very basic core test tries to achieve is
+to serve as a basis for people who are changing the GIT internal
+drastically.  For these people, after making certain changes,
+not seeing failures from the basic test _is_ a failure.  And
+such drastic changes to the core GIT that even changes these
+otherwise supposedly stable object IDs should be accompanied by
+an update to t0000-basic.sh.
+
+However, other tests that simply rely on basic parts of the core
+GIT working properly should not have that level of intimate
+knowledge of the core GIT internals.  If all the test scripts
+hardcoded the object IDs like t0000-basic.sh does, that defeats
+the purpose of t0000-basic.sh, which is to isolate that level of
+validation in one place.  Your test also ends up needing
+updating when such a change to the internal happens, so do _not_
+do it and leave the low level of validation to t0000-basic.sh.
diff --git a/t/t0000-dummy.sh b/t/t0000-dummy.sh
new file mode 100755
index 0000000..1a9bd87
--- /dev/null
+++ b/t/t0000-dummy.sh
@@ -0,0 +1,17 @@
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
+test_expect_success \
+    'check stgit can be run' \
+    'stg version'
+
+test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
new file mode 100755
index 0000000..6339c54
--- /dev/null
+++ b/t/test-lib.sh
@@ -0,0 +1,203 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+# Copyright (c) 2006 Yann Dirson - tuning for stgit
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
+	echo "empty start" |
+	git-commit-tree `git-write-tree` >.git/refs/heads/master 2>/dev/null ||
+	error "cannot run git-commit -- is your git-core funtionning?"
+	cd "$owd"
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
