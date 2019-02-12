Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BC3F1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 00:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfBLAlc (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 19:41:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:40976 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727374AbfBLAlc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 19:41:32 -0500
Received: (qmail 20311 invoked by uid 109); 12 Feb 2019 00:41:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Feb 2019 00:41:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19729 invoked by uid 111); 12 Feb 2019 00:41:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Feb 2019 19:41:42 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2019 19:41:30 -0500
Date:   Mon, 11 Feb 2019 19:41:30 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Florian Steenbuck <steenbuckflorian@gmail.com>, git@vger.kernel.org
Subject: Re: Confusion about the PACK format
Message-ID: <20190212004130.GI13301@sigill.intra.peff.net>
References: <CAA4q8U5JD1tA0KH1nxAhN1AuqYeB-Y5UGqXzichx-ZCipDKsgQ@mail.gmail.com>
 <e9a8ae8d-6f4a-5595-0287-80bf31923abf@ramsayjones.plus.com>
 <a0e1ad5b-8d6b-7fa0-54f3-dc0b4b275533@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0e1ad5b-8d6b-7fa0-54f3-dc0b4b275533@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 10, 2019 at 07:35:38PM +0000, Ramsay Jones wrote:

> > Now, the 'n-byte type and length' is a variable length encoding of
> > the object type and length. The number of bytes used to encode this
> > data is content dependant. If the top bit of a byte is set, then we
> > need to process the next byte, otherwise we are done. So, looking
> > at the first 'object entry' byte (at offset 12) '9d', we take the
> > top nibble, remove the top bit, and shift right 4 bits to get the
> > object type. ie. (0x9d >> 4) & 7 which gives an object type of 1
> > (which is a commit object). The lower nibble of the first byte
> > contains the first (or only) 4 bits of the size, here (0x9d & 15)
> > which is 0xd. Given that the top bit of this byte is set, we now
> > process the next byte. After the first byte, each byte contains 7
> > bits of the size field which is combined with the value from the
> > previous byte by shifting and adding (first by 4 bits, then 11, 18,
> > 25 etc.). So, in this case we have (0x13 << 4) + 0xd = 317.
> 
> Sorry, to be clear, I should have said, "mask off the top bit,
> shift and add", so:
> 
>   ((0x13 & 0x7f) << 4) + 0xd = 317

Yes. Also, see the first 10 or so lines of builtin/index-pack.c's
unpack_raw_entry() for real-world example code.

-Peff
