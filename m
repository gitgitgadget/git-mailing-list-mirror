Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0B9C43381
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 20:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9BCB64FC9
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 20:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhCJUBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 15:01:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:59084 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232181AbhCJUBS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 15:01:18 -0500
Received: (qmail 6890 invoked by uid 109); 10 Mar 2021 20:01:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Mar 2021 20:01:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25235 invoked by uid 111); 10 Mar 2021 20:01:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Mar 2021 15:01:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Mar 2021 15:01:17 -0500
From:   Jeff King <peff@peff.net>
To:     John Szakmeister <john@szakmeister.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] http: store credential when PKI auth is used
Message-ID: <YEkljZWg4+lTQRyS@coredump.intra.peff.net>
References: <20210306225253.87130-1-john@szakmeister.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210306225253.87130-1-john@szakmeister.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 06, 2021 at 05:52:53PM -0500, John Szakmeister wrote:

> We already looked for the PKI credentials in the credential store, but
> failed to approve it on success.  Meaning, the PKI certificate password
> was never stored and git would request it on every connection to the
> remote.  Let's complete the chain by storing the certificate password on
> success.
> 
> Signed-off-by: John Szakmeister <john@szakmeister.net>
> ---
> 
> I'm not sure if certificate passwords were not stored for some reason, but
> searching the archives I didn't see a mention of it.  Hopefully this is
> acceptable.  I did try this in an environment where we have client SSL certs and
> this made the user experience much better.

I think it was just something that nobody ever cared about before. The
cert password request got converted to credential_fill() as part of
148bb6a7b4 (http: use credential API to get passwords, 2011-12-10). That
commit added approve/reject for http, because that's what I really cared
about, but the intent was always to treat most password queries
consistently.

> diff --git a/http.c b/http.c
> index f8ea28bb2e..440890695f 100644
> --- a/http.c
> +++ b/http.c
> @@ -1637,6 +1637,8 @@ static int handle_curl_result(struct slot_results *results)
>  		credential_approve(&http_auth);
>  		if (proxy_auth.password)
>  			credential_approve(&proxy_auth);
> +		if (cert_auth.password)
> +			credential_approve(&cert_auth);

So I think this is the right direction, but:

  - you'd need a credential_reject() somewhere, too. Otherwise a bad
    password will get stored and then reused over and over, with no
    opportunity to tell the helper to forget about it.

  - is this the best spot to check that our password was right? We only
    care about unlocking the local cert, which in theory is independent
    of what the server tells us. I suspect we can't really tell the
    difference, though (we hand the cert path and password off to curl,
    and then hopefully a request is successful). So this may be the best
    we can do for approval. But for rejection, I doubt that a 401 would
    be the right response. How does curl respond when the password is
    bad? Likewise, what happens if the password is bad but the server is
    willing to make the request anyway (does curl bail immediately, or
    might we get an HTTP 200 even with a bad cert password)?

  - I think proxy_cert_auth would probably want the same treatment.

  - The "if (cert_auth.password)" is redundant. credential_approve()
    will return silently if there is no password to approve. I know
    you're copying the pattern from directly above, but I think that one
    should be cleaned up, too.

    (I also was mildly surprised that this worked at all, since
    credential_approve() will bail if there is no username field. But
    the cert code fills in an empty username).

Most of those are "nice to have" improvements over what you have here,
but I think without a matching reject() this would be a regression.

-Peff
