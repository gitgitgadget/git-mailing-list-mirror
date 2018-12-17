Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB5801F405
	for <e@80x24.org>; Mon, 17 Dec 2018 21:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbeLQVdM (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 16:33:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:44208 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727181AbeLQVdM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 16:33:12 -0500
Received: (qmail 24021 invoked by uid 109); 17 Dec 2018 21:33:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 17 Dec 2018 21:33:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6920 invoked by uid 111); 17 Dec 2018 21:32:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 17 Dec 2018 16:32:44 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2018 16:33:10 -0500
Date:   Mon, 17 Dec 2018 16:33:10 -0500
From:   Jeff King <peff@peff.net>
To:     Masaya Suzuki <masayasuzuki@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] pack-protocol.txt: accept error packets in any
 context
Message-ID: <20181217213310.GA14251@sigill.intra.peff.net>
References: <20181116084427.GA31493@sigill.intra.peff.net>
 <cover.1544572142.git.steadmon@google.com>
 <df7d3659ae5f11d163f1e992f3b9403be709ddb7.1544572142.git.steadmon@google.com>
 <20181212110206.GA30673@sigill.intra.peff.net>
 <CAJB1erXRqQW0yQyZutJAJKC7WbdVhBAYUMWM+8ZutxA-W-7S8w@mail.gmail.com>
 <20181213221826.GE37614@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181213221826.GE37614@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 02:18:26PM -0800, Josh Steadmon wrote:

> On 2018.12.12 17:17, Masaya Suzuki wrote:
> > On Wed, Dec 12, 2018 at 3:02 AM Jeff King <peff@peff.net> wrote:
> > > This ERR handling has been moved to a very low level. What happens if
> > > we're passing arbitrary data via the packet_read() code? Could we
> > > erroneously trigger an error if a packfile happens to have the bytes
> > > "ERR " at a packet boundary?
> > >
> > > For packfiles via upload-pack, I _think_ we're OK, because we only
> > > packetize it when a sideband is in use. In which case this would never
> > > match, because we'd have "\1" in the first byte slot.
> > >
> > > But are there are other cases we need to worry about? Just
> > > brainstorming, I can think of:
> > >
> > >   1. We also pass packetized packfiles between git-remote-https and
> > >      the stateless-rpc mode of fetch-pack/send-pack. And I don't think
> > >      we use sidebands there.
> > >
> > >   2. The packet code is used for long-lived clean/smudge filters these
> > >      days, which also pass arbitrary data.
> > >
> > > So I think it's probably not a good idea to unconditionally have callers
> > > of packet_read_with_status() handle this. We'd need a flag like
> > > PACKET_READ_RESPECT_ERR, and to trigger it from the appropriate callers.
> > 
> > This is outside of the Git pack protocol so having a separate parsing
> > mode makes sense to me.
> 
> This sounds like it could be a significant refactoring. Should we go
> back to V2 of this series, and then work on the new parsing mode
> separately?

Which one is v2? :)

Just the remote-curl cleanups from me, and then your "die on server-side
errors" patch?

-Peff
