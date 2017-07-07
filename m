Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9CB9202AC
	for <e@80x24.org>; Fri,  7 Jul 2017 09:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbdGGJVD (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 05:21:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:33570 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750768AbdGGJVC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 05:21:02 -0400
Received: (qmail 9021 invoked by uid 109); 7 Jul 2017 09:21:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 09:21:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20875 invoked by uid 111); 7 Jul 2017 09:21:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 05:21:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jul 2017 05:21:00 -0400
Date:   Fri, 7 Jul 2017 05:21:00 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Kyle Meyer <kyle@kyleam.com>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 1/7] t1414: document some reflog-walk oddities
Message-ID: <20170707092059.rhimba5ebyzdaj4w@sigill.intra.peff.net>
References: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net>
 <20170707090610.x2vodxgc7yr6o5pi@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170707090610.x2vodxgc7yr6o5pi@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 07, 2017 at 05:06:10AM -0400, Jeff King wrote:

> +test_expect_failure 'walking multiple reflogs shows all' '
> +	# We expect to see all entries for all reflogs, but interleaved by
> +	# date, with order no the command line breaking ties. We
> +	# can use "sort" on the separate lists to generate this,
> +	# but note two tricks:
> +	#
> +	#   1. We use "{" as the delimiter, which lets us skip to the reflog
> +	#      date specifier as our second field, and then our "-n" numeric
> +	#      sort ignores the bits after the timestamp.
> +	#
> +	#   2. POSIX leaves undefined whether this is a stable sort or not. So
> +	#      we use "-k 1" to ensure that we see HEAD before master before
> +	#      side when breaking ties.
> +	{
> +		do_walk --date=unix HEAD &&
> +		do_walk --date=unix side &&
> +		do_walk --date=unix master
> +	} >expect.raw &&
> +	sort -t "{" -k 2nr -k 1 <expect.raw >expect &&

I won't lie; the contortions needed for this "sort" made me a little
sick to my stomach.

It would be much easier if we could do something like:

  git log -g --format="%gt %gd"

and just get the reflog timestamp separately. But we never added %gt, so
we'd have to munge it with sed or perl.

One thing that perl would buy is that we could rely on a stable sort,
and ask for an order besides alphabetical. I.e., we could ask for:

  do_walk side master HEAD

and confirm that "side" comes before "HEAD", even though it doesn't
byte-wise sort.

I didn't think writing a perl snippet was worth the trouble for that
minor benefit, though probably it would be shorter than the comment I
needed to explain the "sort" invocation. ;)

-Peff
