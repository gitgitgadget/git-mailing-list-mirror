Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FBBA20960
	for <e@80x24.org>; Mon, 10 Apr 2017 18:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753067AbdDJSWU (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 14:22:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:59332 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751588AbdDJSWT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 14:22:19 -0400
Received: (qmail 15560 invoked by uid 109); 10 Apr 2017 18:22:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 18:22:18 +0000
Received: (qmail 27336 invoked by uid 111); 10 Apr 2017 18:22:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 14:22:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Apr 2017 14:22:15 -0400
Date:   Mon, 10 Apr 2017 14:22:15 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Tom G. Christensen" <tgc@jupiterrise.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [RFC] dropping support for ancient versions of curl
Message-ID: <20170410182215.figy7hm4sogwipyz@sigill.intra.peff.net>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
 <d6ba17f0-3da9-8699-8d5c-5ebf1eaef00e@jupiterrise.com>
 <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
 <20170406005301.4vmjkiu6qkj3g276@genre.crustytoothpaste.net>
 <20170406092942.ow4mvce5miyzbgld@sigill.intra.peff.net>
 <alpine.DEB.2.20.1704071257560.4268@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1704071257560.4268@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 07, 2017 at 01:18:30PM +0200, Johannes Schindelin wrote:

> On Thu, 6 Apr 2017, Jeff King wrote:
> 
> > And it's not like people on ancient mission-critical systems get cut
> > off. They can still run the version of Git they were running when their
> > OS went out of support.
> 
> You keep baiting me, so I'll bite, after resisting the urge for so long.

I wasn't going to respond to this, because I didn't feel like the
discussion was going anywhere. But I ran across yet another issue
related to this today that hadn't been mentioned yet.

Your story shows that yes, it's convenient when old libraries are
supported. I don't dispute that. But one of my earlier points is that
this isn't just about maintenance burden (which I agree is not huge);
it's about whether we do a disservice to users to pretend that Git is
even remotely tested with older versions of curl.

For instance, did you know that versions of curl prior to v7.17 rely on
any strings fed via curl_easy_setopt() remaining valid for the lifetime
of the curl handle[1]?

We have some workarounds for this in old code (for example, see the
handling of CURLOPT_PASSWORD in http.c), but a lot of calls have been
added since then. I think there's a very good chance there are
use-after-free bugs when Git is compiled against an older curl.

I'm concerned that we're giving users a false sense of what is
reasonable to compile against.  You can reframe that as a maintenance
question (we _could_ find and fix those bugs), but that changes the
cost/benefit analysis.

[1] http://public-inbox.org/git/alpine.DEB.2.00.1306180825460.24456@tvnag.unkk.fr/

-Peff
