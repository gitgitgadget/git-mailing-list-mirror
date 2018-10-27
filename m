Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3F0A1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 07:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeJ0QOv (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 12:14:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:57052 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727643AbeJ0QOv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 12:14:51 -0400
Received: (qmail 25949 invoked by uid 109); 27 Oct 2018 07:34:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 27 Oct 2018 07:34:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4723 invoked by uid 111); 27 Oct 2018 07:34:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 27 Oct 2018 03:34:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Oct 2018 03:34:46 -0400
Date:   Sat, 27 Oct 2018 03:34:46 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 02/10] index-pack: remove #ifdef NO_PTHREADS
Message-ID: <20181027073446.GC26685@sigill.intra.peff.net>
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027071003.1347-3-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181027071003.1347-3-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 27, 2018 at 09:09:55AM +0200, Nguyễn Thái Ngọc Duy wrote:

>  static inline struct thread_local *get_thread_data(void)
>  {
> -#ifndef NO_PTHREADS
> -	if (threads_active)
> -		return pthread_getspecific(key);
> -	assert(!threads_active &&
> -	       "This should only be reached when all threads are gone");
> -#endif
> +	if (HAVE_THREADS) {
> +		if (threads_active)
> +			return pthread_getspecific(key);
> +		assert(!threads_active &&
> +		       "This should only be reached when all threads are gone");
> +	}
>  	return &nothread_data;
>  }
>  
> -#ifndef NO_PTHREADS
>  static void set_thread_data(struct thread_local *data)
>  {
>  	if (threads_active)
>  		pthread_setspecific(key, data);
>  }
> -#endif

If we do the getspecific/setspecific thing I mentioned for the previous
patch, then I think helpers like this can just go away.

-Peff
