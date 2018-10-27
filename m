Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DAF61F453
	for <e@80x24.org>; Sat, 27 Oct 2018 07:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbeJ0QLa (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 12:11:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:57032 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727643AbeJ0QLa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 12:11:30 -0400
Received: (qmail 25817 invoked by uid 109); 27 Oct 2018 07:31:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 27 Oct 2018 07:31:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4691 invoked by uid 111); 27 Oct 2018 07:30:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 27 Oct 2018 03:30:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Oct 2018 03:31:26 -0400
Date:   Sat, 27 Oct 2018 03:31:26 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 01/10] thread-utils: macros to unconditionally compile
 pthreads API
Message-ID: <20181027073125.GB26685@sigill.intra.peff.net>
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027071003.1347-2-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181027071003.1347-2-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 27, 2018 at 09:09:54AM +0200, Nguyễn Thái Ngọc Duy wrote:

> +/*
> + * macros instead of typedefs because pthread definitions may have
> + * been pulled in by some system dependencies even though the user
> + * wants to disable pthread.
> + */
> +#define pthread_t int
> +#define pthread_mutex_t int
> +#define pthread_cond_t int
> +
> +#define pthread_mutex_init(mutex, attr) dummy_pthread_init(mutex)
> +#define pthread_mutex_lock(mutex)
> +#define pthread_mutex_unlock(mutex)
> +#define pthread_mutex_destroy(mutex)

OK, we only need to do the dummy init to shut up the compiler, and the
rest really can just become noops. Makes sense.

> +#define pthread_cond_init(cond, attr) dummy_pthread_init(cond)
> +#define pthread_cond_wait(cond, mutex)
> +#define pthread_cond_signal(cond)
> +#define pthread_cond_broadcast(cond)
> +#define pthread_cond_destroy(cond)

And this is the same.

> +#define pthread_key_create(key, attr) dummy_pthread_init(key)
> +#define pthread_key_delete(key)

We don't need keys because we know we have only one key: the main
thread. Makes sense. But...

> +#define pthread_setspecific(key, data)
> +#define pthread_getspecific(key) NULL

We expect to be able to store a void pointer here and get it back, which
should work even for a single thread. Do we need something like:

  extern void *pthread_specific_data;

  #define pthread_setspecific(key, data) do { \
	pthread_specific_data = data; \
  } while(0)

  void pthread_getspecific(key) pthread_specific_data

> +#define pthread_create(thread, attr, fn, data) \
> +	dummy_pthread_create(thread, attr, fn, data)

I wondered if this should actually run "fn", but I guess there is not
much point. At this point the caller expects the main thread to keep
going, so this is already an error, and reporting ENOSYS is probably the
best thing to do.

-Peff
