From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v3 10/21] pack-bitmap: add support for bitmap indexes
Date: Sat, 07 Dec 2013 21:52:58 +0100
Message-ID: <52A38AAA.7040308@gmail.com>
References: <20131114124157.GA23784@sigill.intra.peff.net> <20131114124432.GJ10757@sigill.intra.peff.net> <87fvqlfpmw.fsf@linux-k42r.v.cablecom.net> <5295B6A8.70303@gmail.com> <20131128103838.GB14615@sigill.intra.peff.net> <529DED69.4080300@gmail.com> <20131203182133.GA21296@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, git@vger.kernel.org,
	=?UTF-8?B?VmljZW4=?= =?UTF-8?B?dCBNYXJ0w60=?= <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 07 21:53:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpOs4-0000IZ-Pt
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 21:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759080Ab3LGUw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 15:52:58 -0500
Received: from mail-ea0-f179.google.com ([209.85.215.179]:65353 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637Ab3LGUw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 15:52:56 -0500
Received: by mail-ea0-f179.google.com with SMTP id r15so880024ead.10
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 12:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=AybZrWamcWbga4VgmVLg+5JUMbMSaCtceBUe9CWBXEA=;
        b=u4YER3yD5tvPxY9wuN40732VIqqoKV3Ih8hlxlALxbdTzRARhTdBAWDXP6jSp/46I9
         ZC2cyw8djgX24nESx37J3t3smE9ClW1Pr6jrs2OL6JFEWtZU3XfTbVwmiH463mjIDJ6G
         UlIkyNpf4BoR6VrUMZ1ds152LGOr0i0YcgtBKQqNOOpWmr9o9WH+0DX3MrpCSAgdWQVY
         B3e/52N/GvPJeGFtKt7/NP5HoKZ7IXtxd+9Y3WiWT6zUKWB8FjlvHdSAJyZ887v+fxCp
         37YRnWFIm8FgZcGwI788E+Rte77dgZyWD6LbW1wnwGsrOks0OlXwtpC/cvtNje8J20FA
         feOQ==
X-Received: by 10.15.111.201 with SMTP id cj49mr7209508eeb.56.1386449575183;
        Sat, 07 Dec 2013 12:52:55 -0800 (PST)
Received: from [10.1.100.54] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id n1sm10039254eep.20.2013.12.07.12.52.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Dec 2013 12:52:54 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <20131203182133.GA21296@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239019>

Am 03.12.2013 19:21, schrieb Jeff King:
> On Tue, Dec 03, 2013 at 03:40:41PM +0100, Karsten Blees wrote:
> 
>> IMO, trying to improve khash isn't worth the trouble.
>>
>> With smaller-than-pointer types, khash _may_ actually save a few bytes
>> compared to hash.[ch] or hashmap.[ch]. E.g. a set of 'int's would be a
>> perfect use case for khash. However, you're using bitmaps for that,
>> and khash's predefined macros for int sets and maps have been removed
>> from the git version.
> 
> True, we are not using it for smaller-than-pointer sizes here. So it may
> not be worth thinking about (I was considering more for the general
> case). In most instances, though, we can shove the int bits into a
> pointer with the right casting. So it probably isn't worth worrying
> about (you may waste a few bytes, but probably not more than one word
> per entry).
> 
>> Using khash with pointers and larger-than-pointer types is just a
>> waste of memory and performance, though. Hash tables are sparsely
>> filled by design, and using large types means lots of large empty
>> buckets. E.g. kh_resize requires almost four times the size or your
>> data, and copies everything at least three times.
> 
> I think the analysis is more complicated than that, and depends on what
> you are storing. If you are storing something that is 1.5 times the size
> of a pointer, it is more space efficient to just stick it in the hash
> table than it is to have a separate pointer in the hash table (you pay
> the load factor penalty only on the single pointer, but you've almost
> doubled your total storage).
> 
> But again, that's a more general argument. We're not storing anything of
> that size here, and in fact I think we are just storing pointers
> everywhere.
> 

Yes. With pointers, its a very close call regarding space. Let's take bitmap_index.bitmaps / struct stored_bitmap as an example. I'm assuming 8 byte pointers and an average load factor of 0.5.

struct stored_bitmap is already kind of an entry structure (key + value) allocated on the heap. This is a very common szenario, all hash.[ch] -> hashmap.[ch] conversions were that way.

The average khash memory requirement per entry is (on top of the data on the heap):

  (key + value + flags) / load-factor = (8 + 8 + .25) / .5 = 32.5 bytes

For the hashmap conversion, I simply injected struct hashmap_entry into the existing structure, adding 12 bytes per entry. So the total hashmap memory per entry is:

  hashmap_entry + (entry-pointer / load-factor) = 12 + (8 / .5) = 28 bytes

>> Additionally, there are the obvious problems with khash's macro design
>> (hard to read, impossible to debug, and each named instance increases
>> executable size by ~4k).
> 
> Yes, those are all downsides to macros. Type safety is one of the
> upsides, though.
>

Well, khash_sha1 maps to void *, so I guess its not that important :-) But if you care about type safety, a common core implementation with a few small wrapper macros would be hugely preferable, don't you think?
 
> Besides macros, I think the major difference between the two
> implementations is open-addressing versus chaining. Especially for sets,
> we've had good experiences with open-addressing by keeping the load
> factor low (e.g., the one in object.c). As you note, the resizing
> operation pays some penalty, but in most of our workloads it's largely
> irrelevant compared to lookup times.
>

Resizing is reasonably fast and straightforward for both open addressing and chaining. My 'copy three times' remark above was specific to the rehash-in-place stunt in kh_resize (if you haven't wondered what these 64 multi-statement-lines do, you probably don't wanna know... ;-)

But its still best if you know the target size and can prevent resizing altogether.

> Chaining typically adds an extra layer of pointer-following to the
> lookup, and I'd be worried about that loss of locality. It's true that
> when you are storing a pointer you are already hurting locality to
> follow the pointer to the key, but I don't know whether that means an
> _extra_ layer doesn't still hurt more (and I really mean I don't know --
> I'd be interested to see measurements).
>

The locality advantage of open addressing _only_ applies when storing the data directly in the table, but AFAIK we're not doing that anywhere in git. Compared to open addressing with pointers, chaining in fact has _better_ locality.

Iterating a linked list (i.e. chaining) accesses exactly one (1.0) memory location per element.

Iterating an array of pointers (i.e. open addressing with linear probing) accesses ~1.125 memory locations per element (assuming 8 byte pointers and 64 byte cache lines, array[8] will be in a different cache line than array[0], thus the +.125).

Of course, any implementation can add more pointer-following to that minimum. E.g. khash uses separate flags and keys arrays and triangular numbers as probe sequence, so its up to 3 memory locations per element.

Hashmap, on the other hand, allows you to inject it's per-entry data into the user data structure to prevent locality penalties (well, the user data structure could add more pointer-following, but that's not hashmap's fault).

> In your implementation, it looks like you break even there because you
> store the hash directly in the entry, and do a single-word compare (so
> you avoid having to follow a pointer to the key in the common case
> during lookup).

More importantly, it saves calling a function pointer with three parameters unless its a _very_ probable match.

> But that also means you're paying extra to store the
> hash. That probably makes sense for things like strings, where it takes
> some effort to calculate the hash. But not necessarily for sha1s, where
> looking at the hash is the same thing as looking at the key bytes (so
> you are storing extra bytes,

True. Its 4 bytes overhead for sha1s and probably ints (but even for ints you may want to wiggle the bits for better distribution). However, its an utterly necessary optimization for e.g. strings with common prefixes. Think of a Java project where all paths start with com/mycompany/myou/productname/component/... i.e. strcmp has to compare ~40 bytes before finding a difference.

> and when you do have a hit on the stored
> hash, which is just the first bytes of the sha1, you end up comparing
> them again as part of the hashcmp.

Not necessarily - I could skip the part that I've used as hash code...

> The tradeoff is that in the
> non-matching cases, you avoid an extra level of indirection).
> 
> All of these are things I could see helping or hurting, depending on the
> case. I'd really love to see more numbers. I tried timing your patch
> below, but there was no interesting change. Mostly because the code path
> you changed is not heavily exercised (the "ext_index" is for objects
> that are not in the pack, and frequent packing keeps that number low).
> 
> I'd be really interested to see if you could make the hash in object.c
> faster. That one is a prominent lookup bottle-neck (e.g., for "git
> rev-list --objects --all"); if you can make that faster, I would be very
> convinced that your implementation is fast (note that I am not implying
> the converse; if you cannot make it faster, that does not necessarily
> mean your implementation sucks, but perhaps only that the existing one
> has lots of type-specific optimizations which add up).
> 

Ok, let's see...

Hash tables only compare for equality, not for sorting, so the first thing that comes to mind is to compare 4 bytes at a time.

The hashmap version cuts quite a bit of code, but uses slightly more memory (~6 bytes per entry). Still todo: get_indexed_object now only returns the list heads, so callers need to follow the chain...

Then I wrote a custom chaining version (i.e. no cached hash code, inlined hashcmp() etc.). The increased load-factor of 0.8 should fully compensate the additional next pointer in struct object. Ditto for get_indexed_object.

Finally, just for fun, the khash version...

Your move-to-front optimization seems highly specialized to lookup_object access patterns, and also breaks the assumption that concurrent lookup is thread safe. So I didn't bother to pimp hashmap and khash internals, and instead did the other measurements with and without move-to-front enabled. The hashmap move-to-front is via the existing API (remove + add), i.e. its true LRU instead of swap (same for custom-chaining).

Numbers are in seconds, best of 10 runs of 'git rev-list --all --objects >/dev/null' on the linux kernel repo.

 fast  | move  ||  next  |  hash  | custom | khash  |
 hash  |  to   ||        |  map   |        |        |
 cmp   | front || (open) |(chain) |(chain) | (open) |
=======+=======++========+========+========+========+
  no   |  no   || 45.593 | 42.924 | 41.033 | 62.974 |
  no   |  yes  || 41.017 | 43.095 | 40.478 |        |
  yes  |  no   || 43.172 | 40.965 | 39.564 |        |
  yes  |  yes  || 39.332 | 41.008 | 38.869 |        |

The fastest versions of each variant can be found here:

https://github.com/kblees/git/commits/kb/optimize-lookup-object-next
https://github.com/kblees/git/commits/kb/optimize-lookup-object-hashmap
https://github.com/kblees/git/commits/kb/optimize-lookup-object-custom-chaining
https://github.com/kblees/git/commits/kb/optimize-lookup-object-khash


> Khash also has a lot of bloat (e.g., flags) that the one in object.c
> does not have. If you do not care about deletion and are storing
> something with a sentinel value (e.g., NULL for pointers), you can trim
> quite a bit of fat.
> 

Actually, the lack of deletion in hash.[ch] was the reason I started this...one advantage of chaining is that delete can be implemented efficiently (O(1)) without affecting lookup / insert performance.

>> Below is a patch that converts pack-bitmap.c to hashmap. Its not even
>> longer than the khash version, and the hashmap API forces you to think
>> about no-brainer improvements such as specifying an expected size or
>> skipping duplicates checks where they aren't needed. I could do the
>> same for pack-bitmap-write.c if you like.
> 
> If it's not too much trouble, I'd be curious to measure the performance
> impact on pack-bitmap-write.
> 

I'll see what I can do

>> Removes two unnecessary duplicates checks:
>>  - we don't expect a pack index file to contain duplicate sha1's
> 
> We don't expect them to, but it has happened (and caused bugs not too
> long ago). What happens after your patch when there are duplicates?
> 

Both entries are added, and hashmap_get returns one of them at random. Re-adding duplicates checks is simple, though:

- hashmap_add(...);
+ if (hashmap_put(...))
+   die("foo has duplicate o's");

>> +static struct ewah_bitmap *lookup_stored_bitmap_sha1(const unsigned char *sha1)
>> +{
>> +	struct stored_bitmap key, *st;
>> +	hashmap_entry_init(&key, __kh_oid_hash(sha1));
>> +	st = hashmap_get(&bitmap_git.bitmaps, &key, sha1);
>> +	if (st)
>> +		return lookup_stored_bitmap(st);
>> +	return NULL;
>> +}
> 
> This interface looks odd to me. You create a fake stored_bitmap for the
> hashmap_entry part of it, and then fill in the "hash" field by hashing
> the sha1. And then pass the same sha1 in. I guess you are trying to
> avoid the hash table knowing about the hash function at all, since it
> just stores the hash for each entry already.
> 

The general case would be:

 struct stored_bitmap key;
 /* fill in hash code */
 hashmap_entry_init(&key, __kh_oid_hash(sha1));
 /* fill in key data */
 hashcpy(key.sha1, sha1);
 key.another_key_field = foobar;
 ...
 return hashmap_get(&bitmap_git.bitmaps, &key, NULL);

In this case, the sha1 is the only key data, and its larger that a word, so passing it as keydata parameter and checking for this in the cmp-function is slightly more efficient.

> I guess that makes sense, but would not work for a system where you
> wanted to get rid of the extra hash storage (but as I implied above, I
> am not sure if it is helping or hurting for the sha1 case).
> 
>> -	hash_pos = kh_put_sha1_pos(eindex->positions, object->sha1, &hash_ret);
>> -	if (hash_ret > 0) {
>> -		if (eindex->count >= eindex->alloc) {
>> -			eindex->alloc = (eindex->alloc + 16) * 3 / 2;
>> -			eindex->objects = xrealloc(eindex->objects,
>> -				eindex->alloc * sizeof(struct object *));
>> -			eindex->hashes = xrealloc(eindex->hashes,
>> -				eindex->alloc * sizeof(uint32_t));
>> -		}
>> -
>> -		bitmap_pos = eindex->count;
>> -		eindex->objects[eindex->count] = object;
>> -		eindex->hashes[eindex->count] = pack_name_hash(name);
>> -		kh_value(eindex->positions, hash_pos) = bitmap_pos;
>> -		eindex->count++;
>> -	} else {
>> -		bitmap_pos = kh_value(eindex->positions, hash_pos);
>> -	}
>> -
>> -	return bitmap_pos + bitmap_git.pack->num_objects;
>> +	struct ext_entry *e = xmalloc(sizeof(struct ext_entry));
>> +	hashmap_entry_init(e, __kh_oid_hash(object->sha1));
>> +	e->object = object;
>> +	e->name_hash = pack_name_hash(name);
>> +	e->nr = bitmap_git.ext_index.size;
>> +	hashmap_add(&bitmap_git.ext_index, e);
>> +	return e->nr + bitmap_git.pack->num_objects;
> 
> One of the side effects of the current system is that the array
> effectively works as a custom allocator, and we do not pay per-entry
> malloc overhead. As I mentioned above, this is not that
> heavily-exercised a code path, so it may not matter (and you can convert
> it by explicitly using a custom allocator, at which point you could drop
> the e->nr field entirely, I'd think).
> 

Realloc doesn't produce stable pointers, so we'd have to use a custom slab-allocator such as in alloc.c. However, I tend to think of malloc as a separate problem. There are quite efficient heap implementations with near-zero memory overhead even for small objects out there. I wouldn't be surprised if some day allocating many small objects will be faster and more space-efficient than re-allocating big blocks. Then you'd have all your code base littered with custom allocators that actually slow down the application...

>> @@ -584,17 +581,15 @@ static struct bitmap *find_objects(struct rev_info *revs,
>>  static void show_extended_objects(struct bitmap *objects,
>>  				  show_reachable_fn show_reach)
>>  {
>> -	struct eindex *eindex = &bitmap_git.ext_index;
>> -	uint32_t i;
>> -
>> -	for (i = 0; i < eindex->count; ++i) {
>> -		struct object *obj;
>> +	struct ext_entry *e;
>> +	struct hashmap_iter iter;
>>  
>> -		if (!bitmap_get(objects, bitmap_git.pack->num_objects + i))
>> +	for (e = hashmap_iter_first(&bitmap_git.ext_index, &iter); e;
>> +	     e = hashmap_iter_next(&iter)) {
>> +		if (!bitmap_get(objects, bitmap_git.pack->num_objects + e->nr))
>>  			continue;
>>  
>> -		obj = eindex->objects[i];
>> -		show_reach(obj->sha1, obj->type, 0, eindex->hashes[i], NULL, 0);
>> +		show_reach(e->object->sha1, e->object->type, 0, e->name_hash, NULL, 0);
> 
> Before we were iterating in eindex order. Now we are iterating in
> hashmap order. That effects our traversal order, and ultimately our
> output for something like "rev-list". We'd want to sort on e->nr (or
> again, a custom allocator would make this go away because we would
> iterate over the array).
> 

I didn't think it would matter, as the caller emits the objects from the bitmapped pack ordered by type and pack-index...well, I'll try to think of something (probably a linked list between entries?)

>> -	for (i = 0; i < eindex->count; ++i) {
>> -		if (eindex->objects[i]->type == type &&
>> -			bitmap_get(objects, bitmap_git.pack->num_objects + i))
>> +	for (e = hashmap_iter_first(&bitmap_git.ext_index, &iter); e;
>> +	     e = hashmap_iter_next(&iter)) {
>> +		if (e->object->type == type &&
>> +			bitmap_get(objects, bitmap_git.pack->num_objects + e->nr))
>>  			count++;
> 
> Ditto here, but I do not think the order matters in this instance.
> 
> -Peff
> 
