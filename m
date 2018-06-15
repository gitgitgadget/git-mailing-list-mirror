Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D6AC1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 20:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936344AbeFOUiQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 16:38:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:46272 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S936200AbeFOUiP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 16:38:15 -0400
Received: (qmail 29471 invoked by uid 109); 15 Jun 2018 20:38:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Jun 2018 20:38:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24696 invoked by uid 111); 15 Jun 2018 20:38:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 15 Jun 2018 16:38:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2018 16:38:13 -0400
Date:   Fri, 15 Jun 2018 16:38:13 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Luat Nguyen <root@l4w.io>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/3] ewah: adjust callers of ewah_read_mmap()
Message-ID: <20180615203813.GA27008@sigill.intra.peff.net>
References: <2067D731-C415-4D19-8CDA-90D7DC638397@l4w.io>
 <20180615032850.GA23241@sigill.intra.peff.net>
 <20180615034442.GA14422@sigill.intra.peff.net>
 <f6931351-df79-cb76-ee29-c57472a6a201@gmail.com>
 <xmqq1sd82e9h.fsf@gitster-ct.c.googlers.com>
 <20180615173155.GC3067@sigill.intra.peff.net>
 <1685a358-f033-64e0-2e12-df3a1c10af19@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1685a358-f033-64e0-2e12-df3a1c10af19@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 15, 2018 at 02:23:44PM -0400, Derrick Stolee wrote:

> If we are considering changing the reachability bitmap, then I'm very
> intrigued. I think the number one thing to consider is to use the
> multi-pack-index as a reference point (with a stable object order) so the
> objects can be repacked independently from the reachability bitmap
> computation. If we are changing the model at that level, then it is worth
> thinking about other questions, like how we index the file or how we
> compress the bitmaps.

I'm open to a new format if it provides significant improvements over
the existing one. I think the existing bitmaps have served us well for
several years, but they do have a few weaknesses. Some of which I
mentioned before, but the most obvious one is that being very
pack-oriented they require repacking to update (and don't handle
cross-pack reachability at all). I know that doesn't fly for
Windows-sized repos at all, but it would also be nice if we could do
incremental updates more cheaply (e.g., after every push instead of just
once a day).

The Roaring stuff looks really interesting. I'm curious about the stable
object order you guys use. Because EWAH is basically run-length-encoding,
it benefits hugely from having the bitmaps in pack order (where there's
a enormous locality with respect to reachability) as opposed to sha1
order (where it's essentially random).

Is your stable object order based on traversing the commit graph? Or
does Roaring do a sufficiently better job of compressing the jumbled
sha1 order?

-Peff
