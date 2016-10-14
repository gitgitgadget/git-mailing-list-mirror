Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E85C1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 23:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbcJNX5X (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 19:57:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:57724 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751195AbcJNX5V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 19:57:21 -0400
Received: (qmail 8412 invoked by uid 109); 14 Oct 2016 23:57:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Oct 2016 23:57:21 +0000
Received: (qmail 11585 invoked by uid 111); 14 Oct 2016 23:57:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Oct 2016 19:57:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Oct 2016 19:57:18 -0400
Date:   Fri, 14 Oct 2016 19:57:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] test-lib: detect common misuse of test_expect_failure
Message-ID: <20161014235718.2rbejrzs5axhopt7@sigill.intra.peff.net>
References: <xmqqk2day2ry.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk2day2ry.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2016 at 03:38:41PM -0700, Junio C Hamano wrote:

> It is a very easy mistake to make to say test_expect_failure when
> making sure a step in the test fails, which must be spelled
> "test_must_fail".  By introducing a toggle $test_in_progress that is
> turned on at the beginning of test_start_() and off at the end of
> test_finish_() helper, we can detect this fairly easily.
> 
> Strictly speaking, writing "test_expect_success" inside another
> test_expect_success (or inside test_expect_failure for that matter)
> can be detected with the same mechanism if we really wanted to, but
> that is a lot less likely confusion, so let's not bother.

I like the general idea, but I'm not sure how this would interact with
the tests in t0000 that test the test suite. It looks like that always
happens in a full sub-shell invocation (via run_sub_test_lib_test), so
we're OK as long as test_in_progress is not exported (and obviously the
subshell cannot accidentally overwrite our variable with a 0 when it is
finished).

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index fdaeb3a96b..fc8c10a061 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -381,6 +381,10 @@ test_verify_prereq () {
>  }
>  
>  test_expect_failure () {
> +	if test "$test_in_progress" = 1
> +	then
> +		error "bug in the test script: did you mean test_must_fail instead of test_expect_failure?"
> +	fi

This follows existing practice for things like the &&-lint-checker, and
bails out on the whole test script. That sometimes makes it hard to find
the problematic test, especially if you're running via something like
"prove", because it doesn't make valid TAP output.

It might be nicer if we just said "this test is malformed, and therefore
fails", and then you get all the usual niceties for recording and
finding the failed test.

I don't think it would be robust enough to try to propagate the error up
to the outer test_expect_success block (and anyway, you'd also want to
know about it in a test_expect_failure block; it's a bug in the test,
not a known breakage). But perhaps error() could dump some TAP-like
output with a "virtual" failed test.

Something like:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 11562bd..dc6b1f5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -299,9 +299,8 @@ TERM=dumb
 export TERM
 
 error () {
-	say_color error "error: $*"
-	GIT_EXIT_OK=t
-	exit 1
+	test_failure_ "$@"
+	test_done
 }
 
 say () {
@@ -600,7 +599,7 @@ test_run_ () {
 		# code of other programs
 		test_eval_ "(exit 117) && $1"
 		if test "$?" != 117; then
-			error "bug in the test script: broken &&-chain: $1"
+			error "bug in the test script: broken &&-chain" "$1"
 		fi
 		trace=$trace_tmp
 	fi

which lets "make prove" collect the broken test number.

It would perhaps need to cover the case when $test_count is "0"
separately. I dunno. It would be nicer still if we could continue
running other tests in the script, but I think it's impossible to
robustly jump back to the outer script.

These kinds of "bug in the test suite" are presumably rare enough that
the niceties don't matter that much, but I trigger the &&-checker
reasonably frequently (that and test_line_count, because I can never
remember the correct invocation).

Anyway. That's all orthogonal to your patch. I just wondered if we could
do better, but AFAICT the right way to do better is to hook into
error(), which means your patch would not have to care exactly how it
fails.

-Peff
