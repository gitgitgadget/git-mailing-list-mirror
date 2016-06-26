Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17D7920179
	for <e@80x24.org>; Sun, 26 Jun 2016 18:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbcFZS17 (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 14:27:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:32882 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751648AbcFZS17 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 14:27:59 -0400
Received: (qmail 5339 invoked by uid 102); 26 Jun 2016 18:27:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Jun 2016 14:27:19 -0400
Received: (qmail 3368 invoked by uid 107); 26 Jun 2016 18:27:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Jun 2016 14:27:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Jun 2016 14:27:16 -0400
Date:	Sun, 26 Jun 2016 14:27:16 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	sschuberth@gmail.com
Subject: Re: [PATCH] config: add conditional include
Message-ID: <20160626182715.GA12546@sigill.intra.peff.net>
References: <20160626070617.30211-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160626070617.30211-1-pclouds@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jun 26, 2016 at 09:06:17AM +0200, Nguyễn Thái Ngọc Duy wrote:

> If the path argument in "include" starts with "gitdir:", it is
> followed by a wildmatch pattern. The include is only effective if
> $GIT_DIR matches the pattern. This is very useful to add configuration
> to a group of repositories.

I think this needs some more introduction to the concept. When you say
"path argument" here, I assumed you meant the value of include.path. But
you really mean: we are introducing a new concept for the "subsection"
field of include.*, which is to provide restrictions for conditional
includes.

It also may be worth discussing the motivation or examples.

> For convenience
> 
>  - "~" is expanded to $USER
> 
>  - if the pattern ends with '/', "**" will be appended (e.g. foo/
>    becomes foo/**). In other words, "foo/" automatically matches
>    everything in starting with "foo/".
> 
>  - if the pattern contains no slashes, it's wrapped around by "**/"
>    and "/**" (e.g. "foo" becomes "**/foo/**"). In other words, "foo"
>    matches any directory component in $GIT_DIR.
>
> The combination of the first two is used to group repositories by
> path. While the last one could be used to match worktree's basename.

This is a nice description, but it probably belongs in the
documentation.

I don't have any real opinion on the rules themselves, though they seem
reasonable to me (though in the first one I assume you mean $HOME).

> This code is originally written by Jeff King [1]. All genius designs
> are his. All bugs are mine (claiming bugs is just more fun :).

Heh. I have written this code in a "something like this" form at least 3
times over the years.  Conditional includes were always something I
planned into the original scheme, but had never actually found a good
use for it. ;)

> +	/*
> +	 * It's OK to run over cond_len in our checks here, as that just pushes
> +	 * us past the final ".", which cannot match any of our prefixes.
> +	 */
> +	if (skip_prefix(cond, "gitdir:", &value)) {

This would benefit from the skip_prefix_mem I proposed in:

  http://article.gmane.org/gmane.comp.version-control.git/298050

(and which is ae989a61dad98debe9899823ca987305f8e8020d in Junio's tree,
though it is only in pu so far, I think).

That eliminates the need for the comment, and auto-update cond_len, so
that later:

> +		strbuf_add(&pattern, value, cond_len - (value - cond));

...you do not have to do extra computation to get the correct length.

This is a tangent, but I wonder if expand_user_path() should take a
buf/len. It always puts the result into a new strbuf anyway, so it would
not be a big deal to do so. Skimming the output of grep, though, it
looks like this might be the only caller that would be helped.

> +		buf = expand_user_path(pattern.buf);
> +		if (buf) {
> +			strbuf_reset(&pattern);
> +			strbuf_addstr(&pattern, buf);
> +			free(buf);
> +		}

Maybe strbuf_attach() would be shorter here?

> +		} else if (!strchr(pattern.buf, '/')) {
> +			/* no slashes match one directory component */
> +			strbuf_insert(&pattern, 0, "**/", 3);
> +			strbuf_addstr(&pattern, "/**");
> +		}

I guess it's a little funny that "foo" and "foo/bar" are matched quite
differently. I wonder if a simpler rule would just be: relative paths
are unanchored.

-Peff
