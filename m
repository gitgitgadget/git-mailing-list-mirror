Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6562CC83004
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 08:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8B9206A5
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 08:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgD1IOX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:14:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:42032 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726377AbgD1IOX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 04:14:23 -0400
Received: (qmail 19554 invoked by uid 109); 28 Apr 2020 08:14:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Apr 2020 08:14:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32525 invoked by uid 111); 28 Apr 2020 08:25:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Apr 2020 04:25:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Apr 2020 04:14:21 -0400
From:   Jeff King <peff@peff.net>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] t0000: disable GIT_TEST_FAIL_PREREQS in sub-tests
Message-ID: <20200428081421.GA2381876@coredump.intra.peff.net>
References: <CAL3xRKc6Q1m=9XJYcafhczCU+ONYjapkUgBi0nKMFoMr+bgjYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL3xRKc6Q1m=9XJYcafhczCU+ONYjapkUgBi0nKMFoMr+bgjYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 08:52:34AM +0200, Son Luong Ngoc wrote:

> Running t0000 with GIT_TEST_FAIL_PREREQS=true is failing.
> 
> > GIT_TEST_FAIL_PREREQS=true ./t0000-basic.sh
> t/./t0000-basic.sh:836: error: not ok 45 - lazy prereqs do not turn off tracing
> #
> #               run_sub_test_lib_test lazy-prereq-and-tracing
>  'lazy prereqs and -x' -v -x <<-\EOF &&
> #               test_lazy_prereq LAZY true
> #
> #               test_expect_success lazy 'test_have_prereq LAZY && echo trace'
> #
> #               test_done
> #               EOF
> #
> #               grep 'echo trace' lazy-prereq-and-tracing/err

I think the patch below is the right fix.

-- >8 --
Subject: [PATCH] t0000: disable GIT_TEST_FAIL_PREREQS in sub-tests

The test added by 477dcaddb6 (tests: do not let lazy prereqs inside
`test_expect_*` turn off tracing, 2020-03-26) runs a sub-test script
that traces a test with a lazy prereq, like:

  test_have_prereq LAZY && echo trace

That won't work if GIT_TEST_FAIL_PREREQS is set in the environment,
because our have_prereq will report failure, and we won't run the echo
at all.

We could work around this by avoiding the &&-chain, but we can
fix this and any future tests at once by unsetting that variable for our
sub-tests. These are meant to be controlled environments where we test
the test-suite itself; the outer test snippet should be in charge of the
sub-test environment, not whatever mode the user happens to be running
in.

Reported-by: Son Luong Ngoc <sluongng@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0000-basic.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index b859721620..f58f3deaa8 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -98,6 +98,7 @@ _run_sub_test_lib_test_common () {
 		export TEST_DIRECTORY &&
 		TEST_OUTPUT_DIRECTORY=$(pwd) &&
 		export TEST_OUTPUT_DIRECTORY &&
+		sane_unset GIT_TEST_FAIL_PREREQS &&
 		if test -z "$neg"
 		then
 			./"$name.sh" "$@" >out 2>err
-- 
2.26.2.827.g3c1233342b

