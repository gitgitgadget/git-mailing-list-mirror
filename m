Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 474091F404
	for <e@80x24.org>; Tue, 20 Mar 2018 05:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751022AbeCTFm0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 01:42:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:35528 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750768AbeCTFmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 01:42:25 -0400
Received: (qmail 1124 invoked by uid 109); 20 Mar 2018 05:42:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Mar 2018 05:42:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29399 invoked by uid 111); 20 Mar 2018 05:43:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Mar 2018 01:43:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Mar 2018 01:42:23 -0400
Date:   Tue, 20 Mar 2018 01:42:23 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        lars.schneider@autodesk.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/2] routines to generate JSON data
Message-ID: <20180320054223.GC15813@sigill.intra.peff.net>
References: <20180316194057.77513-1-git@jeffhostetler.com>
 <20180316211837.GB12333@sigill.intra.peff.net>
 <e2a9d2a9-f2e2-f285-52c3-be11668da543@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2a9d2a9-f2e2-f285-52c3-be11668da543@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 06:19:26AM -0400, Jeff Hostetler wrote:

> > To make the above work, I think you'd have to store a little more state.
> > E.g., the "array_append" functions check "out->len" to see if they need
> > to add a separating comma. That wouldn't work if we might be part of a
> > nested array. So I think you'd need a context struct like:
> > 
> >    struct json_writer {
> >      int first_item;
> >      struct strbuf out;
> >    };
> >    #define JSON_WRITER_INIT { 1, STRBUF_INIT }
> > 
> > to store the state and the output. As a bonus, you could also use it to
> > store some other sanity checks (e.g., keep a "depth" counter and BUG()
> > when somebody tries to access the finished strbuf with a hanging-open
> > object or array).
> 
> Yeah, I thought about that, but I think it gets more complex than that.
> I'd need a stack of "first_item" values.  Or maybe the _begin() needs to
> increment a depth and set first_item and the _end() needs to always
> unset first_item.  I'll look at this gain.

I think you may be able to get by with just unsetting first_item for any
"end". Because as you "pop" to whatever data structure is holding
whatever has ended, you know it's no longer the first item (whatever
just ended was there before it).

I admit I haven't thought too hard on it, though, so maybe I'm missing
something.

> The thing I liked about the bottom-up construction is that it is easier
> to collect multiple sets in parallel and combine them during the final
> roll-up.  With the in-line nesting, you're tempted to try to construct
> the resulting JSON in a single series and that may not fit what the code
> is trying to do.  For example, if I wanted to collect an array of error
> messages as they are generated and an array of argv arrays and any alias
> expansions, then put together a final JSON string containing them and
> the final exit code, I'd need to build it in parts.  I can build these
> parts in pieces of JSON and combine them at the end -- or build up other
> similar data structures (string arrays, lists, or whatever) and then
> have a JSON conversion step.  But we can make it work both ways, I just
> wanted to keep it simpler.

Yeah, I agree that kind of bottom-up construction would be nice for some
cases. I'm mostly worried about inefficiency copying the strings over
and over as we build up the final output.  Maybe that's premature
worrying, though.

If the first_item thing isn't too painful, then it might be nice to have
both approaches available.

> > In general I'd really prefer to keep the shell script as the driver for
> > the tests, and have t/helper programs just be conduits. E.g., something
> > like:
> > 
> >    cat >expect <<-\EOF &&
> >    {"key": "value", "foo": 42}
> >    EOF
> >    test-json-writer >actual \
> >      object_begin \
> >      object_append_string key value \
> >      object_append_int foo 42 \
> >      object_end &&
> >    test_cmp expect actual
> > 
> > It's a bit tedious (though fairly mechanical) to expose the API in this
> > way, but it makes it much easier to debug, modify, or add tests later
> > on (for example, I had to modify the C program to find out that my
> > append example above wouldn't work).
> 
> Yeah, I wasn't sure if such a simple api required exposing all that
> machinery to the shell or not.  And the api is fairly self-contained
> and not depending on a lot of disk/repo setup or anything, so my tests
> would be essentially static WRT everything else.
> 
> With my t0019 script you should have been able use -x -v to see what
> was failing.

I was able to run the test-helper directly. The tricky thing is that I
had to write new C code to test my theory about how the API worked.
Admittedly that's not something most people would do regularly, but I
often seem to end up doing that kind of probing and debugging. Many
times I've found the more generic t/helper programs useful.

I also wonder if various parts of the system embrace JSON, if we'd want
to have a tool for generating it as part of other tests (e.g., to create
"expect" files).

-Peff
