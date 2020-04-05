Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22768C2BA15
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 19:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07BA2063A
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 19:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgDES7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 14:59:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:33798 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727075AbgDES7w (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 14:59:52 -0400
Received: (qmail 16092 invoked by uid 109); 5 Apr 2020 18:59:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 05 Apr 2020 18:59:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5274 invoked by uid 111); 5 Apr 2020 19:10:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 05 Apr 2020 15:10:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 5 Apr 2020 14:59:51 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fast-import: replace custom hash with hashmap.c
Message-ID: <20200405185951.GA1309762@coredump.intra.peff.net>
References: <20200403121508.GA638328@coredump.intra.peff.net>
 <6926f6fe-2e5c-bcbc-fd0a-5b9a70eed06c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6926f6fe-2e5c-bcbc-fd0a-5b9a70eed06c@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 03, 2020 at 08:53:30PM +0200, René Scharfe wrote:

> > Here are the results for linux.git:
> >
> >   Test                        HEAD^                 HEAD
> >   ----------------------------------------------------------------------------
> >   9300.1: export (no-blobs)   67.64(66.96+0.67)     67.81(67.06+0.75) +0.3%
> >   9300.2: import (no-blobs)   284.04(283.34+0.69)   198.09(196.01+0.92) -30.3%
> 
> My numbers look a bit different for this, not sure why:
> 
> Test                        origin/master         HEAD
> ---------------------------------------------------------------------------
> 9300.1: export (no-blobs)   69.36(66.44+1.56)     67.89(66.07+1.56) -2.1%
> 9300.2: import (no-blobs)   295.10(293.83+1.19)   283.83(282.91+0.91) -3.8%
> 
> They are still in favor of the patch, just not as strongly as yours.

Interesting. I re-ran mine just to double check, and got:

Test                        HEAD^                 HEAD                      
----------------------------------------------------------------------------
9300.1: export (no-blobs)   63.11(62.31+0.79)     62.00(61.21+0.79) -1.8%   
9300.2: import (no-blobs)   261.79(261.06+0.72)   188.55(187.87+0.66) -28.0%

(for some reason my whole machine is faster today; maybe I had closed
slack).

This is on a fresh-ish clone of linux.git.

> > +	e1 = container_of(eptr, const struct object_entry, ent);
> > +	if (oid)
> > +		return oidcmp(&e1->idx.oid, oid);
> > +
> > +	e2 = container_of(entry_or_key, const struct object_entry, ent);
> > +	return oidcmp(&e1->idx.oid, &e2->idx.oid);
> 
> Other hashmap users express this more tersely, similar to this:
> 
> 	const struct object_entry *e1, *e2;
> 
> 	e1 = container_of(eptr, const struct object_entry, ent);
> 	e2 = container_of(entry_or_key, const struct object_entry, ent);
> 	return oidcmp(&e1->idx.oid, keydata ? keydata : &e2->idx.oid);

I wasn't sure if we'd ever see entry_or_key as NULL, in which case the
second container_of() would be undefined behavior. There's a
container_of_or_null() for this, but it seemed simpler to just avoid the
deref entirely if we didn't need it.

I think in practice we won't ever pass NULL, though. Even a
hashmap_get() needs to pass in a hashmap_entry with the hash value in
it. Though I think that's technically _also_ undefined behavior. If I
have a struct where the entry is not at the beginning, like:

  struct foo {
    const char *bar;
    struct hashmap_entry ent;
  };

then:

  e2 = container_of(ptr_to_entry, struct foo, ent);

is going to form a pointer at 8 bytes before ptr_to_entry. If it really
is a "struct hashmap_entry" on the stack, then it's pointing at garbage.

We don't dereference it, so it's likely fine in practice, but even
computing such a pointer does violate the standard.

> > +	hashmap_entry_init(&lookup_entry, oidhash(oid));
> > +	hashent = hashmap_get(&object_table, &lookup_entry, oid);
> > +	if (hashent)
> > +		return container_of(hashent, struct object_entry, ent);
> 
> That duplicates find_object()...

Yes. This is how most hashmap users do it. It's only a few lines, and
sharing without extra work would mean passing the hash value around
(otherwise we'd have to recompute it again), which is awkward.

Though in our case oidhash() is cheap enough that perhaps it's not worth
worrying about?

> >  	e = new_object(oid);
> > -	e->next = object_table[h];
> >  	e->idx.offset = 0;
> > -	object_table[h] = e;
> > +	e->ent.hash = lookup_entry.hash;
> 
> ... except for this part.  Would it make sense to replace this line with
> a call to hashmap_entry_init()?  Seems cleaner to me.  It would look
> like this:
> 	struct object_entry *e = find_object(oid);
> 
> 	if (e)
> 		return e;
> 
> 	e = new_object(oid);
> 	e->idx.offset = 0;
> 	hashmap_entry_init(&e->ent, oidhash(oid));
> 	hashmap_add(&object_table, &e->ent);
> 	return e;

Right, that calls oidhash() again. If we're OK with that, I agree it's a
bit shorter and not any more awkward. I do worry slightly that it sets a
bad example, though (you wouldn't want to repeat a strhash(), for
example).

-Peff
