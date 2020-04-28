Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AC9C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 21:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5992B206D6
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 21:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgD1VRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:17:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:43132 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726307AbgD1VRh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 17:17:37 -0400
Received: (qmail 23935 invoked by uid 109); 28 Apr 2020 21:17:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Apr 2020 21:17:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7508 invoked by uid 111); 28 Apr 2020 21:29:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Apr 2020 17:29:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Apr 2020 17:17:36 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] fetch-pack: try harder to read an ERR packet
Message-ID: <20200428211736.GG4000@coredump.intra.peff.net>
References: <20200428074442.29830-1-chriscool@tuxfamily.org>
 <xmqqzhav1kix.fsf@gitster.c.googlers.com>
 <20200428204908.GA4000@coredump.intra.peff.net>
 <xmqqh7x31fyu.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7x31fyu.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 02:02:33PM -0700, Junio C Hamano wrote:

> > I think the "lucky" case happens pretty routinely. The situation we're
> > trying to catch here is that server does:
> >
> >    packet_write("ERR I don't like your request for some reason");
> >    die("exiting");
> 
> OK, if we assume that the communication route is never flaky and
> everything writtten will go through before TCP shutdown that would
> happen when die() kills the process (or like test environment that
> most communication goes locally between two processes), sure, it may
> look common enough to be worth "fixing".  I simply did not realize
> that was the shared assumption behind this patch before I went back
> to the original discussion that was about a racy test.

Certainly the communication route will _sometimes_ be flaky. And there's
nothing we can do there except say "Broken pipe" or similar, whether the
other side said ERR or not. So any reads have to be speculative. But
assuming TCP is functioning, some portion of our ERR packets are simply
dropped from the incoming TCP buffers. I suspect we don't get more
reports of this in the wild (and are mostly annoyed by it in racy tests)
because:

  - ERR conditions don't happen all that often (though we have been
    adding more recently)

  - users may not realize they _could_ have gotten a good message
    (especially since historically many of these conditions did just
    involve the server hanging up)

  - I think the race may be easier to win on real networks with latency.
    Locally, if I write "want bogus" and then "done", the other side may
    process the "want" between the two and close the pipe. But if
    there's 50ms between client and server, we've usually managed to
    "done" into the systems TCP buffer, if not onto the wire, by the
    time the other side has figured out the error and gotten a FIN
    packet back to us.

> As long as an extra read on the side that just got a write error
> won't throw us into a deadlock, I think I am OK, but I am still not
> sure if the code complexity to have two write_in_full() is worth it.

Yes, I don't see the point of that.

> If the mechanism to do this were limited to the packet IO layer, it
> may be more palatable, though.

Agreed. There's not a single place where we write, though, since we
often form packets in local buffers and then write() them out manually.
So it does have to be sprinkled around fetch-pack.c. But certainly the
damage can be limited to that client network code.

-Peff
