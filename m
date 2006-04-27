From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] use delta index data when finding best delta matches
Date: Wed, 26 Apr 2006 23:58:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604262351221.18520@localhost.localdomain>
References: <Pine.LNX.4.64.0604252330190.18520@localhost.localdomain>
 <7vpsj4sxer.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604261341200.18520@localhost.localdomain>
 <Pine.LNX.4.64.0604262210120.18520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 27 05:58:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYxdr-0003ny-2w
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 05:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWD0D6E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 23:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWD0D6E
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 23:58:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46725 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932415AbWD0D6B
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Apr 2006 23:58:01 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IYD004DD4COLXE0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 26 Apr 2006 23:58:01 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0604262210120.18520@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19222>


This patch allows for computing the delta index for each base object 
only once and reuse it when trying to find the best delta match.

This should set the mark and pave the way for possibly better delta 
generator algorithms.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

... as mentioned in my previous post

diff --git a/pack-objects.c b/pack-objects.c
index c0acc46..5b2ef9a 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -994,6 +994,7 @@ static int type_size_sort(const struct o
 struct unpacked {
 	struct object_entry *entry;
 	void *data;
+	struct delta_index *index;
 };
 
 /*
@@ -1004,64 +1005,56 @@ struct unpacked {
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
+	if (trg_entry->preferred_base)
 		return -1;
 
-	/* If the current object is at pack edge, take the depth the
+	/*
+	 * If the current object is at pack edge, take the depth the
 	 * objects that depend on the current object into account --
 	 * otherwise they would become too deep.
 	 */
-	if (cur_entry->delta_child) {
-		if (max_depth <= cur_entry->delta_limit)
+	if (trg_entry->delta_child) {
+		if (max_depth <= trg_entry->delta_limit)
 			return 0;
-		max_depth -= cur_entry->delta_limit;
+		max_depth -= trg_entry->delta_limit;
 	}
-
-	size = cur_entry->size;
-	oldsize = old_entry->size;
-	sizediff = oldsize > size ? oldsize - size : size - oldsize;
-
-	if (size < 50)
-		return -1;
-	if (old_entry->depth >= max_depth)
+	if (src_entry->depth >= max_depth)
 		return 0;
 
-	/*
-	 * NOTE!
-	 *
-	 * We always delta from the bigger to the smaller, since that's
-	 * more space-efficient (deletes don't have to say _what_ they
-	 * delete).
-	 */
+	/* Now some size filtering euristics. */
+	size = trg_entry->size;
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
+	trg_entry->delta = src_entry;
+	trg_entry->delta_size = delta_size;
+	trg_entry->depth = src_entry->depth + 1;
 	free(delta_buf);
-	return 0;
+	return 1;
 }
 
 static void progress_interval(int signum)
@@ -1109,11 +1102,19 @@ static void find_deltas(struct object_en
 			 */
 			continue;
 
+		if (entry->size < 50)
+			continue;
+		if (n->index)
+			free_delta_index(n->index);
 		free(n->data);
 		n->entry = entry;
 		n->data = read_sha1_file(entry->sha1, type, &size);
 		if (size != entry->size)
-			die("object %s inconsistent object length (%lu vs %lu)", sha1_to_hex(entry->sha1), size, entry->size);
+			die("object %s inconsistent object length (%lu vs %lu)",
+			    sha1_to_hex(entry->sha1), size, entry->size);
+		n->index = create_delta_index(n->data, size);
+		if (!n->index)
+			die("out of memory");
 
 		j = window;
 		while (--j > 0) {
@@ -1124,7 +1125,7 @@ static void find_deltas(struct object_en
 			m = array + other_idx;
 			if (!m->entry)
 				break;
-			if (try_delta(n, m, depth) < 0)
+			if (try_delta(n, m, m->index, depth) < 0)
 				break;
 		}
 #if 0
@@ -1144,8 +1145,11 @@ #endif
 	if (progress)
 		fputc('\n', stderr);
 
-	for (i = 0; i < window; ++i)
+	for (i = 0; i < window; ++i) {
+		if (array[i].index)
+			free_delta_index(array[i].index);
 		free(array[i].data);
+	}
 	free(array);
 }
 
