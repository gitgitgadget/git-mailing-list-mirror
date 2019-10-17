Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 850041F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 06:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390972AbfJQG0m (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 02:26:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:50514 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727653AbfJQG0m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 02:26:42 -0400
Received: (qmail 21182 invoked by uid 109); 17 Oct 2019 06:26:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Oct 2019 06:26:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6240 invoked by uid 111); 17 Oct 2019 06:29:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Oct 2019 02:29:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Oct 2019 02:26:41 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, mh@glandium.org
Subject: Re: [PATCH 3/6] index-pack: remove redundant child field
Message-ID: <20191017062640.GD10862@sigill.intra.peff.net>
References: <cover.1570663470.git.jonathantanmy@google.com>
 <39740c6e58bd6cb6ea33e5abb4ab8542ff6eb7b7.1570663470.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39740c6e58bd6cb6ea33e5abb4ab8542ff6eb7b7.1570663470.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 09, 2019 at 04:44:19PM -0700, Jonathan Tan wrote:

> -static void prune_base_data(struct base_data *retain)
> +static void prune_base_data(struct base_data *youngest_child)
>  {
>  	struct base_data *b;
>  	struct thread_local *data = get_thread_data();
> -	for (b = data->base_cache;
> -	     data->base_cache_used > delta_base_cache_limit && b;
> -	     b = b->child) {
> -		if (b->data && b != retain)
> -			free_base_data(b);
> +	struct base_data **ancestry = NULL;
> +	int nr = 0, alloc = 0;

Minor, but please use size_t for allocation variables.

> +	int i;

Technically this probably ought to be a size_t as well, but I'm much
more concerned about the allocation ones, where we might accidentally
overflow and underallocate a buffer. Overflowing "i" would probably just
lead to an error or bad result.

I _think_ what the patch is actually doing makes sense (taking as an
assumption that it's heading in a useful direction for the end of the
series).

-Peff
