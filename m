Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C32620248
	for <e@80x24.org>; Mon, 18 Mar 2019 21:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfCRVtI (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 17:49:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:55584 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726983AbfCRVtI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 17:49:08 -0400
Received: (qmail 11393 invoked by uid 109); 18 Mar 2019 21:49:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Mar 2019 21:49:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24026 invoked by uid 111); 18 Mar 2019 21:49:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 18 Mar 2019 17:49:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2019 17:49:05 -0400
Date:   Mon, 18 Mar 2019 17:49:05 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH 3/4] gc docs: de-duplicate "OPTIONS" and "CONFIGURATION"
Message-ID: <20190318214905.GG29661@sigill.intra.peff.net>
References: <20190318161502.7979-1-avarab@gmail.com>
 <20190318161502.7979-4-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190318161502.7979-4-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 05:15:01PM +0100, Ævar Arnfjörð Bjarmason wrote:

> In an earlier commit I started including the "gc.*" documentation from
> git-config(1) in the git-gc(1) documentation. That still left us in a
> state where the "--auto" option and "gc.auto" were redundantly
> discussing the same thing.
> 
> Fix that by briefly discussing how the option itself works for
> "--auto", and for the rest referring to the configuration
> documentation.
> 
> This revealed existing blind spots in the configuration documentation,
> move over the documentation and reword as appropriate.

Nice improvement. A few comments:

> diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
> index a834a801cd6..605e14bc80b 100644
> --- a/Documentation/config/gc.txt
> +++ b/Documentation/config/gc.txt
> @@ -19,13 +19,27 @@ gc.auto::
>  	objects in the repository, `git gc --auto` will pack them.
>  	Some Porcelain commands use this command to perform a
>  	light-weight garbage collection from time to time.  The
> -	default value is 6700.  Setting this to 0 disables it.
> +	default value is 6700.
> ++
> +Setting this to 0 disables not only automatic packing based on the
> +number of loose objects, but any other heuristic `git gc --auto` will
> +otherwise use to determine if there's work to do, such as
> +`gc.autoPackLimit`.
> ++
> +The repacking of loose objects will be performed with `git repack -d
> +-l`.

I know this last sentence came from the existing documentation, but I
wonder if we should be more vague here. We'd pack with "repack -dl" when
we have just loose objects, and "repack -Adl" when we have too many
packs. Or "repack -adl" if we're pruning now, and "--unpack-unreachable"
otherwise.

I think the point of git-gc is that you don't have to care about that
stuff. It works magically, and if you are implementing your own custom
gc scheme, then you are probably better off reading the output of
GIT_TRACE or looking at the source, rather than this documentation.

>  gc.autoPackLimit::
> +
>  	When there are more than this many packs that are not

What's this newline for? I'm not completely opposed if that's the style
we want, but it seems odd that just this one has a blank between the
variable name and the text.

>  	marked with `*.keep` file in the repository, `git gc
>  	--auto` consolidates them into one larger pack.  The
> -	default	value is 50.  Setting this to 0 disables it.
> +	default value is 50.  Setting this (or `gc.auto`) to 0
> +	disables it. Packs will be consolidated using the `-A` option
> +	of `git repack`.

If we do revise the "-d -l" bit for the loose limit, we'd probably want
to adjust this to match.

> @@ -35,13 +49,18 @@ gc.bigPackThreshold::
>  	If non-zero, all packs larger than this limit are kept when
>  	`git gc` is run. This is very similar to `--keep-base-pack`
>  	except that all packs that meet the threshold are kept, not
> -	just the base pack. Defaults to zero. Common unit suffixes of
> -	'k', 'm', or 'g' are supported.
> +	just the base pack. Defaults to zero or a memory heuristic.
> +	Common unit suffixes of 'k', 'm', or 'g' are supported.

I'm not sure how to read this "or". What's the difference between "0" or
the memory heuristic, and when is one used? Or is that what the "if the
number of kept packs is more than..." below is trying to say?

If so, I wonder if it would be simpler to say "defaults to a memory
heuristic", but with a note for "but under these conditions it is not
used".

Or am I totally misunderstanding how it actually works (which seems
likely to me)?

> +If the amount of memory is estimated not enough for `git repack` to
> +run smoothly and `gc.bigPackThreshold` is not set, the largest pack
> +will also be excluded (which is the equivalent of running `git gc`
> +with `--keep-base-pack`).

I had trouble parsing this first line. Maybe:

  If the amount of memory estimated for `git repack` to run smoothly is
  not available and ...

I guess a lot of this is just being copied from elsewhere, but it's
probably worth cleaning it up while we're here.

> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> [...]
> +See the `gc.auto' option in the "CONFIGURATION" below for how this
> +heuristic works.

s/CONFIGURATION/& section/?

> +Once housekeeping is triggered by exceeding the limits of
> +configurations options such as `gc.auto` and `gc.autoPackLimit`, all

s/configurations/configuration/

-Peff
