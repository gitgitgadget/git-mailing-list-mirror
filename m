Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 300841F404
	for <e@80x24.org>; Fri, 30 Mar 2018 13:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeC3NJO (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 09:09:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:48566 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752043AbeC3NJN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 09:09:13 -0400
Received: (qmail 8990 invoked by uid 109); 30 Mar 2018 13:09:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 13:09:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27313 invoked by uid 111); 30 Mar 2018 13:10:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 09:10:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 09:09:11 -0400
Date:   Fri, 30 Mar 2018 09:09:11 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 7/9] git config --unset: remove empty sections (in normal
 situations)
Message-ID: <20180330130911.GA29568@sigill.intra.peff.net>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
 <c246c8bc2fb1cd6fe6307463d299cf56fbe4dc5b.1522336130.git.johannes.schindelin@gmx.de>
 <20180329213229.GG2939@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1803301454400.5026@qfpub.tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1803301454400.5026@qfpub.tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 03:00:06PM +0200, Johannes Schindelin wrote:

> > I guess the holy grail would be a parser which reports _all_ syntactic
> > events (section names, keys, comments, whitespace, etc) as a stream
> > without storing anything. And then the normal reader could just discard
> > the non-key events, and the writer here could build the tree from those
> > events.
> 
> I already changed the do_config_from_file()/do_config_from() code path to
> allow for handing back section headers. And I *think* that approach should
> be easily extended to allow for an optional callback for these syntactic
> events (and we do not need more than that, as the parsed "tree" really is
> a list: there is nothing nested about ini files, so we really only have a
> linear list of blocks (event type, offset range)).

True. I was thinking we'd want sections with keys, whitespace, and
comments under them. But even that does not really make sense. As this
patch series shows, comments do not "belong" to a section, and the file
really needs to be considered as a stream.

So yeah, if we can parse it into a sequence of events in one
forward-pass and then manipulate that sequence, I think it should be
sufficient (and _way_ more readable than the current code, even before
the bits you are trying to fix here).

> I'll think about this a little bit, and hopefully come back with v2 in a
> while that uses that approach.
> 
> Thank you so much for that suggestion,

Great. Thanks for working on this.

-Peff
