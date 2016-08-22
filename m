Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A2572018E
	for <e@80x24.org>; Mon, 22 Aug 2016 23:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754576AbcHVXSI (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 19:18:08 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34946 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752840AbcHVXSH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 19:18:07 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A3E361F859;
        Mon, 22 Aug 2016 23:18:06 +0000 (UTC)
Date:   Mon, 22 Aug 2016 23:18:06 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/7] delta_base_cache: use list.h for LRU
Message-ID: <20160822231806.GA26148@starla>
References: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
 <20160822215942.nm2jcrkyib7acr4u@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160822215942.nm2jcrkyib7acr4u@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> We keep an LRU list of entries for when we need to drop
> something from an over-full cache. The list is implemented
> as a circular doubly-linked list, which is exactly what
> list.h provides. We can save a few lines by using the list.h
> macros and functions. More importantly, this makes the code
> easier to follow, as the reader sees explicit concepts like
> "list_add_tail()" instead of pointer manipulation.

Yay!

> As a bonus, the list_entry() macro lets us place the lru
> pointers anywhere inside the delta_base_cache_entry struct
> (as opposed to just casting the pointer, which requires it
> at the front of the struct). This will be useful in later
> patches when we need to place other items at the front of
> the struct (e.g., our hashmap implementation requires this).

On a side note, I think we should s/list_entry/container_of/ and
use container_of for hashmap.

Linux kernel defines list_entry to use container_of,
but I'd rather avoid introducing the duality entirely.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I think the result is much nicer, but I found list_entry() a little
> disappointing, because we lack typeof(). So you are stuck writing:
> 
>   struct delta_base_cache_entry *f =
>     list_entry(p, struct delta_base_cache_entry, lru);
> 
> I waffled on adding something like:
> 
>   LIST_ITEM(struct delta_bas_cache_entry, f, p, lru);
> 
> to declare "f" as above. But it's getting rather magical and un-C-like.

Right.  I'd rather keep the list_entry/container_of usage
identical to what developers familiar using userspace-rcu,
ccan/list, or the Linux kernel expect.

>  sha1_file.c | 38 ++++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 22 deletions(-)

Good to see the code reduction.
