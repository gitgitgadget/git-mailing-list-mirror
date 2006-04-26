From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH/RFC] reverse the pack-objects delta window logic
Date: Tue, 25 Apr 2006 23:37:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604252330190.18520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 26 05:38:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYaqM-0003CZ-Fd
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 05:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWDZDhX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 23:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbWDZDhX
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 23:37:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23762 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751626AbWDZDhW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 23:37:22 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IYB00KTW8Q9VN60@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 25 Apr 2006 23:37:21 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19182>

This allows for keeping a single delta index constant while delta 
targets are tested against the same base object.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

Note, this is a RFC particularly to Junio since the resulting pack is 
larger than without the patch with git-repack -a -f.  However using a 
subsequent git-repack -a brings the pack size down to expected size.  So 
I'm not sure I've got everything right.

diff --git a/pack-objects.c b/pack-objects.c
index c0acc46..33027a8 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -19,19 +19,17 @@ struct object_entry {
 	unsigned long offset;	/* offset into the final pack file;
 				 * nonzero if already written.
 				 */
-	unsigned int depth;	/* delta depth */
-	unsigned int delta_limit;	/* base adjustment for in-pack delta */
+	unsigned int delta_limit;	/* deepest delta from this object */
 	unsigned int hash;	/* name hint hash */
 	enum object_type type;
 	enum object_type in_pack_type;	/* could be delta */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	struct object_entry *delta;	/* delta base object */
-	struct packed_git *in_pack; 	/* already in pack */
-	unsigned int in_pack_offset;
 	struct object_entry *delta_child; /* delitified objects who bases me */
 	struct object_entry *delta_sibling; /* other deltified objects who
-					     * uses the same base as me
-					     */
+					       uses the same base as me */
+	struct packed_git *in_pack; 	/* already in pack */
+	unsigned int in_pack_offset;
 	int preferred_base;	/* we do not pack this, but is encouraged to
 				 * be used as the base objectto delta huge
 				 * objects against.
@@ -906,11 +904,11 @@ static void get_object_details(void)
 	for (i = 0, entry = objects; i < nr_objects; i++, entry++)
 		check_object(entry);
 
-	if (nr_objects == nr_result) {
+	if (!no_reuse_delta && nr_objects == nr_result) {
 		/*
-		 * Depth of objects that depend on the entry -- this
-		 * is subtracted from depth-max to break too deep
-		 * delta chain because of delta data reusing.
+		 * We must determine the maximum depth of reused deltas
+		 * for those objects used as their base before find_deltas()
+		 * starts considering them as potential delta targets.
 		 * However, we loosen this restriction when we know we
 		 * are creating a thin pack -- it will have to be
 		 * expanded on the other end anyway, so do not
@@ -1004,64 +1002,78 @@ struct unpacked {
  * more importantly, the bigger file is likely the more recent
  * one.
  */
-static int try_delta(struct unpacked *cur, struct unpacked *old, unsigned max_depth)
+static int try_delta(struct unpacked *trg, struct unpacked *src,
+		     struct delta_index *src_index, unsigned max_depth)
 {
-	struct object_entry *cur_entry = cur->entry;
-	struct object_entry *old_entry = old->entry;
-	unsigned long size, oldsize, delta_size, sizediff;
-	long max_size;
+	struct object_entry *trg_entry = trg->entry;
+	struct object_entry *src_entry = src->entry;
+	unsigned long size, src_size, delta_size, sizediff, max_size;
 	void *delta_buf;
 
 	/* Don't bother doing diffs between different types */
-	if (cur_entry->type != old_entry->type)
+	if (trg_entry->type != src_entry->type)
 		return -1;
 
 	/* We do not compute delta to *create* objects we are not
 	 * going to pack.
 	 */
-	if (cur_entry->preferred_base)
-		return -1;
+	if (trg_entry->preferred_base)
+		return 0;
 
-	/* If the current object is at pack edge, take the depth the
-	 * objects that depend on the current object into account --
-	 * otherwise they would become too deep.
+	/*
+	 * Make sure deltifying this object won't make its deepest delta
+	 * too deep, but only when not producing a thin pack.
 	 */
-	if (cur_entry->delta_child) {
-		if (max_depth <= cur_entry->delta_limit)
-			return 0;
-		max_depth -= cur_entry->delta_limit;
-	}
-
-	size = cur_entry->size;
-	oldsize = old_entry->size;
-	sizediff = oldsize > size ? oldsize - size : size - oldsize;
+	if (nr_objects == nr_result && trg_entry->delta_limit >= max_depth)
+		return 0;
 
+	/* Now some size filtering euristics. */
+	size = trg_entry->size;
 	if (size < 50)
-		return -1;
-	if (old_entry->depth >= max_depth)
 		return 0;
-
-	/*
-	 * NOTE!
-	 *
-	 * We always delta from the bigger to the smaller, since that's
-	 * more space-efficient (deletes don't have to say _what_ they
-	 * delete).
-	 */
 	max_size = size / 2 - 20;
-	if (cur_entry->delta)
-		max_size = cur_entry->delta_size-1;
+	if (trg_entry->delta)
+		max_size = trg_entry->delta_size-1;
+	src_size = src_entry->size;
+	sizediff = src_size < size ? size - src_size : 0;
 	if (sizediff >= max_size)
 		return 0;
-	delta_buf = diff_delta(old->data, oldsize,
-			       cur->data, size, &delta_size, max_size);
+
+	delta_buf = create_delta(src_index, trg->data, size, &delta_size, max_size);
 	if (!delta_buf)
 		return 0;
-	cur_entry->delta = old_entry;
-	cur_entry->delta_size = delta_size;
-	cur_entry->depth = old_entry->depth + 1;
+
+	if (trg_entry->delta) {
+		/*
+		 * The target object already has a delta base but we just
+		 * found a better one.  Remove it from its former base
+		 * childhood and redetermine the base delta_limit (if used).
+		 */
+		struct object_entry *base = trg_entry->delta;
+		struct object_entry **child_link = &base->delta_child;
+		base->delta_limit = 0;
+		while (*child_link) {
+			if (*child_link == trg_entry) {
+				*child_link = trg_entry->delta_sibling;
+				if (nr_objects != nr_result)
+					break;
+				continue;
+			}
+			if (base->delta_limit <= (*child_link)->delta_limit)
+				base->delta_limit =
+					(*child_link)->delta_limit + 1;
+			child_link = &(*child_link)->delta_sibling;
+		}
+	}
+
+	trg_entry->delta = src_entry;
+	trg_entry->delta_size = delta_size;
+	trg_entry->delta_sibling = src_entry->delta_child;
+	src_entry->delta_child = trg_entry;
+	if (src_entry->delta_limit <= trg_entry->delta_limit)
+		src_entry->delta_limit = trg_entry->delta_limit + 1;
 	free(delta_buf);
-	return 0;
+	return 1;
 }
 
 static void progress_interval(int signum)
@@ -1078,14 +1090,15 @@ static void find_deltas(struct object_en
 	unsigned last_percent = 999;
 
 	memset(array, 0, array_size);
-	i = nr_objects;
+	i = 0;
 	idx = 0;
 	if (progress)
 		fprintf(stderr, "Deltifying %d objects.\n", nr_result);
 
-	while (--i >= 0) {
-		struct object_entry *entry = list[i];
+	while (i < nr_objects) {
+		struct object_entry *entry = list[i++];
 		struct unpacked *n = array + idx;
+		struct delta_index *delta_index;
 		unsigned long size;
 		char type[10];
 		int j;
@@ -1113,7 +1126,13 @@ static void find_deltas(struct object_en
 		n->entry = entry;
 		n->data = read_sha1_file(entry->sha1, type, &size);
 		if (size != entry->size)
-			die("object %s inconsistent object length (%lu vs %lu)", sha1_to_hex(entry->sha1), size, entry->size);
+			die("object %s inconsistent object length (%lu vs %lu)",
+			    sha1_to_hex(entry->sha1), size, entry->size);
+		if (!size)
+			continue;
+		delta_index = create_delta_index(n->data, size);
+		if (!delta_index)
+			die("out of memory");
 
 		j = window;
 		while (--j > 0) {
@@ -1124,18 +1143,10 @@ static void find_deltas(struct object_en
 			m = array + other_idx;
 			if (!m->entry)
 				break;
-			if (try_delta(n, m, depth) < 0)
+			if (try_delta(m, n, delta_index, depth) < 0)
 				break;
 		}
-#if 0
-		/* if we made n a delta, and if n is already at max
-		 * depth, leaving it in the window is pointless.  we
-		 * should evict it first.
-		 * ... in theory only; somehow this makes things worse.
-		 */
-		if (entry->delta && depth <= entry->depth)
-			continue;
-#endif
+		free_delta_index(delta_index);
 		idx++;
 		if (idx >= window)
 			idx = 0;
