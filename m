Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D058F2098B
	for <e@80x24.org>; Tue, 18 Oct 2016 10:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759145AbcJRK2S (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 06:28:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:58776 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753548AbcJRK2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 06:28:16 -0400
Received: (qmail 14894 invoked by uid 109); 18 Oct 2016 10:28:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Oct 2016 10:28:15 +0000
Received: (qmail 4290 invoked by uid 111); 18 Oct 2016 10:28:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Oct 2016 06:28:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Oct 2016 06:28:13 -0400
Date:   Tue, 18 Oct 2016 06:28:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Shawn Pearce <spearce@spearce.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] fetch: use "quick" has_sha1_file for tag following
Message-ID: <20161018102813.mctfmrgljcxujkc7@sigill.intra.peff.net>
References: <fb66dc02-fb75-5aad-74e5-01b969cf9f9a@oracle.com>
 <af801f22-0e24-525d-a862-f2114941719a@oracle.com>
 <20161013152632.ynsabbv3yrthgidy@sigill.intra.peff.net>
 <20161013165344.jv7hyj74q33yb4ip@sigill.intra.peff.net>
 <20161013170443.43slna3zvcvrse5r@sigill.intra.peff.net>
 <20161013200644.lnustevmpvufbg5y@sigill.intra.peff.net>
 <xmqqfunyzv6f.fsf@gitster.mtv.corp.google.com>
 <20161014185953.k4b5xwihlgvxurjc@sigill.intra.peff.net>
 <xmqqeg3ex4qz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeg3ex4qz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2016 at 10:30:28AM -0700, Junio C Hamano wrote:

> > It looks like I _did_ look into optimizing this into a single stat()
> > call in the thread at [1]. I completely forgot about that. I did find
> > there that naively using stat_validity() on a directory is racy, though
> > I wonder if we could do something clever with gettimeofday() instead.
> 
> It feels funny to hear an idea to compare fs timestamp with gettimeofday
> immedately after hearing the word NFS, though ;-).

Yeah, I had a funny feeling in my stomach as I wrote that.

What you really want to know is the current filesystem time. You'd
probably have to do something gross like creating a new file and then
comparing its timestamp. In theory you'd only have to do that _once_,
and then as long as the pack directory wasn't changing, you could say "I
don't know what time it is now, but I know it is at least time X, and I
know that X is greater than Y, the pack directory timestamp, therefore
the pack directory hasn't changed since I last looked".

That assumes monotonic clocks, but we basically already do so for the
racy-git checks, I think.

I dunno. It feels...complicated. And bad to require writing to the
repository for what would otherwise be a read-only operation. But I
don't see any fundamental reason it could not work.

-Peff
