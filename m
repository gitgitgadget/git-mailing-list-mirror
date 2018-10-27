Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CE101F453
	for <e@80x24.org>; Sat, 27 Oct 2018 07:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeJ0QUA (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 12:20:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:57058 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726610AbeJ0QUA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 12:20:00 -0400
Received: (qmail 26128 invoked by uid 109); 27 Oct 2018 07:39:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 27 Oct 2018 07:39:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4744 invoked by uid 111); 27 Oct 2018 07:39:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 27 Oct 2018 03:39:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Oct 2018 03:39:55 -0400
Date:   Sat, 27 Oct 2018 03:39:55 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 05/10] send-pack.c: remove #ifdef NO_PTHREADS
Message-ID: <20181027073954.GD26685@sigill.intra.peff.net>
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027071003.1347-6-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181027071003.1347-6-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 27, 2018 at 09:09:58AM +0200, Nguyễn Thái Ngọc Duy wrote:

> While at there correct "#include cache.h" position. It must be one of
> the first includes.
> [...]
> @@ -1,4 +1,5 @@
>  #include "builtin.h"
> +#include "cache.h"

I think it's actually fine as it is. The rule is not about cache.h in
particular, but that the first include must be one of the special ones.
And builtin.h is such a special one. After that, there are no ordering
rules.

> @@ -203,9 +204,8 @@ static int receive_status(int in, struct ref *refs)
>  static int sideband_demux(int in, int out, void *data)
>  {
>  	int *fd = data, ret;
> -#ifdef NO_PTHREADS
> -	close(fd[1]);
> -#endif
> +	if (!HAVE_THREADS)
> +		close(fd[1]);
>  	ret = recv_sideband("send-pack", fd[0], out);
>  	close(out);
>  	return ret;

This one is a very interesting case. Your conversion here isn't wrong,
but what we actually want to know is: is "struct async" implemented as a
separate process or not.

And "struct async" will continue to switch on NO_PTHREADS, as it can
never use these dummy bits. I can't think of a way that HAVE_THREADS
would ever diverge from how "struct async" works, but my gut feeling is
that we probably ought to have a separate variable for the async code to
tell how it works. Even if it ends up being the same as HAVE_THREADS,
it helps untangle the two cases.

-Peff
