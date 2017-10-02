Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD3CD202A5
	for <e@80x24.org>; Mon,  2 Oct 2017 06:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750770AbdJBGni (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 02:43:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:57304 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750715AbdJBGnh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 02:43:37 -0400
Received: (qmail 9998 invoked by uid 109); 2 Oct 2017 06:43:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 06:43:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26319 invoked by uid 111); 2 Oct 2017 06:44:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 02:44:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 02:43:35 -0400
Date:   Mon, 2 Oct 2017 02:43:35 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] ref-filter.c: pass empty-string as NULL to atom parsers
Message-ID: <20171002064335.vzm3j2dgax4q5bxd@sigill.intra.peff.net>
References: <20171002055052.GB10729@D-10-157-251-166.dhcp4.washington.edu>
 <20171002055311.29681-1-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171002055311.29681-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 01, 2017 at 10:53:11PM -0700, Taylor Blau wrote:

> Peff points out that different atom parsers handle the empty
> "sub-argument" list differently. An example of this is the format
> "%(refname:)".
> 
> Since callers often use `string_list_split` (which splits the empty
> string with any delimiter as a 1-ary string_list containing the empty
> string), this makes handling empty sub-argument strings non-ergonomic.
> 
> Let's fix this by assuming that atom parser implementations don't care
> about distinguishing between the empty string "%(refname:)" and no
> sub-arguments "%(refname)".

This looks good to me (both the explanation and the function of the
code).

But let me assume for a moment that your "please let me know" from the
earlier series is still in effect, and you wish to be showered with
pedantry and subjective advice. ;)

I see a lot of newer contributors sending single patches as a 1-patch
series with a cover letter. As a reviewer, I think this is mostly just a
hassle. The cover letter ends up mostly repeating the same content from
the single commit, so readers end up having to go over it twice (and you
ended up having to write it twice).

Sometimes there _is_ useful information to be conveyed that doesn't
belong in the commit message, but that can easily go after the "---" (or
before a "-- >8 --" if you really feel it should be read before the
commit message.

In general, if you find yourself writing a really long cover letter, and
especially one that isn't mostly "meta" information (like where this
should be applied, or what's changed since the last version), you should
consider whether that information ought to go into the commit message
instead. The one exception is if you _do_ have a long series and you
need to sketch out the approach to help the reader see the big picture
(in which case your cover letter should be summarizing what's already in
the commit messages).

And before anybody digs in the list to find my novel-length cover
letters to throw back in my face, I know that I'm very guilty of this.
I'm trying to get better at it, and passing it on so you can learn from
my mistakes. :)

> -	if (arg)
> +	if (arg) {
>  		arg = used_atom[at].name + (arg - atom) + 1;
> +		if (!*arg) {
> +			/*
> +			 * string_list_split is often use by atom parsers to
> +			 * split multiple sub-arguments for inspection.
> +			 *
> +			 * Given a string that does not contain a delimiter
> +			 * (example: ""), string_list_split returns a 1-ary
> +			 * string_list that requires adding special cases to
> +			 * atom parsers.
> +			 *
> +			 * Thus, treat the empty argument string as NULL.
> +			 */
> +			arg = NULL;
> +		}
> +	}

I know this is getting _really_ subjective, but IMHO this is a lot more
reasoning than the comment needs. The commit message goes into the
details of the "why", but here I'd have just written something like:

  /* treat "%(foo:)" the same as "%(foo)"; i.e., no arguments */

-Peff
