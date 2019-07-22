Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A9871F461
	for <e@80x24.org>; Mon, 22 Jul 2019 21:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfGVVAj (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 17:00:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:48736 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730554AbfGVVAj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jul 2019 17:00:39 -0400
Received: (qmail 32473 invoked by uid 109); 22 Jul 2019 21:00:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Jul 2019 21:00:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4522 invoked by uid 111); 22 Jul 2019 21:01:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Jul 2019 17:01:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Jul 2019 17:00:38 -0400
From:   Jeff King <peff@peff.net>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] credential: add nocache option to the credentials API
Message-ID: <20190722210037.GA31664@sigill.intra.peff.net>
References: <20190707055132.103736-1-masayasuzuki@google.com>
 <20190709125620.GA18175@sigill.intra.peff.net>
 <CAJB1erXRg4S-vzRZwA-Q5cXAPayRE0dAjFjjkNQ9CoKiXF=7EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJB1erXRg4S-vzRZwA-Q5cXAPayRE0dAjFjjkNQ9CoKiXF=7EQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 22, 2019 at 10:30:52AM -0700, Masaya Suzuki wrote:

> > In that patch, I essentially proposed making all gathered credentials as
> > nocache. That's a more secure default (though in some cases less
> > convenient).
> >
> > It did break a case Shawn had of caching the result of another helper. I
> > showed some options there for providing a mechanism to chain helpers
> > together explicitly.
> 
> I think that it's better to make it nocache by default. Having one
> helper produce a credential and having another cache it looks storage.
> But since this is the current behavior, I'm OK with just keeping
> nocache an option. It's backward compatible.

Yeah, I think that make sense.

> > We also discussed helpers passing out an explicit ttl. That's a more
> > general case of your nocache flag (i.e., ttl=0 covers that case, but we
> > could additionally pass "ttl" to the cache helper to let it be smarter).
> 
> TTL sounds like it's a generalized version. It might be a bit awkward
> because the existing credential helpers that don't support TTL would
> anyway cache the credentials. I think in practice the password saving
> feature is mainly used by those password management software (like
> git-credential-osxkeychain), and they wouldn't support a short-lived
> credential. Just having nocache seems fine to me. As you said, if
> needed, "ttl" can be added and "nocache" can be just a shorthand of
> "ttl=0".

I was thinking that Git itself could treat "ttl=0" specially, the same
as your nocache, and avoid passing it along to any helpers during the
approve stage. That would make it exactly equivalent to your patch
(modulo the name change).

> > Here we're disallowing a "nocache" credential from being passed to _any_
> > helper, whether it's caching or not. It could be storing permanently,
> > though perhaps that's semantic nitpicking (if it's not to be cached, it
> > probably shouldn't be stored permanently either). Other helpers could in
> > theory be doing something else with the data, though in practice I doubt
> > here are any uses beyond debugging.
> 
> I cannot think of a usage either. If there's a good usage, I would
> change this, but if it's for debugging, it's better to be done with
> those debugging features (like GIT_TRACE_CURL). Note that this is
> called only when the credential is successfully used. We probably want
> to use such debugging feature for the credentials that are not
> successfully used.

Yeah, I don't think debugging is worth caring about here. As you say, we
can dump the data readily through other means. I was more wondering if
there was some legitimate use where a helper wanted to see (but not
store!) an existing credential. But again, I don't know of one.

And as you noted above, if we don't suppress the helper calls inside
Git, then every matching storage helper needs to learn about "nocache"
(or "ttl") before it will do any good.

-Peff
