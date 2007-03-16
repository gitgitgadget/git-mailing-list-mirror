From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] clean up pack index handling a bit
Date: Fri, 16 Mar 2007 16:42:50 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703161639270.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 16 21:42:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSJGM-0006UJ-MS
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 21:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641AbXCPUmz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 16:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753654AbXCPUmz
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 16:42:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49701 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbXCPUmx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 16:42:53 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF000HE2K7EUFD0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 16 Mar 2007 16:42:52 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42397>


Especially with the new index format to come, it is more appropriate
to encapsulate more into check_packed_git_idx() and assume less of the
index format in struct packed_git.

To that effect, the index_base is renamed to index_data with void * type
so it is not used directly but other pointers initialized with it. This
allows for a couple pointer cast removal, as well as providing a better
generic name to grep for when adding support for new index versions or
formats.

And index_data is declared const too while at it.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index f8ebad0..73d448b 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -166,11 +166,12 @@ static void prepare_pack_revindex(struct pack_revindex *rix)
 	struct packed_git *p = rix->p;
 	int num_ent = num_packed_objects(p);
 	int i;
-	void *index = p->index_base + 256;
+	const char *index = p->index_data;
 
+	index += 4 * 256;
 	rix->revindex = xmalloc(sizeof(*rix->revindex) * (num_ent + 1));
 	for (i = 0; i < num_ent; i++) {
-		unsigned int hl = *((unsigned int *)((char *) index + 24*i));
+		uint32_t hl = *((uint32_t *)(index + 24 * i));
 		rix->revindex[i].offset = ntohl(hl);
 		rix->revindex[i].nr = i;
 	}
@@ -217,11 +218,11 @@ static off_t find_packed_object_size(struct packed_git *p, off_t ofs)
 	return entry[1].offset - ofs;
 }
 
-static unsigned char *find_packed_object_name(struct packed_git *p,
-					      off_t ofs)
+static const unsigned char *find_packed_object_name(struct packed_git *p,
+						    off_t ofs)
 {
 	struct revindex_entry *entry = find_packed_object(p, ofs);
-	return (unsigned char *)(p->index_base + 256) + 24 * entry->nr + 4;
+	return ((unsigned char *)p->index_data) + 4 * 256 + 24 * entry->nr + 4;
 }
 
 static void *delta_against(void *buf, unsigned long size, struct object_entry *entry)
@@ -996,7 +997,8 @@ static void check_object(struct object_entry *entry)
 		 * delta.
 		 */
 		if (!no_reuse_delta) {
-			unsigned char c, *base_name;
+			unsigned char c;
+			const unsigned char *base_name;
 			off_t ofs;
 			unsigned long used_0;
 			/* there is at least 20 bytes left in the pack */
diff --git a/cache.h b/cache.h
index 9f8e655..5396d33 100644
--- a/cache.h
+++ b/cache.h
@@ -371,10 +371,11 @@ struct pack_window {
 extern struct packed_git {
 	struct packed_git *next;
 	struct pack_window *windows;
-	uint32_t *index_base;
-	time_t mtime;
+	const void *index_data;
 	off_t index_size;
 	off_t pack_size;
+	time_t mtime;
+	int index_version;
 	int pack_fd;
 	int pack_local;
 	unsigned char sha1[20];
@@ -412,7 +413,7 @@ extern int server_supports(const char *feature);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1);
 extern struct packed_git *parse_pack_index_file(const unsigned char *sha1,
-						char *idx_path);
+						const char *idx_path);
 
 extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
@@ -424,7 +425,7 @@ extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 extern void pack_report(void);
 extern unsigned char* use_pack(struct packed_git *, struct pack_window **, off_t, unsigned int *);
 extern void unuse_pack(struct pack_window **);
-extern struct packed_git *add_packed_git(char *, int, int);
+extern struct packed_git *add_packed_git(const char *, int, int);
 extern uint32_t num_packed_objects(const struct packed_git *p);
 extern int nth_packed_object_sha1(const struct packed_git *, uint32_t, unsigned char*);
 extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
diff --git a/pack-check.c b/pack-check.c
index 299c514..d988322 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -5,7 +5,7 @@ static int verify_packfile(struct packed_git *p,
 		struct pack_window **w_curs)
 {
 	off_t index_size = p->index_size;
-	void *index_base = p->index_base;
+	const unsigned char *index_base = p->index_data;
 	SHA_CTX ctx;
 	unsigned char sha1[20];
 	off_t offset = 0, pack_sig = p->pack_size - 20;
@@ -31,7 +31,7 @@ static int verify_packfile(struct packed_git *p,
 	if (hashcmp(sha1, use_pack(p, w_curs, pack_sig, NULL)))
 		return error("Packfile %s SHA1 mismatch with itself",
 			     p->pack_name);
-	if (hashcmp(sha1, (unsigned char *)index_base + index_size - 40))
+	if (hashcmp(sha1, index_base + index_size - 40))
 		return error("Packfile %s SHA1 mismatch with idx",
 			     p->pack_name);
 	unuse_pack(w_curs);
@@ -127,7 +127,7 @@ static void show_pack_info(struct packed_git *p)
 int verify_pack(struct packed_git *p, int verbose)
 {
 	off_t index_size = p->index_size;
-	void *index_base = p->index_base;
+	const unsigned char *index_base = p->index_data;
 	SHA_CTX ctx;
 	unsigned char sha1[20];
 	int ret;
@@ -137,7 +137,7 @@ int verify_pack(struct packed_git *p, int verbose)
 	SHA1_Init(&ctx);
 	SHA1_Update(&ctx, index_base, (unsigned int)(index_size - 20));
 	SHA1_Final(sha1, &ctx);
-	if (hashcmp(sha1, (unsigned char *)index_base + index_size - 20))
+	if (hashcmp(sha1, index_base + index_size - 20))
 		ret = error("Packfile index for %s SHA1 mismatch",
 			    p->pack_name);
 
diff --git a/pack-redundant.c b/pack-redundant.c
index c8f7d9a..40e579b 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -17,7 +17,7 @@ static int load_all_packs, verbose, alt_odb;
 
 struct llist_item {
 	struct llist_item *next;
-	unsigned char *sha1;
+	const unsigned char *sha1;
 };
 static struct llist {
 	struct llist_item *front;
@@ -104,9 +104,9 @@ static struct llist * llist_copy(struct llist *list)
 	return ret;
 }
 
-static inline struct llist_item * llist_insert(struct llist *list,
-					       struct llist_item *after,
-					       unsigned char *sha1)
+static inline struct llist_item *llist_insert(struct llist *list,
+					      struct llist_item *after,
+					       const unsigned char *sha1)
 {
 	struct llist_item *new = llist_item_get();
 	new->sha1 = sha1;
@@ -128,12 +128,14 @@ static inline struct llist_item * llist_insert(struct llist *list,
 	return new;
 }
 
-static inline struct llist_item *llist_insert_back(struct llist *list, unsigned char *sha1)
+static inline struct llist_item *llist_insert_back(struct llist *list,
+						   const unsigned char *sha1)
 {
 	return llist_insert(list, list->back, sha1);
 }
 
-static inline struct llist_item *llist_insert_sorted_unique(struct llist *list, unsigned char *sha1, struct llist_item *hint)
+static inline struct llist_item *llist_insert_sorted_unique(struct llist *list,
+			const unsigned char *sha1, struct llist_item *hint)
 {
 	struct llist_item *prev = NULL, *l;
 
@@ -246,12 +248,12 @@ static struct pack_list * pack_list_difference(const struct pack_list *A,
 static void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
 {
 	int p1_off, p2_off;
-	unsigned char *p1_base, *p2_base;
+	const unsigned char *p1_base, *p2_base;
 	struct llist_item *p1_hint = NULL, *p2_hint = NULL;
 
 	p1_off = p2_off = 256 * 4 + 4;
-	p1_base = (unsigned char *) p1->pack->index_base;
-	p2_base = (unsigned char *) p2->pack->index_base;
+	p1_base = p1->pack->index_data;
+	p2_base = p2->pack->index_data;
 
 	while (p1_off <= p1->pack->index_size - 3 * 20 &&
 	       p2_off <= p2->pack->index_size - 3 * 20)
@@ -351,11 +353,11 @@ static size_t sizeof_union(struct packed_git *p1, struct packed_git *p2)
 {
 	size_t ret = 0;
 	int p1_off, p2_off;
-	unsigned char *p1_base, *p2_base;
+	const unsigned char *p1_base, *p2_base;
 
 	p1_off = p2_off = 256 * 4 + 4;
-	p1_base = (unsigned char *)p1->index_base;
-	p2_base = (unsigned char *)p2->index_base;
+	p1_base = p1->index_data;
+	p2_base = p2->index_data;
 
 	while (p1_off <= p1->index_size - 3 * 20 &&
 	       p2_off <= p2->index_size - 3 * 20)
@@ -534,7 +536,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 {
 	struct pack_list l;
 	size_t off;
-	unsigned char *base;
+	const unsigned char *base;
 
 	if (!p->pack_local && !(alt_odb || verbose))
 		return NULL;
@@ -543,7 +545,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 	llist_init(&l.all_objects);
 
 	off = 256 * 4 + 4;
-	base = (unsigned char *)p->index_base;
+	base = p->index_data;
 	while (off <= p->index_size - 3 * 20) {
 		llist_insert_back(l.all_objects, base + off);
 		off += 24;
diff --git a/pack.h b/pack.h
index deb427e..d4d412c 100644
--- a/pack.h
+++ b/pack.h
@@ -16,24 +16,15 @@ struct pack_header {
 };
 
 /*
- * Packed object index header
- *
- * struct pack_idx_header {
- * 	uint32_t idx_signature;
- *	uint32_t idx_version;
- * };
- *
- * Note: this header isn't active yet.  In future versions of git
- * we may change the index file format.  At that time we would start
- * the first four bytes of the new index format with this signature,
- * as all older git binaries would find this value illegal and abort
- * reading the file.
+ * The first four bytes of index formats later than version 1 should
+ * start with this signature, as all older git binaries would find this
+ * value illegal and abort reading the file.
  *
  * This is the case because the number of objects in a packfile
  * cannot exceed 1,431,660,000 as every object would need at least
- * 3 bytes of data and the overall packfile cannot exceed 4 GiB due
- * to the 32 bit offsets used by the index.  Clearly the signature
- * exceeds this maximum.
+ * 3 bytes of data and the overall packfile cannot exceed 4 GiB with
+ * version 1 of the index file due to the offsets limited to 32 bits.
+ * Clearly the signature exceeds this maximum.
  *
  * Very old git binaries will also compare the first 4 bytes to the
  * next 4 bytes in the index and abort with a "non-monotonic index"
@@ -43,6 +34,15 @@ struct pack_header {
  */
 #define PACK_IDX_SIGNATURE 0xff744f63	/* "\377tOc" */
 
+/*
+ * Packed object index header
+ */
+struct pack_idx_header {
+	uint32_t idx_signature;
+	uint32_t idx_version;
+};
+
+
 extern int verify_pack(struct packed_git *, int);
 
 #define PH_ERROR_EOF		(-1)
diff --git a/sha1_file.c b/sha1_file.c
index 5691448..110d696 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -432,16 +432,15 @@ void pack_report()
 		pack_mapped, peak_pack_mapped);
 }
 
-static int check_packed_git_idx(const char *path,
-	unsigned long *idx_size_,
-	void **idx_map_)
+static int check_packed_git_idx(const char *path,  struct packed_git *p)
 {
 	void *idx_map;
-	uint32_t *index;
+	struct pack_idx_header *hdr;
 	size_t idx_size;
-	uint32_t nr, i;
+	uint32_t nr, i, *index;
 	int fd = open(path, O_RDONLY);
 	struct stat st;
+
 	if (fd < 0)
 		return -1;
 	if (fstat(fd, &st)) {
@@ -456,15 +455,12 @@ static int check_packed_git_idx(const char *path,
 	idx_map = xmmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 
-	index = idx_map;
-	*idx_map_ = idx_map;
-	*idx_size_ = idx_size;
-
 	/* a future index format would start with this, as older git
 	 * binaries would fail the non-monotonic index check below.
 	 * give a nicer warning to the user if we can.
 	 */
-	if (index[0] == htonl(PACK_IDX_SIGNATURE)) {
+	hdr = idx_map;
+	if (hdr->idx_signature == htonl(PACK_IDX_SIGNATURE)) {
 		munmap(idx_map, idx_size);
 		return error("index file %s is a newer version"
 			" and is not supported by this binary"
@@ -473,6 +469,7 @@ static int check_packed_git_idx(const char *path,
 	}
 
 	nr = 0;
+	index = idx_map;
 	for (i = 0; i < 256; i++) {
 		uint32_t n = ntohl(index[i]);
 		if (n < nr) {
@@ -494,6 +491,9 @@ static int check_packed_git_idx(const char *path,
 		return error("wrong index file size in %s", path);
 	}
 
+	p->index_version = 1;
+	p->index_data = idx_map;
+	p->index_size = idx_size;
 	return 0;
 }
 
@@ -614,7 +614,7 @@ static int open_packed_git_1(struct packed_git *p)
 		return error("end of packfile %s is unavailable", p->pack_name);
 	if (read_in_full(p->pack_fd, sha1, sizeof(sha1)) != sizeof(sha1))
 		return error("packfile %s signature is unavailable", p->pack_name);
-	idx_sha1 = ((unsigned char *)p->index_base) + p->index_size - 40;
+	idx_sha1 = ((unsigned char *)p->index_data) + p->index_size - 40;
 	if (hashcmp(sha1, idx_sha1))
 		return error("packfile %s does not match index", p->pack_name);
 	return 0;
@@ -710,38 +710,37 @@ unsigned char* use_pack(struct packed_git *p,
 	return win->base + offset;
 }
 
-struct packed_git *add_packed_git(char *path, int path_len, int local)
+struct packed_git *add_packed_git(const char *path, int path_len, int local)
 {
 	struct stat st;
-	struct packed_git *p;
-	unsigned long idx_size;
-	void *idx_map;
-	unsigned char sha1[20];
+	struct packed_git *p = xmalloc(sizeof(*p) + path_len + 2);
 
-	if (check_packed_git_idx(path, &idx_size, &idx_map))
+	/*
+	 * Make sure a corresponding .pack file exists and that
+	 * the index looks sane.
+	 */
+	path_len -= strlen(".idx");
+	if (path_len < 1)
 		return NULL;
-
-	/* do we have a corresponding .pack file? */
-	strcpy(path + path_len - 4, ".pack");
-	if (stat(path, &st) || !S_ISREG(st.st_mode)) {
-		munmap(idx_map, idx_size);
+	memcpy(p->pack_name, path, path_len);
+	strcpy(p->pack_name + path_len, ".pack");
+	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode) ||
+	    check_packed_git_idx(path, p)) {
+		free(p);
 		return NULL;
 	}
+
 	/* ok, it looks sane as far as we can check without
 	 * actually mapping the pack file.
 	 */
-	p = xmalloc(sizeof(*p) + path_len + 2);
-	strcpy(p->pack_name, path);
-	p->index_size = idx_size;
 	p->pack_size = st.st_size;
-	p->index_base = idx_map;
 	p->next = NULL;
 	p->windows = NULL;
 	p->pack_fd = -1;
 	p->pack_local = local;
 	p->mtime = st.st_mtime;
-	if ((path_len > 44) && !get_sha1_hex(path + path_len - 44, sha1))
-		hashcpy(p->sha1, sha1);
+	if (path_len < 40 || get_sha1_hex(path + path_len - 40, p->sha1))
+		hashclr(p->sha1);
 	return p;
 }
 
@@ -751,23 +750,19 @@ struct packed_git *parse_pack_index(unsigned char *sha1)
 	return parse_pack_index_file(sha1, path);
 }
 
-struct packed_git *parse_pack_index_file(const unsigned char *sha1, char *idx_path)
+struct packed_git *parse_pack_index_file(const unsigned char *sha1,
+					 const char *idx_path)
 {
-	struct packed_git *p;
-	unsigned long idx_size;
-	void *idx_map;
-	char *path;
+	const char *path = sha1_pack_name(sha1);
+	struct packed_git *p = xmalloc(sizeof(*p) + strlen(path) + 2);
 
-	if (check_packed_git_idx(idx_path, &idx_size, &idx_map))
+	if (check_packed_git_idx(idx_path, p)) {
+		free(p);
 		return NULL;
+	}
 
-	path = sha1_pack_name(sha1);
-
-	p = xmalloc(sizeof(*p) + strlen(path) + 2);
 	strcpy(p->pack_name, path);
-	p->index_size = idx_size;
 	p->pack_size = 0;
-	p->index_base = idx_map;
 	p->next = NULL;
 	p->windows = NULL;
 	p->pack_fd = -1;
@@ -1423,24 +1418,27 @@ uint32_t num_packed_objects(const struct packed_git *p)
 int nth_packed_object_sha1(const struct packed_git *p, uint32_t n,
 			   unsigned char* sha1)
 {
-	void *index = p->index_base + 256;
+	const unsigned char *index = p->index_data;
+	index += 4 * 256;
 	if (num_packed_objects(p) <= n)
 		return -1;
-	hashcpy(sha1, (unsigned char *) index + (24 * n) + 4);
+	hashcpy(sha1, index + 24 * n + 4);
 	return 0;
 }
 
 off_t find_pack_entry_one(const unsigned char *sha1,
 				  struct packed_git *p)
 {
-	uint32_t *level1_ofs = p->index_base;
+	const uint32_t *level1_ofs = p->index_data;
 	int hi = ntohl(level1_ofs[*sha1]);
 	int lo = ((*sha1 == 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
-	void *index = p->index_base + 256;
+	const unsigned char *index = p->index_data;
+
+	index += 4 * 256;
 
 	do {
 		int mi = (lo + hi) / 2;
-		int cmp = hashcmp((unsigned char *)index + (24 * mi) + 4, sha1);
+		int cmp = hashcmp(index + 24 * mi + 4, sha1);
 		if (!cmp)
 			return ntohl(*((uint32_t *)((char *)index + (24 * mi))));
 		if (cmp > 0)
