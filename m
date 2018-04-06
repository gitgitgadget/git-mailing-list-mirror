Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 355661F404
	for <e@80x24.org>; Fri,  6 Apr 2018 21:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbeDFVWa (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 17:22:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:56456 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751708AbeDFVWa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 17:22:30 -0400
Received: (qmail 29057 invoked by uid 109); 6 Apr 2018 21:22:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 21:22:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29973 invoked by uid 111); 6 Apr 2018 21:23:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 17:23:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 17:22:28 -0400
Date:   Fri, 6 Apr 2018 17:22:28 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v2 08/15] config: introduce an optional event stream
 while parsing
Message-ID: <20180406212227.GA7870@sigill.intra.peff.net>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
 <cover.1522772789.git.johannes.schindelin@gmx.de>
 <a38025bcbc07b83b578ff2f1cde786bdca0c918c.1522772789.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a38025bcbc07b83b578ff2f1cde786bdca0c918c.1522772789.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 03, 2018 at 06:28:29PM +0200, Johannes Schindelin wrote:

> This extends our config parser so that it can optionally produce an event
> stream via callback function, where it reports e.g. when a comment was
> parsed, or a section header, etc.
> 
> This parser will be used subsequently to handle the scenarios better where
> removing config entries would make sections empty, or where a new entry
> could be added to an already-existing, empty section.

Nice, it looks like this didn't end up being too bad to go in this
direction. It seems like this is an optional "also emit the events here"
function you can set. I think in the long run we could actually just
always emit the events to this function. And then we could wrap that to
provide an interface that matches the existing callbacks (just an
event-stream callback that sees EVENT_ENTRY and calls the sub-callback).

But that might end up quite a pain, since we have a zillion entry points
into the config parser, making wrapping tough. So I'm perfectly happy to
stop here for now.

> +static inline int do_event(enum config_event_t type,
> +			   struct parse_event_data *data)

I'm not sure if "inline" here is a good idea, as it seems to get called
quite a few times. If we're trying to make things fast, bloating the
instruction cache may have the opposite effect.

-Peff
