Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8191EC34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6595E24125
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgBRUFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:05:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:47136 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728158AbgBRUFm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 15:05:42 -0500
Received: (qmail 20029 invoked by uid 109); 18 Feb 2020 20:05:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Feb 2020 20:05:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22102 invoked by uid 111); 18 Feb 2020 20:14:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Feb 2020 15:14:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Feb 2020 15:05:41 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/15] rev-list: allow commit-only bitmap traversals
Message-ID: <20200218200541.GD21774@coredump.intra.peff.net>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182227.GI150965@coredump.intra.peff.net>
 <967821c8-aca4-52ff-8eb9-01a74f5a8144@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <967821c8-aca4-52ff-8eb9-01a74f5a8144@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 01:18:21PM -0500, Derrick Stolee wrote:

> > +	test_expect_success "enumerate commits ($state)" '
> > +		git rev-list --use-bitmap-index HEAD >actual &&
> > +		git rev-list HEAD >expect &&
> > +		test_bitmap_traversal --no-confirm-bitmaps expect actual
> > +	'
> > +
> 
> I was wondering if there is anything we could add to the "expect"
> command that could better guarantee these commits show up in a
> different order than the bitmap order, allowing us to drop the
> "--no-confirm-bitmaps". Perhaps the issue is the merge structure
> of the repository, and how it will cause these orders to always
> agree?
> 
> I suppose "--topo-order" may actually present an order _even closer_
> to the bitmap order.

I think in the partial-bitmap state it may have a different order,
because we'd put the new commits at the end. But we run this test in
both fully-bitmapped and partial-bitmap conditions.

We could add something like --topo-order to the expected output, but I
think even if it worked, then the bitmap-confirmation in
test_bitmap_traversal wouldn't really be checking anything! I.e., if the
"actual" traversal didn't use bitmaps, we'd still say "oh, these two
outputs are different, so one must have used bitmaps." So saying
"--no-confirm-bitmap" at least documents that we don't expect any
difference.

-Peff
