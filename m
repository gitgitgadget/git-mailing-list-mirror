From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 7/17] Replace use_packed_git with window cursors.
Date: Sat, 23 Dec 2006 02:34:08 -0500
Message-ID: <20061223073408.GH9837@spearce.org>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 08:34:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy1Ob-0001qn-Md
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 08:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbWLWHeO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 02:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752686AbWLWHeO
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 02:34:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38775 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbWLWHeM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 02:34:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy1O6-00038X-9z; Sat, 23 Dec 2006 02:33:46 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EC56720FB65; Sat, 23 Dec 2006 02:34:08 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35286>

Part of the implementation concept of the sliding mmap window for
pack access is to permit multiple windows per pack to be mapped
independently.  Since the inuse_cnt is associated with the mmap and
not with the file, this value is in struct pack_window and needs to
be incremented/decremented for each pack_window accessed by any code.

To faciliate that implementation we need to replace all uses of
use_packed_git() and unuse_packed_git() with a different API that
follows struct pack_window objects rather than struct packed_git.

The way this works is when we need to start accessing a pack for
the first time we should setup a new window 'cursor' by declaring
a local and setting it to NULL:

  struct pack_windows *w_curs = NULL;

To obtain the memory region which contains a specific section of
the pack file we invoke use_pack(), supplying the address of our
current window cursor:

  unsigned int len;
  unsigned char *addr = use_pack(p, &w_curs, offset, &len);

the returned address `addr` will be the first byte at `offset`
within the pack file.  The optional variable len will also be
updated with the number of bytes remaining following the address.

Multiple calls to use_pack() with the same window cursor will
update the window cursor, moving it from one window to another
when necessary.  In this way each window cursor variable maintains
only one struct pack_window inuse at a time.

Finally before exiting the scope which originally declared the window
cursor we must invoke unuse_pack() to unuse the current window (which
may be different from the one that was first obtained from use_pack):

  unuse_pack(&w_curs);

This implementation is still not complete with regards to multiple
windows, as only one window per pack file is supported right now.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-pack-objects.c |   16 +++----
 cache.h                |    4 +-
 pack-check.c           |   22 +++++----
 sha1_file.c            |  110 ++++++++++++++++++++++++++++--------------------
 4 files changed, 85 insertions(+), 67 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 4a00a12..6d7ae7f 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -416,6 +416,7 @@ static unsigned long write_object(struct sha1file *f,
 	}
 	else {
 		struct packed_git *p = entry->in_pack;
+		struct pack_window *w_curs = NULL;
 
 		if (entry->delta) {
 			obj_type = (allow_ofs_delta && entry->delta->offset) ?
@@ -437,16 +438,14 @@ static unsigned long write_object(struct sha1file *f,
 			hdrlen += 20;
 		}
 
-		use_packed_git(p);
-		buf = p->windows->base
-			+ entry->in_pack_offset
-			+ entry->in_pack_header_size;
+		buf = use_pack(p, &w_curs, entry->in_pack_offset
+			+ entry->in_pack_header_size, NULL);
 		datalen = find_packed_object_size(p, entry->in_pack_offset)
 				- entry->in_pack_header_size;
 		if (!pack_to_stdout && check_inflate(buf, datalen, entry->size))
 			die("corrupt delta in pack %s", sha1_to_hex(entry->sha1));
 		sha1write(f, buf, datalen);
-		unuse_packed_git(p);
+		unuse_pack(&w_curs);
 		reused++;
 	}
 	if (entry->delta)
@@ -937,14 +936,13 @@ static void check_object(struct object_entry *entry)
 
 	if (entry->in_pack && !entry->preferred_base) {
 		struct packed_git *p = entry->in_pack;
+		struct pack_window *w_curs = NULL;
 		unsigned long left = p->pack_size - entry->in_pack_offset;
 		unsigned long size, used;
 		unsigned char *buf;
 		struct object_entry *base_entry = NULL;
 
-		use_packed_git(p);
-		buf = p->windows->base;
-		buf += entry->in_pack_offset;
+		buf = use_pack(p, &w_curs, entry->in_pack_offset, NULL);
 
 		/* We want in_pack_type even if we do not reuse delta.
 		 * There is no point not reusing non-delta representations.
@@ -990,7 +988,7 @@ static void check_object(struct object_entry *entry)
 			if (base_name)
 				base_entry = locate_object_entry(base_name);
 		}
-		unuse_packed_git(p);
+		unuse_pack(&w_curs);
 		entry->in_pack_header_size = used;
 
 		if (base_entry) {
diff --git a/cache.h b/cache.h
index 0afc55e..b294bbf 100644
--- a/cache.h
+++ b/cache.h
@@ -397,8 +397,8 @@ extern void install_packed_git(struct packed_git *pack);
 extern struct packed_git *find_sha1_pack(const unsigned char *sha1, 
 					 struct packed_git *packs);
 
-extern int use_packed_git(struct packed_git *);
-extern void unuse_packed_git(struct packed_git *);
+extern unsigned char* use_pack(struct packed_git *, struct pack_window **, unsigned long, unsigned int *);
+extern void unuse_pack(struct pack_window **);
 extern struct packed_git *add_packed_git(char *, int, int);
 extern int num_packed_objects(const struct packed_git *p);
 extern int nth_packed_object_sha1(const struct packed_git *, int, unsigned char*);
diff --git a/pack-check.c b/pack-check.c
index 761cc85..972916f 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -1,7 +1,8 @@
 #include "cache.h"
 #include "pack.h"
 
-static int verify_packfile(struct packed_git *p)
+static int verify_packfile(struct packed_git *p,
+		struct pack_window **w_curs)
 {
 	unsigned long index_size = p->index_size;
 	void *index_base = p->index_base;
@@ -13,7 +14,7 @@ static int verify_packfile(struct packed_git *p)
 	int nr_objects, err, i;
 
 	/* Header consistency check */
-	pack_base = p->windows->base;
+	pack_base = use_pack(p, w_curs, 0, NULL);
 	hdr = (struct pack_header*)pack_base;
 	if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
 		return error("Packfile %s signature mismatch", p->pack_name);
@@ -72,13 +73,14 @@ static int verify_packfile(struct packed_git *p)
 
 #define MAX_CHAIN 40
 
-static void show_pack_info(struct packed_git *p)
+static void show_pack_info(struct packed_git *p,
+		struct pack_window **w_curs)
 {
 	struct pack_header *hdr;
 	int nr_objects, i;
 	unsigned int chain_histogram[MAX_CHAIN];
 
-	hdr = (struct pack_header*)p->windows->base;
+	hdr = (struct pack_header*)use_pack(p, w_curs, 0, NULL);
 	nr_objects = ntohl(hdr->hdr_entries);
 	memset(chain_histogram, 0, sizeof(chain_histogram));
 
@@ -142,18 +144,18 @@ int verify_pack(struct packed_git *p, int verbose)
 
 	if (!ret) {
 		/* Verify pack file */
-		use_packed_git(p);
-		ret = verify_packfile(p);
-		unuse_packed_git(p);
+		struct pack_window *w_curs = NULL;
+		ret = verify_packfile(p, &w_curs);
+		unuse_pack(&w_curs);
 	}
 
 	if (verbose) {
 		if (ret)
 			printf("%s: bad\n", p->pack_name);
 		else {
-			use_packed_git(p);
-			show_pack_info(p);
-			unuse_packed_git(p);
+			struct pack_window *w_curs = NULL;
+			show_pack_info(p, &w_curs);
+			unuse_pack(&w_curs);
 			printf("%s: ok\n", p->pack_name);
 		}
 	}
diff --git a/sha1_file.c b/sha1_file.c
index cc68a8b..ef3f056 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -470,10 +470,13 @@ static int unuse_one_packed_git(void)
 	return 1;
 }
 
-void unuse_packed_git(struct packed_git *p)
+void unuse_pack(struct pack_window **w_cursor)
 {
-	if (p->windows)
-		p->windows->inuse_cnt--;
+	struct pack_window *w = *w_cursor;
+	if (w) {
+		w->inuse_cnt--;
+		*w_cursor = NULL;
+	}
 }
 
 static void open_packed_git(struct packed_git *p)
@@ -518,13 +521,16 @@ static void open_packed_git(struct packed_git *p)
 		die("packfile %s does not match index", p->pack_name);
 }
 
-int use_packed_git(struct packed_git *p)
+unsigned char* use_pack(struct packed_git *p,
+		struct pack_window **w_cursor,
+		unsigned long offset,
+		unsigned int *left)
 {
+	struct pack_window *win = p->windows;
+
 	if (p->pack_fd == -1)
 		open_packed_git(p);
-	if (!p->windows) {
-		struct pack_window *win;
-
+	if (!win) {
 		pack_mapped += p->pack_size;
 		while (packed_git_limit < pack_mapped && unuse_one_packed_git())
 			; /* nothing */
@@ -535,9 +541,14 @@ int use_packed_git(struct packed_git *p)
 			die("packfile %s cannot be mapped.", p->pack_name);
 		p->windows = win;
 	}
-	p->windows->last_used = pack_used_ctr++;
-	p->windows->inuse_cnt++;
-	return 0;
+	if (win != *w_cursor) {
+		win->last_used = pack_used_ctr++;
+		win->inuse_cnt++;
+		*w_cursor = win;
+	}
+	if (left)
+		*left = win->len - offset;
+	return win->base + offset;
 }
 
 struct packed_git *add_packed_git(char *path, int path_len, int local)
@@ -881,12 +892,13 @@ void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned l
 }
 
 static unsigned long get_delta_base(struct packed_git *p,
+				    struct pack_window **w_curs,
 				    unsigned long offset,
 				    enum object_type kind,
 				    unsigned long delta_obj_offset,
 				    unsigned long *base_obj_offset)
 {
-	unsigned char *base_info = p->windows->base + offset;
+	unsigned char *base_info = use_pack(p, w_curs, offset, NULL);
 	unsigned long base_offset;
 
 	/* there must be at least 20 bytes left regardless of delta type */
@@ -926,6 +938,7 @@ static int packed_object_info(struct packed_git *p, unsigned long offset,
 			      char *type, unsigned long *sizep);
 
 static int packed_delta_info(struct packed_git *p,
+			     struct pack_window **w_curs,
 			     unsigned long offset,
 			     enum object_type kind,
 			     unsigned long obj_offset,
@@ -934,7 +947,8 @@ static int packed_delta_info(struct packed_git *p,
 {
 	unsigned long base_offset;
 
-	offset = get_delta_base(p, offset, kind, obj_offset, &base_offset);
+	offset = get_delta_base(p, w_curs, offset, kind,
+		obj_offset, &base_offset);
 
 	/* We choose to only get the type of the base object and
 	 * ignore potentially corrupt pack file that expects the delta
@@ -953,8 +967,7 @@ static int packed_delta_info(struct packed_git *p,
 
 		memset(&stream, 0, sizeof(stream));
 
-		stream.next_in = p->windows->base + offset;
-		stream.avail_in = p->pack_size - offset;
+		stream.next_in = use_pack(p, w_curs, offset, &stream.avail_in);
 		stream.next_out = delta_head;
 		stream.avail_out = sizeof(delta_head);
 
@@ -980,16 +993,18 @@ static int packed_delta_info(struct packed_git *p,
 	return 0;
 }
 
-static unsigned long unpack_object_header(struct packed_git *p, unsigned long offset,
-	enum object_type *type, unsigned long *sizep)
+static unsigned long unpack_object_header(struct packed_git *p,
+		struct pack_window **w_curs,
+		unsigned long offset,
+		enum object_type *type,
+		unsigned long *sizep)
 {
+	unsigned char *base;
+	unsigned int left;
 	unsigned long used;
 
-	if (p->pack_size <= offset)
-		die("object offset outside of pack file");
-
-	used = unpack_object_header_gently(p->windows->base + offset,
-					   p->pack_size - offset, type, sizep);
+	base = use_pack(p, w_curs, offset, &left);
+	used = unpack_object_header_gently(base, left, type, sizep);
 	if (!used)
 		die("object offset outside of pack file");
 
@@ -1004,13 +1019,14 @@ void packed_object_info_detail(struct packed_git *p,
 			       unsigned int *delta_chain_length,
 			       unsigned char *base_sha1)
 {
+	struct pack_window *w_curs = NULL;
 	unsigned long obj_offset, val;
 	unsigned char *next_sha1;
 	enum object_type kind;
 
 	*delta_chain_length = 0;
 	obj_offset = offset;
-	offset = unpack_object_header(p, offset, &kind, size);
+	offset = unpack_object_header(p, &w_curs, offset, &kind, size);
 
 	for (;;) {
 		switch (kind) {
@@ -1023,25 +1039,24 @@ void packed_object_info_detail(struct packed_git *p,
 		case OBJ_TAG:
 			strcpy(type, type_names[kind]);
 			*store_size = 0; /* notyet */
+			unuse_pack(&w_curs);
 			return;
 		case OBJ_OFS_DELTA:
-			get_delta_base(p, offset, kind, obj_offset, &offset);
+			get_delta_base(p, &w_curs, offset, kind,
+				obj_offset, &offset);
 			if (*delta_chain_length == 0) {
 				/* TODO: find base_sha1 as pointed by offset */
 			}
 			break;
 		case OBJ_REF_DELTA:
-			if (p->pack_size <= offset + 20)
-				die("pack file %s records an incomplete delta base",
-				    p->pack_name);
-			next_sha1 = p->windows->base + offset;
+			next_sha1 = use_pack(p, &w_curs, offset, NULL);
 			if (*delta_chain_length == 0)
 				hashcpy(base_sha1, next_sha1);
 			offset = find_pack_entry_one(next_sha1, p);
 			break;
 		}
 		obj_offset = offset;
-		offset = unpack_object_header(p, offset, &kind, &val);
+		offset = unpack_object_header(p, &w_curs, offset, &kind, &val);
 		(*delta_chain_length)++;
 	}
 }
@@ -1049,20 +1064,26 @@ void packed_object_info_detail(struct packed_git *p,
 static int packed_object_info(struct packed_git *p, unsigned long offset,
 			      char *type, unsigned long *sizep)
 {
+	struct pack_window *w_curs = NULL;
 	unsigned long size, obj_offset = offset;
 	enum object_type kind;
+	int r;
 
-	offset = unpack_object_header(p, offset, &kind, &size);
+	offset = unpack_object_header(p, &w_curs, offset, &kind, &size);
 
 	switch (kind) {
 	case OBJ_OFS_DELTA:
 	case OBJ_REF_DELTA:
-		return packed_delta_info(p, offset, kind, obj_offset, type, sizep);
+		r = packed_delta_info(p, &w_curs, offset, kind,
+			obj_offset, type, sizep);
+		unuse_pack(&w_curs);
+		return r;
 	case OBJ_COMMIT:
 	case OBJ_TREE:
 	case OBJ_BLOB:
 	case OBJ_TAG:
 		strcpy(type, type_names[kind]);
+		unuse_pack(&w_curs);
 		break;
 	default:
 		die("pack %s contains unknown object type %d",
@@ -1074,6 +1095,7 @@ static int packed_object_info(struct packed_git *p, unsigned long offset,
 }
 
 static void *unpack_compressed_entry(struct packed_git *p,
+				    struct pack_window **w_curs,
 				    unsigned long offset,
 				    unsigned long size)
 {
@@ -1084,8 +1106,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	buffer = xmalloc(size + 1);
 	buffer[size] = 0;
 	memset(&stream, 0, sizeof(stream));
-	stream.next_in = p->windows->base + offset;
-	stream.avail_in = p->pack_size - offset;
+	stream.next_in = use_pack(p, w_curs, offset, &stream.avail_in);
 	stream.next_out = buffer;
 	stream.avail_out = size;
 
@@ -1101,6 +1122,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
 }
 
 static void *unpack_delta_entry(struct packed_git *p,
+				struct pack_window **w_curs,
 				unsigned long offset,
 				unsigned long delta_size,
 				enum object_type kind,
@@ -1111,13 +1133,14 @@ static void *unpack_delta_entry(struct packed_git *p,
 	void *delta_data, *result, *base;
 	unsigned long result_size, base_size, base_offset;
 
-	offset = get_delta_base(p, offset, kind, obj_offset, &base_offset);
+	offset = get_delta_base(p, w_curs, offset, kind,
+		obj_offset, &base_offset);
 	base = unpack_entry(p, base_offset, type, &base_size);
 	if (!base)
 		die("failed to read delta base object at %lu from %s",
 		    base_offset, p->pack_name);
 
-	delta_data = unpack_compressed_entry(p, offset, delta_size);
+	delta_data = unpack_compressed_entry(p, w_curs, offset, delta_size);
 	result = patch_delta(base, base_size,
 			     delta_data, delta_size,
 			     &result_size);
@@ -1132,17 +1155,17 @@ static void *unpack_delta_entry(struct packed_git *p,
 void *unpack_entry(struct packed_git *p, unsigned long offset,
 			  char *type, unsigned long *sizep)
 {
+	struct pack_window *w_curs = NULL;
 	unsigned long size, obj_offset = offset;
 	enum object_type kind;
 	void *retval;
 
-	if (use_packed_git(p))
-		die("cannot map packed file");
-	offset = unpack_object_header(p, offset, &kind, &size);
+	offset = unpack_object_header(p, &w_curs, offset, &kind, &size);
 	switch (kind) {
 	case OBJ_OFS_DELTA:
 	case OBJ_REF_DELTA:
-		retval = unpack_delta_entry(p, offset, size, kind, obj_offset, type, sizep);
+		retval = unpack_delta_entry(p, &w_curs, offset, size,
+			kind, obj_offset, type, sizep);
 		break;
 	case OBJ_COMMIT:
 	case OBJ_TREE:
@@ -1150,12 +1173,12 @@ void *unpack_entry(struct packed_git *p, unsigned long offset,
 	case OBJ_TAG:
 		strcpy(type, type_names[kind]);
 		*sizep = size;
-		retval = unpack_compressed_entry(p, offset, size);
+		retval = unpack_compressed_entry(p, &w_curs, offset, size);
 		break;
 	default:
 		die("unknown object type %i in %s", kind, p->pack_name);
 	}
-	unuse_packed_git(p);
+	unuse_pack(&w_curs);
 	return retval;
 }
 
@@ -1282,7 +1305,6 @@ static int sha1_loose_object_info(const unsigned char *sha1, char *type, unsigne
 
 int sha1_object_info(const unsigned char *sha1, char *type, unsigned long *sizep)
 {
-	int status;
 	struct pack_entry e;
 
 	if (!find_pack_entry(sha1, &e, NULL)) {
@@ -1290,11 +1312,7 @@ int sha1_object_info(const unsigned char *sha1, char *type, unsigned long *sizep
 		if (!find_pack_entry(sha1, &e, NULL))
 			return sha1_loose_object_info(sha1, type, sizep);
 	}
-	if (use_packed_git(e.p))
-		die("cannot map packed file");
-	status = packed_object_info(e.p, e.offset, type, sizep);
-	unuse_packed_git(e.p);
-	return status;
+	return packed_object_info(e.p, e.offset, type, sizep);
 }
 
 static void *read_packed_sha1(const unsigned char *sha1, char *type, unsigned long *size)
-- 
1.4.4.3.g87d8
