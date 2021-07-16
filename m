Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D22C636CB
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 18:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8F23613F7
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 18:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhGPSqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 14:46:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:52166 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231715AbhGPSqn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 14:46:43 -0400
Received: (qmail 21534 invoked by uid 109); 16 Jul 2021 18:43:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Jul 2021 18:43:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11707 invoked by uid 111); 16 Jul 2021 18:43:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Jul 2021 14:43:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Jul 2021 14:43:47 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH] t0000: clear GIT_SKIP_TESTS before running sub-tests
Message-ID: <YPHTY5G9JaQFKlX5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t0000, we run several fake "sub-test" suites to verify the behavior
of the test suite. But because we don't clear the parent environment
completely, the sub-tests can be fooled by variables meant for the
parent. For example:

  GIT_SKIP_TESTS=t1234 ./t0000-basic.sh

fails when a sub-test expects its fake t1234 to actually run. This
particular pattern is unlikely in practice; we're running a single
script, and there is no t1234 in the real test suite anyway (not yet, at
least). A more real-world example is:

  GIT_SKIP_TESTS=t[^0]* make test

to run only the t0* tests.

The fix is conceptually simple: we should clear the GIT_SKIP_TESTS
variable when running the sub-tests, because its contents (if any) will
be meant for the main test suite. This is easy to do centrally in our
sub-test helper.

But there's a catch: some of our tests do set GIT_SKIP_TESTS
intentionally to test the feature. We need to allow them to continue to
set it, but clear it for all the other tests. And the sub-test helper
can't tell if the GIT_SKIP_TESTS it sees is from a test or not. We can
handle this by adding a new option to the helper to let callers specify
the skip list.

I considered adding a more general "--eval" option to let callers set up
the env for the sub-test however they like. That would cover this case
and possible future ones. But the quoting gets awkward for the callers
(since we're now 2 layers deep in evals!), so I went with the simpler
more specific solution.

Signed-off-by: Jeff King <peff@peff.net>
---
For reference, the eval solution would look something like this in the
callers:

	diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
	index f68c27d864..bf60c8fdc8 100755
	--- a/t/t0000-basic.sh
	+++ b/t/t0000-basic.sh
	@@ -361,7 +361,10 @@ test_expect_success 'GIT_SKIP_TESTS several tests' '
	 	(
	 		run_sub_test_lib_test git-skip-tests-several \
	 			"GIT_SKIP_TESTS several tests" \
	-			--skip="git.2 git.5" <<-\EOF &&
	+			--eval="
	+				GIT_SKIP_TESTS=\"git.2 git.5\"
	+				export GIT_SKIP_TESTS
	+			" <<-\EOF &&
	 		for i in 1 2 3 4 5 6
	 		do
	 			test_expect_success "passing test #$i" "true"

 t/t0000-basic.sh | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 2c6e34b947..f68c27d864 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -69,6 +69,23 @@ test_expect_success 'success is reported like this' '
 _run_sub_test_lib_test_common () {
 	neg="$1" name="$2" descr="$3" # stdin is the body of the test code
 	shift 3
+
+	# intercept pseudo-options at the front of the argument list that we
+	# will not pass to child script
+	skip=
+	while test $# -gt 0
+	do
+		case "$1" in
+		--skip=*)
+			skip=${1#--*=}
+			shift
+			;;
+		*)
+			break
+			;;
+		esac
+	done
+
 	mkdir "$name" &&
 	(
 		# Pretend we're not running under a test harness, whether we
@@ -91,6 +108,8 @@ _run_sub_test_lib_test_common () {
 		export TEST_DIRECTORY &&
 		TEST_OUTPUT_DIRECTORY=$(pwd) &&
 		export TEST_OUTPUT_DIRECTORY &&
+		GIT_SKIP_TESTS=$skip &&
+		export GIT_SKIP_TESTS &&
 		sane_unset GIT_TEST_FAIL_PREREQS &&
 		if test -z "$neg"
 		then
@@ -319,9 +338,9 @@ test_expect_success 'test --verbose-only' '
 
 test_expect_success 'GIT_SKIP_TESTS' '
 	(
-		GIT_SKIP_TESTS="git.2" && export GIT_SKIP_TESTS &&
 		run_sub_test_lib_test git-skip-tests-basic \
-			"GIT_SKIP_TESTS" <<-\EOF &&
+			"GIT_SKIP_TESTS" \
+			--skip="git.2" <<-\EOF &&
 		for i in 1 2 3
 		do
 			test_expect_success "passing test #$i" "true"
@@ -340,9 +359,9 @@ test_expect_success 'GIT_SKIP_TESTS' '
 
 test_expect_success 'GIT_SKIP_TESTS several tests' '
 	(
-		GIT_SKIP_TESTS="git.2 git.5" && export GIT_SKIP_TESTS &&
 		run_sub_test_lib_test git-skip-tests-several \
-			"GIT_SKIP_TESTS several tests" <<-\EOF &&
+			"GIT_SKIP_TESTS several tests" \
+			--skip="git.2 git.5" <<-\EOF &&
 		for i in 1 2 3 4 5 6
 		do
 			test_expect_success "passing test #$i" "true"
@@ -364,9 +383,9 @@ test_expect_success 'GIT_SKIP_TESTS several tests' '
 
 test_expect_success 'GIT_SKIP_TESTS sh pattern' '
 	(
-		GIT_SKIP_TESTS="git.[2-5]" && export GIT_SKIP_TESTS &&
 		run_sub_test_lib_test git-skip-tests-sh-pattern \
-			"GIT_SKIP_TESTS sh pattern" <<-\EOF &&
+			"GIT_SKIP_TESTS sh pattern" \
+			--skip="git.[2-5]" <<-\EOF &&
 		for i in 1 2 3 4 5 6
 		do
 			test_expect_success "passing test #$i" "true"
@@ -388,9 +407,9 @@ test_expect_success 'GIT_SKIP_TESTS sh pattern' '
 
 test_expect_success 'GIT_SKIP_TESTS entire suite' '
 	(
-		GIT_SKIP_TESTS="git" && export GIT_SKIP_TESTS &&
 		run_sub_test_lib_test git-skip-tests-entire-suite \
-			"GIT_SKIP_TESTS entire suite" <<-\EOF &&
+			"GIT_SKIP_TESTS entire suite" \
+			--skip="git" <<-\EOF &&
 		for i in 1 2 3
 		do
 			test_expect_success "passing test #$i" "true"
@@ -405,9 +424,9 @@ test_expect_success 'GIT_SKIP_TESTS entire suite' '
 
 test_expect_success 'GIT_SKIP_TESTS does not skip unmatched suite' '
 	(
-		GIT_SKIP_TESTS="notgit" && export GIT_SKIP_TESTS &&
 		run_sub_test_lib_test git-skip-tests-unmatched-suite \
-			"GIT_SKIP_TESTS does not skip unmatched suite" <<-\EOF &&
+			"GIT_SKIP_TESTS does not skip unmatched suite" \
+			--skip="notgit" <<-\EOF &&
 		for i in 1 2 3
 		do
 			test_expect_success "passing test #$i" "true"
-- 
2.32.0.693.gc302eace04
