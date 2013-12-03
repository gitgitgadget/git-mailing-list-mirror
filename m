From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 10/21] pack-bitmap: add support for bitmap indexes
Date: Tue, 3 Dec 2013 13:21:33 -0500
Message-ID: <20131203182133.GA21296@sigill.intra.peff.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
 <20131114124432.GJ10757@sigill.intra.peff.net>
 <87fvqlfpmw.fsf@linux-k42r.v.cablecom.net>
 <5295B6A8.70303@gmail.com>
 <20131128103838.GB14615@sigill.intra.peff.net>
 <529DED69.4080300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <tr@thomasrast.ch>, git@vger.kernel.org,
	Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 19:21:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnubO-0005zY-1F
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 19:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670Ab3LCSVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 13:21:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:49763 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751977Ab3LCSVg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 13:21:36 -0500
Received: (qmail 7422 invoked by uid 102); 3 Dec 2013 18:21:36 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Dec 2013 12:21:36 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Dec 2013 13:21:33 -0500
Content-Disposition: inline
In-Reply-To: <529DED69.4080300@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238707>

On Tue, Dec 03, 2013 at 03:40:41PM +0100, Karsten Blees wrote:

> IMO, trying to improve khash isn't worth the trouble.
> 
> With smaller-than-pointer types, khash _may_ actually save a few bytes
> compared to hash.[ch] or hashmap.[ch]. E.g. a set of 'int's would be a
> perfect use case for khash. However, you're using bitmaps for that,
> and khash's predefined macros for int sets and maps have been removed
> from the git version.

True, we are not using it for smaller-than-pointer sizes here. So it may
not be worth thinking about (I was considering more for the general
case). In most instances, though, we can shove the int bits into a
pointer with the right casting. So it probably isn't worth worrying
about (you may waste a few bytes, but probably not more than one word
per entry).

> Using khash with pointers and larger-than-pointer types is just a
> waste of memory and performance, though. Hash tables are sparsely
> filled by design, and using large types means lots of large empty
> buckets. E.g. kh_resize requires almost four times the size or your
> data, and copies everything at least three times.

I think the analysis is more complicated than that, and depends on what
you are storing. If you are storing something that is 1.5 times the size
of a pointer, it is more space efficient to just stick it in the hash
table than it is to have a separate pointer in the hash table (you pay
the load factor penalty only on the single pointer, but you've almost
doubled your total storage).

But again, that's a more general argument. We're not storing anything of
that size here, and in fact I think we are just storing pointers
everywhere.

> Additionally, there are the obvious problems with khash's macro design
> (hard to read, impossible to debug, and each named instance increases
> executable size by ~4k).

Yes, those are all downsides to macros. Type safety is one of the
upsides, though.

Besides macros, I think the major difference between the two
implementations is open-addressing versus chaining. Especially for sets,
we've had good experiences with open-addressing by keeping the load
factor low (e.g., the one in object.c). As you note, the resizing
operation pays some penalty, but in most of our workloads it's largely
irrelevant compared to lookup times.

Chaining typically adds an extra layer of pointer-following to the
lookup, and I'd be worried about that loss of locality. It's true that
when you are storing a pointer you are already hurting locality to
follow the pointer to the key, but I don't know whether that means an
_extra_ layer doesn't still hurt more (and I really mean I don't know --
I'd be interested to see measurements).

In your implementation, it looks like you break even there because you
store the hash directly in the entry, and do a single-word compare (so
you avoid having to follow a pointer to the key in the common case
during lookup). But that also means you're paying extra to store the
hash. That probably makes sense for things like strings, where it takes
some effort to calculate the hash. But not necessarily for sha1s, where
looking at the hash is the same thing as looking at the key bytes (so
you are storing extra bytes, and when you do have a hit on the stored
hash, which is just the first bytes of the sha1, you end up comparing
them again as part of the hashcmp. The tradeoff is that in the
non-matching cases, you avoid an extra level of indirection).

All of these are things I could see helping or hurting, depending on the
case. I'd really love to see more numbers. I tried timing your patch
below, but there was no interesting change. Mostly because the code path
you changed is not heavily exercised (the "ext_index" is for objects
that are not in the pack, and frequent packing keeps that number low).

I'd be really interested to see if you could make the hash in object.c
faster. That one is a prominent lookup bottle-neck (e.g., for "git
rev-list --objects --all"); if you can make that faster, I would be very
convinced that your implementation is fast (note that I am not implying
the converse; if you cannot make it faster, that does not necessarily
mean your implementation sucks, but perhaps only that the existing one
has lots of type-specific optimizations which add up).

Khash also has a lot of bloat (e.g., flags) that the one in object.c
does not have. If you do not care about deletion and are storing
something with a sentinel value (e.g., NULL for pointers), you can trim
quite a bit of fat.

> Below is a patch that converts pack-bitmap.c to hashmap. Its not even
> longer than the khash version, and the hashmap API forces you to think
> about no-brainer improvements such as specifying an expected size or
> skipping duplicates checks where they aren't needed. I could do the
> same for pack-bitmap-write.c if you like.

If it's not too much trouble, I'd be curious to measure the performance
impact on pack-bitmap-write.

> Removes two unnecessary duplicates checks:
>  - we don't expect a pack index file to contain duplicate sha1's

We don't expect them to, but it has happened (and caused bugs not too
long ago). What happens after your patch when there are duplicates?

> +static struct ewah_bitmap *lookup_stored_bitmap_sha1(const unsigned char *sha1)
> +{
> +	struct stored_bitmap key, *st;
> +	hashmap_entry_init(&key, __kh_oid_hash(sha1));
> +	st = hashmap_get(&bitmap_git.bitmaps, &key, sha1);
> +	if (st)
> +		return lookup_stored_bitmap(st);
> +	return NULL;
> +}

This interface looks odd to me. You create a fake stored_bitmap for the
hashmap_entry part of it, and then fill in the "hash" field by hashing
the sha1. And then pass the same sha1 in. I guess you are trying to
avoid the hash table knowing about the hash function at all, since it
just stores the hash for each entry already.

I guess that makes sense, but would not work for a system where you
wanted to get rid of the extra hash storage (but as I implied above, I
am not sure if it is helping or hurting for the sha1 case).

> -	hash_pos = kh_put_sha1_pos(eindex->positions, object->sha1, &hash_ret);
> -	if (hash_ret > 0) {
> -		if (eindex->count >= eindex->alloc) {
> -			eindex->alloc = (eindex->alloc + 16) * 3 / 2;
> -			eindex->objects = xrealloc(eindex->objects,
> -				eindex->alloc * sizeof(struct object *));
> -			eindex->hashes = xrealloc(eindex->hashes,
> -				eindex->alloc * sizeof(uint32_t));
> -		}
> -
> -		bitmap_pos = eindex->count;
> -		eindex->objects[eindex->count] = object;
> -		eindex->hashes[eindex->count] = pack_name_hash(name);
> -		kh_value(eindex->positions, hash_pos) = bitmap_pos;
> -		eindex->count++;
> -	} else {
> -		bitmap_pos = kh_value(eindex->positions, hash_pos);
> -	}
> -
> -	return bitmap_pos + bitmap_git.pack->num_objects;
> +	struct ext_entry *e = xmalloc(sizeof(struct ext_entry));
> +	hashmap_entry_init(e, __kh_oid_hash(object->sha1));
> +	e->object = object;
> +	e->name_hash = pack_name_hash(name);
> +	e->nr = bitmap_git.ext_index.size;
> +	hashmap_add(&bitmap_git.ext_index, e);
> +	return e->nr + bitmap_git.pack->num_objects;

One of the side effects of the current system is that the array
effectively works as a custom allocator, and we do not pay per-entry
malloc overhead. As I mentioned above, this is not that
heavily-exercised a code path, so it may not matter (and you can convert
it by explicitly using a custom allocator, at which point you could drop
the e->nr field entirely, I'd think).

> @@ -584,17 +581,15 @@ static struct bitmap *find_objects(struct rev_info *revs,
>  static void show_extended_objects(struct bitmap *objects,
>  				  show_reachable_fn show_reach)
>  {
> -	struct eindex *eindex = &bitmap_git.ext_index;
> -	uint32_t i;
> -
> -	for (i = 0; i < eindex->count; ++i) {
> -		struct object *obj;
> +	struct ext_entry *e;
> +	struct hashmap_iter iter;
>  
> -		if (!bitmap_get(objects, bitmap_git.pack->num_objects + i))
> +	for (e = hashmap_iter_first(&bitmap_git.ext_index, &iter); e;
> +	     e = hashmap_iter_next(&iter)) {
> +		if (!bitmap_get(objects, bitmap_git.pack->num_objects + e->nr))
>  			continue;
>  
> -		obj = eindex->objects[i];
> -		show_reach(obj->sha1, obj->type, 0, eindex->hashes[i], NULL, 0);
> +		show_reach(e->object->sha1, e->object->type, 0, e->name_hash, NULL, 0);

Before we were iterating in eindex order. Now we are iterating in
hashmap order. That effects our traversal order, and ultimately our
output for something like "rev-list". We'd want to sort on e->nr (or
again, a custom allocator would make this go away because we would
iterate over the array).

> -	for (i = 0; i < eindex->count; ++i) {
> -		if (eindex->objects[i]->type == type &&
> -			bitmap_get(objects, bitmap_git.pack->num_objects + i))
> +	for (e = hashmap_iter_first(&bitmap_git.ext_index, &iter); e;
> +	     e = hashmap_iter_next(&iter)) {
> +		if (e->object->type == type &&
> +			bitmap_get(objects, bitmap_git.pack->num_objects + e->nr))
>  			count++;

Ditto here, but I do not think the order matters in this instance.

-Peff
