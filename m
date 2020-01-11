Return-Path: <SRS0=hslh=3A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7621C33C9E
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 09:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877242064C
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 09:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgAKJ4F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jan 2020 04:56:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:34172 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728828AbgAKJ4F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jan 2020 04:56:05 -0500
Received: (qmail 11803 invoked by uid 109); 11 Jan 2020 09:56:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 11 Jan 2020 09:56:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32314 invoked by uid 111); 11 Jan 2020 10:02:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Jan 2020 05:02:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 11 Jan 2020 04:56:04 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Erik Fastermann <erik@fastermann.de>, git@vger.kernel.org
Subject: Re: Question about the pack OBJ_OFS_DELTA format
Message-ID: <20200111095604.GA1605786@coredump.intra.peff.net>
References: <1032627506.120165.1578644787174@email.ionos.de>
 <20200110095707.GA459765@coredump.intra.peff.net>
 <xmqq1rs7m757.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rs7m757.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 10, 2020 at 11:41:08AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The pack-format.txt file says:
> >
> >        offset encoding:
> >             n bytes with MSB set in all but the last one.
> >             The offset is then the number constructed by
> >             concatenating the lower 7 bit of each byte, and
> >             for n >= 2 adding 2^7 + 2^14 + ... + 2^(7*(n-1))
> >             to the result.
> >
> > but I think is missing two bits of information:
> >
> >   - the bytes are in most-significant to least-significant order, which
> >     IIRC is the opposite of the size varint
> >
> >   - each 7-bit byte sneaks in some extra data by implicitly adding "1"
> >     to all but the last byte
> 
> Isn't the latter mentioned in the paragraph you quoted?

Hmm, yeah. I admit I had trouble parsing exactly what that part was
trying to say, and thought it was trying to talk about how you'd shift
the individual bytes. But reading more carefully, it does say "adding",
so yeah, it accounts for the extra.

It's a little confusing, I think, because in code you'd add just
continually add one before shifting, rather than trying to add in the
extra values at the end.

-Peff
