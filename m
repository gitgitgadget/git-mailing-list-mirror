Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B317BCA90AF
	for <git@archiver.kernel.org>; Tue, 12 May 2020 19:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 913F120740
	for <git@archiver.kernel.org>; Tue, 12 May 2020 19:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgELTQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 15:16:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:44542 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725938AbgELTQM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 15:16:12 -0400
Received: (qmail 30852 invoked by uid 109); 12 May 2020 19:16:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 May 2020 19:16:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9906 invoked by uid 111); 12 May 2020 19:16:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 May 2020 15:16:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 May 2020 15:16:10 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] http, imap-send: stop using CURLOPT_VERBOSE
Message-ID: <20200512191610.GB54565@coredump.intra.peff.net>
References: <cover.1589218693.git.jonathantanmy@google.com>
 <1df9e9deb7831b32694ea453759bf5d21952e165.1589218693.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1df9e9deb7831b32694ea453759bf5d21952e165.1589218693.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 11, 2020 at 10:43:10AM -0700, Jonathan Tan wrote:

> Whenever GIT_CURL_VERBOSE is set, teach Git to behave as if
> GIT_TRACE_CURL=1 and GIT_TRACE_CURL_NO_DATA=1 is set, instead of setting
> CURLOPT_VERBOSE.
> 
> This is to prevent inadvertent revelation of sensitive data. In
> particular, GIT_CURL_VERBOSE redacts neither the "Authorization" header
> nor any cookies specified by GIT_REDACT_COOKIES.
> 
> Unifying the tracing mechanism also has the future benefit that any
> improvements to the tracing mechanism will benefit both users of
> GIT_CURL_VERBOSE and GIT_TRACE_CURL, and we do not need to remember to
> implement any improvement twice.

Yeah, I think this is worth doing. The patch looks OK to me, though:

> +void http_trace_curl_no_data(void)
> +{
> +	trace_override_envvar(&trace_curl, "1");
> +	trace_curl_data = 0;
> +}

Would:

  setenv("GIT_TRACE_CURL", "1", 0);
  setenv("GIT_TRACE_CURL_NO_DATA", "0", 0);

be simpler? Perhaps it makes the flow more convoluted as we'd go on to
parse those variables, but it puts us on the same paths that we'd use if
the user specified those things (and avoids the need for the special
"override" function entirely).

Other than that nit, it seems very cleanly done.

-Peff

PS I sometimes find the normal trace a bit verbose, but I do still want
   to see data. Do others feel the same? Particularly I find the "SSL"
   lines totally worthless (I guess maybe you could be debugging ssl
   stuff, but that would be the exception, I'd think). Ditto the split
   of data into two lines: one with the size and one with the actual
   data.

   I dunno. I haven't been debugging any git-over-http stuff lately, so
   it hasn't been bothering me. But I definitely have written perl
   scripts to extract the data to a more readable format. Maybe it would
   be easier if it had a few more knobs.
