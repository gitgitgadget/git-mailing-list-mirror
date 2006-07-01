From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] don't load objects needlessly when repacking
Date: Fri, 30 Jun 2006 22:55:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606302243120.1213@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 04:55:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwVdw-0001qX-Bv
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 04:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWGACzc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 22:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWGACzc
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 22:55:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49204 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751031AbWGACzb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 22:55:31 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J1P00828ESI7N40@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 30 Jun 2006 22:55:31 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23033>

If no delta is attempted on some objects then it is useless to load them 
in memory, neither create any delta index for them.  The best thing to 
do is therefore to load and index them only when really needed.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

With this patch, a git-repack -a on the Linux kernel repo takes 19 
seconds instead of 25 seconds on my machine.  At this point the cost of 
creating a pack is largely dominated by git-rev-list alone while the 
actual pack creation is basically free.

diff --git a/pack-objects.c b/pack-objects.c
index 47da33b..b486ea5 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -970,11 +970,12 @@ struct unpacked {
  * one.
  */
 static int try_delta(struct unpacked *trg, struct unpacked *src,
-		     struct delta_index *src_index, unsigned max_depth)
+		     unsigned max_depth)
 {
 	struct object_entry *trg_entry = trg->entry;
 	struct object_entry *src_entry = src->entry;
-	unsigned long size, src_size, delta_size, sizediff, max_size;
+	unsigned long trg_size, src_size, delta_size, sizediff, max_size, sz;
+	char type[10];
 	void *delta_buf;
 
 	/* Don't bother doing diffs between different types */
@@ -1009,19 +1010,38 @@ static int try_delta(struct unpacked *tr
 		return 0;
 
 	/* Now some size filtering heuristics. */
-	size = trg_entry->size;
-	max_size = size/2 - 20;
+	trg_size = trg_entry->size;
+	max_size = trg_size/2 - 20;
 	max_size = max_size * (max_depth - src_entry->depth) / max_depth;
 	if (max_size == 0)
 		return 0;
 	if (trg_entry->delta && trg_entry->delta_size <= max_size)
 		max_size = trg_entry->delta_size-1;
 	src_size = src_entry->size;
-	sizediff = src_size < size ? size - src_size : 0;
+	sizediff = src_size < trg_size ? trg_size - src_size : 0;
 	if (sizediff >= max_size)
 		return 0;
 
-	delta_buf = create_delta(src_index, trg->data, size, &delta_size, max_size);
+	/* Load data if not already done */
+	if (!trg->data) {
+		trg->data = read_sha1_file(trg_entry->sha1, type, &sz);
+		if (sz != trg_size)
+			die("object %s inconsistent object length (%lu vs %lu)",
+			    sha1_to_hex(trg_entry->sha1), sz, trg_size);
+	}
+	if (!src->data) {
+		src->data = read_sha1_file(src_entry->sha1, type, &sz);
+		if (sz != src_size)
+			die("object %s inconsistent object length (%lu vs %lu)",
+			    sha1_to_hex(src_entry->sha1), sz, src_size);
+	}
+	if (!src->index) {
+		src->index = create_delta_index(src->data, src_size);
+		if (!src->index)
+			die("out of memory");
+	}
+
+	delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
 	if (!delta_buf)
 		return 0;
 
@@ -1054,8 +1074,6 @@ static void find_deltas(struct object_en
 	while (--i >= 0) {
 		struct object_entry *entry = list[i];
 		struct unpacked *n = array + idx;
-		unsigned long size;
-		char type[10];
 		int j;
 
 		if (!entry->preferred_base)
@@ -1082,11 +1100,8 @@ static void find_deltas(struct object_en
 		free_delta_index(n->index);
 		n->index = NULL;
 		free(n->data);
+		n->data = NULL;
 		n->entry = entry;
-		n->data = read_sha1_file(entry->sha1, type, &size);
-		if (size != entry->size)
-			die("object %s inconsistent object length (%lu vs %lu)",
-			    sha1_to_hex(entry->sha1), size, entry->size);
 
 		j = window;
 		while (--j > 0) {
@@ -1097,7 +1112,7 @@ static void find_deltas(struct object_en
 			m = array + other_idx;
 			if (!m->entry)
 				break;
-			if (try_delta(n, m, m->index, depth) < 0)
+			if (try_delta(n, m, depth) < 0)
 				break;
 		}
 		/* if we made n a delta, and if n is already at max
@@ -1107,10 +1122,6 @@ static void find_deltas(struct object_en
 		if (entry->delta && depth <= entry->depth)
 			continue;
 
-		n->index = create_delta_index(n->data, size);
-		if (!n->index)
-			die("out of memory");
-
 		idx++;
 		if (idx >= window)
 			idx = 0;
