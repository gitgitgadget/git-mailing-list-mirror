From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 6/6] make git-pack-objects able to create deltas with offset to
 base
Date: Thu, 21 Sep 2006 00:09:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609210008360.2627@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 06:10:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQFsj-0007BP-71
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 06:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWIUEJr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 00:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWIUEJq
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 00:09:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:1260 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750855AbWIUEJp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 00:09:45 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J5X0071ACW8T710@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 21 Sep 2006 00:09:45 -0400 (EDT)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27448>


This is enabled with --delta-base-offset only, and doesn't work with
pack data reuse yet.

The idea is to allow for the fetch protocol to use an extension flag
to notify the remote end that --delta-base-offset can be used with
git-pack-objects. Eventually git-repack will always provide this flag.

With this, all delta base objects are now pushed before deltas that depend
on them.  This is a requirements for OBJ_OFS_DELTA.  This is not a
requirement for OBJ_REF_DELTA but always doing so makes the code simpler.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

Delta data reuse is possible, of course, but that will come through a
separate patch.  I need to think about it some more in order to implement
it as efficiently as possible.  The issue is to get back to the
corresponding object entry given an object offset in an existing pack.

I guess I could use the pack offset to find the corresponding sha1 in the pack
index, and then use locate_object_entry_hash(), but that would require a pack
index sorted by offset to be efficient... which means yet more memory usage.
Well, I need to look at that revindex more closely I guess...

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index c62734a..ec57536 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -60,6 +60,8 @@ static int non_empty;
 static int no_reuse_delta;
 static int local;
 static int incremental;
+static int allow_ofs_delta;
+
 static struct object_entry **sorted_by_sha, **sorted_by_type;
 static struct object_entry *objects;
 static int nr_objects, nr_alloc, nr_result;
@@ -334,9 +336,6 @@ static unsigned long write_object(struct
 	enum object_type obj_type;
 	int to_reuse = 0;
 
-	if (entry->preferred_base)
-		return 0;
-
 	obj_type = entry->type;
 	if (! entry->in_pack)
 		to_reuse = 0;	/* can't reuse what we don't have */
@@ -380,18 +379,35 @@ static unsigned long write_object(struct
 		if (entry->delta) {
 			buf = delta_against(buf, size, entry);
 			size = entry->delta_size;
-			obj_type = OBJ_REF_DELTA;
+			obj_type = (allow_ofs_delta && entry->delta->offset) ?
+				OBJ_OFS_DELTA : OBJ_REF_DELTA;
 		}
 		/*
 		 * The object header is a byte of 'type' followed by zero or
-		 * more bytes of length.  For deltas, the 20 bytes of delta
-		 * sha1 follows that.
+		 * more bytes of length.
 		 */
 		hdrlen = encode_header(obj_type, size, header);
 		sha1write(f, header, hdrlen);
 
-		if (entry->delta) {
-			sha1write(f, entry->delta, 20);
+		if (obj_type == OBJ_OFS_DELTA) {
+			/*
+			 * Deltas with relative base contain an additional
+			 * encoding of the relative offset for the delta
+			 * base from this object's position in the pack.
+			 */
+			unsigned long ofs = entry->offset - entry->delta->offset;
+			unsigned pos = sizeof(header) - 1;
+			header[pos] = ofs & 127;
+			while (ofs >>= 7)
+				header[--pos] = 128 | (--ofs & 127);
+			sha1write(f, header + pos, sizeof(header) - pos);
+			hdrlen += sizeof(header) - pos;
+		} else if (obj_type == OBJ_REF_DELTA) {
+			/*
+			 * Deltas with a base reference contain
+			 * an additional 20 bytes for the base sha1.
+			 */
+			sha1write(f, entry->delta->sha1, 20);
 			hdrlen += 20;
 		}
 		datalen = sha1write_compressed(f, buf, size);
@@ -413,7 +429,7 @@ static unsigned long write_object(struct
 			reused_delta++;
 		reused++;
 	}
-	if (obj_type == OBJ_REF_DELTA)
+	if (entry->delta)
 		written_delta++;
 	written++;
 	return hdrlen + datalen;
@@ -423,17 +439,16 @@ static unsigned long write_one(struct sh
 			       struct object_entry *e,
 			       unsigned long offset)
 {
-	if (e->offset)
+	if (e->offset || e->preferred_base)
 		/* offset starts from header size and cannot be zero
 		 * if it is written already.
 		 */
 		return offset;
-	e->offset = offset;
-	offset += write_object(f, e);
-	/* if we are deltified, write out its base object. */
+	/* if we are deltified, write out its base object first. */
 	if (e->delta)
 		offset = write_one(f, e->delta, offset);
-	return offset;
+	e->offset = offset;
+	return offset + write_object(f, e);
 }
 
 static void write_pack_file(void)
@@ -1484,6 +1499,10 @@ int cmd_pack_objects(int argc, const cha
 			no_reuse_delta = 1;
 			continue;
 		}
+		if (!strcmp("--delta-base-offset", arg)) {
+			allow_ofs_delta = no_reuse_delta = 1;
+			continue;
+		}
 		if (!strcmp("--stdout", arg)) {
 			pack_to_stdout = 1;
 			continue;
