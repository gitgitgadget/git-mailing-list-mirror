From: Nicolas Pitre <nico@cam.org>
Subject: Re: kernel.org and GIT tree rebuilding
Date: Wed, 29 Jun 2005 01:16:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0506290111250.1667@localhost.localdomain>
References: <20050624.212009.92584730.davem@davemloft.net>
 <42BCE026.8050405@pobox.com>
 <Pine.LNX.4.58.0506242208210.11175@ppc970.osdl.org>
 <42BCF02B.5090706@pobox.com>
 <Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org>
 <Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org>
 <Pine.LNX.4.63.0506281351150.1667@localhost.localdomain>
 <Pine.LNX.4.58.0506281201510.19755@ppc970.osdl.org>
 <Pine.LNX.4.63.0506281655140.1667@localhost.localdomain>
 <Pine.LNX.4.58.0506281424420.19755@ppc970.osdl.org>
 <Pine.LNX.4.63.0506282314320.1667@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 29 07:10:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnUpi-0003ZA-Bb
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 07:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbVF2FRC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 01:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVF2FRC
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 01:17:02 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9196 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262405AbVF2FQ3
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 01:16:29 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR001.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IIT00422YNHZD@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Jun 2005 01:16:29 -0400 (EDT)
In-reply-to: <Pine.LNX.4.63.0506282314320.1667@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 28 Jun 2005, Nicolas Pitre wrote:

> OK... See below the cleanups I merged from my version on top of yours:

Of course by the time I sent the above you already rewrote the ting to 
be streamable.

So again :-) see below the cleanups I merged from my version on top of 
yours:

 pack-objects.c   |   70 ++++++++++++++-----------------------------------------
 pack.h           |   17 ++++++++-----
 unpack-objects.c |   29 ++++++++++++----------
 3 files changed, 46 insertions(+), 70 deletions(-)

I also restored my original object header size ordering (little endian) 
for two reasons:

 - it is much simpler to generate and therefore allows for removing 
   quite some code

 - it allows for stable bit position which makes it much easier to look 
   at an hex dump of the binary data for manual debugging

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/pack-objects.c b/pack-objects.c
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -34,7 +34,7 @@ static void *delta_against(void *buf, un
 	if (!otherbuf)
 		die("unable to read %s", sha1_to_hex(entry->delta->sha1));
         delta_buf = diff_delta(otherbuf, othersize,
-			       buf, size, &delta_size, ~0UL);
+			       buf, size, &delta_size, 0UL);
         if (!delta_buf || delta_size != entry->delta_size)
         	die("delta size changed");
         free(buf);
@@ -42,54 +42,13 @@ static void *delta_against(void *buf, un
 	return delta_buf;
 }
 
-/*
- * The per-object header is a pretty dense thing, which is
- *  - first byte: low four bits are "size", then three bits of "type",
- *    and the high bit is "size continues".
- *  - each byte afterwards: low seven bits are size continuation,
- *    with the high bit being "size continues"
- */
-static int encode_header(enum object_type type, unsigned long size, unsigned char *hdr)
-{
-	int n = 1, i;
-	unsigned char c;
-
-	if (type < OBJ_COMMIT || type > OBJ_DELTA)
-		die("bad type %d", type);
-
-	/*
-	 * Shift the size up by 7 bits at a time,
-	 * until you get bits in the "high four".
-	 * That will be our beginning. We'll have
-	 * four size bits in 28..31, then groups
-	 * of seven in 21..27, 14..20, 7..13 and
-	 * finally 0..6.
-	 */
-	if (size) {
-		n = 5;
-		while (!(size & 0xfe000000)) {
-			size <<= 7;
-			n--;
-		}
-	}
-	c = (type << 4) | (size >> 28);
-	for (i = 1; i < n; i++) {
-		*hdr++ = c | 0x80;
-		c = (size >> 21) & 0x7f;
-		size <<= 7;
-	}
-	*hdr = c;
-	return n;
-}
-
 static unsigned long write_object(struct sha1file *f, struct object_entry *entry)
 {
 	unsigned long size;
 	char type[10];
 	void *buf = read_sha1_file(entry->sha1, type, &size);
-	unsigned char header[10];
+	char header[25];
 	unsigned hdrlen, datalen;
-	enum object_type obj_type;
 
 	if (!buf)
 		die("unable to read %s", sha1_to_hex(entry->sha1));
@@ -97,22 +56,31 @@ static unsigned long write_object(struct
 		die("object %s size inconsistency (%lu vs %lu)", sha1_to_hex(entry->sha1), size, entry->size);
 
 	/*
-	 * The object header is a byte of 'type' followed by zero or
-	 * more bytes of length.  For deltas, the 20 bytes of delta sha1
-	 * follows that.
+	 * The object header first byte has its low 3 bits representing the
+	 * object type, the 4 upper bits indicating which of the following
+	 * bytes are used to build the object size.  For delta objects the
+	 * sha1 of the reference object is also appended.
 	 */
-	obj_type = entry->type;
 	if (entry->delta) {
+		header[0] = OBJ_DELTA;
 		buf = delta_against(buf, size, entry);
 		size = entry->delta_size;
-		obj_type = OBJ_DELTA;
+	} else
+		header[0] = entry->type;
+	header[0] |= size << 3;
+	hdrlen = 1;
+	datalen = size >> 4;
+	while (datalen) {
+		header[hdrlen - 1] |= 0x80;
+		header[hdrlen++] = datalen;
+		datalen >>= 7;
 	}
-	hdrlen = encode_header(obj_type, size, header);
-	sha1write(f, header, hdrlen);
 	if (entry->delta) {
-		sha1write(f, entry->delta, 20);
+		memcpy(header+hdrlen, entry->delta, 20);
 		hdrlen += 20;
 	}
+
+	sha1write(f, header, hdrlen);
 	datalen = sha1write_compressed(f, buf, size);
 	free(buf);
 	return hdrlen + datalen;
diff --git a/pack.h b/pack.h
--- a/pack.h
+++ b/pack.h
@@ -1,13 +1,18 @@
 #ifndef PACK_H
 #define PACK_H
 
+/*
+ * The packed object type is stored in the low 3 bits of a byte.
+ * The type value 0 is a reserved prefix if ever there is more than 7
+ * object types, or any future format extensions.
+ */
 enum object_type {
-	OBJ_NONE,
-	OBJ_COMMIT,
-	OBJ_TREE,
-	OBJ_BLOB,
-	OBJ_TAG,
-	OBJ_DELTA,
+	OBJ_EXT = 0,
+	OBJ_COMMIT = 1,
+	OBJ_TREE = 2,
+	OBJ_BLOB = 3,
+	OBJ_TAG = 4,
+	OBJ_DELTA = 7
 };
 
 /*
diff --git a/unpack-objects.c b/unpack-objects.c
--- a/unpack-objects.c
+++ b/unpack-objects.c
@@ -6,6 +6,14 @@
 static int dry_run;
 static const char unpack_usage[] = "git-unpack-objects < pack-file";
 
+static char *type_string[] = {
+	[OBJ_COMMIT]	= "commit",
+	[OBJ_TREE]	= "tree",
+	[OBJ_BLOB]	= "blob",
+	[OBJ_TAG]	= "tag",
+	[OBJ_DELTA]	= "delta"
+};
+
 /* We always read in 4kB chunks. */
 static unsigned char buffer[4096];
 static unsigned long offset, len, eof;
@@ -139,19 +147,11 @@ static void added_object(unsigned char *
 	}
 }
 
-static int unpack_non_delta_entry(enum object_type kind, unsigned long size)
+static int unpack_non_delta_entry(char *type, unsigned long size)
 {
 	void *buf = get_data(size);
 	unsigned char sha1[20];
-	char *type;
 
-	switch (kind) {
-	case OBJ_COMMIT: type = "commit"; break;
-	case OBJ_TREE:   type = "tree"; break;
-	case OBJ_BLOB:   type = "blob"; break;
-	case OBJ_TAG:    type = "tag"; break;
-	default: die("bad type %d", kind);
-	}
 	if (write_sha1_file(buf, size, type, sha1) < 0)
 		die("failed to write object");
 	added_object(sha1, type, buf, size);
@@ -184,26 +184,29 @@ static int unpack_delta_entry(unsigned l
 static void unpack_one(void)
 {
 	unsigned char *pack, c;
+	unsigned int i;
 	unsigned long size;
 	enum object_type type;
 
 	pack = fill(1);
 	c = *pack;
 	use(1);
-	type = (c >> 4) & 7;
-	size = (c & 15);
+	type = c & 0x07;
+	size = (c & ~0x80) >> 3;
+	i = 4;
 	while (c & 0x80) {
 		pack = fill(1);
 		c = *pack++;
 		use(1);
-		size = (size << 7) + (c & 0x7f);
+		size |= (c & ~0x80) << i;
+		i += 7;
 	}
 	switch (type) {
 	case OBJ_COMMIT:
 	case OBJ_TREE:
 	case OBJ_BLOB:
 	case OBJ_TAG:
-		unpack_non_delta_entry(type, size);
+		unpack_non_delta_entry(type_string[type], size);
 		return;
 	case OBJ_DELTA:
 		unpack_delta_entry(size);
