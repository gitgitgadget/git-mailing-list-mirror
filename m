Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AE5C433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 01:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B84164F92
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 01:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhCLBpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 20:45:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:33102 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhCLBpW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 20:45:22 -0500
Received: (qmail 20187 invoked by uid 109); 12 Mar 2021 01:45:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 Mar 2021 01:45:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15999 invoked by uid 111); 12 Mar 2021 01:45:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Mar 2021 20:45:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Mar 2021 20:45:21 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     John Szakmeister <john@szakmeister.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] http: store credential when PKI auth is used
Message-ID: <YErHsQwIC2grgjwI@coredump.intra.peff.net>
References: <20210312004842.30697-1-john@szakmeister.net>
 <20210312004842.30697-2-john@szakmeister.net>
 <YErGymyECXjPXWcP@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YErGymyECXjPXWcP@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 01:41:30AM +0000, brian m. carlson wrote:

> > diff --git a/http.c b/http.c
> > index f8ea28bb2e..12a8aaba48 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -1637,7 +1637,17 @@ static int handle_curl_result(struct slot_results *results)
> >  		credential_approve(&http_auth);
> >  		if (proxy_auth.password)
> >  			credential_approve(&proxy_auth);
> > +		credential_approve(&cert_auth);
> >  		return HTTP_OK;
> > +	} else if (results->curl_result == CURLE_SSL_CERTPROBLEM) {
> > +		/*
> > +		 * We can't tell from here whether it's a bad path, bad
> > +		 * certificate, bad password, or something else wrong
> > +		 * with the certificate.  So we reject the credential to
> > +		 * avoid caching or saving a bad password.
> > +		 */
> > +		credential_reject(&http_auth);
> 
> Is this supposed to be &cert_auth here?  I'm not sure how a bad HTTP
> password would even have been tested in this case.

Good catch! When reviewing, I was so busy thinking about _where_ this
line should go that I didn't even notice what it said. :)

-Peff
