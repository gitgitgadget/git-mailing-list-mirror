Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0C7520357
	for <e@80x24.org>; Fri, 14 Jul 2017 20:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751158AbdGNUKo (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 16:10:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:41132 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751035AbdGNUKn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 16:10:43 -0400
Received: (qmail 5233 invoked by uid 109); 14 Jul 2017 20:10:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 20:10:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14010 invoked by uid 111); 14 Jul 2017 20:10:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 16:10:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jul 2017 16:10:41 -0400
Date:   Fri, 14 Jul 2017 16:10:41 -0400
From:   Jeff King <peff@peff.net>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: reftable: new ref storage format
Message-ID: <20170714201040.hwrr5gwrc23lp3jt@sigill.intra.peff.net>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
 <20170713193234.fkxf73t6jevj4svg@sigill.intra.peff.net>
 <CAGZ79kbY_t=Xtpb7fy0sZ9TWOy-UOUx8X5+_qLx60Dtg48Ok-g@mail.gmail.com>
 <20170713203533.vcfyf5iei46g4tcf@sigill.intra.peff.net>
 <CAJo=hJv7kaT3m6k1nz1-tGuVAMmgnrS0dcfycGfE3PyXjG3xRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJo=hJv7kaT3m6k1nz1-tGuVAMmgnrS0dcfycGfE3PyXjG3xRA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 05:27:44PM -0700, Shawn Pearce wrote:

> > We _could_ consider gzipping individual blocks of
> > a reftable (or any structure that allows you to search to a
> > constant-sized block and do a linear search from there). But given that
> > they're in the same ballpark, I'm happy with whatever ends up the
> > simplest to code and debug. ;)
> 
> This does help to shrink the file, e.g. it drops from 28M to 23M.
> 
> It makes it more CPU costly to access a block, as we have to inflate
> that to walk through the records. It also messes with alignment. When
> you touch a block, that may be straddling two virtual memory pages in
> your kernel/filesystem.
> 
> I'm not sure those penalties are worth the additional 16% reduction in size.

Yeah, I don't really care about a 16% reduction in size. I care much
more about simplicity of implementation and debugging. Using zlib is
kind-of simple to implement. But if you've ever had to debug it (or
figure out what is going on with maybe-corrupted output), it's pretty
nasty.

So I don't mind a more readable custom compression if it's not too
complicated. And especially if it buys us extra performance by being
able to jump around non-sequentially in the block.

-Peff
