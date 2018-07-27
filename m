Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F18621F597
	for <e@80x24.org>; Fri, 27 Jul 2018 09:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbeG0LBb (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 07:01:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:60870 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729568AbeG0LBb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 07:01:31 -0400
Received: (qmail 18445 invoked by uid 109); 27 Jul 2018 09:40:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 27 Jul 2018 09:40:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24197 invoked by uid 111); 27 Jul 2018 09:40:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 27 Jul 2018 05:40:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jul 2018 05:40:26 -0400
Date:   Fri, 27 Jul 2018 05:40:26 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 2/5] Add delta-islands.{c,h}
Message-ID: <20180727094026.GA17155@sigill.intra.peff.net>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
 <20180722054836.28935-3-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180722054836.28935-3-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 22, 2018 at 07:48:33AM +0200, Christian Couder wrote:

> +	/*
> +	 * We process only trees, as commits and tags have already been handled
> +	 * (and passed their marks on to root trees, as well. We must make sure
> +	 * to process them in descending tree-depth order so that marks
> +	 * propagate down the tree properly, even if a sub-tree is found in
> +	 * multiple parent trees.
> +	 */
> +	todo = xmalloc(to_pack->nr_objects * sizeof(*todo));

I was fiddling with "make coccicheck", and it looks like this code could
stand some modernization. This could use ALLOC_ARRAY().

> +	for (i = 0; i < to_pack->nr_objects; i++) {
> +		if (oe_type(&to_pack->objects[i]) == OBJ_TREE)
> +			todo[nr++] = &to_pack->objects[i];
> +	}
> +	qsort(todo, nr, sizeof(*todo), cmp_tree_depth);

And this QSORT().

There are a few others, I won't list them all. The only tricky one I see
is:

> +		free(tree->buffer);
> +		tree->buffer = NULL;
> +		tree->object.parsed = 0;

This suggests FREE_AND_NULL(), but I think it actually the whole block
should become a call to free_tree_buffer().

-Peff
