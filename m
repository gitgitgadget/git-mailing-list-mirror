Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE8B71F453
	for <e@80x24.org>; Thu, 20 Sep 2018 20:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbeIUBvi (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 21:51:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:54238 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387985AbeIUBvi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 21:51:38 -0400
Received: (qmail 4842 invoked by uid 109); 20 Sep 2018 20:06:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Sep 2018 20:06:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28336 invoked by uid 111); 20 Sep 2018 20:06:23 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Sep 2018 16:06:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Sep 2018 16:06:27 -0400
Date:   Thu, 20 Sep 2018 16:06:27 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] transport.c: introduce core.alternateRefsCommand
Message-ID: <20180920200627.GA536@sigill.intra.peff.net>
References: <cover.1537466087.git.me@ttaylorr.com>
 <4c4900722cab253b3ce33cb28910c4602ce44536.1537466087.git.me@ttaylorr.com>
 <20180920193751.GC29603@sigill.intra.peff.net>
 <20180920200034.GA83799@syl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180920200034.GA83799@syl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 20, 2018 at 04:00:34PM -0400, Taylor Blau wrote:

> > My "rev-list --alternate-refs" patches _do_ use the refnames, since you
> > could do something like "--source" that cares about them. But there's
> > some awkwardness there, because the names are in a different namespace
> > than the rest of the refs. If we were to just say "nope, you do not get
> > to see the names of the alternates" then that awkwardness goes away. But
> > it also loses some information that could _possibly_ be of use to a
> > caller.
> >
> > Back in that earlier discussion I did not have a strong opinion, but
> > here we are cementing that decision into a user-visible interface. So it
> > probably makes sense to revisit and decide once and for all.
> 
> Interesting, and thanks for the link to the prior discussion. I think
> that I agree mostly with your rationale in [1], which boils down (for
> me) to:
> 
>   - Other callers (like 'rev-list --alternate-refs') might care about
>     them. Even if we don't have those patches in Git today, it's worth
>     keeping their use case(s) in mind.
> 
>   - I didn't measure either, but I can't imagine that we're paying a
>     huge price for this. So, it might be easy enough to keep saying,
>     "please write output as '%(objectname) SP %(refname)'", even if we
>     end up throwing out the refname, anyway.

TBH, the main advantage to me is that it makes the user-visible
interface way simpler. We just say "give us a list of object ids, one
per line". I guess the current spec is not too bad, especially given
that we can just provide a for-each-ref format that generates it.

> > Probably not worth nit-picking process count, but this could done with a
> > single "update-ref --stdin".
> 
> Sure, I don't think that 7 `update-ref`'s vs 2 (`cat` + `git update-ref
> --stdin`) will make or break the series, but I can happily shorten it as
> you suggest ;-).

Yeah, in retrospect I should have not have even mentioned it.
test_commit() already adds a bunch of extra processes you may or may not
care about (e.g., by making tags, or using "git add" when "commit -a"
might do).

> > > +	cat >expect <<-EOF &&
> > > +	$(git rev-parse a) .have
> > > +	$(git rev-parse c) .have
> > > +	EOF
> > > +	printf "0000" | git receive-pack fork | extract_haves >actual &&
> >
> > There's been a push lately to avoid having git on the left-hand side of
> > a fork, since we might otherwise miss its exit code (including things

Heh, I meant to say "left-hand side of a pipe", but you obviously
figured out what I meant. :)

-Peff
