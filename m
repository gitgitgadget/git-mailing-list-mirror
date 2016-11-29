Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E7F01FF6D
	for <e@80x24.org>; Tue, 29 Nov 2016 07:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755286AbcK2HGl (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 02:06:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:48266 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755119AbcK2HGk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 02:06:40 -0500
Received: (qmail 31055 invoked by uid 109); 29 Nov 2016 07:06:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Nov 2016 07:06:39 +0000
Received: (qmail 8170 invoked by uid 111); 29 Nov 2016 07:07:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Nov 2016 02:07:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Nov 2016 02:06:37 -0500
Date:   Tue, 29 Nov 2016 02:06:37 -0500
From:   Jeff King <peff@peff.net>
To:     Jack Bates <bk874k@nottheoilrig.com>
Cc:     git@vger.kernel.org, Jack Bates <jack@nottheoilrig.com>
Subject: Re: [PATCH] diff: handle --no-abbrev outside of repository
Message-ID: <20161129070637.eult6o3m34r2mima@sigill.intra.peff.net>
References: <20161128182508.10570-1-jack@nottheoilrig.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161128182508.10570-1-jack@nottheoilrig.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2016 at 11:25:08AM -0700, Jack Bates wrote:

> diff --git a/diff.c b/diff.c
> index ec87283..0447eff 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3106,7 +3106,8 @@ static const char *diff_abbrev_oid(const struct object_id *oid, int abbrev)
>  			abbrev = FALLBACK_DEFAULT_ABBREV;
>  		if (abbrev > GIT_SHA1_HEXSZ)
>  			die("BUG: oid abbreviation out of range: %d", abbrev);
> -		hex[abbrev] = '\0';
> +		if (abbrev)
> +			hex[abbrev] = '\0';
>  		return hex;
>  	}

This hunk made me wonder if there is a regression in v2.11, as this
fallback code is new in that version. But I don't think so.

This new code doesn't handle abbrev==0 the same as find_unique_abbrev()
does, and that's clearly a bug. But I couldn't find any way to trigger
it with the existing code.

The obvious way is with --no-abbrev, but that doesn't work without yet
without your patch.

A less obvious way is --abbrev=0, but that gets munged internally to
MINIMUM_ABBREV.

The most obscure is "git -c core.abbrev=0", but that barfs completely on
a too-small abbreviation (without even giving a good error message,
which is something we might want to fix).

So I think there is no regression, and we only have to worry about it as
part of the feature you are adding here (it might be worth calling out
the bug fix specifically in the commit message, though, or even putting
it in its own patch).

-Peff
