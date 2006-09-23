From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 7/6] make pack data reuse compatible with both delta types
Date: Fri, 22 Sep 2006 21:25:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609222059570.2627@xanadu.home>
References: <Pine.LNX.4.64.0609210008360.2627@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 03:25:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQwGW-00014s-KQ
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 03:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbWIWBZJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 21:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbWIWBZI
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 21:25:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:7105 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965101AbWIWBZG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Sep 2006 21:25:06 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J6000300ULS7QC0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 22 Sep 2006 21:25:05 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0609210008360.2627@xanadu.home>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27555>

This is the missing part to git-pack-objects allowing it to reuse delta
data to/from any of the two delta types.  It can reuse delta from any 
type, and it outputs base offsets when --allow-delta-base-offset is
provided and the base is also included in the pack.  Otherwise it 
outputs base sha1 references just like it always did.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

On Thu, 21 Sep 2006, Nicolas Pitre wrote:

> Delta data reuse is possible, of course, but that will come through a
> separate patch.  I need to think about it some more in order to implement
> it as efficiently as possible.  The issue is to get back to the
> corresponding object entry given an object offset in an existing pack.

This was done with the addition of a sequence number in the revindex 
entry which is 4 additional bytes per object that has to live in memory.  
If ever this is considered too much memory usage then there is always 
the possibility of using an array of pointers to pack index entries 
instead, but then the runtime cost might be higher since the sorting and 
searching will have to dereference those pointers to get to the offset 
and endian swap it every time.  I think that memory usage should not be 
an issue in most cases, and if it is then this 4 bytes per object is 
probably not going to save much anyway.

So I think support for delta base offset is now complete.

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 2212649..6db97b6 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -29,6 +29,7 @@ struct object_entry {
 	enum object_type type;
 	enum object_type in_pack_type;	/* could be delta */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
+#define in_pack_header_size delta_size	/* only when reusing pack data */
 	struct object_entry *delta;	/* delta base object */
 	struct packed_git *in_pack; 	/* already in pack */
 	unsigned int in_pack_offset;
@@ -86,17 +87,25 @@ static int object_ix_hashsz;
  * Pack index for existing packs give us easy access to the offsets into
  * corresponding pack file where each object's data starts, but the entries
  * do not store the size of the compressed representation (uncompressed
- * size is easily available by examining the pack entry header).  We build
- * a hashtable of existing packs (pack_revindex), and keep reverse index
- * here -- pack index file is sorted by object name mapping to offset; this
- * pack_revindex[].revindex array is an ordered list of offsets, so if you
- * know the offset of an object, next offset is where its packed
- * representation ends.
+ * size is easily available by examining the pack entry header).  It is
+ * also rather expensive to find the sha1 for an object given its offset.
+ *
+ * We build a hashtable of existing packs (pack_revindex), and keep reverse
+ * index here -- pack index file is sorted by object name mapping to offset;
+ * this pack_revindex[].revindex array is a list of offset/index_nr pairs
+ * ordered by offset, so if you know the offset of an object, next offset
+ * is where its packed representation ends and the index_nr can be used to
+ * get the object sha1 from the main index.
  */
+struct revindex_entry {
+	unsigned int offset;
+	unsigned int nr;
+};
 struct pack_revindex {
 	struct packed_git *p;
-	unsigned long *revindex;
-} *pack_revindex = NULL;
+	struct revindex_entry *revindex;
+};
+static struct  pack_revindex *pack_revindex;
 static int pack_revindex_hashsz;
 
 /*
@@ -143,14 +152,9 @@ static void prepare_pack_ix(void)
 
 static int cmp_offset(const void *a_, const void *b_)
 {
-	unsigned long a = *(unsigned long *) a_;
-	unsigned long b = *(unsigned long *) b_;
-	if (a < b)
-		return -1;
-	else if (a == b)
-		return 0;
-	else
-		return 1;
+	const struct revindex_entry *a = a_;
+	const struct revindex_entry *b = b_;
+	return (a->offset < b->offset) ? -1 : (a->offset > b->offset) ? 1 : 0;
 }
 
 /*
@@ -163,25 +167,27 @@ static void prepare_pack_revindex(struct
 	int i;
 	void *index = p->index_base + 256;
 
-	rix->revindex = xmalloc(sizeof(unsigned long) * (num_ent + 1));
+	rix->revindex = xmalloc(sizeof(*rix->revindex) * (num_ent + 1));
 	for (i = 0; i < num_ent; i++) {
 		unsigned int hl = *((unsigned int *)((char *) index + 24*i));
-		rix->revindex[i] = ntohl(hl);
+		rix->revindex[i].offset = ntohl(hl);
+		rix->revindex[i].nr = i;
 	}
 	/* This knows the pack format -- the 20-byte trailer
 	 * follows immediately after the last object data.
 	 */
-	rix->revindex[num_ent] = p->pack_size - 20;
-	qsort(rix->revindex, num_ent, sizeof(unsigned long), cmp_offset);
+	rix->revindex[num_ent].offset = p->pack_size - 20;
+	rix->revindex[num_ent].nr = -1;
+	qsort(rix->revindex, num_ent, sizeof(*rix->revindex), cmp_offset);
 }
 
-static unsigned long find_packed_object_size(struct packed_git *p,
-					     unsigned long ofs)
+static struct revindex_entry * find_packed_object(struct packed_git *p,
+						  unsigned int ofs)
 {
 	int num;
 	int lo, hi;
 	struct pack_revindex *rix;
-	unsigned long *revindex;
+	struct revindex_entry *revindex;
 	num = pack_revindex_ix(p);
 	if (num < 0)
 		die("internal error: pack revindex uninitialized");
@@ -193,10 +199,10 @@ static unsigned long find_packed_object_
 	hi = num_packed_objects(p) + 1;
 	do {
 		int mi = (lo + hi) / 2;
-		if (revindex[mi] == ofs) {
-			return revindex[mi+1] - ofs;
+		if (revindex[mi].offset == ofs) {
+			return revindex + mi;
 		}
-		else if (ofs < revindex[mi])
+		else if (ofs < revindex[mi].offset)
 			hi = mi;
 		else
 			lo = mi + 1;
@@ -204,6 +210,20 @@ static unsigned long find_packed_object_
 	die("internal error: pack revindex corrupt");
 }
 
+static unsigned long find_packed_object_size(struct packed_git *p,
+					     unsigned long ofs)
+{
+	struct revindex_entry *entry = find_packed_object(p, ofs);
+	return entry[1].offset - ofs;
+}
+
+static unsigned char *find_packed_object_name(struct packed_git *p,
+					      unsigned long ofs)
+{
+	struct revindex_entry *entry = find_packed_object(p, ofs);
+	return (unsigned char *)(p->index_base + 256) + 24 * entry->nr + 4;
+}
+
 static void *delta_against(void *buf, unsigned long size, struct object_entry *entry)
 {
 	unsigned long othersize, delta_size;
@@ -249,6 +269,10 @@ static int encode_header(enum object_typ
 	return n;
 }
 
+/*
+ * we are going to reuse the existing object data as is.  make
+ * sure it is not corrupt.
+ */
 static int check_inflate(unsigned char *data, unsigned long len, unsigned long expect)
 {
 	z_stream stream;
@@ -280,32 +304,6 @@ static int check_inflate(unsigned char *
 	return st;
 }
 
-/*
- * we are going to reuse the existing pack entry data.  make
- * sure it is not corrupt.
- */
-static int revalidate_pack_entry(struct object_entry *entry, unsigned char *data, unsigned long len)
-{
-	enum object_type type;
-	unsigned long size, used;
-
-	if (pack_to_stdout)
-		return 0;
-
-	/* the caller has already called use_packed_git() for us,
-	 * so it is safe to access the pack data from mmapped location.
-	 * make sure the entry inflates correctly.
-	 */
-	used = unpack_object_header_gently(data, len, &type, &size);
-	if (!used)
-		return -1;
-	if (type == OBJ_REF_DELTA)
-		used += 20; /* skip base object name */
-	data += used;
-	len -= used;
-	return check_inflate(data, len, entry->size);
-}
-
 static int revalidate_loose_object(struct object_entry *entry,
 				   unsigned char *map,
 				   unsigned long mapsize)
@@ -339,7 +337,7 @@ static unsigned long write_object(struct
 	obj_type = entry->type;
 	if (! entry->in_pack)
 		to_reuse = 0;	/* can't reuse what we don't have */
-	else if (obj_type == OBJ_REF_DELTA)
+	else if (obj_type == OBJ_REF_DELTA || obj_type == OBJ_OFS_DELTA)
 		to_reuse = 1;	/* check_object() decided it for us */
 	else if (obj_type != entry->in_pack_type)
 		to_reuse = 0;	/* pack has delta which is unusable */
@@ -415,18 +413,38 @@ static unsigned long write_object(struct
 	}
 	else {
 		struct packed_git *p = entry->in_pack;
-		use_packed_git(p);
 
-		datalen = find_packed_object_size(p, entry->in_pack_offset);
-		buf = (char *) p->pack_base + entry->in_pack_offset;
+		if (entry->delta) {
+			obj_type = (allow_ofs_delta && entry->delta->offset) ?
+				OBJ_OFS_DELTA : OBJ_REF_DELTA;
+			reused_delta++;
+		}
+		hdrlen = encode_header(obj_type, entry->size, header);
+		sha1write(f, header, hdrlen);
+		if (obj_type == OBJ_OFS_DELTA) {
+			unsigned long ofs = entry->offset - entry->delta->offset;
+			unsigned pos = sizeof(header) - 1;
+			header[pos] = ofs & 127;
+			while (ofs >>= 7)
+				header[--pos] = 128 | (--ofs & 127);
+			sha1write(f, header + pos, sizeof(header) - pos);
+			hdrlen += sizeof(header) - pos;
+		} else if (obj_type == OBJ_REF_DELTA) {
+			sha1write(f, entry->delta->sha1, 20);
+			hdrlen += 20;
+		}
 
-		if (revalidate_pack_entry(entry, buf, datalen))
+		use_packed_git(p);
+		buf = (char *) p->pack_base
+			+ entry->in_pack_offset
+			+ entry->in_pack_header_size;
+		datalen = find_packed_object_size(p, entry->in_pack_offset)
+				- entry->in_pack_header_size;
+//fprintf(stderr, "reusing %d at %d header %d size %d\n", obj_type, entry->in_pack_offset, entry->in_pack_header_size, datalen);
+		if (!pack_to_stdout && check_inflate(buf, datalen, entry->size))
 			die("corrupt delta in pack %s", sha1_to_hex(entry->sha1));
 		sha1write(f, buf, datalen);
 		unuse_packed_git(p);
-		hdrlen = 0; /* not really */
-		if (obj_type == OBJ_REF_DELTA)
-			reused_delta++;
 		reused++;
 	}
 	if (entry->delta)
@@ -914,26 +932,64 @@ static void check_object(struct object_e
 	char type[20];
 
 	if (entry->in_pack && !entry->preferred_base) {
-		unsigned char base[20];
-		unsigned long size;
-		struct object_entry *base_entry;
+		struct packed_git *p = entry->in_pack;
+		unsigned long left = p->pack_size - entry->in_pack_offset;
+		unsigned long size, used;
+		unsigned char *buf;
+		struct object_entry *base_entry = NULL;
+
+		use_packed_git(p);
+		buf = p->pack_base;
+		buf += entry->in_pack_offset;
 
 		/* We want in_pack_type even if we do not reuse delta.
 		 * There is no point not reusing non-delta representations.
 		 */
-		check_reuse_pack_delta(entry->in_pack,
-				       entry->in_pack_offset,
-				       base, &size,
-				       &entry->in_pack_type);
+		used = unpack_object_header_gently(buf, left,
+						   &entry->in_pack_type, &size);
+		if (!used || left - used <= 20)
+			die("corrupt pack for %s", sha1_to_hex(entry->sha1));
 
 		/* Check if it is delta, and the base is also an object
 		 * we are going to pack.  If so we will reuse the existing
 		 * delta.
 		 */
-		if (!no_reuse_delta &&
-		    entry->in_pack_type == OBJ_REF_DELTA &&
-		    (base_entry = locate_object_entry(base)) &&
-		    (!base_entry->preferred_base)) {
+		if (!no_reuse_delta) {
+			unsigned char c, *base_name;
+			unsigned long ofs;
+			/* there is at least 20 bytes left in the pack */
+			switch (entry->in_pack_type) {
+			case OBJ_REF_DELTA:
+				base_name = buf + used;
+				used += 20;
+				break;
+			case OBJ_OFS_DELTA:
+				c = buf[used++];
+				ofs = c & 127;
+				while (c & 128) {
+					ofs += 1;
+					if (!ofs || ofs & ~(~0UL >> 7))
+						die("delta base offset overflow in pack for %s",
+						    sha1_to_hex(entry->sha1));
+					c = buf[used++];
+					ofs = (ofs << 7) + (c & 127);
+				}
+				if (ofs >= entry->in_pack_offset)
+					die("delta base offset out of bound for %s",
+					    sha1_to_hex(entry->sha1));
+				ofs = entry->in_pack_offset - ofs;
+				base_name = find_packed_object_name(p, ofs);
+				break;
+			default:
+				base_name = NULL;
+			}
+			if (base_name)
+				base_entry = locate_object_entry(base_name);
+		}
+		unuse_packed_git(p);
+		entry->in_pack_header_size = used;
+
+		if (base_entry && !base_entry->preferred_base) {
 
 			/* Depth value does not matter - find_deltas()
 			 * will never consider reused delta as the
@@ -942,9 +998,9 @@ static void check_object(struct object_e
 			 */
 
 			/* uncompressed size of the delta data */
-			entry->size = entry->delta_size = size;
+			entry->size = size;
 			entry->delta = base_entry;
-			entry->type = OBJ_REF_DELTA;
+			entry->type = entry->in_pack_type;
 
 			entry->delta_sibling = base_entry->delta_child;
 			base_entry->delta_child = entry;
@@ -1500,7 +1556,7 @@ int cmd_pack_objects(int argc, const cha
 			continue;
 		}
 		if (!strcmp("--delta-base-offset", arg)) {
-			allow_ofs_delta = no_reuse_delta = 1;
+			allow_ofs_delta = 1;
 			continue;
 		}
 		if (!strcmp("--stdout", arg)) {
diff --git a/pack.h b/pack.h
index 05557da..4c9bddd 100644
--- a/pack.h
+++ b/pack.h
@@ -16,7 +16,4 @@ struct pack_header {
 };
 
 extern int verify_pack(struct packed_git *, int);
-extern int check_reuse_pack_delta(struct packed_git *, unsigned long,
-				  unsigned char *, unsigned long *,
-				  enum object_type *);
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 66ebdde..e4bc4ae 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1004,25 +1004,6 @@ static unsigned long unpack_object_heade
 	return offset + used;
 }
 
-int check_reuse_pack_delta(struct packed_git *p, unsigned long offset,
-			   unsigned char *base, unsigned long *sizep,
-			   enum object_type *kindp)
-{
-	unsigned long ptr;
-	int status = -1;
-
-	use_packed_git(p);
-	ptr = offset;
-	ptr = unpack_object_header(p, ptr, kindp, sizep);
-	if (*kindp != OBJ_REF_DELTA)
-		goto done;
-	hashcpy(base, (unsigned char *) p->pack_base + ptr);
-	status = 0;
- done:
-	unuse_packed_git(p);
-	return status;
-}
-
 void packed_object_info_detail(struct packed_git *p,
 			       unsigned long offset,
 			       char *type,
