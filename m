Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,WEIRD_PORT
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 765F4201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 13:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbdB1N2R (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 08:28:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:35624 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbdB1N2R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 08:28:17 -0500
Received: (qmail 27296 invoked by uid 109); 28 Feb 2017 13:28:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 13:28:16 +0000
Received: (qmail 25945 invoked by uid 111); 28 Feb 2017 13:28:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 08:28:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 08:28:14 -0500
Date:   Tue, 28 Feb 2017 08:28:14 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] http: attempt updating base URL only if no error
Message-ID: <20170228132814.wp3cq4ilp7syinqy@sigill.intra.peff.net>
References: <20170228025311.6347-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170228025311.6347-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 06:53:11PM -0800, Jonathan Tan wrote:

> http.c supports HTTP redirects of the form
> 
>   http://foo/info/refs?service=git-upload-pack
>   -> http://anything
>   -> http://bar/info/refs?service=git-upload-pack
> 
> (that is to say, as long as the Git part of the path and the query
> string is preserved in the final redirect destination, the intermediate
> steps can have any URL). However, if one of the intermediate steps
> results in an HTTP exception, a confusing "unable to update url base
> from redirection" message is printed instead of a Curl error message
> with the HTTP exception code.

Right, your patch makes sense. A real HTTP error should take precedence
over the url-update trickery.

Acked-by: Jeff King <peff@peff.net>

> Therefore, teach http to check the HTTP status before attempting to
> check if only the "base" part of the URL differed. This commit teaches
> http_request_reauth to return early without updating options->base_url
> upon an error; the only invoker of this function that passes a non-NULL
> "options" is remote-curl.c (through "http_get_strbuf"), which only uses
> options->base_url for an informational message in the situations that
> this commit cares about (that is, when the return value is not HTTP_OK).

Running your included test, we get:

  fatal: unable to access 'http://127.0.0.1:5550/redir-to/502/': The
  requested URL returned error: 502

but the error really happened in the intermediate step. I wonder if we
should show the effective_url in that case, as it's more likely to
pinpoint the problem. OTOH, we do not mention the intermediate redirect
at all, so they might be confused about where that URL came from. If you
really want to debug HTTP confusion, you should use GIT_TRACE_CURL.

At any rate, that's orthogonal to your patch, which is obviously the
right thing to do.

-Peff
