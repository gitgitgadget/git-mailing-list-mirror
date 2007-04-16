From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 3/9] pack-objects: rework check_delta_limit usage
Date: Mon, 16 Apr 2007 12:29:16 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704161228570.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 18:29:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdU5A-00005G-U4
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 18:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030863AbXDPQ3T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 12:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030860AbXDPQ3T
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 12:29:19 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57842 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030844AbXDPQ3R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 12:29:17 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGL00HJMN4S00G0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 16 Apr 2007 12:29:17 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44668>

Objects that have delta "children" from pack data reuse must consider the
depth of their deepest child when they try to deltify themselves for those
children not to become too deep.

However, in the context of a "thin" pack, the delta children depth was
skipped entirely on the presumption that the pack was always going to be
exploded on the receiving end, hence the delta length wasn't an issue.

Now that we keep received packs as is and reuse pack data when repacking,
those packs do contain delta chains that are longer than expected. Worse,
those delta chain may even grow longer when the pack is further repacked
into another thin pack for a subsequent transmission.

So this patch restores strict delta length even for thin packs, and it
moves check_delta_limit() usage directly in the delta loop where it is
needed.  This way the delta_limit can be removed from struct object_entry
as well.  Oh and the initial value was wrong too.

The  progress_interval() function was moved to a more logical location in
the process.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   76 ++++++++++++++++++++---------------------------
 1 files changed, 32 insertions(+), 44 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 869ca1a..d44b8f4 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -27,7 +27,6 @@ struct object_entry {
 				 * nonzero if already written.
 				 */
 	unsigned int depth;	/* delta depth */
-	unsigned int delta_limit;	/* base adjustment for in-pack delta */
 	unsigned int hash;	/* name hint hash */
 	enum object_type type;
 	enum object_type in_pack_type;	/* could be delta */
@@ -1172,19 +1171,6 @@ static void check_object(struct object_entry *entry)
 		    sha1_to_hex(entry->sha1));
 }
 
-static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
-{
-	struct object_entry *child = me->delta_child;
-	unsigned int m = n;
-	while (child) {
-		unsigned int c = check_delta_limit(child, n + 1);
-		if (m < c)
-			m = c;
-		child = child->delta_sibling;
-	}
-	return m;
-}
-
 static void get_object_details(void)
 {
 	uint32_t i;
@@ -1193,23 +1179,6 @@ static void get_object_details(void)
 	prepare_pack_ix();
 	for (i = 0, entry = objects; i < nr_objects; i++, entry++)
 		check_object(entry);
-
-	if (nr_objects == nr_result) {
-		/*
-		 * Depth of objects that depend on the entry -- this
-		 * is subtracted from depth-max to break too deep
-		 * delta chain because of delta data reusing.
-		 * However, we loosen this restriction when we know we
-		 * are creating a thin pack -- it will have to be
-		 * expanded on the other end anyway, so do not
-		 * artificially cut the delta chain and let it go as
-		 * deep as it wants.
-		 */
-		for (i = 0, entry = objects; i < nr_objects; i++, entry++)
-			if (!entry->delta && entry->delta_child)
-				entry->delta_limit =
-					check_delta_limit(entry, 1);
-	}
 }
 
 typedef int (*entry_sort_t)(const struct object_entry *, const struct object_entry *);
@@ -1322,16 +1291,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	    trg_entry->in_pack_type != OBJ_OFS_DELTA)
 		return 0;
 
-	/*
-	 * If the current object is at pack edge, take the depth the
-	 * objects that depend on the current object into account --
-	 * otherwise they would become too deep.
-	 */
-	if (trg_entry->delta_child) {
-		if (max_depth <= trg_entry->delta_limit)
-			return 0;
-		max_depth -= trg_entry->delta_limit;
-	}
+	/* Let's not bust the allowed depth. */
 	if (src_entry->depth >= max_depth)
 		return 0;
 
@@ -1378,9 +1338,17 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	return 1;
 }
 
-static void progress_interval(int signum)
+static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
 {
-	progress_update = 1;
+	struct object_entry *child = me->delta_child;
+	unsigned int m = n;
+	while (child) {
+		unsigned int c = check_delta_limit(child, n + 1);
+		if (m < c)
+			m = c;
+		child = child->delta_sibling;
+	}
+	return m;
 }
 
 static void find_deltas(struct object_entry **list, int window, int depth)
@@ -1389,6 +1357,7 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 	unsigned int array_size = window * sizeof(struct unpacked);
 	struct unpacked *array;
 	unsigned last_percent = 999;
+	int max_depth;
 
 	if (!nr_objects)
 		return;
@@ -1429,6 +1398,18 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 		n->data = NULL;
 		n->entry = entry;
 
+		/*
+		 * If the current object is at pack edge, take the depth the
+		 * objects that depend on the current object into account
+		 * otherwise they would become too deep.
+		 */
+		max_depth = depth;
+		if (entry->delta_child) {
+			max_depth -= check_delta_limit(entry, 0);
+			if (max_depth <= 0)
+				goto next;
+		}
+
 		j = window;
 		while (--j > 0) {
 			uint32_t other_idx = idx + j;
@@ -1438,9 +1419,10 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 			m = array + other_idx;
 			if (!m->entry)
 				break;
-			if (try_delta(n, m, depth) < 0)
+			if (try_delta(n, m, max_depth) < 0)
 				break;
 		}
+
 		/* if we made n a delta, and if n is already at max
 		 * depth, leaving it in the window is pointless.  we
 		 * should evict it first.
@@ -1448,6 +1430,7 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 		if (entry->delta && depth <= entry->depth)
 			continue;
 
+		next:
 		idx++;
 		if (idx >= window)
 			idx = 0;
@@ -1525,6 +1508,11 @@ static int reuse_cached_pack(unsigned char *sha1)
 	return 1;
 }
 
+static void progress_interval(int signum)
+{
+	progress_update = 1;
+}
+
 static void setup_progress_signal(void)
 {
 	struct sigaction sa;
-- 
1.5.1.1.781.g65e8
