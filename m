Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133F5C433F5
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 10:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhLRKSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Dec 2021 05:18:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:54474 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbhLRKSU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Dec 2021 05:18:20 -0500
Received: (qmail 27583 invoked by uid 109); 18 Dec 2021 10:18:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Dec 2021 10:18:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8205 invoked by uid 111); 18 Dec 2021 10:18:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Dec 2021 05:18:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 18 Dec 2021 05:18:18 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] daemon: plug memory leak on overlong path
Message-ID: <Yb21alvEAzBkxwGH@coredump.intra.peff.net>
References: <5b151dc3-d4c7-29d3-71ed-a79033693d5d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b151dc3-d4c7-29d3-71ed-a79033693d5d@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 18, 2021 at 10:47:03AM +0100, René Scharfe wrote:

> Release the strbuf containing the interpolated path after copying it to
> a stack buffer and before erroring out if it's too long.

Thanks, this looks obviously correct. The problem was introduced by my
6bdb0083be (daemon: detect and reject too-long paths, 2016-10-22).

I don't think it's that big a deal in practice, since we'd always be in
a worker process handling a single request, and will exit immediately
after returning from the function. So you could not, say, convince a
long-running git-daemon to leak a bunch of memory over time.

But definitely still worth fixing.

> diff --git a/daemon.c b/daemon.c
> index 4a000ee4af..94a5b8a364 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -232,13 +232,13 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
> 
>  		rlen = strlcpy(interp_path, expanded_path.buf,
>  			       sizeof(interp_path));
> +		strbuf_release(&expanded_path);
>  		if (rlen >= sizeof(interp_path)) {
>  			logerror("interpolated path too large: %s",
>  				 interp_path);
>  			return NULL;
>  		}
> 
> -		strbuf_release(&expanded_path);
>  		loginfo("Interpolated dir '%s'", interp_path);

A common mistake in these kinds of fixes is that the variable to be
freed is used to generate an error message in the early-return path.
Here we put "interp_path" in the message instead. That does mean the
error message shows the truncated name rather than the full one. That
may be a hidden feature, though. :)

-Peff
