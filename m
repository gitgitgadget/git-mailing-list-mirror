Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5E971F576
	for <e@80x24.org>; Fri,  2 Mar 2018 10:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426786AbeCBK5S (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 05:57:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:44088 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1426710AbeCBK5N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 05:57:13 -0500
Received: (qmail 8209 invoked by uid 109); 2 Mar 2018 10:57:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Mar 2018 10:57:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27324 invoked by uid 111); 2 Mar 2018 10:58:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Mar 2018 05:58:02 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Mar 2018 05:57:10 -0500
Date:   Fri, 2 Mar 2018 05:57:10 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH 00/11] Reduce pack-objects memory footprint
Message-ID: <20180302105710.GE11074@sigill.intra.peff.net>
References: <20180228092722.GA25627@ash>
 <20180301091052.32267-1-pclouds@gmail.com>
 <87y3jbdiof.fsf@evledraar.gmail.com>
 <CACsJy8Bvtk_rKJ34F_PmBD5F2WN4L8ecug5dQX8-gt8i1owy3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8Bvtk_rKJ34F_PmBD5F2WN4L8ecug5dQX8-gt8i1owy3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 02, 2018 at 07:14:01AM +0700, Duy Nguyen wrote:

> > We have a big repo, and this gets repacked on 6-8GB of memory on dev
> > KVMs, so we're under a fair bit of memory pressure. git-gc slows things
> > down a lot.
> >
> > It would be really nice to have something that made it use drastically
> > less memory at the cost of less efficient packs. Is the property that
> 
> Ahh.. less efficient. You may be more interested in [1] then. It
> avoids rewriting the base pack. Without the base pack, book keeping
> becomes much much cheaper.
> 
> We still read every single byte in all packs though (I think, unless
> you use pack-bitmap) and this amount of I/O affect the rest of the
> system too. Perhaps reducing core.packedgitwindowsize might make it
> friendlier to the OS, I don't know.

Yes, the ".keep" thing is actually quite expensive. We still do a
complete rev-list to find all the objects we want, and then for each
object say "is this in a pack with .keep?". And worse, the mru doesn't
help there because even if we find it in the first pack, we have to keep
looking to see if it's _another_ pack.

There are probably some low-hanging optimizations there (e.g., only
looking in the .keep packs if that's all we're looking for; we may even
do that already).

But I think fundamentally you'd do much better to generate the partial
list of objects outside of pack-objects entirely, and then just feed it
to pack-objects without using "--revs".

-Peff
