Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8B6B1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 16:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeJTASG (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 20:18:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:46396 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727700AbeJTASG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 20:18:06 -0400
Received: (qmail 23530 invoked by uid 109); 19 Oct 2018 16:11:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Oct 2018 16:11:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12218 invoked by uid 111); 19 Oct 2018 16:10:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Oct 2018 12:10:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2018 12:11:19 -0400
Date:   Fri, 19 Oct 2018 12:11:19 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH v8 7/7] read-cache: load cache entries on worker threads
Message-ID: <20181019161118.GA8100@sigill.intra.peff.net>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181010155938.20996-8-peartben@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181010155938.20996-8-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 11:59:38AM -0400, Ben Peart wrote:

> +static unsigned long load_cache_entries_threaded(struct index_state *istate, const char *mmap, size_t mmap_size,
> +			unsigned long src_offset, int nr_threads, struct index_entry_offset_table *ieot)

The src_offset parameter isn't used in this function.

In early versions of the series, it was used to feed the p->start_offset
field of each load_cache_entries_thread_data. But after the switch to
ieot, we don't, and instead feed p->ieot_start. But we always begin that
at 0.

Is that right (and we can drop the parameter), or should this logic:

> +	offset = ieot_start = 0;
> +	ieot_blocks = DIV_ROUND_UP(ieot->nr, nr_threads);
> +	for (i = 0; i < nr_threads; i++) {
> [...]

be starting at src_offset instead of 0?

-Peff
