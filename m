Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B89FC83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 20:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 227C9208E0
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 20:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgD1UtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:49:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:42934 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726208AbgD1UtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 16:49:09 -0400
Received: (qmail 23623 invoked by uid 109); 28 Apr 2020 20:49:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Apr 2020 20:49:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6878 invoked by uid 111); 28 Apr 2020 21:00:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Apr 2020 17:00:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Apr 2020 16:49:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] fetch-pack: try harder to read an ERR packet
Message-ID: <20200428204908.GA4000@coredump.intra.peff.net>
References: <20200428074442.29830-1-chriscool@tuxfamily.org>
 <xmqqzhav1kix.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzhav1kix.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 12:24:06PM -0700, Junio C Hamano wrote:

> Christian Couder <christian.couder@gmail.com> writes:
> 
> > From: SZEDER Gábor <szeder.dev@gmail.com>
> >
> > When the server has hung up after sending an ERR packet to the
> > client, the client might still be writing, for example a "done"
> > line. Therefore the client might get a write error before reading
> > the ERR packet.
> >
> > When fetching, this could result in the client displaying a
> > "Broken pipe" error, instead of the more useful error sent by
> > the server in the ERR packet.
> 
> Hmm, if the connection gets severed just before the ERR packet the
> other side has written, we will see "Broken pipe" if we write
> "done", and no amount of "try to read to collect as much what they
> said as possible" would help.  If you are lucky and the connection
> is broken after the ERR reaches on this side, such an "extra effort"
> may help, but is it really worth the effort?  It is not clear to me
> if the extra complexity, one more API function people need to learn,
> and the need to think which one to use every time they want to say
> write_in_full(), are justifiable.

I think the "lucky" case happens pretty routinely. The situation we're
trying to catch here is that server does:

   packet_write("ERR I don't like your request for some reason");
   die("exiting");

On the client side, we'll get that final packet and then see that the
connection is closed. So if we get EPIPE or similar on write(), that
means we're seeing the closed connection. Which means we'll _always_
have gotten the ERR packet (in this situation).

So the problem it is solving is that there isn't really flow control in
the protocol. The server might be aborting and dumping out an error
response while the client is still writing. If the server were to
continue reading the client request before closing the connection, this
wouldn't happen. And that's what an HTTP server would be doing.

But I think that's pretty tricky to do in our programs, where the
protocol framing isn't so structured, and deciding when the client is
done talking often involves parsing their request. E.g., imagine we die
with "not our ref" due to a "want" line. We'd have to return an error up
the stack to the code that is reading want/have/done lines, so that it
knows to keep pumping the socket until it gets to a break point, and
_then_ die().

I think by contrast, just having the client handle EPIPE more gracefully
is a simpler fix.

-Peff
