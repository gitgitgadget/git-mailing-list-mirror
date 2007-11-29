From: Nicolas Pitre <nico@cam.org>
Subject: Re: Some git performance measurements..
Date: Thu, 29 Nov 2007 12:25:39 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711291208060.9605@xanadu.home>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0711281852160.8458@woody.linux-foundation.org>
 <alpine.LFD.0.99999.0711282244190.9605@xanadu.home>
 <alpine.LFD.0.9999.0711282022470.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 18:26:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixn9G-00010C-SS
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 18:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759661AbXK2RZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 12:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759310AbXK2RZn
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 12:25:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:26458 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758815AbXK2RZm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 12:25:42 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSA00ET832RDF01@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 29 Nov 2007 12:25:41 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.0.9999.0711282022470.8458@woody.linux-foundation.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66547>

On Wed, 28 Nov 2007, Linus Torvalds wrote:

> On Wed, 28 Nov 2007, Nicolas Pitre wrote:
> 
> > But for a checkout that should actually correspond to a nice linear 
> > access.
> 
> For the initial check-out, yes. But the thing I timed was just a plain 
> "git checkout", which won't actually do any of the blobs if they already 
> exist checked-out (which I obviously had), which explains the non-dense 
> patterns.
> 
> The reason I care about "git checkout" (which is totally uninteresting in 
> itself) is that it is a trivial use-case that fairly closely approximates 
> two common cases that are *not* uninteresting: switching branches with 
> most files unaffected and a fast-forward merge (both of which are the 
> "two-way merge" special case).

[...]

> So it's actually fairly common to have "git checkout"-like behaviour with 
> no blobs needing to be updated, and the "initial checkout" is in fact 
> likely a less usual case. I wonder if we should make the pack-file have 
> all the object types in separate regions (we already do that for commits, 
> since "git rev-list" kind of operations are dense in the commit).
> 
> Making the tree objects dense (the same way the commit objects are) might 
> also conceivably speed up "git blame" and path history simplification, 
> since those also tend to be "dense" in the tree history but don't actually 
> look at the blobs themselves until they change.

Well, see below for the patch that actually split the pack data into 
objects of the same type.  Doing that "git checkout" on the kernel tree 
did improve things for me although not spectacularly.

Current Git warm cache:		0.532s
Current Git cold cache:		17.4s

Patched Git warm cache:		0.521s
Patched Git cold cache:		14.2s

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 4f44658..b655efd 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -585,22 +585,43 @@ static off_t write_one(struct sha1file *f,
 	return offset + size;
 }
 
+static int sort_by_type(const void *_a, const void *_b)
+{
+	const struct object_entry *a = *(struct object_entry **)_a;
+	const struct object_entry *b = *(struct object_entry **)_b;
+
+	/*
+	 * Preserve recency order for objects of the same type  and reused deltas.
+	 */
+	if(a->type == OBJ_REF_DELTA || a->type == OBJ_OFS_DELTA ||
+	   b->type == OBJ_REF_DELTA || b->type == OBJ_OFS_DELTA ||
+	   a->type == b->type)
+		return (a < b) ? -1 : 1;
+	return a->type - b->type;
+}
+
 /* forward declaration for write_pack_file */
 static int adjust_perm(const char *path, mode_t mode);
 
 static void write_pack_file(void)
 {
-	uint32_t i = 0, j;
+	uint32_t i, j;
 	struct sha1file *f;
 	off_t offset, offset_one, last_obj_offset = 0;
 	struct pack_header hdr;
 	int do_progress = progress >> pack_to_stdout;
 	uint32_t nr_remaining = nr_result;
+	struct object_entry **sorted_by_type;
 
 	if (do_progress)
 		progress_state = start_progress("Writing objects", nr_result);
 	written_list = xmalloc(nr_objects * sizeof(*written_list));
+	sorted_by_type = xmalloc(nr_objects * sizeof(*sorted_by_type));
+	for (i = 0; i < nr_objects; i++)
+		sorted_by_type[i] = objects + i;
+	qsort(sorted_by_type, nr_objects, sizeof(*sorted_by_type), sort_by_type);
 
+	i = 0;
 	do {
 		unsigned char sha1[20];
 		char *pack_tmp_name = NULL;
@@ -625,7 +646,7 @@ static void write_pack_file(void)
 		nr_written = 0;
 		for (; i < nr_objects; i++) {
 			last_obj_offset = offset;
-			offset_one = write_one(f, objects + i, offset);
+			offset_one = write_one(f, sorted_by_type[i], offset);
 			if (!offset_one)
 				break;
 			offset = offset_one;
@@ -681,6 +702,7 @@ static void write_pack_file(void)
 		nr_remaining -= nr_written;
 	} while (nr_remaining && i < nr_objects);
 
+	free(sorted_by_type);
 	free(written_list);
 	stop_progress(&progress_state);
 	if (written != nr_result)
