Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BF8A208EA
	for <e@80x24.org>; Fri, 27 Jul 2018 13:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732167AbeG0OYW (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 10:24:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:32804 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732163AbeG0OYV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 10:24:21 -0400
Received: (qmail 26328 invoked by uid 109); 27 Jul 2018 13:02:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 27 Jul 2018 13:02:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26074 invoked by uid 111); 27 Jul 2018 13:02:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 27 Jul 2018 09:02:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jul 2018 09:02:29 -0400
Date:   Fri, 27 Jul 2018 09:02:29 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 2/5] Add delta-islands.{c,h}
Message-ID: <20180727130229.GB18599@sigill.intra.peff.net>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
 <20180722054836.28935-3-chriscool@tuxfamily.org>
 <xmqqpnzczila.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpnzczila.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24, 2018 at 09:47:29AM -0700, Junio C Hamano wrote:

> > +/*
> > + * Allocate a new bitmap; if "old" is not NULL, the new bitmap will be a copy
> > + * of "old". Otherwise, the new bitmap is empty.
> > + */
> > +static struct island_bitmap *island_bitmap_new(const struct island_bitmap *old)
> > +{
> > +	size_t size = sizeof(struct island_bitmap) + (island_bitmap_size * 4);
> > +	struct island_bitmap *b = xcalloc(1, size);
> 
> Is one of the variants of flex array macros applicable here?

Hmm, maybe. The tricky thing about this bitmap (and this touches on your
"why another bitmap" question below) is that we have a _ton_ of them
(one per object). So we want to do what we can to keep memory usage
down. So there are two weird things:

 - these bitmaps do not know their own size. They are all exactly the
   same size (one bit per island), and we store the size only once in
   the whole program.

 - they are copy-on-write. This helps because there's a lot of
   locality to the maps within the object graph. But it also means
   sometimes we initialize empty, and sometimes from another array.

So I think it might work to do:

  if (old) {
	/* copy bits from existing bitmap */
	FLEX_ALLOC_MEM(b, bits, old->bits, st_mult(island_bitmap_size, 4));
  } else {
	/* start with all-zero bits courtesy of xcalloc */
	FLEX_ALLOC_MEM(b, bits, NULL, 0);
  }

That'd still waste an extra byte per struct (or 4, I guess, due to
padding), since we unconditionally NUL-terminate the flex-struct (since
they were really designed around string storage).

> > +static int island_bitmap_get(struct island_bitmap *self, uint32_t i)
> > +{
> > +	return (self->bits[ISLAND_BITMAP_BLOCK(i)] & ISLAND_BITMAP_MASK(i)) != 0;
> > +}
> > +
> 
> Not necessarily a complaint, but do we need another implementation
> of bitmap here, or the compressed bitmap used for the pack bitmap is
> unsuited for the purpose of this thing (e.g. perhaps it is overkill,
> as we won't be shooting for saving disk footprint of a bitmap that
> we are not going to save on disk anyway)?

Mostly it's about memory savings, as I discussed above. We _could_ use
ewah bitmaps instead of naive ones here. Those are bad for random access
to bits, but I think most of the operations are "is this bitmap a subset
of this other one" which can be done by walking them linearly.

I doubt the compression would be all that significant, though. They do
best when there's a lot of locality in the bitmap. Here our bits are the
islands, grouped and ordered by some subset of the refname. I don't
think there's any reason to think that refs/heads/a and refs/heads/b
would be correlated. OTOH, if most objects are in most islands (e.g.,
because the islands represent a bunch of forks of some "base" history),
then you might get a big run of 1's for those objects.

I don't think we really experimented with it. To be honest, I don't
recall how much measuring we did for the refcounted bitmaps, either. So
I'm not sure how much the copy-on-write saves (though my vague
recollection is that it was worth doing if you have a lot of islands).

> > +	/*
> > +	 * We process only trees, as commits and tags have already been handled
> > +	 * (and passed their marks on to root trees, as well. We must make sure
> > +	 * to process them in descending tree-depth order so that marks
> > +	 * propagate down the tree properly, even if a sub-tree is found in
> > +	 * multiple parent trees.
> > +	 */
> > +	todo = xmalloc(to_pack->nr_objects * sizeof(*todo));
> > +	for (i = 0; i < to_pack->nr_objects; i++) {
> > +		if (oe_type(&to_pack->objects[i]) == OBJ_TREE)
> > +			todo[nr++] = &to_pack->objects[i];
> > +	}
> > +	qsort(todo, nr, sizeof(*todo), cmp_tree_depth);
> 
> Hmph, at this stage nobody actually seems to set tree_depth; I am
> wondering how a tree that is at the root in one commit but appears
> as a subdirectory in another commit is handled by this code.

The tree depth is set when we actually walk the graph collecting
objects, and we use the max depth at which we've seen it. That said,
this happens in show_object(), which I think we'd avoid entering twice
for the same object (due to list-objects setting the SEEN flag).

So I suspect that yes, you could have a case where a tree has multiple
depths, and we'd visit them topologically out of order. And that could
lead to objects reachable from that tree missing some of their islands.
Something like:

  - refs/remotes/123/master points to commit C which points to tree X,
    which points to blob B

  - refs/remotes/456/master points to commit D which points to tree Y,
    which points to tree X, which points to blob B

We mark C with island "123" and D with island "456", and ditto for their
root trees X and Y. Then we sort the trees by depth, with the intent
that Y would come before its child X. But due to the bogus depth, X may
come first.  We propagate the mark for 123 down to children of X,
including B. When we get to Y, we propagate the mark for 456 down to
tree X. But we don't ever visit X again, because we assume we're going
in topological order through the list.

And we might decide not to allow a delta that we otherwise would
(because B really is in both 123 and 456, but is only marked for one).

> > +static regex_t *island_regexes;
> > +static unsigned int island_regexes_alloc, island_regexes_nr;
> > +static const char *core_island_name;
> 
> Are these (and the bitmap & hashtable) something that "everything in
> the_repository" folks would come in and nuke as global variables?  I
> haven't thought deeply about it, but these smell like that there
> would be one set of such in-core variables per one in-core object
> store plus refs (i.e. repository instance).

I don't think so. They're really local to the single pack-objects operation, so
they're no worse than all the other file-local static globals.

-Peff
