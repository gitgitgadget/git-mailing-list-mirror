Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 112C0201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 21:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934961AbdBQVVv (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 16:21:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:57448 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934861AbdBQVVu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 16:21:50 -0500
Received: (qmail 22671 invoked by uid 109); 17 Feb 2017 21:21:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 21:21:08 +0000
Received: (qmail 6172 invoked by uid 111); 17 Feb 2017 21:21:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 16:21:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 16:21:06 -0500
Date:   Fri, 17 Feb 2017 16:21:06 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?utf-8?B?SsOhY2h5bSBCYXJ2w61uZWs=?= <jachymb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tempfile: avoid "ferror | fclose" trick
Message-ID: <20170217212106.bew6krtb7pqpi3rr@sigill.intra.peff.net>
References: <xmqq37ff2hn8.fsf@gitster.mtv.corp.google.com>
 <20170215231832.bzg3ygz4ualcvqlc@sigill.intra.peff.net>
 <87tw7uv439.fsf@linux-m68k.org>
 <20170216164359.k2ab7laqqvusfsm2@sigill.intra.peff.net>
 <20170216213140.xqw7gzjimhvg7tcm@sigill.intra.peff.net>
 <923e328c-7fea-a9e4-1059-3bd6b8e58164@alum.mit.edu>
 <20170217080759.2357wzdiuymcyosw@sigill.intra.peff.net>
 <64eedabd-c0de-a7e0-8d98-ad23a9625b45@alum.mit.edu>
 <20170217205442.wnldfsxbj3dnnqvj@sigill.intra.peff.net>
 <xmqq37fcsejx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37fcsejx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 01:17:06PM -0800, Junio C Hamano wrote:

> > I guess we are simultaneously assuming that it is OK to munge errno on
> > success in our function, but that fclose() will not do so. Which seems a
> > bit hypocritical. Maybe the "if" dance is better.
> 
> Yes.  When both ferror() and fclose() are successful, we would
> prefer to see the original errno unmolested, so the "if" dance,
> even though it looks uglier, is better.  The ugliness is limited
> to the implementation anyway ;-)
> 
> But it does look ugly, especially when nested inside the existing
> code like so.

I think our emails crossed, but our patches are obviously quite similar.
My commit message maybe explains a bit more of my thinking.

> Stepping back a bit, would this be really needed?  Even if the ferror()
> does not update errno, the original stdio operation that failed
> would have, no?

Sure, but we have no clue what happened in between.

-Peff
