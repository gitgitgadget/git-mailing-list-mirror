Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1A6A1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 21:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbdB0Vss (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 16:48:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:35191 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751756AbdB0Vsc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 16:48:32 -0500
Received: (qmail 31719 invoked by uid 109); 27 Feb 2017 21:41:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 21:41:49 +0000
Received: (qmail 20419 invoked by uid 111); 27 Feb 2017 21:41:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 16:41:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2017 16:41:47 -0500
Date:   Mon, 27 Feb 2017 16:41:47 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t6300: avoid creating refs/heads/HEAD
Message-ID: <20170227214147.5ezxskhihi3cc77m@sigill.intra.peff.net>
References: <20170227092931.7iquwaxomeuuusi2@sigill.intra.peff.net>
 <xmqqzih7whrw.fsf@gitster.mtv.corp.google.com>
 <20170227205151.rjhod347ddhmdmxp@sigill.intra.peff.net>
 <xmqqshmzuyam.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshmzuyam.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 01:19:29PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I suspect there are a lot of other places that are less clear cut. E.g.,
> > I think just:
> >
> >   git branch foo bar
> >
> > will put "foo" through the same interpretation. So you could do:
> >
> >   git branch -f @{-1} bar
> >
> > Is that insane? Maybe. But it does work now.
> 
> No, it _is_ very sensible, so is "git checkout -B @{-1} <someplace>"
> 
> Perhaps interpret-branch-name that does not error out when given "@"
> is what is broken?  I suspect that calling interpret_empty_at() from
> that function is fundamentally flawed.  The "@" end user types never
> means refs/heads/HEAD, and HEAD@{either reflog or -1} would not mean
> anything that should be taken as a branch_name, either.
> 
> So perhaps what interpret_empty_at() does is necessary for the "four
> capital letters is too many to type, so just type one key while
> holding a shift", but it should be called from somewhere else, and
> not from interpret_branch_name()?

I think _most_ of interpret_branch_name() is in the same boat. The
"@{upstream}" mark is not likely to give you a branch in refs/heads
either.

So in practice, I think strbuf_check_branch_ref() could probably get by
with just calling interpret_nth_prior_checkout(). Or if you prefer, to
rip everything out of interpret_branch_name() except that. :) But that
other stuff has to go somewhere, and there are some challenges with the
recursion from reinterpret().

The "other" stuff could sometimes be useful, I guess. It's not _always_
wrong to do:

  git branch -f @{upstream} foo

It depends on what your @{upstream} resolves to. Switching to just using
interpret_nth_prior_checkout() would break the case when it resolves to
a local branch. I'm not sure if we're OK with that or not. If we want to
keep all the existing cases working, I think we need something like the
"not_in_refs_heads" patch I posted elsewhere.

-Peff
