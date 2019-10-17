Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE5C81F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 07:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405114AbfJQHX1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 03:23:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:50596 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727132AbfJQHX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 03:23:27 -0400
Received: (qmail 22894 invoked by uid 109); 17 Oct 2019 07:23:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Oct 2019 07:23:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6579 invoked by uid 111); 17 Oct 2019 07:26:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Oct 2019 03:26:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Oct 2019 03:23:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        christian.couder@gmail.com, git@vger.kernel.org,
        chriscool@tuxfamily.org, ramsay@ramsayjones.plus.com
Subject: Re: [RFC PATCH 10/10] pack-objects: improve partial packfile reuse
Message-ID: <20191017072326.GA14045@sigill.intra.peff.net>
References: <20190913130226.7449-11-chriscool@tuxfamily.org>
 <20191010235952.174426-1-jonathantanmy@google.com>
 <20191011180125.GA20601@sigill.intra.peff.net>
 <xmqqsgnyg76d.fsf@gitster-ct.c.googlers.com>
 <20191013073851.GA7001@sigill.intra.peff.net>
 <xmqq8spj97mj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8spj97mj.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 04:03:00PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> Hmm, I am kind of surprised that the decoding side allowed such a
> >> padding.
> >
> > IIRC, the "padding" is just a sequence of 0-length-plus-continuation-bit
> > varint bytes. And for some reason it worked for the size but not for the
> > delta offset value.
> 
> I think the reason is because they use different varint definition.
> 
> The encoding used in builtin/pack-objects.c::write_no_reuse_object()
> is for offsets, and it came much later and with an improvement over
> the encoding used for delta size in diff-delta.c::create_delta().
> The more recent encoding does not allow padding (when I compare the
> decoders for these two encodings, I notice there is +1 for each
> 7-bit iteration; this essentially declares that a byte with "not the
> final byte" bit set with all other bits clear does not mean 0 but it
> means 1, which breaks the idea of padding to encode filler zero
> bits).

Yeah, that sounds right. I think the "old" one is actually the pack size
header in unpack_object_header_buffer(), not the delta size header.

At any rate, it seems like a terrible idea, so I'll be glad to see the
code dropped. :)

-Peff
