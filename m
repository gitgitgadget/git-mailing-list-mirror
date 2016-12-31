Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C48F220441
	for <e@80x24.org>; Sat, 31 Dec 2016 17:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754731AbcLaR6O (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 12:58:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:33599 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754660AbcLaR6N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 12:58:13 -0500
Received: (qmail 21480 invoked by uid 109); 31 Dec 2016 17:58:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 31 Dec 2016 17:58:13 +0000
Received: (qmail 4393 invoked by uid 111); 31 Dec 2016 17:59:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 31 Dec 2016 12:59:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Dec 2016 12:58:08 -0500
Date:   Sat, 31 Dec 2016 12:58:08 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH v3 13/23] log_ref_setup(): pass the open file descriptor
 back to the caller
Message-ID: <20161231175808.cvm54nmk3x7zoipo@sigill.intra.peff.net>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
 <ef2355e9d5ccaa53928c821530bae59f2b118013.1483153436.git.mhagger@alum.mit.edu>
 <20161231063211.tqsiafg3iahcuotz@sigill.intra.peff.net>
 <f5ced16d-61dc-ba14-7f29-88f20d4a65d2@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5ced16d-61dc-ba14-7f29-88f20d4a65d2@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 31, 2016 at 08:58:43AM +0100, Michael Haggerty wrote:

> > The return value is always "0" or "-1". It seems like it would be
> > simpler to just return the descriptor instead of 0.
> > 
> > I guess that makes it hard to identify the case when we chose not to
> > create a descriptor. I wonder if more "normal" semantics would be:
> > 
> >   1. ret >= 0: file existed or was created, and ret is the descriptor
> > 
> >   2. ret < 0, err is empty: we chose not to create
> > 
> >   3. ret < 0, err is non-empty: a real error
> 
> I don't like making callers read err to find out whether the call was
> successful, and I think we've been able to avoid that pattern so far.

I guess my mental model is that case 2 _is_ a failure, because we didn't
open the reflog. It's just one that callers may want to distinguish from
case 3, because it's probably a silent failure, not one we want to
complain to the user about.

But whether that's accurate would depend on the callers. Looking at the
callers, I think the immediate callers would be happier with this, but
you probably would want to end up converting case 3 back to "return 0"
out of files_log_ref_write().

> > I dunno. This may just be bikeshedding, and I can live with it either
> > way (especially because you documented it!).
> 
> Let's see if anybody has a strong opinion about it; otherwise I'd rather
> leave it as is.

Sounds good.

-Peff
