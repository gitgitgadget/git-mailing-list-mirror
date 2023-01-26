Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9754AC54E94
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 10:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbjAZKcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 05:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236259AbjAZKb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 05:31:59 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8034734011
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 02:31:58 -0800 (PST)
Received: (qmail 19412 invoked by uid 109); 26 Jan 2023 10:31:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Jan 2023 10:31:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22100 invoked by uid 111); 26 Jan 2023 10:31:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Jan 2023 05:31:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Jan 2023 05:31:57 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v7 11/12] http: read HTTP WWW-Authenticate response
 headers
Message-ID: <Y9JWnQeEV0weV4yu@coredump.intra.peff.net>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <5f5e46038cf526714f3c5b89ffef2b895b503242.1674252531.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f5e46038cf526714f3c5b89ffef2b895b503242.1674252531.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2023 at 10:08:49PM +0000, Matthew John Cheetham via GitGitGadget wrote:

> From: Matthew John Cheetham <mjcheetham@outlook.com>
> 
> Read and store the HTTP WWW-Authenticate response headers made for
> a particular request.
> 
> This will allow us to pass important authentication challenge
> information to credential helpers or others that would otherwise have
> been lost.

Makes sense, and the code looks pretty reasonable overall.

A few observations:

> @@ -115,6 +116,19 @@ struct credential {
>  	 */
>  	struct string_list helpers;
>  
> +	/**
> +	 * A `strvec` of WWW-Authenticate header values. Each string
> +	 * is the value of a WWW-Authenticate header in an HTTP response,
> +	 * in the order they were received in the response.
> +	 */
> +	struct strvec wwwauth_headers;
> +
> +	/**
> +	 * Internal use only. Used to keep track of split header fields
> +	 * in order to fold multiple lines into one value.
> +	 */
> +	unsigned header_is_last_match:1;
> +

Stuffing this into a "struct credential" feels a little weird, just
because it's specific to http parsing (especially this internal flag).
And the credential code is seeing full header lines, not broken down at
all.

I guess I would have expected some level of abstraction here between the
credential subsystem and the http subsystem, where the latter is parsing
and then sticking opaque data into the credential to ferry to the
helpers.

But it probably isn't that big a deal either way. Even though there are
non-http credentials, it's not too unreasonable for the credential
system to be aware of http specifically.

> +static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
> +{
> +	size_t size = st_mult(eltsize, nmemb);

Here's that st_mult() again. Same comment as the previous patch. :)

> +	/*
> +	 * Header lines may not come NULL-terminated from libcurl so we must
> +	 * limit all scans to the maximum length of the header line, or leverage
> +	 * strbufs for all operations.
> +	 *
> +	 * In addition, it is possible that header values can be split over
> +	 * multiple lines as per RFC 2616 (even though this has since been
> +	 * deprecated in RFC 7230). A continuation header field value is
> +	 * identified as starting with a space or horizontal tab.
> +	 *
> +	 * The formal definition of a header field as given in RFC 2616 is:
> +	 *
> +	 *   message-header = field-name ":" [ field-value ]
> +	 *   field-name     = token
> +	 *   field-value    = *( field-content | LWS )
> +	 *   field-content  = <the OCTETs making up the field-value
> +	 *                    and consisting of either *TEXT or combinations
> +	 *                    of token, separators, and quoted-string>
> +	 */
> +
> +	strbuf_add(&buf, ptr, size);

OK, so we just copy the buffer. I don't think it would be too hard to
handle the buffer as-is, but this does make things a bit easier.  Given
that we're going to immediately throw away the copy for anything except
www-authenticate, we could perhaps wait until we've matched it.  That
does mean trimming the CRLF ourselves and using skip_prefix_mem() to
match the start (you'd want skip_iprefix_mem(), of course, but it
doesn't yet exist; I'll leave that as an exercise).

Maybe not worth it to save a few allocations, as an http request is
already pretty heavyweight. Mostly I flagged it because this is going to
run for every header of every request, even though most requests won't
trigger it at all.

> +	/* Strip the CRLF that should be present at the end of each field */
> +	strbuf_trim_trailing_newline(&buf);
> +
> +	/* Start of a new WWW-Authenticate header */
> +	if (skip_iprefix(buf.buf, "www-authenticate:", &val)) {
> +		while (isspace(*val))
> +			val++;
> +
> +		strvec_push(values, val);
> +		http_auth.header_is_last_match = 1;
> +		goto exit;
> +	}

OK, this looks correct from my knowledge of the RFCs. I saw something
about isspace() matching newlines, etc, in an earlier thread, but I
think we'd never see a newline here, as we're expecting curl to be
splitting on our behalf.

> +	/*
> +	 * This line could be a continuation of the previously matched header
> +	 * field. If this is the case then we should append this value to the
> +	 * end of the previously consumed value.
> +	 * Continuation lines start with at least one whitespace, maybe more,
> +	 * so we should collapse these down to a single SP (valid per the spec).
> +	 */
> +	if (http_auth.header_is_last_match && isspace(*buf.buf)) {
> +		/* Trim leading whitespace from this continuation hdr line. */
> +		strbuf_ltrim(&buf);

OK, makes sense. This will memmove(), which is needlessly inefficient
(we could just advance a pointer), but probably not a big deal in
practice. Using the strbuf functions is a nice simplification.

> +		/*
> +		 * At this point we should always have at least one existing
> +		 * value, even if it is empty. Do not bother appending the new
> +		 * value if this continuation header is itself empty.
> +		 */
> +		if (!values->nr) {
> +			BUG("should have at least one existing header value");
> +		} else if (buf.len) {
> +			char *prev = xstrdup(values->v[values->nr - 1]);
> +
> +			/* Join two non-empty values with a single space. */
> +			const char *const sp = *prev ? " " : "";
> +
> +			strvec_pop(values);
> +			strvec_pushf(values, "%s%s%s", prev, sp, buf.buf);
> +			free(prev);
> +		}

Likewise here we end up with an extra allocation of "prev", just because
we can't pop/push in the right order. But that's probably OK in
practice, as this is triggering only for the header we care about.

The concatenation itself makes the whole thing quadratic, but unless we
are worried about a malicious server DoS-ing us with a billion
www-authenticate continuations, I think we can disregard that.

-Peff
