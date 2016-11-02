Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6E2920229
	for <e@80x24.org>; Wed,  2 Nov 2016 02:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755066AbcKBCMJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 22:12:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:37360 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754615AbcKBCMI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 22:12:08 -0400
Received: (qmail 14454 invoked by uid 109); 2 Nov 2016 02:12:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 02:12:08 +0000
Received: (qmail 32484 invoked by uid 111); 2 Nov 2016 02:12:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Nov 2016 22:12:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Nov 2016 22:12:05 -0400
Date:   Tue, 1 Nov 2016 22:12:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] abbrev: auto size the default abbreviation
Message-ID: <20161102021205.xyxnlxxx4nufvhor@sigill.intra.peff.net>
References: <20161001001937.10884-1-gitster@pobox.com>
 <20161001001937.10884-4-gitster@pobox.com>
 <20161003222701.za5njew33rqc5b6g@sigill.intra.peff.net>
 <xmqqmvhimzrh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmvhimzrh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2016 at 06:33:38PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Sep 30, 2016 at 05:19:37PM -0700, Junio C Hamano wrote:
> >
> >> Introduce a mechanism, where we estimate the number of objects in
> >> the repository upon the first request to abbreviate an object name
> >> with the default setting and come up with a sane default for the
> >> repository.  Based on the expectation that we would see collision in
> >> a repository with 2^(2N) objects when using object names shortened
> >> to first N bits, use sufficient number of hexdigits to cover the
> >> number of objects in the repository.  Each hexdigit (4-bits) we add
> >> to the shortened name allows us to have four times (2-bits) as many
> >> objects in the repository.
> 
> I was idly browsing the draft release notes and then documentation
> and noticed that, even though the new default is to auto-scale,
> there is no mention of that in the documentation and there is no way
> to explicitly ask for auto-scaling.
> 
> I wonder if we want to have something like this.  I actually am
> inclined to drop the change to config.c and remove the new mention
> of "auto" in the documentation.

I doubt anybody cares that much either way, but in theory
core.abbrev=auto is a way to override core.abbrev=10 in /etc/gitconfig
or something. Though I'm having trouble envisioning a case where anybody
would set it in /etc/gitconfig, or why somebody would then want to
override that back to auto.

So I think it is fine either way (but I do agree that the core.abbrev
needs _some_ update to mention the auto-scaling behavior).

> diff --git a/config.c b/config.c
> index 83fdecb1bc..c363cca4a9 100644
> --- a/config.c
> +++ b/config.c
> @@ -834,10 +834,16 @@ static int git_default_core_config(const char *var, const char *value)
>  	}
>  
>  	if (!strcmp(var, "core.abbrev")) {
> -		int abbrev = git_config_int(var, value);
> -		if (abbrev < minimum_abbrev || abbrev > 40)
> -			return -1;
> -		default_abbrev = abbrev;
> +		if (!value)
> +			return config_error_nonbool(var);
> +		if (!strcasecmp(value, "auto"))
> +			default_abbrev = -1;
> +		else {
> +			int abbrev = git_config_int(var, value);
> +			if (abbrev < minimum_abbrev || abbrev > 40)
> +				return -1;
> +			default_abbrev = abbrev;
> +		}

This isn't a new problem you added, but that "return -1" would probably
leave people confused:

  $ git -c core.abbrev=2 log
  fatal: unable to parse 'core.abbrev' from command-line config

Probably something like:

  return error("abbrev length out of range: %d", abbrev);

would be more descriptive. I doubt it's a big deal in practice, though
(why would you set core.abbrev to something silly in the first place?).

-Peff
