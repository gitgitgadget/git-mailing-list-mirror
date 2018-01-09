Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196EE1F404
	for <e@80x24.org>; Tue,  9 Jan 2018 06:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753738AbeAIGuV (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 01:50:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:38210 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753630AbeAIGuV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 01:50:21 -0500
Received: (qmail 3038 invoked by uid 109); 9 Jan 2018 06:50:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 09 Jan 2018 06:50:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2257 invoked by uid 111); 9 Jan 2018 06:50:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 09 Jan 2018 01:50:53 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jan 2018 01:50:18 -0500
Date:   Tue, 9 Jan 2018 01:50:18 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [RFC PATCH 00/18] Multi-pack index (MIDX)
Message-ID: <20180109065018.GA32257@sigill.intra.peff.net>
References: <20180107181459.222909-1-dstolee@microsoft.com>
 <87k1wtb8a4.fsf@evledraar.gmail.com>
 <c08416f1-bbec-2037-34a6-f454d85de439@gmail.com>
 <20180108102029.GA21232@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1801081438470.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1801081438470.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 08, 2018 at 02:43:00PM +0100, Johannes Schindelin wrote:

> Take the interactive rebase for example. It generates todo lists with
> abbreviated commit names, for readability (and it is *really* important to
> keep this readable). As we expect new objects to be introduced by the
> interactive rebase, we convert that todo list to unabbreviated commit
> names before executing the interactive rebase.
> 
> Your idea (to not care about unambiguous abbreviations) would break that.

I think that could be easily worked around for rebase by asking git to
check ambiguity during the conversion. Speed is much less of a problem
there, because we're doing a relatively small number of abbreviations
(compared to "git log --oneline --raw", which is abbreviating almost
every object in the repository).

But I agree it's a potential problem for other scripts that we might not
have control over. I hadn't really intended this to be the default
behavior (my patch was just trying to show the direction). But it does
make for a pretty awful interface if callers have to opt into it
manually ("git log --oneline --no-really-go-fast").

I am a bit curious if there's a bounded probability that people would
find acceptable for Git to give an ambiguous abbreviation. We already
accept 1 in 2^160, of course. But would, e.g., one in a million be OK?

-Peff
