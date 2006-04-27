From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH/RFC] reverse the pack-objects delta window logic
Date: Wed, 26 Apr 2006 23:05:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604262210120.18520@localhost.localdomain>
References: <Pine.LNX.4.64.0604252330190.18520@localhost.localdomain>
 <7vpsj4sxer.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604261341200.18520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 27 05:05:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYwpB-0002A5-0F
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 05:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWD0DFq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 23:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWD0DFq
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 23:05:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27880 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S964905AbWD0DFp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Apr 2006 23:05:45 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IYD00L561XJW420@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 26 Apr 2006 23:05:45 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0604261341200.18520@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19221>

On Wed, 26 Apr 2006, Nicolas Pitre wrote:

> On Tue, 25 Apr 2006, Junio C Hamano wrote:
> 
> > Nicolas Pitre <nico@cam.org> writes:
> > 
> > > Note, this is a RFC particularly to Junio since the resulting pack is 
> > > larger than without the patch with git-repack -a -f.  However using a 
> > > subsequent git-repack -a brings the pack size down to expected size.  So 
> > > I'm not sure I've got everything right.
> > 
> > I haven't tested it seriously yet, but there is nothing that
> > looks obviously wrong that might cause the inflation problem,
> > from the cursory look after applying the patch on top of your
> > last round.
> 
> Never mind.  I found a flaw in the determination of delta_limit when 
> reparenting a delta target.  The immediate parent's delta_limit is 
> readjusted when its longest delta is moved to another base, but if that 
> parent was itself a delta then the delta_limit adjustment is not 
> propagated back up to the top.  This means that some objects were 
> falsely credited with too high delta_limit.
> 
> And actually I'm not sure how to solve that without walking the tree 
> up to the top each time, which I want to avoid as much as possible.

Well, that seems to be unavoidable.

Reversing the window logic isn't that much of a good idea after all.  As 
soon as we need to control the delta depth we sorta need to maintain 
trees of deltas and those trees are built from leaves up to the trunk.  

But each new object in the list is then used as a possible
new base for previously created deltas still in the object window.  When 
the new base is determined to produce a better delta then the 
relationship with the old base must be broken, which means that the 
information about delta length for the old base has to be updated.  And 
if the detached delta chain was the longest for that old base then the 
remaining longest delta chain from that old base has to be found and 
that information reflected up to the ultimate base in that tree.  And 
doing so isn't necessarily trivial as can be seen in the patch below.

Then there is the possibility of having a delta "branch" with maximum 
depth meaning that the trunk for that branch may not be deltified. But 
if a later objects to come does constitute a better delta base for the 
object in the middle of that branch then the branch will be broken in 
the middle to be transplanted onto the new base as explained previously.  
Which means that the initial trunk no longer has a maximum 
depth and 
some objects that were skipped because of the depth limit could 
now have been tested, leading to suboptimal delta matching.  This is why 
running pack-objects a second time improved things as it picked up 
those missed delta opportunities.  But having to run pack-objects 
multiple times is a bit against the point, and even if pack-objects 
processed the object list multiple times it certainly won't be 
faster than the current code.

In short, trying to deltify objects by keeping the base object constant 
for the match window really sucks, even from a theoretical point of 
view.  It does produce sensibly larger 
packs and it does take longer to do so.  I'm therefore dropping that 
approach.  My current patch can be found below.  If someone 
smarter than me (there are plenty I'm sure) can come with improvements 
to it then be my guest.

Therefore I really think the best approach is to simply keep delta index 
data along with object data in the match window and keep the current 
window direction for matching.  It obviously will take up more memory, 
but most probably less than if we set the window size = 20.  And 
building delta trees from the trunk to the leaves will always be optimal 
regardless with no delta rebasing needed.  I'll post another patch doing 
just that.

---

diff --git a/pack-objects.c b/pack-objects.c
index c0acc46..17280fb 100644
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
@@ -884,17 +882,16 @@ static void check_object(struct object_e
 		    sha1_to_hex(entry->sha1), type);
 }
 
-static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
+static unsigned int find_delta_limit(struct object_entry *me)
 {
 	struct object_entry *child = me->delta_child;
-	unsigned int m = n;
 	while (child) {
-		unsigned int c = check_delta_limit(child, n + 1);
-		if (m < c)
-			m = c;
+		unsigned int c = find_delta_limit(child);
+		if (me->delta_limit <= c)
+			me->delta_limit = c + 1;
 		child = child->delta_sibling;
 	}
-	return m;
+	return me->delta_limit;
 }
 
 static void get_object_details(void)
@@ -906,11 +903,11 @@ static void get_object_details(void)
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
@@ -919,8 +916,7 @@ static void get_object_details(void)
 		 */
 		for (i = 0, entry = objects; i < nr_objects; i++, entry++)
 			if (!entry->delta && entry->delta_child)
-				entry->delta_limit =
-					check_delta_limit(entry, 1);
+				find_delta_limit(entry);
 	}
 }
 
@@ -994,6 +990,7 @@ static int type_size_sort(const struct o
 struct unpacked {
 	struct object_entry *entry;
 	void *data;
+	int pos;
 };
 
 /*
@@ -1004,64 +1001,94 @@ struct unpacked {
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
+	if (trg_entry->delta_limit >= max_depth && nr_objects == nr_result)
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
+	if (trg_entry->delta && nr_objects == nr_result) {
+		/*
+		 * The target object already has a delta base but we just
+		 * found a better one.  Remove it from its former base
+		 * childhood and redetermine the base delta_limit.
+		 * But again, only when not creating a thin pack.
+		 */
+		struct object_entry *base = trg_entry->delta;
+		struct object_entry **child_link = &base->delta_child;
+		unsigned int limit = base->delta_limit;
+		base->delta_limit = 0;
+		while (*child_link) {
+			if (*child_link == trg_entry) {
+				*child_link = trg_entry->delta_sibling;
+				continue;
+			}
+			if (base->delta_limit <= (*child_link)->delta_limit)
+				base->delta_limit =
+					(*child_link)->delta_limit + 1;
+			child_link = &(*child_link)->delta_sibling;
+		}
+		if (base->delta_limit == limit)
+			goto out;
+		while ((base = base->delta) && ++limit == base->delta_limit) {
+			struct object_entry *child = base->delta_child;
+			base->delta_limit = 0;
+			do {
+				if(base->delta_limit <= child->delta_limit) {
+					base->delta_limit =
+						child->delta_limit + 1;
+					if (base->delta_limit == limit)
+						goto out;
+				}
+				child = child->delta_sibling;
+			} while (child);
+		}
+		out:;
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
@@ -1078,14 +1105,15 @@ static void find_deltas(struct object_en
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
@@ -1109,11 +1137,18 @@ static void find_deltas(struct object_en
 			 */
 			continue;
 
+		if (entry->size < 50)
+			continue;
 		free(n->data);
+		n->pos = i;
 		n->entry = entry;
 		n->data = read_sha1_file(entry->sha1, type, &size);
 		if (size != entry->size)
-			die("object %s inconsistent object length (%lu vs %lu)", sha1_to_hex(entry->sha1), size, entry->size);
+			die("object %s inconsistent object length (%lu vs %lu)",
+			    sha1_to_hex(entry->sha1), size, entry->size);
+		delta_index = create_delta_index(n->data, size);
+		if (!delta_index)
+			die("out of memory");
 
 		j = window;
 		while (--j > 0) {
@@ -1124,18 +1159,10 @@ static void find_deltas(struct object_en
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
