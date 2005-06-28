From: Nicolas Pitre <nico@cam.org>
Subject: Re: kernel.org and GIT tree rebuilding
Date: Tue, 28 Jun 2005 17:08:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0506281655140.1667@localhost.localdomain>
References: <20050624.212009.92584730.davem@davemloft.net>
 <42BCE026.8050405@pobox.com>
 <Pine.LNX.4.58.0506242208210.11175@ppc970.osdl.org>
 <42BCF02B.5090706@pobox.com>
 <Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org>
 <Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org>
 <Pine.LNX.4.63.0506281351150.1667@localhost.localdomain>
 <Pine.LNX.4.58.0506281201510.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Chris Mason <mason@suse.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 23:08:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnNI0-0004Qf-HO
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 23:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVF1VNa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 17:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVF1VNa
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 17:13:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53287 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261268AbVF1VJQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 17:09:16 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IIT00KAZC2O0O@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 28 Jun 2005 17:08:48 -0400 (EDT)
In-reply-to: <Pine.LNX.4.58.0506281201510.19755@ppc970.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 28 Jun 2005, Linus Torvalds wrote:

> 
> 
> On Tue, 28 Jun 2005, Nicolas Pitre wrote:
> > 
> > Here's one improvement to the pack format, breaking it early so it won't 
> > affect anyone at this point: compressed object header.  Instead of the 
> > fixed 5 byte header, this patch convert it to a variable size granted 
> > most object are small enough to save on the storage of the significant 
> > size bytes which will be zero and packing the non-zero byte position 
> > with the object type.
> 
> Ok, this is against an older version and doesn't have that "read_sha1" 
> thing, but yes, something like this would work.
> 
> I'd prefer the encoding to be a bit different, though: make the size be
> encoded in seven bits per byte, with the high bit meaning "more to come". 
> We can use four bits from the "type" byte for the initial value, making 
> lengths 0-15 be free.
> 
> 	unsigned long size;
> 	unsigned char c;
> 
> 	c = *pack++;
> 	type = 
> 	size = c & 15;
> 	type = (c >> 4) & 7;
> 	while (c & 0x80) {
> 		c = *pack++;
> 		size = (size << 7) + (pack & 0x7f);
> 	}
> 
> or something. That's even denser.

OK.  New patch below.

> However, I also end up wanting to add a "global header" to the pack-file, 
> that contains at least the number of objects packed. We may not know how 
> big the pack-file will be, but we'll at least know how many objects it 
> has before we start writing it.

Probably a version signature would be a good thing too.

=====

This patch adds compressed object header.  Instead of the fixed 5 byte 
header, this patch convert it to a variable size granted most object are 
small enough to save on the storage of the size's most significant bytes 
which are zero, even ffolding bits with the object type.  Objects up to 
2047 bytes in size will have a header of only 2 bytes.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/pack-objects.c b/pack-objects.c
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -3,24 +3,17 @@
 #include "object.h"
 #include "delta.h"
 #include "csum-file.h"
+#include "pack.h"
 
 static const char pack_usage[] = "git-pack-objects [--window=N] [--depth=N] {--stdout | base-name} < object-list";
 
-/*
- * The object type is a single-character shorthand:
- *  - 'C' for "Commit"
- *  - 'T' for "Tree"
- *  - 'B' for "Blob"
- *  - 'G' for "taG"
- *  - 'D' for "Delta"
- */
 struct object_entry {
 	unsigned char sha1[20];
 	unsigned long size;
 	unsigned long offset;
 	unsigned int depth;
 	unsigned int hash;
-	unsigned char type;
+	packed_obj_type type;
 	unsigned long delta_size;
 	struct object_entry *delta;
 };
@@ -63,21 +56,30 @@ static unsigned long write_object(struct
 		die("object %s size inconsistency (%lu vs %lu)", sha1_to_hex(entry->sha1), size, entry->size);
 
 	/*
-	 * The object header is a byte of 'type' followed by four bytes of
-	 * length, except for deltas that has the 20 bytes of delta sha
-	 * instead.
+	 * The object header first byte has its low 4 bits representing the
+	 * object type, the 4 upper bits indicating which of the following
+	 * bytes are used to build the object size.  For delta objects the
+	 * sha1 of the reference object is also appended.
 	 */
 	header[0] = entry->type;
-	hdrlen = 5;
 	if (entry->delta) {
-		header[0] = 'D';
-		memcpy(header+5, entry->delta, 20);
+		header[0] = PACKED_DELTA;
 		buf = delta_against(buf, size, entry);
 		size = entry->delta_size;
-		hdrlen = 25;
 	}
-	datalen = htonl(size);
-	memcpy(header+1, &datalen, 4);
+	header[0] |= size << 3;
+	hdrlen = 1;
+	datalen = size >> 4;
+	while (datalen) {
+		header[hdrlen - 1] |= 0x80;
+		header[hdrlen++] = datalen;
+		datalen >>= 7;
+	}
+	if (entry->delta) {
+		memcpy(header+hdrlen, entry->delta, 20);
+		hdrlen += 20;
+	}
+
 	sha1write(f, header, hdrlen);
 	datalen = sha1write_compressed(f, buf, size);
 	free(buf);
@@ -168,13 +170,13 @@ static void check_object(struct object_e
 
 	if (!sha1_object_info(entry->sha1, type, &entry->size)) {
 		if (!strcmp(type, "commit")) {
-			entry->type = 'C';
+			entry->type = PACKED_COMMIT;
 		} else if (!strcmp(type, "tree")) {
-			entry->type = 'T';
+			entry->type = PACKED_TREE;
 		} else if (!strcmp(type, "blob")) {
-			entry->type = 'B';
+			entry->type = PACKED_BLOB;
 		} else if (!strcmp(type, "tag")) {
-			entry->type = 'G';
+			entry->type = PACKED_TAG;
 		} else
 			die("unable to pack object %s of type %s",
 			    sha1_to_hex(entry->sha1), type);
diff --git a/pack.h b/pack.h
new file mode 100644
--- /dev/null
+++ b/pack.h
@@ -0,0 +1,19 @@
+#ifndef PACK_H
+#define PACK_H
+
+/*
+ * The packed object type is stored in the low 3 bits of a byte.
+ * The type value 0 is a reserved prefix if ever there is more than 7
+ * object types, or any future format extensions.
+ */
+
+typedef enum {
+	PACKED_RESERVED = 0,
+	PACKED_COMMIT = 1,
+	PACKED_TREE = 2,
+	PACKED_BLOB = 3,
+	PACKED_TAG = 4,
+	PACKED_DELTA = 7
+} packed_obj_type;
+
+#endif
diff --git a/unpack-objects.c b/unpack-objects.c
--- a/unpack-objects.c
+++ b/unpack-objects.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "object.h"
 #include "delta.h"
+#include "pack.h"
 
 static int dry_run;
 static int nr_entries;
@@ -12,6 +13,14 @@ struct pack_entry {
 	unsigned char sha1[20];
 };
 
+static char *type_s[] = {
+	[PACKED_COMMIT]	= "commit",
+	[PACKED_TREE]	= "tree",
+	[PACKED_BLOB]	= "blob",
+	[PACKED_TAG]	= "tag",
+	[PACKED_DELTA]	"delta"
+};
+
 static void *pack_base;
 static unsigned long pack_size;
 static void *index_base;
@@ -92,7 +101,7 @@ static int check_index(void)
 }
 
 static int unpack_non_delta_entry(struct pack_entry *entry,
-				  int kind,
+				  char *type,
 				  unsigned char *data,
 				  unsigned long size,
 				  unsigned long left)
@@ -101,9 +110,8 @@ static int unpack_non_delta_entry(struct
 	z_stream stream;
 	char *buffer;
 	unsigned char sha1[20];
-	char *type_s;
 
-	printf("%s %c %lu\n", sha1_to_hex(entry->sha1), kind, size);
+	printf("%s %s %lu\n", sha1_to_hex(entry->sha1), type, size);
 	if (dry_run)
 		return 0;
 
@@ -120,22 +128,15 @@ static int unpack_non_delta_entry(struct
 	inflateEnd(&stream);
 	if ((st != Z_STREAM_END) || stream.total_out != size)
 		goto err_finish;
-	switch (kind) {
-	case 'C': type_s = "commit"; break;
-	case 'T': type_s = "tree"; break;
-	case 'B': type_s = "blob"; break;
-	case 'G': type_s = "tag"; break;
-	default: goto err_finish;
-	}
-	if (write_sha1_file(buffer, size, type_s, sha1) < 0)
+	if (write_sha1_file(buffer, size, type, sha1) < 0)
 		die("failed to write %s (%s)",
-		    sha1_to_hex(entry->sha1), type_s);
-	printf("%s %s\n", sha1_to_hex(sha1), type_s);
+		    sha1_to_hex(entry->sha1), type);
+	printf("%s %s\n", sha1_to_hex(sha1), type);
 	if (memcmp(sha1, entry->sha1, 20))
-		die("resulting %s have wrong SHA1", type_s);
+		die("resulting %s have wrong SHA1", type);
 
- finish:
 	st = 0;
+ finish:
 	free(buffer);
 	return st;
  err_finish:
@@ -184,15 +185,13 @@ static int unpack_delta_entry(struct pac
 		die("truncated pack file");
 	data = base_sha1 + 20;
 	data_size = left - 20;
-	printf("%s D %lu", sha1_to_hex(entry->sha1), delta_size);
+	printf("%s delta %lu", sha1_to_hex(entry->sha1), delta_size);
 	printf(" %s\n", sha1_to_hex(base_sha1));
 
 	if (dry_run)
 		return 0;
 
-	/* pack+5 is the base sha1, unless we have it, we need to
-	 * unpack it first.
-	 */
+	/* unless we have the base sha1, we need to unpack it first. */
 	if (!has_sha1_file(base_sha1)) {
 		struct pack_entry *base;
 		if (!find_pack_entry(base_sha1, &base))
@@ -237,7 +236,9 @@ static int unpack_delta_entry(struct pac
 static void unpack_entry(struct pack_entry *entry)
 {
 	unsigned long offset, size, left;
-	unsigned char *pack;
+	unsigned char *pack, sizebits;
+	packed_obj_type type;
+	int i;
 
 	/* Have we done this one already due to deltas based on it? */
 	if (lookup_object(entry->sha1))
@@ -247,17 +248,28 @@ static void unpack_entry(struct pack_ent
 	if (offset > pack_size - 5)
 		die("object offset outside of pack file");
 	pack = pack_base + offset;
-	size = (pack[1] << 24) + (pack[2] << 16) + (pack[3] << 8) + pack[4];
-	left = pack_size - offset - 5;
-	switch (*pack) {
-	case 'C': case 'T': case 'B': case 'G':
-		unpack_non_delta_entry(entry, *pack, pack+5, size, left);
+	sizebits = *pack++;
+	type = sizebits & 0x07;
+	size = (sizebits & ~0x80) >> 3;
+	i = 4;
+	while (sizebits & 0x80) {
+		sizebits = *pack++;
+		size |= (sizebits & ~0x80) << i;
+		i += 7;
+	}
+	left = pack_size - ((void *)pack - pack_base);
+	switch (type) {
+	case PACKED_COMMIT:
+	case PACKED_TREE:
+	case PACKED_BLOB:
+	case PACKED_TAG:
+		unpack_non_delta_entry(entry, type_s[type], pack, size, left);
 		break;
-	case 'D':
-		unpack_delta_entry(entry, pack+5, size, left);
+	case PACKED_DELTA:
+		unpack_delta_entry(entry, pack, size, left);
 		break;
 	default:
-		die("corrupted pack file");
+		die("corrupted pack file(unknown object type %d)", type);
 	}
 }
 
