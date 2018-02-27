Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C41C1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 21:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeB0VZo (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 16:25:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:39340 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751907AbeB0VZl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 16:25:41 -0500
Received: (qmail 6997 invoked by uid 109); 27 Feb 2018 21:25:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 27 Feb 2018 21:25:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27253 invoked by uid 111); 27 Feb 2018 21:26:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 27 Feb 2018 16:26:29 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Feb 2018 16:25:38 -0500
Date:   Tue, 27 Feb 2018 16:25:38 -0500
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
Message-ID: <20180227212537.GA6899@sigill.intra.peff.net>
References: <DC552BF4-3E87-41E0-BF92-4BA9633D374E@gmail.com>
 <20180216165815.GA4681@tor.lan>
 <19EDC192-0D83-4762-AC6A-81F7D693475A@gmail.com>
 <xmqqbmgfvf2y.fsf@gitster-ct.c.googlers.com>
 <xmqq7er3tqjq.fsf@gitster-ct.c.googlers.com>
 <FDF4DEB8-E71A-4BFC-9437-678C8F65BBDC@gmail.com>
 <20180226014445.GB8677@sigill.intra.peff.net>
 <20180226173533.GA7877@tor.lan>
 <20180226204635.GB12598@sigill.intra.peff.net>
 <20180227210517.GA17555@tor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180227210517.GA17555@tor.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 10:05:17PM +0100, Torsten Bögershausen wrote:

> The other question is:
> Would this help showing diffs of UTF-16 encoded files on a "git hoster",
> github/bitbucket/.... ?

Almost. There's probably one more thing needed. We don't currently read
in-tree .gitattributes when doing a diff in a bare repository. And most
hosting sites will store bare repositories.

And of course it would require the users to actually set the attributes
themselves.

> Or would the auto-magic UTF-16 avoid binary patch that I send out be more helpful ?
> Or both ?
> Or the w-t-e encoding ?

Of the three solutions, I think the relative merits are something like
this:

  1. baked-in textconv (my patch)

     - reuses an existing diff feature, so minimal code and not likely to
       break things

     - requires people to add a .gitattributes entry

     - needs work to make bare-repo .gitattributes work (though I think
       this would be useful for other features, too)

     - has a run-time cost at each diff to do the conversion

     - may sometimes annoy people when it doesn't kick in (e.g.,
       emailed patches from format-patch won't have a readable diff)

     - doesn't combine with other custom-diff config (e.g., utf-16
       storing C code should still use diff=c funcname rules, but
       wouldn't with my patch)

  2. auto-detect utf-16 (your patch)
     - Just Works for existing repositories storing utf-16

     - carries some risk of kicking in when people would like it not to
       (e.g., when they really do want a binary patch that can be
       applied).

       I think it would probably be OK if this kicked in only when
       ALLOW_TEXTCONV is set (the default for porcelain), and --binary
       is not (i.e., when we would otherwise just say "binary
       files differ").

     - similar to (1), carries a run-time cost for each diff, and users
       may sometimes still see binary diffs

  3. w-t-e (Lars's patch)

     - requires no server-side modifications; the diff is plain vanilla

     - works everywhere you diff, plumbing and porcelain

     - does require people to add a .gitattributes entry

     - run-time cost is per-checkout, not per-diff

So I can see room for (3) to co-exist alongside the others. Between (1)
and (2), I think (2) is probably the better direction.

-Peff
