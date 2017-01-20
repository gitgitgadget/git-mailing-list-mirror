Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E34A320756
	for <e@80x24.org>; Fri, 20 Jan 2017 14:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbdATObO (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 09:31:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:42147 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752726AbdATOaf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 09:30:35 -0500
Received: (qmail 17867 invoked by uid 109); 20 Jan 2017 14:30:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Jan 2017 14:30:33 +0000
Received: (qmail 25696 invoked by uid 111); 20 Jan 2017 14:31:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Jan 2017 09:31:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jan 2017 09:30:32 -0500
Date:   Fri, 20 Jan 2017 09:30:32 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] log: new option decorate reflog of remote refs
Message-ID: <20170120143031.p2mux5uxxzniovkx@sigill.intra.peff.net>
References: <20170119122630.27645-1-pclouds@gmail.com>
 <20170119172310.6meuj6ksxloeee2t@sigill.intra.peff.net>
 <CACsJy8A_LkRMZYfoJuYEUok4r7Tw0VuMwVkG_Kr1o1hFcAUWNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8A_LkRMZYfoJuYEUok4r7Tw0VuMwVkG_Kr1o1hFcAUWNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2017 at 05:55:21PM +0700, Duy Nguyen wrote:

> > We already have very flexible ref-selectors like --remotes, --branches,
> > etc. The generalization of this would perhaps be something like:
> >
> >   git log --decorate-reflog --remotes --branches
> >
> > where "--decorate-reflog" applies to the next ref selector and then is
> > reset, the same way --exclude is. And it includes those refs _only_ for
> > decoration, not for traversal. So you could do:
> >
> >   git log --decorate-reflog --remotes --remotes
> >
> > if you wanted to see use those as traversal roots, too (if this is
> > common, it might even merit another option for "decorate and show").
> >
> > That's just off the top of my head, so maybe there are issues. I was
> > just surprised to see the "-remote" part in your option name.
> 
> Imposing order between options could cause confusion, I think, if you
> remove --decorate-reflog leaving --remotes on by accident, now you get
> --remotes with a new meaning. We could go with something like
> --decodate-reflog=remote, but that clashes with the number of reflog
> entries and we may need a separator, like --decorate-reflog=remote,3.
> Or we could add something to --decorate= in addition to
> short|full|auto|no. Something like --decorate=full,reflog or
> --decorate=full,reflog=remote,entries=3 if I want 3 reflog entries.

I agree that making option-order important is potentially confusing. But
it does already exist with --exclude. It's necessary to specify some
sets of refs (e.g., all of A, except for those that match B, and then
all of C, including those that match B).

Having --decorate-reflog=remote would be similarly constrained. You
couldn't do "decorate all remotes except for these ones". For that
matter, I'm not sure how you would do "decorate just the refs from
origin".

I'll grant that those are going to be a lot less common than just "all
the remotes" (or all the tags, or whatever). I'd just hate to see us
revisiting this in a year to generalize it, and being stuck with
historical baggage.

> My hesitant to go that far is because I suspect decorating reflog
> won't be helpful for non-remotes. But I'm willing to make more changes
> if it opens door to master.

Forgetting reflogs for a moment, I'd actually find it useful to just
decorate tags and local branches, but not remotes. But right now there
isn't any way to select which refs are worthy of decoration (reflog or
not).

That's why I'm thinking so much about a general ref-selection system. I
agree the "--exclude=... --remotes" thing is complicated, but it's also
the ref-selection system we _already_ have, which to me is a slight
point in its favor.

-Peff
