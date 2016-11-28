Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E28A71FF6D
	for <e@80x24.org>; Mon, 28 Nov 2016 02:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753440AbcK1CBc (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Nov 2016 21:01:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:47648 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753216AbcK1CBb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2016 21:01:31 -0500
Received: (qmail 29831 invoked by uid 109); 28 Nov 2016 02:01:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 28 Nov 2016 02:01:31 +0000
Received: (qmail 30790 invoked by uid 111); 28 Nov 2016 02:02:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 27 Nov 2016 21:02:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Nov 2016 21:01:28 -0500
Date:   Sun, 27 Nov 2016 21:01:28 -0500
From:   Jeff King <peff@peff.net>
To:     David Aguilar <davvid@gmail.com>
Cc:     Dun Peal <dunpealer@gmail.com>, Git ML <git@vger.kernel.org>
Subject: Re: trustExitCode doesn't apply to vimdiff mergetool
Message-ID: <20161128020128.6jhdpg444xbshtzz@sigill.intra.peff.net>
References: <CAD03jn5PAZcFeesaq2osjo7cYd1frWZeN0odNqTh+AMxSEmLgQ@mail.gmail.com>
 <20161127050818.rmjpvha64y4wosq2@sigill.intra.peff.net>
 <CAD03jn7gU9g7NyDk_3wYTKsYQUtRGg6msvumZqUDs44hMOVX7w@mail.gmail.com>
 <20161127165559.j5okxyztwescheug@sigill.intra.peff.net>
 <20161128014538.GA18691@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161128014538.GA18691@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 27, 2016 at 05:45:38PM -0800, David Aguilar wrote:

> I have a patch that makes it so that none of the tools do the
> check_unchanged logic themselves and instead rely on the
> library code to handle it for them.  This makes the
> implementation uniform across all tools, and allows tools to
> opt-in to trustExitCode=true.
> 
> This means that all of the builtin tools will default to
> trustExitCode=false, and they can opt-in by setting the
> configuration variable.

FWIW, that was the refactoring that came to mind when I looked at the
code yesterday. This is the first time I've looked at the mergetool
code, though, so you can take that with the appropriate grain of salt.

Your patch looks mostly good to me. One minor comment:

>  	merge_cmd () {
> -		trust_exit_code=$(git config --bool \
> -			"mergetool.$1.trustExitCode" || echo false)
> -		if test "$trust_exit_code" = "false"
> -		then
> -			touch "$BACKUP"
> -			( eval $merge_tool_cmd )
> -			check_unchanged
> -		else
> -			( eval $merge_tool_cmd )
> -		fi
> +		( eval $merge_tool_cmd )
>  	}
>  }
>  
> @@ -225,7 +216,20 @@ run_diff_cmd () {
>  
>  # Run a either a configured or built-in merge tool
>  run_merge_cmd () {
> +	touch "$BACKUP"
> +
>  	merge_cmd "$1"
> +	status=$?
> +
> +	trust_exit_code=$(git config --bool \
> +		"mergetool.$1.trustExitCode" || echo false)
> +	if test "$trust_exit_code" = "false"
> +	then
> +		check_unchanged
> +		status=$?
> +	fi
> +

In the original, we only touch $BACKUP if we care about timestamps. I
can't think of a reason it would matter to do the touch in the
trustExitCode=true case, but you could also write it as:

  if test "$trust_exit_code" = "false"
  then
	touch "$BACKUP"
	merge_cmd "$1"
	check_unchanged
  else
	merge_cmd "$1"
  fi

  # now $? is from either merge_cmd or check_unchanged

Yours is arguably less subtle, though, which may be a good thing.

-Peff
