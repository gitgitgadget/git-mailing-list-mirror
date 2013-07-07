From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] pack-revindex: radix-sort the revindex
Date: Sun, 7 Jul 2013 06:14:39 -0400
Message-ID: <20130707101438.GD19143@sigill.intra.peff.net>
References: <20130707100133.GA18717@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 12:14:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvlzT-0004x8-HI
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 12:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab3GGKOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 06:14:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:46861 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295Ab3GGKOm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 06:14:42 -0400
Received: (qmail 13156 invoked by uid 102); 7 Jul 2013 10:15:56 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 07 Jul 2013 05:15:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Jul 2013 06:14:39 -0400
Content-Disposition: inline
In-Reply-To: <20130707100133.GA18717@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229766>

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
running "echo HEAD | git cat-file --batch-disk-size", which
is dominated by time spent building the pack revindex:

          before     after
  real    0m0.834s   0m0.204s
  user    0m0.788s   0m0.164s
  sys     0m0.040s   0m0.036s

On a smaller repo, the radix sort would not be
as impressive (and could even be worse), as we are trading
the log(n) factor for the k=4 of the radix sort. However,
even on git.git, with 173K objects, it shows some
improvement:

          before     after
  real    0m0.046s   0m0.017s
  user    0m0.036s   0m0.012s
  sys     0m0.008s   0m0.000s

Signed-off-by: Jeff King <peff@peff.net>
---
I think there are probably still two potential issues here:

  1. My while() loop termination probably has issues when we have to use
     all 64 bits to represent the pack offset (not likely, but...)

  2. We put "int pos[65536]" on the stack. This is a little big, but is
     probably OK, as I think the usual small stack problems we have seen
     are always in threaded code. But it would not be a big deal to heap
     allocate it (it would happen once per radix step, which is only 4
     times for the whole sort).

 pack-revindex.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 5 deletions(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index 77a0465..d2adf36 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -59,11 +59,78 @@ static int cmp_offset(const void *a_, const void *b_)
 	/* revindex elements are lazily initialized */
 }
 
-static int cmp_offset(const void *a_, const void *b_)
+/*
+ * This is a least-significant-digit radix sort using a 16-bit "digit".
+ */
+static void sort_revindex(struct revindex_entry *entries, int n, off_t max)
 {
-	const struct revindex_entry *a = a_;
-	const struct revindex_entry *b = b_;
-	return (a->offset < b->offset) ? -1 : (a->offset > b->offset) ? 1 : 0;
+	/*
+	 * We need O(n) temporary storage, so we sort back and forth between
+	 * the real array and our tmp storage. To keep them straight, we always
+	 * sort from "a" into buckets in "b".
+	 */
+	struct revindex_entry *tmp = xcalloc(n, sizeof(*tmp));
+	struct revindex_entry *a = entries, *b = tmp;
+	int digits = 0;
+
+	/*
+	 * We want to know the bucket that a[i] will go into when we are using
+	 * the digit that is N bits from the (least significant) end.
+	 */
+#define BUCKET_FOR(a, i, digits) ((a[i].offset >> digits) & 0xffff)
+
+	while (max / (((off_t)1) << digits)) {
+		struct revindex_entry *swap;
+		int i;
+		int pos[65536] = {0};
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
+			pos[BUCKET_FOR(a, i, digits)]++;
+		for (i = 1; i < ARRAY_SIZE(pos); i++)
+			pos[i] += pos[i-1];
+
+		/*
+		 * Now we can drop the elements into their correct buckets (in
+		 * our temporary array).  We iterate the pos counter backwards
+		 * to avoid using an extra index to count up. And since we are
+		 * going backwards there, we must also go backwards through the
+		 * array itself, to keep the sort stable.
+		 */
+		for (i = n - 1; i >= 0; i--)
+			b[--pos[BUCKET_FOR(a, i, digits)]] = a[i];
+
+		/*
+		 * Now "b" contains the most sorted list, so we swap "a" and
+		 * "b" for the next iteration.
+		 */
+		swap = a;
+		a = b;
+		b = swap;
+
+		/* And bump our digits for the next round. */
+		digits += 16;
+	}
+
+	/*
+	 * If we ended with our data in the original array, great. If not,
+	 * we have to move it back from the temporary storage.
+	 */
+	if (a != entries) {
+		int i;
+		for (i = 0; i < n; i++)
+			entries[i] = tmp[i];
+	}
+	free(tmp);
+
+#undef BUCKET_FOR
 }
 
 /*
@@ -108,7 +175,7 @@ static void create_pack_revindex(struct pack_revindex *rix)
 	 */
 	rix->revindex[num_ent].offset = p->pack_size - 20;
 	rix->revindex[num_ent].nr = -1;
-	qsort(rix->revindex, num_ent, sizeof(*rix->revindex), cmp_offset);
+	sort_revindex(rix->revindex, num_ent, p->pack_size);
 }
 
 struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
-- 
1.8.3.rc3.24.gec82cb9
