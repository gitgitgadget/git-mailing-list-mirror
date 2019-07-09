Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 144751F461
	for <e@80x24.org>; Tue,  9 Jul 2019 12:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfGIM4Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 08:56:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:32962 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725947AbfGIM4X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 08:56:23 -0400
Received: (qmail 7387 invoked by uid 109); 9 Jul 2019 12:56:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 09 Jul 2019 12:56:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32715 invoked by uid 111); 9 Jul 2019 12:57:18 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 09 Jul 2019 08:57:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jul 2019 07:56:20 -0500
Date:   Tue, 9 Jul 2019 07:56:20 -0500
From:   Jeff King <peff@peff.net>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] credential: add nocache option to the credentials API
Message-ID: <20190709125620.GA18175@sigill.intra.peff.net>
References: <20190707055132.103736-1-masayasuzuki@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190707055132.103736-1-masayasuzuki@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 06, 2019 at 10:51:32PM -0700, Masaya Suzuki wrote:

> The credentials API calls credentials helpers in order. If a
> username/password pair is returned the helpers and if it's used for
> authentication successfully, it's announced to the helpers and they can
> store it for later use.
> 
> Some credentials are valid only for the limited time and should not be
> cached. In this case, because the credential is announced to all helpers
> and they can independently decide whether they will cache it or not,
> those short-lived credentials can be cached.
> 
> This change adds an option that a credential helper can specify that the
> credential returned by the helper should not be cached. If this is
> specified, even after the credential is used successfully, it won't be
> announced to other helpers for store.

I think this makes sense to do, though note that there's an old
discussion which covers some alternatives:

  https://public-inbox.org/git/20120407033417.GA13914@sigill.intra.peff.net/

In that patch, I essentially proposed making all gathered credentials as
nocache. That's a more secure default (though in some cases less
convenient).

It did break a case Shawn had of caching the result of another helper. I
showed some options there for providing a mechanism to chain helpers
together explicitly.

We also discussed helpers passing out an explicit ttl. That's a more
general case of your nocache flag (i.e., ttl=0 covers that case, but we
could additionally pass "ttl" to the cache helper to let it be smarter).

Given the age of that discussion and the fact that nobody has really
complained much in the interim, I'm OK to go with your much simpler
approach. But I think it's worth at least thinking for a few minutes on
whether there's anything to pull from that discussion. :)

(As a side note, I've had all those patches on my "to revisit and send
upstream" queue for 7 years; if we take yours, maybe I can finally let
them go. ;) ).

>  Documentation/technical/api-credentials.txt | 4 +++-
>  credential.c                                | 4 +++-
>  credential.h                                | 3 ++-
>  t/t0300-credentials.sh                      | 9 +++++++++
>  4 files changed, 17 insertions(+), 3 deletions(-)

The patch itself looks good; two minor comments:

> @@ -296,7 +298,7 @@ void credential_approve(struct credential *c)
>  {
>  	int i;
>  
> -	if (c->approved)
> +	if (c->approved || c->no_cache)
>  		return;
>  	if (!c->username || !c->password)
>  		return;

Here we're disallowing a "nocache" credential from being passed to _any_
helper, whether it's caching or not. It could be storing permanently,
though perhaps that's semantic nitpicking (if it's not to be cached, it
probably shouldn't be stored permanently either). Other helpers could in
theory be doing something else with the data, though in practice I doubt
here are any uses beyond debugging.

I dunno. I started writing that paragraph to suggest calling it
"nostore" or something, but I think that is really no better than
"nocache".

If we did have a ttl, I'd expect to see a check for "ttl=0" here, but
then otherwise pass the ttl along to the helper (and a matching change
in credential-cache to use the minimum of the credential-specific ttl or
the global-configured one).

> diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
> index 82eaaea0f4..ad06f6fe11 100755
> --- a/t/t0300-credentials.sh
> +++ b/t/t0300-credentials.sh
> @@ -118,6 +118,15 @@ test_expect_success 'do not bother storing password-less credential' '
>  	EOF
>  '
>  
> +test_expect_success 'credential_approve does not call helpers for nocache' '
> +	check approve useless <<-\EOF
> +	username=foo
> +	password=bar
> +	nocache=1
> +	--
> +	--
> +	EOF
> +'

At first I thought this test was doing nothing, since we don't generally
expect a helper to produce output for an "approve" request (and there
are cases in lib-credential.sh that rely on that). But the "useless"
helper is intentionally chatty, so it produces output for all requests,
and this would fail without your patch. Good.

The cases in lib-credential also omit the "--" for empty sections, but I
see the similar "do not bother..." test above includes them. It
shouldn't matter either way.

So I think this looks good.

-Peff
