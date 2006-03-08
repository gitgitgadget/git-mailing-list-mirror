From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] diff-delta: bound hash list length to avoid O(m*n) behavior
Date: Wed, 08 Mar 2006 14:32:50 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0603081319220.1859@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 08 20:34:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FH4P1-0007RA-Gy
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 20:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWCHTcw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 14:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWCHTcw
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 14:32:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:23729 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932124AbWCHTcv
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Mar 2006 14:32:51 -0500
Received: from xanadu.home ([66.131.142.204]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IVT00JHYQAQ7830@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 08 Mar 2006 14:32:51 -0500 (EST)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17383>


The diff-delta code can exhibit O(m*n) behavior with some patological
data set where most hash entries end up in the same hash bucket.

To prevent this, a limit is imposed to the number of entries that can 
exist in the same hash bucket.

Because of the above the code is a tiny bit more expensive on average, 
even if some small optimizations were added as well to atenuate the 
overhead. But the problematic samples used to diagnoze the issue are now 
orders of magnitude less expensive to process with only a slight loss in 
compression.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

For example, Carl Baldwin provided me with a couple 20MB files, and 
deltifying one against another one with test-delta takes around 
TEN MINUTES for only one delta on my P4 @ 3GHz.

Nnow imagine using git-repack -a with a default window
of 10 ... 

With this patch the test-delta time dropped to only 9 seconds.  And the 
resulting delta, once compressed, is about 2% larger.

diff --git a/diff-delta.c b/diff-delta.c
index 2ed5984..aaee7be 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -40,17 +40,18 @@ struct index {
 
 static struct index ** delta_index(const unsigned char *buf,
 				   unsigned long bufsize,
+				   unsigned long trg_bufsize,
 				   unsigned int *hash_shift)
 {
-	unsigned int hsize, hshift, entries, blksize, i;
+	unsigned int i, hsize, hshift, hlimit, entries, *hash_count;
 	const unsigned char *data;
 	struct index *entry, **hash;
 	void *mem;
 
 	/* determine index hash size */
-	entries = (bufsize + BLK_SIZE - 1) / BLK_SIZE;
+	entries = bufsize  / BLK_SIZE;
 	hsize = entries / 4;
-	for (i = 4; (1 << i) < hsize && i < 16; i++);
+	for (i = 4; (1 << i) < hsize && i < 31; i++);
 	hsize = 1 << i;
 	hshift = 32 - i;
 	*hash_shift = hshift;
@@ -63,20 +64,62 @@ static struct index ** delta_index(const
 	entry = mem + hsize * sizeof(*hash);
 	memset(hash, 0, hsize * sizeof(*hash));
 
-	/* then populate it */
+	/* allocate an array to count hash entries */
+	hash_count = calloc(hsize, sizeof(*hash_count));
+	if (!hash_count) {
+		free(hash);
+		return NULL;
+	}
+
+	/* then populate the index */
 	data = buf + entries * BLK_SIZE - BLK_SIZE;
-	blksize = bufsize - (data - buf);
 	while (data >= buf) {
-		unsigned int val = adler32(0, data, blksize);
+		unsigned int val = adler32(0, data, BLK_SIZE);
 		i = HASH(val, hshift);
 		entry->ptr = data;
 		entry->val = val;
 		entry->next = hash[i];
 		hash[i] = entry++;
-		blksize = BLK_SIZE;
+		hash_count[i]++;
 		data -= BLK_SIZE;
  	}
 
+	/*
+	 * Determine a limit on the number of entries in the same hash
+	 * bucket.  This guard us against patological data sets causing
+	 * really bad hash distribution with most entries in the same hash
+	 * bucket that would bring us to O(m*n) computing costs (m and n
+	 * corresponding to reference and target buffer sizes).
+	 *
+	 * The more the target buffer is large, the more it is important to
+	 * have small entry lists for each hash buckets.  With such a limit
+	 * the cost is bounded to something more like O(m+n).
+	 */
+	hlimit = (1 << 26) / trg_bufsize;
+	if (hlimit < 4*BLK_SIZE)
+		hlimit = 4*BLK_SIZE;
+
+	/*
+	 * Now make sure none of the hash buckets has more entries than
+	 * we're willing to test.  Otherwise we cull the entry list
+	 * uniformly to still preserve a good repartition across
+	 * the reference buffer.
+	 */
+	for (i = 0; i < hsize; i++) {
+		if (hash_count[i] < hlimit)
+			continue;
+		entry = hash[i];
+		do {
+			struct index *keep = entry;
+			int skip = hash_count[i] / hlimit / 2;
+			do {
+				entry = entry->next;
+			} while(--skip && entry);
+			keep->next = entry;
+		} while(entry);
+	}
+	free(hash_count);
+
 	return hash;
 }
 
@@ -100,7 +143,7 @@ void *diff_delta(void *from_buf, unsigne
 
 	if (!from_size || !to_size)
 		return NULL;
-	hash = delta_index(from_buf, from_size, &hash_shift);
+	hash = delta_index(from_buf, from_size, to_size, &hash_shift);
 	if (!hash)
 		return NULL;
 
@@ -141,29 +184,27 @@ void *diff_delta(void *from_buf, unsigne
 
 	while (data < top) {
 		unsigned int moff = 0, msize = 0;
-		unsigned int blksize = MIN(top - data, BLK_SIZE);
-		unsigned int val = adler32(0, data, blksize);
-		i = HASH(val, hash_shift);
-		for (entry = hash[i]; entry; entry = entry->next) {
-			const unsigned char *ref = entry->ptr;
-			const unsigned char *src = data;
-			unsigned int ref_size = ref_top - ref;
-			if (entry->val != val)
-				continue;
-			if (ref_size > top - src)
-				ref_size = top - src;
-			while (ref_size && *src++ == *ref) {
-				ref++;
-				ref_size--;
-			}
-			ref_size = ref - entry->ptr;
-			if (ref_size > msize) {
-				/* this is our best match so far */
-				moff = entry->ptr - ref_data;
-				msize = ref_size;
-				if (msize >= 0x10000) {
-					msize = 0x10000;
+		if (data + BLK_SIZE <= top) {
+			unsigned int val = adler32(0, data, BLK_SIZE);
+			i = HASH(val, hash_shift);
+			for (entry = hash[i]; entry; entry = entry->next) {
+				const unsigned char *ref = entry->ptr;
+				const unsigned char *src = data;
+				unsigned int ref_size = ref_top - ref;
+				if (entry->val != val)
+					continue;
+				if (ref_size > top - src)
+					ref_size = top - src;
+				if (ref_size > 0x10000)
+					ref_size = 0x10000;
+				if (ref_size <= msize)
 					break;
+				while (ref_size-- && *src++ == *ref)
+					ref++;
+				if (msize < ref - entry->ptr) {
+					/* this is our best match so far */
+					msize = ref - entry->ptr;
+					moff = entry->ptr - ref_data;
 				}
 			}
 		}
