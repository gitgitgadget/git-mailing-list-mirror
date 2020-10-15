Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7191FC433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E04D22240
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389433AbgJOQXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 12:23:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:32930 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388357AbgJOQXo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 12:23:44 -0400
Received: (qmail 23172 invoked by uid 109); 15 Oct 2020 16:23:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Oct 2020 16:23:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30078 invoked by uid 111); 15 Oct 2020 16:23:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2020 12:23:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Oct 2020 12:23:43 -0400
From:   Jeff King <peff@peff.net>
To:     Sean McAllister <smcallis@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Masaya Suzuki <masayasuzuki@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/3] http: automatically retry some requests
Message-ID: <20201015162343.GC1104947@coredump.intra.peff.net>
References: <20201013191729.2524700-1-smcallis@google.com>
 <20201013191729.2524700-3-smcallis@google.com>
 <20201014195544.GA365911@coredump.intra.peff.net>
 <CAM4o00eefXK2CJ_FxwwVPpBKL01JsJANf+SdjCtw_0NVV82L+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM4o00eefXK2CJ_FxwwVPpBKL01JsJANf+SdjCtw_0NVV82L+Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 04:46:57PM -0600, Sean McAllister wrote:

> > I wonder if it needs to be returning a "do not bother retrying" value,
> > which presumably would cause the caller to propagate the real failure in
> > the usual way.
> >
> I've moved this check up a couple levels in v3, so that if we get too large
> a retry value, then we'll print this message as a warning and quit retrying,
> which will unmask the underlying HTTP error.

Thanks, that sounds much better.

> > After looking at your parsing code, I wondered if there was a way to
> > just get a single header out of curl. But according to the documentation
> > for CURLOPT_HEADERFUNCTION, it will pass back individual lines anyway.
> > Perhaps it would be simpler to have the callback function understand
> > that we only care about getting "Retry-After".
> >
> > The documentation says it doesn't support header folding, but that's
> > probably OK for our purposes. It's deprecated, and your custom parsing
> > doesn't handle it either. :) And most importantly, we won't misbehave
> > terribly if we see it in the wild (we'll just ignore that header).
> >
> I'll put this in my todo pile to think on a little, it'd be nice not
> to have expand the strbuf with every request, but also not a huge
> overhead.

I was less concerned with the overhead of the strbuf (http requests are
pretty heavyweight already) and more that it could simplify your parsing
if you could just do it left-to-right on a single line:

	char *line = xmemdupz(buffer, size);
	const char *p = line;
	if (skip_iprefix(p, "retry-after:", &p)) {
		char *end;
		while (isspace(*p))
			p++;
		opts->retry_after = strtol(p, &end, 10);
		/* if you want to be pedantic */
		if (*end && *end != '\r' && *end != '\n')
			opts->retry_after = 0; /* warn, too? */
	}

If you want to be clever, you could probably avoid the extra allocation,
but I think being able to parse with simple string functions makes it
much more obvious that we don't walk off the end of the input.

-Peff
