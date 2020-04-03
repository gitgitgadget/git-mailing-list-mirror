Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C105CC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 12:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3C320737
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 12:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403942AbgDCMMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:12:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:60434 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2403862AbgDCMMN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 08:12:13 -0400
Received: (qmail 27047 invoked by uid 109); 3 Apr 2020 12:12:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Apr 2020 12:12:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18659 invoked by uid 111); 3 Apr 2020 12:22:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Apr 2020 08:22:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Apr 2020 08:12:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: fast-import's hash table is slow
Message-ID: <20200403121212.GA65799@coredump.intra.peff.net>
References: <20200331094553.GB7274@coredump.intra.peff.net>
 <fcf422e4-08f6-634a-39ba-18d40d1c25ca@web.de>
 <20200401103522.GE60227@coredump.intra.peff.net>
 <20200401111621.GA1265072@coredump.intra.peff.net>
 <38be9140-546c-e3fa-fb71-c92937094a40@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38be9140-546c-e3fa-fb71-c92937094a40@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 02, 2020 at 08:40:35PM +0200, René Scharfe wrote:

> > And I didn't even have to pre-size the table. This really makes me
> > wonder if there's some silly inefficiency in khash which we could be
> > addressing. Or maybe open-addressing really does lose to chaining here,
> > but I think we keep the load factor low enough that it should be a win.
> 
> Or we're just unlucky.  I tried to find the difference between khash
> with and without presizing using callgrind, but came up empty.  It did
> reveal that fast-import spends 70% of its cycles in a million memset()
> calls issued (indirectly) by git_deflate_init() which in turn is called
> by store_object() which is called from parse_and_store_blob(), though.

I think that 70% is outsized in this case because we're dumping millions
of 4-byte blobs. In a real repo you'd have larger blobs, as well as
actual trees and commits pulling them together.

> Why is the won second when handling 1M objects not showing in its
> output?  I suspect it's because it uses its custom allocator to gather
> its data.  So I ran the test with jemalloc2 preloaded:
> 
> nr_objects   master       khash       khash+preload
> 2^20         0m5.812s     0m5.600s    0m5.604s
> 2^21         0m12.913s    0m10.884s   0m10.357s
> 2^22         0m31.257s    0m21.461s   0m21.031s
> 2^23         1m20.904s    0m40.181s   0m42.607s
> 2^24         3m59.201s    1m21.104s   1m23.814s
> 
> My measurements are noisy, but my point is simply that with a different
> allocator you'd not even have seen any slowdown when switching to khash.

Yeah, that makes sense. I still prefer the hashmap solution for its lack
of pointer hackery, given that it seems to perform as well or better.
I'll send a cleaned-up patch in a moment.

> >  struct object_entry {
> >  	struct pack_idx_entry idx;
> > -	struct object_entry *next;
> > +	struct hashmap_entry ent;
> 
> That uses 16 bytes more memory per entry on x64 than khash would.
> That's 256MB for 2^24 objects -- not ideal, but bearable, I guess.

Isn't it 8? We're dropping the old pointer and replacing it with the
"next" pointer in hashmap_entry, plus our 4-byte hash code (which likely
gets padded to 8).

I think it's probably OK in practice.

> > +static int object_entry_hashcmp(const void *map_data,
> > +				const struct hashmap_entry *eptr,
> > +				const struct hashmap_entry *entry_or_key,
> > +				const void *keydata)
> > +{
> > +	const struct object_id *oid = keydata;
> > +	const struct object_entry *e1, *e2;
> > +
> > +	e1 = container_of(eptr, const struct object_entry, ent);
> 
> That's nicer that the pointer alchemy in the khash conversion for sure.
> 
> But why const?  Can const change the layout of a structure?  Scary.

No, I don't think it can. I mostly copied the "const" from the other
container_of() hashmap sites. I don't think it matters in practice,
because we're assigning the result to a const pointer anyway. But it
seems a little cleaner not to momentarily cast away the constness even
inside the macro.

-Peff
