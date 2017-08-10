Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF03C1F667
	for <e@80x24.org>; Thu, 10 Aug 2017 23:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbdHJXmB (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 19:42:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:35614 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751944AbdHJXmA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 19:42:00 -0400
Received: (qmail 3208 invoked by uid 109); 10 Aug 2017 23:42:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 23:42:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11949 invoked by uid 111); 10 Aug 2017 23:42:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 19:42:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 19:41:58 -0400
Date:   Thu, 10 Aug 2017 19:41:58 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: remove prefix_length member from apply_state
Message-ID: <20170810234157.fqsatxk4m3wncm3f@sigill.intra.peff.net>
References: <24fb9d9c-0b1c-4aaa-7d89-12d322066cff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24fb9d9c-0b1c-4aaa-7d89-12d322066cff@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2017 at 05:54:46PM +0200, René Scharfe wrote:

> Use a NULL-and-NUL check to see if we have a prefix and consistently use
> C string functions on it instead of storing its length in a member of
> struct apply_state.  This avoids strlen() calls and simplifies the code.

I had to read the code to figure out exactly what you meant by
NULL-and-NUL (and even then it took me a minute).

I thought at first the latter half just means "use starts_with to walk
the string incrementally rather than bothering to find the length ahead
of time".  Which makes perfect sense to me.

But actually, I think you mean the final block which makes sure we have
a non-empty string.

> diff --git a/apply.c b/apply.c
> index 970bed6d41..168dfe3d16 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -80,7 +80,6 @@ int init_apply_state(struct apply_state *state,
>  {
>  	memset(state, 0, sizeof(*state));
>  	state->prefix = prefix;
> -	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;

So we suspect that state->prefix might be NULL here.

> @@ -786,11 +785,11 @@ static int guess_p_value(struct apply_state *state, const char *nameline)
>  		 * Does it begin with "a/$our-prefix" and such?  Then this is
>  		 * very likely to apply to our directory.
>  		 */
> -		if (!strncmp(name, state->prefix, state->prefix_length))
> +		if (starts_with(name, state->prefix))
>  			val = count_slashes(state->prefix);

At first this looked wrong to me. Don't we need to check for NULL? But
the check is simply just outside the context, so we are good.

>  		else {
>  			cp++;
> -			if (!strncmp(cp, state->prefix, state->prefix_length))
> +			if (starts_with(cp, state->prefix))
>  				val = count_slashes(state->prefix) + 1;
>  		}

And likewise for this one, which is part of the same block.

> @@ -2088,10 +2087,9 @@ static int use_patch(struct apply_state *state, struct patch *p)
>  	int i;
>  
>  	/* Paths outside are not touched regardless of "--include" */
> -	if (0 < state->prefix_length) {
> -		int pathlen = strlen(pathname);
> -		if (pathlen <= state->prefix_length ||
> -		    memcmp(state->prefix, pathname, state->prefix_length))
> +	if (state->prefix && *state->prefix) {
> +		const char *rest;
> +		if (!skip_prefix(pathname, state->prefix, &rest) || !*rest)
>  			return 0;
>  	}

The check for *state->prefix here makes sure the behavior remains
identical. I wondered at first whether it's actually necessary. Wouldn't
an empty prefix always match?

But I think we're looking for the pathname to be a proper superset of
the prefix (hence the "!*rest" check). So I guess an empty path would
not be a proper superset of an empty prefix, even though with the
current code it doesn't hit that block at all.

I'm still not sure it's possible to have an empty pathname, so that
corner case may be moot and we could simplify the condition a little.
But certainly as you've written it, it could not be a regression.

The use of skip_prefix also took me a minute. I wonder if it's worth a
comment with the words "proper superset" or some other indicator (it
also surprised me that we're ok with matching "foobar" in the prefix
"foo", and not demanding "foo/bar". But I didn't look at the context to
know whether that's right or not. This may be a case where the prefix is
supposed to have "/" on it already).

-Peff
