Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BCEC433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66ECE208E4
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732777AbhALIyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:54:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:53076 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbhALIyq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:54:46 -0500
Received: (qmail 6220 invoked by uid 109); 12 Jan 2021 08:54:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 08:54:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10916 invoked by uid 111); 12 Jan 2021 08:54:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 03:54:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 03:54:05 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH 05/20] check_object(): convert to new revindex API
Message-ID: <X/1jrSMU71BLWgm5@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <c47e77a30eb40d9841a60a28b620671860dc2461.1610129796.git.me@ttaylorr.com>
 <b1a6110a-a097-931f-5710-92a1f59a842b@gmail.com>
 <X/x5tdbM3PzkqbFQ@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/x5tdbM3PzkqbFQ@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 11, 2021 at 11:15:49AM -0500, Taylor Blau wrote:

> On Mon, Jan 11, 2021 at 06:43:23AM -0500, Derrick Stolee wrote:
> > > @@ -1813,11 +1813,11 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
> > >  				goto give_up;
> > >  			}
> > >  			if (reuse_delta && !entry->preferred_base) {
> > > -				struct revindex_entry *revidx;
> > > -				revidx = find_pack_revindex(p, ofs);
> > > -				if (!revidx)
> > > +				uint32_t pos;
> > > +				if (offset_to_pack_pos(p, ofs, &pos) < 0)
> >
> > The current implementation does not return a positive value. Only
> > -1 on error and 0 on success. Is this "< 0" doing anything important?
> > Seems like it would be easiest to do
> >
> > 	if (offset_to_pack_pos(p, ofs, &pos))
> >
> > [snip]
> 
> Either would work, of course. I tend to find the '< 0' form easier to
> read, but I may be in the minority there. For me, the negative return
> value makes clear that the function encountered an error.

I'll throw in my opinion that "< 0" to me much more clearly signals "did
an error occur". And that same form can be used consistently with
functions which _do_ have a positive return value on success, too. So I
prefer it for readability.

-Peff
