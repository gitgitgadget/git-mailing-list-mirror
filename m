Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 136C720C11
	for <e@80x24.org>; Thu, 30 Nov 2017 22:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750994AbdK3WDS (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 17:03:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:44900 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750926AbdK3WDS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 17:03:18 -0500
Received: (qmail 25819 invoked by uid 109); 30 Nov 2017 22:03:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Nov 2017 22:03:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32695 invoked by uid 111); 30 Nov 2017 22:03:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Thu, 30 Nov 2017 17:03:36 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Nov 2017 17:03:15 -0500
Date:   Thu, 30 Nov 2017 17:03:15 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 4/6] list-objects: filter objects in
 traverse_commit_list
Message-ID: <20171130220315.GA13784@sigill.intra.peff.net>
References: <20171121205852.15731-1-git@jeffhostetler.com>
 <20171121205852.15731-5-git@jeffhostetler.com>
 <CAGZ79kZR-W-_JJi7zptiGgv=W7KpNMaSEbmmxrXcKovznK9E7Q@mail.gmail.com>
 <21fbd685-2c96-91b9-700e-8902a6e99c08@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21fbd685-2c96-91b9-700e-8902a6e99c08@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 27, 2017 at 02:39:43PM -0500, Jeff Hostetler wrote:

> On 11/22/2017 5:56 PM, Stefan Beller wrote:
> > On Tue, Nov 21, 2017 at 12:58 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
> > > +       assert(arg);
> > > +       assert(!unset);
> > 
> > I count 16 asserts in this patch. Is that really needed?
> > Either omit them or use BUG if we want to rely on user
> > bug reports when these conditions trigger, as assert is unreliable
> > due to its dependence on the NDEBUG flag.
> 
> Yes, there are a few asserts in the code.  Old habits....
> 
> I could remove some/all of them, but personally I feel they
> have merit and hint to the mindset of the author for future
> readers of the code.  Are there other opinions?

I think I'd prefer in general to see assertions remain in one form or
another, if only because of the documentation benefits you mention here.

I do think there's such a thing as too many asserts, but I don't think I
see that here. "Too many" would probably be something like asserting
things that are a normal part of the contract (so "assert(foo)" on
every pointer parameter coming in to make sure it's not NULL).

I thought at first that's what was happening with the ones quoted above,
but it's actually documenting that no, we do not support "--no-filter"
in opt_parse_list_objects_filter (which is really checking that we're in
sync with the PARSE_OPT_NONEG found elsewhere).

So arguably my confusion argues that this one ought to have a custom
message or a comment.

Of course, it also makes me wonder whether we ought to just support
--no-filter. Shouldn't it just set us back to FILTER_DISABLED?

> Personally, I think it might be awkward to keep repeating
> something like:
> 
>     if (!c)
>         BUG(msg);
> 
> Do we want to think about a macro that builds on BUG() and
> does the test?
> 
> Something like:
>     #define ASSERT_OR_BUG(c) do { if (!(c)) BUG("%s", #c); } while (0)

Yeah, I think that was where the other thread[1] led to. IMHO that's
probably what BUG_ON() ought to do (though personally I'm fine with just
continuing to use assert for simple cases).

I think we can sidestep the whole variadic-macros thing mentioned in
that thread since we don't take a custom message.

-Peff

[1] https://public-inbox.org/git/20171122223827.26773-1-sbeller@google.com/
