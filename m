Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D5B41F403
	for <e@80x24.org>; Thu, 14 Jun 2018 17:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754780AbeFNRx2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 13:53:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:44728 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754741AbeFNRx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 13:53:28 -0400
Received: (qmail 24171 invoked by uid 109); 14 Jun 2018 17:53:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Jun 2018 17:53:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13601 invoked by uid 111); 14 Jun 2018 17:53:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Jun 2018 13:53:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jun 2018 13:53:26 -0400
Date:   Thu, 14 Jun 2018 13:53:26 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] t/lib-httpd: sort log based on timestamp to
 avoid occasional failure
Message-ID: <20180614175325.GA14935@sigill.intra.peff.net>
References: <20180614123107.11608-1-szeder.dev@gmail.com>
 <20180614123107.11608-5-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180614123107.11608-5-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 14, 2018 at 02:31:07PM +0200, SZEDER Gábor wrote:

> The last test of 't5561-http-backend.sh', 'server request log matches
> test results' may fail occasionally, because the order of entries in
> Apache's access log doesn't match the order of requests sent in the
> previous tests, although all the right requests are there.  I saw it
> fail on Travis CI five times in the span of about half a year, when
> the order of two subsequent requests was flipped, and could trigger
> the failure with a modified Git.  However, I was unable to trigger it
> with stock Git on my machine.  Three tests in
> 't5541-http-push-smart.sh' and 't5551-http-fetch-smart.sh' check
> requests in the log the same way, so they might be prone to a similar
> occasional failure as well.

I've occasionally run into these failures on my local box, too. I'm
happy somebody is looking into it (I have before, but eventually threw
up my hands in disgust).

> Now, by default the timestamp of a log entry marks the beginning of
> the request processing, not when the log entry gets written.  Since
> our requests are sent sequentially, sorting the log entries based on
> their timestamps would ensure that their order corresponds to the
> order of our requests.

That's a reasonably clever solution. One thing I wonder, though: are we
always guaranteed that the log entries are written _at all_ before we
look at them?

I.e., could we have a situation where we make a request, the client
finishes, and then we look at the logs, but nothing has been written by
apache yet?

>     I don't really like the fix in this patch.  I think an unfortunate
>     clock skew during the test run could mess up the sorting added in this
>     patch and cause test failure.  Or if DST or even a leap second happen
>     while the test is running.  Do we care?  Anyway, this occasional test
>     failure apparently happens more often than DST and leap seconds
>     combined.

We could probably eliminate DST issues by consistently using UTC for the
timestamps. Leap seconds are probably infrequent enough not to worry
about. More likely is something like clock adjustment due to ntp. Those
adjustments are usually small enough not to matter, but if we're talking
microseconds, it could trigger.

>     An alternative I considered was that we could decide that the order of
>     requests in the access log is not important as long as all the right
>     requests are there. This would inherently eliminate the raciness
>     issue, but if something were to go wrong, then it would become rather
>     hard to find out e.g. which request from which test has gone missing,
>     especially considering that several requests are sent in more than one
>     test.  We could address this by truncating the access log at the
>     beginning and checking its contents at the end of each test sending
>     requests.  Unfortunately, this would raise additional difficulties,
>     because all requests in t5561 come from tests included from
>     't556x-common', i.e. from tests shared with
>     't5560-http-backend-noserver.sh', which as its name suggests doesn't
>     run Apache and doesn't have an access log at all.

What if the test script provides the in-order expectation, but we check
only the unordered version (by sorting both actual and expected output
on the fly)? That would give us a more relaxed check most of the time,
but somebody digging in to a failure could run the ordered diff (or we
could even show it automatically on failure instead of just using
test_cmp).

>     Another alternative is to simply accept that these tests are racy, and
>     that the resulting test failures are rare enough that it isn't worth
>     the complexity of the workaround, but adding a comment to the affected
>     tests warning about the raciness is sufficient.  (But I wrote this
>     when I first saw and tracked down this failure; since then I observed
>     it four more times... :)

It's definitely bugged me. I'd be happy to see some solution. I've been
close to suggesting that reading apache logs is simply not robust, and
we should focus our tests on the git-visible state changes (e.g., seeing
successful requests, updated refs, etc).

A side effect of that is that it would become a lot easier to support
other webservers in our test scripts (though that may still be a fool's
errand just due to the amount of custom config we seem to carry).

>     Apache doesn't maintain 2.2 anymore; the final maintenance release
>     2.2.34 was released in July 2017, almost a year ago.  OTOH, our
>     't/lib-httpd/apache.conf' contains a couple of IfVersion directives
>     dealing with versions <2.4, and one even with <2.1.  How much do we
>     actually care about these unmaintained Apache versions, and how much
>     of this is just bitrotting?

I strongly suspect bitrotting. It looks like most of the "< 2.4"
directives are from 5 years ago (when Debian switched to 2.4 by
default), so even long-term stable systems would generally have it by
now (though I'm sure there's probably some RHEL version without it).

-Peff
