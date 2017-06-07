Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E79461FAE5
	for <e@80x24.org>; Wed,  7 Jun 2017 09:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751577AbdFGJr0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 05:47:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:35806 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751026AbdFGJqn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 05:46:43 -0400
Received: (qmail 14664 invoked by uid 109); 7 Jun 2017 09:46:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Jun 2017 09:46:43 +0000
Received: (qmail 32307 invoked by uid 111); 7 Jun 2017 09:46:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Jun 2017 05:46:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Jun 2017 05:46:41 -0400
Date:   Wed, 7 Jun 2017 05:46:41 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [WIP v2 0/2] Modifying pack objects to support --blob-max-bytes
Message-ID: <20170607094641.pibxlk5nbyii5p63@sigill.intra.peff.net>
References: <cover.1496361873.git.jonathantanmy@google.com>
 <cover.1496432147.git.jonathantanmy@google.com>
 <20170602221645.nsz6r6tgfndulc6c@sigill.intra.peff.net>
 <20170605103523.190c9f16@twelve2.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170605103523.190c9f16@twelve2.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 05, 2017 at 10:35:23AM -0700, Jonathan Tan wrote:

> > The rest of the pack code uses a varint encoding which is generally
> > much smaller than a uint64 for most files, but can handle arbitrary
> > sizes.
> > 
> > The one thing it loses is that you wouldn't have a fixed-size record, so
> > if you were planning to dump this directly to disk and binary-search it,
> > that won't work. OTOH, you could make pseudo-pack-entries and just
> > index them along with the rest of the objects in the pack .idx.
> > 
> > The one subtle thing there is that the pseudo-entry would have to say
> > "this is my sha1". And then we'd end up repeating that sha1 in the .idx
> > file. So it's optimal on the network but wastes 20 bytes on disk (unless
> > index-pack throws away the in-pack sha1s as it indexes, which is
> > certainly an option).
> 
> If we end up going with the varint approach (which seems reasonable),
> maybe the client could just expand the varints into uint64s so that it
> has a binary-searchable file. I think it's better to keep this list
> separate from the pack .idx file (there has been some discussion on this
> - [1] and its replies).
> 
> [1] https://public-inbox.org/git/777ab8f2-c31a-d07b-ffe3-f8333f408ea1@jeffhostetler.com/

OK. If we're keeping it separate anyway, then I agree that just
expanding the varints is a good solution. And we don't have to care too
much about the local storage, because it can be changed out later
without touching the on-the-wire protocol.

-Peff
