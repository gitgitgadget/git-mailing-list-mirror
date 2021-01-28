Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F59C433E6
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3045C64DDB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhA1GdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 01:33:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:41670 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhA1GdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 01:33:16 -0500
Received: (qmail 9915 invoked by uid 109); 28 Jan 2021 06:32:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Jan 2021 06:32:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25567 invoked by uid 111); 28 Jan 2021 06:32:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 01:32:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 01:32:35 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/4] t0000: run cleaning test inside sub-test
Message-ID: <YBJag+93WVW+V/U3@coredump.intra.peff.net>
References: <YBJab/tKDKOtH+p0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBJab/tKDKOtH+p0@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our check of test_when_finished is done directly in the main script, and
if we failed to clean, we complain and exit immediately. It's nicer to
signal a test failure here, for a few reasons:

  - this gives better output to the user when run under a TAP harness
    like "prove"

  - constency; it's the only test left in the file that behaves this way

  - half of its "if" conditional is nonsense anyway; it picked up a
    reference to GIT_TEST_FAIL_PREREQS_INTERNAL in dfe1a17df9 (tests:
    add a special setup where prerequisites fail, 2019-05-13) along with
    its neighbors, even though it has nothing to do with that flag

We could actually do this without a sub-test at all, and just put our
two tests (one to do cleanup, and one to check that it happened) in the
main script. But doing it in a subtest is conceptually cleaner (from the
perspective of the main test script, we are checking only one thing),
and it remains consistent with the "cleanup when failing" test directly
after it, which has to happen in a sub-test (to avoid the main script
complaining of the failed test).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0000-basic.sh | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 3d36a87610..502375bdf6 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -852,16 +852,25 @@ test_expect_success 'lazy prereqs do not turn off tracing' "
 	grep 'echo trace' lazy-prereq-and-tracing/err
 "
 
-clean=no
 test_expect_success 'tests clean up after themselves' '
-	test_when_finished clean=yes
-'
+	run_sub_test_lib_test cleanup "test with cleanup" <<-\EOF &&
+	clean=no
+	test_expect_success "do cleanup" "
+		test_when_finished clean=yes
+	"
+	test_expect_success "cleanup happened" "
+		test $clean = yes
+	"
+	test_done
+	EOF
 
-if test -z "$GIT_TEST_FAIL_PREREQS_INTERNAL" -a $clean != yes
-then
-	say "bug in test framework: basic cleanup command does not work reliably"
-	exit 1
-fi
+	check_sub_test_lib_test cleanup <<-\EOF
+	ok 1 - do cleanup
+	ok 2 - cleanup happened
+	# passed all 2 test(s)
+	1..2
+	EOF
+'
 
 test_expect_success 'tests clean up even on failures' "
 	run_sub_test_lib_test_err \
-- 
2.30.0.758.gfe500d6872

