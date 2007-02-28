From: Troy Telford <ttelford.groups@gmail.com>
Subject: Re: [PATCH] Support 64-bit indexes for pack files.
Date: Wed, 28 Feb 2007 12:46:15 -0700
Organization: Linux Networx
Message-ID: <200702281246.15797.ttelford@lnxi.com>
References: <200702261540.27080.ttelford.groups@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 20:47:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMUlP-0001ld-L8
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 20:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbXB1TqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 14:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbXB1TqZ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 14:46:25 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:35727 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbXB1TqW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 14:46:22 -0500
Received: by wx-out-0506.google.com with SMTP id h31so234176wxd
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 11:46:21 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=KNxQURLC1xpVdP9TJ0bUHXu66/gXhRyb6/vZDuSxlDu4TfuQ17BE9NLDl3Z7nEWDaJOnApLeU+LUTInN407jpEISU5a5NP4Nxw4ZJ9bLbY/zak3/abjRbj+tl7eyR7rGpA5ZJEBoNAvtjAPg0VwjKsW38YmCPOPpuAsEh8+zo+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=Kzr/58D9+BHqSoR/DGzX6a/ZKctHu99iZxin3LQP6gEKkX0i6SAuZkc1ycRQx1MqACppOGYLivYny4oOrv5emfDyWD15LlGCscFJhFX6O5qbllSdHtspNe9JXuVdwBld1HBZIIL+8kpfzv14Hu7AbWAxlwn+graUug8a3EbFvP0=
Received: by 10.90.78.9 with SMTP id a9mr1051873agb.1172691981371;
        Wed, 28 Feb 2007 11:46:21 -0800 (PST)
Received: from rygel.lnxi.com ( [63.145.151.2])
        by mx.google.com with ESMTP id c1sm1229785nzd.2007.02.28.11.46.19;
        Wed, 28 Feb 2007 11:46:20 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <200702261540.27080.ttelford.groups@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40999>

Subject: [PATCH] 32-bit support for large indexes

This patch continues the work I've done on large indexes, and was completed
largely as an educational exercise; I'm obviously aware of Pack v4 making
these two patches unnecessary, and that inclusion is unlikely.  I'm
submitting the patch to make my previous patch on 64-bit indexes more
complete, should anyone actually use it.

It also introduced changes that may be expressing a bug
in the SHA1 code.  (Or at least, that's all myself and Eric Biederman can
think of... but it was late and we were tired.)

The long and the short of it is a large number of 'offset' variables are 
'unsigned long', and needed to be changed to 'off_t', with a few cleanups
 to accommodate this change.

The primary goal was to get the extended index to work on x86 (as well as
x86_64) machines.  Operations such as 'git fetch/pull', 'git cat-file -p', and
of course 'git-fsck --full' were either failing or reporting errors.

In the process of testing, I found an issue on x86 (x86_64 worked fine) where
'git-fsck' would report problems "error:  packed <sha1> from <packfile> is
corrupt"  (On 3 files in a very large repository; the number of 'corrupt' files
is a small percentage)

The patch has some (currently disabled) code that would write the offending
blobs to disk, as well as print some related data to the screen.  In the test
repository, the 'corrupt' blobs were fairly large binaries, which ended up
being either tar.gz or tar.bz2.  (Of sizes 200-19 MB).  I checked the blobs for
internal consistency (gzip -t and bzip2 -t), and they checked out OK.
Similarly, git-cat-file -p could extract the 'corrupt' blob without any issues.

Being a bit confused at this point, I checked with Eric Biederman, who also
couldn't find why the blob was being labeled as 'corrupt'.  Eric's only guess
was that something funny was happening in the SHA1 generation, which I don't
believe my code even touches.

That being said, the only problem I've found at this point is with git-fsck,
and then only with 32-bit machines.  Other (previously broken with both 
the old and 'new' index formats) operations such as fetch/pull, and cat-file
now work on 32-bit systems.  This marks the first time I've ever been able
to use git with my large repository on 32-bit systems.
---
 builtin-pack-objects.c   |   30 ++++++++++----------
 builtin-unpack-objects.c |   12 ++++----
 cache.h                  |    6 ++--
 index-pack.c             |   20 +++++++------
 pack-check.c             |   35 ++++++++++++++++++++----
 sha1_file.c              |   67 ++++++++++++++++++++++++++-------------------
 6 files changed, 103 insertions(+), 67 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 92087c1..c1b41b5 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -23,7 +23,7 @@ git-pack-objects [{ -q | --progress | --all-progress }] \n\
 struct object_entry {
 	unsigned char sha1[20];
 	unsigned long size;	/* uncompressed size */
-	unsigned long offset;	/* offset into the final pack file;
+	off_t offset;		/* offset into the final pack file;
 				 * nonzero if already written.
 				 */
 	unsigned int depth;	/* delta depth */
@@ -222,7 +222,7 @@ static void prepare_pack_revindex(struct pack_revindex *rix)
 }
 
 static struct revindex_entry * find_packed_object(struct packed_git *p,
-						  unsigned int ofs)
+						  off_t ofs)
 {
 	int num;
 	int lo, hi;
@@ -250,15 +250,15 @@ static struct revindex_entry * find_packed_object(struct packed_git *p,
 	die("internal error: pack revindex corrupt");
 }
 
-static unsigned long find_packed_object_size(struct packed_git *p,
-					     unsigned long ofs)
+static off_t find_packed_object_size(struct packed_git *p,
+					     off_t ofs)
 {
 	struct revindex_entry *entry = find_packed_object(p, ofs);
 	return entry[1].offset - ofs;
 }
 
 static unsigned char *find_packed_object_name(struct packed_git *p,
-					      unsigned long ofs)
+					      off_t ofs)
 {
 	struct revindex_entry *entry = find_packed_object(p, ofs);
 	if (p->index.version == 0)
@@ -320,7 +320,7 @@ static int encode_header(enum object_type type, unsigned long size, unsigned cha
  */
 static int check_pack_inflate(struct packed_git *p,
 		struct pack_window **w_curs,
-		unsigned long offset,
+		off_t offset,
 		unsigned long len,
 		unsigned long expect)
 {
@@ -347,7 +347,7 @@ static int check_pack_inflate(struct packed_git *p,
 static void copy_pack_data(struct sha1file *f,
 		struct packed_git *p,
 		struct pack_window **w_curs,
-		unsigned long offset,
+		off_t offset,
 		unsigned long len)
 {
 	unsigned char *in;
@@ -483,7 +483,7 @@ static unsigned long write_object(struct sha1file *f,
 			 * encoding of the relative offset for the delta
 			 * base from this object's position in the pack.
 			 */
-			unsigned long ofs = entry->offset - entry->delta->offset;
+			off_t ofs = entry->offset - entry->delta->offset;
 			unsigned pos = sizeof(header) - 1;
 			header[pos] = ofs & 127;
 			while (ofs >>= 7)
@@ -504,7 +504,7 @@ static unsigned long write_object(struct sha1file *f,
 	else {
 		struct packed_git *p = entry->in_pack;
 		struct pack_window *w_curs = NULL;
-		unsigned long offset;
+		off_t offset;
 
 		if (entry->delta) {
 			obj_type = (allow_ofs_delta && entry->delta->offset) ?
@@ -514,7 +514,7 @@ static unsigned long write_object(struct sha1file *f,
 		hdrlen = encode_header(obj_type, entry->size, header);
 		sha1write(f, header, hdrlen);
 		if (obj_type == OBJ_OFS_DELTA) {
-			unsigned long ofs = entry->offset - entry->delta->offset;
+			off_t ofs = entry->offset - entry->delta->offset;
 			unsigned pos = sizeof(header) - 1;
 			header[pos] = ofs & 127;
 			while (ofs >>= 7)
@@ -544,7 +544,7 @@ static unsigned long write_object(struct sha1file *f,
 
 static unsigned long write_one(struct sha1file *f,
 			       struct object_entry *e,
-			       unsigned long offset)
+			       off_t offset)
 {
 	if (e->offset || e->preferred_base)
 		/* offset starts from header size and cannot be zero
@@ -562,7 +562,7 @@ static void write_pack_file(void)
 {
 	int i;
 	struct sha1file *f;
-	unsigned long offset;
+	off_t offset;
 	struct pack_header hdr;
 	unsigned last_percent = 999;
 	int do_progress = progress;
@@ -721,7 +721,7 @@ static int add_object_entry(const unsigned char *sha1, unsigned hash, int exclud
 
 	if (!exclude) {
 		for (p = packed_git; p; p = p->next) {
-			unsigned long offset = find_pack_entry_one(sha1, p);
+			off_t offset = find_pack_entry_one(sha1, p);
 			if (offset) {
 				if (incremental)
 					return 0;
@@ -1044,7 +1044,7 @@ static void check_object(struct object_entry *entry)
 		 */
 		if (!no_reuse_delta) {
 			unsigned char c, *base_name;
-			unsigned long ofs;
+			off_t ofs;
 			unsigned long used_0;
 			/* there is at least 20 bytes left in the pack */
 			switch (entry->in_pack_type) {
@@ -1061,7 +1061,7 @@ static void check_object(struct object_entry *entry)
 				ofs = c & 127;
 				while (c & 128) {
 					ofs += 1;
-					if (!ofs || ofs & ~(~0UL >> 7))
+					if (!ofs || ofs & ~(~((off_t) 0) >> 7))
 						die("delta base offset overflow in pack for %s",
 						    sha1_to_hex(entry->sha1));
 					c = buf[used_0++];
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 8f8e898..b85c557 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -13,7 +13,7 @@ static const char unpack_usage[] = "git-unpack-objects [-n] [-q] [-r] < pack-fil
 
 /* We always read in 4kB chunks. */
 static unsigned char buffer[4096];
-static unsigned long offset, len, consumed_bytes;
+static off_t offset, len, consumed_bytes;
 static SHA_CTX ctx;
 
 /*
@@ -88,7 +88,7 @@ static void *get_data(unsigned long size)
 
 struct delta_info {
 	unsigned char base_sha1[20];
-	unsigned long base_offset;
+	off_t base_offset;
 	unsigned long size;
 	void *delta;
 	unsigned nr;
@@ -98,7 +98,7 @@ struct delta_info {
 static struct delta_info *delta_list;
 
 static void add_delta_to_list(unsigned nr, unsigned const char *base_sha1,
-			      unsigned long base_offset,
+			      off_t base_offset,
 			      void *delta, unsigned long size)
 {
 	struct delta_info *info = xmalloc(sizeof(*info));
@@ -113,7 +113,7 @@ static void add_delta_to_list(unsigned nr, unsigned const char *base_sha1,
 }
 
 struct obj_info {
-	unsigned long offset;
+	off_t offset;
 	unsigned char sha1[20];
 };
 
@@ -209,7 +209,7 @@ static void unpack_delta_entry(enum object_type kind, unsigned long delta_size,
 	} else {
 		unsigned base_found = 0;
 		unsigned char *pack, c;
-		unsigned long base_offset;
+		off_t base_offset;
 		unsigned lo, mid, hi;
 
 		pack = fill(1);
@@ -218,7 +218,7 @@ static void unpack_delta_entry(enum object_type kind, unsigned long delta_size,
 		base_offset = c & 127;
 		while (c & 128) {
 			base_offset += 1;
-			if (!base_offset || base_offset & ~(~0UL >> 7))
+			if (!base_offset || base_offset & ~(~((off_t) 0) >> 7))
 				die("offset value overflow for delta base object");
 			pack = fill(1);
 			c = *pack;
diff --git a/cache.h b/cache.h
index b329ca4..88565b0 100644
--- a/cache.h
+++ b/cache.h
@@ -420,15 +420,15 @@ extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 					 struct packed_git *packs);
 
 extern void pack_report(void);
-extern unsigned char* use_pack(struct packed_git *, struct pack_window **, unsigned long, unsigned int *);
+extern unsigned char* use_pack(struct packed_git *, struct pack_window **, off_t, unsigned int *);
 extern void unuse_pack(struct pack_window **);
 extern struct packed_git *add_packed_git(char *, int, int);
 extern int num_packed_objects(const struct packed_git *p);
 extern int nth_packed_object_sha1(const struct packed_git *, int, unsigned char*);
 extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
-extern void *unpack_entry(struct packed_git *, unsigned long, char *, unsigned long *);
+extern void *unpack_entry(struct packed_git *, off_t, char *, unsigned long *);
 extern unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
-extern void packed_object_info_detail(struct packed_git *, unsigned long, char *, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
+extern void packed_object_info_detail(struct packed_git *, off_t, char *, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
 
 /* Dumb servers support */
 extern int update_server_info(int);
diff --git a/index-pack.c b/index-pack.c
index cc22ea2..ef10e38 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -22,7 +22,7 @@ struct object_entry
 
 union delta_base {
 	unsigned char sha1[20];
-	unsigned long offset;
+	off_t offset;
 };
 
 /*
@@ -173,10 +173,10 @@ static void parse_pack_header(void)
 	use(sizeof(struct pack_header));
 }
 
-static void bad_object(unsigned long offset, const char *format,
+static void bad_object(off_t offset, const char *format,
 		       ...) NORETURN __attribute__((format (printf, 2, 3)));
 
-static void bad_object(unsigned long offset, const char *format, ...)
+static void bad_object(off_t offset, const char *format, ...)
 {
 	va_list params;
 	char buf[1024];
@@ -184,10 +184,11 @@ static void bad_object(unsigned long offset, const char *format, ...)
 	va_start(params, format);
 	vsnprintf(buf, sizeof(buf), format, params);
 	va_end(params);
-	die("pack has bad object at offset %lu: %s", offset, buf);
+	die("pack has bad object at offset %llu: %s",
+		(unsigned long long) offset, buf);
 }
 
-static void *unpack_entry_data(unsigned long offset, unsigned long size)
+static void *unpack_entry_data(off_t offset, unsigned long size)
 {
 	z_stream stream;
 	void *buf = xmalloc(size);
@@ -216,7 +217,8 @@ static void *unpack_entry_data(unsigned long offset, unsigned long size)
 static void *unpack_raw_entry(struct object_entry *obj, union delta_base *delta_base)
 {
 	unsigned char *p, c;
-	unsigned long size, base_offset;
+	unsigned long size;
+	off_t base_offset;
 	unsigned shift;
 
 	obj->offset = consumed_bytes;
@@ -249,7 +251,7 @@ static void *unpack_raw_entry(struct object_entry *obj, union delta_base *delta_
 		base_offset = c & 127;
 		while (c & 128) {
 			base_offset += 1;
-			if (!base_offset || base_offset & ~(~0UL >> 7))
+			if (!base_offset || base_offset & ~(~((off_t)0) >> 7))
 				bad_object(obj->offset, "offset value overflow for delta base object");
 			p = fill(1);
 			c = *p;
@@ -275,8 +277,8 @@ static void *unpack_raw_entry(struct object_entry *obj, union delta_base *delta_
 
 static void *get_data_from_pack(struct object_entry *obj)
 {
-	unsigned long from = obj[0].offset + obj[0].hdr_size;
-	unsigned long len = obj[1].offset - from;
+	off_t from = obj[0].offset + obj[0].hdr_size;
+	off_t len = obj[1].offset - from;
 	unsigned char *src, *data;
 	z_stream stream;
 	int st;
diff --git a/pack-check.c b/pack-check.c
index 12ee933..af5fd3b 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -8,7 +8,7 @@ static int verify_packfile(struct packed_git *p,
 	void *index_base = p->index.base;
 	SHA_CTX ctx;
 	unsigned char sha1[20];
-	unsigned long offset = 0, pack_sig = p->pack_size - 20;
+	off_t offset = 0, pack_sig = p->pack_size - 20;
 	int nr_objects, err, i;
 
 	/* Note that the pack header checks are actually performed by
@@ -22,9 +22,11 @@ static int verify_packfile(struct packed_git *p,
 		unsigned int remaining;
 		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
 		offset += remaining;
+/*		printf("Offset: %llu\tpack_sig: %llu\tremaining: %u\tfirst foo\n",(unsigned long long) offset, (unsigned long long) pack_sig, remaining);*/
 		if (offset > pack_sig)
 			remaining -= offset - pack_sig;
 		SHA1_Update(&ctx, in, remaining);
+/*		printf("Offset: %llu\tpack_sig: %llu\tremaining: %u\n",(unsigned long long) offset, (unsigned long long) pack_sig, remaining);*/
 	}
 	SHA1_Final(sha1, &ctx);
 	if (hashcmp(sha1, use_pack(p, w_curs, pack_sig, NULL)))
@@ -33,6 +35,7 @@ static int verify_packfile(struct packed_git *p,
 	if (hashcmp(sha1, (unsigned char *)index_base + index_size - 40))
 		return error("Packfile %s SHA1 mismatch with idx",
 			     p->pack_name);
+/*	printf("Success; pack name: %s\t%s\n", p->pack_name, sha1_to_hex(sha1));*/
 	unuse_pack(w_curs);
 
 	/* Make sure everything reachable from idx is valid.  Since we
@@ -44,7 +47,8 @@ static int verify_packfile(struct packed_git *p,
 		unsigned char sha1[20];
 		void *data;
 		char type[20];
-		unsigned long size, offset;
+		unsigned long size;
+		off_t offset;
 
 		if (nth_packed_object_sha1(p, i, sha1))
 			die("internal error pack-check nth-packed-object");
@@ -58,6 +62,23 @@ static int verify_packfile(struct packed_git *p,
 			continue;
 		}
 		if (check_sha1_signature(sha1, data, size, type)) {
+#if 0
+			int fd;
+			fd = open(sha1_to_hex(sha1), O_RDWR | O_CREAT,0777);
+			if (fd >= 0) {
+				ssize_t written = 0, chunk;
+				while (written != size) {
+					chunk = xwrite(fd, data + written, size - written);
+					if (chunk < 0)
+						die("OUch!");
+					written += chunk;
+				}
+				close(fd);
+				printf("wrote the data\n");
+			}
+#endif
+			printf("Size=%lu\n",size);
+
 			err = error("packed %s from %s is corrupt",
 				    sha1_to_hex(sha1), p->pack_name);
 			free(data);
@@ -85,7 +106,7 @@ static void show_pack_info(struct packed_git *p)
 		char type[20];
 		unsigned long size;
 		unsigned long store_size;
-		unsigned long offset;
+		off_t offset;
 		unsigned int delta_chain_length;
 
 		if (nth_packed_object_sha1(p, i, sha1))
@@ -99,10 +120,12 @@ static void show_pack_info(struct packed_git *p)
 					  base_sha1);
 		printf("%s ", sha1_to_hex(sha1));
 		if (!delta_chain_length)
-			printf("%-6s %lu %lu\n", type, size, offset);
+			printf("%-6s %lu %llu\n", type, size,
+				(unsigned long long) offset);
 		else {
-			printf("%-6s %lu %lu %u %s\n", type, size, offset,
-			       delta_chain_length, sha1_to_hex(base_sha1));
+			printf("%-6s %lu %llu %u %s\n", type, size,
+				(unsigned long long) offset,
+				delta_chain_length, sha1_to_hex(base_sha1));
 			if (delta_chain_length < MAX_CHAIN)
 				chain_histogram[delta_chain_length]++;
 			else
diff --git a/sha1_file.c b/sha1_file.c
index c5ab5cc..23c5cb2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -646,7 +646,7 @@ static int open_packed_git(struct packed_git *p)
 	return -1;
 }
 
-static int in_window(struct pack_window *win, unsigned long offset)
+static int in_window(struct pack_window *win, off_t offset)
 {
 	/* We must promise at least 20 bytes (one hash) after the
 	 * offset is available from this window, otherwise the offset
@@ -661,7 +661,7 @@ static int in_window(struct pack_window *win, unsigned long offset)
 
 unsigned char* use_pack(struct packed_git *p,
 		struct pack_window **w_cursor,
-		unsigned long offset,
+		off_t offset,
 		unsigned int *left)
 {
 	struct pack_window *win = *w_cursor;
@@ -688,9 +688,9 @@ unsigned char* use_pack(struct packed_git *p,
 			size_t window_align = packed_git_window_size / 2;
 			win = xcalloc(1, sizeof(*win));
 			win->offset = (offset / window_align) * window_align;
-			win->len = p->pack_size - win->offset;
-			if (win->len > packed_git_window_size)
-				win->len = packed_git_window_size;
+			win->len = packed_git_window_size;
+			if (win->len > p->pack_size - win->offset)
+				win->len = p->pack_size - win->offset;
 			pack_mapped += win->len;
 			while (packed_git_limit < pack_mapped
 				&& unuse_one_window(p))
@@ -859,7 +859,15 @@ int check_sha1_signature(const unsigned char *sha1, void *map, unsigned long siz
 {
 	unsigned char real_sha1[20];
 	hash_sha1_file(map, size, type, real_sha1);
+#if 0
+	if (hashcmp(sha1, real_sha1) == 0)
+		return 0;
+	printf("%s: src:%s ", __func__, sha1_to_hex(sha1));
+	printf("real: %s type: %s\n", sha1_to_hex(real_sha1), type);
+	return -1;
+#else
 	return hashcmp(sha1, real_sha1) ? -1 : 0;
+#endif
 }
 
 void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
@@ -1061,15 +1069,15 @@ void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned l
 	return unpack_sha1_rest(&stream, hdr, *size);
 }
 
-static unsigned long get_delta_base(struct packed_git *p,
+static off_t get_delta_base(struct packed_git *p,
 				    struct pack_window **w_curs,
-				    unsigned long offset,
+				    off_t offset,
 				    enum object_type kind,
-				    unsigned long delta_obj_offset,
-				    unsigned long *base_obj_offset)
+				    off_t delta_obj_offset,
+				    off_t *base_obj_offset)
 {
 	unsigned char *base_info = use_pack(p, w_curs, offset, NULL);
-	unsigned long base_offset;
+	off_t base_offset;
 
 	/* use_pack() assured us we have [base_info, base_info + 20)
 	 * as a range that we can look at without walking off the
@@ -1083,7 +1091,7 @@ static unsigned long get_delta_base(struct packed_git *p,
 		base_offset = c & 127;
 		while (c & 128) {
 			base_offset += 1;
-			if (!base_offset || base_offset & ~(~0UL >> 7))
+			if (!base_offset || base_offset & ~(~((off_t) 0) >> 7))
 				die("offset value overflow for delta base object");
 			c = base_info[used++];
 			base_offset = (base_offset << 7) + (c & 127);
@@ -1106,18 +1114,18 @@ static unsigned long get_delta_base(struct packed_git *p,
 }
 
 /* forward declaration for a mutually recursive function */
-static int packed_object_info(struct packed_git *p, unsigned long offset,
+static int packed_object_info(struct packed_git *p, off_t offset,
 			      char *type, unsigned long *sizep);
 
 static int packed_delta_info(struct packed_git *p,
 			     struct pack_window **w_curs,
-			     unsigned long offset,
+			     off_t offset,
 			     enum object_type kind,
-			     unsigned long obj_offset,
+			     off_t obj_offset,
 			     char *type,
 			     unsigned long *sizep)
 {
-	unsigned long base_offset;
+	off_t base_offset;
 
 	offset = get_delta_base(p, w_curs, offset, kind,
 		obj_offset, &base_offset);
@@ -1169,9 +1177,9 @@ static int packed_delta_info(struct packed_git *p,
 	return 0;
 }
 
-static unsigned long unpack_object_header(struct packed_git *p,
+static off_t unpack_object_header(struct packed_git *p,
 		struct pack_window **w_curs,
-		unsigned long offset,
+		off_t offset,
 		enum object_type *type,
 		unsigned long *sizep)
 {
@@ -1194,7 +1202,7 @@ static unsigned long unpack_object_header(struct packed_git *p,
 }
 
 void packed_object_info_detail(struct packed_git *p,
-			       unsigned long offset,
+			       off_t offset,
 			       char *type,
 			       unsigned long *size,
 			       unsigned long *store_size,
@@ -1202,7 +1210,8 @@ void packed_object_info_detail(struct packed_git *p,
 			       unsigned char *base_sha1)
 {
 	struct pack_window *w_curs = NULL;
-	unsigned long obj_offset, val;
+	off_t obj_offset;
+	unsigned long val;
 	unsigned char *next_sha1;
 	enum object_type kind;
 
@@ -1243,7 +1252,7 @@ void packed_object_info_detail(struct packed_git *p,
 	}
 }
 
-static int packed_object_info(struct packed_git *p, unsigned long offset,
+static int packed_object_info(struct packed_git *p, off_t offset,
 			      char *type, unsigned long *sizep)
 {
 	struct pack_window *w_curs = NULL;
@@ -1278,7 +1287,7 @@ static int packed_object_info(struct packed_git *p, unsigned long offset,
 
 static void *unpack_compressed_entry(struct packed_git *p,
 				    struct pack_window **w_curs,
-				    unsigned long offset,
+				    off_t offset,
 				    unsigned long size)
 {
 	int st;
@@ -1309,22 +1318,23 @@ static void *unpack_compressed_entry(struct packed_git *p,
 
 static void *unpack_delta_entry(struct packed_git *p,
 				struct pack_window **w_curs,
-				unsigned long offset,
+				off_t offset,
 				unsigned long delta_size,
 				enum object_type kind,
-				unsigned long obj_offset,
+				off_t obj_offset,
 				char *type,
 				unsigned long *sizep)
 {
 	void *delta_data, *result, *base;
-	unsigned long result_size, base_size, base_offset;
+	unsigned long result_size, base_size;
+	off_t base_offset;
 
 	offset = get_delta_base(p, w_curs, offset, kind,
 		obj_offset, &base_offset);
 	base = unpack_entry(p, base_offset, type, &base_size);
 	if (!base)
-		die("failed to read delta base object at %lu from %s",
-		    base_offset, p->pack_name);
+		die("failed to read delta base object at %llu from %s",
+		    (unsigned long long) base_offset, p->pack_name);
 
 	delta_data = unpack_compressed_entry(p, w_curs, offset, delta_size);
 	result = patch_delta(base, base_size,
@@ -1342,7 +1352,8 @@ void *unpack_entry(struct packed_git *p, off_t offset,
 			  char *type, unsigned long *sizep)
 {
 	struct pack_window *w_curs = NULL;
-	unsigned long size, obj_offset = offset;
+	unsigned long size;
+	off_t obj_offset = offset;
 	enum object_type kind;
 	void *retval;
 
@@ -1495,7 +1506,7 @@ static int matches_pack_name(struct packed_git *p, const char *ig)
 static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, const char **ignore_packed)
 {
 	struct packed_git *p;
-	unsigned long offset;
+	off_t offset;
 
 	prepare_packed_git();
 
-- 
1.5.0.2
