Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9224B1FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 18:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbdCMSsn (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 14:48:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:43332 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750961AbdCMSsm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 14:48:42 -0400
Received: (qmail 28458 invoked by uid 109); 13 Mar 2017 18:48:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Mar 2017 18:48:40 +0000
Received: (qmail 20530 invoked by uid 111); 13 Mar 2017 18:48:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Mar 2017 14:48:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Mar 2017 14:48:37 -0400
Date:   Mon, 13 Mar 2017 14:48:37 -0400
From:   Jeff King <peff@peff.net>
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH 1/3] path.c: Add xdg_cache_home to get paths under
 XDG_CACHE_HOME
Message-ID: <20170313184837.wnluuyflbx63cwlm@sigill.intra.peff.net>
References: <20170313172232.96678-1-lehmacdj@gmail.com>
 <20170313172232.96678-2-lehmacdj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170313172232.96678-2-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2017 at 01:22:30PM -0400, Devin Lehmacher wrote:

> Subject: Re: [GSoC][PATCH 1/3] path.c: Add xdg_cache_home to get paths under XDG_CACHE_HOME

It's nice to keep subject lines succinct, as people will skim through
them in "shortlog" or "log --oneline" output for years to come. Of
course, you should not make them _too_ succinct, but I think there is a
lot of extra detail here.

Probably:

  path.c: add xdg_cache_home

would suffice in this case (not also that we usually do not start
with a capital letter).

> This is necessary to make it posible to use XDG_CACHE_HOME for caches in
> the XDG standard. I modeled this after the very similar xdg_config_home
> function for obtaining paths to functions under XDG_CONFIG_HOME

I think this covers what it needs to, which is good. I'd usually try to
avoid starting the message with "this", as it it can be a bit vague (and
assumes that the body is shown next to the subject, which is not always
the case).

I'd have probably written it like:

  We already have xdg_config_home() to help us format paths in
  XDG_CONFIG_HOME. Let's provide a similar xdg_cache_home() to do the
  same thing for XDG_CACHE_HOME.

or something. I admit this is bikeshedding, but since you're new I feel
like I get to spout off about commit message style. :)

> +char *xdg_cache_home(const char *filename)
> +{
> +	const char *home, *cache_home;
> +
> +	assert(filename);
> +	cache_home = getenv("XDG_CACHE_HOME");
> +	if (cache_home && *cache_home)
> +		return mkpathdup("%s/git/%s", cache_home, filename);
> +
> +	home = getenv("HOME");
> +	if (home)
> +		return mkpathdup("%s/.cache/git/%s", home, filename);
> +	return NULL;
> +}

This looks fine, as it comes from xdg_config_home(). It does make me
wonder if the two should be sharing a common implementation, with a
signature like:

  char *xdg_generic_home(const char *env,
			 const char *fallback,
			 const char *filename);

and then the two functions do:

  return xdg_generic_home("XDG_CACHE_HOME", ".cache", filename);

For two the duplication is not so bad, but I wonder if there are other
xdg paths we'd care about.

And one final note. I notice that we return NULL if the user has no
HOME. But I'm not sure most callers are prepared to handle this. E.g.,
if you have no ident set and no HOME, then we will pass NULL to lstat().
On Linux at least that just gets you EFAULT, but I wouldn't be surprised
if it's a segfault on other systems (probably at least Windows, where we
have an lstat wrapper that calls strlen on the filename).

This is not at all a new thing with your patch, but it might be worth
considering while we are thinking about expanding this interface. I'm
not sure if the callers should be more careful, of it the function
should promise to either die() or return a non-NULL value.

-Peff
