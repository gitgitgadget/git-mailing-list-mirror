Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 280321F404
	for <e@80x24.org>; Fri,  6 Apr 2018 21:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbeDFV2o (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 17:28:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:56502 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751435AbeDFV2n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 17:28:43 -0400
Received: (qmail 29331 invoked by uid 109); 6 Apr 2018 21:28:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 21:28:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30034 invoked by uid 111); 6 Apr 2018 21:29:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 17:29:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 17:28:41 -0400
Date:   Fri, 6 Apr 2018 17:28:41 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v2 11/15] git_config_set: do not use a state machine
Message-ID: <20180406212840.GC7870@sigill.intra.peff.net>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
 <cover.1522772789.git.johannes.schindelin@gmx.de>
 <4b3eba873df4355d7a77dfbd74963c636b1ba08e.1522772789.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b3eba873df4355d7a77dfbd74963c636b1ba08e.1522772789.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 03, 2018 at 06:28:42PM +0200, Johannes Schindelin wrote:

> While a neat theoretical construct, state machines are hard to read. In
> this instance, it does not even make a whole lot of sense because we are
> more interested in flags, anyway: has the section been seen? Has the key
> been seen? Does the current section match the key we are looking for?
> 
> Besides, the state `SECTION_SEEN` was named in a misleading way: it did
> not indicate that we saw the section matching the key we are looking
> for, but it instead indicated that we are *currently* in that section.
> 
> Let's just replace the state machine logic by clear and obvious flags.
> 
> This will also make it easier to review the upcoming patches to use the
> newly-introduced `event_fn` callback of the config parser.

I think this is probably a good direction. But one thing state machines
can help with is keeping the state to a manageable size. With 3 bits of
flags, we now have 8 possible states, up from the previous 4.

Clearly some of those are nonsensical (can you be in key_seen without
section_seen? I'd think not), but it's up to the code to interpret and
reset those manually.

I'll defer to your judgement, though, on this making things for the
future patches more readable. You spend a lot more time poking at it
than I have.

-Peff
