From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 2 Oct 2007 19:28:19 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710021916080.3579@woody.linux-foundation.org>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>
 <7v1wd1d0le.fsf@gitster.siamese.dyndns.org> <7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
 <20070927023633.GA28902@coredump.intra.peff.net> <20071002041652.GA32133@coredump.intra.peff.net>
 <7vsl4up0tf.fsf@gitster.siamese.dyndns.org> <20071002050820.GA4261@coredump.intra.peff.net>
 <20071002051332.GA4462@coredump.intra.peff.net> <86ejge6o8b.fsf@lola.quinscape.zz>
 <20071002161114.GC6828@coredump.intra.peff.net>
 <86ve9p32cp.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 03 04:29:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IctzB-00039A-Bw
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 04:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384AbXJCC3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 22:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755089AbXJCC3G
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 22:29:06 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46865 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754911AbXJCC3E (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Oct 2007 22:29:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l932SKa5020475
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 2 Oct 2007 19:28:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l932SJjb001560;
	Tue, 2 Oct 2007 19:28:19 -0700
In-Reply-To: <86ve9p32cp.fsf@lola.quinscape.zz>
X-Spam-Status: No, hits=-2.449 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_33
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.46__
X-MIMEDefang-Filter: lf$Revision: 1.187 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59770>


[ This is the discussed stupid approach - just sort the dang hash array, 
  so that we can use a linear scan over the src/dst ]

On Tue, 2 Oct 2007, David Kastrup wrote:
> 
> This does not actually require an actual merge _sort_ AFAICS: do the
> "sort file.hashed" step using qsort.  The comparison step does not
> actually need to produce merged output, but merely advances through
> two hash arrays and generates statistics.
> 
> This should already beat the pants off the current implementation,
> even when the hash array is sparse, simply because our inner loop then
> has perfect hash coherence.

Sadly, that's not the case. It *does* seem to beat the current 
implementation, but it's not "beat the pants off". It looks like an 
improvement of about 15%, which is nothing to sneeze at, but it's not an 
order-of-magnitude improvement either.

Here's a test-patch. I don't guarantee anything, except that when I did 
the timings I also did a "wc" on the result, and they matched..

Before:
	[torvalds@woody linux]$ time git diff -l0 --stat -C v2.6.22.. | wc
	   7104   28574  438020

	real    0m10.526s
	user    0m10.401s
	sys     0m0.136s

After:
	[torvalds@woody linux]$ time ~/git/git diff -l0 --stat -C v2.6.22.. | wc
	   7104   28574  438020
	
	real    0m8.876s
	user    0m8.761s
	sys     0m0.128s

but the diff is fairly simple, so if somebody will go over it and say 
whether it's likely to be *correct* too, that 15% may well be worth it.

[ Side note, without rename detection, that diff takes just under three 
  seconds for me, so in that sense the improvement to the rename detection 
  itself is larger than the overall 15% - it brings the cost of just 
  rename detection from 7.5s to 5.9s, which would be on the order of just 
  over a 20% performance improvement. ]

Hmm. The patch depends on half-way subtle issues like the fact that the 
hashtables are guaranteed to not be full => we're guaranteed to have zero 
counts at the end => we don't need to do any steenking iterator count in 
the loop. A few comments might in order.

		Linus

---
 diffcore-delta.c |   54 ++++++++++++++++++++++++++++++------------------------
 1 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/diffcore-delta.c b/diffcore-delta.c
index d9729e5..6d65697 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -46,22 +46,6 @@ struct spanhash_top {
 	struct spanhash data[FLEX_ARRAY];
 };
 
-static struct spanhash *spanhash_find(struct spanhash_top *top,
-				      unsigned int hashval)
-{
-	int sz = 1 << top->alloc_log2;
-	int bucket = hashval & (sz - 1);
-	while (1) {
-		struct spanhash *h = &(top->data[bucket++]);
-		if (!h->cnt)
-			return NULL;
-		if (h->hashval == hashval)
-			return h;
-		if (sz <= bucket)
-			bucket = 0;
-	}
-}
-
 static struct spanhash_top *spanhash_rehash(struct spanhash_top *orig)
 {
 	struct spanhash_top *new;
@@ -122,6 +106,20 @@ static struct spanhash_top *add_spanhash(struct spanhash_top *top,
 	}
 }
 
+static int spanhash_cmp(const void *_a, const void *_b)
+{
+	const struct spanhash *a = _a;
+	const struct spanhash *b = _b;
+
+	/* A count of zero compares at the end.. */
+	if (!a->cnt)
+		return !b->cnt ? 0 : 1;
+	if (!b->cnt)
+		return -1;
+	return a->hashval < b->hashval ? -1 :
+		a->hashval > b->hashval ? 1 : 0;
+}
+
 static struct spanhash_top *hash_chars(struct diff_filespec *one)
 {
 	int i, n;
@@ -158,6 +156,10 @@ static struct spanhash_top *hash_chars(struct diff_filespec *one)
 		n = 0;
 		accum1 = accum2 = 0;
 	}
+	qsort(hash->data,
+		1ul << hash->alloc_log2,
+		sizeof(hash->data[0]),
+		spanhash_cmp);
 	return hash;
 }
 
@@ -169,7 +171,7 @@ int diffcore_count_changes(struct diff_filespec *src,
 			   unsigned long *src_copied,
 			   unsigned long *literal_added)
 {
-	int i, ssz;
+	struct spanhash *s, *d;
 	struct spanhash_top *src_count, *dst_count;
 	unsigned long sc, la;
 
@@ -190,22 +192,26 @@ int diffcore_count_changes(struct diff_filespec *src,
 	}
 	sc = la = 0;
 
-	ssz = 1 << src_count->alloc_log2;
-	for (i = 0; i < ssz; i++) {
-		struct spanhash *s = &(src_count->data[i]);
-		struct spanhash *d;
+	s = src_count->data;
+	d = dst_count->data;
+	for (;;) {
 		unsigned dst_cnt, src_cnt;
 		if (!s->cnt)
-			continue;
+			break;
+		while (d->cnt) {
+			if (d->hashval >= s->hashval)
+				break;
+			d++;
+		}
 		src_cnt = s->cnt;
-		d = spanhash_find(dst_count, s->hashval);
-		dst_cnt = d ? d->cnt : 0;
+		dst_cnt = d->hashval == s->hashval ? d->cnt : 0;
 		if (src_cnt < dst_cnt) {
 			la += dst_cnt - src_cnt;
 			sc += src_cnt;
 		}
 		else
 			sc += dst_cnt;
+		s++;
 	}
 
 	if (!src_count_p)
