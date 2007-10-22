From: Jeff King <peff@peff.net>
Subject: Re: [PATCH, take 1] Linear-time/space rename logic (exact renames
	only)
Date: Mon, 22 Oct 2007 02:47:23 -0400
Message-ID: <20071022064723.GA2737@coredump.intra.peff.net>
References: <alpine.LFD.0.999.0710211603200.10525@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Kastrup <dak@gnu.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 08:47:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijr4c-0003kA-Ru
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 08:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbXJVGr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 02:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbXJVGr1
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 02:47:27 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3180 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709AbXJVGr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 02:47:26 -0400
Received: (qmail 16250 invoked by uid 111); 22 Oct 2007 06:47:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 22 Oct 2007 02:47:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Oct 2007 02:47:23 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710211603200.10525@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61959>

On Sun, Oct 21, 2007 at 04:59:03PM -0700, Linus Torvalds wrote:

> What it does is to rather than iterate over all sources and destinations 
> and checking if they are identical (which is O(src*dst)), it hashes each 
> of the sources and destinations into a hash table, using the SHA1 hash of 
> the contents as the hash. That's O(n+m). It then walks the hash table 
> (which is also O(m+n) in size), and only pairs up files for comparison 
> that hashed to the same spot.
> 
> Doing this for more than just the exact same contents would be basically 
> the same thing, except it starts hashing up fingerprints of the contents 
> and linking up file pairs that get linked up by those fingerprints. More 
> involved, but not impossible.

Hrm. For the inexact case, it seems like you should be able to do
something like this:

 1. put the content fingerprint hashes in a hash table
 2. create a single src * dst table of scores
 3. walk the hash table; for each bucket in which there are collisions,
    find every pair in that bucket, and add to the similarity score in
    the big score table
 4. for each src in the similarity table, find the maximum dest

Step 1 is clearly O(n+m). Step 2 allocates O(n*m) memory, but we only
need a single integer in each slot. The outer walk in step 3 is
O(fingerprints), which is, O(content_size * (n+m)). The inner loop can
actually be worst case O(n*m), but is more likely to be a handful of
pairs (assuming that for any fingerprint chunk, it is only going to
exist in a few files; you would get worst case if you were comparing a
bunch of files with identical contents). And step 4 is actually going to
end up being O(n*m), since you have to find the best match for each.

So there is actually still O(n*m) behavior, but I wonder if we are
tightening the O(n*m) loop enough that we will see improvement.

Hrm. I wonder if we could keep a "best" pointer for each src file, and
when we update the score for a given src/dest pair, check for a new
best. That would add more to step 3, but make step 4 O(n).

And of course the n*m memory is going to bottleneck. I think for 1000 *
1000, it should be fine, but if you want to try 100,000 * 100,000, you
are going to need tens of gigabytes. And it's going to be very sparse.
So perhaps a hash table with keys of src+dst mapped to scores. And then
we could sort the whole table afterwards, and just run through it
linearly, which helps step 4.

>  - it looks ok, and I've tested it some, but this needs more people 
>    looking at it.

Overall it looks like a sane approach. My comments are below.

>  - in fact, the big optimization isn't the actual hash table, but the 
>    independent and much simpler "diff_filespec->used" optimization for a 
>    deleted filename that was used for a rename/copy.

Do you have separate timings? The "diff_filespec->used" optimization
appears to be cutting out an O(n*m) strcmp. If it is most of the
optimization, I wonder if the complexity of the hash change is worth it
(although I find the new code easier to read, so maybe it is worth it on
those grounds alone).

> +struct file_similarity {
> +	int src_dst, index;

It took me a while to figure out all of the meanings of src_dst; maybe a
comment is in order?

> +static int find_identical_files(struct file_similarity *src,
> +				struct file_similarity *dst)

Your function naming is a bit confusing. You have find_identical_files,
find_same_files, and find_exact_renames, all of which do the same thing,
but for different levels of input. Perhaps the names should reflect how
they are different?

> +static int find_identical_files(struct file_similarity *src,
> +				struct file_similarity *dst)
> +{
> +	int renames = 0;
> +	do {
> +		struct diff_filespec *one = src->filespec;
> +		struct file_similarity *p, *best;
> +		int i = 100;
> +
> +		best = NULL;
> +		for (p = dst; p; p = p->next) {
> +			struct diff_filespec *two = p->filespec;
> +
> +			/* Already picked as a destination? */
> +			if (!p->src_dst)
> +				continue;
> +			/* False hash collission? */
> +			if (hashcmp(one->sha1, two->sha1))
> +				continue;
> +			best = p;
> +			if (basename_same(one, two))
> +				break;
> +
> +			/* Too many identical alternatives? Pick one */
> +			if (!--i)
> +				break;
> +		}
> +		if (best) {
> +			best->src_dst = 0;
> +			record_rename_pair(best->index, src->index, MAX_SCORE);
> +			renames++;
> +		}
> +	} while ((src = src->next) != NULL);
> +	return renames;
> +}

The "too many identical alternatives" sanity check is interesting. It
can produce suboptimal results if, e.g., the 101st entry has the same
basename. I suppose it is necessary to prevent a worst case "oops, all
of these files are identical" O(n*m) behavior. But generally I would
favor "always correct, pathological cases slow" to "always fast,
pathological cases incorrect". But maybe the basename heuristic isn't
worth considering "correct" in this case (and honestly, I doubt anyone
will hit the 100 limit anyway).

> +/*
> + * Note: the rest of the rename logic depends on this
> + * phase also populating all the filespecs for any
> + * entry that isn't matched up with an exact rename.
> + */
> +static int free_file_table(void *ptr)
> +{
> +	struct file_similarity *p = ptr;
> +	do {
> +		struct file_similarity *entry = p;
> +		p = p->next;
> +
> +		/* Stupid special case, see note above! */
> +		diff_populate_filespec(entry->filespec, 0);
> +		free(entry);
> +	} while (p);
> +	return 0;
> +}

diff_populate_filespec knows whether or not it needs to do any work. I
wonder if those parts of the rename process that need it should just
call it unconditionally. It seems like a fragile dependency. Besides
which...

> +static unsigned int hash_filespec(struct diff_filespec *filespec)
> +{
> +	unsigned int hash;
> +	if (!filespec->sha1_valid) {
> +		if (diff_populate_filespec(filespec, 0))
> +			return 0;
> +		hash_sha1_file(filespec->data, filespec->size, "blob", filespec->sha1);
> +	}
> +	memcpy(&hash, filespec->sha1, sizeof(hash));
> +	return hash;
> +}

...if everything has been through this hash function, why do we need to
populate again upon freeing?

> +static struct hash_table_entry *lookup_hash_entry(unsigned int hash, struct hash_table *table)
> +{
> +	unsigned int size = table->size, nr = hash % size;
> +	struct hash_table_entry *array = table->array;
> +
> +	while (array[nr].ptr) {
> +		if (array[nr].hash == hash)
> +			break;
> +		nr++;
> +		if (nr >= size)
> +			nr = 0;
> +	}
> +	return array + nr;
> +}

Rather than having buckets where collisions extend in a list within the
bucket, it looks like you are just overflowing into the next bucket.
It seems like you could end up with pretty bad "runs" of full buckets.
E.g., bucket 1 has a collision, so it bleeds into bucket 2.  Now when we
place something in bucket 2, it has to skip past bucket 1's overflow.
And a collision in bucket 2 means we have to skip the overflow for
buckets 1 _and_ 2. And so on, until we can resync by finding enough free
buckets to accept all of our collisions. So it depends on keeping a lot
of holes in the hash structure, which I see that you do, but I wonder
what the optimal value is.

I assume you chose this method to reduce memory fragmentation, which
makes sense. And maybe there is a simple answer that "50-75% free gives
good results over evenly distributed hashes." Though perhaps we should
also consider clustered hashes (especially if we want to put the
fingerprint hashes directly in here).

> +/*
> + * Insert a new hash entry pointer into the table.
> + *
> + * If that hash entry already existed, return the pointer to
> + * the existing entry (and the caller can create a list of the
> + * pointers or do anything else). If it didn't exist, return
> + * NULL (and the caller knows the pointer has been inserted).
> + */
> +static void **insert_hash_entry(unsigned int hash, void *ptr, struct hash_table *table)

This calling convention seems a bit clunky. Since all callers have to
check for hash collision anyway, why not just unconditionally return the
pointer to the data ptr (which will itself be NULL if this is the first
entry)? Then you can drop the conditional, and:

  pos = insert_hash(hash, entry, table);
  if (pos) {
    entry->next = *pos;
    *pos = entry;
  }

can simply become:

  pos = insert_hash(hash, table);
  entry->next = *pos;
  *pos = entry;

> +void **insert_hash(unsigned int hash, void *ptr, struct hash_table *table)
> +{
> +	unsigned int nr = table->nr;
> +	if (nr >= table->size/2)
> +		grow_hash_table(table);
> +	return insert_hash_entry(hash, ptr, table);
> +}

Style nitpick: the local "nr" is rather pointless.

-Peff
