Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B54C31F404
	for <e@80x24.org>; Fri, 23 Mar 2018 05:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbeCWFua (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 01:50:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:39622 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750789AbeCWFu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 01:50:29 -0400
Received: (qmail 29968 invoked by uid 109); 23 Mar 2018 05:50:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Mar 2018 05:50:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25152 invoked by uid 111); 23 Mar 2018 05:51:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 23 Mar 2018 01:51:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Mar 2018 01:50:27 -0400
Date:   Fri, 23 Mar 2018 01:50:27 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
Message-ID: <20180323055027.GA30227@sigill.intra.peff.net>
References: <20180317141033.21545-1-pclouds@gmail.com>
 <20180318142526.9378-1-pclouds@gmail.com>
 <20180321082441.GB25537@sigill.intra.peff.net>
 <CACsJy8DkF3TpTGKp5MdS1ApC8Yj6FOL5uAg5U__PjBAQY1vdNw@mail.gmail.com>
 <20180322093212.GB28907@sigill.intra.peff.net>
 <7a49135b-faad-9856-b757-e3ed4886720d@ramsayjones.plus.com>
 <20180323024609.GA12229@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180323024609.GA12229@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 22, 2018 at 10:46:09PM -0400, Jeff King wrote:

> > which begs the question, how much slower would it be if we
> > replaced the radix-sort with an in-place sort (e.g. heapsort).
> > 
> > I hacked up the patch below, just for fun. I don't have any
> > large repos (or enough disk space) to do any meaningful perf
> > tests, but I did at least compile it and it passes the test-suite.
> > (That is no guarantee that I haven't introduced bugs, of course!)
> 
> It might have been easier to just revert 8b8dfd5132 (pack-revindex:
> radix-sort the revindex, 2013-07-11). It even includes some performance
> numbers. :)
> 
> In short, no, I don't think we want to go back to a comparison-sort. The
> radix sort back then was around 4 times faster for linux.git. And that
> was when there were half as many objects in the repository, so the radix
> sort should continue to improve as the repo size grows.

I was curious whether my hand-waving there was true. It turns out that
it is: the radix sort has stayed about the same speed but the comparison
sort has gotten even slower. Here are best-of-five timings for "git
cat-file --batch-check='%(objectsize:disk)'", which does very little
besides generate the rev-index:

  [current master, using radix sort]
  real	0m0.104s
  user	0m0.088s
  sys	0m0.016s

  [reverting 8b8dfd5132, going back to qsort]
  real	0m1.193s
  user	0m1.176s
  sys	0m0.016s

So it's now a factor of 11. Yikes.

That number does match some napkin math. The radix sort uses four 16-bit
buckets, but can quit when after two rounds (because none of the offsets
is beyond 2^32). So it's essentially O(2n). Whereas the comparison sort
is O(n log n), and with n around 6M, that puts log(n) right around 22.

It's possible that some other comparison-based sort might be a little
more efficient than qsort, but I don't think you'll be able to beat the
algorithmic speedup.

The revert of 8b8dfd5132 is below for reference (it needed a few
conflict tweaks).

-Peff

---
diff --git a/pack-revindex.c b/pack-revindex.c
index ff5f62c033..c20aa9541b 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -15,102 +15,11 @@
  * get the object sha1 from the main index.
  */
 
-/*
- * This is a least-significant-digit radix sort.
- *
- * It sorts each of the "n" items in "entries" by its offset field. The "max"
- * parameter must be at least as large as the largest offset in the array,
- * and lets us quit the sort early.
- */
-static void sort_revindex(struct revindex_entry *entries, unsigned n, off_t max)
+static int cmp_offset(const void *a_, const void *b_)
 {
-	/*
-	 * We use a "digit" size of 16 bits. That keeps our memory
-	 * usage reasonable, and we can generally (for a 4G or smaller
-	 * packfile) quit after two rounds of radix-sorting.
-	 */
-#define DIGIT_SIZE (16)
-#define BUCKETS (1 << DIGIT_SIZE)
-	/*
-	 * We want to know the bucket that a[i] will go into when we are using
-	 * the digit that is N bits from the (least significant) end.
-	 */
-#define BUCKET_FOR(a, i, bits) (((a)[(i)].offset >> (bits)) & (BUCKETS-1))
-
-	/*
-	 * We need O(n) temporary storage. Rather than do an extra copy of the
-	 * partial results into "entries", we sort back and forth between the
-	 * real array and temporary storage. In each iteration of the loop, we
-	 * keep track of them with alias pointers, always sorting from "from"
-	 * to "to".
-	 */
-	struct revindex_entry *tmp, *from, *to;
-	int bits;
-	unsigned *pos;
-
-	ALLOC_ARRAY(pos, BUCKETS);
-	ALLOC_ARRAY(tmp, n);
-	from = entries;
-	to = tmp;
-
-	/*
-	 * If (max >> bits) is zero, then we know that the radix digit we are
-	 * on (and any higher) will be zero for all entries, and our loop will
-	 * be a no-op, as everybody lands in the same zero-th bucket.
-	 */
-	for (bits = 0; max >> bits; bits += DIGIT_SIZE) {
-		unsigned i;
-
-		memset(pos, 0, BUCKETS * sizeof(*pos));
-
-		/*
-		 * We want pos[i] to store the index of the last element that
-		 * will go in bucket "i" (actually one past the last element).
-		 * To do this, we first count the items that will go in each
-		 * bucket, which gives us a relative offset from the last
-		 * bucket. We can then cumulatively add the index from the
-		 * previous bucket to get the true index.
-		 */
-		for (i = 0; i < n; i++)
-			pos[BUCKET_FOR(from, i, bits)]++;
-		for (i = 1; i < BUCKETS; i++)
-			pos[i] += pos[i-1];
-
-		/*
-		 * Now we can drop the elements into their correct buckets (in
-		 * our temporary array).  We iterate the pos counter backwards
-		 * to avoid using an extra index to count up. And since we are
-		 * going backwards there, we must also go backwards through the
-		 * array itself, to keep the sort stable.
-		 *
-		 * Note that we use an unsigned iterator to make sure we can
-		 * handle 2^32-1 objects, even on a 32-bit system. But this
-		 * means we cannot use the more obvious "i >= 0" loop condition
-		 * for counting backwards, and must instead check for
-		 * wrap-around with UINT_MAX.
-		 */
-		for (i = n - 1; i != UINT_MAX; i--)
-			to[--pos[BUCKET_FOR(from, i, bits)]] = from[i];
-
-		/*
-		 * Now "to" contains the most sorted list, so we swap "from" and
-		 * "to" for the next iteration.
-		 */
-		SWAP(from, to);
-	}
-
-	/*
-	 * If we ended with our data in the original array, great. If not,
-	 * we have to move it back from the temporary storage.
-	 */
-	if (from != entries)
-		COPY_ARRAY(entries, tmp, n);
-	free(tmp);
-	free(pos);
-
-#undef BUCKET_FOR
-#undef BUCKETS
-#undef DIGIT_SIZE
+	const struct revindex_entry *a = a_;
+	const struct revindex_entry *b = b_;
+	return (a->offset < b->offset) ? -1 : (a->offset > b->offset) ? 1 : 0;
 }
 
 /*
@@ -152,7 +61,7 @@ static void create_pack_revindex(struct packed_git *p)
 	 */
 	p->revindex[num_ent].offset = p->pack_size - 20;
 	p->revindex[num_ent].nr = -1;
-	sort_revindex(p->revindex, num_ent, p->pack_size);
+	qsort(p->revindex, num_ent, sizeof(*p->revindex), cmp_offset);
 }
 
 void load_pack_revindex(struct packed_git *p)
