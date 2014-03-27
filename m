From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: [PATCH 3/3] test-lib: '--run' to run only specific tests
Date: Thu, 27 Mar 2014 03:32:50 -0700
Message-ID: <1395916370-1404-4-git-send-email-ilya.bobyr@gmail.com>
References: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com>
 <1395916370-1404-1-git-send-email-ilya.bobyr@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Ilya Bobyr <ilya.bobyr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 11:34:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WT7dL-0005FH-LL
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 11:34:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310AbaC0Kd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 06:33:56 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45417 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279AbaC0Kdz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 06:33:55 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so3280386pbb.19
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 03:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n44Y4OEj5EzznL8UVfTVubi64iEv/6OtjUUQ9of0Me4=;
        b=Y/Y4qvgiNZ2CQw4zvWY/PePOyMYYTiWG2olqj0Hf4LyK6qbSqHiylinyAKM+QnTTmg
         5A9bpd66bQwKNXbjsRNgbiBQyzY8rXddqL/YjjFaBEFmvr6/P68IJFT+Vk4P8dH9MQJI
         i4n+FX52xHhfRVE5OEMogyt1pYxhb4IJAM1ksu7t3diU0kswHGe1Q2y2BkxzllQxUv2h
         vIF3hKcWxgTI0vG32nVrDW5IwFS62VYKNA4N0DO75FjQfXBAkRlQHkGKfm2SLIBLxK+t
         CHfIEQIB3ZL7itf5k08F4USV0yytPLZZuaff4LJZhwQNugLX86jOXZpfx4+t5p1RPxft
         am4A==
X-Received: by 10.68.40.138 with SMTP id x10mr1095353pbk.8.1395916435019;
        Thu, 27 Mar 2014 03:33:55 -0700 (PDT)
Received: from localhost.localdomain (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id hc4sm7104861pbc.29.2014.03.27.03.33.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Mar 2014 03:33:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1395916370-1404-1-git-send-email-ilya.bobyr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245274>

Allow better control of the set of tests that will be executed for a
single test suite.  Mostly useful while debugging or developing as it
allows to focus on a specific test.

Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
---
 No changes from the previous version.

 t/README         |   65 ++++++++++++++-
 t/t0000-basic.sh |  233 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh    |   85 ++++++++++++++++++++
 3 files changed, 379 insertions(+), 4 deletions(-)

diff --git a/t/README b/t/README
index 6b93aca..c911f89 100644
--- a/t/README
+++ b/t/README
@@ -100,6 +100,10 @@ appropriately before running "make".
 	This causes additional long-running tests to be run (where
 	available), for more exhaustive testing.
 
+-r,--run=<test numbers>::
+	This causes only specific tests to be included or excluded.  See
+	section "Skipping Tests" below for "<test numbers>" syntax.
+
 --valgrind=<tool>::
 	Execute all Git binaries under valgrind tool <tool> and exit
 	with status 126 on errors (just like regular tests, this will
@@ -187,10 +191,63 @@ and either can match the "t[0-9]{4}" part to skip the whole
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
+--run argument is a list of patterns with optional prefixes that
+are matched against test numbers within the current test suite.
+Supported pattern:
+
+ - A number matches a test with that number.
+
+ - sh metacharacters such as '*', '?' and '[]' match as usual in
+   shell.
+
+ - A number prefixed with '<', '<=', '>', or '>=' matches all
+   tests 'before', 'before or including', 'after', or 'after or
+   including' the specified one.
+
+Optional prefixes are:
+
+ - '+' or no prefix: test(s) matching the pattern are included in
+   the run.
+
+ - '-' or '!': test(s) matching the pattern are exluded from the
+   run.
+
+If --run starts with '+' or unprefixed pattern the initial set of
+tests to run is empty. If the first pattern starts with '-' or
+'!' all the tests are added to the initial set.  After initial
+set is determined every pattern, test number or range is added or
+excluded from the set one by one, from left to right.
+
+For example, common case is to run several setup tests and then a
+specific test that relies on that setup:
+
+    $ sh ./t9200-git-cvsexport-commit.sh --run='1 2 3 21'
+
+or:
+
+    $ sh ./t9200-git-cvsexport-commit.sh --run='<4 21'
+
+To run only tests up to a specific test one could do this:
+
+    $ sh ./t9200-git-cvsexport-commit.sh --run='!>=21'
+
+As noted above test set is build going though patterns left to
+right, so this:
+
+    $ sh ./t9200-git-cvsexport-commit.sh --run='<5 !3'
+
+will run tests 1, 2, and 4.
+
+Some tests in the existing test suite rely on previous test item,
+so you cannot arbitrarily disable one and expect the remainder of
+test to check what the test originally was intended to check.
+--run is mostly useful when you want to focus on a specific test
+and know what you are doing.  Or when you want to run up to a
+certain test.
 
 
 Naming Tests
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index ae8874e..4da527f 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -333,6 +333,239 @@ test_expect_success 'GIT_SKIP_TESTS sh pattern' "
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
+test_expect_success '--run with <' "
+	run_sub_test_lib_test run-lt \
+		'--run with <' --run='<4' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test run-lt <<-\\EOF
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
+test_expect_success '--run with <=' "
+	run_sub_test_lib_test run-le \
+		'--run with <=' --run='<=4' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test run-le <<-\\EOF
+	> ok 1 - passing test #1
+	> ok 2 - passing test #2
+	> ok 3 - passing test #3
+	> ok 4 - passing test #4
+	> ok 5 # skip passing test #5 (--run)
+	> ok 6 # skip passing test #6 (--run)
+	> # passed all 6 test(s)
+	> 1..6
+	EOF
+"
+
+test_expect_success '--run with >' "
+	run_sub_test_lib_test run-gt \
+		'--run with >' --run='>4' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test run-gt <<-\\EOF
+	> ok 1 # skip passing test #1 (--run)
+	> ok 2 # skip passing test #2 (--run)
+	> ok 3 # skip passing test #3 (--run)
+	> ok 4 # skip passing test #4 (--run)
+	> ok 5 - passing test #5
+	> ok 6 - passing test #6
+	> # passed all 6 test(s)
+	> 1..6
+	EOF
+"
+
+test_expect_success '--run with >=' "
+	run_sub_test_lib_test run-ge \
+		'--run with >=' --run='>=4' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test run-ge <<-\\EOF
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
+		'--run with basic negation' --run='-3' <<-\\EOF &&
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
+		'--run with two negation' --run='"'!3 !6'"' <<-\\EOF &&
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
+test_expect_success '--run < and negation' "
+	run_sub_test_lib_test run-lt-neg \
+		'--run < and negation' --run='"'<5 !2'"' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test run-lt-neg <<-\\EOF
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
+		'--run range negation' --run='-<3' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test run-range-neg <<-\\EOF
+	> ok 1 # skip passing test #1 (--run)
+	> ok 2 # skip passing test #2 (--run)
+	> ok 3 - passing test #3
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
+		--run='"'<=5 !<3 1'"' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test run-inc-neg-inc <<-\\EOF
+	> ok 1 - passing test #1
+	> ok 2 # skip passing test #2 (--run)
+	> ok 3 - passing test #3
+	> ok 4 - passing test #4
+	> ok 5 - passing test #5
+	> ok 6 # skip passing test #6 (--run)
+	> # passed all 6 test(s)
+	> 1..6
+	EOF
+"
+test_expect_success '--run exclude and include' "
+	run_sub_test_lib_test run-neg-inc \
+		'--run exclude and include' \
+		--run='"'!>2 5'"' <<-\\EOF &&
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
+
 test_set_prereq HAVEIT
 haveit=no
 test_expect_success HAVEIT 'test runs if prerequisite is satisfied' '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e035f36..63e481a 100644
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
@@ -366,6 +374,76 @@ match_pattern_list () {
 	return 1
 }
 
+match_run_pattern_list () {
+	arg="$1"
+	shift
+	test -z "$*" && return 0
+
+	# If the first patern is negative we include by default.
+	include=
+	case "$1" in
+		[-!]*) include=t ;;
+	esac
+
+	for pattern_
+	do
+		orig_pattern=$pattern_
+
+		positive=t
+		case "$pattern_" in
+			[-!]*)
+				positive=
+				pattern_=${pattern_##?}
+				;;
+		esac
+
+		# Short cut for "obvious" cases
+		[ "x$include" = "x" -a "x$positive" = "x" ] && continue
+		[ "x$include" = "xt" -a "x$positive" = "xt" ] && continue
+
+		pattern_op=
+		case "$pattern_" in
+			\<=*)
+				pattern_op='-le'
+				pattern_=${pattern_##??}
+				;;
+			\<*)
+				pattern_op='-lt'
+				pattern_=${pattern_##?}
+				;;
+			\>=*)
+				pattern_op='-ge'
+				pattern_=${pattern_##??}
+				;;
+			\>*)
+				pattern_op='-gt'
+				pattern_=${pattern_##?}
+				;;
+		esac
+
+		if test -n "$pattern_op"
+		then
+			if expr "z$pattern_" : "z[0-9]*[^0-9]" >/dev/null
+			then
+				echo "error: --run: test number contains" \
+					"non-digits: '$orig_pattern'" >&2
+				exit 1
+			fi
+			if test $arg $pattern_op $pattern_
+			then
+				include=$positive
+			fi
+		else
+			case "$arg" in
+				$pattern_)
+					include=$positive
+			esac
+		fi
+	done
+
+	test -n "$include"
+}
+
 maybe_teardown_verbose () {
 	test -z "$verbose_only" && return
 	exec 4>/dev/null 3>/dev/null
@@ -470,6 +548,13 @@ test_skip () {
 		fi
 		skipped_reason="missing $missing_prereq${of_prereq}"
 	fi
+	if test -z "$to_skip" && test -n "$run_list" &&
+		! match_run_pattern_list $test_count $run_list
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
