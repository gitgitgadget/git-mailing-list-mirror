From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 8/17] Loop over pack_windows when inflating/accessing data.
Date: Sat, 23 Dec 2006 02:34:13 -0500
Message-ID: <20061223073413.GI9837@spearce.org>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 08:34:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy1Oi-0001sU-7I
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 08:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbWLWHeS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 02:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752703AbWLWHeR
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 02:34:17 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38781 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbWLWHeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 02:34:16 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy1OA-00038q-OM; Sat, 23 Dec 2006 02:33:50 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6D5DA20FB65; Sat, 23 Dec 2006 02:34:13 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35289>

When multiple mmaps start getting used for all pack file access it
is not possible to get all data associated with a specific object
in one contiguous memory region.  This limitation prevents simply
passing a single address and length to SHA1_Update or to inflate.

Instead we need to loop until we have processed all data of interest.

As we loop over the data we are always interested in reusing the same
window 'cursor', as the prior window will no longer be of any use
to us.  This allows the use_pack() call to automatically decrement
the use count of the prior window before setting up access for us
to the next window.

Within each loop we need to make use of the available length output
parameter of use_pack() to tell us how many bytes are available in
the current memory region, as we cannot tell otherwise.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-pack-objects.c |   58 +++++++++++++++++++++++++++++++++++++++++++-----
 pack-check.c           |   46 ++++++++++++++++---------------------
 sha1_file.c            |   22 ++++++++++++-----
 3 files changed, 87 insertions(+), 39 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 6d7ae7f..afb926a 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -276,7 +276,52 @@ static int encode_header(enum object_type type, unsigned long size, unsigned cha
  * we are going to reuse the existing object data as is.  make
  * sure it is not corrupt.
  */
-static int check_inflate(unsigned char *data, unsigned long len, unsigned long expect)
+static int check_pack_inflate(struct packed_git *p,
+		struct pack_window **w_curs,
+		unsigned long offset,
+		unsigned long len,
+		unsigned long expect)
+{
+	z_stream stream;
+	unsigned char fakebuf[4096], *in;
+	int st;
+
+	memset(&stream, 0, sizeof(stream));
+	inflateInit(&stream);
+	do {
+		in = use_pack(p, w_curs, offset, &stream.avail_in);
+		stream.next_in = in;
+		stream.next_out = fakebuf;
+		stream.avail_out = sizeof(fakebuf);
+		st = inflate(&stream, Z_FINISH);
+		offset += stream.next_in - in;
+	} while (st == Z_OK || st == Z_BUF_ERROR);
+	inflateEnd(&stream);
+	return (st == Z_STREAM_END &&
+		stream.total_out == expect &&
+		stream.total_in == len) ? 0 : -1;
+}
+
+static void copy_pack_data(struct sha1file *f,
+		struct packed_git *p,
+		struct pack_window **w_curs,
+		unsigned long offset,
+		unsigned long len)
+{
+	unsigned char *in;
+	unsigned int avail;
+
+	while (len) {
+		in = use_pack(p, w_curs, offset, &avail);
+		if (avail > len)
+			avail = len;
+		sha1write(f, in, avail);
+		offset += avail;
+		len -= avail;
+	}
+}
+
+static int check_loose_inflate(unsigned char *data, unsigned long len, unsigned long expect)
 {
 	z_stream stream;
 	unsigned char fakebuf[4096];
@@ -323,7 +368,7 @@ static int revalidate_loose_object(struct object_entry *entry,
 		return -1;
 	map += used;
 	mapsize -= used;
-	return check_inflate(map, mapsize, size);
+	return check_loose_inflate(map, mapsize, size);
 }
 
 static unsigned long write_object(struct sha1file *f,
@@ -417,6 +462,7 @@ static unsigned long write_object(struct sha1file *f,
 	else {
 		struct packed_git *p = entry->in_pack;
 		struct pack_window *w_curs = NULL;
+		unsigned long offset;
 
 		if (entry->delta) {
 			obj_type = (allow_ofs_delta && entry->delta->offset) ?
@@ -438,13 +484,13 @@ static unsigned long write_object(struct sha1file *f,
 			hdrlen += 20;
 		}
 
-		buf = use_pack(p, &w_curs, entry->in_pack_offset
-			+ entry->in_pack_header_size, NULL);
+		offset = entry->in_pack_offset + entry->in_pack_header_size;
 		datalen = find_packed_object_size(p, entry->in_pack_offset)
 				- entry->in_pack_header_size;
-		if (!pack_to_stdout && check_inflate(buf, datalen, entry->size))
+		if (!pack_to_stdout && check_pack_inflate(p, &w_curs,
+				offset, datalen, entry->size))
 			die("corrupt delta in pack %s", sha1_to_hex(entry->sha1));
-		sha1write(f, buf, datalen);
+		copy_pack_data(f, p, &w_curs, offset, datalen);
 		unuse_pack(&w_curs);
 		reused++;
 	}
diff --git a/pack-check.c b/pack-check.c
index 972916f..08a9fd8 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -8,39 +8,38 @@ static int verify_packfile(struct packed_git *p,
 	void *index_base = p->index_base;
 	SHA_CTX ctx;
 	unsigned char sha1[20];
-	unsigned long pack_size = p->pack_size;
-	void *pack_base;
-	struct pack_header *hdr;
+	unsigned long offset = 0, pack_sig = p->pack_size - 20;
 	int nr_objects, err, i;
 
-	/* Header consistency check */
-	pack_base = use_pack(p, w_curs, 0, NULL);
-	hdr = (struct pack_header*)pack_base;
-	if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
-		return error("Packfile %s signature mismatch", p->pack_name);
-	if (!pack_version_ok(hdr->hdr_version))
-		return error("Packfile version %d unsupported",
-			     ntohl(hdr->hdr_version));
-	nr_objects = ntohl(hdr->hdr_entries);
-	if (num_packed_objects(p) != nr_objects)
-		return error("Packfile claims to have %d objects, "
-			     "while idx size expects %d", nr_objects,
-			     num_packed_objects(p));
+	/* Note that the pack header checks are actually performed by
+	 * use_pack when it first opens the pack file.  If anything
+	 * goes wrong during those checks then the call will die out
+	 * immediately.
+	 */
 
 	SHA1_Init(&ctx);
-	SHA1_Update(&ctx, pack_base, pack_size - 20);
+	while (offset < pack_sig) {
+		unsigned int remaining;
+		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
+		offset += remaining;
+		if (offset > pack_sig)
+			remaining -= offset - pack_sig;
+		SHA1_Update(&ctx, in, remaining);
+	}
 	SHA1_Final(sha1, &ctx);
-	if (hashcmp(sha1, (unsigned char *)pack_base + pack_size - 20))
+	if (hashcmp(sha1, use_pack(p, w_curs, pack_sig, NULL)))
 		return error("Packfile %s SHA1 mismatch with itself",
 			     p->pack_name);
 	if (hashcmp(sha1, (unsigned char *)index_base + index_size - 40))
 		return error("Packfile %s SHA1 mismatch with idx",
 			     p->pack_name);
+	unuse_pack(w_curs);
 
 	/* Make sure everything reachable from idx is valid.  Since we
 	 * have verified that nr_objects matches between idx and pack,
 	 * we do not do scan-streaming check on the pack file.
 	 */
+	nr_objects = num_packed_objects(p);
 	for (i = err = 0; i < nr_objects; i++) {
 		unsigned char sha1[20];
 		void *data;
@@ -73,15 +72,12 @@ static int verify_packfile(struct packed_git *p,
 
 #define MAX_CHAIN 40
 
-static void show_pack_info(struct packed_git *p,
-		struct pack_window **w_curs)
+static void show_pack_info(struct packed_git *p)
 {
-	struct pack_header *hdr;
 	int nr_objects, i;
 	unsigned int chain_histogram[MAX_CHAIN];
 
-	hdr = (struct pack_header*)use_pack(p, w_curs, 0, NULL);
-	nr_objects = ntohl(hdr->hdr_entries);
+	nr_objects = num_packed_objects(p);
 	memset(chain_histogram, 0, sizeof(chain_histogram));
 
 	for (i = 0; i < nr_objects; i++) {
@@ -153,9 +149,7 @@ int verify_pack(struct packed_git *p, int verbose)
 		if (ret)
 			printf("%s: bad\n", p->pack_name);
 		else {
-			struct pack_window *w_curs = NULL;
-			show_pack_info(p, &w_curs);
-			unuse_pack(&w_curs);
+			show_pack_info(p);
 			printf("%s: ok\n", p->pack_name);
 		}
 	}
diff --git a/sha1_file.c b/sha1_file.c
index ef3f056..886e3b5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -960,19 +960,23 @@ static int packed_delta_info(struct packed_git *p,
 
 	if (sizep) {
 		const unsigned char *data;
-		unsigned char delta_head[20];
+		unsigned char delta_head[20], *in;
 		unsigned long result_size;
 		z_stream stream;
 		int st;
 
 		memset(&stream, 0, sizeof(stream));
-
-		stream.next_in = use_pack(p, w_curs, offset, &stream.avail_in);
 		stream.next_out = delta_head;
 		stream.avail_out = sizeof(delta_head);
 
 		inflateInit(&stream);
-		st = inflate(&stream, Z_FINISH);
+		do {
+			in = use_pack(p, w_curs, offset, &stream.avail_in);
+			stream.next_in = in;
+			st = inflate(&stream, Z_FINISH);
+			offset += stream.next_in - in;
+		} while ((st == Z_OK || st == Z_BUF_ERROR)
+			&& stream.total_out < sizeof(delta_head));
 		inflateEnd(&stream);
 		if ((st != Z_STREAM_END) &&
 		    stream.total_out != sizeof(delta_head))
@@ -1101,17 +1105,21 @@ static void *unpack_compressed_entry(struct packed_git *p,
 {
 	int st;
 	z_stream stream;
-	unsigned char *buffer;
+	unsigned char *buffer, *in;
 
 	buffer = xmalloc(size + 1);
 	buffer[size] = 0;
 	memset(&stream, 0, sizeof(stream));
-	stream.next_in = use_pack(p, w_curs, offset, &stream.avail_in);
 	stream.next_out = buffer;
 	stream.avail_out = size;
 
 	inflateInit(&stream);
-	st = inflate(&stream, Z_FINISH);
+	do {
+		in = use_pack(p, w_curs, offset, &stream.avail_in);
+		stream.next_in = in;
+		st = inflate(&stream, Z_FINISH);
+		offset += stream.next_in - in;
+	} while (st == Z_OK || st == Z_BUF_ERROR);
 	inflateEnd(&stream);
 	if ((st != Z_STREAM_END) || stream.total_out != size) {
 		free(buffer);
-- 
1.4.4.3.g87d8
