Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49A75200B9
	for <e@80x24.org>; Sat,  5 May 2018 18:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeEESYb (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 14:24:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:57176 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751235AbeEESY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 14:24:29 -0400
Received: (qmail 12786 invoked by uid 109); 5 May 2018 18:24:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 05 May 2018 18:24:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12116 invoked by uid 111); 5 May 2018 18:24:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 05 May 2018 14:24:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 May 2018 14:24:27 -0400
Date:   Sat, 5 May 2018 14:24:27 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 01/18] Add a function to solve least-cost assignment
 problems
Message-ID: <20180505182427.GB17700@sigill.intra.peff.net>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de>
 <3f51970cbc44bfe34133c48c0844ed3723e83808.1525448066.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f51970cbc44bfe34133c48c0844ed3723e83808.1525448066.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 04, 2018 at 05:34:29PM +0200, Johannes Schindelin wrote:

> The Jonker-Volgenant algorithm was implemented to answer questions such
> as: given two different versions of a topic branch (or iterations of a
> patch series), what is the best pairing of commits/patches between the
> different versions?

I love git-tbdiff, so I'm excited to see it getting more exposure (and a
speedup). Thanks for working on this!

Two minor nits on this patch:

> +/*
> + * The parameter `cost` is the cost matrix: the cost to assign column j to row
> + * i is `cost[j + column_count * i].
> + */
> +int compute_assignment(int column_count, int row_count, double *cost,
> +		       int *column2row, int *row2column)
> +{
> +	double *v = xmalloc(sizeof(double) * column_count), *d;

Please use st_mult, xcalloc, or ALLOC_ARRAY here to avoid unchecked
multiplication in an allocation. This is probably hard to exploit in
practice (since you'd need sizeof(size_t)/8 columns, which presumably
requires allocating some heavier-weight struct per item). But it makes
auditing easier if we avoid the pattern altogether.

> +/*
> + * Compute an assignment of columns -> rows (and vice versa) such that every
> + * column is assigned to at most one row (and vice versa) minimizing the
> + * overall cost.
> + *
> + * The parameter `cost` is the cost matrix: the cost to assign column j to row
> + * i is `cost[j + column_count * i].
> + *
> + * The arrays column2row and row2column will be populated with the respective
> + * assignments (-1 for unassigned, which can happen only if column_count !=
> + * row_count).
> + */
> +int compute_assignment(int column_count, int row_count, double *cost,
> +		       int *column2row, int *row2column);

It looks like this always returns zero. Is there a ever a case where we
would return an error if this? If not, should it just be void?

-Peff
