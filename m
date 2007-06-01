From: Geert Bosch <bosch@gnat.com>
Subject: [PATCH] Unify write_index_file functions
Date: Fri, 1 Jun 2007 15:18:05 -0400
Message-ID: <20070602013919.4B0334DF0C8@geert-boschs-computer.local>
References: <7vy7j3xwg5.fsf@assigned-by-dhcp.cox.net>
Cc: Nicolas Pitre <nico@cam.org>, Dana How <danahow@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 02 03:39:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuIak-0007LF-R0
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 03:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759797AbXFBBjT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 21:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759841AbXFBBjT
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 21:39:19 -0400
Received: from nile.gnat.com ([205.232.38.5]:61225 "EHLO nile.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759756AbXFBBjR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 21:39:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 5229848CF7F;
	Fri,  1 Jun 2007 21:39:16 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 20538-01-3; Fri,  1 Jun 2007 21:39:14 -0400 (EDT)
Received: from geert-boschs-computer.local (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	by nile.gnat.com (Postfix) with ESMTP id 9DB5B48CC7D;
	Fri,  1 Jun 2007 21:39:13 -0400 (EDT)
Received: by geert-boschs-computer.local (Postfix, from userid 4190)
	id 4B0334DF0C8; Fri,  1 Jun 2007 21:39:19 -0400 (EDT)
In-Reply-To: <7vy7j3xwg5.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48906>

This patch creates a new pack-idx.c file containing a unified version of
the write_index_file functions in builtin-pack-objects.c and index-pack.c.
As the name "index" is overloaded in git, move in the direction
of using "idx" and "pack idx" when refering to the pack index.
There should be no change in functionality.

Signed-off-by: Geert Bosch <bosch@gnat.com>
---
 builtin-pack-objects.c |  218 +++++++++++-------------------------------------
 index-pack.c           |  208 ++++++++-------------------------------------
 pack-write.c           |  142 +++++++++++++++++++++++++++++++
 pack.h                 |   14 +++
 4 files changed, 243 insertions(+), 339 deletions(-)


On Jun 1, 2007, at 16:15, Junio C Hamano wrote:
>Why?  off_t offset used to be 8-byte aligned but now it is not...
[snip]
>Ah, you wanted to match the shape of the early part of two
>structures.  Sounds error prone for people who would want to
>maintain both programs in the future.

Indeed, and I didn't catch that there was a special order
for efficiency.
>Why not make the private "struct object_entry" in each users
>have an embedded structure at the beginning like this:
I thought about that, but wanted to have a change as small
as possible. This version incorporates the suggestion.

On Jun 1, 2007, at 16:16, Dana How wrote:
>Good stuff.  3 minor issues:

>(1) Shawn named the new file containing common pack-writing
>functions "pack-write.c"; in that spirit should your new file
>be "idx-write.c" ?
Added this to pack-write.c as suggested by Nicolas.

>(2) write_idx_file has a sha1 argument with different in & out
>meanings, requiring copies at some call sites. Should this be 2
>separate args?
Again, I wanted to keep the change as small as possible. Also, one 
extra copy of a SHA1 per generated index is just not worth bothering
about.  As noted by Nicolas, the file-global static variable should
just be removed altogether.

>(3) 2 files now have definitions of "struct object_entry" with no
>indications >that the first 4 fields should be the same as
>"struct idx_object_entry". Please add at least some comments
>to the former (this is the only thing I care strongly about here).
>Better would be putting an idx_object_entry as the first field in
>the object_entry's, but that would result in a lot of trivial
>changes and could be done later.

That was the reason I avoided that change initially, but it's included
in this version.

On Jun 1, 2007, at 16:54, Nicolas Pitre wrote:
>I intended to do exactly that (I even mentioned it in 81a216a5d6) but 
>I'm glad you beat me to it.

I'd like all code that knows about the index file format to
be more centralized, but was holding off until after your index V2
changes.

>A few comments.
>
>Please use pack-write.c rather than a new file.  This pack-write.c
>was created exactly to gather common pack writing tasks.

OK, as done in this patch. 

>Please also consider removing the pack index writing code from 
>fast-import.c as well.
Well, that would be a follow-up patch. I'd like to keep each change
as small as possible.

[about changing field ordering]
>Don't do this.  The crc32 field was carefully placed so the offset
>field is 64-bit aligned with no need for any padding.
OK, missed that.

>In fact, those 3 fields should probably be defined in a structure of 
>their own rather than hoping that no one will fail to change the 
>ordering in all places.
Sure.

This version should have addressed all noted issues.

  -Geert

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index e52332d..a247238 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -23,10 +23,9 @@ git-pack-objects [{ -q | --progress | --all-progress }] [--max-pack-size=N] \n\
 	[--stdout | base-name] [<ref-list | <object-list]";
 
 struct object_entry {
-	unsigned char sha1[20];
-	uint32_t crc32;		/* crc of raw pack data for this object */
-	off_t offset;		/* offset into the final pack file */
+	struct pack_idx_entry idx;
 	unsigned long size;	/* uncompressed size */
+
 	unsigned int hash;	/* name hint hash */
 	unsigned int depth;	/* delta depth */
 	struct packed_git *in_pack; 	/* already in pack */
@@ -65,7 +64,6 @@ static int allow_ofs_delta;
 static const char *pack_tmp_name, *idx_tmp_name;
 static char tmpname[PATH_MAX];
 static const char *base_name;
-static unsigned char pack_file_sha1[20];
 static int progress = 1;
 static int window = 10;
 static uint32_t pack_size_limit;
@@ -241,11 +239,11 @@ static void *delta_against(void *buf, unsigned long size, struct object_entry *e
 {
 	unsigned long othersize, delta_size;
 	enum object_type type;
-	void *otherbuf = read_sha1_file(entry->delta->sha1, &type, &othersize);
+	void *otherbuf = read_sha1_file(entry->delta->idx.sha1, &type, &othersize);
 	void *delta_buf;
 
 	if (!otherbuf)
-		die("unable to read %s", sha1_to_hex(entry->delta->sha1));
+		die("unable to read %s", sha1_to_hex(entry->delta->idx.sha1));
         delta_buf = diff_delta(otherbuf, othersize,
 			       buf, size, &delta_size, 0);
         if (!delta_buf || delta_size != entry->delta_size)
@@ -374,11 +372,11 @@ static unsigned long write_object(struct sha1file *f,
 				/* yes if unlimited packfile */
 				!pack_size_limit ? 1 :
 				/* no if base written to previous pack */
-				entry->delta->offset == (off_t)-1 ? 0 :
+				entry->delta->idx.offset == (off_t)-1 ? 0 :
 				/* otherwise double-check written to this
 				 * pack,  like we do below
 				 */
-				entry->delta->offset ? 1 : 0;
+				entry->delta->idx.offset ? 1 : 0;
 
 	if (!pack_to_stdout)
 		crc32_begin(f);
@@ -405,16 +403,16 @@ static unsigned long write_object(struct sha1file *f,
 		z_stream stream;
 		unsigned long maxsize;
 		void *out;
-		buf = read_sha1_file(entry->sha1, &type, &size);
+		buf = read_sha1_file(entry->idx.sha1, &type, &size);
 		if (!buf)
-			die("unable to read %s", sha1_to_hex(entry->sha1));
+			die("unable to read %s", sha1_to_hex(entry->idx.sha1));
 		if (size != entry->size)
 			die("object %s size inconsistency (%lu vs %lu)",
-			    sha1_to_hex(entry->sha1), size, entry->size);
+			    sha1_to_hex(entry->idx.sha1), size, entry->size);
 		if (usable_delta) {
 			buf = delta_against(buf, size, entry);
 			size = entry->delta_size;
-			obj_type = (allow_ofs_delta && entry->delta->offset) ?
+			obj_type = (allow_ofs_delta && entry->delta->idx.offset) ?
 				OBJ_OFS_DELTA : OBJ_REF_DELTA;
 		} else {
 			/*
@@ -451,7 +449,7 @@ static unsigned long write_object(struct sha1file *f,
 			 * encoding of the relative offset for the delta
 			 * base from this object's position in the pack.
 			 */
-			off_t ofs = entry->offset - entry->delta->offset;
+			off_t ofs = entry->idx.offset - entry->delta->idx.offset;
 			unsigned pos = sizeof(dheader) - 1;
 			dheader[pos] = ofs & 127;
 			while (ofs >>= 7)
@@ -475,7 +473,7 @@ static unsigned long write_object(struct sha1file *f,
 				return 0;
 			}
 			sha1write(f, header, hdrlen);
-			sha1write(f, entry->delta->sha1, 20);
+			sha1write(f, entry->delta->idx.sha1, 20);
 			hdrlen += 20;
 		} else {
 			if (limit && hdrlen + datalen + 20 >= limit) {
@@ -496,7 +494,7 @@ static unsigned long write_object(struct sha1file *f,
 		off_t offset;
 
 		if (entry->delta) {
-			obj_type = (allow_ofs_delta && entry->delta->offset) ?
+			obj_type = (allow_ofs_delta && entry->delta->idx.offset) ?
 				OBJ_OFS_DELTA : OBJ_REF_DELTA;
 			reused_delta++;
 		}
@@ -506,11 +504,11 @@ static unsigned long write_object(struct sha1file *f,
 		datalen = revidx[1].offset - offset;
 		if (!pack_to_stdout && p->index_version > 1 &&
 		    check_pack_crc(p, &w_curs, offset, datalen, revidx->nr))
-			die("bad packed object CRC for %s", sha1_to_hex(entry->sha1));
+			die("bad packed object CRC for %s", sha1_to_hex(entry->idx.sha1));
 		offset += entry->in_pack_header_size;
 		datalen -= entry->in_pack_header_size;
 		if (obj_type == OBJ_OFS_DELTA) {
-			off_t ofs = entry->offset - entry->delta->offset;
+			off_t ofs = entry->idx.offset - entry->delta->idx.offset;
 			unsigned pos = sizeof(dheader) - 1;
 			dheader[pos] = ofs & 127;
 			while (ofs >>= 7)
@@ -524,7 +522,7 @@ static unsigned long write_object(struct sha1file *f,
 			if (limit && hdrlen + 20 + datalen + 20 >= limit)
 				return 0;
 			sha1write(f, header, hdrlen);
-			sha1write(f, entry->delta->sha1, 20);
+			sha1write(f, entry->delta->idx.sha1, 20);
 			hdrlen += 20;
 		} else {
 			if (limit && hdrlen + datalen + 20 >= limit)
@@ -534,7 +532,7 @@ static unsigned long write_object(struct sha1file *f,
 
 		if (!pack_to_stdout && p->index_version == 1 &&
 		    check_pack_inflate(p, &w_curs, offset, datalen, entry->size))
-			die("corrupt packed object for %s", sha1_to_hex(entry->sha1));
+			die("corrupt packed object for %s", sha1_to_hex(entry->idx.sha1));
 		copy_pack_data(f, p, &w_curs, offset, datalen);
 		unuse_pack(&w_curs);
 		reused++;
@@ -543,7 +541,7 @@ static unsigned long write_object(struct sha1file *f,
 		written_delta++;
 	written++;
 	if (!pack_to_stdout)
-		entry->crc32 = crc32_end(f);
+		entry->idx.crc32 = crc32_end(f);
 	return hdrlen + datalen;
 }
 
@@ -554,7 +552,7 @@ static off_t write_one(struct sha1file *f,
 	unsigned long size;
 
 	/* offset is non zero if object is written already. */
-	if (e->offset || e->preferred_base)
+	if (e->idx.offset || e->preferred_base)
 		return offset;
 
 	/* if we are deltified, write out base object first. */
@@ -564,10 +562,10 @@ static off_t write_one(struct sha1file *f,
 			return 0;
 	}
 
-	e->offset = offset;
+	e->idx.offset = offset;
 	size = write_object(f, e, offset);
 	if (!size) {
-		e->offset = 0;
+		e->idx.offset = 0;
 		return 0;
 	}
 	written_list[nr_written++] = e;
@@ -584,8 +582,7 @@ static int open_object_dir_tmp(const char *path)
     return mkstemp(tmpname);
 }
 
-/* forward declarations for write_pack_file */
-static void write_index_file(off_t last_obj_offset, unsigned char *sha1);
+/* forward declaration for write_pack_file */
 static int adjust_perm(const char *path, mode_t mode);
 
 static void write_pack_file(void)
@@ -602,6 +599,8 @@ static void write_pack_file(void)
 	written_list = xmalloc(nr_objects * sizeof(struct object_entry *));
 
 	do {
+		unsigned char sha1[20];
+
 		if (pack_to_stdout) {
 			f = sha1fd(1, "<stdout>");
 		} else {
@@ -633,23 +632,23 @@ static void write_pack_file(void)
 		 * If so, rewrite it like in fast-import
 		 */
 		if (pack_to_stdout || nr_written == nr_remaining) {
-			sha1close(f, pack_file_sha1, 1);
+			sha1close(f, sha1, 1);
 		} else {
-			sha1close(f, pack_file_sha1, 0);
-			fixup_pack_header_footer(f->fd, pack_file_sha1, pack_tmp_name, nr_written);
+			sha1close(f, sha1, 0);
+			fixup_pack_header_footer(f->fd, sha1, pack_tmp_name, nr_written);
 			close(f->fd);
 		}
 
 		if (!pack_to_stdout) {
-			unsigned char object_list_sha1[20];
 			mode_t mode = umask(0);
 
 			umask(mode);
 			mode = 0444 & ~mode;
 
-			write_index_file(last_obj_offset, object_list_sha1);
+			idx_tmp_name = write_idx_file(NULL,
+				(struct pack_idx_entry **) written_list, nr_written, sha1);
 			snprintf(tmpname, sizeof(tmpname), "%s-%s.pack",
-				 base_name, sha1_to_hex(object_list_sha1));
+				 base_name, sha1_to_hex(sha1));
 			if (adjust_perm(pack_tmp_name, mode))
 				die("unable to make temporary pack file readable: %s",
 				    strerror(errno));
@@ -657,19 +656,19 @@ static void write_pack_file(void)
 				die("unable to rename temporary pack file: %s",
 				    strerror(errno));
 			snprintf(tmpname, sizeof(tmpname), "%s-%s.idx",
-				 base_name, sha1_to_hex(object_list_sha1));
+				 base_name, sha1_to_hex(sha1));
 			if (adjust_perm(idx_tmp_name, mode))
 				die("unable to make temporary index file readable: %s",
 				    strerror(errno));
 			if (rename(idx_tmp_name, tmpname))
 				die("unable to rename temporary index file: %s",
 				    strerror(errno));
-			puts(sha1_to_hex(object_list_sha1));
+			puts(sha1_to_hex(sha1));
 		}
 
 		/* mark written objects as written to previous pack */
 		for (j = 0; j < nr_written; j++) {
-			written_list[j]->offset = (off_t)-1;
+			written_list[j]->idx.offset = (off_t)-1;
 		}
 		nr_remaining -= nr_written;
 	} while (nr_remaining && i < nr_objects);
@@ -687,129 +686,12 @@ static void write_pack_file(void)
 	 */
 	for (j = 0; i < nr_objects; i++) {
 		struct object_entry *e = objects + i;
-		j += !e->offset && !e->preferred_base;
+		j += !e->idx.offset && !e->preferred_base;
 	}
 	if (j)
 		die("wrote %u objects as expected but %u unwritten", written, j);
 }
 
-static int sha1_sort(const void *_a, const void *_b)
-{
-	const struct object_entry *a = *(struct object_entry **)_a;
-	const struct object_entry *b = *(struct object_entry **)_b;
-	return hashcmp(a->sha1, b->sha1);
-}
-
-static uint32_t index_default_version = 1;
-static uint32_t index_off32_limit = 0x7fffffff;
-
-static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
-{
-	struct sha1file *f;
-	struct object_entry **sorted_by_sha, **list, **last;
-	uint32_t array[256];
-	uint32_t i, index_version;
-	SHA_CTX ctx;
-
-	int fd = open_object_dir_tmp("tmp_idx_XXXXXX");
-	if (fd < 0)
-		die("unable to create %s: %s\n", tmpname, strerror(errno));
-	idx_tmp_name = xstrdup(tmpname);
-	f = sha1fd(fd, idx_tmp_name);
-
-	if (nr_written) {
-		sorted_by_sha = written_list;
-		qsort(sorted_by_sha, nr_written, sizeof(*sorted_by_sha), sha1_sort);
-		list = sorted_by_sha;
-		last = sorted_by_sha + nr_written;
-	} else
-		sorted_by_sha = list = last = NULL;
-
-	/* if last object's offset is >= 2^31 we should use index V2 */
-	index_version = (last_obj_offset >> 31) ? 2 : index_default_version;
-
-	/* index versions 2 and above need a header */
-	if (index_version >= 2) {
-		struct pack_idx_header hdr;
-		hdr.idx_signature = htonl(PACK_IDX_SIGNATURE);
-		hdr.idx_version = htonl(index_version);
-		sha1write(f, &hdr, sizeof(hdr));
-	}
-
-	/*
-	 * Write the first-level table (the list is sorted,
-	 * but we use a 256-entry lookup to be able to avoid
-	 * having to do eight extra binary search iterations).
-	 */
-	for (i = 0; i < 256; i++) {
-		struct object_entry **next = list;
-		while (next < last) {
-			struct object_entry *entry = *next;
-			if (entry->sha1[0] != i)
-				break;
-			next++;
-		}
-		array[i] = htonl(next - sorted_by_sha);
-		list = next;
-	}
-	sha1write(f, array, 256 * 4);
-
-	/* Compute the SHA1 hash of sorted object names. */
-	SHA1_Init(&ctx);
-
-	/* Write the actual SHA1 entries. */
-	list = sorted_by_sha;
-	for (i = 0; i < nr_written; i++) {
-		struct object_entry *entry = *list++;
-		if (index_version < 2) {
-			uint32_t offset = htonl(entry->offset);
-			sha1write(f, &offset, 4);
-		}
-		sha1write(f, entry->sha1, 20);
-		SHA1_Update(&ctx, entry->sha1, 20);
-	}
-
-	if (index_version >= 2) {
-		unsigned int nr_large_offset = 0;
-
-		/* write the crc32 table */
-		list = sorted_by_sha;
-		for (i = 0; i < nr_written; i++) {
-			struct object_entry *entry = *list++;
-			uint32_t crc32_val = htonl(entry->crc32);
-			sha1write(f, &crc32_val, 4);
-		}
-
-		/* write the 32-bit offset table */
-		list = sorted_by_sha;
-		for (i = 0; i < nr_written; i++) {
-			struct object_entry *entry = *list++;
-			uint32_t offset = (entry->offset <= index_off32_limit) ?
-				entry->offset : (0x80000000 | nr_large_offset++);
-			offset = htonl(offset);
-			sha1write(f, &offset, 4);
-		}
-
-		/* write the large offset table */
-		list = sorted_by_sha;
-		while (nr_large_offset) {
-			struct object_entry *entry = *list++;
-			uint64_t offset = entry->offset;
-			if (offset > index_off32_limit) {
-				uint32_t split[2];
-				split[0]        = htonl(offset >> 32);
-				split[1] = htonl(offset & 0xffffffff);
-				sha1write(f, split, 8);
-				nr_large_offset--;
-			}
-		}
-	}
-
-	sha1write(f, pack_file_sha1, 20);
-	sha1close(f, NULL, 1);
-	SHA1_Final(sha1, &ctx);
-}
-
 static int locate_object_entry_hash(const unsigned char *sha1)
 {
 	int i;
@@ -817,7 +699,7 @@ static int locate_object_entry_hash(const unsigned char *sha1)
 	memcpy(&ui, sha1, sizeof(unsigned int));
 	i = ui % object_ix_hashsz;
 	while (0 < object_ix[i]) {
-		if (!hashcmp(sha1, objects[object_ix[i] - 1].sha1))
+		if (!hashcmp(sha1, objects[object_ix[i] - 1].idx.sha1))
 			return i;
 		if (++i == object_ix_hashsz)
 			i = 0;
@@ -849,7 +731,7 @@ static void rehash_objects(void)
 	object_ix = xrealloc(object_ix, sizeof(int) * object_ix_hashsz);
 	memset(object_ix, 0, sizeof(int) * object_ix_hashsz);
 	for (i = 0, oe = objects; i < nr_objects; i++, oe++) {
-		int ix = locate_object_entry_hash(oe->sha1);
+		int ix = locate_object_entry_hash(oe->idx.sha1);
 		if (0 <= ix)
 			continue;
 		ix = -1 - ix;
@@ -943,7 +825,7 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 
 	entry = objects + nr_objects++;
 	memset(entry, 0, sizeof(*entry));
-	hashcpy(entry->sha1, sha1);
+	hashcpy(entry->idx.sha1, sha1);
 	entry->hash = hash;
 	if (type)
 		entry->type = type;
@@ -1263,13 +1145,13 @@ static void check_object(struct object_entry *entry)
 				ofs += 1;
 				if (!ofs || MSB(ofs, 7))
 					die("delta base offset overflow in pack for %s",
-					    sha1_to_hex(entry->sha1));
+					    sha1_to_hex(entry->idx.sha1));
 				c = buf[used_0++];
 				ofs = (ofs << 7) + (c & 127);
 			}
 			if (ofs >= entry->in_pack_offset)
 				die("delta base offset out of bound for %s",
-				    sha1_to_hex(entry->sha1));
+				    sha1_to_hex(entry->idx.sha1));
 			ofs = entry->in_pack_offset - ofs;
 			if (!no_reuse_delta && !entry->preferred_base)
 				base_ref = find_packed_object_name(p, ofs);
@@ -1316,10 +1198,10 @@ static void check_object(struct object_entry *entry)
 		unuse_pack(&w_curs);
 	}
 
-	entry->type = sha1_object_info(entry->sha1, &entry->size);
+	entry->type = sha1_object_info(entry->idx.sha1, &entry->size);
 	if (entry->type < 0)
 		die("unable to get type of object %s",
-		    sha1_to_hex(entry->sha1));
+		    sha1_to_hex(entry->idx.sha1));
 }
 
 static int pack_offset_sort(const void *_a, const void *_b)
@@ -1329,7 +1211,7 @@ static int pack_offset_sort(const void *_a, const void *_b)
 
 	/* avoid filesystem trashing with loose objects */
 	if (!a->in_pack && !b->in_pack)
-		return hashcmp(a->sha1, b->sha1);
+		return hashcmp(a->idx.sha1, b->idx.sha1);
 
 	if (a->in_pack < b->in_pack)
 		return -1;
@@ -1441,16 +1323,16 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
 	/* Load data if not already done */
 	if (!trg->data) {
-		trg->data = read_sha1_file(trg_entry->sha1, &type, &sz);
+		trg->data = read_sha1_file(trg_entry->idx.sha1, &type, &sz);
 		if (sz != trg_size)
 			die("object %s inconsistent object length (%lu vs %lu)",
-			    sha1_to_hex(trg_entry->sha1), sz, trg_size);
+			    sha1_to_hex(trg_entry->idx.sha1), sz, trg_size);
 	}
 	if (!src->data) {
-		src->data = read_sha1_file(src_entry->sha1, &type, &sz);
+		src->data = read_sha1_file(src_entry->idx.sha1, &type, &sz);
 		if (sz != src_size)
 			die("object %s inconsistent object length (%lu vs %lu)",
-			    sha1_to_hex(src_entry->sha1), sz, src_size);
+			    sha1_to_hex(src_entry->idx.sha1), sz, src_size);
 	}
 	if (!src->index) {
 		src->index = create_delta_index(src->data, src_size);
@@ -1825,12 +1707,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		}
 		if (!prefixcmp(arg, "--index-version=")) {
 			char *c;
-			index_default_version = strtoul(arg + 16, &c, 10);
-			if (index_default_version > 2)
+			pack_idx_default_version = strtoul(arg + 16, &c, 10);
+			if (pack_idx_default_version > 2)
 				die("bad %s", arg);
 			if (*c == ',')
-				index_off32_limit = strtoul(c+1, &c, 0);
-			if (*c || index_off32_limit & 0x80000000)
+				pack_idx_off32_limit = strtoul(c+1, &c, 0);
+			if (*c || pack_idx_off32_limit & 0x80000000)
 				die("bad %s", arg);
 			continue;
 		}
diff --git a/index-pack.c b/index-pack.c
index 58c4a9c..82c8da3 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -13,13 +13,11 @@ static const char index_pack_usage[] =
 
 struct object_entry
 {
-	off_t offset;
+	struct pack_idx_entry idx;
 	unsigned long size;
 	unsigned int hdr_size;
-	uint32_t crc32;
 	enum object_type type;
 	enum object_type real_type;
-	unsigned char sha1[20];
 };
 
 union delta_base {
@@ -197,7 +195,7 @@ static void *unpack_raw_entry(struct object_entry *obj, union delta_base *delta_
 	unsigned shift;
 	void *data;
 
-	obj->offset = consumed_bytes;
+	obj->idx.offset = consumed_bytes;
 	input_crc32 = crc32(0, Z_NULL, 0);
 
 	p = fill(1);
@@ -229,15 +227,15 @@ static void *unpack_raw_entry(struct object_entry *obj, union delta_base *delta_
 		while (c & 128) {
 			base_offset += 1;
 			if (!base_offset || MSB(base_offset, 7))
-				bad_object(obj->offset, "offset value overflow for delta base object");
+				bad_object(obj->idx.offset, "offset value overflow for delta base object");
 			p = fill(1);
 			c = *p;
 			use(1);
 			base_offset = (base_offset << 7) + (c & 127);
 		}
-		delta_base->offset = obj->offset - base_offset;
-		if (delta_base->offset >= obj->offset)
-			bad_object(obj->offset, "delta base offset is out of bound");
+		delta_base->offset = obj->idx.offset - base_offset;
+		if (delta_base->offset >= obj->idx.offset)
+			bad_object(obj->idx.offset, "delta base offset is out of bound");
 		break;
 	case OBJ_COMMIT:
 	case OBJ_TREE:
@@ -245,19 +243,19 @@ static void *unpack_raw_entry(struct object_entry *obj, union delta_base *delta_
 	case OBJ_TAG:
 		break;
 	default:
-		bad_object(obj->offset, "unknown object type %d", obj->type);
+		bad_object(obj->idx.offset, "unknown object type %d", obj->type);
 	}
-	obj->hdr_size = consumed_bytes - obj->offset;
+	obj->hdr_size = consumed_bytes - obj->idx.offset;
 
-	data = unpack_entry_data(obj->offset, obj->size);
-	obj->crc32 = input_crc32;
+	data = unpack_entry_data(obj->idx.offset, obj->size);
+	obj->idx.crc32 = input_crc32;
 	return data;
 }
 
 static void *get_data_from_pack(struct object_entry *obj)
 {
-	unsigned long from = obj[0].offset + obj[0].hdr_size;
-	unsigned long len = obj[1].offset - from;
+	unsigned long from = obj[0].idx.offset + obj[0].hdr_size;
+	unsigned long len = obj[1].idx.offset - from;
 	unsigned long rdy = 0;
 	unsigned char *src, *data;
 	z_stream stream;
@@ -360,11 +358,11 @@ static void resolve_delta(struct object_entry *delta_obj, void *base_data,
 			     &result_size);
 	free(delta_data);
 	if (!result)
-		bad_object(delta_obj->offset, "failed to apply delta");
-	sha1_object(result, result_size, type, delta_obj->sha1);
+		bad_object(delta_obj->idx.offset, "failed to apply delta");
+	sha1_object(result, result_size, type, delta_obj->idx.sha1);
 	nr_resolved_deltas++;
 
-	hashcpy(delta_base.sha1, delta_obj->sha1);
+	hashcpy(delta_base.sha1, delta_obj->idx.sha1);
 	if (!find_delta_children(&delta_base, &first, &last)) {
 		for (j = first; j <= last; j++) {
 			struct object_entry *child = objects + deltas[j].obj_no;
@@ -374,7 +372,7 @@ static void resolve_delta(struct object_entry *delta_obj, void *base_data,
 	}
 
 	memset(&delta_base, 0, sizeof(delta_base));
-	delta_base.offset = delta_obj->offset;
+	delta_base.offset = delta_obj->idx.offset;
 	if (!find_delta_children(&delta_base, &first, &last)) {
 		for (j = first; j <= last; j++) {
 			struct object_entry *child = objects + deltas[j].obj_no;
@@ -418,12 +416,12 @@ static void parse_pack_objects(unsigned char *sha1)
 			delta->obj_no = i;
 			delta++;
 		} else
-			sha1_object(data, obj->size, obj->type, obj->sha1);
+			sha1_object(data, obj->size, obj->type, obj->idx.sha1);
 		free(data);
 		if (verbose)
 			display_progress(&progress, i+1);
 	}
-	objects[i].offset = consumed_bytes;
+	objects[i].idx.offset = consumed_bytes;
 	if (verbose)
 		stop_progress(&progress);
 
@@ -465,10 +463,10 @@ static void parse_pack_objects(unsigned char *sha1)
 
 		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA)
 			continue;
-		hashcpy(base.sha1, obj->sha1);
+		hashcpy(base.sha1, obj->idx.sha1);
 		ref = !find_delta_children(&base, &ref_first, &ref_last);
 		memset(&base, 0, sizeof(base));
-		base.offset = obj->offset;
+		base.offset = obj->idx.offset;
 		ofs = !find_delta_children(&base, &ofs_first, &ofs_last);
 		if (!ref && !ofs)
 			continue;
@@ -535,11 +533,11 @@ static void append_obj_to_pack(const unsigned char *sha1, void *buf,
 	}
 	header[n++] = c;
 	write_or_die(output_fd, header, n);
-	obj[0].crc32 = crc32(0, Z_NULL, 0);
-	obj[0].crc32 = crc32(obj[0].crc32, header, n);
-	obj[1].offset = obj[0].offset + n;
-	obj[1].offset += write_compressed(output_fd, buf, size, &obj[0].crc32);
-	hashcpy(obj->sha1, sha1);
+	obj[0].idx.crc32 = crc32(0, Z_NULL, 0);
+	obj[0].idx.crc32 = crc32(obj[0].idx.crc32, header, n);
+	obj[1].idx.offset = obj[0].idx.offset + n;
+	obj[1].idx.offset += write_compressed(output_fd, buf, size, &obj[0].idx.crc32);
+	hashcpy(obj->idx.sha1, sha1);
 }
 
 static int delta_pos_compare(const void *_a, const void *_b)
@@ -602,145 +600,6 @@ static void fix_unresolved_deltas(int nr_unresolved)
 	free(sorted_by_pos);
 }
 
-static uint32_t index_default_version = 1;
-static uint32_t index_off32_limit = 0x7fffffff;
-
-static int sha1_compare(const void *_a, const void *_b)
-{
-	struct object_entry *a = *(struct object_entry **)_a;
-	struct object_entry *b = *(struct object_entry **)_b;
-	return hashcmp(a->sha1, b->sha1);
-}
-
-/*
- * On entry *sha1 contains the pack content SHA1 hash, on exit it is
- * the SHA1 hash of sorted object names.
- */
-static const char *write_index_file(const char *index_name, unsigned char *sha1)
-{
-	struct sha1file *f;
-	struct object_entry **sorted_by_sha, **list, **last;
-	uint32_t array[256];
-	int i, fd;
-	SHA_CTX ctx;
-	uint32_t index_version;
-
-	if (nr_objects) {
-		sorted_by_sha =
-			xcalloc(nr_objects, sizeof(struct object_entry *));
-		list = sorted_by_sha;
-		last = sorted_by_sha + nr_objects;
-		for (i = 0; i < nr_objects; ++i)
-			sorted_by_sha[i] = &objects[i];
-		qsort(sorted_by_sha, nr_objects, sizeof(sorted_by_sha[0]),
-		      sha1_compare);
-	}
-	else
-		sorted_by_sha = list = last = NULL;
-
-	if (!index_name) {
-		static char tmpfile[PATH_MAX];
-		snprintf(tmpfile, sizeof(tmpfile),
-			 "%s/tmp_idx_XXXXXX", get_object_directory());
-		fd = mkstemp(tmpfile);
-		index_name = xstrdup(tmpfile);
-	} else {
-		unlink(index_name);
-		fd = open(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
-	}
-	if (fd < 0)
-		die("unable to create %s: %s", index_name, strerror(errno));
-	f = sha1fd(fd, index_name);
-
-	/* if last object's offset is >= 2^31 we should use index V2 */
-	index_version = (objects[nr_objects-1].offset >> 31) ? 2 : index_default_version;
-
-	/* index versions 2 and above need a header */
-	if (index_version >= 2) {
-		struct pack_idx_header hdr;
-		hdr.idx_signature = htonl(PACK_IDX_SIGNATURE);
-		hdr.idx_version = htonl(index_version);
-		sha1write(f, &hdr, sizeof(hdr));
-	}
-
-	/*
-	 * Write the first-level table (the list is sorted,
-	 * but we use a 256-entry lookup to be able to avoid
-	 * having to do eight extra binary search iterations).
-	 */
-	for (i = 0; i < 256; i++) {
-		struct object_entry **next = list;
-		while (next < last) {
-			struct object_entry *obj = *next;
-			if (obj->sha1[0] != i)
-				break;
-			next++;
-		}
-		array[i] = htonl(next - sorted_by_sha);
-		list = next;
-	}
-	sha1write(f, array, 256 * 4);
-
-	/* compute the SHA1 hash of sorted object names. */
-	SHA1_Init(&ctx);
-
-	/*
-	 * Write the actual SHA1 entries..
-	 */
-	list = sorted_by_sha;
-	for (i = 0; i < nr_objects; i++) {
-		struct object_entry *obj = *list++;
-		if (index_version < 2) {
-			uint32_t offset = htonl(obj->offset);
-			sha1write(f, &offset, 4);
-		}
-		sha1write(f, obj->sha1, 20);
-		SHA1_Update(&ctx, obj->sha1, 20);
-	}
-
-	if (index_version >= 2) {
-		unsigned int nr_large_offset = 0;
-
-		/* write the crc32 table */
-		list = sorted_by_sha;
-		for (i = 0; i < nr_objects; i++) {
-			struct object_entry *obj = *list++;
-			uint32_t crc32_val = htonl(obj->crc32);
-			sha1write(f, &crc32_val, 4);
-		}
-
-		/* write the 32-bit offset table */
-		list = sorted_by_sha;
-		for (i = 0; i < nr_objects; i++) {
-			struct object_entry *obj = *list++;
-			uint32_t offset = (obj->offset <= index_off32_limit) ?
-				obj->offset : (0x80000000 | nr_large_offset++);
-			offset = htonl(offset);
-			sha1write(f, &offset, 4);
-		}
-
-		/* write the large offset table */
-		list = sorted_by_sha;
-		while (nr_large_offset) {
-			struct object_entry *obj = *list++;
-			uint64_t offset = obj->offset;
-			if (offset > index_off32_limit) {
-				uint32_t split[2];
-				split[0]	= htonl(offset >> 32);
-				split[1] = htonl(offset & 0xffffffff);
-				sha1write(f, split, 8);
-				nr_large_offset--;
-			}
-		}
-	}
-
-	sha1write(f, sha1, 20);
-	sha1close(f, NULL, 1);
-	free(sorted_by_sha);
-	SHA1_Final(sha1, &ctx);
-	return index_name;
-}
-
 static void final(const char *final_pack_name, const char *curr_pack_name,
 		  const char *final_index_name, const char *curr_index_name,
 		  const char *keep_name, const char *keep_msg,
@@ -830,6 +689,7 @@ int main(int argc, char **argv)
 	const char *curr_index, *index_name = NULL;
 	const char *keep_name = NULL, *keep_msg = NULL;
 	char *index_name_buf = NULL, *keep_name_buf = NULL;
+	struct pack_idx_entry **idx_objects;
 	unsigned char sha1[20];
 
 	for (i = 1; i < argc; i++) {
@@ -865,12 +725,12 @@ int main(int argc, char **argv)
 				index_name = argv[++i];
 			} else if (!prefixcmp(arg, "--index-version=")) {
 				char *c;
-				index_default_version = strtoul(arg + 16, &c, 10);
-				if (index_default_version > 2)
+				pack_idx_default_version = strtoul(arg + 16, &c, 10);
+				if (pack_idx_default_version > 2)
 					die("bad %s", arg);
 				if (*c == ',')
-					index_off32_limit = strtoul(c+1, &c, 0);
-				if (*c || index_off32_limit & 0x80000000)
+					pack_idx_off32_limit = strtoul(c+1, &c, 0);
+				if (*c || pack_idx_off32_limit & 0x80000000)
 					die("bad %s", arg);
 			} else
 				usage(index_pack_usage);
@@ -940,7 +800,13 @@ int main(int argc, char **argv)
 			    nr_deltas - nr_resolved_deltas);
 	}
 	free(deltas);
-	curr_index = write_index_file(index_name, sha1);
+
+	idx_objects = xmalloc((nr_objects) * sizeof(struct pack_idx_entry *));
+	for (i = 0; i < nr_objects; i++)
+		idx_objects[i] = &objects[i].idx;
+	curr_index = write_idx_file(index_name, idx_objects, nr_objects, sha1);
+	free(idx_objects);
+
 	final(pack_name, curr_pack,
 		index_name, curr_index,
 		keep_name, keep_msg,
diff --git a/pack-write.c b/pack-write.c
index ae2e481..1cf5f7c 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,5 +1,147 @@
 #include "cache.h"
 #include "pack.h"
+#include "csum-file.h"
+
+uint32_t pack_idx_default_version = 1;
+uint32_t pack_idx_off32_limit = 0x7fffffff;
+
+static int sha1_compare(const void *_a, const void *_b)
+{
+	struct pack_idx_entry *a = *(struct pack_idx_entry **)_a;
+	struct pack_idx_entry *b = *(struct pack_idx_entry **)_b;
+	return hashcmp(a->sha1, b->sha1);
+}
+
+/*
+ * On entry *sha1 contains the pack content SHA1 hash, on exit it is
+ * the SHA1 hash of sorted object names. The objects array passed in
+ * will be sorted by SHA1 on exit.
+ */
+const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, unsigned char *sha1)
+{
+	struct sha1file *f;
+	struct pack_idx_entry **sorted_by_sha, **list, **last;
+	off_t last_obj_offset = 0;
+	uint32_t array[256];
+	int i, fd;
+	SHA_CTX ctx;
+	uint32_t index_version;
+
+	if (nr_objects) {
+		sorted_by_sha = objects;
+		list = sorted_by_sha;
+		last = sorted_by_sha + nr_objects;
+		for (i = 0; i < nr_objects; ++i) {
+			if (objects[i]->offset > last_obj_offset)
+				last_obj_offset = objects[i]->offset;
+		}
+		qsort(sorted_by_sha, nr_objects, sizeof(sorted_by_sha[0]),
+		      sha1_compare);
+	}
+	else
+		sorted_by_sha = list = last = NULL;
+
+	if (!index_name) {
+		static char tmpfile[PATH_MAX];
+		snprintf(tmpfile, sizeof(tmpfile),
+			 "%s/tmp_idx_XXXXXX", get_object_directory());
+		fd = mkstemp(tmpfile);
+		index_name = xstrdup(tmpfile);
+	} else {
+		unlink(index_name);
+		fd = open(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
+	}
+	if (fd < 0)
+		die("unable to create %s: %s", index_name, strerror(errno));
+	f = sha1fd(fd, index_name);
+
+	/* if last object's offset is >= 2^31 we should use index V2 */
+	index_version = (last_obj_offset >> 31) ? 2 : pack_idx_default_version;
+
+	/* index versions 2 and above need a header */
+	if (index_version >= 2) {
+		struct pack_idx_header hdr;
+		hdr.idx_signature = htonl(PACK_IDX_SIGNATURE);
+		hdr.idx_version = htonl(index_version);
+		sha1write(f, &hdr, sizeof(hdr));
+	}
+
+	/*
+	 * Write the first-level table (the list is sorted,
+	 * but we use a 256-entry lookup to be able to avoid
+	 * having to do eight extra binary search iterations).
+	 */
+	for (i = 0; i < 256; i++) {
+		struct pack_idx_entry **next = list;
+		while (next < last) {
+			struct pack_idx_entry *obj = *next;
+			if (obj->sha1[0] != i)
+				break;
+			next++;
+		}
+		array[i] = htonl(next - sorted_by_sha);
+		list = next;
+	}
+	sha1write(f, array, 256 * 4);
+
+	/* compute the SHA1 hash of sorted object names. */
+	SHA1_Init(&ctx);
+
+	/*
+	 * Write the actual SHA1 entries..
+	 */
+	list = sorted_by_sha;
+	for (i = 0; i < nr_objects; i++) {
+		struct pack_idx_entry *obj = *list++;
+		if (index_version < 2) {
+			uint32_t offset = htonl(obj->offset);
+			sha1write(f, &offset, 4);
+		}
+		sha1write(f, obj->sha1, 20);
+		SHA1_Update(&ctx, obj->sha1, 20);
+	}
+
+	if (index_version >= 2) {
+		unsigned int nr_large_offset = 0;
+
+		/* write the crc32 table */
+		list = sorted_by_sha;
+		for (i = 0; i < nr_objects; i++) {
+			struct pack_idx_entry *obj = *list++;
+			uint32_t crc32_val = htonl(obj->crc32);
+			sha1write(f, &crc32_val, 4);
+		}
+
+		/* write the 32-bit offset table */
+		list = sorted_by_sha;
+		for (i = 0; i < nr_objects; i++) {
+			struct pack_idx_entry *obj = *list++;
+			uint32_t offset = (obj->offset <= pack_idx_off32_limit) ?
+				obj->offset : (0x80000000 | nr_large_offset++);
+			offset = htonl(offset);
+			sha1write(f, &offset, 4);
+		}
+
+		/* write the large offset table */
+		list = sorted_by_sha;
+		while (nr_large_offset) {
+			struct pack_idx_entry *obj = *list++;
+			uint64_t offset = obj->offset;
+			if (offset > pack_idx_off32_limit) {
+				uint32_t split[2];
+				split[0] = htonl(offset >> 32);
+				split[1] = htonl(offset & 0xffffffff);
+				sha1write(f, split, 8);
+				nr_large_offset--;
+			}
+		}
+	}
+
+	sha1write(f, sha1, 20);
+	sha1close(f, NULL, 1);
+	SHA1_Final(sha1, &ctx);
+	return index_name;
+}
 
 void fixup_pack_header_footer(int pack_fd,
 			 unsigned char *pack_file_sha1,
diff --git a/pack.h b/pack.h
index d667fb8..f357c9f 100644
--- a/pack.h
+++ b/pack.h
@@ -34,6 +34,10 @@ struct pack_header {
  */
 #define PACK_IDX_SIGNATURE 0xff744f63	/* "\377tOc" */
 
+/* These may be overridden by command-line parameters */
+extern uint32_t pack_idx_default_version;
+extern uint32_t pack_idx_off32_limit;
+
 /*
  * Packed object index header
  */
@@ -42,6 +46,16 @@ struct pack_idx_header {
 	uint32_t idx_version;
 };
 
+/*
+ * Common part of object structure used for write_idx_file
+ */
+struct pack_idx_entry {
+	unsigned char sha1[20];
+	uint32_t crc32;
+	off_t offset;
+};
+
+extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, unsigned char *sha1);
 
 extern int verify_pack(struct packed_git *, int);
 extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t);
-- 
1.5.1
