Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 952A12027C
	for <e@80x24.org>; Wed, 31 May 2017 04:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750902AbdEaEXJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 00:23:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:60360 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750778AbdEaEXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 00:23:09 -0400
Received: (qmail 12955 invoked by uid 109); 31 May 2017 04:23:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 04:23:06 +0000
Received: (qmail 1222 invoked by uid 111); 31 May 2017 04:23:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 00:23:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 May 2017 00:23:05 -0400
Date:   Wed, 31 May 2017 00:23:05 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCHv4 1/2] clone: respect additional configured fetch
 refspecs during initial fetch
Message-ID: <20170531042304.unkxkuw6s3tcpzkm@sigill.intra.peff.net>
References: <CAM0VKjnOSxQg_VCBO2cgtbqesmNYx+e_H7m=36PsNWi9K9rQ1Q@mail.gmail.com>
 <20170530071244.32257-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170530071244.32257-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 09:12:43AM +0200, SZEDER Gábor wrote:

> diff --git a/remote.c b/remote.c
> index ad6c5424e..b8fd09dc9 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -626,6 +626,19 @@ struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec)
>  	return parse_refspec_internal(nr_refspec, refspec, 1, 0);
>  }
>  
> +void add_and_parse_fetch_refspec(struct remote *remote, const char *refspec)
> +{
> +	struct refspec *rs;
> +
> +	add_fetch_refspec(remote, refspec);
> +	rs = parse_fetch_refspec(1, &refspec);
> +	REALLOC_ARRAY(remote->fetch, remote->fetch_refspec_nr);
> +	remote->fetch[remote->fetch_refspec_nr - 1] = *rs;
> +
> +	/* Not free_refspecs(), as we copied its pointers above */
> +	free(rs);
> +}

What happens here if remote->fetch isn't already initialized? I think
we'd end up with a bunch of garbage values. That's what I was trying to
protect against in my original suggestion.

I'm not sure if that's possible or not. We seem to initialize it in both
remote_get() and for_each_remote(), and I don't think there are any
other ways to get a remote. (In fact, I kind of wondered why we do this
parsing lazily at all, but I think it's so that misconfigured remotes
don't cause us to die() if we aren't accessing them at all).

If we assume that the contract that remote.c provides is that the
fetch fields are always filled in before a "struct remote" is returned
to a caller, and that only such callers would use this function, it's
OK. It just seems more dangerous than it needs to be.

-Peff
