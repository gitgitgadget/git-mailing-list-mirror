Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E25E1F453
	for <e@80x24.org>; Sun, 30 Sep 2018 04:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeI3L2m (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 07:28:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:36598 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727753AbeI3L2m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 07:28:42 -0400
Received: (qmail 13035 invoked by uid 109); 30 Sep 2018 04:57:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 30 Sep 2018 04:57:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9646 invoked by uid 111); 30 Sep 2018 04:56:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 30 Sep 2018 00:56:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Sep 2018 00:57:13 -0400
Date:   Sun, 30 Sep 2018 00:57:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH] fetch: replace string-list used as a look-up table with
 a hashmap
Message-ID: <20180930045713.GB32120@sigill.intra.peff.net>
References: <xmqqin2sj6df.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kamkLV7yHtCu_qSqNzj7bJm0=Uw1CKxss+zTKJWsYz3qw@mail.gmail.com>
 <20180927055415.GC14178@sigill.intra.peff.net>
 <xmqqva6o88b7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqva6o88b7.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 11:31:08AM -0700, Junio C Hamano wrote:

> > The only funny thing is that you have to "dereference" the iterator like
> > this:
> >
> >   struct list_head *pos;
> >   struct actual_thing *item;
> >   ...
> >   item = list_entry(pos, struct actual_thing, list_member);
> >
> > which is a minor pain, but it's reasonably hard to get it wrong.
> >
> > I wonder if we could do the same here. The hashmap would only ever see
> > the "struct hashmap_entry", and then the caller would convert that back
> > to the actual type.
> 
> Hmph, how would hashmap_cmp_fn look like with that scheme?  It would
> get one entry, another entry (or just the skeleton of it) and
> optionally a separate keydata (if the second one is skeleton), and
> the first two points at the embedded hashmap struct, not the
> surrounding one.  The callback function is now responsible for
> calling a hashmap_entry() macro that adjusts for the negative offset
> like list_entry() does?

Exactly. The comparison functions currently look something like this:

  int foo_hash_cmp(const void *data,
		   const void *e1, const void *e2,
		   const void *keydata)
  {
	const struct foo *f1 = (const struct foo *)e1;
	const struct foo *f2 = (const struct foo *)e2;
	return strcmp(foo->field, keydata ? keydata : foo->field);
  }

(this is using the correct function signature; you can drop the casts if
you violate that, but IMHO this style is more maintainable in the long
run). With the hashmap_entry at an arbitrary position, the body is:

  const struct foo *f1 = hash_entry(e1, struct foo, hash_field);
  const struct foo *f2 = hash_entry(e2, struct foo, hash_field);
  return strcmp(foo->field, keydata ? keydata : foo->field);

where hash_field is the member of "struct foo" that holds the "struct
hashmap_entry". So that's not so different, but there is an interesting
implication here. The comparison callback has to know which
hashmap_entry name to use! So if you have a struct that can be in two
hashes, like:

  struct foo {
    char *name;
    struct hashmap_entry h1;
    struct hashmap_entry h2;
  };

then you cannot use a single foo_hash_cmp() function. You have to use a
different one for each field. Which seems kind of nasty and error-prone.

So I dunno. Maybe this is not a good direction. I have to admit that I'm
not wild about our hashmap implementation in general:

  - the way it handles allocations is often awkward, or causes you to
    write confusing boilerplate

  - it's not type-safe

  - it seems slower than open-addressed alternatives (e.g., over in [1]
    we determined that oidset can be made almost twice as fast using
    khash)

  - the chained implementation in hashmap.c is probably better for cases
    where there's a lot of deletions, because removing from the hashmap
    truly removes everything (whereas with open-addressed schemes, we
    either didn't implement deletion at all, or it sets a marker which
    allows the item to be dropped next time the hash is resized)

[1] https://public-inbox.org/git/20180814015842.GA27055@sigill.intra.peff.net/

> Was it ever a consideration, when allowing struct list-head anywhere
> in the enclosing struct, that it would allow an element to be on
> more than one list?

I don't know the history of that list code in that kernel, but I always
assumed that was one of the goals. We don't use it yet, but there are
places where we could (e.g., packed_git is part of the regular packed
list, as well as the mru; the former is implemented as a singly-linked
list, but that's mostly historical).

It also allows us to have an item in a list and a hashmap (since if they
both needed to be at the start of the struct, that wouldn't work). We do
use that ability for delta_base_cache_entry.

> Would it benefit us to be able to place an
> element in multiple hashmaps because we do not have to have the
> embedded hashmap_entry always at the beginning if we did this
> change?

I'm not sure. I think it would allow us to more aggressively stick the
hashmap_entry inside existing structs. For instance, in the patch from
this thread, could we actually shove the hashmap_entry structs into
"struct ref", and save having to allocate the extra refname_hash struct?

I guess that pollutes "struct ref", though. Unless we generically say
"it can be a part of up to 3 hashes" and provide struct hashmap_entry
h1, struct hashmap_entry h2, etc. And then your new code does:

  struct hashmap existing_refs;
  struct hashmap remote_refs;

  /*
   * These need to be different compare functions to access the
   * h1 and h2 fields in "struct ref"!
   */
  hashmap_init(&existing_refs, ref_hash_cmp_h1);
  hashmap_init(&remote_refs, ref_hash_cmp_h2);

  ...

  hashmap_add(&existing_refs, &some_ref->h1);

But that seems pretty error-prone (not just confusing h1 and h2 here,
but how do we know that some other part of the code isn't using "h1" for
its own hash already?)

So again, maybe this is just a bad direction.

At least with an open-addressed scheme, the hash table itself contains
everything, and you can just store pointers to the existing refs.

-Peff
