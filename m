Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDACC33CA2
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 09:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD63720721
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 09:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgAJJ5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 04:57:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:33424 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727279AbgAJJ5I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 04:57:08 -0500
Received: (qmail 3472 invoked by uid 109); 10 Jan 2020 09:57:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Jan 2020 09:57:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23750 invoked by uid 111); 10 Jan 2020 10:02:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Jan 2020 05:02:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Jan 2020 04:57:07 -0500
From:   Jeff King <peff@peff.net>
To:     Erik Fastermann <erik@fastermann.de>
Cc:     git@vger.kernel.org
Subject: Re: Question about the pack OBJ_OFS_DELTA format
Message-ID: <20200110095707.GA459765@coredump.intra.peff.net>
References: <1032627506.120165.1578644787174@email.ionos.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1032627506.120165.1578644787174@email.ionos.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 10, 2020 at 09:26:27AM +0100, Erik Fastermann wrote:

> I get: ee 01 8c 63
> 
> The first two bytes, the type and the size are correctly computed.
> 
> So the next varint should be the offset.
> 
> 8c: 10001100 --- 63: 01100011
> 
> -> 1100011_0001100
> 
> -> 12684 ???
> 
> The result is the same when calculating it manually and with my program.

The pack-format.txt file says:

       offset encoding:
            n bytes with MSB set in all but the last one.
            The offset is then the number constructed by
            concatenating the lower 7 bit of each byte, and
            for n >= 2 adding 2^7 + 2^14 + ... + 2^(7*(n-1))
            to the result.

but I think is missing two bits of information:

  - the bytes are in most-significant to least-significant order, which
    IIRC is the opposite of the size varint

  - each 7-bit byte sneaks in some extra data by implicitly adding "1"
    to all but the last byte

So the low seven bits of "8c" is "12". Add one and multiply by 2^7 gets
you 1664. The low seven of "63" is 99. No addition or multiply because
it's the last byte.

The result is 1763, which is what you expected.

It does seem like the documentation could be a lot better. I had to dig
into the source (packfile.c:get_delta_base is pretty clear, but if
you're trying to do a non-GPL clean-room implementation, then obviously
don't look at it).

-Peff
