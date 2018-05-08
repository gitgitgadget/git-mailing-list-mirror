Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 781D3200B9
	for <e@80x24.org>; Tue,  8 May 2018 14:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932176AbeEHOA5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 10:00:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:60380 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932079AbeEHOA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 10:00:56 -0400
Received: (qmail 1567 invoked by uid 109); 8 May 2018 14:00:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 May 2018 14:00:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4847 invoked by uid 111); 8 May 2018 14:01:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 08 May 2018 10:01:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2018 10:00:54 -0400
Date:   Tue, 8 May 2018 10:00:54 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v3 13/15] git_config_set: make use of the config parser's
 event stream
Message-ID: <20180508140054.GA27712@sigill.intra.peff.net>
References: <cover.1522772789.git.johannes.schindelin@gmx.de>
 <cover.1523262449.git.johannes.schindelin@gmx.de>
 <a187a526f46b008c2e81dad6ef90c7d2ddc56044.1523262449.git.johannes.schindelin@gmx.de>
 <20180508134248.GA25513@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180508134248.GA25513@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 08, 2018 at 09:42:48AM -0400, Jeff King wrote:

> On Mon, Apr 09, 2018 at 10:32:20AM +0200, Johannes Schindelin wrote:
> 
> > +static int store_aux_event(enum config_event_t type,
> > +			   size_t begin, size_t end, void *data)
> > +{
> > +	struct config_store_data *store = data;
> > +
> > +	ALLOC_GROW(store->parsed, store->parsed_nr + 1, store->parsed_alloc);
> > +	store->parsed[store->parsed_nr].begin = begin;
> > +	store->parsed[store->parsed_nr].end = end;
> > +	store->parsed[store->parsed_nr].type = type;
> > +	store->parsed_nr++;
> > +
> > +	if (type == CONFIG_EVENT_SECTION) {
> > +		if (cf->var.len < 2 || cf->var.buf[cf->var.len - 1] != '.')
> > +			BUG("Invalid section name '%s'", cf->var.buf);
> 
> I triggered this BUG today while playing around. Here's a minimal
> reproduction:
> 
>   echo '[broken' >config
>   git config --file=config a.b c
> 
> I'm not sure if it should simply be a die() and not a BUG(), since
> it depends on the input. Or if it is a BUG and we expected an earlier
> part of the code (like the event generator) to catch this broken case
> before we get to this function.

By the way, one side effect of BUG() here is that we call abort(), which
means that our atexit handlers don't run. And a crufty "config.lock"
file is left that prevents running the command again.

In our discussion elsewhere of having BUG() just call exit(), I'm not
sure if we'd want it to skip those cleanups or not (it's helpful to
not run them if you're trying to debug, but otherwise is annoying).

-Peff
