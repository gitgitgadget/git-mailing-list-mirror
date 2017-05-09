Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 996011FC44
	for <e@80x24.org>; Tue,  9 May 2017 02:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753811AbdEICAU (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 22:00:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:47748 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752483AbdEICAT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 22:00:19 -0400
Received: (qmail 8073 invoked by uid 109); 9 May 2017 02:00:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 02:00:13 +0000
Received: (qmail 18320 invoked by uid 111); 9 May 2017 02:00:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 22:00:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 May 2017 22:00:10 -0400
Date:   Mon, 8 May 2017 22:00:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-objects: disable pack reuse for object-selection
 options
Message-ID: <20170509020010.meefcustv7uufard@sigill.intra.peff.net>
References: <20170502084326.65eisqmr4th5cbf7@sigill.intra.peff.net>
 <xmqq4lww9cas.fsf@gitster.mtv.corp.google.com>
 <20170508073143.lu73w5b54lvstty2@sigill.intra.peff.net>
 <xmqqd1bi7ta5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1bi7ta5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 09, 2017 at 09:44:50AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Mon, May 08, 2017 at 01:56:27PM +0900, Junio C Hamano wrote:
> >
> >> Surely, even if we need to exclude some objects from an existing
> >> packfile due to these selection options, we should be able to reuse
> >> the non-excluded part, no?  The end result may involve having to
> >> pick and reuse more and smaller slices from existing packfiles,
> >> which may be much less efficient, but it is no immediately obvious
> >> to me if it leads to "need to disable".  I would understand it if it
> >> were "it becomes much less efficient and we are better off not using
> >> the bitmap code at all", though.
> >
> > Yes, it's this last bit. The main win of the packfile reuse code is that
> > it builds on the bitmaps to avoid doing as much per-object work as
> > possible. So the objects don't even get added to the list of "struct
> > object_entry", and we never consider them for the "should they be in the
> > result" checks beyond the have/want computation done by the bitmaps.
> >
> > We could add those checks in, but what's the point? The idea of the
> > reuse code is to be a fast path for serving vanilla clones. Searching
> > through all of the packfiles for a .keep entry is the antithesis of
> > that.
> 
> Ah, OK, and now I understand why you called this a "bug" (which is
> older and do not need to be addressed as part of 2.13) in the
> original message.  The new tests check requests that ought to
> produce an empty packfile as the result actually do, but with the
> current code, the reuse code does not work with --local and friends
> and ends up including what was requested to be excluded.

Right. Did you want me to try re-wording the commit message, or does it
make sense now?

-Peff
