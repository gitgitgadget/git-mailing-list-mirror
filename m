From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: [PATCH 3/3] test-lib: '--run' to run only specific tests
Date: Wed, 30 Apr 2014 02:50:44 -0700
Message-ID: <1398851444-2492-4-git-send-email-ilya.bobyr@gmail.com>
References: <1398154767-1276-1-git-send-email-ilya.bobyr@gmail.com>
 <1398851444-2492-1-git-send-email-ilya.bobyr@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Ilya Bobyr <ilya.bobyr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 11:51:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfRAb-000361-5t
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 11:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964AbaD3JvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 05:51:13 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:44376 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbaD3JvK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 05:51:10 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so1470753pdj.32
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 02:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Fx6bu8msA6ih3WmcxDS7one9JxgBJ7IKVvc2YcCJ2I=;
        b=o1j5Z2rDrlwDhKX+OVUs+UkSa9Dwtj5Gex0cGLShaB3c8fSoIDGml9N4bRA6AtmdyE
         lAnH+UCZ+BkEVFmV/ztYkj+9uRC7/VhW26zTuZ15pW2h1TSeubXHqMSWIJGrgCEtg3y6
         dYVfYFcXx6xjqDvvLMuIZ5fMB/HMSH93Yjm69SBeGPx8pjNi4vs00GeWMPsnq8KFGuSq
         ryPqsrwuN8a+xWAldq1myTBtir298f/+goh94KVfKiafh6ZMw0GN1Mm1aYOgNSigSws1
         PCUxtIAN43mxuMM85kBx5HqfhzW1DO7VyOnYUXg6kpiOfw3KYfpp04ZyFaciyATH9XJC
         oZ9A==
X-Received: by 10.66.189.106 with SMTP id gh10mr6740623pac.31.1398851469378;
        Wed, 30 Apr 2014 02:51:09 -0700 (PDT)
Received: from localhost.localdomain (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id ss2sm131761603pab.8.2014.04.30.02.51.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 02:51:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1398851444-2492-1-git-send-email-ilya.bobyr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247692>

Allow better control of the set of tests that will be executed for a
single test suite.  Mostly useful while debugging or developing as it
allows to focus on a specific test.

Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
---
A number of minor changes according to the review comments.

 t/README         |   81 ++++++++++++-
 t/t0000-basic.sh |  356 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 t/test-lib.sh    |  108 ++++++++++++++++
 3 files changed, 537 insertions(+), 8 deletions(-)

diff --git a/t/README b/t/README
index eaf6ecd..cd99d21 100644
--- a/t/README
+++ b/t/README
@@ -104,6 +104,12 @@ appropriately before running "make".
 	This causes additional long-running tests to be run (where
 	available), for more exhaustive testing.
 
+-r::
+--run=<test-selector>::
+	Run only the subset of tests indicated by
+	<test-selector>.  See section "Skipping Tests" below for
+	<test-selector> syntax.
+
 --valgrind=<tool>::
 	Execute all Git binaries under valgrind tool <tool> and exit
 	with status 126 on errors (just like regular tests, this will
@@ -191,10 +197,77 @@ and either can match the "t[0-9]{4}" part to skip the whole
 test, or t[0-9]{4} followed by ".$number" to say which
 particular test to skip.
 
-Note that some tests in the existing test suite rely on previous
-test item, so you cannot arbitrarily disable one and expect the
-remainder of test to check what the test originally was intended
-to check.
+For an individual test suite --run could be used to specify that
+only some tests should be run or that some tests should be
+excluded from a run.
+
+The argument for --run is a list of individual test numbers or
+ranges with an optional negation prefix that define what tests in
+a test suite to include in the run.  A range is two numbers
+separated with a dash and matches a range of tests with both ends
+been included.  You may omit the first or the second number to
+mean "from the first test" or "up to the very last test"
+respectively.
+
+Optional prefix of '!' means that the test or a range of tests
+should be excluded from the run.
+
+If --run starts with an unprefixed number or range the initial
+set of tests to run is empty. If the first item starts with '!'
+all the tests are added to the initial set.  After initial set is
+determined every test number or range is added or excluded from
+the set one by one, from left to right.
+
+Individual numbers or ranges could be separated either by a space
+or a comma.
+
+For example, to run only tests up to a specific test (21), one
+could do this:
+
+    $ sh ./t9200-git-cvsexport-commit.sh --run='1-21'
+
+or this:
+
+    $ sh ./t9200-git-cvsexport-commit.sh --run='-21'
+
+Common case is to run several setup tests (1, 2, 3) and then a
+specific test (21) that relies on that setup:
+
+    $ sh ./t9200-git-cvsexport-commit.sh --run='1 2 3 21'
+
+or:
+
+    $ sh ./t9200-git-cvsexport-commit.sh --run=1,2,3,21
+
+or:
+
+    $ sh ./t9200-git-cvsexport-commit.sh --run='-3 21'
+
+As noted above, the test set is built going though items left to
+right, so this:
+
+    $ sh ./t9200-git-cvsexport-commit.sh --run='1-4 !3'
+
+will run tests 1, 2, and 4.  Items that comes later have higher
+precendence.  It means that this:
+
+    $ sh ./t9200-git-cvsexport-commit.sh --run='!3 1-4'
+
+would just run tests from 1 to 4, including 3.
+
+You may use negation with ranges.  The following will run all
+test in the test suite except from 7 up to 11:
+
+    $ sh ./t9200-git-cvsexport-commit.sh --run='!7-11'
+
+Some tests in a test suite rely on the previous tests performing
+certain actions, specifically some tests are designated as
+"setup" test, so you cannot _arbitrarily_ disable one test and
+expect the rest to function correctly.
+
+--run is mostly useful when you want to focus on a specific test
+and know what setup is needed for it.  Or when you want to run
+everything up to a certain test.
 
 
 Naming Tests
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index ae8874e..8345c8a 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -42,9 +42,9 @@ test_expect_success 'success is reported like this' '
 	:
 '
 
-run_sub_test_lib_test () {
-	name="$1" descr="$2" # stdin is the body of the test code
-	shift 2
+_run_sub_test_lib_test_common () {
+	neg="$1" name="$2" descr="$3" # stdin is the body of the test code
+	shift 3
 	mkdir "$name" &&
 	(
 		# Pretend we're not running under a test harness, whether we
@@ -70,10 +70,23 @@ run_sub_test_lib_test () {
 		export TEST_DIRECTORY &&
 		TEST_OUTPUT_DIRECTORY=$(pwd) &&
 		export TEST_OUTPUT_DIRECTORY &&
-		./"$name.sh" "$@" >out 2>err
+		if test -z "$neg"
+		then
+			./"$name.sh" "$@" >out 2>err
+		else
+			!  ./"$name.sh" "$@" >out 2>err
+		fi
 	)
 }
 
+run_sub_test_lib_test () {
+	_run_sub_test_lib_test_common '' "$@"
+}
+
+run_sub_test_lib_test_err () {
+	_run_sub_test_lib_test_common '!' "$@"
+}
+
 check_sub_test_lib_test () {
 	name="$1" # stdin is the expected output from the test
 	(
@@ -84,6 +97,18 @@ check_sub_test_lib_test () {
 	)
 }
 
+check_sub_test_lib_test_err () {
+	name="$1" # stdin is the expected output output from the test
+	# expected error output is in descriptior 3
+	(
+		cd "$name" &&
+		sed -e 's/^> //' -e 's/Z$//' >expect.out &&
+		test_cmp expect.out out &&
+		sed -e 's/^> //' -e 's/Z$//' <&3 >expect.err &&
+		test_cmp expect.err err
+	)
+}
+
 test_expect_success 'pretend we have a fully passing test suite' "
 	run_sub_test_lib_test full-pass '3 passing tests' <<-\\EOF &&
 	for i in 1 2 3
@@ -333,6 +358,329 @@ test_expect_success 'GIT_SKIP_TESTS sh pattern' "
 	EOF
 "
 
+test_expect_success '--run basic' "
+	run_sub_test_lib_test run-basic \
+		'--run basic' --run='1 3 5' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test run-basic <<-\\EOF
+	> ok 1 - passing test #1
+	> ok 2 # skip passing test #2 (--run)
+	> ok 3 - passing test #3
+	> ok 4 # skip passing test #4 (--run)
+	> ok 5 - passing test #5
+	> ok 6 # skip passing test #6 (--run)
+	> # passed all 6 test(s)
+	> 1..6
+	EOF
+"
+
+test_expect_success '--run with a range' "
+	run_sub_test_lib_test run-range \
+		'--run with a range' --run='1-3' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test run-range <<-\\EOF
+	> ok 1 - passing test #1
+	> ok 2 - passing test #2
+	> ok 3 - passing test #3
+	> ok 4 # skip passing test #4 (--run)
+	> ok 5 # skip passing test #5 (--run)
+	> ok 6 # skip passing test #6 (--run)
+	> # passed all 6 test(s)
+	> 1..6
+	EOF
+"
+
+test_expect_success '--run with two ranges' "
+	run_sub_test_lib_test run-two-ranges \
+		'--run with two ranges' --run='1-2 5-6' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test run-two-ranges <<-\\EOF
+	> ok 1 - passing test #1
+	> ok 2 - passing test #2
+	> ok 3 # skip passing test #3 (--run)
+	> ok 4 # skip passing test #4 (--run)
+	> ok 5 - passing test #5
+	> ok 6 - passing test #6
+	> # passed all 6 test(s)
+	> 1..6
+	EOF
+"
+
+test_expect_success '--run with a left open range' "
+	run_sub_test_lib_test run-left-open-range \
+		'--run with a left open range' --run='-3' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test run-left-open-range <<-\\EOF
+	> ok 1 - passing test #1
+	> ok 2 - passing test #2
+	> ok 3 - passing test #3
+	> ok 4 # skip passing test #4 (--run)
+	> ok 5 # skip passing test #5 (--run)
+	> ok 6 # skip passing test #6 (--run)
+	> # passed all 6 test(s)
+	> 1..6
+	EOF
+"
+
+test_expect_success '--run with a right open range' "
+	run_sub_test_lib_test run-right-open-range \
+		'--run with a right open range' --run='4-' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test run-right-open-range <<-\\EOF
+	> ok 1 # skip passing test #1 (--run)
+	> ok 2 # skip passing test #2 (--run)
+	> ok 3 # skip passing test #3 (--run)
+	> ok 4 - passing test #4
+	> ok 5 - passing test #5
+	> ok 6 - passing test #6
+	> # passed all 6 test(s)
+	> 1..6
+	EOF
+"
+
+test_expect_success '--run with basic negation' "
+	run_sub_test_lib_test run-basic-neg \
+		'--run with basic negation' --run='"'!3'"' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test run-basic-neg <<-\\EOF
+	> ok 1 - passing test #1
+	> ok 2 - passing test #2
+	> ok 3 # skip passing test #3 (--run)
+	> ok 4 - passing test #4
+	> ok 5 - passing test #5
+	> ok 6 - passing test #6
+	> # passed all 6 test(s)
+	> 1..6
+	EOF
+"
+
+test_expect_success '--run with two negations' "
+	run_sub_test_lib_test run-two-neg \
+		'--run with two negations' --run='"'!3 !6'"' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test run-two-neg <<-\\EOF
+	> ok 1 - passing test #1
+	> ok 2 - passing test #2
+	> ok 3 # skip passing test #3 (--run)
+	> ok 4 - passing test #4
+	> ok 5 - passing test #5
+	> ok 6 # skip passing test #6 (--run)
+	> # passed all 6 test(s)
+	> 1..6
+	EOF
+"
+
+test_expect_success '--run a range and negation' "
+	run_sub_test_lib_test run-range-and-neg \
+		'--run a range and negation' --run='"'-4 !2'"' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test run-range-and-neg <<-\\EOF
+	> ok 1 - passing test #1
+	> ok 2 # skip passing test #2 (--run)
+	> ok 3 - passing test #3
+	> ok 4 - passing test #4
+	> ok 5 # skip passing test #5 (--run)
+	> ok 6 # skip passing test #6 (--run)
+	> # passed all 6 test(s)
+	> 1..6
+	EOF
+"
+
+test_expect_success '--run range negation' "
+	run_sub_test_lib_test run-range-neg \
+		'--run range negation' --run='"'!1-3'"' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test run-range-neg <<-\\EOF
+	> ok 1 # skip passing test #1 (--run)
+	> ok 2 # skip passing test #2 (--run)
+	> ok 3 # skip passing test #3 (--run)
+	> ok 4 - passing test #4
+	> ok 5 - passing test #5
+	> ok 6 - passing test #6
+	> # passed all 6 test(s)
+	> 1..6
+	EOF
+"
+
+test_expect_success '--run include, exclude and include' "
+	run_sub_test_lib_test run-inc-neg-inc \
+		'--run include, exclude and include' \
+		--run='"'1-5 !1-3 2'"' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test run-inc-neg-inc <<-\\EOF
+	> ok 1 # skip passing test #1 (--run)
+	> ok 2 - passing test #2
+	> ok 3 # skip passing test #3 (--run)
+	> ok 4 - passing test #4
+	> ok 5 - passing test #5
+	> ok 6 # skip passing test #6 (--run)
+	> # passed all 6 test(s)
+	> 1..6
+	EOF
+"
+
+test_expect_success '--run include, exclude and include, comma separated' "
+	run_sub_test_lib_test run-inc-neg-inc-comma \
+		'--run include, exclude and include, comma separated' \
+		--run=1-5,\!1-3,2 <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test run-inc-neg-inc-comma <<-\\EOF
+	> ok 1 # skip passing test #1 (--run)
+	> ok 2 - passing test #2
+	> ok 3 # skip passing test #3 (--run)
+	> ok 4 - passing test #4
+	> ok 5 - passing test #5
+	> ok 6 # skip passing test #6 (--run)
+	> # passed all 6 test(s)
+	> 1..6
+	EOF
+"
+
+test_expect_success '--run exclude and include' "
+	run_sub_test_lib_test run-neg-inc \
+		'--run exclude and include' \
+		--run='"'!3- 5'"' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test run-neg-inc <<-\\EOF
+	> ok 1 - passing test #1
+	> ok 2 - passing test #2
+	> ok 3 # skip passing test #3 (--run)
+	> ok 4 # skip passing test #4 (--run)
+	> ok 5 - passing test #5
+	> ok 6 # skip passing test #6 (--run)
+	> # passed all 6 test(s)
+	> 1..6
+	EOF
+"
+
+test_expect_success '--run empty selectors' "
+	run_sub_test_lib_test run-empty-sel \
+		'--run empty selectors' \
+		--run='1,,3,,,5' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test run-empty-sel <<-\\EOF
+	> ok 1 - passing test #1
+	> ok 2 # skip passing test #2 (--run)
+	> ok 3 - passing test #3
+	> ok 4 # skip passing test #4 (--run)
+	> ok 5 - passing test #5
+	> ok 6 # skip passing test #6 (--run)
+	> # passed all 6 test(s)
+	> 1..6
+	EOF
+"
+
+test_expect_success '--run invalid range start' "
+	run_sub_test_lib_test_err run-inv-range-start \
+		'--run invalid range start' \
+		--run='a-5' <<-\\EOF &&
+	test_expect_success \"passing test #1\" 'true'
+	test_done
+	EOF
+	check_sub_test_lib_test_err run-inv-range-start \
+		<<-\\EOF_OUT 3<<-\\EOF_ERR
+	> FATAL: Unexpected exit with code 1
+	EOF_OUT
+	> error: --run: invalid non-numeric in range start: 'a-5'
+	EOF_ERR
+"
+
+test_expect_success '--run invalid range end' "
+	run_sub_test_lib_test_err run-inv-range-end \
+		'--run invalid range end' \
+		--run='1-z' <<-\\EOF &&
+	test_expect_success \"passing test #1\" 'true'
+	test_done
+	EOF
+	check_sub_test_lib_test_err run-inv-range-end \
+		<<-\\EOF_OUT 3<<-\\EOF_ERR
+	> FATAL: Unexpected exit with code 1
+	EOF_OUT
+	> error: --run: invalid non-numeric in range end: '1-z'
+	EOF_ERR
+"
+
+test_expect_success '--run invalid selector' "
+	run_sub_test_lib_test_err run-inv-selector \
+		'--run invalid selector' \
+		--run='1?' <<-\\EOF &&
+	test_expect_success \"passing test #1\" 'true'
+	test_done
+	EOF
+	check_sub_test_lib_test_err run-inv-selector \
+		<<-\\EOF_OUT 3<<-\\EOF_ERR
+	> FATAL: Unexpected exit with code 1
+	EOF_OUT
+	> error: --run: invalid non-numeric in test selector: '1?'
+	EOF_ERR
+"
+
+
 test_set_prereq HAVEIT
 haveit=no
 test_expect_success HAVEIT 'test runs if prerequisite is satisfied' '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e7d9c51..91000fe 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -191,6 +191,14 @@ do
 		immediate=t; shift ;;
 	-l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
 		GIT_TEST_LONG=t; export GIT_TEST_LONG; shift ;;
+	-r)
+		shift; test "$#" -ne 0 || {
+			echo 'error: -r requires an argument' >&2;
+			exit 1;
+		}
+		run_list=$1; shift ;;
+	--run=*)
+		run_list=$(expr "z$1" : 'z[^=]*=\(.*\)'); shift ;;
 	-h|--h|--he|--hel|--help)
 		help=t; shift ;;
 	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
@@ -366,6 +374,99 @@ match_pattern_list () {
 	return 1
 }
 
+match_test_selector_list () {
+	title="$1"
+	shift
+	arg="$1"
+	shift
+	test -z "$1" && return 0
+
+	# Both commas and whitespace are accepted as separators.
+	OLDIFS=$IFS
+	IFS=' 	,'
+	set -- $1
+	IFS=$OLDIFS
+
+	# If the first selector is negative we include by default.
+	include=
+	case "$1" in
+		!*) include=t ;;
+	esac
+
+	for selector
+	do
+		orig_selector=$selector
+
+		positive=t
+		case "$selector" in
+			!*)
+				positive=
+				selector=${selector##?}
+				;;
+		esac
+
+		test -z "$selector" && continue
+
+		case "$selector" in
+			*-*)
+				if expr "z${selector%%-*}" : "z[0-9]*[^0-9]" >/dev/null
+				then
+					echo "error: $title: invalid non-numeric in range" \
+						"start: '$orig_selector'" >&2
+					exit 1
+				fi
+				if expr "z${selector#*-}" : "z[0-9]*[^0-9]" >/dev/null
+				then
+					echo "error: $title: invalid non-numeric in range" \
+						"end: '$orig_selector'" >&2
+					exit 1
+				fi
+				;;
+			*)
+				if expr "z$selector" : "z[0-9]*[^0-9]" >/dev/null
+				then
+					echo "error: $title: invalid non-numeric in test" \
+						"selector: '$orig_selector'" >&2
+					exit 1
+				fi
+		esac
+
+		# Short cut for "obvious" cases
+		test -z "$include" && test -z "$positive" && continue
+		test -n "$include" && test -n "$positive" && continue
+
+		case "$selector" in
+			-*)
+				if test $arg -le ${selector#-}
+				then
+					include=$positive
+				fi
+				;;
+			*-)
+				if test $arg -ge ${selector%-}
+				then
+					include=$positive
+				fi
+				;;
+			*-*)
+				if test ${selector%%-*} -le $arg \
+					&& test $arg -le ${selector#*-}
+				then
+					include=$positive
+				fi
+				;;
+			*)
+				if test $arg -eq $selector
+				then
+					include=$positive
+				fi
+				;;
+		esac
+	done
+
+	test -n "$include"
+}
+
 maybe_teardown_verbose () {
 	test -z "$verbose_only" && return
 	exec 4>/dev/null 3>/dev/null
@@ -470,6 +571,13 @@ test_skip () {
 		fi
 		skipped_reason="missing $missing_prereq${of_prereq}"
 	fi
+	if test -z "$to_skip" && test -n "$run_list" &&
+		! match_test_selector_list '--run' $test_count "$run_list"
+	then
+		to_skip=t
+		skipped_reason="--run"
+	fi
+
 	case "$to_skip" in
 	t)
 		say_color skip >&3 "skipping test: $@"
-- 
1.7.9
