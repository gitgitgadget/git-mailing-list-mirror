Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E8EE1FADF
	for <e@80x24.org>; Sat, 13 Jan 2018 10:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965464AbeAMKHh (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 05:07:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:43028 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965443AbeAMKHg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 05:07:36 -0500
Received: (qmail 28769 invoked by uid 109); 13 Jan 2018 10:07:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 13 Jan 2018 10:07:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5700 invoked by uid 111); 13 Jan 2018 10:08:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 13 Jan 2018 05:08:10 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Jan 2018 05:07:34 -0500
Date:   Sat, 13 Jan 2018 05:07:34 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: git gc --auto yelling at users where a repo legitimately has
 >6700 loose objects
Message-ID: <20180113100734.GA30698@sigill.intra.peff.net>
References: <87inc89j38.fsf@evledraar.gmail.com>
 <CACsJy8AWO5Vk-Qz3VVBUezWL=oAd9YkeGq=_TXGSb0GSs5bLcg@mail.gmail.com>
 <87d12f9lx1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d12f9lx1.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 12, 2018 at 03:44:26PM +0100, Ævar Arnfjörð Bjarmason wrote:

> More generally, the reason we even have the 2 week limit is to pick a
> good trade-off between performance and not losing someone's work that
> they e.g. "git add"-ed but never committed.
> 
> I'm suggesting (but don't know if this is worth it, especially given
> Jeff's comments) that one smarter approach might be to track where the
> objects came from (e.g. by keeping reflogs for deleted upstream branches
> for $expiry_time).

I don't think reflogs would help here. We consider reflog'd objects as
"reachable". So you'd still have something like this:

  1. You delete a branch. Reflog still mentions its commits.

  2. You run gc (or auto-gc). Those objects are still retained in the
     main pack due to the reachability rule. This may happen multiple
     times, and each time their "timestamp" is updated, because it is
     really just the timestamp of the containing pack.

  3. 30 days later, you run another gc. The reflog is now past its
     expiration and is deleted, and now those objects are unreachable.
     This gc turns them loose, but it still considers them "recent" as
     of the last gc you ran, due to the timestamp thing above.

-Peff
