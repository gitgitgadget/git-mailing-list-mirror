Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E73A61FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 15:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754288AbdBFPqb (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 10:46:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:49789 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752200AbdBFPqb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 10:46:31 -0500
Received: (qmail 10730 invoked by uid 109); 6 Feb 2017 15:46:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 15:46:30 +0000
Received: (qmail 13891 invoked by uid 111); 6 Feb 2017 15:46:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 10:46:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2017 16:46:28 +0100
Date:   Mon, 6 Feb 2017 16:46:28 +0100
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w5h5dmluZCBBIC4=?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 2/5] stash: introduce push verb
Message-ID: <20170206154628.v27z5mqhxylz22ba@sigill.intra.peff.net>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
 <20170205202642.14216-3-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170205202642.14216-3-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 05, 2017 at 08:26:39PM +0000, Thomas Gummerer wrote:

> +		-m|--message)
> +			shift
> +			stash_msg=${1?"-m needs an argument"}
> +			;;

I think this is our first use of the "?" parameter expansion magic. It
_is_ in POSIX, so it may be fine. We may get complaints from people on
weird shell variants, though. If that's the only reason to avoid it, I'd
be inclined to try it and see, as it is much shorter.

OTOH, most of the other usage errors call usage(), and this one doesn't.
Nor is the error message translatable. Perhaps we should stick to the
longer form (and add a helper function if necessary to reduce the
boilerplate).

> +save_stash () {
> +	push_options=
> +	while test $# != 0
> +	do
> +		case "$1" in
> +		--help)
> +			show_help
> +			;;
> +		--)
> +			shift
> +			break
> +			;;
> +		-*)
> +			# pass all options through to push_stash
> +			push_options="$push_options $1"
> +			;;
> +		*)
> +			break
> +			;;
> +		esac
> +		shift
> +	done

I suspect you could just let "--help" get handled in the pass-through
case (it generally takes precedence over errors found in other options,
but I do not see any other parsing errors that could be found by this
loop). It is not too bad to keep it, though (the important thing is that
we're not duplicating all of the push_stash options here).

> +	if test -z "$stash_msg"
> +	then
> +		push_stash $push_options
> +	else
> +		push_stash $push_options -m "$stash_msg"
> +	fi

Hmm. So $push_options is subject to word-splitting here. That's
necessary to split the options back apart. It does the wrong thing if
any of the options had spaces in them. But I don't think there are any
valid options which do so, and "save" would presumably not grow any new
options (they would go straight to "push").

So there is a detectable behavior change:

  [before]
  $ git stash "--bogus option"
  error: unknown option for 'stash save': --bogus option
         To provide a message, use git stash save -- '--bogus option'
  [etc...]

  [after]
  $ git stash "--bogus option"
  error: unknown option for 'stash save': --bogus
         To provide a message, use git stash save -- '--bogus'

but it's probably an acceptable casualty (the "right" way would be to
shell-quote everything you stuff into $push_options and then eval the
result when you invoke push_stash).

Likewise, it's usually a mistake to just stick a new option (like "-m")
after a list of unknown options. But it's OK here because we know we
removed any "--" or non-option arguments.

-Peff
