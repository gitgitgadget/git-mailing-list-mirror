Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C226DCD37B2
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 05:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbjIPF0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 01:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238717AbjIPFZu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 01:25:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BB61BC9
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 22:25:44 -0700 (PDT)
Received: (qmail 743 invoked by uid 109); 16 Sep 2023 05:25:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 16 Sep 2023 05:25:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8851 invoked by uid 111); 16 Sep 2023 05:25:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 16 Sep 2023 01:25:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 16 Sep 2023 01:25:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] http: update curl http/2 info matching for curl 8.3.0
Message-ID: <20230916052540.GA13092@coredump.intra.peff.net>
References: <20230915113237.GA3531328@coredump.intra.peff.net>
 <20230915113443.GB3531587@coredump.intra.peff.net>
 <xmqqsf7fe1q4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsf7fe1q4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2023 at 11:21:55AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > @@ -751,6 +753,18 @@ static int match_curl_h2_trace(const char *line, const char **out)
> >  	    skip_iprefix(line, "h2 [", out))
> >  		return 1;
> >  
> > +	/*
> > +	 * curl 8.3.0 uses:
> > +	 *   [HTTP/2] [<stream-id>] [<header-name>: <header-val>]
> > +	 * where <stream-id> is numeric.
> > +	 */
> > +	if (skip_iprefix(line, "[HTTP/2] [", &p)) {
> > +		while (isdigit(*p))
> > +			p++;
> > +		if (skip_prefix(p, "] [", out))
> > +			return 1;
> > +	}
> 
> Looking good assuming that <stream-id> part will never be updated to
> allow spaces around the ID, or allow non-digits in the ID, in the
> future.  Is there much harm if this code allowed false positives and
> sent something that is *not* a curl trace, like "foo]" parsed out of
> "[HTTP/2] [PATCH] [foo]", to redact_sensitive_header() function?

The current code on the generating side is pretty strict. It's
literally a printf using "[HTTP/2] [%d] [%.*s: %.*s]". As far as future
changes, I'm hesitant to make any changes based on guesses of what
_could_ happen. Our chance of hitting the mark is not high (I never
would have dreamed about this format after seeing the existing h2h3
ones), and it always carries the risk of misinterpretation.

You are right that the cost of a false positive is probably not too high
(the absolute worst case is that we redact something that looks
header-ish in the trace output). But even still, I'd prefer not to
complicate the code with extra parsing for a format that may or may not
ever come to exist.

If we were to loosen the parsing, it would make more sense to me to
loosen _much_ more, and just look for anything inside brackets.
Something like:

	p = header->buf;
	while ((p = strchr(p, '['))) {
		if (redact_sensitive_header(header, p - header->buf + 1)) {
			/* redaction ate our closing bracket */
			strbuf_addch(header, ']');
			break;
		}
		p++; /* skip past to look for next opening bracket */
	}

Then we are relying on redact_sensitive_header() to match the header
strings, and we'll pass it lots of garbage which it will reject. But at
least we've bought something: all of the h2 formats we know about will
just work, and any future ones which retain the bracketing will as well.

That said, I'm still somewhat inclined to the stricter parsing, just
because it's possible for us to see arbitrary bytes here. So if you had
a header that happened to have brackets in it, we'd match those.
Probably nothing too bad could come of it, but it just feels sloppy to
me.

> By the way, would this patch make sense?  Everybody in the function
> that try to notice a sensitive header seems to check the sentting
> independently, which seems error prone for those who want to add a
> new header to redact.
> [...]
> +	if (!trace_curl_redact)
> +		return ret;

Yeah, that looks a reasonable simplification to me (though obviously
orthogonal to the patch under discussion).

-Peff
