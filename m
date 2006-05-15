From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] simple euristic for further free packing improvements
Date: Mon, 15 May 2006 11:40:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605151129540.18071@localhost.localdomain>
References: <Pine.LNX.4.64.0605132305580.18071@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 17:41:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FffB6-0007w1-35
	for gcvg-git@gmane.org; Mon, 15 May 2006 17:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWEOPkI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 11:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWEOPkH
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 11:40:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47210 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751481AbWEOPkG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 11:40:06 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IZB00CYTCUTTCE0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 15 May 2006 11:40:05 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0605132305580.18071@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20058>

Given that the early eviction of objects with maximum delta depth 
may exhibit bad packing on its own, why not considering a bias against 
deep base objects in try_delta() to mitigate that bad behavior.

This patch adjust the MAX_size allowed for a delta based on the depth of 
the base object as well as enabling the early eviction of max depth 
objects from the object window.  When used separately, those two things 
produce slightly better and much worse results respectively.  But their 
combined effect is a surprising significant packing improvement.

With this really simple patch the GIT repo gets nearly 15% smaller, and 
the Linux kernel repo about 5% smaller, with no significantly measurable 
CPU usage difference.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/pack-objects.c b/pack-objects.c
index 523a1c7..b0388d7 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -1038,8 +1038,8 @@ static int try_delta(struct unpacked *tr
 
 	/* Now some size filtering euristics. */
 	size = trg_entry->size;
-	max_size = size / 2 - 20;
-	if (trg_entry->delta)
+	max_size = (size/2 - 20) / (src_entry->depth + 1);
+	if (trg_entry->delta && trg_entry->delta_size <= max_size)
 		max_size = trg_entry->delta_size-1;
 	src_size = src_entry->size;
 	sizediff = src_size < size ? size - src_size : 0;
@@ -1128,15 +1128,12 @@ static void find_deltas(struct object_en
 			if (try_delta(n, m, m->index, depth) < 0)
 				break;
 		}
-#if 0
 		/* if we made n a delta, and if n is already at max
 		 * depth, leaving it in the window is pointless.  we
 		 * should evict it first.
-		 * ... in theory only; somehow this makes things worse.
 		 */
 		if (entry->delta && depth <= entry->depth)
 			continue;
-#endif
 		idx++;
 		if (idx >= window)
 			idx = 0;
