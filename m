Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEF481F405
	for <e@80x24.org>; Mon, 17 Dec 2018 21:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeLQVoi (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 16:44:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:44220 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726532AbeLQVoi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 16:44:38 -0500
Received: (qmail 24749 invoked by uid 109); 17 Dec 2018 21:44:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 17 Dec 2018 21:44:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6987 invoked by uid 111); 17 Dec 2018 21:44:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 17 Dec 2018 16:44:10 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2018 16:44:36 -0500
Date:   Mon, 17 Dec 2018 16:44:36 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/7] test-lib: parse some --options earlier
Message-ID: <20181217214436.GB14251@sigill.intra.peff.net>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181209225628.22216-1-szeder.dev@gmail.com>
 <20181209225628.22216-3-szeder.dev@gmail.com>
 <20181211110919.GC8452@sigill.intra.peff.net>
 <20181211124245.GT30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181211124245.GT30222@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11, 2018 at 01:42:45PM +0100, SZEDER Gábor wrote:

> > But looking at what this is replacing:
> > 
> > > -case "$GIT_TEST_TEE_STARTED, $* " in
> > > -done,*)
> > > -	# do not redirect again
> > > -	;;
> > > -*' --tee '*|*' --va'*|*' -V '*|*' --verbose-log '*)
> 
> 
> Anyway, I had another crack at turning the current option parsing loop
> into a for loop keeping $@ intact, and the results don't look all that
> bad this time.  Note that this diff below only does the while -> for
> conversion, but leaves the loop where it is, so the changes are easily
> visible.  The important bits are the conditions at the beginning of
> the loop and after the loop, and the handling of '-r'; the rest is
> mostly s/shift// and sort-of s/$1/$opt/.
> 
> Thoughts?  Is it better than two loops?  I think it's better.

It certainly looks better to me. It also makes sense to me to validate
the options before forking/logging, though I suppose one could argue the
opposite.

I wonder why we didn't do it this way in the beginning (i.e., why the
tee bits were all handled separately before the parsing phase). I guess
just because we have to pass the options down to the sub-process.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 9a3f7930a3..efdb6be3c8 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -264,58 +264,65 @@ test "x$TERM" != "xdumb" && (
>  	) &&
>  	color=t
>  
> -while test "$#" -ne 0
> +store_arg_to=
> +prev_opt=
> +for opt
>  do
> -	case "$1" in
> +	if test -n "$store_arg_to"
> +	then
> +		eval $store_arg_to=\$opt
> +		store_arg_to=
> +		prev_opt=
> +		continue
> +	fi

OK, so this is set for the unstuck options, which then pick up the
option in the next loop iteration. That's perhaps less gross than my
"re-build the options with set --" trick.

A simple variable set is enough for "-r". In theory we could make this:

  if test -n "$handle_unstuck_arg"
  then
	eval "$handle_unstuck_arg \$1"
  fi
  ...

  -r)
	handle_unstuck_arg=handle_opt_r ;;

and handle_opt_r() could do whatever it wants. But I don't really
foresee us adding a lot of new options (in fact, given that this is just
the internal tests, I am tempted to say that we should just make it
"-r<arg>" for the sake of simplicity and consistency. But maybe somebody
would be annoyed. I have never used "-r" ever myself).

-Peff
