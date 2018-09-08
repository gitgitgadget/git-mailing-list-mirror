Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76D221F404
	for <e@80x24.org>; Sat,  8 Sep 2018 16:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeIHVPa (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 17:15:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:43746 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726314AbeIHVPa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 17:15:30 -0400
Received: (qmail 11943 invoked by uid 109); 8 Sep 2018 16:29:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 08 Sep 2018 16:29:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29178 invoked by uid 111); 8 Sep 2018 16:29:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 08 Sep 2018 12:29:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Sep 2018 12:29:09 -0400
Date:   Sat, 8 Sep 2018 12:29:09 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     timschumi@gmx.de, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH v4 2/3] Show the call history when an alias is looping
Message-ID: <20180908162908.GC9016@sigill.intra.peff.net>
References: <20180905085427.4099-1-timschumi@gmx.de>
 <20180907224430.23859-1-timschumi@gmx.de>
 <20180907224430.23859-2-timschumi@gmx.de>
 <CACsJy8C+VPGyu1D6yeFU3eqzwusv_Q=tobZgvXOtZ=5gYak5dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8C+VPGyu1D6yeFU3eqzwusv_Q=tobZgvXOtZ=5gYak5dg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 08, 2018 at 03:34:34PM +0200, Duy Nguyen wrote:

> On Sat, Sep 8, 2018 at 12:44 AM Tim Schumacher <timschumi@gmx.de> wrote:
> >
> > Just printing the command that the user entered is not particularly
> > helpful when trying to find the alias that causes the loop.
> >
> > Print the history of substituted commands to help the user find the
> > offending alias. Mark the entrypoint of the loop with "<==" and the
> > last command (which looped back to the entrypoint) with "==>".
> 
> An even simpler way to give this information is simply suggest the
> user tries again with GIT_TRACE=1. All alias expansion is shown there
> and we teach the user about GIT_TRACE. But your approach is probably
> more user friendly.

Good point. I'm OK with the amount of code here for the nicer message
(but would be happy either way).

If we were going to track cross-process loops like Ævar suggested, I
think I'd rather go with a simple counter and just ask the user to run
with GIT_TRACE when it exceeds some maximum sanity value. For two
reasons:

  1. Passing a counter through the environment is way simpler than
     an arbitrarily-sized list.

  2. When you get into multiple processes, there's potentially more
     going on than just Git commands. You might have a git command which
     runs a hook which runs a third party script which runs a git
     command, which runs a hook, and so on. That full dump is going to
     be more useful.

-Peff
