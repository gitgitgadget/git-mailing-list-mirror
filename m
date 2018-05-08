Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D014200B9
	for <e@80x24.org>; Tue,  8 May 2018 13:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755305AbeEHNmv (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 09:42:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:60340 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755246AbeEHNmu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 09:42:50 -0400
Received: (qmail 887 invoked by uid 109); 8 May 2018 13:42:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 May 2018 13:42:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4407 invoked by uid 111); 8 May 2018 13:42:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 08 May 2018 09:42:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2018 09:42:48 -0400
Date:   Tue, 8 May 2018 09:42:48 -0400
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
Message-ID: <20180508134248.GA25513@sigill.intra.peff.net>
References: <cover.1522772789.git.johannes.schindelin@gmx.de>
 <cover.1523262449.git.johannes.schindelin@gmx.de>
 <a187a526f46b008c2e81dad6ef90c7d2ddc56044.1523262449.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a187a526f46b008c2e81dad6ef90c7d2ddc56044.1523262449.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 09, 2018 at 10:32:20AM +0200, Johannes Schindelin wrote:

> +static int store_aux_event(enum config_event_t type,
> +			   size_t begin, size_t end, void *data)
> +{
> +	struct config_store_data *store = data;
> +
> +	ALLOC_GROW(store->parsed, store->parsed_nr + 1, store->parsed_alloc);
> +	store->parsed[store->parsed_nr].begin = begin;
> +	store->parsed[store->parsed_nr].end = end;
> +	store->parsed[store->parsed_nr].type = type;
> +	store->parsed_nr++;
> +
> +	if (type == CONFIG_EVENT_SECTION) {
> +		if (cf->var.len < 2 || cf->var.buf[cf->var.len - 1] != '.')
> +			BUG("Invalid section name '%s'", cf->var.buf);

I triggered this BUG today while playing around. Here's a minimal
reproduction:

  echo '[broken' >config
  git config --file=config a.b c

I'm not sure if it should simply be a die() and not a BUG(), since
it depends on the input. Or if it is a BUG and we expected an earlier
part of the code (like the event generator) to catch this broken case
before we get to this function.

-Peff
