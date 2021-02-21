Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BCFC433DB
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 21:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15A164EB4
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 21:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhBUVvh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Feb 2021 16:51:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:39796 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbhBUVvh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Feb 2021 16:51:37 -0500
Received: (qmail 14778 invoked by uid 109); 21 Feb 2021 21:50:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 21 Feb 2021 21:50:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2962 invoked by uid 111); 21 Feb 2021 21:50:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 21 Feb 2021 16:50:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 21 Feb 2021 16:50:42 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 1/2] tests: don't mess with fd 7 of test helper functions
Message-ID: <YDLVsjumwSXgEU7k@coredump.intra.peff.net>
References: <20210221192512.3096291-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210221192512.3096291-1-szeder.dev@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 21, 2021 at 08:25:11PM +0100, SZEDER Gábor wrote:

> The root of the issue stems from a5bf824f3b (t: prevent '-x' tracing
> from interfering with test helpers' stderr, 2018-02-25), where we
> started to use a couple of file descriptor duplications and
> redirections to separate the standard error of git commands exercised
> in test helper functions from the stderr containing the '-x' trace
> output of said helper functions.  To achieve that the git command's
> stderr is redirected to the test helper function's fd 7, which was
> previously duplicated from the helper's stderr.  Alas, fd 7 was not
> the right choice for this purpose, because fd 7 is the original
> standard error of the test script, and, consequently, we now can't
> send error messages from within such test helper functions directly to
> the test script's stderr.  Since BUG() does want to send its error
> message there it doesn't work as expected in such test helper
> functions, because:
> 
>   - If the test helper's stderr were redirected to a file (as is often
>     the case e.g. with 'test_must_fail'), then the "bug in the test
>     script" error message would end up in that file.
> 
>   - If the test script is invoked without any of the verbose options,
>     then that error message would get lost to /dev/null, leaving no
>     clues about why the test script aborted so suddenly.

Makes sense. Well explained.

> Use fd 6 instead of fd 7 for these '-x' tracing related duplications
> and redirections.  It is a better choice for this purpose, because fd
> 6 is the test script's original standard input, and neither these test
> helper functions not the git commands exercised by them should ever
> read from the test scipt's stdin, see 781f76b158 (test-lib: redirect
> stdin of tests, 2011-12-15).  Update the aforementioned error
> reporting in 'test_must_fail' to send the error message to fd 6 as
> well; the next patch will update it to use BUG() instead.

s/scipt/script/ in the paragraph above.

I agree that 6 is probably reasonable. I wonder if it is worth having a
master comment describing the function of various descriptors within the
test suite, so that people know which ones are available for which
purposes.  It is getting awfully crowded in that space. Sadly, I don't
think we can portably use numbers higher than 9 (bash is happy to, but
even dash cannot).

Of course people would have to know to look for said comment, which they
may not do. :)

-Peff
