Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02A541F404
	for <e@80x24.org>; Sat, 24 Feb 2018 04:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752217AbeBXEBx (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 23:01:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:35122 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751943AbeBXEBw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 23:01:52 -0500
Received: (qmail 3150 invoked by uid 109); 24 Feb 2018 04:01:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Feb 2018 04:01:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23407 invoked by uid 111); 24 Feb 2018 04:02:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 23 Feb 2018 23:02:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Feb 2018 23:01:49 -0500
Date:   Fri, 23 Feb 2018 23:01:49 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 13/35] ls-refs: introduce ls-refs server command
Message-ID: <20180224040149.GA16743@sigill.intra.peff.net>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-14-bmwill@google.com>
 <20180222094831.GB12442@sigill.intra.peff.net>
 <20180223004514.GP185096@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180223004514.GP185096@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 22, 2018 at 04:45:14PM -0800, Brandon Williams wrote:

> > This kind of tail matching can't quite implement all of the current
> > behavior. Because we actually do the normal dwim_ref() matching, which
> > includes stuff like "refs/remotes/%s/HEAD".
> > 
> > The other problem with tail-matching is that it's inefficient on the
> > server. Ideally we could get a request for "master" and only look up
> > refs/heads/master, refs/tags/master, etc. And if there are 50,000 refs
> > in refs/pull, we wouldn't have to process those at all. Of course this
> > is no worse than the current code, which not only looks at each ref but
> > actually _sends_ it. But it would be nice if we could fix this.
> > 
> > There's some more discussion in this old thread:
> > 
> >   https://public-inbox.org/git/20161024132932.i42rqn2vlpocqmkq@sigill.intra.peff.net/
> 
> Thanks for the pointer.  I was told to be wary a while about about
> performance implications on the server but no discussion ensued till now
> about it :)
> 
> We always have the ability to extend the patterns accepted via a feature
> (or capability) to ls-refs, so maybe the best thing to do now would only
> support a few patterns with specific semantics.  Something like if you
> say "master" only match against refs/heads/ and refs/tags/ and if you
> want something else you would need to specify "refs/pull/master"?

The big question is whether you want to break compatibility with the
existing program behavior. If not, then I think you have to ask for
every variant in ref_rev_parse_rules (of which there are 6 variants).

Which sounds pretty gross, but it actually may not be _too_ bad. Most
fetches tend to ask for either a single name, or they use left-anchored
wildcards. So it would work to just have the client expand all of the
possibilities itself into fully-qualified refs, and keep the server as
dumb as possible.

And then the server for now can just cull based on the pattern list,
like you have here. But later, we could optimize it to look up the
individual patterns, which should be cheaper, since we'd generally have
many fewer patterns than total refs.

> > Does the client have to be aware that we're using wildmatch? I think
> > they'd need "refs/heads/**" to actually implement what we usually
> > specify in refspecs as "refs/heads/*". Or does the lack of WM_PATHNAME
> > make this work with just "*"?
> > 
> > Do we anticipate that the client would left-anchor the refspec like
> > "/refs/heads/*" so that in theory the server could avoid looking outside
> > of /refs/heads/?
> 
> Yeah we may want to anchor it by providing the leading '/' instead of
> just "refs/<blah>".

I actually wonder if we should just specify that the patterns must
_always_ be fully-qualified, but may end with a single "/*" to iterate
over wildcards. Or even simpler, that "refs/heads/foo" would find that
ref itself, and anything under it.

That drops any question about how wildcards work (e.g., does "refs/foo*"
work to find "refs/foobar"?).

> I need to read over the discussion you linked to more but what sort of
> ref patterns do you believe we should support as part of the initial
> release of v2?  It seems like you wanted this at some point in the past
> so I assume you have an idea of what sort of filtering would be
> beneficial.

My goals were just optimizing:

  1. Don't send all the refs across the wire if we can avoid it.

  2. Don't even iterate over all the refs internally if we can avoid it.

Especially with the new binary-searching packed-refs code, we should be
able to serve a request like "ls-refs refs/heads/*" without looking into
"refs/pull" or "refs/changes" at all.

-Peff
