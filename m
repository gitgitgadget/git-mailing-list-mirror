Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 814E82095B
	for <e@80x24.org>; Tue, 21 Mar 2017 22:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932321AbdCUWiQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 18:38:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:49077 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755793AbdCUWiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 18:38:16 -0400
Received: (qmail 29426 invoked by uid 109); 21 Mar 2017 22:38:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 22:38:14 +0000
Received: (qmail 21864 invoked by uid 111); 21 Mar 2017 22:38:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 18:38:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Mar 2017 18:38:09 -0400
Date:   Tue, 21 Mar 2017 18:38:09 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] stash: keep untracked files intact in stash -k
Message-ID: <20170321223809.c7wik5lfjylno6wn@sigill.intra.peff.net>
References: <20170319202351.8825-1-t.gummerer@gmail.com>
 <20170321221219.28041-1-t.gummerer@gmail.com>
 <20170321221219.28041-4-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170321221219.28041-4-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 10:12:19PM +0000, Thomas Gummerer wrote:

> Currently when there are untracked changes in a file "one" and in a file
> "two" in the repository and the user uses:
> 
>     git stash push -k one
> 
> all changes in "two" are wiped out completely.  That is clearly not the
> intended result.  Make sure that only the files given in the pathspec
> are changed when git stash push -k <pathspec> is used.

Good description.

> diff --git a/git-stash.sh b/git-stash.sh
> index 13711764a9..2fb651b2b8 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -314,7 +314,9 @@ push_stash () {
>  
>  		if test "$keep_index" = "t" && test -n "$i_tree"
>  		then
> -			git read-tree --reset -u $i_tree
> +			git read-tree --reset $i_tree
> +			git ls-files -z --modified -- "$@" |
> +			git checkout-index -z --force --stdin
>  		fi

I briefly wondered if this needed "-q" to match the earlier commit, but
"checkout-index" isn't really chatty, so I don't think so (and the
earlier checkout-index doesn't have it either).

I also wondered if this could be done in a single command as:

  git reset -q --hard $i_tree -- "$@"

But "git reset" can't handle pathspecs with "--hard" (which is why the
similar case a few lines above uses the same commands).

So this looks good to me.

> +test_expect_success 'stash -k -- <pathspec> leaves unstaged files intact' '
> +	git reset &&
> +	>foo &&
> +	>bar &&
> +	git add foo bar &&
> +	git commit -m "test" &&
> +	echo "foo" >foo &&
> +	echo "bar" >bar &&
> +	git stash -k -- foo &&
> +	test "",bar = $(cat foo),$(cat bar) &&
> +	git stash pop &&
> +	test foo,bar = $(cat foo),$(cat bar)
> +'

I always get nervous when I see test arguments without quotes, but I
think this is fine (and I couldn't see a shorter way of doing it with
test_cmp).

-Peff
