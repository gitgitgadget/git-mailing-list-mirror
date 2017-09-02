Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 933B2208CD
	for <e@80x24.org>; Sat,  2 Sep 2017 08:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbdIBIRu (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Sep 2017 04:17:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:55636 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751510AbdIBIRt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2017 04:17:49 -0400
Received: (qmail 27060 invoked by uid 109); 2 Sep 2017 08:17:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 02 Sep 2017 08:17:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9157 invoked by uid 111); 2 Sep 2017 08:18:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 02 Sep 2017 04:18:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Sep 2017 04:17:47 -0400
Date:   Sat, 2 Sep 2017 04:17:47 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, martin.agren@gmail.com,
        git@vger.kernel.org, jeffhost@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH] hashmap: add API to disable item counting when threaded
Message-ID: <20170902081747.lca2kkzpniykdxy2@sigill.intra.peff.net>
References: <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
 <20170830185922.10107-1-git@jeffhostetler.com>
 <20170830185922.10107-2-git@jeffhostetler.com>
 <alpine.DEB.2.21.1.1709020109520.4132@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1709020109520.4132@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 02, 2017 at 01:31:19AM +0200, Johannes Schindelin wrote:

> > https://public-inbox.org/git/adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com/
> [...]
> > Add API to hashmap to disable item counting and to disable automatic
> > rehashing.  Also include APIs to re-enable item counting and automatica
> > rehashing.
> [...]
> 
> The Git contribution process forces me to point out lines longer than 80
> columns. I wish there was already an automated tool to fix that, but we
> (as in "the core Git developers") have not yet managed to agree on one. So
> I'll have to ask you to identify and fix them manually.

Perhaps it would be helpful if you pointed out the lines that are too
long. Because I don't see any being added by the patch. There are two in
the commit message. One is a URL. For the other, which is 82 characters,
I'm not sure there is a better tool than "turn on text wrapping in your
editor".

> > +	/* TODO Consider counting them and returning that. */
> 
> I'd rather not. If counting is disabled, it is disabled.
> 
> > +	die("hashmap_get_size: size not set");
> 
> Before anybody can ask for this message to be wrapped in _(...) to be
> translateable, let me suggest instead to add the prefix "BUG: ".

Agreed on both (and Jonathan's suggestion to just use BUG()).

> > +static inline void hashmap_enable_item_counting(struct hashmap *map)
> > +{
> > +	void *item;
> > +	unsigned int n = 0;
> > +	struct hashmap_iter iter;
> > +
> > +	hashmap_iter_init(map, &iter);
> > +	while ((item = hashmap_iter_next(&iter)))
> > +		n++;
> > +
> > +	map->do_count_items = 1;
> > +	map->private_size = n;
> > +}
> 
> BTW this made me think that we may have a problem in our code since
> switching from my original hashmap implementation to the bucket one added
> in 6a364ced497 (add a hashtable implementation that supports O(1) removal,
> 2013-11-14): while it is not expected that there are many collisions, the
> "grow_at" logic still essentially assumes the number of buckets to be
> equal to the number of hashmap entries.

I'm confused about what the problem is. If I am reading the code
correctly, "size" is always the number of elements and "grow_at" is the
table size times a load factor. Those are the same numbers you'd use to
decide to grow in an open-address table.

It's true that this does not take into account the actual number of
collisions we see (or the average per bucket, or however you want to
count it). But generally nor do open-address schemes (and certainly our
other hash tables just use load factor to decide when to grow).

Am I missing something?

-Peff
