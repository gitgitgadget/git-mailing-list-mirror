Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98014C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 06:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF6F20739
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 06:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgCUG0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 02:26:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:46006 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726942AbgCUG0M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 02:26:12 -0400
Received: (qmail 10213 invoked by uid 109); 21 Mar 2020 06:26:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Mar 2020 06:26:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15913 invoked by uid 111); 21 Mar 2020 06:35:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 21 Mar 2020 02:35:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 21 Mar 2020 02:26:11 -0400
From:   Jeff King <peff@peff.net>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-lib: allow short options to be stacked
Message-ID: <20200321062611.GA1441446@coredump.intra.peff.net>
References: <48c28683412e3e0803d4c7189a6d66daddcdc580.1584759277.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48c28683412e3e0803d4c7189a6d66daddcdc580.1584759277.git.matheus.bernardino@usp.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 21, 2020 at 12:07:05AM -0300, Matheus Tavares wrote:

> When debugging a test (or a set of tests), it's common to execute it
> with some combination of short options, such as:
> 
> 	$ ./txxx-testname.sh -d -x -i
> 
> In cases like this, CLIs usually allow the short options to be stacked
> in a single argument, for convenience and agility. Let's add this
> feature to test-lib, allowing the above command to be run as:
> 
> 	$ ./txxx-testname.sh -dxi
> 	(or any other permutation, e.g. '-ixd')

Yay. I've grown accustomed to the lack of this feature in the test
scripts, but I'll be happy to have it. :)

Most getopt implementations I've seen call this "bundling" rather than
"stacking" (I don't care too much either way, but Junio mentioned being
confused at the name).

> +	case "$opt" in
> +	--*)
> +		parse_option "$opt" ;;
> +	-?*)
> +		# stacked short options must be fed separately to parse_option
> +		for c in $(echo "${opt#-}" | sed 's/./& /g')
> +		do
> +			parse_option "-$c"
> +		done

I wondered if we could do this without the extra process. This works:

  opt=${opt#-}
  while test -n "$opt"
  do
	extra=${opt#?}
	this=${opt%$extra}
	opt=$extra
	parse_option "-$this"
  done

It's a little convoluted. I'm not sure if saving a process per unbundled
short option is worth it.

What happens to bundled short options with arguments? I think "-r" is
the only one. We don't allow "stuck" short options like "-r5", so we
don't have to worry about feeding non-option bits to parse_option(). It
looks like we'd only examine $store_arg_to outside of the short-option
loop, so we'd treat:

  ./t1234-foo.sh -vrix 5

the same as:

  ./t1234-foo.sh -v -r 5 -i -x

which seems reasonable. But:

  ./t1234-foo.sh -rr 5 6

would get garbled. We'd come out of "-rr" parsing with $store_arg_to
set, but only grab the first argument. I think I could live with that,
considering this is just the test scripts. Fixing it would require
store_arg_to becoming a space-separated list.

-Peff
