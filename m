Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7E0C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 01:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D791661100
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 01:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhIUBSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 21:18:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:51322 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhIUBQr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:16:47 -0400
Received: (qmail 2866 invoked by uid 109); 21 Sep 2021 01:15:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 01:15:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25929 invoked by uid 111); 21 Sep 2021 01:15:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Sep 2021 21:15:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Sep 2021 21:15:18 -0400
From:   Jeff King <peff@peff.net>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 1/2] grep: refactor next_match() and
 match_one_pattern() for external use
Message-ID: <YUkyJjaTfDcjakIe@coredump.intra.peff.net>
References: <20210921003050.641393-1-someguy@effective-light.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210921003050.641393-1-someguy@effective-light.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 08:30:49PM -0400, Hamza Mahfooz wrote:

> diff --git a/grep.c b/grep.c
> index 424a39591b..2901233865 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -956,26 +956,34 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
>  	const char *start = bol;
>  
>  	if ((p->token != GREP_PATTERN) &&
> -	    ((p->token == GREP_PATTERN_HEAD) != (ctx == GREP_CONTEXT_HEAD)))
> +	    ((p->token == GREP_PATTERN_HEAD) != (ctx == GREP_CONTEXT_HEAD)) &&
> +	    ((p->token == GREP_PATTERN_BODY) != (ctx == GREP_CONTEXT_BODY)))
>  		return 0;
>  
>  	if (p->token == GREP_PATTERN_HEAD) {
>  		const char *field;
>  		size_t len;
> -		assert(p->field < ARRAY_SIZE(header_field));
> -		field = header_field[p->field].field;
> -		len = header_field[p->field].len;
> -		if (strncmp(bol, field, len))
> -			return 0;
> -		bol += len;
> +		const char *end = eol;
> +
>  		switch (p->field) {
>  		case GREP_HEADER_AUTHOR:
>  		case GREP_HEADER_COMMITTER:
>  			saved_ch = strip_timestamp(bol, &eol);
> +			if (eol == end)
> +				goto again;

I'm not sure if this part is right. If we didn't strip any timestamp,
then we jump to the "again" label, where we actually try to match the
pattern.

But that means we skip the part you deleted above, which got moved down
here:

>  			break;
>  		default:
>  			break;
>  		}
> +
> +		assert(p->field < ARRAY_SIZE(header_field));
> +		field = header_field[p->field].field;
> +		len = header_field[p->field].len;
> +
> +		if (strncmp(bol, field, len))
> +			goto restore;
> +
> +		bol += len;
>  	}

And so we do not check that we have the right field at all. And as a
result, we may return nonsense results. For example, try this in
git.git:

  git log -1 --author=junio 1462b67bc893fc845d28e2748c20357cb16a5ce3

It currently returns no results, because the match is case-sensitive (so
it does not match "Junio" in the author field). But with your patch, it
prints t hat commit (1462b67bc), because it matches a line buried in the
mergetag header ("tag post183-for-junio").

That pattern is how I actually stumbled across it, but an even more
obvious version is:

  git log --author=commit

Currently that returns one result (somebody who has the word "commit" in
their email address). But after your patch, it returns a ton of tag
merges (because they all have "type commit" in their mergetag headers).

-Peff
