From: Nicolas Pitre <nico@cam.org>
Subject: Re: kernel.org and GIT tree rebuilding
Date: Tue, 28 Jun 2005 14:06:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0506281351150.1667@localhost.localdomain>
References: <20050624.212009.92584730.davem@davemloft.net>
 <42BCE026.8050405@pobox.com>
 <Pine.LNX.4.58.0506242208210.11175@ppc970.osdl.org>
 <42BCF02B.5090706@pobox.com>
 <Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org>
 <Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Chris Mason <mason@suse.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 20:04:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnKQj-0004O2-VX
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 20:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVF1SKH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 14:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbVF1SIf
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 14:08:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28720 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262175AbVF1SG6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 14:06:58 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IIT00IMN3MG5D@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 28 Jun 2005 14:06:16 -0400 (EDT)
In-reply-to: <Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 26 Jun 2005, Linus Torvalds wrote:

> On Fri, 24 Jun 2005, Linus Torvalds wrote:
> > 
> > yeah, it clearly needs some refining to be useful, but I think you can
> > kind of see how it would work.
> 
> Ok, here's how it works.
> 
[...]
> 
> Nico? Chris? Interested in giving it a look? It's kind of a combination of 
> your things, generalized and then made to have fast lookup with the index.

Wow !

Look away for a few days and when you look back your own stuff has been 
yanked out!

But actually I like this packing thing.  Certainly much nicer to work 
with and also more useful.  And, since the pack file has its own 
checksum  it is possible to use that pack format (without the index 
(which can be recreated from the pack file alone anyway) for network 
transfer.

Here's one improvement to the pack format, breaking it early so it won't 
affect anyone at this point: compressed object header.  Instead of the 
fixed 5 byte header, this patch convert it to a variable size granted 
most object are small enough to save on the storage of the significant 
size bytes which will be zero and packing the non-zero byte position 
with the object type.

This can save up to 2% or 21KB on the test I 
performed with the git repository.

diff --git a/pack-objects.c b/pack-objects.c
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -7,7 +7,7 @@
 static const char pack_usage[] = "git-pack-objects [--window=N] [--depth=N] base-name < object-list";
 
 enum object_type {
-	OBJ_NONE,
+	OBJ_NONE = 0,
 	OBJ_COMMIT,
 	OBJ_TREE,
 	OBJ_BLOB,
@@ -55,7 +55,7 @@ static unsigned long write_object(struct
 	char type[10];
 	void *buf = read_sha1_file(entry->sha1, type, &size);
 	char header[25];
-	unsigned hdrlen, datalen;
+	unsigned hdrlen, datalen, bit;
 
 	if (!buf)
 		die("unable to read %s", sha1_to_hex(entry->sha1));
@@ -63,21 +63,33 @@ static unsigned long write_object(struct
 		die("object %s size inconsistency (%lu vs %lu)", sha1_to_hex(entry->sha1), size, entry->size);
 
 	/*
-	 * The object header is a byte of 'type' followed by four bytes of
-	 * length, except for deltas that has the 20 bytes of delta sha
-	 * instead.
+	 * The object header is one byte which low 4 bits represent the
+	 * object type, the 4 upper bits indicates which of the following
+	 * bytes are used to build the object size.  For delta objects the
+	 * sha1 of the reference object is also appended.
 	 */
-	header[0] = ".CTB"[entry->type];
-	hdrlen = 5;
+	header[0] = entry->type;
 	if (entry->delta) {
-		header[0] = 'D';
-		memcpy(header+5, entry->delta, 20);
+		header[0] = OBJ_DELTA;
 		buf = delta_against(buf, size, entry);
 		size = entry->delta_size;
-		hdrlen = 25;
 	}
-	datalen = htonl(size);
-	memcpy(header+1, &datalen, 4);
+	hdrlen = 1;
+	bit = (1 << 4);
+	datalen = size;
+	do {
+		if (datalen & 0xff) {
+			header[0] |= bit;
+			header[hdrlen++] = datalen;
+		}
+		bit <<= 1;
+		datalen >>= 8;
+	} while (datalen);
+	if (entry->delta) {
+		memcpy(header+hdrlen, entry->delta, 20);
+		hdrlen += 20;
+	}
+
 	sha1write(f, header, hdrlen);
 	datalen = sha1write_compressed(f, buf, size);
 	free(buf);
diff --git a/unpack-objects.c b/unpack-objects.c
--- a/unpack-objects.c
+++ b/unpack-objects.c
@@ -12,6 +12,16 @@ struct pack_entry {
 	unsigned char sha1[20];
 };
 
+enum object_type {
+	OBJ_NONE = 0,
+	OBJ_COMMIT,
+	OBJ_TREE,
+	OBJ_BLOB,
+	OBJ_DELTA
+};
+
+static char *type_s[] = { NULL, "commit", "tree", "blob", "delta" };
+
 static void *pack_base;
 static unsigned long pack_size;
 static void *index_base;
@@ -92,7 +102,7 @@ static int check_index(void)
 }
 
 static int unpack_non_delta_entry(struct pack_entry *entry,
-				  int kind,
+				  char *type,
 				  unsigned char *data,
 				  unsigned long size,
 				  unsigned long left)
@@ -101,9 +111,8 @@ static int unpack_non_delta_entry(struct
 	z_stream stream;
 	char *buffer;
 	unsigned char sha1[20];
-	char *type_s;
 
-	printf("%s %c %lu\n", sha1_to_hex(entry->sha1), kind, size);
+	printf("%s %s %lu\n", sha1_to_hex(entry->sha1), type, size);
 	if (dry_run)
 		return 0;
 
@@ -120,18 +129,12 @@ static int unpack_non_delta_entry(struct
 	inflateEnd(&stream);
 	if ((st != Z_STREAM_END) || stream.total_out != size)
 		goto err_finish;
-	switch (kind) {
-	case 'C': type_s = "commit"; break;
-	case 'T': type_s = "tree"; break;
-	case 'B': type_s = "blob"; break;
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
 
  finish:
 	st = 0;
@@ -183,15 +186,13 @@ static int unpack_delta_entry(struct pac
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
@@ -236,7 +237,9 @@ static int unpack_delta_entry(struct pac
 static void unpack_entry(struct pack_entry *entry)
 {
 	unsigned long offset, size, left;
-	unsigned char *pack;
+	unsigned char *pack, sizebits;
+	enum object_type type;
+	int i;
 
 	/* Have we done this one already due to deltas based on it? */
 	if (lookup_object(entry->sha1))
@@ -246,14 +249,25 @@ static void unpack_entry(struct pack_ent
 	if (offset > pack_size - 5)
 		die("object offset outside of pack file");
 	pack = pack_base + offset;
-	size = (pack[1] << 24) + (pack[2] << 16) + (pack[3] << 8) + pack[4];
-	left = pack_size - offset - 5;
-	switch (*pack) {
-	case 'C': case 'T': case 'B':
-		unpack_non_delta_entry(entry, *pack, pack+5, size, left);
+	sizebits = *pack++;
+	type = sizebits & 0x0f;
+	sizebits >>= 4;
+	i = size = 0;
+	while (sizebits) {
+		if (sizebits & 1)
+			size |= *pack++ << i;
+		i += 8;
+		sizebits >>= 1;
+	}
+	left = pack_size - ((void *)pack - pack_base);
+	switch (type) {
+		case OBJ_COMMIT:
+		case OBJ_TREE:
+		case OBJ_BLOB:
+		unpack_non_delta_entry(entry, type_s[type], pack, size, left);
 		break;
-	case 'D':
-		unpack_delta_entry(entry, pack+5, size, left);
+	case OBJ_DELTA:
+		unpack_delta_entry(entry, pack, size, left);
 		break;
 	default:
 		die("corrupted pack file");
