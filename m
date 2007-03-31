From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Packing large repositories
Date: Sat, 31 Mar 2007 14:20:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703311408560.6730@woody.linux-foundation.org>
References: <56b7f5510703280005o7998d65pcbcd4636b46d8d23@mail.gmail.com>
 <Pine.LNX.4.64.0703280943450.6730@woody.linux-foundation.org>
 <20070330062324.GU13247@spearce.org> <alpine.LFD.0.83.0703300851270.3041@xanadu.home>
 <78639417-ACDB-484F-85BB-EC0AF694949A@adacore.com>
 <Pine.LNX.4.64.0703311033290.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dana How <danahow@gmail.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 23:21:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXl0e-0001zi-KC
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 23:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbXCaVVN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 17:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752431AbXCaVVN
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 17:21:13 -0400
Received: from smtp.osdl.org ([65.172.181.24]:36623 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752433AbXCaVVM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 17:21:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2VLKood019683
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 31 Mar 2007 14:20:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2VLKnsI030363;
	Sat, 31 Mar 2007 14:20:49 -0700
In-Reply-To: <Pine.LNX.4.64.0703311033290.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.965 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43570>



On Sat, 31 Mar 2007, Linus Torvalds wrote:
> 
> Here's a stupid patch that does that. It's biggest weakness is that it 
> only does a single iteration of newton-raphson. It should probably do at 
> least one more iteration. I bet that you'd get so close that you find it 
> really quickly if you did that. As it is, it doesn't seem to be any slower 
> than the binary search..

Ok, here's a slightly updated patch that does a few more iterations..

It actually seems to outperform the old binary search for me, although 
quite frankly, my only test was the eclipse git thing, and doing a

	time git log > /dev/null

which isn't exactly scientific or necessarily even very interesting. For 
a run of five, I got:

Before:
	real    0m2.940s
	real    0m2.277s
	real    0m2.220s
	real    0m2.377s
	real    0m2.223s

After:
	real    0m2.903s
	real    0m2.217s
	real    0m2.269s
	real    0m2.148s
	real    0m2.215s

ie it's really pretty much in the noise, but the best-of-five actually 
comes with this Newton-Raphson + linear search thing rather than with the 
binary search.

Anyway, it's *so* much in the noise that I doubt that object lookup really 
is a very noticeable cost for this load (and perhaps it never is). But it 
was interesting to see that at least the theory seems sound.

The patch has some commented-out statistics code (ie "hit it in one" vs 
reporting how many steps forwards/backwards it needed to look.

Not really meant to be applied, but it was interesting to play with 
this. NOTE! I don't think the math is really strictly correct (ie the 
scaling inside the loop), but it's "close enough" to not matter, and this 
really was meant to be an request-for-discussion.

		Linus

---
diff --git a/sha1_file.c b/sha1_file.c
index 9c26038..b1643ea 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1543,27 +1543,134 @@ int nth_packed_object_sha1(const struct packed_git *p, uint32_t n,
 	return 0;
 }
 
+struct index_entry {
+	uint32_t nb_offset;	/* pack-file offset in network byte order */
+	unsigned char sha1[20];	/* SHA1 of the object */
+};
+
+static off_t pack_search_backward(const struct index_entry *index, uint32_t guess, const unsigned char *sha1)
+{
+	int count = 1;
+	while (guess) {
+		int cmp;
+
+		guess--;
+		index--;
+		cmp = hashcmp(index->sha1, sha1);
+		if (!cmp) {
+//			error("  backward: %d", count);
+			return ntohl(index->nb_offset);
+		}
+		if (cmp < 0)
+			break;
+		count++;
+	}
+	return 0;
+}
+
+static off_t pack_search_forward(const struct index_entry *index, uint32_t guess, uint32_t max, const unsigned char *sha1)
+{
+	int count = 1;
+	while (++guess < max) {
+		int cmp;
+
+		index++;
+		cmp = hashcmp(index->sha1, sha1);
+		if (!cmp) {
+//			error("  forward: %d", count);
+			return ntohl(index->nb_offset);
+		}
+		if (cmp > 0)
+			break;
+		count++;
+	}
+	return 0;
+}
+
+/*
+ * The "fraction" thing is a 32-bit number that is seen as a
+ * fraction of 1<<32. Ie 0x80000000 means "half-way". We use
+ * this as a way to do simple comparisons of 32-bit partial
+ * SHA1 fragments, and to estimate how far off we are from
+ * the value we wish to see.
+ */
+static inline uint32_t get_fraction(const unsigned char *p)
+{
+	return (p[0] << 24) | (p[1] << 16) | (p[2] << 8) | p[3];
+}
+
+static inline int update_guess(unsigned int nr, uint32_t fraction)
+{
+	return (0x80000000 + nr * (uint64_t) fraction) >> 32;
+}
+
 off_t find_pack_entry_one(const unsigned char *sha1,
 				  struct packed_git *p)
 {
+	int i;
+	const struct index_entry *index;
 	const uint32_t *level1_ofs = p->index_data;
-	int hi = ntohl(level1_ofs[*sha1]);
-	int lo = ((*sha1 == 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
-	const unsigned char *index = p->index_data;
+	uint32_t min, max, first;
+	uint32_t hash_val, guess;
+	int cmp;
 
-	index += 4 * 256;
+	/*
+	 * Get the initial range using the first 8 bits of
+	 * the SHA1 and the 8-bit fan-out in the index
+	 */
+	first = *sha1;
+	min = first ? ntohl(level1_ofs[first - 1]) : 0;
+	max = ntohl(level1_ofs[first]);
+	if (min == max)
+		return 0;
 
-	do {
-		int mi = (lo + hi) / 2;
-		int cmp = hashcmp(index + 24 * mi + 4, sha1);
-		if (!cmp)
-			return ntohl(*((uint32_t *)((char *)index + (24 * mi))));
-		if (cmp > 0)
-			hi = mi;
+	/*
+	 * Initial guess using the next 32 bits of the SHA1
+	 * (using "sha1+1" because the first byte of the SHA1
+	 * is now known to be irrelevant and will always match,
+	 * thanks to the index fan-out)
+	 */
+	hash_val = get_fraction(sha1+1);
+	guess = min + update_guess(max - min, hash_val);
+
+	/*
+	 * Look up that entry in the index file...
+	 */
+	index = (const struct index_entry *)((char *) p->index_data + 4 * 256);
+	index += guess;
+
+	/*
+	 * ..and update the guess with a correction based on how
+	 * close the guessed entry's hash value was.
+	 */
+	for (i = 0; i < 3; i++) {
+		uint32_t guess_hash_val = get_fraction(index->sha1+1);
+		int correction;
+
+		if (guess_hash_val == hash_val)
+			break;
+		if (guess_hash_val < hash_val)
+			correction = update_guess(max - guess, hash_val - guess_hash_val);
 		else
-			lo = mi+1;
-	} while (lo < hi);
-	return 0;
+			correction = -update_guess(guess - min, guess_hash_val - hash_val);
+		if (!correction)
+			break;
+		guess += correction;
+		index += correction;
+	}
+
+	/*
+	 * ..and we should now be close enough that now we'll just use a
+	 * linear search from the updated guess.
+	 */
+	cmp = hashcmp(index->sha1, sha1);
+	if (!cmp) {
+//		error("hit it in one!");
+		return ntohl(index->nb_offset);
+	}
+	if (cmp > 0)
+		return pack_search_backward(index, guess, sha1);
+	return pack_search_forward(index, guess, max, sha1);
 }
 
 static int matches_pack_name(struct packed_git *p, const char *ig)
