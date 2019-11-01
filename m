Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6521F454
	for <e@80x24.org>; Fri,  1 Nov 2019 19:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfKATnl (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 15:43:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:36562 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725536AbfKATnk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 15:43:40 -0400
Received: (qmail 29273 invoked by uid 109); 1 Nov 2019 19:43:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Nov 2019 19:43:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14184 invoked by uid 111); 1 Nov 2019 19:46:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Nov 2019 15:46:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Nov 2019 15:43:39 -0400
From:   Jeff King <peff@peff.net>
To:     Davide Berardi <berardi.dav@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com
Subject: Re: [PATCH] Segmentation Fault on non-commit --branch clone
Message-ID: <20191101194339.GB1169@sigill.intra.peff.net>
References: <20191101002432.GA49846@carpenter.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191101002432.GA49846@carpenter.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 01, 2019 at 01:24:32AM +0100, Davide Berardi wrote:

> Fixed segmentation fault that can be triggered using
> $ git clone --branch $object $repository
> with object pointing to a non-commit ref (e.g. a blob).

Thanks for working on this. I left some thoughts on the overall fallback
scheme in the other part of the thread, and other than I agree with all
of Dscho's review.

A few other comments:

> +static int fallback_on_noncommit(const struct ref *check,
> +				 const struct ref *remote,
> +				 const char *msg)
> +{
> +	if (check == NULL)
> +		return 1;

I wondered in what circumstances "check" would be NULL. In the first
conditional we pass "our" after checking it's non-NULL:

> 	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
> +		if (fallback_on_noncommit(our, remote, msg) != 0)

and then again in the second case-arm:

> 	} else if (our) {
> +		if (fallback_on_noncommit(our, remote, msg) != 0)

and then in the third we pass remote after checking that it's not NULL:

> 	} else if (remote) {
> +		if (fallback_on_noncommit(remote, remote, msg) != 0)
> +			return;

So I think this NULL check can go away. In general I don't mind
functions being defensive, but it's hard to decide whether it's doing
the right thing since it's not a case we think can come up (it could be
marked with a BUG() assertion, but IMHO it's not worth it; most
functions require their arguments to be non-NULL, so checking it would
be unusual in our code base).

> +static int fallback_on_noncommit(const struct ref *check,
> +				 const struct ref *remote,
> +				 const char *msg)
> [...]
> +	return c == NULL;

The return value for this function is unusual for our code base. If it's
just an error return, we'd usually use "0" for success and a negative
value for errors (i.e., mimicking system calls).

> diff --git a/refs.h b/refs.h
> index 730d05ad91..35ee6eb058 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -497,6 +497,13 @@ enum action_on_err {
> 	UPDATE_REFS_QUIET_ON_ERR
> };
> 
> +/*
> + * In case of a remote HEAD pointing to a non-commit update_head
> + * will make HEAD reference fallback to this value, master ref
> + * should be safe.
> + */
> +#define FALLBACK_REF "refs/heads/master"
> +
> /*

Since this is only used in one spot, I think it's better to keep it
localized to that function. E.g., with:

  static const char fallback_ref[] = "refs/heads/master";

That way it's clear that no other code depends on it.

-Peff
