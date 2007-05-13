From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: Re: [RFC] Optimize diff-delta.c
Date: Sun, 13 May 2007 22:50:13 +0200
Message-ID: <1179089413753-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun May 13 22:50:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnL1L-0004VJ-Eo
	for gcvg-git@gmane.org; Sun, 13 May 2007 22:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406AbXEMUuT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 16:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755481AbXEMUuT
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 16:50:19 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:33258 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755406AbXEMUuR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 16:50:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 2401E7A95F25;
	Sun, 13 May 2007 22:50:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lyE9WP23asNi; Sun, 13 May 2007 22:50:13 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id E7DF968021C5; Sun, 13 May 2007 22:50:13 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47180>

---
On Fri, 04 May 2007, Nicolas Pitre wrote:
> On Fri, 4 May 2007, Martin Koegler wrote:
> > On 2007-05-01 16:05:24, Nicolas Pitre wrote:
> > In the long term, I think, that the delta generation code needs to get
> > tunable.
> 
> No.  It should be self-tunable certainly, but there are way too many 
> config options already, and another one for the inner working of the 
> delta algorithm would be a bit too esoteric for most users and they 
> won't get advantage of it.  This thing really has to self tune itself.

I would like that too, but that will probably not the case for
everybody. 

Why does git has options to control the zlib compression?  

Why are patches like "Custom compression levels for objects and packs"
(http://www.spinics.net/lists/git/msg30244.html) sent to the mailing
list?

> > > > I tried to speed up the delta generation by searching for a common 
> > > > prefix, as my blobs are mostly append only. I tested it with about 
> > > > less than 1000 big blobs. The time for finding the deltas decreased 
> > > > from 17 to 14 minutes cpu time.
> > > 
> > > I'm surprised that your patch makes so much of a difference.  Normally 
> > > the first window should always match in the case you're trying to 
> > > optimize and the current code should already perform more or less the 
> > > same as your common prefix match does.
> > 
> > A block is limited to 64k. If the file has some hundred MBs, it has to
> > match many blocks.
> 
> Only if the first match is smaller than 64K.  If the first match is 64K 
> in size then the rest of the file is not considered at all.

If I read the code correctly, the currect code does a new hash table
search after writing a block.

> > My patch can process everything except the few last thousand lines by
> > doing a memcmp.
> > 
> > Additionally, nearly every line starts with the same, longer than 16
> > byte prefix. So its likely, that many blocks map to the same hash
> > value.
> 
> The hash index only remembers the lowest of consecutive identical blocks 
> so repeated blocks are indexed only with the first one.  If however you 
> happen to have many identical blocks interlaced between other blocks 
> then there is not much that can be done.  What the code does in that 
> case is to trim those hash buckets that gets too large by keeping only a 
> few entries across the reference buffer to avoid a O(n^2) behavior. But 
> that happens only when your line beginnings are located on the same 
> block boundary (but with a block size of 16 this is rather likely in the 
> presence of lots of lines I suppose).
> 
> I'll be very interested in the results you get with my suggested patch.

As my original patch is not considering other and possibly better
matches, I rewrote the patch. The new version matches block of
unlimited length (stopping after finding a match >=64kB). If the block
it bigger than 64kB, it writes block of 64kB in a loop.

The patch recomputes the hash of 16 bytes after writing a block, as I
haven't had time to correct the hash update code for blocks < 16
bytes. (By the way, is this code path necessary?)

I did some tests on differenent machines:

Repacking a test repository with big blobs:

- original version:
   Total 6452 (delta 4582), reused 1522 (delta 0)
   11752.26user 4256.21system 4:26:52elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
   0inputs+0outputs (576major+1042499851minor)pagefaults 0swaps
   =>92 MB pack size
- your patch (stop at 4096 bytes block size):
   Total 6452 (delta 4582), reused 1522 (delta 0)
   11587.41user 4064.73system 4:20:54elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
   0inputs+0outputs (0major+1042500427minor)pagefaults 0swaps
   =>92 MB pack size
- my first patch
   Total 6452 (delta 4706), reused 1450 (delta 0)
   10316.93user 4220.67system 4:02:20elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
   0inputs+0outputs (0major+1045003394minor)pagefaults 0swaps
   =>92 MB pack size
- attached patch
   Total 6452 (delta 4581), reused 1522 (delta 0)
   11354.38user 5451.60system 4:40:09elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
   0inputs+0outputs (0major+1371504762minor)pagefaults 0swaps
   =>75 MB pack size

Repacking git.git repository:

- original version
   Total 42893 (delta 29900), reused 12400 (delta 0)
   57.32user 1.17system 1:03.73elapsed 91%CPU (0avgtext+0avgdata 0maxresident)k
   0inputs+0outputs (267major+47813minor)pagefaults 0swaps
   11538746 bytes pack size
- attached patch
   Total 42893 (delta 29899), reused 12400 (delta 0)
   57.04user 0.80system 1:00.68elapsed 95%CPU (0avgtext+0avgdata 0maxresident)k
   0inputs+0outputs (7major+28628minor)pagefaults 0swaps
   11538869 bytes pack size

Repacking linux kernel repository:

- original version
   Total 467313 (delta 376494), reused 78113 (delta 0)
   809.08user 39.59system 36:54.70elapsed 38%CPU (0avgtext+0avgdata 0maxresident)k
   0inputs+0outputs (83839major+1257686minor)pagefaults 0swaps
   149460017 bytes pack size
- attached patch
   Total 467313 (delta 376495), reused 78113 (delta 0)
   806.27user 37.81system 35:06.12elapsed 40%CPU (0avgtext+0avgdata 0maxresident)k
   0inputs+0outputs (79755major+1235874minor)pagefaults 0swaps
   149336835 bytes pack size

The following patch is only for testing purposes and not cleaned up.

 diff-delta.c |  105 +++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 68 insertions(+), 37 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 9f998d0..df9b336 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -305,8 +305,6 @@ create_delta(const struct delta_index *index,
 				continue;
 			if (ref_size > top - src)
 				ref_size = top - src;
-			if (ref_size > 0x10000)
-				ref_size = 0x10000;
 			if (ref_size <= msize)
 				break;
 			while (ref_size-- && *src++ == *ref)
@@ -315,6 +313,8 @@ create_delta(const struct delta_index *index,
 				/* this is our best match so far */
 				msize = ref - entry->ptr;
 				moff = entry->ptr - ref_data;
+				if (msize >= 0x10000)
+				    break;
 			}
 		}
 
@@ -328,30 +328,15 @@ create_delta(const struct delta_index *index,
 				inscnt = 0;
 			}
 		} else {
-			unsigned char *op;
-
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
+			unsigned int wsize, undo = 0;
+			
 			if (inscnt) {
 				while (moff && ref_data[moff-1] == data[-1]) {
-					if (msize == 0x10000)
-						break;
 					/* we can match one byte back */
 					msize++;
 					moff--;
 					data--;
+					undo++;
 					outpos--;
 					if (--inscnt)
 						continue;
@@ -359,27 +344,72 @@ create_delta(const struct delta_index *index,
 					inscnt--;  /* make it -1 */
 					break;
 				}
-				out[outpos - inscnt - 1] = inscnt;
+					out[outpos - inscnt - 1] = inscnt;
 				inscnt = 0;
 			}
+			
+			wsize=msize;
+			while (wsize >= 4)
+			{
+				unsigned char *op;
+				unsigned int boff, bsize;
+				boff = moff;
+				bsize = wsize;
+
+				if (bsize > 0x10000)
+					bsize = 0x10000;
+
+				moff += bsize;
+				wsize -= bsize;
+				
+				op = out + outpos++;
+				i = 0x80;
+				
+				if (boff & 0xff) { out[outpos++] = boff; i |= 0x01; }
+				boff >>= 8;
+				if (boff & 0xff) { out[outpos++] = boff; i |= 0x02; }
+				boff >>= 8;
+				if (boff & 0xff) { out[outpos++] = boff; i |= 0x04; }
+				boff >>= 8;
+				if (boff & 0xff) { out[outpos++] = boff; i |= 0x08; }
+				
+				if (bsize & 0xff) { out[outpos++] = bsize; i |= 0x10; }
+				bsize >>= 8;
+				if (bsize & 0xff) { out[outpos++] = bsize; i |= 0x20; }
+				
+				*op = i;
+
+				if (outpos >= outsize - MAX_OP_SIZE) {
+					void *tmp = out;
+					outsize = outsize * 3 / 2;
+					if (max_size && outsize >= max_size)
+						outsize = max_size + MAX_OP_SIZE + 1;
+					if (max_size && outpos > max_size)
+						goto out;
+					out = xrealloc(out, outsize);
+					if (!out) {
+						free(tmp);
+						return NULL;
+					}
+				}
+			}
+			
+			msize -= wsize;
+			if (msize - undo >= RABIN_WINDOW || 1) {
+				const unsigned char *sk;
+				sk = data + msize - RABIN_WINDOW;
+				val = 0;
+				for (i = 0; i < RABIN_WINDOW; i++)
+					val = ((val << 8) | *sk++) ^ T[val >> RABIN_SHIFT];
+			} else {
+				const unsigned char *sk = data + 1;
+				for (i = 1; i < msize; i++) {
+					val ^= U[sk[-RABIN_WINDOW + undo]];
+					val = ((val << 8) | *sk++) ^ T[val >> RABIN_SHIFT];
+				}
+			}
 
 			data += msize;
-			op = out + outpos++;
-			i = 0x80;
-
-			if (moff & 0xff) { out[outpos++] = moff; i |= 0x01; }
-			moff >>= 8;
-			if (moff & 0xff) { out[outpos++] = moff; i |= 0x02; }
-			moff >>= 8;
-			if (moff & 0xff) { out[outpos++] = moff; i |= 0x04; }
-			moff >>= 8;
-			if (moff & 0xff) { out[outpos++] = moff; i |= 0x08; }
-
-			if (msize & 0xff) { out[outpos++] = msize; i |= 0x10; }
-			msize >>= 8;
-			if (msize & 0xff) { out[outpos++] = msize; i |= 0x20; }
-
-			*op = i;
 		}
 
 		if (outpos >= outsize - MAX_OP_SIZE) {
@@ -397,6 +427,7 @@ create_delta(const struct delta_index *index,
 		}
 	}
 
+ out:
 	if (inscnt)
 		out[outpos - inscnt - 1] = inscnt;
 
-- 
1.4.4.4
