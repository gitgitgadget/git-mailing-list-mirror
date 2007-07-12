From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] reduce git-pack-objects memory usage a little more
Date: Thu, 12 Jul 2007 17:07:59 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707121703240.32552@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 23:08:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I95tS-0007Ns-IN
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 23:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759850AbXGLVIB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 17:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761475AbXGLVIB
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 17:08:01 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20443 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759747AbXGLVIA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 17:08:00 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JL3005SD41BST00@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 12 Jul 2007 17:07:59 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52337>

The delta depth doesn't have to be stored in the global object array 
structure since it is only used during the deltification pass.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index b4f3e7c..55609f3 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -25,9 +25,6 @@ git-pack-objects [{ -q | --progress | --all-progress }] [--max-pack-size=N] \n\
 struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;	/* uncompressed size */
-
-	unsigned int hash;	/* name hint hash */
-	unsigned int depth;	/* delta depth */
 	struct packed_git *in_pack; 	/* already in pack */
 	off_t in_pack_offset;
 	struct object_entry *delta;	/* delta base object */
@@ -37,6 +34,7 @@ struct object_entry {
 					     */
 	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
+	unsigned int hash;	/* name hint hash */
 	enum object_type type;
 	enum object_type in_pack_type;	/* could be delta */
 	unsigned char in_pack_header_size;
@@ -1270,6 +1268,7 @@ struct unpacked {
 	struct object_entry *entry;
 	void *data;
 	struct delta_index *index;
+	unsigned depth;
 };
 
 static int delta_cacheable(struct unpacked *trg, struct unpacked *src,
@@ -1328,7 +1327,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		return 0;
 
 	/* Let's not bust the allowed depth. */
-	if (src_entry->depth >= max_depth)
+	if (src->depth >= max_depth)
 		return 0;
 
 	/* Now some size filtering heuristics. */
@@ -1338,9 +1337,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		ref_depth = 1;
 	} else {
 		max_size = trg_entry->delta_size;
-		ref_depth = trg_entry->depth;
+		ref_depth = trg->depth;
 	}
-	max_size = max_size * (max_depth - src_entry->depth) /
+	max_size = max_size * (max_depth - src->depth) /
 						(max_depth - ref_depth + 1);
 	if (max_size == 0)
 		return 0;
@@ -1379,17 +1378,17 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	if (trg_entry->delta_data) {
 		/* Prefer only shallower same-sized deltas. */
 		if (delta_size == trg_entry->delta_size &&
-		    src_entry->depth + 1 >= trg_entry->depth) {
+		    src->depth + 1 >= trg->depth) {
 			free(delta_buf);
 			return 0;
 		}
 		delta_cache_size -= trg_entry->delta_size;
 		free(trg_entry->delta_data);
+		trg_entry->delta_data = NULL;
 	}
-	trg_entry->delta_data = 0;
 	trg_entry->delta = src_entry;
 	trg_entry->delta_size = delta_size;
-	trg_entry->depth = src_entry->depth + 1;
+	trg->depth = src->depth + 1;
 
 	if (delta_cacheable(src, trg, src_size, trg_size, delta_size)) {
 		trg_entry->delta_data = xrealloc(delta_buf, delta_size);
@@ -1484,7 +1483,7 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 		 * depth, leaving it in the window is pointless.  we
 		 * should evict it first.
 		 */
-		if (entry->delta && depth <= entry->depth)
+		if (entry->delta && depth <= n->depth)
 			continue;
 
 		next:
