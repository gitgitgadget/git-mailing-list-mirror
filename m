From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] diff-delta: produce optimal pack data
Date: Tue, 21 Feb 2006 20:45:36 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 02:45:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBj4W-0002L6-7p
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 02:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWBVBpi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 20:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbWBVBph
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 20:45:37 -0500
Received: from relais.videotron.ca ([24.201.245.36]:43998 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932497AbWBVBph
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 20:45:37 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV2003QZFK0WY30@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 21 Feb 2006 20:45:36 -0500 (EST)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16582>


Indexing based on adler32 has a match precision based on the block size 
(currently 16).  Lowering the block size would produce smaller deltas 
but the indexing memory and computing cost increases significantly.

For optimal delta result the indexing block size should be 3 with an 
increment of 1 (instead of 16 and 16).  With such low params the adler32 
becomes a clear overhead increasing the time for git-repack by a factor 
of 3.  And with such small blocks the adler 32 is not very useful as the 
whole of the block bits can be used directly.

This patch replaces the adler32 with an open coded index value based on 
3 characters directly.  This gives sufficient bits for hashing and 
allows for optimal delta with reasonable CPU cycles.

The resulting packs are 6% smaller on average.  The increase in CPU time 
is about 25%.  But this cost is now hidden by the delta reuse patch 
while the saving on data transfers is always there.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

 diff-delta.c |   77 +++++++++++++++++++++++-----------------------------------
 1 files changed, 30 insertions(+), 47 deletions(-)

54aa50fb403981a9292453b76d894a79da9698de
diff --git a/diff-delta.c b/diff-delta.c
index 2ed5984..27f83a0 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -20,21 +20,11 @@
 
 #include <stdlib.h>
 #include <string.h>
-#include <zlib.h>
 #include "delta.h"
 
 
-/* block size: min = 16, max = 64k, power of 2 */
-#define BLK_SIZE 16
-
-#define MIN(a, b) ((a) < (b) ? (a) : (b))
-
-#define GR_PRIME 0x9e370001
-#define HASH(v, shift) (((unsigned int)(v) * GR_PRIME) >> (shift))
-
 struct index {
 	const unsigned char *ptr;
-	unsigned int val;
 	struct index *next;
 };
 
@@ -42,21 +32,21 @@ static struct index ** delta_index(const
 				   unsigned long bufsize,
 				   unsigned int *hash_shift)
 {
-	unsigned int hsize, hshift, entries, blksize, i;
+	unsigned long hsize;
+	unsigned int hshift, i;
 	const unsigned char *data;
 	struct index *entry, **hash;
 	void *mem;
 
 	/* determine index hash size */
-	entries = (bufsize + BLK_SIZE - 1) / BLK_SIZE;
-	hsize = entries / 4;
-	for (i = 4; (1 << i) < hsize && i < 16; i++);
+	hsize = bufsize / 4;
+	for (i = 8; (1 << i) < hsize && i < 16; i++);
 	hsize = 1 << i;
-	hshift = 32 - i;
+	hshift = i - 8;
 	*hash_shift = hshift;
 
 	/* allocate lookup index */
-	mem = malloc(hsize * sizeof(*hash) + entries * sizeof(*entry));
+	mem = malloc(hsize * sizeof(*hash) + bufsize * sizeof(*entry));
 	if (!mem)
 		return NULL;
 	hash = mem;
@@ -64,17 +54,12 @@ static struct index ** delta_index(const
 	memset(hash, 0, hsize * sizeof(*hash));
 
 	/* then populate it */
-	data = buf + entries * BLK_SIZE - BLK_SIZE;
-	blksize = bufsize - (data - buf);
-	while (data >= buf) {
-		unsigned int val = adler32(0, data, blksize);
-		i = HASH(val, hshift);
-		entry->ptr = data;
-		entry->val = val;
+	data = buf + bufsize - 2;
+	while (data > buf) {
+		entry->ptr = --data;
+		i = data[0] ^ data[1] ^ (data[2] << hshift);
 		entry->next = hash[i];
 		hash[i] = entry++;
-		blksize = BLK_SIZE;
-		data -= BLK_SIZE;
  	}
 
 	return hash;
@@ -141,29 +126,27 @@ void *diff_delta(void *from_buf, unsigne
 
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
+		if (data + 2 < top) {
+			i = data[0] ^ data[1] ^ (data[2] << hash_shift);
+			for (entry = hash[i]; entry; entry = entry->next) {
+				const unsigned char *ref = entry->ptr;
+				const unsigned char *src = data;
+				unsigned int ref_size = ref_top - ref;
+				if (ref_size > top - src)
+					ref_size = top - src;
+				if (ref_size > 0x10000)
+					ref_size = 0x10000;
+				if (ref_size <= msize)
 					break;
+				while (ref_size && *src++ == *ref) {
+					ref++;
+					ref_size--;
+				}
+				ref_size = ref - entry->ptr;
+				if (msize < ref - entry->ptr) {
+					/* this is our best match so far */
+					msize = ref - entry->ptr;
+					moff = entry->ptr - ref_data;
 				}
 			}
 		}
-- 
1.2.2.g6643-dirty
