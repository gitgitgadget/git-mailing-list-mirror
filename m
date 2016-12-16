Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 745E71FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 21:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757973AbcLPVtM (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 16:49:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:57802 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757707AbcLPVtK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 16:49:10 -0500
Received: (qmail 11170 invoked by uid 109); 16 Dec 2016 21:49:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 21:49:10 +0000
Received: (qmail 14966 invoked by uid 111); 16 Dec 2016 21:49:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 16:49:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Dec 2016 16:49:07 -0500
Date:   Fri, 16 Dec 2016 16:49:07 -0500
From:   Jeff King <peff@peff.net>
To:     David Turner <novalis@novalis.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: "disabling bitmap writing, as some objects are not being packed"?
Message-ID: <20161216214906.z53yp2x4n6hdc27m@sigill.intra.peff.net>
References: <1481922331.28176.11.camel@frank>
 <xmqqpokrr2cf.fsf@gitster.mtv.corp.google.com>
 <20161216213214.z3mzkp2xqnwrqkh2@sigill.intra.peff.net>
 <1481924416.28176.19.camel@frank>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481924416.28176.19.camel@frank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 16, 2016 at 04:40:16PM -0500, David Turner wrote:

> I would assume, based on the documentation, that auto gc would be doing
> an all-into-one repack:
> "If the number of packs exceeds the value of gc.autopacklimit, then
>  existing packs (except those marked with a .keep file) are
>  consolidated into a single pack by using the -A option of git
>  repack."
> 
> I don't have any settings that limit the size of packs, either.  And a
> manual git repack -a -d creates only a single pack.  Its loneliness
> doesn't last long, because pretty soon a new pack is created by an
> incoming push.

The interesting code is in need_to_gc():

        /*
         * If there are too many loose objects, but not too many
         * packs, we run "repack -d -l".  If there are too many packs,
         * we run "repack -A -d -l".  Otherwise we tell the caller
         * there is no need.
         */
        if (too_many_packs())
                add_repack_all_option();
        else if (!too_many_loose_objects())
                return 0;

So if you have (say) 10 packs and 10,000 objects, we'll incrementally
pack those objects into a single new pack.

I never noticed this myself because we do not use auto-gc at GitHub at
all. We only ever do a big all-into-one repack.

> Unless this just means that some objects are being kept loose (perhaps
> because they are unreferenced)? 

If they're unreferenced, they won't be part of the new pack. You might
accumulate loose objects that are ejected from previous packs, which
could trigger auto-gc to do an incremental pack (even though it wouldn't
be productive, because they're unreferenced!). You may also get them
from pushes (small pushes will be exploded into loose objects by
default).

-Peff
