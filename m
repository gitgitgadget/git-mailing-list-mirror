Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECB181FC43
	for <e@80x24.org>; Sun, 12 Mar 2017 11:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755721AbdCLLMX (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 07:12:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:42781 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753548AbdCLLMW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 07:12:22 -0400
Received: (qmail 24054 invoked by uid 109); 12 Mar 2017 11:12:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Mar 2017 11:12:20 +0000
Received: (qmail 12022 invoked by uid 111); 12 Mar 2017 11:12:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Mar 2017 07:12:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Mar 2017 07:12:18 -0400
Date:   Sun, 12 Mar 2017 07:12:18 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 4/4] ref-filter: use separate cache for contains_tag_algo
Message-ID: <20170312111217.swapjaazeg3wbuyt@sigill.intra.peff.net>
References: <20170309132728.c57ltzel746l366a@sigill.intra.peff.net>
 <20170309132949.shyc4gmdrhazykev@sigill.intra.peff.net>
 <CACBZZX5A46-ua9y_HxqrqycQviR0uGnStnaPwH9jukzPVak6ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX5A46-ua9y_HxqrqycQviR0uGnStnaPwH9jukzPVak6ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 11, 2017 at 09:01:25PM +0100, Ævar Arnfjörð Bjarmason wrote:

> On Thu, Mar 9, 2017 at 2:29 PM, Jeff King <peff@peff.net> wrote:
> > [...]
> > @@ -1874,6 +1886,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
> >                 broken = 1;
> >         filter->kind = type & FILTER_REFS_KIND_MASK;
> >
> > +       init_contains_cache(&ref_cbdata.contains_cache);
> > +
> >         /*  Simple per-ref filtering */
> > [...]
> >
> > +       clear_contains_cache(&ref_cbdata.contains_cache);
> >
> >         /*  Filters that need revision walking */
> >         if (filter->merge_commit)
> 
> Shouldn't both of those be guarded by a "if (filter->with_commit)" test?

I thought about that while writing it, but decided that it was not worth
complicating the initialization and cleanup with conditionals. The
initialization is on par with what we would normally do with a static
struct initializer, and the cleanup is a noop if the cache wasn't
touched.

So my thinking was that it didn't matter either way, and dropping the
conditional was one less thing for readers of the code to have to worry
about.

That said, I'm not opposed to doing it the other way.

> That init/clear codepath is rather light, but it seems to me that we
> can avoid it entirely if filter->with_commit isn't defined. I've
> tested this locally and it still passes all tests.

Yes, it should be correct either way.

-Peff
