Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A5931F461
	for <e@80x24.org>; Fri,  6 Sep 2019 01:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389344AbfIFBYc (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 21:24:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:41602 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731742AbfIFBYc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 21:24:32 -0400
Received: (qmail 11951 invoked by uid 109); 6 Sep 2019 01:24:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Sep 2019 01:24:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 778 invoked by uid 111); 6 Sep 2019 01:26:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2019 21:26:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Sep 2019 21:24:30 -0400
From:   Jeff King <peff@peff.net>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Paul Tan <pyokagan@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Fix maybe-uninitialized warnings found by gcc 9 -flto
Message-ID: <20190906012430.GA29104@sigill.intra.peff.net>
References: <20190905082459.26816-1-s-beyer@gmx.net>
 <20190905224859.GA28660@sigill.intra.peff.net>
 <963e5249-82ca-8961-917a-f45c20b1affe@gmx.net>
 <20190905225802.GA19526@sigill.intra.peff.net>
 <6894a758-d4ee-92e8-1aab-fc44c9ddcdc3@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6894a758-d4ee-92e8-1aab-fc44c9ddcdc3@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 01:10:46AM +0200, Stephan Beyer wrote:

> I took a quick glance at yours. I also noticed the issue you address in
> [PATCH 2/6], but I was unsure if this is the way to go (I'm only
> occasionally reading on this list). I would prefer your patch series,
> with maybe one exception...

Yeah, we've been slowly removing these old "unsigned char *" references
(see a7db4c193d98f for the latest round touching this same code -- I'm
actually surprised I missed this one back then, as that's when
packlist_find() got converted).

> The thing is: I had *exactly* the same commit like your [PATCH 6/6]
> (except for the commit message and for the number), but I dropped it.
> Why? Because I had the feeling (no particular instance though) that the
> second locate_object_entry_hash() for each insertion *can* indeed take
> "too much" time. Also, I was wondering, if the "found = 1" case should
> be catched as a BUG("should not happen") or something.
> 
> I don't care much, though. The performance impact should probably be
> checked carefully.

I did measure it, like this:

  # Do the traversal separately. This would make any difference in the
  # pack-objects hash code stand out _more_, plus it makes it cheaper to
  # run multiple trials.
  git rev-list --objects --all >input

  # Make sure stderr is redirected to avoid progress, which again would
  # amplify any differences.
  git pack-objects --stdout --delta-base-offset <input >/dev/null 2>&1

Running on linux.git, I got:

  [before]
  Benchmark #1: git pack-objects --stdout --delta-base-offset <input >/dev/null 2>&1
    Time (mean ± σ):     26.225 s ±  0.233 s    [User: 24.089 s, System: 4.867 s]
    Range (min … max):   25.915 s … 26.555 s    10 runs

  [after]
  Benchmark #1: git pack-objects --stdout --delta-base-offset <input >/dev/null 2>&1
    Time (mean ± σ):     26.129 s ±  0.170 s    [User: 24.003 s, System: 4.958 s]
    Range (min … max):   25.974 s … 26.570 s    10 runs

So actually faster after, though not statistically significant. ;)

The BUG() on "found==1" might be worth doing.

-Peff
