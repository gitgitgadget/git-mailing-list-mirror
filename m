From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] apply delta depth bias to already deltified objects
Date: Thu, 12 Jul 2007 02:38:30 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707120049120.32552@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 08:38:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8sKD-0008Q8-AK
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 08:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759464AbXGLGid (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 02:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbXGLGid
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 02:38:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33726 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759391AbXGLGic (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 02:38:32 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JL100JVRZS79F40@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 12 Jul 2007 02:38:31 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52249>


We already apply a bias on the initial delta attempt with max_size being 
a function of the base object depth.  This already has the effect of 
favoring shallower deltas even if deeper deltas could be smaller, and 
therefore creating a wider delta tree (see commits 4e8da195 and 
c3b06a69).

This principle should also be applied to all delta attempts for the same 
object and not only the first attempt.  With this the criteria for the 
best delta is not only its size but also its depth, so that a shallower 
delta might be selected even if it is larger than a deeper one.  Even if 
some deltas get larger, they allow for wider delta trees making the 
depth limit less quickly reached and therefore better deltas can be 
subsequently found, keeping the resulting pack size equal or even 
smaller.  Runtime access to the pack should also benefit from shallower 
deltas.

Testing on the GIT repo before this patch provided those numbers:

$ git repack -a -f --depth=10
Total 56534 (delta 39441), reused 0 (delta 0)
29.38user 0.33system 0:29.73elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+20996minor)pagefaults 0swaps

$ git verify-pack -v
chain length = 1: 3150 objects
chain length = 2: 2713 objects
chain length = 3: 2441 objects
chain length = 4: 2205 objects
chain length = 5: 2014 objects
chain length = 6: 1895 objects
chain length = 7: 1802 objects
chain length = 8: 1997 objects
chain length = 9: 2710 objects
chain length = 10: 18514 objects

Pack size is 18273039 bytes.

With this patch:

$ git repack -a -f --depth=10
Total 56534 (delta 39370), reused 0 (delta 0)
24.32user 0.35system 0:24.78elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+19142minor)pagefaults 0swaps

$ git verify-pack -v
chain length = 1: 4059 objects
chain length = 2: 4048 objects
chain length = 3: 3775 objects
chain length = 4: 3428 objects
chain length = 5: 3007 objects
chain length = 6: 2793 objects
chain length = 7: 2701 objects
chain length = 8: 2988 objects
chain length = 9: 3935 objects
chain length = 10: 8636 objects

Pack size is 16311008 bytes.

Summary: this patch makes for slightly faster repacks, a smaller pack, 
and a much lower count of object hanging on the max delta depth.

Same repo again with the default depth of 50:

Before:
Total 56534 (delta 39545), reused 0 (delta 0)
23.01user 0.36system 0:23.40elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+21017minor)pagefaults 0swaps
chain length = 1: 2882 objects
chain length = 2: 2443 objects
chain length = 3: 2157 objects
[...]
chain length = 48: 505 objects
chain length = 49: 782 objects
chain length = 50: 1802 objects
Pack size: 14651260 bytes.

After:

Total 56534 (delta 39596), reused 0 (delta 0)
22.98user 0.20system 0:23.20elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+20560minor)pagefaults 0swaps
chain length = 1: 2985 objects
chain length = 2: 2625 objects
chain length = 3: 2282 objects
[...]
chain length = 48: 477 objects
chain length = 49: 564 objects
chain length = 50: 392 objects
Pack size: 14383165 bytes.

With the Linux kernel repo:

Before:

Total 531582 (delta 431824), reused 0 (delta 0)
276.66user 3.64system 4:45.35elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+149606minor)pagefaults 0swaps
chain length = 1: 40779 objects
chain length = 2: 35650 objects
chain length = 3: 30226 objects
chain length = 4: 25619 objects
chain length = 5: 21709 objects
[...]
chain length = 46: 2223 objects
chain length = 47: 3263 objects
chain length = 48: 3175 objects
chain length = 49: 2128 objects
chain length = 50: 6413 objects
Pack size: 155680720 bytes.

After:

Total 531582 (delta 432537), reused 0 (delta 0)
270.31user 3.15system 4:35.07elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+140517minor)pagefaults 0swaps
chain length = 1: 41555 objects
chain length = 2: 36919 objects
chain length = 3: 31217 objects
chain length = 4: 26762 objects
chain length = 5: 22348 objects
[...]
chain length = 46: 1842 objects
chain length = 47: 1800 objects
chain length = 48: 1483 objects
chain length = 49: 1216 objects
chain length = 50: 1310 objects
Pack size: 154421656 bytes.


Signed-off-by: Nicolas Pitre <nico@cam.org>
---

This apparently makes BRian's patological case worse (although better 
than before his same-size-shallower patch), but I think that the 
improvement in the general case is worth it.  Even Brian's pack gets 
smaller so...

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 54b9d26..1eb86ed 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1332,12 +1332,14 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
 	/* Now some size filtering heuristics. */
 	trg_size = trg_entry->size;
-	max_size = trg_size/2 - 20;
+	if (!trg_entry->delta)
+		max_size = trg_size/2 - 20;
+	else
+		max_size = trg_entry->delta_size * max_depth /
+				(max_depth - trg_entry->depth + 1);
 	max_size = max_size * (max_depth - src_entry->depth) / max_depth;
 	if (max_size == 0)
 		return 0;
-	if (trg_entry->delta && trg_entry->delta_size <= max_size)
-		max_size = trg_entry->delta_size;
 	src_size = src_entry->size;
 	sizediff = src_size < trg_size ? trg_size - src_size : 0;
 	if (sizediff >= max_size)
