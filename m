Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A63B20248
	for <e@80x24.org>; Tue, 26 Mar 2019 05:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfCZFAO (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 01:00:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:36020 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726279AbfCZFAO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 01:00:14 -0400
Received: (qmail 8321 invoked by uid 109); 26 Mar 2019 05:00:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Mar 2019 05:00:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14800 invoked by uid 111); 26 Mar 2019 05:00:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Mar 2019 01:00:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2019 01:00:12 -0400
Date:   Tue, 26 Mar 2019 01:00:12 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] fetch-pack: call prepare_shallow_info only if v0
Message-ID: <20190326050011.GA1933@sigill.intra.peff.net>
References: <cover.1553546216.git.jonathantanmy@google.com>
 <d2eb101709cc9b300e38151b14c97f96a2b14188.1553546216.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2eb101709cc9b300e38151b14c97f96a2b14188.1553546216.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 01:43:22PM -0700, Jonathan Tan wrote:

> In fetch_pack(), be clearer that there is no shallow information before
> the fetch when v2 is used - memset the struct shallow_info to 0 instead
> of calling prepare_shallow_info().
> 
> This patch is in preparation for a future patch in which a v2 fetch
> might call prepare_shallow_info() after shallow info has been retrieved
> during the fetch, so I needed to ensure that prepare_shallow_info() is
> not called before the fetch.

Makes sense.

I wondered here:

> diff --git a/fetch-pack.c b/fetch-pack.c
> index e69993b2eb..a0eb268dfc 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1648,13 +1648,17 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
>  		packet_flush(fd[1]);
>  		die(_("no matching remote head"));
>  	}
> -	prepare_shallow_info(&si, shallow);
> -	if (version == protocol_v2)
> +	if (version == protocol_v2) {
> +		if (shallow && shallow->nr)
> +			BUG("Protocol V2 does not provide shallows at this point in the fetch");
> +		memset(&si, 0, sizeof(si));
>  		ref_cpy = do_fetch_pack_v2(args, fd, ref, sought, nr_sought,
>  					   pack_lockfile);

...who actually might set "shallow". Specifically, I was curious whether
a v2 server could erroneously send us shallow lines, which would trigger
our BUG(), when in fact we should be complaining about the server.

But the answer is no, they have no opportunity. AFAICT, this would only
be set by a call to get_remote_heads(), which we do only for v0/v1
protocols. So there's no way to trigger the BUG. Good.

-Peff
