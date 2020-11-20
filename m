Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27C2C63777
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 00:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E34822242
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 00:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgKTARY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 19:17:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:36202 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgKTARY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 19:17:24 -0500
Received: (qmail 483 invoked by uid 109); 20 Nov 2020 00:17:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Nov 2020 00:17:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1262 invoked by uid 111); 20 Nov 2020 00:17:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Nov 2020 19:17:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Nov 2020 19:17:23 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/4] t0000: keep clean-up tests together
Message-ID: <20201120001723.GA307112@coredump.intra.peff.net>
References: <20201120001458.GA274082@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201120001458.GA274082@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We check that test_when_finished cleans up after a test, and that it
runs even after a failure. Those two were originally adjacent, but got
split apart by the new test added in 477dcaddb6 (tests: do not let lazy
prereqs inside `test_expect_*` turn off tracing, 2020-03-26), and then
further by more lazy-prereq tests. Let's move them back together.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0000-basic.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index f4ba2e8c85..d49b5dd4ac 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -829,17 +829,6 @@ then
 	exit 1
 fi
 
-clean=no
-test_expect_success 'tests clean up after themselves' '
-	test_when_finished clean=yes
-'
-
-if test -z "$GIT_TEST_FAIL_PREREQS_INTERNAL" -a $clean != yes
-then
-	say "bug in test framework: basic cleanup command does not work reliably"
-	exit 1
-fi
-
 test_lazy_prereq NESTED_INNER '
 	>inner &&
 	rm -f outer
@@ -874,6 +863,17 @@ test_expect_success 'lazy prereqs do not turn off tracing' "
 	grep 'echo trace' lazy-prereq-and-tracing/err
 "
 
+clean=no
+test_expect_success 'tests clean up after themselves' '
+	test_when_finished clean=yes
+'
+
+if test -z "$GIT_TEST_FAIL_PREREQS_INTERNAL" -a $clean != yes
+then
+	say "bug in test framework: basic cleanup command does not work reliably"
+	exit 1
+fi
+
 test_expect_success 'tests clean up even on failures' "
 	run_sub_test_lib_test_err \
 		failing-cleanup 'Failing tests with cleanup commands' <<-\\EOF &&
-- 
2.29.2.730.g3e418f96ba

