Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6242CC46467
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 23:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjAOXWs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 18:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjAOXWr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 18:22:47 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C0810E1
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 15:22:47 -0800 (PST)
Received: (qmail 9263 invoked by uid 109); 15 Jan 2023 23:22:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Jan 2023 23:22:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25121 invoked by uid 111); 15 Jan 2023 23:22:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Jan 2023 18:22:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 15 Jan 2023 18:22:45 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] http: support CURLOPT_PROTOCOLS_STR
Message-ID: <Y8SKxZyh6xn2npbh@coredump.intra.peff.net>
References: <Y8RddcM9Vr71ljp4@coredump.intra.peff.net>
 <Y8ReHbGWetJHQcI1@coredump.intra.peff.net>
 <8f175d26-3d84-3019-031d-e358390f2de4@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f175d26-3d84-3019-031d-e358390f2de4@ramsayjones.plus.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 15, 2023 at 09:37:07PM +0000, Ramsay Jones wrote:

> > +/**
> > + * CURLOPT_PROTOCOLS_STR and CURLOPT_REDIR_PROTOCOLS_STR were added in 7.85.0,
> > + * released in August 2022.
> > + */
> > +#if LIBCURL_VERSION_NUM >= 0x075500
> > +#define GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR 1
> > +#endif
> 
> Ah, I haven't really grokked what this file is about ... but this
> looks simple enough. ;)

It's newish from the cleanups in e4ff3b67c2 (http: centralize the
accounting of libcurl dependencies, 2021-09-13). I mostly just
cargo-culted this part. ;)

> > +#ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
> > +	{
> > +		struct strbuf buf = STRBUF_INIT;
> > +
> > +		get_curl_allowed_protocols(0, &buf);
> > +		curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS_STR, buf.buf);
> > +		strbuf_reset(&buf);
> > +
> > +		get_curl_allowed_protocols(-1, &buf);
> > +		curl_easy_setopt(result, CURLOPT_PROTOCOLS_STR, buf.buf);
> > +		strbuf_release(&buf);
> 
> I used two static char arrays to accumulate the strings before
> passing them to curl. I was unsure of the lifetime/ownership
> semantics - I still haven't got around to looking them up!

Really old versions of curl had lifetime issues, but for a long now
(since before the oldest version we'd support), the rule is generally
that curl will copy any opt strings as necessary.

The allocations do feel heavyweight for setting an option. And I think
this get_curl_handle() is really called once per request, so we _could_
probably just generate them once and cache the result. But in general
I've been trying to avoid hidden static variables, etc, as they make
later libification efforts harder. And an extra malloc() on top of an
HTTP request is probably not noticeable.

> > +#else
> >  	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
> > -			 get_curl_allowed_protocols(0));
> > +			 get_curl_allowed_protocols(0, NULL));
> >  	curl_easy_setopt(result, CURLOPT_PROTOCOLS,
> > -			 get_curl_allowed_protocols(-1));
> > +			 get_curl_allowed_protocols(-1, NULL));
> > +#endif
> > +
> >  	if (getenv("GIT_CURL_VERBOSE"))
> >  		http_trace_curl_no_data();
> >  	setup_curl_trace(result);
> 
> (another reason for not completing these patches - I don't
> know what the test coverage is like for these changes; are
> more tests required? dunno).

I had wondered that, too. ;) It's covered by t5812 (my quick and dirty
check was to just drop these lines and see what broke in the test
suite).

-Peff
