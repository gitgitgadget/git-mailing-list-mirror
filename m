Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3954720970
	for <e@80x24.org>; Tue, 11 Apr 2017 16:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbdDKQQZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 12:16:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:60053 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751415AbdDKQQY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 12:16:24 -0400
Received: (qmail 15600 invoked by uid 109); 11 Apr 2017 16:16:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 16:16:20 +0000
Received: (qmail 3322 invoked by uid 111); 11 Apr 2017 16:16:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 12:16:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 12:16:17 -0400
Date:   Tue, 11 Apr 2017 12:16:17 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: Re: [PATCH v5 3/8] convert: Split start_multi_file_filter into two
 separate functions
Message-ID: <20170411161617.fyu5pmzgplscoozz@sigill.intra.peff.net>
References: <20170407120354.17736-1-benpeart@microsoft.com>
 <20170407120354.17736-4-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170407120354.17736-4-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 07, 2017 at 08:03:49AM -0400, Ben Peart wrote:

> @@ -642,7 +621,41 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
>  done:
>  	sigchain_pop(SIGPIPE);
>  
> -	if (err || errno == EPIPE) {
> +	if (err || errno == EPIPE)
> +		err = err ? err : errno;
> +
> +	return err;
> +}

This isn't a new problem introduced by your patch, but this use of errno
seems funny to me. Specifically:

  1. Do we need to save errno before calling sigchain_pop()? It's making
     syscalls (though admittedly they are unlikely to fail).

  2. If err is 0, then nothing failed. Who would have set errno? Aren't
     we reading whatever cruft happened to be in errno before the
     function started?

     So I'm confused about what case would trigger on this errno check
     at all.

Also, I'm not quite sure what the return value of the function is
supposed to be; usually we'd use 0 for success and negative for errors.
But here we might return a negative value that we got from the packet_*
functions, or we might return EPIPE, which is positive. I don't think
it's a huge deal because the caller checks "if (err)", but perhaps it
should be "-errno" for consistency.

-Peff
