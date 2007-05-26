From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] improve delta long block matching with big files
Date: Fri, 25 May 2007 21:38:58 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705252119200.3366@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 26 03:39:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrlFQ-0008BE-Ei
	for gcvg-git@gmane.org; Sat, 26 May 2007 03:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbXEZBjI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 21:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752787AbXEZBjI
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 21:39:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21517 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbXEZBjH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 21:39:07 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIM00GZ0KKZYYD0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 25 May 2007 21:39:00 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48442>

Martin Koegler noted that create_delta() performs a new hash lookup
after every block copy encoding which are currently limited to 64KB.

In case of larger identical blocks, the next hash lookup would normally
point to the next 64KB block in the reference buffer and multiple block
copy operations will be consecutively encoded.

It is however possible that the reference buffer be sparsely indexed if
hash buckets have been trimmed down in create_delta_index() when hashing
of the reference buffer isn't well balanced.  In that case the hash
lookup following a block copy might fail to match anything and the fact
that the reference buffer still matches beyond the previous 64KB block
will be missed.

Let's rework the code so that buffer comparison isn't bounded to 64KB
anymore.  The match size should be as large as possible up front and
only then should multiple block copy be encoded to cover it all.
Also, fewer hash lookups will be performed in the end.

According to Martin, this patch should reduce his 92MB pack down to 75MB
with the dataset he has.

Tests performed on the Linux kernel repo show a slightly smaller pack and
a slightly faster repack.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/diff-delta.c b/diff-delta.c
index 9f998d0..09e6bcd 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -246,7 +246,7 @@ create_delta(const struct delta_index *index,
 	     const void *trg_buf, unsigned long trg_size,
 	     unsigned long *delta_size, unsigned long max_size)
 {
-	unsigned int i, outpos, outsize, val;
+	unsigned int i, outpos, outsize, moff, msize, val;
 	int inscnt;
 	const unsigned char *ref_data, *ref_top, *data, *top;
 	unsigned char *out;
@@ -291,30 +291,33 @@ create_delta(const struct delta_index *index,
 	}
 	inscnt = i;
 
+	moff = 0;
+	msize = 0;
 	while (data < top) {
-		unsigned int moff = 0, msize = 0;
-		struct index_entry *entry;
-		val ^= U[data[-RABIN_WINDOW]];
-		val = ((val << 8) | *data) ^ T[val >> RABIN_SHIFT];
-		i = val & index->hash_mask;
-		for (entry = index->hash[i]; entry; entry = entry->next) {
-			const unsigned char *ref = entry->ptr;
-			const unsigned char *src = data;
-			unsigned int ref_size = ref_top - ref;
-			if (entry->val != val)
-				continue;
-			if (ref_size > top - src)
-				ref_size = top - src;
-			if (ref_size > 0x10000)
-				ref_size = 0x10000;
-			if (ref_size <= msize)
-				break;
-			while (ref_size-- && *src++ == *ref)
-				ref++;
-			if (msize < ref - entry->ptr) {
-				/* this is our best match so far */
-				msize = ref - entry->ptr;
-				moff = entry->ptr - ref_data;
+		if (msize < 4096) {
+			struct index_entry *entry;
+			val ^= U[data[-RABIN_WINDOW]];
+			val = ((val << 8) | *data) ^ T[val >> RABIN_SHIFT];
+			i = val & index->hash_mask;
+			for (entry = index->hash[i]; entry; entry = entry->next) {
+				const unsigned char *ref = entry->ptr;
+				const unsigned char *src = data;
+				unsigned int ref_size = ref_top - ref;
+				if (entry->val != val)
+					continue;
+				if (ref_size > top - src)
+					ref_size = top - src;
+				if (ref_size <= msize)
+					break;
+				while (ref_size-- && *src++ == *ref)
+					ref++;
+				if (msize < ref - entry->ptr) {
+					/* this is our best match so far */
+					msize = ref - entry->ptr;
+					moff = entry->ptr - ref_data;
+					if (msize >= 4096) /* good enough */
+						break;
+				}
 			}
 		}
 
@@ -327,27 +330,13 @@ create_delta(const struct delta_index *index,
 				out[outpos - inscnt - 1] = inscnt;
 				inscnt = 0;
 			}
+			msize = 0;
 		} else {
+			unsigned int left;
 			unsigned char *op;
 
-			if (msize >= RABIN_WINDOW) {
-				const unsigned char *sk;
-				sk = data + msize - RABIN_WINDOW;
-				val = 0;
-				for (i = 0; i < RABIN_WINDOW; i++)
-					val = ((val << 8) | *sk++) ^ T[val >> RABIN_SHIFT];
-			} else {
-				const unsigned char *sk = data + 1;
-				for (i = 1; i < msize; i++) {
-					val ^= U[sk[-RABIN_WINDOW]];
-					val = ((val << 8) | *sk++) ^ T[val >> RABIN_SHIFT];
-				}
-			}
-
 			if (inscnt) {
 				while (moff && ref_data[moff-1] == data[-1]) {
-					if (msize == 0x10000)
-						break;
 					/* we can match one byte back */
 					msize++;
 					moff--;
@@ -363,23 +352,40 @@ create_delta(const struct delta_index *index,
 				inscnt = 0;
 			}
 
-			data += msize;
+			/* A copy op is currently limited to 64KB (pack v2) */
+			left = (msize < 0x10000) ? 0 : (msize - 0x10000);
+			msize -= left;
+
 			op = out + outpos++;
 			i = 0x80;
 
-			if (moff & 0xff) { out[outpos++] = moff; i |= 0x01; }
-			moff >>= 8;
-			if (moff & 0xff) { out[outpos++] = moff; i |= 0x02; }
-			moff >>= 8;
-			if (moff & 0xff) { out[outpos++] = moff; i |= 0x04; }
-			moff >>= 8;
-			if (moff & 0xff) { out[outpos++] = moff; i |= 0x08; }
+			if (moff & 0x000000ff)
+				out[outpos++] = moff >> 0,  i |= 0x01;
+			if (moff & 0x0000ff00)
+				out[outpos++] = moff >> 8,  i |= 0x02;
+			if (moff & 0x00ff0000)
+				out[outpos++] = moff >> 16, i |= 0x04;
+			if (moff & 0xff000000)
+				out[outpos++] = moff >> 24, i |= 0x08;
 
-			if (msize & 0xff) { out[outpos++] = msize; i |= 0x10; }
-			msize >>= 8;
-			if (msize & 0xff) { out[outpos++] = msize; i |= 0x20; }
+			if (msize & 0x00ff)
+				out[outpos++] = msize >> 0, i |= 0x10;
+			if (msize & 0xff00)
+				out[outpos++] = msize >> 8, i |= 0x20;
 
 			*op = i;
+
+			data += msize;
+			moff += msize;
+			msize = left;
+
+			if (msize < 4096) {
+				int j;
+				val = 0;
+				for (j = -RABIN_WINDOW; j < 0; j++)
+					val = ((val << 8) | data[j])
+					      ^ T[val >> RABIN_SHIFT];
+			}
 		}
 
 		if (outpos >= outsize - MAX_OP_SIZE) {
