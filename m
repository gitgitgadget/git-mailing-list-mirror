Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12A5C20A10
	for <e@80x24.org>; Sat, 30 Sep 2017 07:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752476AbdI3HgY (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 03:36:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:55366 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751345AbdI3HgX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 03:36:23 -0400
Received: (qmail 10643 invoked by uid 109); 30 Sep 2017 07:36:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 30 Sep 2017 07:36:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11487 invoked by uid 111); 30 Sep 2017 07:36:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 30 Sep 2017 03:36:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Sep 2017 03:36:15 -0400
Date:   Sat, 30 Sep 2017 03:36:15 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 5/5] ref-filter.c: parse trailers arguments with
 %(contents) atom
Message-ID: <20170930073615.js3o57qmxlqnkpp5@sigill.intra.peff.net>
References: <20170930062238.87077-1-me@ttaylorr.com>
 <20170930062238.87077-6-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170930062238.87077-6-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 29, 2017 at 11:22:38PM -0700, Taylor Blau wrote:

> The %(contents) atom takes a contents "field" as its argument. Since "trailers"
> is one of those fields, extend contents_atom_parser to parse "trailers"'s
> arguments when used through "%(contents)", like:
> 
>   %(contents:trailers:unfold,only)
> 
> A caveat: trailers_atom_parser expects NULL when no arguments are given (see:
> `parse_ref_filter_atom`). To simulate this behavior without teaching
> trailers_atom_parser to accept strings with length zero, conditionally pass
> NULL to trailers_atom_parser if the arguments portion of the argument to
> %(contents) is empty.

Yeah, this is a weird effect of trailers_atom_parser() doing double-duty
to parse both "%(contents:trailers)" and "%(trailers)".

Though I think trailers_atom_parser() does do the sensible thing with an
empty string (there are no options, so nothing to parse). I.e., I'd
expect the same thing out of:

  %(trailers:)

and

  %(trailers)

even though one gets a NULL "arg" field and the other gets an empty
string.

> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index b7325a25d..0aaac8af9 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -214,10 +214,11 @@ blank line.  The optional GPG signature is `contents:signature`.  The
>  first `N` lines of the message is obtained using `contents:lines=N`.
>  Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
>  are obtained as 'contents:trailers'. Non-trailer lines from the trailer block
> -can be omitted with 'trailers:only'. Whitespace-continuations can be removed
> -from trailers so that each trailer appears on a line by itself with its full
> -content with 'trailers:unfold'. Both can be used together as
> -'trailers:unfold,only'.
> +can be omitted with 'trailers:only', or 'contents:trailers:only'.
> +Whitespace-continuations can be removed from trailers so that each trailer
> +appears on a line by itself with its full content with 'trailers:unfold' or
> +'contents:trailers:unfold'. Both can be used together as 'trailers:unfold,only',
> +or 'contents:trailers:unfold,only'.

Rather than enumerate each, we might do better to just say explicitly
"contents:trailers" and "trailers" are aliases of one another. It looks
like we don't even document %(trailers) at all here. I'd actually be in
favor of just declaring %(trailers) the official spelling, and calling
"%(contents:trailers)" a historical alias.

> diff --git a/ref-filter.c b/ref-filter.c
> index 8573acbed..a8d4a52bd 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -207,8 +207,10 @@ static void contents_atom_parser(struct used_atom *atom, const char *arg)
>  		atom->u.contents.option = C_SIG;
>  	else if (!strcmp(arg, "subject"))
>  		atom->u.contents.option = C_SUB;
> -	else if (!strcmp(arg, "trailers"))
> -		atom->u.contents.option = C_TRAILERS;
> +	else if (skip_prefix(arg, "trailers", &arg)) {
> +		skip_prefix(arg, ":", &arg);
> +		trailers_atom_parser(atom, strlen(arg) ? arg : NULL);
> +	}

We usually spell "is this an empty string?" as "*arg" rather than
calling strlen().

However, I'm not sure we need to check. As I said above, I think
trailers_atom_parser() does the sensible thing with an empty string.

And if we _did_ want to distinguish between

  %(contents:trailers:)

and

  %(contents:trailers)

then I don't think this quite does it. It passes NULL for both cases. So
if we really want to emulate how parse_ref_filter_atom calls it, we'd
want:

  if (!skip_prefix(arg, ":", &arg))
	arg = NULL;
  trailers_atom_parser(atom, arg);

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 2bd0c5da7..d9b71589f 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -642,6 +642,35 @@ test_expect_success '%(trailers:only) and %(trailers:unfold) work together' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '%(contents:trailers:unfold) unfolds trailers' '
> +  git for-each-ref --format="%(contents:trailers:unfold)" refs/heads/master >actual &&
> +  {

This has the same spaces/tabs thing going on as the previous commit.

-Peff
