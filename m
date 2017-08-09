Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07475208B4
	for <e@80x24.org>; Wed,  9 Aug 2017 10:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752991AbdHIKOg (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 06:14:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:33052 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752850AbdHIKOf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 06:14:35 -0400
Received: (qmail 28179 invoked by uid 109); 9 Aug 2017 10:14:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 10:14:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25725 invoked by uid 111); 9 Aug 2017 10:14:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 06:14:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 06:14:32 -0400
Date:   Wed, 9 Aug 2017 06:14:32 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 1/2] sha1_file: drop experimental GIT_USE_LOOKUP search
Message-ID: <20170809101432.6jquwmev423o56pb@sigill.intra.peff.net>
References: <20170809101106.p45y34uk6wcruqxv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170809101106.p45y34uk6wcruqxv@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Long ago in 628522ec14 (sha1-lookup: more memory efficient
search in sorted list of SHA-1, 2007-12-29) we added
sha1_entry_pos(), a binary search that uses the uniform
distribution of sha1s to scale the selection of mid-points.
As this was a performance experiment, we tied it to the
GIT_USE_LOOKUP environment variable and never enabled it by
default.

This code was successful in reducing the number of steps in
each search. But the overhead of the scaling ends up making
it slower when the cache is warm. Here are best-of-five
timings for running rev-list on linux.git, which will have
to look up every object:

  $ time git rev-list --objects --all >/dev/null
  real	0m35.357s
  user	0m35.016s
  sys	0m0.340s

  $ time GIT_USE_LOOKUP=1 git rev-list --objects --all >/dev/null
  real	0m37.364s
  user	0m37.045s
  sys	0m0.316s

The USE_LOOKUP version might have more benefit on a cold
cache, as the time to fault in each page would dominate. But
that would be for a single lookup. In practice, most
operations tend to look up many objects, and the whole pack
.idx will end up warm.

It's possible that the code could be better optimized to
compete with a naive binary search for the warm-cache case,
and we could have the best of both worlds. But over the
years nobody has done so, and this is largely dead code that
is rarely run outside of the test suite. Let's drop it in
the name of simplicity.

This lets us remove sha1_entry_pos() entirely, as the .idx
lookup code was the only caller.  Note that sha1-lookup.c
still contains sha1_pos(), which differs from
sha1_entry_pos() in two ways:

  - it has a different interface; it uses a function pointer
    to access sha1 entries rather than a size/offset pair
    describing the table's memory layout

  - it only scales the initial selection of "mi", rather
    than each iteration of the search

We can't get rid of this function, as it's called from
several places. It may be that we could replace it with a
simple binary search, but that's out of scope for this patch
(and would need benchmarking).

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1-lookup.c                     | 216 --------------------------------------
 sha1_file.c                       |  11 --
 t/t5308-pack-detect-duplicates.sh |  11 +-
 t/test-lib.sh                     |   1 -
 4 files changed, 1 insertion(+), 238 deletions(-)

diff --git a/sha1-lookup.c b/sha1-lookup.c
index 5f069214d9..2552b7902c 100644
--- a/sha1-lookup.c
+++ b/sha1-lookup.c
@@ -99,219 +99,3 @@ int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
 	} while (lo < hi);
 	return -lo-1;
 }
-
-/*
- * Conventional binary search loop looks like this:
- *
- *	unsigned lo, hi;
- *      do {
- *              unsigned mi = (lo + hi) / 2;
- *              int cmp = "entry pointed at by mi" minus "target";
- *              if (!cmp)
- *                      return (mi is the wanted one)
- *              if (cmp > 0)
- *                      hi = mi; "mi is larger than target"
- *              else
- *                      lo = mi+1; "mi is smaller than target"
- *      } while (lo < hi);
- *
- * The invariants are:
- *
- * - When entering the loop, lo points at a slot that is never
- *   above the target (it could be at the target), hi points at a
- *   slot that is guaranteed to be above the target (it can never
- *   be at the target).
- *
- * - We find a point 'mi' between lo and hi (mi could be the same
- *   as lo, but never can be as same as hi), and check if it hits
- *   the target.  There are three cases:
- *
- *    - if it is a hit, we are happy.
- *
- *    - if it is strictly higher than the target, we set it to hi,
- *      and repeat the search.
- *
- *    - if it is strictly lower than the target, we update lo to
- *      one slot after it, because we allow lo to be at the target.
- *
- *   If the loop exits, there is no matching entry.
- *
- * When choosing 'mi', we do not have to take the "middle" but
- * anywhere in between lo and hi, as long as lo <= mi < hi is
- * satisfied.  When we somehow know that the distance between the
- * target and lo is much shorter than the target and hi, we could
- * pick mi that is much closer to lo than the midway.
- *
- * Now, we can take advantage of the fact that SHA-1 is a good hash
- * function, and as long as there are enough entries in the table, we
- * can expect uniform distribution.  An entry that begins with for
- * example "deadbeef..." is much likely to appear much later than in
- * the midway of the table.  It can reasonably be expected to be near
- * 87% (222/256) from the top of the table.
- *
- * However, we do not want to pick "mi" too precisely.  If the entry at
- * the 87% in the above example turns out to be higher than the target
- * we are looking for, we would end up narrowing the search space down
- * only by 13%, instead of 50% we would get if we did a simple binary
- * search.  So we would want to hedge our bets by being less aggressive.
- *
- * The table at "table" holds at least "nr" entries of "elem_size"
- * bytes each.  Each entry has the SHA-1 key at "key_offset".  The
- * table is sorted by the SHA-1 key of the entries.  The caller wants
- * to find the entry with "key", and knows that the entry at "lo" is
- * not higher than the entry it is looking for, and that the entry at
- * "hi" is higher than the entry it is looking for.
- */
-int sha1_entry_pos(const void *table,
-		   size_t elem_size,
-		   size_t key_offset,
-		   unsigned lo, unsigned hi, unsigned nr,
-		   const unsigned char *key)
-{
-	const unsigned char *base = table;
-	const unsigned char *hi_key, *lo_key;
-	unsigned ofs_0;
-	static int debug_lookup = -1;
-
-	if (debug_lookup < 0)
-		debug_lookup = !!getenv("GIT_DEBUG_LOOKUP");
-
-	if (!nr || lo >= hi)
-		return -1;
-
-	if (nr == hi)
-		hi_key = NULL;
-	else
-		hi_key = base + elem_size * hi + key_offset;
-	lo_key = base + elem_size * lo + key_offset;
-
-	ofs_0 = 0;
-	do {
-		int cmp;
-		unsigned ofs, mi, range;
-		unsigned lov, hiv, kyv;
-		const unsigned char *mi_key;
-
-		range = hi - lo;
-		if (hi_key) {
-			for (ofs = ofs_0; ofs < 20; ofs++)
-				if (lo_key[ofs] != hi_key[ofs])
-					break;
-			ofs_0 = ofs;
-			/*
-			 * byte 0 thru (ofs-1) are the same between
-			 * lo and hi; ofs is the first byte that is
-			 * different.
-			 *
-			 * If ofs==20, then no bytes are different,
-			 * meaning we have entries with duplicate
-			 * keys. We know that we are in a solid run
-			 * of this entry (because the entries are
-			 * sorted, and our lo and hi are the same,
-			 * there can be nothing but this single key
-			 * in between). So we can stop the search.
-			 * Either one of these entries is it (and
-			 * we do not care which), or we do not have
-			 * it.
-			 *
-			 * Furthermore, we know that one of our
-			 * endpoints must be the edge of the run of
-			 * duplicates. For example, given this
-			 * sequence:
-			 *
-			 *     idx 0 1 2 3 4 5
-			 *     key A C C C C D
-			 *
-			 * If we are searching for "B", we might
-			 * hit the duplicate run at lo=1, hi=3
-			 * (e.g., by first mi=3, then mi=0). But we
-			 * can never have lo > 1, because B < C.
-			 * That is, if our key is less than the
-			 * run, we know that "lo" is the edge, but
-			 * we can say nothing of "hi". Similarly,
-			 * if our key is greater than the run, we
-			 * know that "hi" is the edge, but we can
-			 * say nothing of "lo".
-			 *
-			 * Therefore if we do not find it, we also
-			 * know where it would go if it did exist:
-			 * just on the far side of the edge that we
-			 * know about.
-			 */
-			if (ofs == 20) {
-				mi = lo;
-				mi_key = base + elem_size * mi + key_offset;
-				cmp = memcmp(mi_key, key, 20);
-				if (!cmp)
-					return mi;
-				if (cmp < 0)
-					return -1 - hi;
-				else
-					return -1 - lo;
-			}
-
-			hiv = hi_key[ofs_0];
-			if (ofs_0 < 19)
-				hiv = (hiv << 8) | hi_key[ofs_0+1];
-		} else {
-			hiv = 256;
-			if (ofs_0 < 19)
-				hiv <<= 8;
-		}
-		lov = lo_key[ofs_0];
-		kyv = key[ofs_0];
-		if (ofs_0 < 19) {
-			lov = (lov << 8) | lo_key[ofs_0+1];
-			kyv = (kyv << 8) | key[ofs_0+1];
-		}
-		assert(lov < hiv);
-
-		if (kyv < lov)
-			return -1 - lo;
-		if (hiv < kyv)
-			return -1 - hi;
-
-		/*
-		 * Even if we know the target is much closer to 'hi'
-		 * than 'lo', if we pick too precisely and overshoot
-		 * (e.g. when we know 'mi' is closer to 'hi' than to
-		 * 'lo', pick 'mi' that is higher than the target), we
-		 * end up narrowing the search space by a smaller
-		 * amount (i.e. the distance between 'mi' and 'hi')
-		 * than what we would have (i.e. about half of 'lo'
-		 * and 'hi').  Hedge our bets to pick 'mi' less
-		 * aggressively, i.e. make 'mi' a bit closer to the
-		 * middle than we would otherwise pick.
-		 */
-		kyv = (kyv * 6 + lov + hiv) / 8;
-		if (lov < hiv - 1) {
-			if (kyv == lov)
-				kyv++;
-			else if (kyv == hiv)
-				kyv--;
-		}
-		mi = (range - 1) * (kyv - lov) / (hiv - lov) + lo;
-
-		if (debug_lookup) {
-			printf("lo %u hi %u rg %u mi %u ", lo, hi, range, mi);
-			printf("ofs %u lov %x, hiv %x, kyv %x\n",
-			       ofs_0, lov, hiv, kyv);
-		}
-		if (!(lo <= mi && mi < hi))
-			die("assertion failure lo %u mi %u hi %u %s",
-			    lo, mi, hi, sha1_to_hex(key));
-
-		mi_key = base + elem_size * mi + key_offset;
-		cmp = memcmp(mi_key + ofs_0, key + ofs_0, 20 - ofs_0);
-		if (!cmp)
-			return mi;
-		if (cmp > 0) {
-			hi = mi;
-			hi_key = mi_key;
-		} else {
-			lo = mi + 1;
-			lo_key = mi_key + elem_size;
-		}
-	} while (lo < hi);
-	return -lo-1;
-}
diff --git a/sha1_file.c b/sha1_file.c
index 11ee69a99d..607b34ea53 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2759,7 +2759,6 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 	const uint32_t *level1_ofs = p->index_data;
 	const unsigned char *index = p->index_data;
 	unsigned hi, lo, stride;
-	static int use_lookup = -1;
 	static int debug_lookup = -1;
 
 	if (debug_lookup < 0)
@@ -2789,16 +2788,6 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 		printf("%02x%02x%02x... lo %u hi %u nr %"PRIu32"\n",
 		       sha1[0], sha1[1], sha1[2], lo, hi, p->num_objects);
 
-	if (use_lookup < 0)
-		use_lookup = !!getenv("GIT_USE_LOOKUP");
-	if (use_lookup) {
-		int pos = sha1_entry_pos(index, stride, 0,
-					 lo, hi, p->num_objects, sha1);
-		if (pos < 0)
-			return 0;
-		return nth_packed_object_offset(p, pos);
-	}
-
 	while (lo < hi) {
 		unsigned mi = (lo + hi) / 2;
 		int cmp = hashcmp(index + mi * stride, sha1);
diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
index 9c5a8766ab..156ae9e9d3 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -56,20 +56,11 @@ test_expect_success 'create batch-check test vectors' '
 	EOF
 '
 
-test_expect_success 'lookup in duplicated pack (binary search)' '
+test_expect_success 'lookup in duplicated pack' '
 	git cat-file --batch-check <input >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'lookup in duplicated pack (GIT_USE_LOOKUP)' '
-	(
-		GIT_USE_LOOKUP=1 &&
-		export GIT_USE_LOOKUP &&
-		git cat-file --batch-check <input >actual
-	) &&
-	test_cmp expect actual
-'
-
 test_expect_success 'index-pack can reject packs with duplicates' '
 	clear_packs &&
 	create_pack dups.pack 2 &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1b6e53f78a..5e3ca30ab3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -99,7 +99,6 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
 	my $ok = join("|", qw(
 		TRACE
 		DEBUG
-		USE_LOOKUP
 		TEST
 		.*_TEST
 		PROVE
-- 
2.14.0.609.gd2d1f7ddf

