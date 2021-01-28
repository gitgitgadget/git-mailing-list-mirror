Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42BDC433E0
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4607064DC4
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhA1GdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 01:33:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:41672 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhA1GdV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 01:33:21 -0500
Received: (qmail 9918 invoked by uid 109); 28 Jan 2021 06:32:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Jan 2021 06:32:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25570 invoked by uid 111); 28 Jan 2021 06:32:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 01:32:40 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 01:32:37 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/4] t0000: consistently use single quotes for outer tests
Message-ID: <YBJahevyXE67PdNo@coredump.intra.peff.net>
References: <YBJab/tKDKOtH+p0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBJab/tKDKOtH+p0@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we use the sub-test helpers, we end up defining one shell snippet
inside another shell snippet. So if we use single-quotes for the outer
snippet, we have to use double-quotes within the inner snippet (it's
included as here-doc within the outer snippet, but using a single quote
would end the outer snippet early). Or vice versa we can use double
quotes for the outer snippet, but then single quotes in the inner.

We have some of each in the script, and neither is wrong. But it would
be nice to be consistent unless there is a good reason not to. Using
single quotes for the outer script is preferable, because it requires
less metacharacter quoting overall. For example, in:

  test_expect_success 'outer' '
	run_sub_test_lib_test ...  <<-\EOF
		echo $foo &&
		test_expect_success "inner" "
			echo \$bar
		"
	EOF
  '

we need only quote inside "inner", but not inside "outer" or the
here-doc. Whereas if we flip them, we have to quote in both places:

  test_expect_success 'outer' "
	run_sub_test_lib_test ...  <<-\EOF
		echo \$foo &&
		test_expect_success 'inner' '
			echo \$bar
		'
	EOF
  "

The exception is when we need a literal single-quote in an expected
output here-doc. There we can either use outer double-quotes, or just
use ${SQ} within the doc. I chose the latter for consistency (within
this test, but also with other test scripts that face the same problem).

There is one other interesting case, which is some tests that do:

  test_expect_success ... "
	do_something --run='"'!3'"'
  "

This is rather confusing to read, but is correct. The outer script sees
'!3' in single-quotes, as does the eval'd snippet. This is perhaps being
overly cautious. In many interactive shells, an exclamation triggers
history expansion even inside double quotes, but that is not generally
true in non-interactive shells.

There's some conflicting information here. Commit 784ce03d55 (t4216:
avoid unnecessary subshell in test_bloom_filters_not_used, 2020-05-19)
reports it as a problem with OpenBSD 6.7's /bin/sh. However, we have
many instances in this script of prereqs like !LAZY_TRUE, which haven't
been a problem. I left them un-escaped here to test out this theory.
It's much nicer if we can not worry about this as a portability issue,
so it's worth knowing.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0000-basic.sh | 380 +++++++++++++++++++++++------------------------
 1 file changed, 190 insertions(+), 190 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 502375bdf6..a6e570d674 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -135,77 +135,77 @@ check_sub_test_lib_test_err () {
 	)
 }
 
-test_expect_success 'pretend we have a fully passing test suite' "
-	run_sub_test_lib_test full-pass '3 passing tests' <<-\\EOF &&
+test_expect_success 'pretend we have a fully passing test suite' '
+	run_sub_test_lib_test full-pass "3 passing tests" <<-\EOF &&
 	for i in 1 2 3
 	do
-		test_expect_success \"passing test #\$i\" 'true'
+		test_expect_success "passing test #$i" "true"
 	done
 	test_done
 	EOF
-	check_sub_test_lib_test full-pass <<-\\EOF
+	check_sub_test_lib_test full-pass <<-\EOF
 	> ok 1 - passing test #1
 	> ok 2 - passing test #2
 	> ok 3 - passing test #3
 	> # passed all 3 test(s)
 	> 1..3
 	EOF
-"
+'
 
-test_expect_success 'pretend we have a partially passing test suite' "
+test_expect_success 'pretend we have a partially passing test suite' '
 	run_sub_test_lib_test_err \
-		partial-pass '2/3 tests passing' <<-\\EOF &&
-	test_expect_success 'passing test #1' 'true'
-	test_expect_success 'failing test #2' 'false'
-	test_expect_success 'passing test #3' 'true'
+		partial-pass "2/3 tests passing" <<-\EOF &&
+	test_expect_success "passing test #1" "true"
+	test_expect_success "failing test #2" "false"
+	test_expect_success "passing test #3" "true"
 	test_done
 	EOF
-	check_sub_test_lib_test partial-pass <<-\\EOF
+	check_sub_test_lib_test partial-pass <<-\EOF
 	> ok 1 - passing test #1
 	> not ok 2 - failing test #2
 	#	false
 	> ok 3 - passing test #3
 	> # failed 1 among 3 test(s)
 	> 1..3
 	EOF
-"
+'
 
-test_expect_success 'pretend we have a known breakage' "
-	run_sub_test_lib_test failing-todo 'A failing TODO test' <<-\\EOF &&
-	test_expect_success 'passing test' 'true'
-	test_expect_failure 'pretend we have a known breakage' 'false'
+test_expect_success 'pretend we have a known breakage' '
+	run_sub_test_lib_test failing-todo "A failing TODO test" <<-\EOF &&
+	test_expect_success "passing test" "true"
+	test_expect_failure "pretend we have a known breakage" "false"
 	test_done
 	EOF
-	check_sub_test_lib_test failing-todo <<-\\EOF
+	check_sub_test_lib_test failing-todo <<-\EOF
 	> ok 1 - passing test
 	> not ok 2 - pretend we have a known breakage # TODO known breakage
 	> # still have 1 known breakage(s)
 	> # passed all remaining 1 test(s)
 	> 1..2
 	EOF
-"
+'
 
-test_expect_success 'pretend we have fixed a known breakage' "
-	run_sub_test_lib_test passing-todo 'A passing TODO test' <<-\\EOF &&
-	test_expect_failure 'pretend we have fixed a known breakage' 'true'
+test_expect_success 'pretend we have fixed a known breakage' '
+	run_sub_test_lib_test passing-todo "A passing TODO test" <<-\EOF &&
+	test_expect_failure "pretend we have fixed a known breakage" "true"
 	test_done
 	EOF
-	check_sub_test_lib_test passing-todo <<-\\EOF
+	check_sub_test_lib_test passing-todo <<-\EOF
 	> ok 1 - pretend we have fixed a known breakage # TODO known breakage vanished
 	> # 1 known breakage(s) vanished; please update test(s)
 	> 1..1
 	EOF
-"
+'
 
-test_expect_success 'pretend we have fixed one of two known breakages (run in sub test-lib)' "
+test_expect_success 'pretend we have fixed one of two known breakages (run in sub test-lib)' '
 	run_sub_test_lib_test partially-passing-todos \
-		'2 TODO tests, one passing' <<-\\EOF &&
-	test_expect_failure 'pretend we have a known breakage' 'false'
-	test_expect_success 'pretend we have a passing test' 'true'
-	test_expect_failure 'pretend we have fixed another known breakage' 'true'
+		"2 TODO tests, one passing" <<-\EOF &&
+	test_expect_failure "pretend we have a known breakage" "false"
+	test_expect_success "pretend we have a passing test" "true"
+	test_expect_failure "pretend we have fixed another known breakage" "true"
 	test_done
 	EOF
-	check_sub_test_lib_test partially-passing-todos <<-\\EOF
+	check_sub_test_lib_test partially-passing-todos <<-\EOF
 	> not ok 1 - pretend we have a known breakage # TODO known breakage
 	> ok 2 - pretend we have a passing test
 	> ok 3 - pretend we have fixed another known breakage # TODO known breakage vanished
@@ -214,17 +214,17 @@ test_expect_success 'pretend we have fixed one of two known breakages (run in su
 	> # passed all remaining 1 test(s)
 	> 1..3
 	EOF
-"
+'
 
-test_expect_success 'pretend we have a pass, fail, and known breakage' "
+test_expect_success 'pretend we have a pass, fail, and known breakage' '
 	run_sub_test_lib_test_err \
-		mixed-results1 'mixed results #1' <<-\\EOF &&
-	test_expect_success 'passing test' 'true'
-	test_expect_success 'failing test' 'false'
-	test_expect_failure 'pretend we have a known breakage' 'false'
+		mixed-results1 "mixed results #1" <<-\EOF &&
+	test_expect_success "passing test" "true"
+	test_expect_success "failing test" "false"
+	test_expect_failure "pretend we have a known breakage" "false"
 	test_done
 	EOF
-	check_sub_test_lib_test mixed-results1 <<-\\EOF
+	check_sub_test_lib_test mixed-results1 <<-\EOF
 	> ok 1 - passing test
 	> not ok 2 - failing test
 	> #	false
@@ -233,24 +233,24 @@ test_expect_success 'pretend we have a pass, fail, and known breakage' "
 	> # failed 1 among remaining 2 test(s)
 	> 1..3
 	EOF
-"
+'
 
-test_expect_success 'pretend we have a mix of all possible results' "
+test_expect_success 'pretend we have a mix of all possible results' '
 	run_sub_test_lib_test_err \
-		mixed-results2 'mixed results #2' <<-\\EOF &&
-	test_expect_success 'passing test' 'true'
-	test_expect_success 'passing test' 'true'
-	test_expect_success 'passing test' 'true'
-	test_expect_success 'passing test' 'true'
-	test_expect_success 'failing test' 'false'
-	test_expect_success 'failing test' 'false'
-	test_expect_success 'failing test' 'false'
-	test_expect_failure 'pretend we have a known breakage' 'false'
-	test_expect_failure 'pretend we have a known breakage' 'false'
-	test_expect_failure 'pretend we have fixed a known breakage' 'true'
+		mixed-results2 "mixed results #2" <<-\EOF &&
+	test_expect_success "passing test" "true"
+	test_expect_success "passing test" "true"
+	test_expect_success "passing test" "true"
+	test_expect_success "passing test" "true"
+	test_expect_success "failing test" "false"
+	test_expect_success "failing test" "false"
+	test_expect_success "failing test" "false"
+	test_expect_failure "pretend we have a known breakage" "false"
+	test_expect_failure "pretend we have a known breakage" "false"
+	test_expect_failure "pretend we have fixed a known breakage" "true"
 	test_done
 	EOF
-	check_sub_test_lib_test mixed-results2 <<-\\EOF
+	check_sub_test_lib_test mixed-results2 <<-\EOF
 	> ok 1 - passing test
 	> ok 2 - passing test
 	> ok 3 - passing test
@@ -269,7 +269,7 @@ test_expect_success 'pretend we have a mix of all possible results' "
 	> # failed 3 among remaining 7 test(s)
 	> 1..10
 	EOF
-"
+'
 
 test_expect_success C_LOCALE_OUTPUT 'test --verbose' '
 	run_sub_test_lib_test_err \
@@ -321,39 +321,39 @@ test_expect_success 'test --verbose-only' '
 	EOF
 '
 
-test_expect_success 'GIT_SKIP_TESTS' "
+test_expect_success 'GIT_SKIP_TESTS' '
 	(
-		GIT_SKIP_TESTS='git.2' && export GIT_SKIP_TESTS &&
+		GIT_SKIP_TESTS="git.2" && export GIT_SKIP_TESTS &&
 		run_sub_test_lib_test git-skip-tests-basic \
-			'GIT_SKIP_TESTS' <<-\\EOF &&
+			"GIT_SKIP_TESTS" <<-\EOF &&
 		for i in 1 2 3
 		do
-			test_expect_success \"passing test #\$i\" 'true'
+			test_expect_success "passing test #$i" "true"
 		done
 		test_done
 		EOF
-		check_sub_test_lib_test git-skip-tests-basic <<-\\EOF
+		check_sub_test_lib_test git-skip-tests-basic <<-\EOF
 		> ok 1 - passing test #1
 		> ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
 		> ok 3 - passing test #3
 		> # passed all 3 test(s)
 		> 1..3
 		EOF
 	)
-"
+'
 
-test_expect_success 'GIT_SKIP_TESTS several tests' "
+test_expect_success 'GIT_SKIP_TESTS several tests' '
 	(
-		GIT_SKIP_TESTS='git.2 git.5' && export GIT_SKIP_TESTS &&
+		GIT_SKIP_TESTS="git.2 git.5" && export GIT_SKIP_TESTS &&
 		run_sub_test_lib_test git-skip-tests-several \
-			'GIT_SKIP_TESTS several tests' <<-\\EOF &&
+			"GIT_SKIP_TESTS several tests" <<-\EOF &&
 		for i in 1 2 3 4 5 6
 		do
-			test_expect_success \"passing test #\$i\" 'true'
+			test_expect_success "passing test #$i" "true"
 		done
 		test_done
 		EOF
-		check_sub_test_lib_test git-skip-tests-several <<-\\EOF
+		check_sub_test_lib_test git-skip-tests-several <<-\EOF
 		> ok 1 - passing test #1
 		> ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
 		> ok 3 - passing test #3
@@ -364,20 +364,20 @@ test_expect_success 'GIT_SKIP_TESTS several tests' "
 		> 1..6
 		EOF
 	)
-"
+'
 
-test_expect_success 'GIT_SKIP_TESTS sh pattern' "
+test_expect_success 'GIT_SKIP_TESTS sh pattern' '
 	(
-		GIT_SKIP_TESTS='git.[2-5]' && export GIT_SKIP_TESTS &&
+		GIT_SKIP_TESTS="git.[2-5]" && export GIT_SKIP_TESTS &&
 		run_sub_test_lib_test git-skip-tests-sh-pattern \
-			'GIT_SKIP_TESTS sh pattern' <<-\\EOF &&
+			"GIT_SKIP_TESTS sh pattern" <<-\EOF &&
 		for i in 1 2 3 4 5 6
 		do
-			test_expect_success \"passing test #\$i\" 'true'
+			test_expect_success "passing test #$i" "true"
 		done
 		test_done
 		EOF
-		check_sub_test_lib_test git-skip-tests-sh-pattern <<-\\EOF
+		check_sub_test_lib_test git-skip-tests-sh-pattern <<-\EOF
 		> ok 1 - passing test #1
 		> ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
 		> ok 3 # skip passing test #3 (GIT_SKIP_TESTS)
@@ -388,56 +388,56 @@ test_expect_success 'GIT_SKIP_TESTS sh pattern' "
 		> 1..6
 		EOF
 	)
-"
+'
 
-test_expect_success 'GIT_SKIP_TESTS entire suite' "
+test_expect_success 'GIT_SKIP_TESTS entire suite' '
 	(
-		GIT_SKIP_TESTS='git' && export GIT_SKIP_TESTS &&
+		GIT_SKIP_TESTS="git" && export GIT_SKIP_TESTS &&
 		run_sub_test_lib_test git-skip-tests-entire-suite \
-			'GIT_SKIP_TESTS entire suite' <<-\\EOF &&
+			"GIT_SKIP_TESTS entire suite" <<-\EOF &&
 		for i in 1 2 3
 		do
-			test_expect_success \"passing test #\$i\" 'true'
+			test_expect_success "passing test #$i" "true"
 		done
 		test_done
 		EOF
-		check_sub_test_lib_test git-skip-tests-entire-suite <<-\\EOF
+		check_sub_test_lib_test git-skip-tests-entire-suite <<-\EOF
 		> 1..0 # SKIP skip all tests in git
 		EOF
 	)
-"
+'
 
-test_expect_success 'GIT_SKIP_TESTS does not skip unmatched suite' "
+test_expect_success 'GIT_SKIP_TESTS does not skip unmatched suite' '
 	(
-		GIT_SKIP_TESTS='notgit' && export GIT_SKIP_TESTS &&
+		GIT_SKIP_TESTS="notgit" && export GIT_SKIP_TESTS &&
 		run_sub_test_lib_test git-skip-tests-unmatched-suite \
-			'GIT_SKIP_TESTS does not skip unmatched suite' <<-\\EOF &&
+			"GIT_SKIP_TESTS does not skip unmatched suite" <<-\EOF &&
 		for i in 1 2 3
 		do
-			test_expect_success \"passing test #\$i\" 'true'
+			test_expect_success "passing test #$i" "true"
 		done
 		test_done
 		EOF
-		check_sub_test_lib_test git-skip-tests-unmatched-suite <<-\\EOF
+		check_sub_test_lib_test git-skip-tests-unmatched-suite <<-\EOF
 		> ok 1 - passing test #1
 		> ok 2 - passing test #2
 		> ok 3 - passing test #3
 		> # passed all 3 test(s)
 		> 1..3
 		EOF
 	)
-"
+'
 
-test_expect_success '--run basic' "
+test_expect_success '--run basic' '
 	run_sub_test_lib_test run-basic \
-		'--run basic' --run='1,3,5' <<-\\EOF &&
+		"--run basic" --run="1,3,5" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
-		test_expect_success \"passing test #\$i\" 'true'
+		test_expect_success "passing test #$i" "true"
 	done
 	test_done
 	EOF
-	check_sub_test_lib_test run-basic <<-\\EOF
+	check_sub_test_lib_test run-basic <<-\EOF
 	> ok 1 - passing test #1
 	> ok 2 # skip passing test #2 (--run)
 	> ok 3 - passing test #3
@@ -447,18 +447,18 @@ test_expect_success '--run basic' "
 	> # passed all 6 test(s)
 	> 1..6
 	EOF
-"
+'
 
-test_expect_success '--run with a range' "
+test_expect_success '--run with a range' '
 	run_sub_test_lib_test run-range \
-		'--run with a range' --run='1-3' <<-\\EOF &&
+		"--run with a range" --run="1-3" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
-		test_expect_success \"passing test #\$i\" 'true'
+		test_expect_success "passing test #$i" "true"
 	done
 	test_done
 	EOF
-	check_sub_test_lib_test run-range <<-\\EOF
+	check_sub_test_lib_test run-range <<-\EOF
 	> ok 1 - passing test #1
 	> ok 2 - passing test #2
 	> ok 3 - passing test #3
@@ -468,18 +468,18 @@ test_expect_success '--run with a range' "
 	> # passed all 6 test(s)
 	> 1..6
 	EOF
-"
+'
 
-test_expect_success '--run with two ranges' "
+test_expect_success '--run with two ranges' '
 	run_sub_test_lib_test run-two-ranges \
-		'--run with two ranges' --run='1-2,5-6' <<-\\EOF &&
+		"--run with two ranges" --run="1-2,5-6" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
-		test_expect_success \"passing test #\$i\" 'true'
+		test_expect_success "passing test #$i" "true"
 	done
 	test_done
 	EOF
-	check_sub_test_lib_test run-two-ranges <<-\\EOF
+	check_sub_test_lib_test run-two-ranges <<-\EOF
 	> ok 1 - passing test #1
 	> ok 2 - passing test #2
 	> ok 3 # skip passing test #3 (--run)
@@ -489,18 +489,18 @@ test_expect_success '--run with two ranges' "
 	> # passed all 6 test(s)
 	> 1..6
 	EOF
-"
+'
 
-test_expect_success '--run with a left open range' "
+test_expect_success '--run with a left open range' '
 	run_sub_test_lib_test run-left-open-range \
-		'--run with a left open range' --run='-3' <<-\\EOF &&
+		"--run with a left open range" --run="-3" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
-		test_expect_success \"passing test #\$i\" 'true'
+		test_expect_success "passing test #$i" "true"
 	done
 	test_done
 	EOF
-	check_sub_test_lib_test run-left-open-range <<-\\EOF
+	check_sub_test_lib_test run-left-open-range <<-\EOF
 	> ok 1 - passing test #1
 	> ok 2 - passing test #2
 	> ok 3 - passing test #3
@@ -510,18 +510,18 @@ test_expect_success '--run with a left open range' "
 	> # passed all 6 test(s)
 	> 1..6
 	EOF
-"
+'
 
-test_expect_success '--run with a right open range' "
+test_expect_success '--run with a right open range' '
 	run_sub_test_lib_test run-right-open-range \
-		'--run with a right open range' --run='4-' <<-\\EOF &&
+		"--run with a right open range" --run="4-" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
-		test_expect_success \"passing test #\$i\" 'true'
+		test_expect_success "passing test #$i" "true"
 	done
 	test_done
 	EOF
-	check_sub_test_lib_test run-right-open-range <<-\\EOF
+	check_sub_test_lib_test run-right-open-range <<-\EOF
 	> ok 1 # skip passing test #1 (--run)
 	> ok 2 # skip passing test #2 (--run)
 	> ok 3 # skip passing test #3 (--run)
@@ -531,18 +531,18 @@ test_expect_success '--run with a right open range' "
 	> # passed all 6 test(s)
 	> 1..6
 	EOF
-"
+'
 
-test_expect_success '--run with basic negation' "
+test_expect_success '--run with basic negation' '
 	run_sub_test_lib_test run-basic-neg \
-		'--run with basic negation' --run='"'!3'"' <<-\\EOF &&
+		"--run with basic negation" --run="!3" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
-		test_expect_success \"passing test #\$i\" 'true'
+		test_expect_success "passing test #$i" "true"
 	done
 	test_done
 	EOF
-	check_sub_test_lib_test run-basic-neg <<-\\EOF
+	check_sub_test_lib_test run-basic-neg <<-\EOF
 	> ok 1 - passing test #1
 	> ok 2 - passing test #2
 	> ok 3 # skip passing test #3 (--run)
@@ -552,18 +552,18 @@ test_expect_success '--run with basic negation' "
 	> # passed all 6 test(s)
 	> 1..6
 	EOF
-"
+'
 
-test_expect_success '--run with two negations' "
+test_expect_success '--run with two negations' '
 	run_sub_test_lib_test run-two-neg \
-		'--run with two negations' --run='"'!3,!6'"' <<-\\EOF &&
+		"--run with two negations" --run="!3,!6" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
-		test_expect_success \"passing test #\$i\" 'true'
+		test_expect_success "passing test #$i" "true"
 	done
 	test_done
 	EOF
-	check_sub_test_lib_test run-two-neg <<-\\EOF
+	check_sub_test_lib_test run-two-neg <<-\EOF
 	> ok 1 - passing test #1
 	> ok 2 - passing test #2
 	> ok 3 # skip passing test #3 (--run)
@@ -573,18 +573,18 @@ test_expect_success '--run with two negations' "
 	> # passed all 6 test(s)
 	> 1..6
 	EOF
-"
+'
 
-test_expect_success '--run a range and negation' "
+test_expect_success '--run a range and negation' '
 	run_sub_test_lib_test run-range-and-neg \
-		'--run a range and negation' --run='"'-4,!2'"' <<-\\EOF &&
+		"--run a range and negation" --run="-4,!2" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
-		test_expect_success \"passing test #\$i\" 'true'
+		test_expect_success "passing test #$i" "true"
 	done
 	test_done
 	EOF
-	check_sub_test_lib_test run-range-and-neg <<-\\EOF
+	check_sub_test_lib_test run-range-and-neg <<-\EOF
 	> ok 1 - passing test #1
 	> ok 2 # skip passing test #2 (--run)
 	> ok 3 - passing test #3
@@ -594,18 +594,18 @@ test_expect_success '--run a range and negation' "
 	> # passed all 6 test(s)
 	> 1..6
 	EOF
-"
+'
 
-test_expect_success '--run range negation' "
+test_expect_success '--run range negation' '
 	run_sub_test_lib_test run-range-neg \
-		'--run range negation' --run='"'!1-3'"' <<-\\EOF &&
+		"--run range negation" --run="!1-3" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
-		test_expect_success \"passing test #\$i\" 'true'
+		test_expect_success "passing test #$i" "true"
 	done
 	test_done
 	EOF
-	check_sub_test_lib_test run-range-neg <<-\\EOF
+	check_sub_test_lib_test run-range-neg <<-\EOF
 	> ok 1 # skip passing test #1 (--run)
 	> ok 2 # skip passing test #2 (--run)
 	> ok 3 # skip passing test #3 (--run)
@@ -615,19 +615,19 @@ test_expect_success '--run range negation' "
 	> # passed all 6 test(s)
 	> 1..6
 	EOF
-"
+'
 
-test_expect_success '--run include, exclude and include' "
+test_expect_success '--run include, exclude and include' '
 	run_sub_test_lib_test run-inc-neg-inc \
-		'--run include, exclude and include' \
-		--run='"'1-5,!1-3,2'"' <<-\\EOF &&
+		"--run include, exclude and include" \
+		--run="1-5,!1-3,2" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
-		test_expect_success \"passing test #\$i\" 'true'
+		test_expect_success "passing test #$i" "true"
 	done
 	test_done
 	EOF
-	check_sub_test_lib_test run-inc-neg-inc <<-\\EOF
+	check_sub_test_lib_test run-inc-neg-inc <<-\EOF
 	> ok 1 # skip passing test #1 (--run)
 	> ok 2 - passing test #2
 	> ok 3 # skip passing test #3 (--run)
@@ -637,19 +637,19 @@ test_expect_success '--run include, exclude and include' "
 	> # passed all 6 test(s)
 	> 1..6
 	EOF
-"
+'
 
-test_expect_success '--run include, exclude and include, comma separated' "
+test_expect_success '--run include, exclude and include, comma separated' '
 	run_sub_test_lib_test run-inc-neg-inc-comma \
-		'--run include, exclude and include, comma separated' \
-		--run=1-5,\!1-3,2 <<-\\EOF &&
+		"--run include, exclude and include, comma separated" \
+		--run=1-5,!1-3,2 <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
-		test_expect_success \"passing test #\$i\" 'true'
+		test_expect_success "passing test #$i" "true"
 	done
 	test_done
 	EOF
-	check_sub_test_lib_test run-inc-neg-inc-comma <<-\\EOF
+	check_sub_test_lib_test run-inc-neg-inc-comma <<-\EOF
 	> ok 1 # skip passing test #1 (--run)
 	> ok 2 - passing test #2
 	> ok 3 # skip passing test #3 (--run)
@@ -659,19 +659,19 @@ test_expect_success '--run include, exclude and include, comma separated' "
 	> # passed all 6 test(s)
 	> 1..6
 	EOF
-"
+'
 
-test_expect_success '--run exclude and include' "
+test_expect_success '--run exclude and include' '
 	run_sub_test_lib_test run-neg-inc \
-		'--run exclude and include' \
-		--run='"'!3-,5'"' <<-\\EOF &&
+		"--run exclude and include" \
+		--run="!3-,5" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
-		test_expect_success \"passing test #\$i\" 'true'
+		test_expect_success "passing test #$i" "true"
 	done
 	test_done
 	EOF
-	check_sub_test_lib_test run-neg-inc <<-\\EOF
+	check_sub_test_lib_test run-neg-inc <<-\EOF
 	> ok 1 - passing test #1
 	> ok 2 - passing test #2
 	> ok 3 # skip passing test #3 (--run)
@@ -681,19 +681,19 @@ test_expect_success '--run exclude and include' "
 	> # passed all 6 test(s)
 	> 1..6
 	EOF
-"
+'
 
-test_expect_success '--run empty selectors' "
+test_expect_success '--run empty selectors' '
 	run_sub_test_lib_test run-empty-sel \
-		'--run empty selectors' \
-		--run='1,,3,,,5' <<-\\EOF &&
+		"--run empty selectors" \
+		--run="1,,3,,,5" <<-\EOF &&
 	for i in 1 2 3 4 5 6
 	do
-		test_expect_success \"passing test #\$i\" 'true'
+		test_expect_success "passing test #$i" "true"
 	done
 	test_done
 	EOF
-	check_sub_test_lib_test run-empty-sel <<-\\EOF
+	check_sub_test_lib_test run-empty-sel <<-\EOF
 	> ok 1 - passing test #1
 	> ok 2 # skip passing test #2 (--run)
 	> ok 3 - passing test #3
@@ -703,20 +703,20 @@ test_expect_success '--run empty selectors' "
 	> # passed all 6 test(s)
 	> 1..6
 	EOF
-"
+'
 
-test_expect_success '--run substring selector' "
+test_expect_success '--run substring selector' '
 	run_sub_test_lib_test run-substring-selector \
-		'--run empty selectors' \
-		--run='relevant' <<-\\EOF &&
-	test_expect_success \"relevant test\" 'true'
+		"--run empty selectors" \
+		--run="relevant" <<-\EOF &&
+	test_expect_success "relevant test" "true"
 	for i in 1 2 3 4 5 6
 	do
-		test_expect_success \"other test #\$i\" 'true'
+		test_expect_success "other test #$i" "true"
 	done
 	test_done
 	EOF
-	check_sub_test_lib_test run-substring-selector <<-\\EOF
+	check_sub_test_lib_test run-substring-selector <<-\EOF
 	> ok 1 - relevant test
 	> ok 2 # skip other test #1 (--run)
 	> ok 3 # skip other test #2 (--run)
@@ -727,37 +727,37 @@ test_expect_success '--run substring selector' "
 	> # passed all 7 test(s)
 	> 1..7
 	EOF
-"
+'
 
-test_expect_success '--run keyword selection' "
+test_expect_success '--run keyword selection' '
 	run_sub_test_lib_test_err run-inv-range-start \
-		'--run invalid range start' \
-		--run='a-5' <<-\\EOF &&
-	test_expect_success \"passing test #1\" 'true'
+		"--run invalid range start" \
+		--run="a-5" <<-\EOF &&
+	test_expect_success "passing test #1" "true"
 	test_done
 	EOF
 	check_sub_test_lib_test_err run-inv-range-start \
-		<<-\\EOF_OUT 3<<-\\EOF_ERR
+		<<-\EOF_OUT 3<<-EOF_ERR
 	> FATAL: Unexpected exit with code 1
 	EOF_OUT
-	> error: --run: invalid non-numeric in range start: 'a-5'
+	> error: --run: invalid non-numeric in range start: ${SQ}a-5${SQ}
 	EOF_ERR
-"
+'
 
-test_expect_success '--run invalid range end' "
+test_expect_success '--run invalid range end' '
 	run_sub_test_lib_test_err run-inv-range-end \
-		'--run invalid range end' \
-		--run='1-z' <<-\\EOF &&
-	test_expect_success \"passing test #1\" 'true'
+		"--run invalid range end" \
+		--run="1-z" <<-\EOF &&
+	test_expect_success "passing test #1" "true"
 	test_done
 	EOF
 	check_sub_test_lib_test_err run-inv-range-end \
-		<<-\\EOF_OUT 3<<-\\EOF_ERR
+		<<-\EOF_OUT 3<<-EOF_ERR
 	> FATAL: Unexpected exit with code 1
 	EOF_OUT
-	> error: --run: invalid non-numeric in range end: '1-z'
+	> error: --run: invalid non-numeric in range end: ${SQ}1-z${SQ}
 	EOF_ERR
-"
+'
 
 test_expect_success 'tests respect prerequisites' '
 	run_sub_test_lib_test prereqs "tests respect prereqs" <<-\EOF &&
@@ -839,18 +839,18 @@ test_expect_success 'nested lazy prerequisites' '
 	EOF
 '
 
-test_expect_success 'lazy prereqs do not turn off tracing' "
+test_expect_success 'lazy prereqs do not turn off tracing' '
 	run_sub_test_lib_test lazy-prereq-and-tracing \
-		'lazy prereqs and -x' -v -x <<-\\EOF &&
+		"lazy prereqs and -x" -v -x <<-\EOF &&
 	test_lazy_prereq LAZY true
 
-	test_expect_success lazy 'test_have_prereq LAZY && echo trace'
+	test_expect_success lazy "test_have_prereq LAZY && echo trace"
 
 	test_done
 	EOF
 
-	grep 'echo trace' lazy-prereq-and-tracing/err
-"
+	grep "echo trace" lazy-prereq-and-tracing/err
+'
 
 test_expect_success 'tests clean up after themselves' '
 	run_sub_test_lib_test cleanup "test with cleanup" <<-\EOF &&
@@ -872,20 +872,20 @@ test_expect_success 'tests clean up after themselves' '
 	EOF
 '
 
-test_expect_success 'tests clean up even on failures' "
+test_expect_success 'tests clean up even on failures' '
 	run_sub_test_lib_test_err \
-		failing-cleanup 'Failing tests with cleanup commands' <<-\\EOF &&
-	test_expect_success 'tests clean up even after a failure' '
+		failing-cleanup "Failing tests with cleanup commands" <<-\EOF &&
+	test_expect_success "tests clean up even after a failure" "
 		touch clean-after-failure &&
 		test_when_finished rm clean-after-failure &&
 		(exit 1)
-	'
-	test_expect_success 'failure to clean up causes the test to fail' '
+	"
+	test_expect_success "failure to clean up causes the test to fail" "
 		test_when_finished \"(exit 2)\"
-	'
+	"
 	test_done
 	EOF
-	check_sub_test_lib_test failing-cleanup <<-\\EOF
+	check_sub_test_lib_test failing-cleanup <<-\EOF
 	> not ok 1 - tests clean up even after a failure
 	> #	Z
 	> #	touch clean-after-failure &&
@@ -894,30 +894,30 @@ test_expect_success 'tests clean up even on failures' "
 	> #	Z
 	> not ok 2 - failure to clean up causes the test to fail
 	> #	Z
-	> #	test_when_finished \"(exit 2)\"
+	> #	test_when_finished "(exit 2)"
 	> #	Z
 	> # failed 2 among 2 test(s)
 	> 1..2
 	EOF
-"
+'
 
-test_expect_success 'test_atexit is run' "
+test_expect_success 'test_atexit is run' '
 	run_sub_test_lib_test_err \
-		atexit-cleanup 'Run atexit commands' -i <<-\\EOF &&
-	test_expect_success 'tests clean up even after a failure' '
+		atexit-cleanup "Run atexit commands" -i <<-\EOF &&
+	test_expect_success "tests clean up even after a failure" "
 		> ../../clean-atexit &&
 		test_atexit rm ../../clean-atexit &&
 		> ../../also-clean-atexit &&
 		test_atexit rm ../../also-clean-atexit &&
 		> ../../dont-clean-atexit &&
 		(exit 1)
-	'
+	"
 	test_done
 	EOF
 	test_path_is_file dont-clean-atexit &&
 	test_path_is_missing clean-atexit &&
 	test_path_is_missing also-clean-atexit
-"
+'
 
 test_expect_success 'test_oid provides sane info by default' '
 	test_oid zero >actual &&
-- 
2.30.0.758.gfe500d6872
