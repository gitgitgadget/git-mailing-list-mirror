Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEF1E1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 19:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeC2Tjg (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 15:39:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:47742 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751256AbeC2Tjf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 15:39:35 -0400
Received: (qmail 23063 invoked by uid 109); 29 Mar 2018 19:39:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Mar 2018 19:39:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21557 invoked by uid 111); 29 Mar 2018 19:40:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 29 Mar 2018 15:40:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2018 15:39:33 -0400
Date:   Thu, 29 Mar 2018 15:39:33 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 0/9] Assorted fixes for `git config` (including the
 "empty sections" bug)
Message-ID: <20180329193932.GA2939@sigill.intra.peff.net>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1522336130.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 05:18:30PM +0200, Johannes Schindelin wrote:

> Little did I know that this would turn not only into a full patch to fix this
> issue, but into a full-blown series of nine patches.

It's amazing how often that happens. :)

> The first patch is somewhat of a "while at it" bug fix that I first thought
> would be a lot more critical than it actually is: It really only affects config
> files that start with a section followed immediately (i.e. without a newline)
> by a one-letter boolean setting (i.e. without a `= <value>` part). So while it
> is a real bug fix, I doubt anybody ever got bitten by it.

That makes me wonder if somebody could craft a malicious config to do
something bad. But I don't think so. Config is trusted already, and it
looks like this bug is both hard to trigger and doesn't result in any
kind of memory funniness, just a bogus output.

> Now, to the really important part: why does this patch series not conflict with
> my very early statements that we cannot simply remove empty sections because we
> may end up with stale comments?
> 
> Well, the patch in question takes pains to determine *iff* there are any
> comments surrounding, or included in, the section. If any are found: previous
> behavior. Under the assumption that the user edited the file, we keep it as
> intact as possible (see below for some argument against this). If no comments
> are found, and let's face it, this is probably *the* common case, as few people
> edit their config files by hand these days (neither should they because it is
> too easy to end up with an unparseable one), the now-empty section *is*
> removed.

I'm not against people editing their config files by hand. But I think
what you propose here makes a lot of sense, because it works as long as
you don't intermingle hand- and auto-editing in the same section (and it
even works if you do intermingle, as long as you don't use comments,
which are probably even more rare).

So it seems like quite a sensible compromise, and I think should make
most people happy.

-Peff
