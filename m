Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902E7C43381
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52BE864DD6
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhA1GdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 01:33:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:41668 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhA1GdP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 01:33:15 -0500
Received: (qmail 9912 invoked by uid 109); 28 Jan 2021 06:32:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Jan 2021 06:32:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25564 invoked by uid 111); 28 Jan 2021 06:32:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 01:32:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 01:32:32 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/4] t0000: run prereq tests inside sub-test
Message-ID: <YBJagLna/9JVeWdp@coredump.intra.peff.net>
References: <YBJab/tKDKOtH+p0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBJab/tKDKOtH+p0@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We test the behavior of prerequisites in t0000 by setting up fake ones
in the main test script, trying to run some tests, and then seeing if
those tests impacted the environment correctly. If they didn't, then we
write a message and manually call exit.

Instead, let's push these down into a sub-test, like many of the other
tests covering the framework itself. This has a few advantages:

  - it does not pollute the test output with mention of skipped tests
    (that we know are uninteresting -- the point of the test was to see
    that these are skipped).

  - when running in a TAP harness, we get a useful test failure message
    (whereas when the script exits early, a tool like "prove" simply
    says "Dubious, test returned 1").

  - we do not have to worry about different test environments, such as
    when GIT_TEST_FAIL_PREREQS_INTERNAL is set. Our sub-test helpers
    already give us a known environment.

  - the tests themselves are a bit easier to read, as we can just check
    the test-framework output to see what happened (and get the usual
    test_cmp diff if it failed)

A few notes on the implementation:

  - we could do one sub-test per each individual test_expect_success. I
    broke it up here into a few logical groups, as I think this makes it
    more readable

  - the original tests modified environment variables inside the test
    bodies. Instead, I've used "true" as the body of a test we expect to
    run and "false" otherwise. Technically this does not confirm that
    the body of the "true" test actually ran. We are trusting the
    framework output to believe that it truly ran, which is sufficient
    for these tests. And I think the end result is much simpler to
    follow.

  - the nested_prereq test uses a few bare "test -f" calls; I converted
    these to our usual test_path_is_* helpers while moving the code
    around.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0000-basic.sh | 149 ++++++++++++++++++++++-------------------------
 1 file changed, 69 insertions(+), 80 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index d49b5dd4ac..3d36a87610 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -759,96 +759,85 @@ test_expect_success '--run invalid range end' "
 	EOF_ERR
 "
 
+test_expect_success 'tests respect prerequisites' '
+	run_sub_test_lib_test prereqs "tests respect prereqs" <<-\EOF &&
 
-test_set_prereq HAVEIT
-haveit=no
-test_expect_success HAVEIT 'test runs if prerequisite is satisfied' '
-	test_have_prereq HAVEIT &&
-	haveit=yes
-'
-donthaveit=yes
-test_expect_success DONTHAVEIT 'unmet prerequisite causes test to be skipped' '
-	donthaveit=no
-'
-if test -z "$GIT_TEST_FAIL_PREREQS_INTERNAL" -a $haveit$donthaveit != yesyes
-then
-	say "bug in test framework: prerequisite tags do not work reliably"
-	exit 1
-fi
+	test_set_prereq HAVEIT
+	test_expect_success HAVEIT "prereq is satisfied" "true"
+	test_expect_success "have_prereq works" "
+		test_have_prereq HAVEIT
+	"
+	test_expect_success DONTHAVEIT "prereq not satisfied" "false"
 
-test_set_prereq HAVETHIS
-haveit=no
-test_expect_success HAVETHIS,HAVEIT 'test runs if prerequisites are satisfied' '
-	test_have_prereq HAVEIT &&
-	test_have_prereq HAVETHIS &&
-	haveit=yes
-'
-donthaveit=yes
-test_expect_success HAVEIT,DONTHAVEIT 'unmet prerequisites causes test to be skipped' '
-	donthaveit=no
-'
-donthaveiteither=yes
-test_expect_success DONTHAVEIT,HAVEIT 'unmet prerequisites causes test to be skipped' '
-	donthaveiteither=no
-'
-if test -z "$GIT_TEST_FAIL_PREREQS_INTERNAL" -a $haveit$donthaveit$donthaveiteither != yesyesyes
-then
-	say "bug in test framework: multiple prerequisite tags do not work reliably"
-	exit 1
-fi
+	test_set_prereq HAVETHIS
+	test_expect_success HAVETHIS,HAVEIT "multiple prereqs" "true"
+	test_expect_success HAVEIT,DONTHAVEIT "mixed prereqs (yes,no)" "false"
+	test_expect_success DONTHAVEIT,HAVEIT "mixed prereqs (no,yes)" "false"
 
-test_lazy_prereq LAZY_TRUE true
-havetrue=no
-test_expect_success LAZY_TRUE 'test runs if lazy prereq is satisfied' '
-	havetrue=yes
-'
-donthavetrue=yes
-test_expect_success !LAZY_TRUE 'missing lazy prereqs skip tests' '
-	donthavetrue=no
+	test_done
+	EOF
+
+	check_sub_test_lib_test prereqs <<-\EOF
+	ok 1 - prereq is satisfied
+	ok 2 - have_prereq works
+	ok 3 # skip prereq not satisfied (missing DONTHAVEIT)
+	ok 4 - multiple prereqs
+	ok 5 # skip mixed prereqs (yes,no) (missing DONTHAVEIT of HAVEIT,DONTHAVEIT)
+	ok 6 # skip mixed prereqs (no,yes) (missing DONTHAVEIT of DONTHAVEIT,HAVEIT)
+	# passed all 6 test(s)
+	1..6
+	EOF
 '
 
-if test -z "$GIT_TEST_FAIL_PREREQS_INTERNAL" -a "$havetrue$donthavetrue" != yesyes
-then
-	say 'bug in test framework: lazy prerequisites do not work'
-	exit 1
-fi
+test_expect_success 'tests respect lazy prerequisites' '
+	run_sub_test_lib_test lazy-prereqs "respect lazy prereqs" <<-\EOF &&
 
-test_lazy_prereq LAZY_FALSE false
-nothavefalse=no
-test_expect_success !LAZY_FALSE 'negative lazy prereqs checked' '
-	nothavefalse=yes
-'
-havefalse=yes
-test_expect_success LAZY_FALSE 'missing negative lazy prereqs will skip' '
-	havefalse=no
-'
+	test_lazy_prereq LAZY_TRUE true
+	test_expect_success LAZY_TRUE "lazy prereq is satisifed" "true"
+	test_expect_success !LAZY_TRUE "negative lazy prereq" "false"
 
-if test -z "$GIT_TEST_FAIL_PREREQS_INTERNAL" -a "$nothavefalse$havefalse" != yesyes
-then
-	say 'bug in test framework: negative lazy prerequisites do not work'
-	exit 1
-fi
+	test_lazy_prereq LAZY_FALSE false
+	test_expect_success LAZY_FALSE "lazy prereq not satisfied" "false"
+	test_expect_success !LAZY_FALSE "negative false prereq" "true"
 
-test_lazy_prereq NESTED_INNER '
-	>inner &&
-	rm -f outer
-'
-test_lazy_prereq NESTED_PREREQ '
-	>outer &&
-	test_have_prereq NESTED_INNER &&
-	echo "can create new file in cwd" >file &&
-	test -f outer &&
-	test ! -f inner
-'
-test_expect_success NESTED_PREREQ 'evaluating nested lazy prereqs dont interfere with each other' '
-	nestedworks=yes
+	test_done
+	EOF
+
+	check_sub_test_lib_test lazy-prereqs <<-\EOF
+	ok 1 - lazy prereq is satisifed
+	ok 2 # skip negative lazy prereq (missing !LAZY_TRUE)
+	ok 3 # skip lazy prereq not satisfied (missing LAZY_FALSE)
+	ok 4 - negative false prereq
+	# passed all 4 test(s)
+	1..4
+	EOF
 '
 
-if test -z "$GIT_TEST_FAIL_PREREQS_INTERNAL" && test "$nestedworks" != yes
-then
-	say 'bug in test framework: nested lazy prerequisites do not work'
-	exit 1
-fi
+test_expect_success 'nested lazy prerequisites' '
+	run_sub_test_lib_test nested-lazy "nested lazy prereqs" <<-\EOF &&
+
+	test_lazy_prereq NESTED_INNER "
+		>inner &&
+		rm -f outer
+	"
+	test_lazy_prereq NESTED_PREREQ "
+		>outer &&
+		test_have_prereq NESTED_INNER &&
+		echo can create new file in cwd >file &&
+		test_path_is_file outer &&
+		test_path_is_missing inner
+	"
+	test_expect_success NESTED_PREREQ "evaluate nested prereq" "true"
+
+	test_done
+	EOF
+
+	check_sub_test_lib_test nested-lazy <<-\EOF
+	ok 1 - evaluate nested prereq
+	# passed all 1 test(s)
+	1..1
+	EOF
+'
 
 test_expect_success 'lazy prereqs do not turn off tracing' "
 	run_sub_test_lib_test lazy-prereq-and-tracing \
-- 
2.30.0.758.gfe500d6872

