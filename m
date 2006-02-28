From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] diff-delta: bound hash list length to avoid O(m*n) behavior
Date: Mon, 27 Feb 2006 23:09:55 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602272110320.25336@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 05:10:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDwBb-00015q-8l
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 05:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbWB1EJ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 23:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbWB1EJ5
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 23:09:57 -0500
Received: from relais.videotron.ca ([24.201.245.36]:29245 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751815AbWB1EJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 23:09:56 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IVD00HWXQ8JKGC0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 27 Feb 2006 23:09:55 -0500 (EST)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16911>

The diff-delta code can exhibit O(m*n) behavior with some patological 
data set where most hash entries end up in the same hash bucket.

The latest code rework reduced the block size making it particularly 
vulnerable to this issue, but the issue was always there and can be 
triggered regardless of the block size.

This patch does two things:

1) the hashing has been reworked to offer a better distribution to 
   atenuate the problem a bit, and

2) a limit is imposed to the number of entries that can exist in the 
   same hash bucket.

Because of the above the code is a bit more expensive on average, but 
the problematic samples used to diagnoze the issue are now orders of 
magnitude less expensive to process with only a slight loss in 
compression.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

For example, Carl Baldwin provided me with a couple 20MB files, and 
deltifying one against another one with test-delta takes around 
SEVENTEEN MINUTES for only one delta on my P4 @ 3GHz when using the 
original adler32 version with 16 byte blocks.  With the latest delta 
code in the pu branch it simply takes forever (I interrupted it after 20 
minutes of processing).  now imagine using git-repack -a with a window 
of 10. With this patch on top of the small block patch (still in the pu 
branch) this time dropped to only 10 seconds.  And the resulting delta 
is still smaller than the 16 byte adler32 based version:

blob 02220dae8cd219916ce52a12cda67322659e0e57 ->
blob af8f99dd11ca288f4e4a08f2626af2de8b3ecfd2
size (21187748 -> 19424744)
delta size (16 byte blocks): 5238542 in 16m55
delta size (3 byte blocks): [interrupted after 20 minutes]
delta size (3 byte blocks + this patch): 4910988 in 9.69 secs

Other data points from the Linux kernel repository:

blob 9af06ba723df75fed49f7ccae5b6c9c34bc5115f ->
blob dfc9cd58dc065d17030d875d3fea6e7862ede143
size (491102 -> 496045)
delta size (16 byte blocks): 248899 in less than 0.1 sec
delta size (3 byte blocks): 136000 in 11.8 secs
delta size (3 byte blocks + this patch): 171688 in 0.79 sec

blob 4917ec509720a42846d513addc11cbd25e0e3c4f ->
blob dfc9cd58dc065d17030d875d3fea6e7862ede143
size (495831 -> 496045)
delta size (16 byte blocks): 226218 in less than 0.1 sec
delta size (3 byte blocks): 120948 in 11.7 secs
delta size (3 byte blocks + this patch): 157135 in 0.77 sec


 diff-delta.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 56 insertions(+), 13 deletions(-)

1682f4b1b2899288d7761844a4cfd02772c464d1
diff --git a/diff-delta.c b/diff-delta.c
index 27f83a0..bb07926 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -30,19 +30,20 @@ struct index {
 
 static struct index ** delta_index(const unsigned char *buf,
 				   unsigned long bufsize,
+				   unsigned long trg_bufsize,
 				   unsigned int *hash_shift)
 {
 	unsigned long hsize;
-	unsigned int hshift, i;
+	unsigned int i, hshift, hlimit, *hash_count;
 	const unsigned char *data;
 	struct index *entry, **hash;
 	void *mem;
 
 	/* determine index hash size */
 	hsize = bufsize / 4;
-	for (i = 8; (1 << i) < hsize && i < 16; i++);
+	for (i = 8; (1 << i) < hsize && i < 24; i += 2);
 	hsize = 1 << i;
-	hshift = i - 8;
+	hshift = (i - 8) / 2;
 	*hash_shift = hshift;
 
 	/* allocate lookup index */
@@ -53,15 +54,59 @@ static struct index ** delta_index(const
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
 	data = buf + bufsize - 2;
 	while (data > buf) {
 		entry->ptr = --data;
-		i = data[0] ^ data[1] ^ (data[2] << hshift);
+		i = data[0] ^ ((data[1] ^ (data[2] << hshift)) << hshift);
 		entry->next = hash[i];
 		hash[i] = entry++;
+		hash_count[i]++;
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
+	if (hlimit < 16)
+		hlimit = 16;
+
+	/*
+	 * Now make sure none of the hash buckets has more entries than
+	 * we're willing to test.  Otherwise we short-circuit the entry
+	 * list uniformly to still preserve a good repartition across
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
 
@@ -85,7 +130,7 @@ void *diff_delta(void *from_buf, unsigne
 
 	if (!from_size || !to_size)
 		return NULL;
-	hash = delta_index(from_buf, from_size, &hash_shift);
+	hash = delta_index(from_buf, from_size, to_size, &hash_shift);
 	if (!hash)
 		return NULL;
 
@@ -126,8 +171,8 @@ void *diff_delta(void *from_buf, unsigne
 
 	while (data < top) {
 		unsigned int moff = 0, msize = 0;
-		if (data + 2 < top) {
-			i = data[0] ^ data[1] ^ (data[2] << hash_shift);
+		if (data + 3 <= top) {
+			i = data[0] ^ ((data[1] ^ (data[2] << hash_shift)) << hash_shift);
 			for (entry = hash[i]; entry; entry = entry->next) {
 				const unsigned char *ref = entry->ptr;
 				const unsigned char *src = data;
@@ -138,11 +183,9 @@ void *diff_delta(void *from_buf, unsigne
 					ref_size = 0x10000;
 				if (ref_size <= msize)
 					break;
-				while (ref_size && *src++ == *ref) {
-					ref++;
-					ref_size--;
-				}
-				ref_size = ref - entry->ptr;
+				if (*ref != *src)
+					continue;
+				while (ref_size-- && *++src == *++ref);
 				if (msize < ref - entry->ptr) {
 					/* this is our best match so far */
 					msize = ref - entry->ptr;
-- 
1.2.3.g8fcf1-dirty
