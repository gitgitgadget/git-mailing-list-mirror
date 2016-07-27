Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5235D203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 13:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904AbcG0NcV (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 09:32:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:49792 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755891AbcG0NcU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 09:32:20 -0400
Received: (qmail 21501 invoked by uid 102); 27 Jul 2016 13:32:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 09:32:19 -0400
Received: (qmail 16653 invoked by uid 107); 27 Jul 2016 13:32:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 09:32:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2016 09:32:14 -0400
Date:	Wed, 27 Jul 2016 09:32:14 -0400
From:	Jeff King <peff@peff.net>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	larsxschneider@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	jnareb@gmail.com, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	e@80x24.org, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v2 4/5] convert: generate large test files only once
Message-ID: <20160727133214.GA14928@sigill.intra.peff.net>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160727000605.49982-1-larsxschneider@gmail.com>
 <20160727000605.49982-5-larsxschneider@gmail.com>
 <c3d7466b-cd3f-9f62-bc82-9f77b4f3d1a4@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3d7466b-cd3f-9f62-bc82-9f77b4f3d1a4@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 04:35:32AM +0200, Torsten Bögershausen wrote:

> > +	mkdir -p generated-test-data &&
> > +	for i in $(test_seq 1 $T0021_LARGE_FILE_SIZE)
> > +	do
> > +		# Generate 1MB of empty data and 100 bytes of random characters
> > +		printf "%1048576d" 1
> > +		printf "$(LC_ALL=C tr -dc "A-Za-z0-9" </dev/urandom | dd bs=$((RANDOM>>8)) count=1 2>/dev/null)"
> I'm not sure how portable /dev/urandom is.
> The other thing, that "really random" numbers are an overkill, and
> it may be easier to use pre-defined numbers,

Right, there are a few reasons not to use /dev/urandom:

  - it's not portable

  - if we have to generate a lot of numbers, it drains the system's
    entropy pool, which is an unfriendly thing to do (and may also be
    slow)

  - it makes our tests random! This sounds like a good thing, but it
    means that if some input happens to cause failure, you are unlikely
    to be able to reproduce it.

Instead, use test-genrandom, which is an LCG that starts at a seed. So
you get a large amount of random-ish quickly and portably, and you get
the same data each time.

-Peff
