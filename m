Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1176C1F858
	for <e@80x24.org>; Fri, 29 Jul 2016 04:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbcG2EJv (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 00:09:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:50808 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750729AbcG2EJt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 00:09:49 -0400
Received: (qmail 24376 invoked by uid 102); 29 Jul 2016 04:09:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 00:09:50 -0400
Received: (qmail 31370 invoked by uid 107); 29 Jul 2016 04:10:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 00:10:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 00:09:46 -0400
Date:	Fri, 29 Jul 2016 00:09:46 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/7] find_pack_entry: replace last_found_pack with MRU
 cache
Message-ID: <20160729040946.GD22408@sigill.intra.peff.net>
References: <20160729040422.GA19678@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160729040422.GA19678@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Each pack has an index for looking up entries in O(log n)
time, but if we have multiple packs, we have to scan through
them linearly. This can produce a measurable overhead for
some operations.

We dealt with this long ago in f7c22cc (always start looking
up objects in the last used pack first, 2007-05-30), which
keeps what is essentially a 1-element most-recently-used
cache. In theory, we should be able to do better by keeping
a similar but longer cache, that is the same length as the
pack-list itself.

Since we now have a convenient generic MRU structure, we can
plug it in and measure. Here are the numbers for running
p5303 against linux.git:

Test                      HEAD^                HEAD
------------------------------------------------------------------------
5303.3: rev-list (1)      31.56(31.28+0.27)    31.30(31.08+0.20) -0.8%
5303.4: repack (1)        40.62(39.35+2.36)    40.60(39.27+2.44) -0.0%
5303.6: rev-list (50)     31.31(31.06+0.23)    31.23(31.00+0.22) -0.3%
5303.7: repack (50)       58.65(69.12+1.94)    58.27(68.64+2.05) -0.6%
5303.9: rev-list (1000)   38.74(38.40+0.33)    31.87(31.62+0.24) -17.7%
5303.10: repack (1000)    367.20(441.80+4.62)  342.00(414.04+3.72) -6.9%

The main numbers of interest here are the rev-list ones
(since that is exercising the normal object lookup code
path).  The single-pack case shouldn't improve at all; the
260ms speedup there is just part of the run-to-run noise
(but it's important to note that we didn't make anything
worse with the overhead of maintaining our cache). In the
50-pack case, we see similar results. There may be a slight
improvement, but it's mostly within the noise.

The 1000-pack case does show a big improvement, though. That
carries over to the repack case, as well. Even though we
haven't touched its pack-search loop yet, it does still do a
lot of normal object lookups (e.g., for the internal
revision walk), and so improves.

As a point of reference, I also ran the 1000-pack test
against a version of HEAD^ with the last_found_pack
optimization disabled. It takes ~60s, so that gives an
indication of how much even the single-element cache is
helping.

For comparison, here's a smaller repository, git.git:

Test                      HEAD^               HEAD
---------------------------------------------------------------------
5303.3: rev-list (1)      1.56(1.54+0.01)    1.54(1.51+0.02) -1.3%
5303.4: repack (1)        1.84(1.80+0.10)    1.82(1.80+0.09) -1.1%
5303.6: rev-list (50)     1.58(1.55+0.02)    1.59(1.57+0.01) +0.6%
5303.7: repack (50)       2.50(3.18+0.04)    2.50(3.14+0.04) +0.0%
5303.9: rev-list (1000)   2.76(2.71+0.04)    2.24(2.21+0.02) -18.8%
5303.10: repack (1000)    13.21(19.56+0.25)  11.66(18.01+0.21) -11.7%

You can see that the percentage improvement is similar.
That's because the lookup we are optimizing is roughly
O(nr_objects * nr_packs). Since the number of packs is
constant in both tests, we'd expect the improvement to be
linear in the number of objects. But the whole process is
also linear in the number of objects, so the improvement
is a constant factor.

The exact improvement does also depend on the contents of
the packs. In p5303, the extra packs all have 5 first-parent
commits in them, which is a reasonable simulation of a
pushed-to repository. But it also means that only 250
first-parent commits are in those packs (compared to almost
50,000 total in linux.git), and the rest are in the huge
"base" pack. So once we start looking at history in taht big
pack, that's where we'll find most everything, and even the
1-element cache gets close to 100% cache hits.  You could
almost certainly show better numbers with a more
pathological case (e.g., distributing the objects more
evenly across the packs). But that's simply not that
realistic a scenario, so it makes more sense to focus on
these numbers.

The implementation itself is a straightforward application
of the MRU code. We provide an MRU-ordered list of packs
that shadows the packed_git list. This is easy to do because
we only create and revise the pack list in one place. The
"reprepare" code path actually drops the whole MRU and
replaces it for simplicity. It would be more efficient to
just add new entries, but there's not much point in
optimizing here; repreparing happens rarely, and only after
doing a lot of other expensive work.  The key things to keep
optimized are traversal (which is just a normal linked list,
albeit with one extra level of indirection over the regular
packed_git list), and marking (which is a constant number of
pointer assignments, though slightly more than the old
last_found_pack was; it doesn't seem to create a measurable
slowdown, though).

Signed-off-by: Jeff King <peff@peff.net>
---
I could see an argument against this, which is basically:

  - this is touching a really critical and core part of the code

  - in normal cases, we should never grow beyond 50 packs

  - it seems to be a wash at 50 packs

So it's all risk and no benefit. But it definitely _does_ help in the
more pathological cases, which are sadly a thing I have seen more than
once. So I tried hard to show that it does no harm, performance-wise,
for the smaller cases. As for complexity, you can be the judge. I think
the call-site here is improved, but of course that's because the
complexity is hidden in the mru_mark() function.

 cache.h     |  7 +++++++
 sha1_file.c | 36 ++++++++++++++++++------------------
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/cache.h b/cache.h
index 57ef726..9b4b08f 100644
--- a/cache.h
+++ b/cache.h
@@ -1377,6 +1377,13 @@ extern struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 } *packed_git;
 
+/*
+ * A most-recently-used ordered version of the packed_git list, which can
+ * be iterated instead of packed_git (and marked via mru_mark).
+ */
+struct mru;
+extern struct mru *packed_git_mru;
+
 struct pack_entry {
 	off_t offset;
 	unsigned char sha1[20];
diff --git a/sha1_file.c b/sha1_file.c
index e045d2f..4eb3318 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -23,6 +23,7 @@
 #include "bulk-checkin.h"
 #include "streaming.h"
 #include "dir.h"
+#include "mru.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -59,14 +60,6 @@ static struct cached_object empty_tree = {
 	0
 };
 
-/*
- * A pointer to the last packed_git in which an object was found.
- * When an object is sought, we look in this packfile first, because
- * objects that are looked up at similar times are often in the same
- * packfile as one another.
- */
-static struct packed_git *last_found_pack;
-
 static struct cached_object *find_cached_object(const unsigned char *sha1)
 {
 	int i;
@@ -522,6 +515,9 @@ static size_t peak_pack_mapped;
 static size_t pack_mapped;
 struct packed_git *packed_git;
 
+static struct mru packed_git_mru_storage;
+struct mru *packed_git_mru = &packed_git_mru_storage;
+
 void pack_report(void)
 {
 	fprintf(stderr,
@@ -1355,6 +1351,15 @@ static void rearrange_packed_git(void)
 	free(ary);
 }
 
+static void prepare_packed_git_mru(void)
+{
+	struct packed_git *p;
+
+	mru_clear(packed_git_mru);
+	for (p = packed_git; p; p = p->next)
+		mru_append(packed_git_mru, p);
+}
+
 static int prepare_packed_git_run_once = 0;
 void prepare_packed_git(void)
 {
@@ -1370,6 +1375,7 @@ void prepare_packed_git(void)
 		alt->name[-1] = '/';
 	}
 	rearrange_packed_git();
+	prepare_packed_git_mru();
 	prepare_packed_git_run_once = 1;
 }
 
@@ -2574,21 +2580,15 @@ static int fill_pack_entry(const unsigned char *sha1,
  */
 static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 {
-	struct packed_git *p;
+	struct mru_entry *p;
 
 	prepare_packed_git();
 	if (!packed_git)
 		return 0;
 
-	if (last_found_pack && fill_pack_entry(sha1, e, last_found_pack))
-		return 1;
-
-	for (p = packed_git; p; p = p->next) {
-		if (p == last_found_pack)
-			continue; /* we already checked this one */
-
-		if (fill_pack_entry(sha1, e, p)) {
-			last_found_pack = p;
+	for (p = packed_git_mru->head; p; p = p->next) {
+		if (fill_pack_entry(sha1, e, p->item)) {
+			mru_mark(packed_git_mru, p);
 			return 1;
 		}
 	}
-- 
2.9.2.607.g98dce7b

