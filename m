Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A2441F4C0
	for <e@80x24.org>; Sat, 19 Oct 2019 23:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfJSXSi (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 19:18:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:53066 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726145AbfJSXSh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 19:18:37 -0400
Received: (qmail 20386 invoked by uid 109); 19 Oct 2019 23:18:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 19 Oct 2019 23:18:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27031 invoked by uid 111); 19 Oct 2019 23:21:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 19 Oct 2019 19:21:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 19 Oct 2019 19:18:36 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 5/9] pack-bitmap: introduce bitmap_walk_contains()
Message-ID: <20191019231836.GA32408@sigill.intra.peff.net>
References: <20191019103531.23274-1-chriscool@tuxfamily.org>
 <20191019103531.23274-6-chriscool@tuxfamily.org>
 <dce8e0b5-c4ea-f4f6-6275-1322f2d7200b@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dce8e0b5-c4ea-f4f6-6275-1322f2d7200b@iee.email>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 19, 2019 at 04:25:19PM +0100, Philip Oakley wrote:

> > +int bitmap_walk_contains(struct bitmap_index *bitmap_git,
> > +			 struct bitmap *bitmap, const struct object_id *oid)
> > +{
> > +	int idx;
> Excuse my ignorance here...
> 
> For the case on Windows (int/long 32 bit), is this return value guaranteed
> to be less than 2GiB, i.e. not a memory offset?
> 
> I'm just thinking ahead to the resolution of the 4GiB file limit issue on
> Git-for-Windows (https://github.com/git-for-windows/git/pull/2179)

Yes, it's not a memory offset.

This "idx" here (and the return value of bitmap_position) represents a
position within an array of objects. This isn't strictly limited to the
objects in a single pack (because a traversal might extend to objects
outside the bitmapped pack), but we can use that as a general ballpark.
And it's limited to a 4-byte object count already.

So the "best" type here would be a uint32_t (which is used elsewhere
in the pack code), but we use signedness to indicate that the object
wasn't found.

That's probably OK. The biggest repos I've seen have on the order of
10-100M objects. That still gives us a factor of 20 before we hit 2^31.
If we imagine those repos took 10 years or so to accrue that many
objects, then we probably still have 200 years of growth left. Of course
growth accelerates over time, but I suspect repos with 2B objects will
run into other scaling problems first. So I don't think it's worth
worrying about too much for now.

-Peff
