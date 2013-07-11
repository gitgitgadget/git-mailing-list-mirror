From: Jeff King <peff@peff.net>
Subject: [PATCHv3 10/10] pack-revindex: radix-sort the revindex
Date: Thu, 11 Jul 2013 08:16:00 -0400
Message-ID: <20130711121600.GA18710@sigill.intra.peff.net>
References: <20130710113447.GA20113@sigill.intra.peff.net>
 <20130710115557.GJ21963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 11 14:16:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxFn7-0002qy-EG
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 14:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755062Ab3GKMQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 08:16:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:57547 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754518Ab3GKMQD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 08:16:03 -0400
Received: (qmail 29455 invoked by uid 102); 11 Jul 2013 12:17:19 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Jul 2013 07:17:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Jul 2013 08:16:00 -0400
Content-Disposition: inline
In-Reply-To: <20130710115557.GJ21963@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230096>

  Here's an update of the radix-sort patch. It fixes the "unsigned" issue
  Brandon pointed out, along with a few other comment/naming/style fixes.
  I also updated the commit message with more explanation of the
  timings.
  
  The interdiff is:
  
  diff --git a/pack-revindex.c b/pack-revindex.c
  index 9365bc2..b4d2b35 100644
  --- a/pack-revindex.c
  +++ b/pack-revindex.c
  @@ -61,6 +61,10 @@ static void init_pack_revindex(void)
   
   /*
    * This is a least-significant-digit radix sort.
  + *
  + * It sorts each of the "n" items in "entries" by its offset field. The "max"
  + * parameter must be at least as large as the largest offset in the array,
  + * and lets us quit the sort early.
    */
   static void sort_revindex(struct revindex_entry *entries, unsigned n, off_t max)
   {
  @@ -78,18 +82,25 @@ static void sort_revindex(struct revindex_entry *entries, unsigned n, off_t max)
   #define BUCKET_FOR(a, i, bits) (((a)[(i)].offset >> (bits)) & (BUCKETS-1))
   
   	/*
  -	 * We need O(n) temporary storage, so we sort back and forth between
  -	 * the real array and our tmp storage. To keep them straight, we always
  -	 * sort from "a" into buckets in "b".
  +	 * We need O(n) temporary storage. Rather than do an extra copy of the
  +	 * partial results into "entries", we sort back and forth between the
  +	 * real array and temporary storage. In each iteration of the loop, we
  +	 * keep track of them with alias pointers, always sorting from "from"
  +	 * to "to".
   	 */
  -	struct revindex_entry *tmp = xcalloc(n, sizeof(*tmp));
  -	struct revindex_entry *a = entries, *b = tmp;
  -	int bits = 0;
  +	struct revindex_entry *tmp = xmalloc(n * sizeof(*tmp));
  +	struct revindex_entry *from = entries, *to = tmp;
  +	int bits;
   	unsigned *pos = xmalloc(BUCKETS * sizeof(*pos));
   
  -	while (max >> bits) {
  +	/*
  +	 * If (max >> bits) is zero, then we know that the radix digit we are
  +	 * on (and any higher) will be zero for all entries, and our loop will
  +	 * be a no-op, as everybody lands in the same zero-th bucket.
  +	 */
  +	for (bits = 0; max >> bits; bits += DIGIT_SIZE) {
   		struct revindex_entry *swap;
  -		int i;
  +		unsigned i;
   
   		memset(pos, 0, BUCKETS * sizeof(*pos));
   
  @@ -102,7 +113,7 @@ static void sort_revindex(struct revindex_entry *entries, unsigned n, off_t max)
   		 * previous bucket to get the true index.
   		 */
   		for (i = 0; i < n; i++)
  -			pos[BUCKET_FOR(a, i, bits)]++;
  +			pos[BUCKET_FOR(from, i, bits)]++;
   		for (i = 1; i < BUCKETS; i++)
   			pos[i] += pos[i-1];
   
  @@ -112,32 +123,37 @@ static void sort_revindex(struct revindex_entry *entries, unsigned n, off_t max)
   		 * to avoid using an extra index to count up. And since we are
   		 * going backwards there, we must also go backwards through the
   		 * array itself, to keep the sort stable.
  +		 *
  +		 * Note that we use an unsigned iterator to make sure we can
  +		 * handle 2^32-1 objects, even on a 32-bit system. But this
  +		 * means we cannot use the more obvious "i >= 0" loop condition
  +		 * for counting backwards, and must instead check for
  +		 * wrap-around with UINT_MAX.
   		 */
  -		for (i = n - 1; i >= 0; i--)
  -			b[--pos[BUCKET_FOR(a, i, bits)]] = a[i];
  +		for (i = n - 1; i != UINT_MAX; i--)
  +			to[--pos[BUCKET_FOR(from, i, bits)]] = from[i];
   
   		/*
  -		 * Now "b" contains the most sorted list, so we swap "a" and
  -		 * "b" for the next iteration.
  +		 * Now "to" contains the most sorted list, so we swap "from" and
  +		 * "to" for the next iteration.
   		 */
  -		swap = a;
  -		a = b;
  -		b = swap;
  -
  -		/* And bump our bits for the next round. */
  -		bits += DIGIT_SIZE;
  +		swap = from;
  +		from = to;
  +		to = swap;
   	}
   
   	/*
   	 * If we ended with our data in the original array, great. If not,
   	 * we have to move it back from the temporary storage.
   	 */
  -	if (a != entries)
  +	if (from != entries)
   		memcpy(entries, tmp, n * sizeof(*entries));
   	free(tmp);
   	free(pos);
   
   #undef BUCKET_FOR
  +#undef BUCKETS
  +#undef DIGIT_SIZE
   }
   
   /*

-- >8 --
Subject: [PATCH] pack-revindex: radix-sort the revindex

The pack revindex stores the offsets of the objects in the
pack in sorted order, allowing us to easily find the on-disk
size of each object. To compute it, we populate an array
with the offsets from the sha1-sorted idx file, and then use
qsort to order it by offsets.

That does O(n log n) offset comparisons, and profiling shows
that we spend most of our time in cmp_offset. However, since
we are sorting on a simple off_t, we can use numeric sorts
that perform better. A radix sort can run in O(k*n), where k
is the number of "digits" in our number. For a 64-bit off_t,
using 16-bit "digits" gives us k=4.

On the linux.git repo, with about 3M objects to sort, this
yields a 400% speedup. Here are the best-of-five numbers for
running

  echo HEAD | git cat-file --batch-check="%(objectsize:disk)

on a fully packed repository, which is dominated by time
spent building the pack revindex:

          before     after
  real    0m0.834s   0m0.204s
  user    0m0.788s   0m0.164s
  sys     0m0.040s   0m0.036s

This matches our algorithmic expectations. log(3M) is ~21.5,
so a traditional sort is ~21.5n. Our radix sort runs in k*n,
where k is the number of radix digits. In the worst case,
this is k=4 for a 64-bit off_t, but we can quit early when
the largest value to be sorted is smaller. For any
repository under 4G, k=2. Our algorithm makes two passes
over the list per radix digit, so we end up with 4n. That
should yield ~5.3x speedup. We see 4x here; the difference
is probably due to the extra bucket book-keeping the radix
sort has to do.

On a smaller repo, the difference is less impressive, as
log(n) is smaller. For git.git, with 173K objects (but still
k=2), we see a 2.7x improvement:

          before     after
  real    0m0.046s   0m0.017s
  user    0m0.036s   0m0.012s
  sys     0m0.008s   0m0.000s

On even tinier repos (e.g., a few hundred objects), the
speedup goes away entirely, as the small advantage of the
radix sort gets erased by the book-keeping costs (and at
those sizes, the cost to generate the the rev-index gets
lost in the noise anyway).

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-revindex.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 95 insertions(+), 5 deletions(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index 1aa9754..b4d2b35 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -59,11 +59,101 @@ static int cmp_offset(const void *a_, const void *b_)
 	/* revindex elements are lazily initialized */
 }
 
-static int cmp_offset(const void *a_, const void *b_)
+/*
+ * This is a least-significant-digit radix sort.
+ *
+ * It sorts each of the "n" items in "entries" by its offset field. The "max"
+ * parameter must be at least as large as the largest offset in the array,
+ * and lets us quit the sort early.
+ */
+static void sort_revindex(struct revindex_entry *entries, unsigned n, off_t max)
 {
-	const struct revindex_entry *a = a_;
-	const struct revindex_entry *b = b_;
-	return (a->offset < b->offset) ? -1 : (a->offset > b->offset) ? 1 : 0;
+	/*
+	 * We use a "digit" size of 16 bits. That keeps our memory
+	 * usage reasonable, and we can generally (for a 4G or smaller
+	 * packfile) quit after two rounds of radix-sorting.
+	 */
+#define DIGIT_SIZE (16)
+#define BUCKETS (1 << DIGIT_SIZE)
+	/*
+	 * We want to know the bucket that a[i] will go into when we are using
+	 * the digit that is N bits from the (least significant) end.
+	 */
+#define BUCKET_FOR(a, i, bits) (((a)[(i)].offset >> (bits)) & (BUCKETS-1))
+
+	/*
+	 * We need O(n) temporary storage. Rather than do an extra copy of the
+	 * partial results into "entries", we sort back and forth between the
+	 * real array and temporary storage. In each iteration of the loop, we
+	 * keep track of them with alias pointers, always sorting from "from"
+	 * to "to".
+	 */
+	struct revindex_entry *tmp = xmalloc(n * sizeof(*tmp));
+	struct revindex_entry *from = entries, *to = tmp;
+	int bits;
+	unsigned *pos = xmalloc(BUCKETS * sizeof(*pos));
+
+	/*
+	 * If (max >> bits) is zero, then we know that the radix digit we are
+	 * on (and any higher) will be zero for all entries, and our loop will
+	 * be a no-op, as everybody lands in the same zero-th bucket.
+	 */
+	for (bits = 0; max >> bits; bits += DIGIT_SIZE) {
+		struct revindex_entry *swap;
+		unsigned i;
+
+		memset(pos, 0, BUCKETS * sizeof(*pos));
+
+		/*
+		 * We want pos[i] to store the index of the last element that
+		 * will go in bucket "i" (actually one past the last element).
+		 * To do this, we first count the items that will go in each
+		 * bucket, which gives us a relative offset from the last
+		 * bucket. We can then cumulatively add the index from the
+		 * previous bucket to get the true index.
+		 */
+		for (i = 0; i < n; i++)
+			pos[BUCKET_FOR(from, i, bits)]++;
+		for (i = 1; i < BUCKETS; i++)
+			pos[i] += pos[i-1];
+
+		/*
+		 * Now we can drop the elements into their correct buckets (in
+		 * our temporary array).  We iterate the pos counter backwards
+		 * to avoid using an extra index to count up. And since we are
+		 * going backwards there, we must also go backwards through the
+		 * array itself, to keep the sort stable.
+		 *
+		 * Note that we use an unsigned iterator to make sure we can
+		 * handle 2^32-1 objects, even on a 32-bit system. But this
+		 * means we cannot use the more obvious "i >= 0" loop condition
+		 * for counting backwards, and must instead check for
+		 * wrap-around with UINT_MAX.
+		 */
+		for (i = n - 1; i != UINT_MAX; i--)
+			to[--pos[BUCKET_FOR(from, i, bits)]] = from[i];
+
+		/*
+		 * Now "to" contains the most sorted list, so we swap "from" and
+		 * "to" for the next iteration.
+		 */
+		swap = from;
+		from = to;
+		to = swap;
+	}
+
+	/*
+	 * If we ended with our data in the original array, great. If not,
+	 * we have to move it back from the temporary storage.
+	 */
+	if (from != entries)
+		memcpy(entries, tmp, n * sizeof(*entries));
+	free(tmp);
+	free(pos);
+
+#undef BUCKET_FOR
+#undef BUCKETS
+#undef DIGIT_SIZE
 }
 
 /*
@@ -108,7 +198,7 @@ static void create_pack_revindex(struct pack_revindex *rix)
 	 */
 	rix->revindex[num_ent].offset = p->pack_size - 20;
 	rix->revindex[num_ent].nr = -1;
-	qsort(rix->revindex, num_ent, sizeof(*rix->revindex), cmp_offset);
+	sort_revindex(rix->revindex, num_ent, p->pack_size);
 }
 
 struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
-- 
1.8.3.rc3.24.gec82cb9
