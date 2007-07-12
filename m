From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] apply delta depth bias to already deltified objects
Date: Thu, 12 Jul 2007 14:33:21 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707121415450.32552@xanadu.home>
References: <alpine.LFD.0.999.0707120049120.32552@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Brian Downing <bdowning@lavos.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 20:33:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I93Th-00084z-Ob
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 20:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbXGLSdX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 14:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755307AbXGLSdX
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 14:33:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61494 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012AbXGLSdW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 14:33:22 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JL200F0KWVLRWB0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 12 Jul 2007 14:33:21 -0400 (EDT)
In-reply-to: <alpine.LFD.0.999.0707120049120.32552@xanadu.home>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52313>

We already apply a bias on the initial delta attempt with max_size being 
a function of the base object depth.  This has the effect of favoring 
shallower deltas even if deeper deltas could be smaller, and therefore 
creating a wider delta tree (see commits 4e8da195 and c3b06a69).

This principle should also be applied to all delta attempts for the same 
object and not only the first attempt.  With this the criteria for the 
best delta is not only its size but also its depth, so that a shallower 
delta might be selected even if it is larger than a deeper one.  Even if 
some deltas get larger, they allow for wider delta trees making the 
depth limit less quickly reached and therefore better deltas can be 
subsequently found, keeping the resulting pack size even smaller.  
Runtime access to the pack should also benefit from shallower deltas.

Testing on different repositories showed slighter faster repacks, 
smaller resulting packs, and a much nicer curve for delta depth 
distribution with no more peak at the maximum depth level.  
Improvements are even more significant with smaller depth limits.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

No, I wonn't provide the full test results again.  Yes, they're 
different and even slightly better with this version, but I can't be 
bothered to run them all and wait for the results again.  You'll have to 
take my word or do your own.

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 54b9d26..b4f3e7c 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1303,6 +1303,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	struct object_entry *trg_entry = trg->entry;
 	struct object_entry *src_entry = src->entry;
 	unsigned long trg_size, src_size, delta_size, sizediff, max_size, sz;
+	unsigned ref_depth;
 	enum object_type type;
 	void *delta_buf;
 
@@ -1332,12 +1333,17 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
 	/* Now some size filtering heuristics. */
 	trg_size = trg_entry->size;
-	max_size = trg_size/2 - 20;
-	max_size = max_size * (max_depth - src_entry->depth) / max_depth;
+	if (!trg_entry->delta) {
+		max_size = trg_size/2 - 20;
+		ref_depth = 1;
+	} else {
+		max_size = trg_entry->delta_size;
+		ref_depth = trg_entry->depth;
+	}
+	max_size = max_size * (max_depth - src_entry->depth) /
+						(max_depth - ref_depth + 1);
 	if (max_size == 0)
 		return 0;
-	if (trg_entry->delta && trg_entry->delta_size <= max_size)
-		max_size = trg_entry->delta_size;
 	src_size = src_entry->size;
 	sizediff = src_size < trg_size ? trg_size - src_size : 0;
 	if (sizediff >= max_size)
