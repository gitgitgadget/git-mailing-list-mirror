Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAE8E1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 06:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437014AbfJQGUQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 02:20:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:50482 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731726AbfJQGUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 02:20:16 -0400
Received: (qmail 20945 invoked by uid 109); 17 Oct 2019 06:20:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Oct 2019 06:20:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6167 invoked by uid 111); 17 Oct 2019 06:23:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Oct 2019 02:23:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Oct 2019 02:20:15 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, mh@glandium.org
Subject: Re: [PATCH 1/6] index-pack: unify threaded and unthreaded code
Message-ID: <20191017062015.GA10862@sigill.intra.peff.net>
References: <cover.1570663470.git.jonathantanmy@google.com>
 <32ef0122a55bfbdbde0595b2aad930d83b27dd6d.1570663470.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32ef0122a55bfbdbde0595b2aad930d83b27dd6d.1570663470.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 09, 2019 at 04:44:17PM -0700, Jonathan Tan wrote:

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/index-pack.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index a23454da6e..1a2600d4b3 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1210,15 +1210,7 @@ static void resolve_deltas(void)
>  		cleanup_thread();
>  		return;
>  	}
> -
> -	for (i = 0; i < nr_objects; i++) {
> -		struct object_entry *obj = &objects[i];
> -
> -		if (is_delta_type(obj->type))
> -			continue;
> -		resolve_base(obj);
> -		display_progress(progress, nr_resolved_deltas);
> -	}
> +	threaded_second_pass(&nothread_data);
>  }

I wondered at first if this would be a problem with NO_PTHREADS. But I
think since the cleanups around 2094c5e582 (index-pack: remove #ifdef
NO_PTHREADS, 2018-11-03), we always define threaded_second_pass(), even
if all the locks are noops and we only ever have one thread.

-Peff
