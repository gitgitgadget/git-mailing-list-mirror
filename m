Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE3101FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932132AbdC1T4K (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:56:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:53213 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932098AbdC1T4J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:56:09 -0400
Received: (qmail 12415 invoked by uid 109); 28 Mar 2017 19:56:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:56:08 +0000
Received: (qmail 24952 invoked by uid 111); 28 Mar 2017 19:56:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:56:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:56:06 -0400
Date:   Tue, 28 Mar 2017 15:56:06 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 0/2] read-cache: call verify_hdr() in a background
 thread
Message-ID: <20170328195605.xy4pnhy74s6wgwps@sigill.intra.peff.net>
References: <20170328190732.59486-1-git@jeffhostetler.com>
 <20170328191628.dprziuhpv7khvocu@sigill.intra.peff.net>
 <35f220df-aa63-b80f-8970-429850202cdd@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <35f220df-aa63-b80f-8970-429850202cdd@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 03:50:34PM -0400, Jeff Hostetler wrote:

> It was a convenient way to isolate, average, and compare
> read_index() times, but I suppose we could do something
> like that.
> 
> I did confirm that a ls-files does show a slight 0.008
> second difference on the 58K file Linux tree when toggled
> on or off.

Yeah, I agree it helps isolate the change. I'm just not sure we want to
carry a bunch of function-specific perf-testing code. And one of the
nice things about testing a real command is that it's...a real command.
So it's an actual improvement a user might see.

> But I'm tempted to suggest that we just omit my helper exe
> and not worry about a test -- since we don't have any test
> repos large enough to really demonstrate the differences.
> My concern is that that 0.008 would be lost in the noise
> of the rest of the test and make for an unreliable result.

Yeah, I think that would be fine. You _could_ write a t/perf test and
then use your 400MB monstrosity as GIT_PERF_LARGE_REPO. But given that
most people don't have such a thing, there's not much value over you
just showing off the perf improvement in the commit message.

We could also have a t/perf test that generates a monstrous index and
shows that it's faster. But frankly, I don't think this is all that
interesting as a performance regression test. It's not like there's
something subtle about the performance improvement; we stopped computing
the SHA-1, and (gasp!) it takes exactly one SHA-1 computation's less
time.

So just mentioning the test case and the improvement in the commit
message is sufficient, IMHO.

-Peff
