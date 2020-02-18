Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FBEC34049
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFAF21D56
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgBRUFE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:05:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:47124 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728908AbgBRUCU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 15:02:20 -0500
Received: (qmail 20004 invoked by uid 109); 18 Feb 2020 20:02:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Feb 2020 20:02:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22036 invoked by uid 111); 18 Feb 2020 20:11:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Feb 2020 15:11:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Feb 2020 15:02:19 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/15] pack-bitmap: fix leak of haves/wants object
 lists
Message-ID: <20200218200219.GC21774@coredump.intra.peff.net>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182211.GB150965@coredump.intra.peff.net>
 <28c2f199-e9eb-4405-9044-92a0af7632ec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28c2f199-e9eb-4405-9044-92a0af7632ec@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 12:58:10PM -0500, Derrick Stolee wrote:

> On 2/14/2020 1:22 PM, Jeff King wrote:
> > When we do a bitmap-aware revision traversal, we create an object_list
> > for each of the "haves" and "wants" tips. After creating the result
> > bitmaps these are no longer needed or used, but we never free the list
> > memory.
> 
> It's surprising that we got away with this for so long. Is it
> possible that this loop of freeing memory could provide significant
> performance drawbacks? I'm assuming that the free() loop is much
> faster than the malloc() loop, so the impact is negligible.

I don't think it's surprising. We're only talking about leaking hundreds
or perhaps thousands of structs. So maybe a few kilobytes at most. And
we'd typically only run one such bitmap traversal per program.

Meanwhile rev-list is generally storing that same set of objects in a
pending array, and I think we don't generally clean up after it (nor is
there even a convenient function to do so).

So I think it's sort of a drop in the bucket of Git's "eh, this pretty
much lasts about the whole program anyway" leaks. I don't think there's
much performance difference either way in freeing or not. It's mostly
just a cleanliness thing. (I do one day dream of being able to run the
test suite through a leakchecker, but we're still a ways off, I think).

-Peff
