Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8143320285
	for <e@80x24.org>; Thu, 24 Aug 2017 14:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753538AbdHXO2q (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 10:28:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:47964 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753405AbdHXO2p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 10:28:45 -0400
Received: (qmail 19041 invoked by uid 109); 24 Aug 2017 14:28:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Aug 2017 14:28:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10161 invoked by uid 111); 24 Aug 2017 14:29:13 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Aug 2017 10:29:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Aug 2017 07:28:41 -0700
Date:   Thu, 24 Aug 2017 07:28:41 -0700
From:   Jeff King <peff@peff.net>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 0/3] imap-send curl tunnelling support
Message-ID: <20170824142841.wqcbjwaajhy5ppvl@sigill.intra.peff.net>
References: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com>
 <20170816083432.rgurgckch6phcul3@sigill.intra.peff.net>
 <0beb0a6c-acb3-ae24-5c52-95747f74c07f@suse.de>
 <20170823214349.k4ayl2urqepch7p4@sigill.intra.peff.net>
 <e11d4449-8377-dbd7-3ad5-441baf7446b6@morey-chaisemartin.com>
 <20170824135331.27wtwicjuoiyremx@sigill.intra.peff.net>
 <2875ec38-9d22-ef94-28e5-7b9c6855139d@morey-chaisemartin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2875ec38-9d22-ef94-28e5-7b9c6855139d@morey-chaisemartin.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2017 at 04:15:04PM +0200, Nicolas Morey-Chaisemartin wrote:

> >> 1) There does not seem to be an easy/clean workaround for the lack of socketpair on windows.
> >> Fidling with a loopback AF_UNIX?AF_LOCAL socket should work but it
> >> means creating a socket file somewhere which pulls a lot of potential
> >> issues (where to put it ? Post-mortem cleanup ? Parallel imap-send ?)
> > Even if you create a non-anonymous socket and connect to both ends, I'm
> > not sure how it works to pass that to the spawned child. IIRC, our
> > run_command emulation cannot pass arbitrary descriptors to the child
> > processes (but I don't know the details of why that is the case, or if
> > there are windows-specific calls we could be making to work around it).
> Well as long as we can map it on a fd, the dup2 trickery should allow to remap whatever solution we pick to stdin/stdout.
> Could this code be put in a #ifndef WINDOWS ?

Good point. So yeah, in theory you could emulate socketpair() with a
temporary path to do the rendezvous. Just bind/listen/accept in a
non-blocking way, then connect() from the same process, then close() the
listener and delete the socket path.

Of course that doesn't work if you don't have AF_UNIX in the first
place. You could always do the same trick with TCP sockets over the
loopback, but now you get the added bonus of wondering whether whoever
connected is the other half of your process. ;)

I dunno. I am well out of my range of Windows knowledge, and I don't
have a system to test on to determine whether my suggestions are going
completely off the deep end.

-Peff
