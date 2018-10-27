Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB8161F453
	for <e@80x24.org>; Sat, 27 Oct 2018 07:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeJ0QYt (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 12:24:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:57084 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726610AbeJ0QYt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 12:24:49 -0400
Received: (qmail 26331 invoked by uid 109); 27 Oct 2018 07:44:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 27 Oct 2018 07:44:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4794 invoked by uid 111); 27 Oct 2018 07:44:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 27 Oct 2018 03:44:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Oct 2018 03:44:44 -0400
Date:   Sat, 27 Oct 2018 03:44:44 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 06/10] grep: remove #ifdef NO_PTHREADS
Message-ID: <20181027074443.GE26685@sigill.intra.peff.net>
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027071003.1347-7-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181027071003.1347-7-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 27, 2018 at 09:09:59AM +0200, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/builtin/grep.c b/builtin/grep.c
> index d8508ddf79..29221e1003 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -34,7 +34,6 @@ static int recurse_submodules;
>  #define GREP_NUM_THREADS_DEFAULT 8
>  static int num_threads;
>  
> -#ifndef NO_PTHREADS
>  static pthread_t *threads;
>  
>  /* We use one producer thread and THREADS consumer
> @@ -265,13 +264,6 @@ static int wait_all(void)
>  
>  	return hit;
>  }
> -#else /* !NO_PTHREADS */
> -
> -static int wait_all(void)
> -{
> -	return 0;
> -}
> -#endif

Cases like this are kind of weird. I'd expect to see wait_all() return
immediately when !HAVE_THREADS. But we don't need to, because later we
do this:

> -	if (num_threads)
> +	if (HAVE_THREADS && num_threads)
>  		hit |= wait_all();

Which I think works, but it feels like we're introducing some subtle
dependencies about which functions get called in which cases. I'd hoped
in general that the non-threaded code paths could mostly just collapse
down into the same as the "threads == 1" cases, and we wouldn't have to
ask "are threads even supported" in a lot of places.

I dunno. My comment isn't really an objection exactly, but mostly just
an indication that I'm still thinking through what the best approach is,
and what end state we want to end up in.

-Peff
