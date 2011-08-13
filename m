From: "George Spelvin" <linux@horizon.com>
Subject: Re: [PATCH 07/11] object: try naive cuckoo hashing
Date: 13 Aug 2011 06:22:44 -0400
Message-ID: <20110813102244.9033.qmail@science.horizon.com>
Cc: git@vger.kernel.org, linux@horizon.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Aug 13 12:22:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsBMj-00042a-7R
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 12:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356Ab1HMKWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Aug 2011 06:22:47 -0400
Received: from science.horizon.com ([71.41.210.146]:11860 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751083Ab1HMKWq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2011 06:22:46 -0400
Received: (qmail 9034 invoked by uid 1000); 13 Aug 2011 06:22:44 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179273>

I had vague memories of hearing about cuckoo hashing in the pasr, but
your posting inspired me to read up on it.

Your implementation doesn't quite match the standard one.  Did you get
it from somewhere, or is it your own creation?

In the classical design, the H1 and H2 hashes use two separate hash
tables (T1 and T2), so there is never any question about where insertion
should happen.

It's
- New items are inserted into T1 (at H1).
- If the slot is full, the new item is still stored there, but
  it is bumped to T2.
- If that T2 slot is full, it is still overwritten, but what was there
  is bumped back to T1.

etc., until a NULL pointer is found or 

You use a single hash table.  Is that variant analyzed somewhere, or is
it something you've found is better?

It seems that what your insert_obj_hash does is "if the H1 slot is open,
store there.  Otherwise, store in the H2 slot and bump the item already
there (if any)."  What this means is that as soon as you hit an object
already in its H2 slot, the insert will fall into an infinite loop and
eventually fail.

The original scheme could bump items out of H2 slots back to H1 slots.

Another advantage of the 2-table system is that every object hash two
possible homes, even if H1 == H2.  With one table, the hash functions
are twice as big, so the chance of that happening is cut in half, but
such objects have only one possible home and really gum up the works.

(You could define H2 = H1 + obj->sha1[1] % (obj_hash_size-1) to
solve this, using the standard shift-and-add optimizations for
computing modulo a power of two less one, but I'm still not sure
if it's worth it.)


Another technique for using a hash table at a high load factor is
multiple-entry buckets.  This is discussed in "A cool and practical
alternative to traditional hash tables"
http://www.ru.is/faculty/ulfar/CuckooHash.pdf

Because a bucket is a single cache line, accessing it adds no more
overhead than a single-entry bicket, *as long as you can validate the
lookup without following a pointer*.

The best way to do that is to store some additional validation data
(fortunately, SHA-1 provides lots; even if you're using all 5 words,
their sum is available) in the hash table itself.  This does make the
table larger, but speeds up lookups.

One way to speed up pointer-bumping in the 2-hash case would be to
store H1+H2 (the full 32-bit sum) as a validation value.  In addition to
allowing you to avoid following the pointer on misses the vast majority
of the time, this also lets you bump pointers from H1 to H2 without
actually following them.  You know one of the hashes (because you found
the pointer in that table slot), and a subtraction produces the other.

This produces insert code like the following:

struct obj_hash_entry {
	struct object *obj;
	uint32_t hash_sum;
} *obj_hash;

static struct object *insert_obj_hash(struct object *obj)
{
	uint32_t hash_sum = hash_val(obj->sha1);
	unsigned ix = hash_sum & (obj_hash_size - 1);
	unsigned n = 0, lim = 1;
	unsigned loop_check;	/* Ignore GCC warning */

	hash_sum += hash_val(obj->sha1 + 4)

	do {
		struct object *tmp_obj = obj_hash[ix].obj;
		uint32_t tmp_hash_sum = obj_hash[ix].hash_sum;

		obj_hash[ix].obj = obj;
		obj_hash[ix].hash_sum = hash_sum;

		/* Brent's cycle-finding algorithm */
		if (++n == lim) {	/* Less registers: if (n & (n-1)) == 0 */
			loop_check = ix;
			lim *= 2;
		}
		
		obj = tmp_obj;
		hash_sum = tmp_hash_sum;
		ix = (tmp_hash_sum - ix) & (obj_hash_size - 1);

	} while (obj && ix != loop_check);

	return obj;
}

I presume the optimization to lookup_object is obvious.
