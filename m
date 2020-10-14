Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B3CC433E7
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 19:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C63C206DC
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 19:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgJNTzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 15:55:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:60220 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgJNTzp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 15:55:45 -0400
Received: (qmail 18522 invoked by uid 109); 14 Oct 2020 19:55:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2020 19:55:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20426 invoked by uid 111); 14 Oct 2020 19:55:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2020 15:55:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Oct 2020 15:55:44 -0400
From:   Jeff King <peff@peff.net>
To:     Sean McAllister <smcallis@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, masayasuzuki@google.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 3/3] http: automatically retry some requests
Message-ID: <20201014195544.GA365911@coredump.intra.peff.net>
References: <20201013191729.2524700-1-smcallis@google.com>
 <20201013191729.2524700-3-smcallis@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201013191729.2524700-3-smcallis@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 01:17:29PM -0600, Sean McAllister wrote:

> +/*
> + * check for a retry-after header in the given headers string, if found, then
> + * honor it, otherwise do an exponential backoff up to the max on the current
> + * delay
> +*/
> +static int http_retry_after(const struct strbuf headers, int cur_delay_sec)
> +{
> +	int delay_sec;
> +	char *end;
> +	char* value = http_header_value(headers, "retry-after");
> +
> +	if (value) {
> +		delay_sec = strtol(value, &end, 0);
> +		free(value);
> +		if (*value && *end == '\0' && delay_sec >= 0) {

This looks at the contents of the just-freed "value" memory block.

> +			if (delay_sec > http_max_delay_sec) {
> +				die(Q_("server requested retry after %d second,"
> +					   " which is longer than max allowed\n",
> +					   "server requested retry after %d seconds,"
> +					   " which is longer than max allowed\n", delay_sec),
> +					delay_sec);
> +			}
> +			return delay_sec;

I guess there's no point in being gentle here. We could shrink the retry
time to our maximum allowed, but the server just told us not to bother.
But would this die() mask the actual http error we encountered, which is
surely the more interesting thing for the user?

I wonder if it needs to be returning a "do not bother retrying" value,
which presumably would cause the caller to propagate the real failure in
the usual way.

>  static int http_request(const char *url,
>  			void *result, int target,
>  			const struct http_get_options *options)
>  {
>  	struct active_request_slot *slot;
>  	struct slot_results results;
> -	struct curl_slist *headers = http_copy_default_headers();
> +	struct curl_slist *headers;
>  	struct strbuf buf = STRBUF_INIT;
> +	struct strbuf result_headers = STRBUF_INIT;

This new result_headers strbuf is filled in for every request, but I
don't think us ever releasing it (whether we retry or not). So I think
it's leaking for each request.

It sounds like you're going to rework this to put the retry loop outside
of http_request(), so it may naturally get fixed there. But I thought it
worth mentioning.

> +	curl_easy_setopt(slot->curl, CURLOPT_HEADERDATA, &result_headers);
> +	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_buffer);

After looking at your parsing code, I wondered if there was a way to
just get a single header out of curl. But according to the documentation
for CURLOPT_HEADERFUNCTION, it will pass back individual lines anyway.
Perhaps it would be simpler to have the callback function understand
that we only care about getting "Retry-After".

The documentation says it doesn't support header folding, but that's
probably OK for our purposes. It's deprecated, and your custom parsing
doesn't handle it either. :) And most importantly, we won't misbehave
terribly if we see it in the wild (we'll just ignore that header).

-Peff
