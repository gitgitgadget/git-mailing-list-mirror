Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B730201B0
	for <e@80x24.org>; Sun, 26 Feb 2017 06:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbdBZGVJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 01:21:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:34317 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750970AbdBZGUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2017 01:20:25 -0500
Received: (qmail 12441 invoked by uid 109); 26 Feb 2017 06:12:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Feb 2017 06:12:23 +0000
Received: (qmail 8451 invoked by uid 111); 26 Feb 2017 06:12:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Feb 2017 01:12:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Feb 2017 01:12:20 -0500
Date:   Sun, 26 Feb 2017 01:12:20 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        sschuberth@gmail.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 1/1] config: add conditional include
Message-ID: <20170226061220.nizc4xeucx6ks6vq@sigill.intra.peff.net>
References: <20170223122346.12222-1-pclouds@gmail.com>
 <20170224131425.32409-1-pclouds@gmail.com>
 <20170224131425.32409-4-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170224131425.32409-4-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 08:14:25PM +0700, Nguyễn Thái Ngọc Duy wrote:

> +static int include_condition_is_true(const char *cond, size_t cond_len)
> +{
> +	/* no condition (i.e., "include.path") is always true */
> +	if (!cond)
> +		return 1;
> +
> +	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
> +		return include_by_gitdir(cond, cond_len, 0);
> +	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
> +		return include_by_gitdir(cond, cond_len, 1);
> +
> +	error(_("unrecognized include condition: %.*s"), (int)cond_len, cond);
> +	/* unknown conditionals are always false */
> +	return 0;
> +}

This "error()" is a nice warning to people who have misspelled the
condition (or are surprised that an old version does not respect their
condition). But it seems out of place with the rest of the compatibility
strategy, which is to quietly ignore include types we don't understand.

For example, if your patch ships in v2.13 and we add the "foo:"
condition in v2.14, then with config like:

  [includeif "foo:bar"]
  path = whatever

you get:

  v2.12: silently ignore
  v2.13: loudly ignore
  v2.14: works

which seems odd.

If we do keep it, it should probably be warning(). I would expect
"error:" to indicate that some requested operation could not be
completed, but this is just "by the way, I ignored this garbage".

-Peff

PS I know we try to avoid dashes in the section names, but "includeIf"
   and "includeif" just look really ugly to me. Maybe it is just me,
   though.
