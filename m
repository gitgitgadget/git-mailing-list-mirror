Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 887351F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 19:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfHLTzi (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 15:55:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:41132 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726679AbfHLTzi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 15:55:38 -0400
Received: (qmail 27773 invoked by uid 109); 12 Aug 2019 19:55:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Aug 2019 19:55:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26467 invoked by uid 111); 12 Aug 2019 19:58:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Aug 2019 15:58:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Aug 2019 15:55:37 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, l.s.r@web.de
Subject: Re: [RFC PATCH] http: use xmalloc with cURL
Message-ID: <20190812195537.GA14223@sigill.intra.peff.net>
References: <20190810220251.3684-1-carenas@gmail.com>
 <nycvar.QRO.7.76.6.1908111317540.46@tvgsbejvaqbjf.bet>
 <CAPUEspg62pRNH6=_VvWDxQ4YujHUJAoTTampc0L4t68QMj30xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPUEspg62pRNH6=_VvWDxQ4YujHUJAoTTampc0L4t68QMj30xg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 11, 2019 at 12:08:53PM -0700, Carlo Arenas wrote:

> there is also the risk that xmalloc might not be sufficiently thread
> safe (ex: when it triggers unuse_one_window() through the use of a
> try_to_free_routine in packfile.c but we could mitigate the risk for
> now by doing it only first #ifdef NED (I promise to take it out before
> it even gets to next, assuming Junio would trust me enough after the
> last blow up to even get it into pu)

Yes, our xmalloc() is very much not thread-safe, and I suspect
multithreaded bits that don't override try_to_free_routine, like
git-grep, are probably buggy right now (assuming they xmalloc() outside
of the big global lock). This has been the case for ages (see
[1] from 2011, for example) and I don't think anybody has ever
complained. Which leads me to believe that try_to_free_routine() rarely
actually kicks in.

I've long suspected that the whole try_to_free_pack_memory thing is more
trouble than it's worth these days. We're dealing with mmap'd files, so
the OS is going to do a much better job at responding to memory pressure
by dropping individual pages.

So the only thing we're really freeing is address space. On 64-bit
systems, we have plenty of that to go around. On 32-bit systems, it
might. But we introduced it[2] at the same time as sliding windows[3],
so it's not clear how much it helps (keep in mind that even without this
we'd still free old pack windows to make room for more mmap'd packs).

And as a cost, xmalloc() isn't thread safe, and is a lot harder to
reason about (e.g., something simple like strbuf_grow() might trigger
quite a bit more work than you'd expect).

I think it might be worth just eliminating the whole idea.

[1] https://public-inbox.org/git/20110831015936.GB2519@sigill.intra.peff.net/
[2] 97bfeb34df (Release pack windows before reporting out of memory., 2006-12-24)
[3] 60bb8b1453 (Fully activate the sliding window pack access., 2006-12-23)

-Peff
