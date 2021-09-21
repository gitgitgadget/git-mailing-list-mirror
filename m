Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55220C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 18:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B03261242
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 18:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhIUSst (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 14:48:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:51976 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233592AbhIUSsi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 14:48:38 -0400
Received: (qmail 6370 invoked by uid 109); 21 Sep 2021 18:47:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 18:47:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3392 invoked by uid 111); 21 Sep 2021 18:47:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Sep 2021 14:47:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Sep 2021 14:47:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] http: match headers case-insensitively when redacting
Message-ID: <YUoorS6UwA1DmwBm@coredump.intra.peff.net>
References: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 02:41:16PM -0400, Jeff King wrote:

> When HTTP/2 is in use, we fail to correctly redact "Authorization" (and
> other) headers in our GIT_TRACE_CURL output.
> 
> We get the headers in our CURLOPT_DEBUGFUNCTION callback, curl_trace().
> It passes them along to curl_dump_header(), which in turn checks
> redact_sensitive_header(). We see the headers as a text buffer like:
> 
>   Host: ...
>   Authorization: Basic ...
> 
> After breaking it into lines, we match each header using skip_prefix().
> This is case-insensitive, even though HTTP headers are case-insensitive.
> This has worked reliably in the past because these headers are generated
> by curl itself, which is predictable in what it sends.
> 
> But when HTTP/2 is in use, instead we get a lower-case "authorization:"
> header, and we fail to match it. The fix is simple: we should match with
> skip_iprefix().

Daniel,

I cc'd you here mostly as an FYI. I think Git was doing the wrong thing
in assuming case here (we're only expecting these particular headers
coming from the client, but for response headers, I thnk curl will give
us whatever form the server sent us).

But certainly I found the behavior surprising. :) I'd guess it's because
HTTP/2 is sending some binary goo instead of text headers, and the names
we get are just coming from some lookup table? Or maybe I'm just showing
my ignorance of HTTP/2.

At any rate, I wonder if it would be friendlier for curl to hand strings
to the debug function with the usual capitalization.

-Peff

PS This nit aside, it is totally cool that I have been seamlessly using
   HTTP/2 to talk to github.com without even realizing it. I wonder for
   how long!
