Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC92FC636CA
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8808F613FB
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhGPTLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 15:11:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:52236 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhGPTLd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 15:11:33 -0400
Received: (qmail 21659 invoked by uid 109); 16 Jul 2021 19:08:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Jul 2021 19:08:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12066 invoked by uid 111); 16 Jul 2021 19:08:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Jul 2021 15:08:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Jul 2021 15:08:36 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] test-lib-functions: use test-tool for [de]packetize()
Message-ID: <YPHZNJgAkd3m6bhm@coredump.intra.peff.net>
References: <cover-0.5-0000000000-20210714T005115Z-avarab@gmail.com>
 <patch-1.1-546974eed59-20210716T153909Z-avarab@gmail.com>
 <YPG5few/PeStqe/2@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPG5few/PeStqe/2@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 12:53:17PM -0400, Taylor Blau wrote:

> >  packetize () {
> >  	if test $# -gt 0
> >  	then
> >  		packet="$*"
> >  		printf '%04x%s' "$((4 + ${#packet}))" "$packet"
> >  	else
> > -		perl -e '
> > -			my $packet = do { local $/; <STDIN> };
> > -			printf "%04x%s", 4 + length($packet), $packet;
> > -		'
> > +		test-tool pkt-line pack
> >  	fi
> >  }
> 
> For what it's worth, I would be happy to remove the printf shortcut
> entirely. Some quick grepping indicates only 22 uses of the word
> "packetize" in our whole test suite (one of them being the function
> declaration itself). And of the 21 callers, only 10 pass at least one
> argument:
> 
>     git grep -Ew 'packetize [^()&]+' -- t
> 
> So I would be fine with adding 10 more new processes to the test suite
> in the name of simplifying this declaration. I don't feel strongly,
> though, since the conditional here does not really add that much
> complexity.

I'd be fine with that, too. Part of the goal of the cmdline option was
making callers more readable. E.g.,

  -printf "want %s" "$hash_head" | packetize
  +packetize "want $hash_head"

But I think the here-doc input to "test-tool pkt-line" is generally
equally nice, especially when you have multiple lines.

(the commit introducing the cmdline version talks about efficiency, but
there the old version was using 4 processes!)

-Peff
