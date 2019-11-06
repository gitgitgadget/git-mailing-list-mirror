Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 965E51F454
	for <e@80x24.org>; Wed,  6 Nov 2019 04:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbfKFEDP (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 23:03:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:40096 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725768AbfKFEDP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 23:03:15 -0500
Received: (qmail 17646 invoked by uid 109); 6 Nov 2019 04:03:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Nov 2019 04:03:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19279 invoked by uid 111); 6 Nov 2019 04:06:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Nov 2019 23:06:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Nov 2019 23:03:14 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Danh Doan <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] sequencer: reencode to utf-8 before arrange
 rebase's todo list
Message-ID: <20191106040314.GA4307@sigill.intra.peff.net>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1572596278.git.congdanhqx@gmail.com>
 <b7927b27235422ac53595cfaa63b4f1cbe009013.1572596278.git.congdanhqx@gmail.com>
 <20191101165921.GD26219@sigill.intra.peff.net>
 <20191102010215.GB17624@danh.dev>
 <20191105080010.GA7415@sigill.intra.peff.net>
 <xmqqftj1yeo5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqftj1yeo5.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 06, 2019 at 10:30:34AM +0900, Junio C Hamano wrote:

> > That's normally what we do. The only cases we're covering here are when
> > somebody has explicitly asked that the commit object be stored in
> > another encoding. Presumably they'd also be using a matching
> > i18n.logOutputEncoding in that case, in which case logmsg_reencode()
> > would be a noop. I think the only reasons to do that are:
> >
> >   1. You're stuck on some legacy encoding for your terminal. But in that
> >      case, I think you'd still be better off storing utf-8 and
> >      translating on the fly, since whatever encoding you do store is
> >      baked into your objects for all time (so accept some slowness now,
> >      but eventually move to utf-8).
> >
> >   2. Your preferred language is bigger in utf-8 than in some specific
> >      encoding, and you'd rather save some bytes. I'm not sure how big a
> >      deal this is, given that commit messages don't tend to be that big
> >      in the first place (compared to trees and blobs). And the zlib
> >      deflation on the result might help remove some of the redundancy,
> >      too.
> 
> Perhaps add
> 
>     3. You are dealing with a project originated on and migrated
>        from a foreign SCM, and older parts of the history is stored
>        in a non-utf-8, even though recent history is in utf-8
> 
> to the mix?

I would think you'd want to convert to utf-8 as you do the migration in
that case, since you're writing new hashes anyway. But I think a similar
case would just be an old Git repository, where for some reason you
thought i18n.commitEncoding was a good idea back then (perhaps because
you were in situation (1) then, but now you aren't).

In either case, though, I don't think it's a compelling motivation for
optimization, if only because those old commits will be shown less and
less (and even without modern optimizations like commit-graph, we'd
generally avoid reencoding those old commits unless we're actually going
to _show_ them).

> I suspect even the heavy Windows/Mac users in Japan have migrated
> out of legacy (the suspicion comes from an anecdote that is offtopic
> here).

Thanks for the data point. All of this is very far from my personal
experience, so I mostly go on scraps of hearsay I pick up reading this
or that. :)

-Peff
