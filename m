From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 7/9] Use off_t when we really mean a file offset.
Date: Tue, 6 Mar 2007 20:44:30 -0500
Message-ID: <20070307014430.GH26482@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 02:46:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOlEF-00070d-L5
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 02:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161194AbXCGBol (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 20:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbXCGBoj
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 20:44:39 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49222 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161184AbXCGBoe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 20:44:34 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOlCX-0003qq-DQ; Tue, 06 Mar 2007 20:44:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ABFFC20FBAE; Tue,  6 Mar 2007 20:44:30 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41640>

Not all platforms have declared 'unsigned long' to be a 64 bit value,
but we want to support a 64 bit packfile (or close enough anyway)
in the near future as some projects are getting large enough that
their packed size exceeds 4 GiB.

By using off_t, the POSIX type that is declared to mean an offset
within a file, we support whatever maximum file size the underlying
operating system will handle.  For most modern systems this is up
around 2^60 or higher.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 cache.h           |   10 ++++----
 fast-import.c     |    4 ---
 git-compat-util.h |    4 +++
 pack-check.c      |   21 +++++++++++--------
 pack-redundant.c  |    8 +++---
 sha1_file.c       |   54 ++++++++++++++++++++++++++++------------------------
 6 files changed, 54 insertions(+), 47 deletions(-)

diff --git a/cache.h b/cache.h
index 63a093b..ae25759 100644
--- a/cache.h
+++ b/cache.h
@@ -383,7 +383,7 @@ extern struct packed_git {
 } *packed_git;
 
 struct pack_entry {
-	unsigned int offset;
+	off_t offset;
 	unsigned char sha1[20];
 	struct packed_git *p;
 };
@@ -422,15 +422,15 @@ extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 					 struct packed_git *packs);
 
 extern void pack_report(void);
-extern unsigned char* use_pack(struct packed_git *, struct pack_window **, unsigned long, unsigned int *);
+extern unsigned char* use_pack(struct packed_git *, struct pack_window **, off_t, unsigned int *);
 extern void unuse_pack(struct pack_window **);
 extern struct packed_git *add_packed_git(char *, int, int);
 extern uint32_t num_packed_objects(const struct packed_git *p);
 extern int nth_packed_object_sha1(const struct packed_git *, uint32_t, unsigned char*);
-extern unsigned long find_pack_entry_one(const unsigned char *, struct packed_git *);
-extern void *unpack_entry(struct packed_git *, unsigned long, enum object_type *, unsigned long *);
+extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
+extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
-extern const char *packed_object_info_detail(struct packed_git *, unsigned long, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
+extern const char *packed_object_info_detail(struct packed_git *, off_t, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
 
 /* Dumb servers support */
 extern int update_server_info(int);
diff --git a/fast-import.c b/fast-import.c
index 132dd9c..a418a17 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -133,10 +133,6 @@ Format of STDIN stream:
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
 
-#ifndef PRIuMAX
-#define PRIuMAX "llu"
-#endif
-
 struct object_entry
 {
 	struct object_entry *next;
diff --git a/git-compat-util.h b/git-compat-util.h
index 56212b2..33b68e4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -70,6 +70,10 @@
 #define PATH_MAX 4096
 #endif
 
+#ifndef PRIuMAX
+#define PRIuMAX "llu"
+#endif
+
 #ifdef __GNUC__
 #define NORETURN __attribute__((__noreturn__))
 #else
diff --git a/pack-check.c b/pack-check.c
index 7c82f67..299c514 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -4,11 +4,11 @@
 static int verify_packfile(struct packed_git *p,
 		struct pack_window **w_curs)
 {
-	unsigned long index_size = p->index_size;
+	off_t index_size = p->index_size;
 	void *index_base = p->index_base;
 	SHA_CTX ctx;
 	unsigned char sha1[20];
-	unsigned long offset = 0, pack_sig = p->pack_size - 20;
+	off_t offset = 0, pack_sig = p->pack_size - 20;
 	uint32_t nr_objects, i;
 	int err;
 
@@ -24,7 +24,7 @@ static int verify_packfile(struct packed_git *p,
 		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
 		offset += remaining;
 		if (offset > pack_sig)
-			remaining -= offset - pack_sig;
+			remaining -= (unsigned int)(offset - pack_sig);
 		SHA1_Update(&ctx, in, remaining);
 	}
 	SHA1_Final(sha1, &ctx);
@@ -45,7 +45,8 @@ static int verify_packfile(struct packed_git *p,
 		unsigned char sha1[20];
 		void *data;
 		enum object_type type;
-		unsigned long size, offset;
+		unsigned long size;
+		off_t offset;
 
 		if (nth_packed_object_sha1(p, i, sha1))
 			die("internal error pack-check nth-packed-object");
@@ -85,7 +86,7 @@ static void show_pack_info(struct packed_git *p)
 		const char *type;
 		unsigned long size;
 		unsigned long store_size;
-		unsigned long offset;
+		off_t offset;
 		unsigned int delta_chain_length;
 
 		if (nth_packed_object_sha1(p, i, sha1))
@@ -99,9 +100,11 @@ static void show_pack_info(struct packed_git *p)
 						 base_sha1);
 		printf("%s ", sha1_to_hex(sha1));
 		if (!delta_chain_length)
-			printf("%-6s %lu %lu\n", type, size, offset);
+			printf("%-6s %lu %"PRIuMAX"\n",
+			       type, size, (uintmax_t)offset);
 		else {
-			printf("%-6s %lu %lu %u %s\n", type, size, offset,
+			printf("%-6s %lu %"PRIuMAX" %u %s\n",
+			       type, size, (uintmax_t)offset,
 			       delta_chain_length, sha1_to_hex(base_sha1));
 			if (delta_chain_length < MAX_CHAIN)
 				chain_histogram[delta_chain_length]++;
@@ -123,7 +126,7 @@ static void show_pack_info(struct packed_git *p)
 
 int verify_pack(struct packed_git *p, int verbose)
 {
-	unsigned long index_size = p->index_size;
+	off_t index_size = p->index_size;
 	void *index_base = p->index_base;
 	SHA_CTX ctx;
 	unsigned char sha1[20];
@@ -132,7 +135,7 @@ int verify_pack(struct packed_git *p, int verbose)
 	ret = 0;
 	/* Verify SHA1 sum of the index file */
 	SHA1_Init(&ctx);
-	SHA1_Update(&ctx, index_base, index_size - 20);
+	SHA1_Update(&ctx, index_base, (unsigned int)(index_size - 20));
 	SHA1_Final(sha1, &ctx);
 	if (hashcmp(sha1, (unsigned char *)index_base + index_size - 20))
 		ret = error("Packfile index for %s SHA1 mismatch",
diff --git a/pack-redundant.c b/pack-redundant.c
index edb5524..c8f7d9a 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -396,9 +396,9 @@ static size_t get_pack_redundancy(struct pack_list *pl)
 	return ret;
 }
 
-static inline size_t pack_set_bytecount(struct pack_list *pl)
+static inline off_t pack_set_bytecount(struct pack_list *pl)
 {
-	size_t ret = 0;
+	off_t ret = 0;
 	while (pl) {
 		ret += pl->pack->pack_size;
 		ret += pl->pack->index_size;
@@ -413,7 +413,7 @@ static void minimize(struct pack_list **min)
 		*non_unique = NULL, *min_perm = NULL;
 	struct pll *perm, *perm_all, *perm_ok = NULL, *new_perm;
 	struct llist *missing;
-	size_t min_perm_size = (size_t)-1, perm_size;
+	off_t min_perm_size = 0, perm_size;
 	int n;
 
 	pl = local_packs;
@@ -461,7 +461,7 @@ static void minimize(struct pack_list **min)
 	perm = perm_ok;
 	while (perm) {
 		perm_size = pack_set_bytecount(perm->pl);
-		if (min_perm_size > perm_size) {
+		if (!min_perm_size || min_perm_size > perm_size) {
 			min_perm_size = perm_size;
 			min_perm = perm->pl;
 		}
diff --git a/sha1_file.c b/sha1_file.c
index 54ffa7c..50d800e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -629,7 +629,7 @@ static int open_packed_git(struct packed_git *p)
 	return -1;
 }
 
-static int in_window(struct pack_window *win, unsigned long offset)
+static int in_window(struct pack_window *win, off_t offset)
 {
 	/* We must promise at least 20 bytes (one hash) after the
 	 * offset is available from this window, otherwise the offset
@@ -644,7 +644,7 @@ static int in_window(struct pack_window *win, unsigned long offset)
 
 unsigned char* use_pack(struct packed_git *p,
 		struct pack_window **w_cursor,
-		unsigned long offset,
+		off_t offset,
 		unsigned int *left)
 {
 	struct pack_window *win = *w_cursor;
@@ -1049,14 +1049,14 @@ void * unpack_sha1_file(void *map, unsigned long mapsize, enum object_type *type
 	return unpack_sha1_rest(&stream, hdr, *size);
 }
 
-static unsigned long get_delta_base(struct packed_git *p,
+static off_t get_delta_base(struct packed_git *p,
 				    struct pack_window **w_curs,
-				    unsigned long *curpos,
+				    off_t *curpos,
 				    enum object_type type,
-				    unsigned long delta_obj_offset)
+				    off_t delta_obj_offset)
 {
 	unsigned char *base_info = use_pack(p, w_curs, *curpos, NULL);
-	unsigned long base_offset;
+	off_t base_offset;
 
 	/* use_pack() assured us we have [base_info, base_info + 20)
 	 * as a range that we can look at without walking off the
@@ -1092,17 +1092,17 @@ static unsigned long get_delta_base(struct packed_git *p,
 }
 
 /* forward declaration for a mutually recursive function */
-static int packed_object_info(struct packed_git *p, unsigned long offset,
+static int packed_object_info(struct packed_git *p, off_t offset,
 			      unsigned long *sizep);
 
 static int packed_delta_info(struct packed_git *p,
 			     struct pack_window **w_curs,
-			     unsigned long curpos,
+			     off_t curpos,
 			     enum object_type type,
-			     unsigned long obj_offset,
+			     off_t obj_offset,
 			     unsigned long *sizep)
 {
-	unsigned long base_offset;
+	off_t base_offset;
 
 	base_offset = get_delta_base(p, w_curs, &curpos, type, obj_offset);
 	type = packed_object_info(p, base_offset, NULL);
@@ -1152,7 +1152,7 @@ static int packed_delta_info(struct packed_git *p,
 
 static int unpack_object_header(struct packed_git *p,
 				struct pack_window **w_curs,
-				unsigned long *curpos,
+				off_t *curpos,
 				unsigned long *sizep)
 {
 	unsigned char *base;
@@ -1176,14 +1176,15 @@ static int unpack_object_header(struct packed_git *p,
 }
 
 const char *packed_object_info_detail(struct packed_git *p,
-				      unsigned long obj_offset,
+				      off_t obj_offset,
 				      unsigned long *size,
 				      unsigned long *store_size,
 				      unsigned int *delta_chain_length,
 				      unsigned char *base_sha1)
 {
 	struct pack_window *w_curs = NULL;
-	unsigned long curpos, dummy;
+	off_t curpos;
+	unsigned long dummy;
 	unsigned char *next_sha1;
 	enum object_type type;
 
@@ -1223,11 +1224,12 @@ const char *packed_object_info_detail(struct packed_git *p,
 	}
 }
 
-static int packed_object_info(struct packed_git *p, unsigned long obj_offset,
+static int packed_object_info(struct packed_git *p, off_t obj_offset,
 			      unsigned long *sizep)
 {
 	struct pack_window *w_curs = NULL;
-	unsigned long size, curpos = obj_offset;
+	unsigned long size;
+	off_t curpos = obj_offset;
 	enum object_type type;
 
 	type = unpack_object_header(p, &w_curs, &curpos, &size);
@@ -1255,7 +1257,7 @@ static int packed_object_info(struct packed_git *p, unsigned long obj_offset,
 
 static void *unpack_compressed_entry(struct packed_git *p,
 				    struct pack_window **w_curs,
-				    unsigned long curpos,
+				    off_t curpos,
 				    unsigned long size)
 {
 	int st;
@@ -1286,20 +1288,22 @@ static void *unpack_compressed_entry(struct packed_git *p,
 
 static void *unpack_delta_entry(struct packed_git *p,
 				struct pack_window **w_curs,
-				unsigned long curpos,
+				off_t curpos,
 				unsigned long delta_size,
-				unsigned long obj_offset,
+				off_t obj_offset,
 				enum object_type *type,
 				unsigned long *sizep)
 {
 	void *delta_data, *result, *base;
-	unsigned long base_size, base_offset;
+	unsigned long base_size;
+	off_t base_offset;
 
 	base_offset = get_delta_base(p, w_curs, &curpos, *type, obj_offset);
 	base = unpack_entry(p, base_offset, type, &base_size);
 	if (!base)
-		die("failed to read delta base object at %lu from %s",
-		    base_offset, p->pack_name);
+		die("failed to read delta base object"
+		    " at %"PRIuMAX" from %s",
+		    (uintmax_t)base_offset, p->pack_name);
 
 	delta_data = unpack_compressed_entry(p, w_curs, curpos, delta_size);
 	result = patch_delta(base, base_size,
@@ -1312,11 +1316,11 @@ static void *unpack_delta_entry(struct packed_git *p,
 	return result;
 }
 
-void *unpack_entry(struct packed_git *p, unsigned long obj_offset,
+void *unpack_entry(struct packed_git *p, off_t obj_offset,
 		   enum object_type *type, unsigned long *sizep)
 {
 	struct pack_window *w_curs = NULL;
-	unsigned long curpos = obj_offset;
+	off_t curpos = obj_offset;
 	void *data;
 
 	*type = unpack_object_header(p, &w_curs, &curpos, sizep);
@@ -1355,7 +1359,7 @@ int nth_packed_object_sha1(const struct packed_git *p, uint32_t n,
 	return 0;
 }
 
-unsigned long find_pack_entry_one(const unsigned char *sha1,
+off_t find_pack_entry_one(const unsigned char *sha1,
 				  struct packed_git *p)
 {
 	uint32_t *level1_ofs = p->index_base;
@@ -1397,7 +1401,7 @@ static int matches_pack_name(struct packed_git *p, const char *ig)
 static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, const char **ignore_packed)
 {
 	struct packed_git *p;
-	unsigned long offset;
+	off_t offset;
 
 	prepare_packed_git();
 
-- 
1.5.0.3.863.gf0989
