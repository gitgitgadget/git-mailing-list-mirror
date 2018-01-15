Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5F7F1F406
	for <e@80x24.org>; Mon, 15 Jan 2018 22:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeAOWJu (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 17:09:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:44464 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750764AbeAOWJt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 17:09:49 -0500
Received: (qmail 16376 invoked by uid 109); 15 Jan 2018 22:09:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 15 Jan 2018 22:09:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20274 invoked by uid 111); 15 Jan 2018 22:10:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 15 Jan 2018 17:10:23 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jan 2018 17:09:47 -0500
Date:   Mon, 15 Jan 2018 17:09:47 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 01/18] cat-file: split expand_atom into 2 functions
Message-ID: <20180115220946.GF4778@sigill.intra.peff.net>
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
 <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <20180115213335.GB4778@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180115213335.GB4778@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 15, 2018 at 04:33:35PM -0500, Jeff King wrote:

> That works, but I don't think it's where we want to end up in the long
> run. Because:
> 
>   1. We still have the set of formats duplicated between expand_atom()
>      and the "preparation" step. It's just that the preparation is now
>      in ref-filter.c. What happens if ref-filter.c learns new formatting
>      placeholders (or options for those placeholders) that cat-file.c
>      doesn't, or vice versa? The two have to be kept in sync.
> 
>   2. We're missing out on all of the other placeholders that ref-filter
>      knows about. Not all of them are meaningful (e.g., %(refname)
>      wouldn't make sense here), but part of our goal is to support the
>      same set of placeholders as much as possible. Some obvious ones
>      that ought to work for cat-file: %(objectname:short), %(if), and
>      things like %(subject) when the appropriate object type is used.
> 
> In other words, I think the endgame is that expand_atom() isn't there at
> all, and we're calling the equivalent of format_ref_item() for each
> object (except that in a unified formatting world, it probably doesn't
> have the word "ref" in it, since that's just one of the items a caller
> might pass in).

I read carefully up through about patch 6, and then skimmed through the
rest. I think we really want to push this in the direction of more
unification, as above. I know that the patches here may be a step on the
way, but I had a hard time evaluating each patch to see if it was
leading us in the right direction.

I think what would help for reviewing this is:

  1. Start with a cover letter that makes it clear what the end state of
     the series is, and why that's the right place to end up.

  2. Include a rough roadmap of the patches in the cover letter.
     Hopefully they should group into a few obvious steps (like "in
     patches 1-5, we're teaching ref-filter to support everything that
     cat-file can do, then in 6-10 we're preparing cat-file for the
     conversion, and then in 11 we do the conversion"). If it doesn't
     form a coherent narrative, then it may be worth stepping back and
     thinking about combining or reordering the patches in a different
     way, so that the progression becomes more plain.

     I think one of the things that makes the progression here hard to
     understand (for me, anyway) is that it's "inside out" of what I'd
     expect. There's a lot of code movement happening first, and then
     refactoring and simplifying after that. So between those two steps,
     there's a lot of interim ugliness (e.g., having to reach across
     module boundaries to look at expand_data). It's hard to tell when
     looking at each individual patch how necessary the ugliness is, and
     whether and when it's going to go away later in the series.

There's a lot of good work here, and you've figured out a lot about how
the two systems function. I think we just need to rearrange things a bit
to make sure each step is moving in the right direction.

-Peff
