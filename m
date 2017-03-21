Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E74962095B
	for <e@80x24.org>; Tue, 21 Mar 2017 22:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932835AbdCUWOv (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 18:14:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:49051 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932822AbdCUWOv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 18:14:51 -0400
Received: (qmail 27816 invoked by uid 109); 21 Mar 2017 22:14:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 22:14:50 +0000
Received: (qmail 21672 invoked by uid 111); 21 Mar 2017 22:15:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 18:15:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Mar 2017 18:14:46 -0400
Date:   Tue, 21 Mar 2017 18:14:46 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] stash: don't show internal implementation details
Message-ID: <20170321221445.3jpaoce7qbshtdoq@sigill.intra.peff.net>
References: <20170319202351.8825-1-t.gummerer@gmail.com>
 <20170321221219.28041-1-t.gummerer@gmail.com>
 <20170321221219.28041-2-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170321221219.28041-2-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 10:12:17PM +0000, Thomas Gummerer wrote:

> git stash push uses other git commands internally.  Currently it only
> passes the -q flag to those if the -q flag is passed to git stash.  when
> using 'git stash push -p -q --no-keep-index', it doesn't even pass the
> flag on to the internal reset at all.
> 
> It really is enough for the user to know that the stash is created,
> without bothering them with the internal details of what's happening.
> Always pass the -q flag to the internal git clean and git reset
> commands, to avoid unnecessary and potentially confusing output.
> 
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>

I think combining these is fine. The incorrect output with pathspecs
isn't mentioned anymore, but I think that's OK.

> diff --git a/git-stash.sh b/git-stash.sh
> index 9c70662cc8..ba86d84321 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -299,12 +299,12 @@ push_stash () {
>  	then
>  		if test $# != 0
>  		then
> -			git reset ${GIT_QUIET:+-q} -- "$@"
> +			git reset -q -- "$@"
>  			git ls-files -z --modified -- "$@" |
>  			git checkout-index -z --force --stdin
> -			git clean --force ${GIT_QUIET:+-q} -d -- "$@"
> +			git clean --force -q -d -- "$@"
>  		else
> -			git reset --hard ${GIT_QUIET:+-q}
> +			git reset --hard -q
>  		fi
>  		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
>  		if test -n "$untracked"
> @@ -322,7 +322,7 @@ push_stash () {
>  
>  		if test "$keep_index" != "t"
>  		then
> -			git reset
> +			git reset -q
>  		fi
>  	fi
>  }

These all look fine.

> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 89877e4b52..ea8e5c7818 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -663,7 +663,7 @@ test_expect_success 'stash apply shows status same as git status (relative to cu
>  		sane_unset GIT_MERGE_VERBOSITY &&
>  		git stash apply
>  	) |
> -	sed -e 1,2d >actual && # drop "Saved..." and "HEAD is now..."
> +	sed -e 1,1d >actual && # drop "Saved..."
>  	test_i18ncmp expect actual
>  '

This too, though I think "1d" would be the more usual way to say it.

-peff
