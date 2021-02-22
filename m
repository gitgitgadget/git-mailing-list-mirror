Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE28C433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6099661481
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhBVTU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 14:20:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:40610 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232993AbhBVTSs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 14:18:48 -0500
Received: (qmail 21461 invoked by uid 109); 22 Feb 2021 19:17:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Feb 2021 19:17:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16011 invoked by uid 111); 22 Feb 2021 19:17:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Feb 2021 14:17:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Feb 2021 14:17:51 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 2/2] test-lib-functions: use BUG() in 'test_must_fail'
Message-ID: <YDQDX/zdGTI1HmJ9@coredump.intra.peff.net>
References: <20210221192512.3096291-1-szeder.dev@gmail.com>
 <20210221192512.3096291-2-szeder.dev@gmail.com>
 <YDLXf+OoJabrJTWu@coredump.intra.peff.net>
 <YDQBxqTbuYgq1xV8@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDQBxqTbuYgq1xV8@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 22, 2021 at 02:11:02PM -0500, Jeff King wrote:

> It also adds "test_done" to the sub-test snippets, which my earlier
> patch did not include. That's not strictly necessary (we should error
> out before we even get there), but it makes the test more robust (we are
> sure that the BUG is what caused us to exit non-zero, not the missing
> test_done).

I'm quite tempted to do this, as well (this is on top of what I just
sent, but could easily be done independently by removing the hunks
touching the instances I just added):

-- >8 --
Subject: [PATCH] t0000: automatically add test_done to sub-test snippets

Our sub-test helper already handles setting up test_description,
including test-lib.sh, etc. Let's also automatically a test_done at the
end, since it is easy to forget and essentially every test snippet will
want it.

The only test which _wouldn't_ want this is one that was specifically
trying to check the behavior when test_done is not run. We don't have
such a test, but if we wanted one, it could just as easily run "exit 0"
as part of its snippet (which is arguably more obvious and readable than
leaving out the test_done, anyway).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0000-basic.sh | 46 +---------------------------------------------
 1 file changed, 1 insertion(+), 45 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index e5c06d055b..5a9592dd10 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -92,6 +92,7 @@ _run_sub_test_lib_test_common () {
 		. "\$TEST_DIRECTORY"/test-lib.sh
 		EOF
 		cat >>"$name.sh" &&
+		echo "test_done" >>"$name.sh" &&
 		export TEST_DIRECTORY &&
 		TEST_OUTPUT_DIRECTORY=$(pwd) &&
 		export TEST_OUTPUT_DIRECTORY &&
@@ -141,7 +142,6 @@ test_expect_success 'pretend we have a fully passing test suite' '
 	do
 		test_expect_success "passing test #$i" "true"
 	done
-	test_done
 	EOF
 	check_sub_test_lib_test full-pass <<-\EOF
 	> ok 1 - passing test #1
@@ -158,7 +158,6 @@ test_expect_success 'pretend we have a partially passing test suite' '
 	test_expect_success "passing test #1" "true"
 	test_expect_success "failing test #2" "false"
 	test_expect_success "passing test #3" "true"
-	test_done
 	EOF
 	check_sub_test_lib_test partial-pass <<-\EOF
 	> ok 1 - passing test #1
@@ -174,7 +173,6 @@ test_expect_success 'pretend we have a known breakage' '
 	run_sub_test_lib_test failing-todo "A failing TODO test" <<-\EOF &&
 	test_expect_success "passing test" "true"
 	test_expect_failure "pretend we have a known breakage" "false"
-	test_done
 	EOF
 	check_sub_test_lib_test failing-todo <<-\EOF
 	> ok 1 - passing test
@@ -188,7 +186,6 @@ test_expect_success 'pretend we have a known breakage' '
 test_expect_success 'pretend we have fixed a known breakage' '
 	run_sub_test_lib_test passing-todo "A passing TODO test" <<-\EOF &&
 	test_expect_failure "pretend we have fixed a known breakage" "true"
-	test_done
 	EOF
 	check_sub_test_lib_test passing-todo <<-\EOF
 	> ok 1 - pretend we have fixed a known breakage # TODO known breakage vanished
@@ -203,7 +200,6 @@ test_expect_success 'pretend we have fixed one of two known breakages (run in su
 	test_expect_failure "pretend we have a known breakage" "false"
 	test_expect_success "pretend we have a passing test" "true"
 	test_expect_failure "pretend we have fixed another known breakage" "true"
-	test_done
 	EOF
 	check_sub_test_lib_test partially-passing-todos <<-\EOF
 	> not ok 1 - pretend we have a known breakage # TODO known breakage
@@ -222,7 +218,6 @@ test_expect_success 'pretend we have a pass, fail, and known breakage' '
 	test_expect_success "passing test" "true"
 	test_expect_success "failing test" "false"
 	test_expect_failure "pretend we have a known breakage" "false"
-	test_done
 	EOF
 	check_sub_test_lib_test mixed-results1 <<-\EOF
 	> ok 1 - passing test
@@ -248,7 +243,6 @@ test_expect_success 'pretend we have a mix of all possible results' '
 	test_expect_failure "pretend we have a known breakage" "false"
 	test_expect_failure "pretend we have a known breakage" "false"
 	test_expect_failure "pretend we have fixed a known breakage" "true"
-	test_done
 	EOF
 	check_sub_test_lib_test mixed-results2 <<-\EOF
 	> ok 1 - passing test
@@ -277,7 +271,6 @@ test_expect_success C_LOCALE_OUTPUT 'test --verbose' '
 	test_expect_success "passing test" true
 	test_expect_success "test with output" "echo foo"
 	test_expect_success "failing test" false
-	test_done
 	EOF
 	mv t1234-verbose/out t1234-verbose/out+ &&
 	grep -v "^Initialized empty" t1234-verbose/out+ >t1234-verbose/out &&
@@ -305,7 +298,6 @@ test_expect_success 'test --verbose-only' '
 	test_expect_success "passing test" true
 	test_expect_success "test with output" "echo foo"
 	test_expect_success "failing test" false
-	test_done
 	EOF
 	check_sub_test_lib_test t2345-verbose-only-2 <<-\EOF
 	> ok 1 - passing test
@@ -330,7 +322,6 @@ test_expect_success 'GIT_SKIP_TESTS' '
 		do
 			test_expect_success "passing test #$i" "true"
 		done
-		test_done
 		EOF
 		check_sub_test_lib_test git-skip-tests-basic <<-\EOF
 		> ok 1 - passing test #1
@@ -351,7 +342,6 @@ test_expect_success 'GIT_SKIP_TESTS several tests' '
 		do
 			test_expect_success "passing test #$i" "true"
 		done
-		test_done
 		EOF
 		check_sub_test_lib_test git-skip-tests-several <<-\EOF
 		> ok 1 - passing test #1
@@ -375,7 +365,6 @@ test_expect_success 'GIT_SKIP_TESTS sh pattern' '
 		do
 			test_expect_success "passing test #$i" "true"
 		done
-		test_done
 		EOF
 		check_sub_test_lib_test git-skip-tests-sh-pattern <<-\EOF
 		> ok 1 - passing test #1
@@ -399,7 +388,6 @@ test_expect_success 'GIT_SKIP_TESTS entire suite' '
 		do
 			test_expect_success "passing test #$i" "true"
 		done
-		test_done
 		EOF
 		check_sub_test_lib_test git-skip-tests-entire-suite <<-\EOF
 		> 1..0 # SKIP skip all tests in git
@@ -416,7 +404,6 @@ test_expect_success 'GIT_SKIP_TESTS does not skip unmatched suite' '
 		do
 			test_expect_success "passing test #$i" "true"
 		done
-		test_done
 		EOF
 		check_sub_test_lib_test git-skip-tests-unmatched-suite <<-\EOF
 		> ok 1 - passing test #1
@@ -435,7 +422,6 @@ test_expect_success '--run basic' '
 	do
 		test_expect_success "passing test #$i" "true"
 	done
-	test_done
 	EOF
 	check_sub_test_lib_test run-basic <<-\EOF
 	> ok 1 - passing test #1
@@ -456,7 +442,6 @@ test_expect_success '--run with a range' '
 	do
 		test_expect_success "passing test #$i" "true"
 	done
-	test_done
 	EOF
 	check_sub_test_lib_test run-range <<-\EOF
 	> ok 1 - passing test #1
@@ -477,7 +462,6 @@ test_expect_success '--run with two ranges' '
 	do
 		test_expect_success "passing test #$i" "true"
 	done
-	test_done
 	EOF
 	check_sub_test_lib_test run-two-ranges <<-\EOF
 	> ok 1 - passing test #1
@@ -498,7 +482,6 @@ test_expect_success '--run with a left open range' '
 	do
 		test_expect_success "passing test #$i" "true"
 	done
-	test_done
 	EOF
 	check_sub_test_lib_test run-left-open-range <<-\EOF
 	> ok 1 - passing test #1
@@ -519,7 +502,6 @@ test_expect_success '--run with a right open range' '
 	do
 		test_expect_success "passing test #$i" "true"
 	done
-	test_done
 	EOF
 	check_sub_test_lib_test run-right-open-range <<-\EOF
 	> ok 1 # skip passing test #1 (--run)
@@ -540,7 +522,6 @@ test_expect_success '--run with basic negation' '
 	do
 		test_expect_success "passing test #$i" "true"
 	done
-	test_done
 	EOF
 	check_sub_test_lib_test run-basic-neg <<-\EOF
 	> ok 1 - passing test #1
@@ -561,7 +542,6 @@ test_expect_success '--run with two negations' '
 	do
 		test_expect_success "passing test #$i" "true"
 	done
-	test_done
 	EOF
 	check_sub_test_lib_test run-two-neg <<-\EOF
 	> ok 1 - passing test #1
@@ -582,7 +562,6 @@ test_expect_success '--run a range and negation' '
 	do
 		test_expect_success "passing test #$i" "true"
 	done
-	test_done
 	EOF
 	check_sub_test_lib_test run-range-and-neg <<-\EOF
 	> ok 1 - passing test #1
@@ -603,7 +582,6 @@ test_expect_success '--run range negation' '
 	do
 		test_expect_success "passing test #$i" "true"
 	done
-	test_done
 	EOF
 	check_sub_test_lib_test run-range-neg <<-\EOF
 	> ok 1 # skip passing test #1 (--run)
@@ -625,7 +603,6 @@ test_expect_success '--run include, exclude and include' '
 	do
 		test_expect_success "passing test #$i" "true"
 	done
-	test_done
 	EOF
 	check_sub_test_lib_test run-inc-neg-inc <<-\EOF
 	> ok 1 # skip passing test #1 (--run)
@@ -647,7 +624,6 @@ test_expect_success '--run include, exclude and include, comma separated' '
 	do
 		test_expect_success "passing test #$i" "true"
 	done
-	test_done
 	EOF
 	check_sub_test_lib_test run-inc-neg-inc-comma <<-\EOF
 	> ok 1 # skip passing test #1 (--run)
@@ -669,7 +645,6 @@ test_expect_success '--run exclude and include' '
 	do
 		test_expect_success "passing test #$i" "true"
 	done
-	test_done
 	EOF
 	check_sub_test_lib_test run-neg-inc <<-\EOF
 	> ok 1 - passing test #1
@@ -691,7 +666,6 @@ test_expect_success '--run empty selectors' '
 	do
 		test_expect_success "passing test #$i" "true"
 	done
-	test_done
 	EOF
 	check_sub_test_lib_test run-empty-sel <<-\EOF
 	> ok 1 - passing test #1
@@ -714,7 +688,6 @@ test_expect_success '--run substring selector' '
 	do
 		test_expect_success "other test #$i" "true"
 	done
-	test_done
 	EOF
 	check_sub_test_lib_test run-substring-selector <<-\EOF
 	> ok 1 - relevant test
@@ -734,7 +707,6 @@ test_expect_success '--run keyword selection' '
 		"--run invalid range start" \
 		--run="a-5" <<-\EOF &&
 	test_expect_success "passing test #1" "true"
-	test_done
 	EOF
 	check_sub_test_lib_test_err run-inv-range-start \
 		<<-\EOF_OUT 3<<-EOF_ERR
@@ -749,7 +721,6 @@ test_expect_success '--run invalid range end' '
 		"--run invalid range end" \
 		--run="1-z" <<-\EOF &&
 	test_expect_success "passing test #1" "true"
-	test_done
 	EOF
 	check_sub_test_lib_test_err run-inv-range-end \
 		<<-\EOF_OUT 3<<-EOF_ERR
@@ -773,8 +744,6 @@ test_expect_success 'tests respect prerequisites' '
 	test_expect_success HAVETHIS,HAVEIT "multiple prereqs" "true"
 	test_expect_success HAVEIT,DONTHAVEIT "mixed prereqs (yes,no)" "false"
 	test_expect_success DONTHAVEIT,HAVEIT "mixed prereqs (no,yes)" "false"
-
-	test_done
 	EOF
 
 	check_sub_test_lib_test prereqs <<-\EOF
@@ -799,8 +768,6 @@ test_expect_success 'tests respect lazy prerequisites' '
 	test_lazy_prereq LAZY_FALSE false
 	test_expect_success LAZY_FALSE "lazy prereq not satisfied" "false"
 	test_expect_success !LAZY_FALSE "negative false prereq" "true"
-
-	test_done
 	EOF
 
 	check_sub_test_lib_test lazy-prereqs <<-\EOF
@@ -828,8 +795,6 @@ test_expect_success 'nested lazy prerequisites' '
 		test_path_is_missing inner
 	"
 	test_expect_success NESTED_PREREQ "evaluate nested prereq" "true"
-
-	test_done
 	EOF
 
 	check_sub_test_lib_test nested-lazy <<-\EOF
@@ -845,8 +810,6 @@ test_expect_success 'lazy prereqs do not turn off tracing' '
 	test_lazy_prereq LAZY true
 
 	test_expect_success lazy "test_have_prereq LAZY && echo trace"
-
-	test_done
 	EOF
 
 	grep "echo trace" lazy-prereq-and-tracing/err
@@ -861,7 +824,6 @@ test_expect_success 'tests clean up after themselves' '
 	test_expect_success "cleanup happened" "
 		test $clean = yes
 	"
-	test_done
 	EOF
 
 	check_sub_test_lib_test cleanup <<-\EOF
@@ -883,7 +845,6 @@ test_expect_success 'tests clean up even on failures' '
 	test_expect_success "failure to clean up causes the test to fail" "
 		test_when_finished \"(exit 2)\"
 	"
-	test_done
 	EOF
 	check_sub_test_lib_test failing-cleanup <<-\EOF
 	> not ok 1 - tests clean up even after a failure
@@ -912,7 +873,6 @@ test_expect_success 'test_atexit is run' '
 		> ../../dont-clean-atexit &&
 		(exit 1)
 	"
-	test_done
 	EOF
 	test_path_is_file dont-clean-atexit &&
 	test_path_is_missing clean-atexit &&
@@ -992,7 +952,6 @@ test_expect_success 'test_bool_env invalid value' '
 		export envvar &&
 		test_bool_env envvar true
 	"
-	test_done
 	EOF
 	grep "error: test_bool_env requires bool values" invalid-bool-value/err
 '
@@ -1004,7 +963,6 @@ test_expect_success 'test_bool_env invalid default' '
 		export envvar &&
 		test_bool_env envvar default
 	"
-	test_done
 	EOF
 	grep "error: test_bool_env requires bool values" invalid-bool-default/err
 '
@@ -1331,7 +1289,6 @@ test_expect_success 'test_must_fail rejects a non-git command' '
 	test_expect_success "non-git command" "
 		test_must_fail grep ^$ notafile
 	"
-	test_done
 	EOF
 	grep "bug.*test_must_fail: only .git. is allowed" bug-fail-nongit/err
 '
@@ -1341,7 +1298,6 @@ test_expect_success 'test_must_fail rejects a non-git command with env' '
 	test_expect_success "non-git command with env" "
 		test_must_fail env var1=a var2=b grep ^$ notafile
 	"
-	test_done
 	EOF
 	grep "bug.*test_must_fail: only .git. is allowed" bug-fail-env/err
 '
-- 
2.30.1.1033.gd525307ce1

