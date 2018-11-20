Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 033301F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 11:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbeKTWDH (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 17:03:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:45580 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729122AbeKTWDG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 17:03:06 -0500
Received: (qmail 25811 invoked by uid 109); 20 Nov 2018 11:34:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Nov 2018 11:34:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28086 invoked by uid 111); 20 Nov 2018 11:33:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Nov 2018 06:33:47 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Nov 2018 06:34:23 -0500
Date:   Tue, 20 Nov 2018 06:34:23 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (v2.20.0-rc0)
Message-ID: <20181120113423.GA29319@sigill.intra.peff.net>
References: <9e293b1b-1845-1772-409b-031c0bf4d17b@gmail.com>
 <6f532502-d4b6-17f6-0ec7-01079077ac90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f532502-d4b6-17f6-0ec7-01079077ac90@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 10:40:53AM -0500, Derrick Stolee wrote:

> > 28b8a73080 builtin/pack-objects.c 2793) depth++;
> > 108f530385 builtin/pack-objects.c 2797) oe_set_tree_depth(&to_pack, ent,
> > depth);
> 
> This 'depth' variable is incremented as part of a for loop in this patch:
> 
>  static void show_object(struct object *obj, const char *name, void *data)
> @@ -2686,6 +2706,19 @@ static void show_object(struct object *obj, const
> char *name, void *data)
>         add_preferred_base_object(name);
>         add_object_entry(&obj->oid, obj->type, name, 0);
>         obj->flags |= OBJECT_ADDED;
> +
> +       if (use_delta_islands) {
> +               const char *p;
> +               unsigned depth = 0;
> +               struct object_entry *ent;
> +
> +               for (p = strchr(name, '/'); p; p = strchr(p + 1, '/'))
> +                       depth++;
> +
> +               ent = packlist_find(&to_pack, obj->oid.hash, NULL);
> +               if (ent && depth > ent->tree_depth)
> +                       ent->tree_depth = depth;
> +       }
>  }
> 
> And that 'ent->tree_depth = depth;' line is replaced with the
> oe_set_tree_depth() call in the report.
> 
> Since depth is never incremented, we are not covering this block. Is it
> possible to test?

This should be covered by the fix in:

  https://public-inbox.org/git/20181120095053.GC22742@sigill.intra.peff.net/

because now entries at the top-level are depth "1". The "depth++" line
is still never executed in our test suite. I'm not sure how much that
matters.

> > delta-islands.c
> > c8d521faf7  53) memcpy(b, old, size);
> 
> This memcpy happens when the 'old' island_bitmap is passed to
> island_bitmap_new(), but...
> 
> > c8d521faf7 187) b->refcount--;
> > c8d521faf7 188) b = kh_value(island_marks, pos) = island_bitmap_new(b);
> 
> This block has the only non-NULL caller to island_bitmap_new().

This is another case where it triggers a lot for a reasonably-sized
repo, but it's hard to construct a small case. This code implements a
copy-on-write of the bitmap, which means the same objects have to be
accessible from two different paths through the reachability graph, each
with different island marks. And then a test would I guess make sure
that the correct subsets of objects never become deltas, which gets
complicated.

And I think that's a pattern with the delta-island code. What we really
care about most is that if we throw a real fork-network repository at
it, it produces faster clones with fewer un-reusable deltas. So I think
a much more interesting approach here would be perf tests. But:

  - we'd want to count those as coverage, and that likely makes your
    coverage tests prohibitively expensive

  - it requires a specialized repo to demonstrate, which most people
    aren't going to have handy

> > c8d521faf7 212) obj = ((struct tag *)obj)->tagged;
> > c8d521faf7 213) if (obj) {
> > c8d521faf7 214) parse_object(the_repository, &obj->oid);
> > c8d521faf7 215) marks = create_or_get_island_marks(obj);
> > c8d521faf7 216) island_bitmap_set(marks, island_counter);
> 
> It appears that this block would happen if we placed a tag in the delta
> island.

Yep. Again, exercised by real repositories.

I'm not sure how far we want to go in the blind pursuit of coverage.
Certainly we could add a tag to the repo in t5320, and this code would
get executed. But verifying that it's doing the right thing is much
harder (and is more easily done with a perf test).

> > c8d521faf7 397) strbuf_addch(&island_name, '-');
> 
> This block is inside the following patch:
> [...]

Yeah, this triggers if your regex has more than one capture group (and
likewise, we almost certainly don't run the "you have too many groups"
warning).

> > c8d521faf7 433) continue;
> > c8d521faf7 436) list[dst] = list[src];
> 
> These blocks are inside the following nested loop in deduplicate_islands():
> 
> +       for (ref = 0; ref + 1 < island_count; ref++) {
> +               for (src = ref + 1, dst = src; src < island_count; src++) {
> +                       if (list[ref]->hash == list[src]->hash)
> +                               continue;
> +
> +                       if (src != dst)
> +                               list[dst] = list[src];
> +
> +                       dst++;
> +               }
> +               island_count = dst;
> +       }
> 
> This means that our "deduplication" logic is never actually doing anything
> meaningful.

Sorry, I don't even remember what this code is trying to do. The island
code is 5+ years old, and just recently ported to upstream Git by
Christian. And that's perhaps part of my laziness in the above tests; it
would be a significant effort to re-figure out all these corner cases.
It's a big part of why I hadn't been sending the patches upstream
myself.

-Peff
