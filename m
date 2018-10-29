Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B441F453
	for <e@80x24.org>; Mon, 29 Oct 2018 14:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbeJ2XT3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 19:19:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:59008 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725964AbeJ2XT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 19:19:29 -0400
Received: (qmail 20663 invoked by uid 109); 29 Oct 2018 14:30:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Oct 2018 14:30:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18053 invoked by uid 111); 29 Oct 2018 14:29:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Oct 2018 10:29:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2018 10:30:34 -0400
Date:   Mon, 29 Oct 2018 10:30:34 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com
Subject: Re: [PATCH v2 08/10] read-cache.c: remove #ifdef NO_PTHREADS
Message-ID: <20181029143033.GF17668@sigill.intra.peff.net>
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027173008.18852-1-pclouds@gmail.com>
 <20181027173008.18852-9-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181027173008.18852-9-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 27, 2018 at 07:30:06PM +0200, Nguyễn Thái Ngọc Duy wrote:

> -#ifndef NO_PTHREADS
> -	nr_threads = git_config_get_index_threads();
> +	if (HAVE_THREADS) {
> +		nr_threads = git_config_get_index_threads();
>  
> -	/* TODO: does creating more threads than cores help? */
> -	if (!nr_threads) {
> -		nr_threads = istate->cache_nr / THREAD_COST;
> -		cpus = online_cpus();
> -		if (nr_threads > cpus)
> -			nr_threads = cpus;
> +		/* TODO: does creating more threads than cores help? */
> +		if (!nr_threads) {
> +			nr_threads = istate->cache_nr / THREAD_COST;
> +			cpus = online_cpus();
> +			if (nr_threads > cpus)
> +				nr_threads = cpus;
> +		}
> +	} else {
> +		nr_threads = 1;
>  	}

I'd have thought we could just rely on online_cpus() returning 1 here to
avoid having to ask "do we even have thread support?". But I guess that
TODO comment implies that we might one day two 2 threads on a single
CPU.

-Peff
