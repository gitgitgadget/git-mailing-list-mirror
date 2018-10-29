Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D95D11F453
	for <e@80x24.org>; Mon, 29 Oct 2018 15:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeJ3AHs (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 20:07:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:59142 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726919AbeJ3AHs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 20:07:48 -0400
Received: (qmail 22549 invoked by uid 109); 29 Oct 2018 15:18:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Oct 2018 15:18:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18462 invoked by uid 111); 29 Oct 2018 15:17:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Oct 2018 11:17:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2018 11:18:42 -0400
Date:   Mon, 29 Oct 2018 11:18:42 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        gerardu@amazon.com, Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
Message-ID: <20181029151842.GJ17668@sigill.intra.peff.net>
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
 <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
 <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
 <20181027093300.GA23974@sigill.intra.peff.net>
 <CACsJy8A2MFbZQ-y5ufw-D6zzc-ye_gJmLVbDbgA+=2mhFiTusQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8A2MFbZQ-y5ufw-D6zzc-ye_gJmLVbDbgA+=2mhFiTusQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 27, 2018 at 04:04:32PM +0200, Duy Nguyen wrote:

> > Of course any cache raises questions of cache invalidation, but I think
> > we've already dealt with that for this case. When we use
> > OBJECT_INFO_QUICK, that is a sign that we want to make this kind of
> > accuracy/speed tradeoff (which does a similar caching thing with
> > packfiles).
> 
> We don't care about a separate process adding more loose objects while
> index-pack is running, do we? I'm guessing we don't but just to double
> check...

Right. That's basically what QUICK means: don't bother re-examining the
repository to handle simultaneous writes, even if it means saying an
object is not there when it has recently appeared.

So far it has only applied to packs, but this is really just the same
concept (just as we would not notice a new pack arriving, we will not
notice a new loose object arriving).

> > +/* probably should be configurable? */
> > +#define LOOSE_OBJECT_CACHE_MAX 65536
> 
> Yes, perhaps with gc.auto config value (multiplied by 256) as the cut
> point. If it's too big maybe just go with a bloom filter. For this
> particular case we expect like 99% of calls to miss.

I wonder, though, if we should have a maximum at all. The existing
examples I've found of this technique are:

  - mark_complete_and_common_ref(), which is trying to cover this exact
    case. It looks like it avoids adding more objects than there are
    refs, so I guess it actually has a pretty small cutoff.

  - find_short_object_filename(), which does the same thing with no
    limits. And there if we _do_ have a lot of objects, we'd still
    prefer to keep the cache.

And really, this list is pretty much equivalent to looking at a pack
.idx. The only difference is that one is mmap'd, but here we'd use the
heap. So it's not shared between processes, but otherwise the working
set size is similar.

-Peff
