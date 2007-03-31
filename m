From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Packing large repositories
Date: Sat, 31 Mar 2007 11:36:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703311033290.6730@woody.linux-foundation.org>
References: <56b7f5510703280005o7998d65pcbcd4636b46d8d23@mail.gmail.com>
 <Pine.LNX.4.64.0703280943450.6730@woody.linux-foundation.org>
 <20070330062324.GU13247@spearce.org> <alpine.LFD.0.83.0703300851270.3041@xanadu.home>
 <78639417-ACDB-484F-85BB-EC0AF694949A@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dana How <danahow@gmail.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 20:38:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXiSg-0005gm-U8
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 20:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811AbXCaSho (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 14:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753877AbXCaSho
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 14:37:44 -0400
Received: from smtp.osdl.org ([65.172.181.24]:60284 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753811AbXCaShn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 14:37:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2VIagod015857
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 31 Mar 2007 11:36:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2VIaZSP027840;
	Sat, 31 Mar 2007 11:36:39 -0700
In-Reply-To: <78639417-ACDB-484F-85BB-EC0AF694949A@adacore.com>
X-Spam-Status: No, hits=-0.965 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43564>



On Sat, 31 Mar 2007, Geert Bosch wrote:
> 
> I've been working on a design for a new index file format, and I'll
> include my current draft at the end of this message. It is not finished,
> and I've not written much code yet, but I'd like to prevent duplicated
> work and give others the opportunity to borrow from the ideas so far.

Ok, here's one comment...

I think your basic assumption that the current index-pack is bad is 
broken ;)

The thing is, I think the index-pack could be improved, but I think we can 
get a bigger improvement from just being more intelligent about searching 
than from actually needing to re-organize the pack.

Here's a few clues:
 - binary search is certainly not the only way to do lookups on sorted 
   contents
 - one of the fundamental rules about cryptographic hashes is that they 
   are *evenly*distributed*
 - currently we do not take advantage of our inherent knowledge of the 
   distribution when we look things up, and we use a stupid binary lookup 
   that is guaranteed to basically always take O(log2(n)) random jumps 
   around the data area, with bad locality.

In other words, the 256-entry fan-out was meant to avoid the first eight 
levels of binary lookup. But the thing is, we should be able to generally 
do a *lot* better than any binary lookup by just doing a LINEAR SEARCH, 
which is also more cache-friendly, and prefetches much better when it's 
not in the cache.

The only thing we want for a linear search is a good starting point. Which 
gets us back to the simple: "SHA1 hashes are evenly distributed". In other 
words, getting a good starting point should be *trivial*.

So here's a suggestion:

 - start finding a range using the 256-entry fan-out, exactly the way we 
   did for the binary search. It's cheap. We could probably avoid EVEN 
   THIS, and just do one more newton-raphson iteration more. But since we 
   have the data, we migth as well use it. After all, it really *is* just 
   a first approximation of newton-raphson, and while it uses only 8 bits 
   (and we could do better), at least it's an *exact* one.

 - use newton-raphson to iterate closer. It should be a much faster way to 
   find the rough area for the entry we're searching for than binary 
   search. Two or three iterations should get us there, easily.

 - do a linear search once you're close enough.

Here's a stupid patch that does that. It's biggest weakness is that it 
only does a single iteration of newton-raphson. It should probably do at 
least one more iteration. I bet that you'd get so close that you find it 
really quickly if you did that. As it is, it doesn't seem to be any slower 
than the binary search..

And the nice thing is that I think that in large packs the "evenly 
distributed" should be *more*true* than in small packs, so this should 
scale up very nicely, and I'm hoping that it would get much better cache 
behaviour (because we wouldn't bounce around in the index file too much). 
I wouldn't be surprised if we basically hit it on the first try if we did 
two or three iterations of newton-raphson.

Comments? Does anybody want to take this and run with it?

(No guarantees that this really can ever beat binary search, but somebody 
might find this interesting. And I think the potential is there, but I 
think you do need to do at *least* two iterations).

		Linus
---
 sha1_file.c |   79 +++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 9c26038..fc4dbc7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1543,29 +1543,78 @@ int nth_packed_object_sha1(const struct packed_git *p, uint32_t n,
 	return 0;
 }
 
-off_t find_pack_entry_one(const unsigned char *sha1,
-				  struct packed_git *p)
+struct index_entry {
+	uint32_t nb_offset;	/* pack-file offset in network byte order */
+	unsigned char sha1[20];	/* SHA1 of the object */
+};
+
+static off_t pack_search_backward(const struct index_entry *index, uint32_t guess, const unsigned char *sha1)
 {
-	const uint32_t *level1_ofs = p->index_data;
-	int hi = ntohl(level1_ofs[*sha1]);
-	int lo = ((*sha1 == 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
-	const unsigned char *index = p->index_data;
+	int count = 1;
+	while (guess) {
+		int cmp;
 
-	index += 4 * 256;
+		guess--;
+		index--;
+		cmp = hashcmp(index->sha1, sha1);
+		if (!cmp)
+			return ntohl(index->nb_offset);
+		if (cmp < 0)
+			break;
+		count++;
+	}
+	return 0;
+}
 
-	do {
-		int mi = (lo + hi) / 2;
-		int cmp = hashcmp(index + 24 * mi + 4, sha1);
+static off_t pack_search_forward(const struct index_entry *index, uint32_t guess, uint32_t max, const unsigned char *sha1)
+{
+	int count = 1;
+	while (++guess < max) {
+		int cmp;
+
+		index++;
+		cmp = hashcmp(index->sha1, sha1);
 		if (!cmp)
-			return ntohl(*((uint32_t *)((char *)index + (24 * mi))));
+			return ntohl(index->nb_offset);
 		if (cmp > 0)
-			hi = mi;
-		else
-			lo = mi+1;
-	} while (lo < hi);
+			break;
+		count++;
+	}
 	return 0;
 }
 
+off_t find_pack_entry_one(const unsigned char *sha1,
+				  struct packed_git *p)
+{
+	const struct index_entry *index;
+	const uint32_t *level1_ofs = p->index_data;
+	uint32_t min, max, first;
+	uint32_t hash_val;
+	uint32_t guess;
+	int cmp;
+
+	first = *sha1;
+	min = first ? ntohl(level1_ofs[first - 1]) : 0;
+	max = ntohl(level1_ofs[first]);
+
+	hash_val = (sha1[1] << 24) |
+		   (sha1[2] << 16) |
+		   (sha1[3] << 8) |
+		   (sha1[4]);
+	guess = ((uint64_t)(max - min) * hash_val) >> 32;
+	guess += min;
+
+	index = (const struct index_entry *)((char *) p->index_data + 4 * 256);
+	index += guess;
+
+	cmp = hashcmp(index->sha1, sha1);
+	if (!cmp)
+		return ntohl(index->nb_offset);
+	if (cmp > 0)
+		return pack_search_backward(index, guess, sha1);
+	return pack_search_forward(index, guess, max, sha1);
+}
+
 static int matches_pack_name(struct packed_git *p, const char *ig)
 {
 	const char *last_c, *c;
