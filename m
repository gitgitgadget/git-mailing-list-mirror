Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347E8C433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 13:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC5823428
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 13:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbhAMNDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 08:03:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:54650 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbhAMNDV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 08:03:21 -0500
Received: (qmail 22382 invoked by uid 109); 13 Jan 2021 13:02:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Jan 2021 13:02:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29625 invoked by uid 111); 13 Jan 2021 13:02:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Jan 2021 08:02:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Jan 2021 08:02:39 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 02/20] write_reuse_object(): convert to new revindex API
Message-ID: <X/7vb9Dnrfa1Yaut@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <00668523e1cd860f6de08dd7c5a2a54edc08b7b6.1610129796.git.me@ttaylorr.com>
 <X/1iM0p5d8Zj8ucS@coredump.intra.peff.net>
 <X/3O7D18gRLfSNJ8@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/3O7D18gRLfSNJ8@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 11:31:40AM -0500, Taylor Blau wrote:

> > > +	datalen = pack_pos_to_offset(p, pos + 1) - offset;
> >
> > This "pos + 1" means we may be looking one past the end of the array.
> > That's OK (at least for now), because our revindex always puts in an
> > extra dummy value exactly for computing these kinds of byte-distances.
> > That might be worth documenting in the API header.
> 
> Yeah, I made sure to document that when I was touching up the last
> patch. FWIW, that's a behavior that we're going to carry over even when
> the reverse index is stored on-disk (not by writing four extra bytes
> into the .rev file, but by handling queries for pos == p->num_objects
> separately.)

I think the only reason to look past the end like that is to compute the
size of the final entry. So we _could_ abstract that away from the
callers with a separate function like:

  off_t pack_pos_to_size(struct packed_git *p, uint32_t pos);

But as long as the behavior of passing p->num_objects is documented, I
do not mind overly mind spelling it one way or the other.

-Peff
