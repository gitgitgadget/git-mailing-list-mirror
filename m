Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6F4C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 08:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A3842053B
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 08:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgD1Idi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:33:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:42068 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726803AbgD1Idi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 04:33:38 -0400
Received: (qmail 19671 invoked by uid 109); 28 Apr 2020 08:33:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Apr 2020 08:33:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32630 invoked by uid 111); 28 Apr 2020 08:45:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Apr 2020 04:45:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Apr 2020 04:33:36 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH] fetch-pack: try harder to read an ERR packet
Message-ID: <20200428083336.GA2405176@coredump.intra.peff.net>
References: <20200422163357.27056-1-chriscool@tuxfamily.org>
 <20200422232744.GA19100@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422232744.GA19100@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 05:27:44PM -0600, Taylor Blau wrote:

> > -		if (write_in_full(fd, buf->buf, buf->len) < 0)
> > +		if (write_in_full(fd, buf->buf, buf->len) < 0) {
> 
> This makes sense; if 'write_in_full' fails, we want to go into the
> error-handling case below.
> 
> But, I wonder if we could do better than re-using 'write_in_full' here.
> We definitely do want to write 'buf->len' bytes overall, but what
> happens when a 'write()' fails? I think it's at _that_ point we want to
> try and read a packet or two off from the remote.
> 
> What if instead this looked something like:
> 
>   const char *p = buf;
>   ssize_t total = 0;
> 
>   while (count > 0) {
>     ssize_t written = xwrite(fd, p, count);
>     if (written < 0)
>       return -1;
>     /* note the change on this line */
>     if (!written && packet_reader_read(reader) == PACKET_READ_EOF) {
>       errno = ENOSPC;
>       return -1;
>     }
>     count -= written;
>     p += written;
>     total += written;
>   }
> 
>   return total;
> 
> That is basically the definition of 'write_in_full', but when we didn't
> get a chance to write anything, then we try to read one packet.

I'm not sure I understand what this is trying to do. If write_in_full()
returns an error, then we know that write() just failed, and it would be
appropriate to check errno at that point and decide whether to read a
packet.

The code you've written above doesn't make sense to me. If we see an
error, we'd return _before_ doing any packet_reader_read() stuff. We'd
trigger it only when write() returns 0. But it should only do that if we
fed it 0 bytes, which we know we'd never pass (because we wouldn't run
the loop if count==0).

-Peff
