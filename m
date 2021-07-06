Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F959C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 23:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D0A61CB0
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 23:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhGFXYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 19:24:38 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44562 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhGFXYi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 19:24:38 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 435191F8C6;
        Tue,  6 Jul 2021 23:21:59 +0000 (UTC)
Date:   Tue, 6 Jul 2021 23:21:59 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 5/5] oidtree: a crit-bit tree for odb_loose_cache
Message-ID: <20210706232159.GB8624@dcvr>
References: <20210627024718.25383-1-e@80x24.org>
 <20210629205305.7100-6-e@80x24.org>
 <ab757bce-3b51-afac-312c-ea2e883cf0bf@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab757bce-3b51-afac-312c-ea2e883cf0bf@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> wrote:
> Am 29.06.21 um 22:53 schrieb Eric Wong:
> > --- a/alloc.c
> > +++ b/alloc.c
> > @@ -14,6 +14,7 @@
> >  #include "tree.h"
> >  #include "commit.h"
> >  #include "tag.h"
> > +#include "oidtree.h"
> >  #include "alloc.h"
> >
> >  #define BLOCKING 1024
> > @@ -123,6 +124,11 @@ void *alloc_commit_node(struct repository *r)
> >  	return c;
> >  }
> >
> > +void *alloc_from_state(struct alloc_state *alloc_state, size_t n)
> > +{
> > +	return alloc_node(alloc_state, n);
> > +}
> > +
> 
> Why extend alloc.c instead of using mem-pool.c?  (I don't know which fits
> better, but when you say "memory pool" and not use mem-pool.c I just have
> to ask..)

I didn't know mem-pool.c existed :x  (And I've always known
about alloc.c).

Perhaps we could merge them in another series to avoid further
confusion.

> > +void oidtree_insert(struct oidtree *ot, const struct object_id *oid)
> > +{
> > +	struct oidtree_node *on;
> > +
> > +	if (!ot->mempool)
> > +		ot->mempool = allocate_alloc_state();
> > +	if (!oid->algo)
> > +		BUG("oidtree_insert requires oid->algo");
> > +
> > +	on = alloc_from_state(ot->mempool, sizeof(*on) + sizeof(*oid));
> > +	oidcpy_with_padding((struct object_id *)on->n.k, oid);
> > +
> > +	/*
> > +	 * n.b. we shouldn't get duplicates, here, but we'll have
> > +	 * a small leak that won't be freed until oidtree_destroy
> > +	 */
> 
> Why shouldn't we get duplicates?  That depends on the usage of oidtree,
> right?  The current user is fine because we avoid reading the same loose
> object directory twice using the loose_objects_subdir_seen bitmap.

Yes, it reflects the current caller.

> The leak comes from the allocation above, which is not used in case we
> already have the key in the oidtree.  So we need memory for all
> candidates, not just the inserted candidates.  That's probably
> acceptable in most use cases.

Yes, I think the small, impossible-due-to-current-usage leak is
an acceptable trade off.

> We can do better by keeping track of the unnecessary allocation in
> struct oidtree and recycling it at the next insert attempt, however.
> That way we'd only waste at most one slot.

It'd involve maintaining a free list; which may be better
suited to being in alloc_state or mem_pool.  That would also
increase the size of a struct *somewhere* and add a small
amount of code complexity, too.

> > +	cb_insert(&ot->t, &on->n, sizeof(*oid));
> > +}
> > +
> > +int oidtree_contains(struct oidtree *ot, const struct object_id *oid)
> > +{
> > +	struct object_id k = { 0 };
> > +	size_t klen = sizeof(k);
> > +	oidcpy_with_padding(&k, oid);
> 
> Why initialize k; isn't oidcpy_with_padding() supposed to overwrite it
> completely?

Ah, I only added oidcpy_with_padding later into the development
of this patch.

> > +
> > +	if (oid->algo == GIT_HASH_UNKNOWN) {
> > +		k.algo = hash_algo_by_ptr(the_hash_algo);
> > +		klen -= sizeof(oid->algo);
> > +	}
> 
> This relies on the order of the members hash and algo in struct
> object_id to find a matching hash if we don't actually know algo.  It
> also relies on the absence of padding after algo.  Would something like
> this make sense?
> 
>    BUILD_ASSERT_OR_ZERO(offsetof(struct object_id, algo) + sizeof(k.algo) == sizeof(k));

Maybe... I think a static assertion that object_id.hash be the
first element of "struct object_id" is definitely needed, at
least.

> And why set k.algo to some arbitrary value if we ignore it anyway?  I.e.
> why not keep it GIT_HASH_UNKNOWN, as set by oidcpy_with_padding()?

Good point, shortening klen would've been all that was needed.

> > +void oidtree_each(struct oidtree *ot, const struct object_id *oid,
> > +			size_t oidhexlen, oidtree_iter fn, void *arg)
> > +{
> > +	size_t klen = oidhexlen / 2;
> > +	struct oidtree_iter_data x = { 0 };
> > +
> > +	x.fn = fn;
> > +	x.arg = arg;
> > +	x.algo = oid->algo;
> > +	if (oidhexlen & 1) {
> > +		x.last_byte = oid->hash[klen];
> > +		x.last_nibble_at = &klen;
> > +	}
> > +	cb_each(&ot->t, (const uint8_t *)oid, klen, iter, &x);
> > +}
> 
> Clamp oidhexlen at GIT_MAX_HEXSZ?  Or die?

I think an assertion would be enough, here.
init_object_disambiguation already clamps to the_hash_algo->hexsz
