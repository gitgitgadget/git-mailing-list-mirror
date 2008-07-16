From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/5] clean up pack index handling a bit
Date: Wed, 16 Jul 2008 02:31:35 -0400
Message-ID: <1216189899-14279-2-git-send-email-nico@cam.org>
References: <1216189899-14279-1-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 08:32:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ0Z6-0006PH-6M
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 08:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbYGPGbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 02:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752625AbYGPGbn
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 02:31:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11931 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbYGPGbl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 02:31:41 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K43006BG64RTN50@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 16 Jul 2008 02:31:40 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.3.499.geae9
In-reply-to: <1216189899-14279-1-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88640>

Especially with the new index format to come, it is more appropriate
to encapsulate more into check_packed_git_idx() and assume less of the
index format in struct packed_git.

To that effect, the index_base is renamed to index_data with void * type
so it is not used directly but other pointers initialized with it. This
allows for a couple pointer cast removal, as well as providing a better
generic name to grep for when adding support for new index versions or
formats.

And index_data is declared const too while at it.

(based on commit 4287307833a7c67b09973fc1023311e473f830b2)

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   14 ++++---
 cache.h                |    5 ++-
 pack-check.c           |    8 ++--
 pack-redundant.c       |   30 ++++++++-------
 pack.h                 |   28 ++++++++++++++
 sha1_file.c            |   94 ++++++++++++++++++++++++++----------------------
 6 files changed, 110 insertions(+), 69 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 69e5dd3..ae051f9 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -170,11 +170,12 @@ static void prepare_pack_revindex(struct pack_revindex *rix)
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
@@ -222,11 +223,11 @@ static unsigned long find_packed_object_size(struct packed_git *p,
 	return entry[1].offset - ofs;
 }
 
-static unsigned char *find_packed_object_name(struct packed_git *p,
-					      unsigned long ofs)
+static const unsigned char *find_packed_object_name(struct packed_git *p,
+						    unsigned long ofs)
 {
 	struct revindex_entry *entry = find_packed_object(p, ofs);
-	return (unsigned char *)(p->index_base + 256) + 24 * entry->nr + 4;
+	return ((unsigned char *)p->index_data) + 4 * 256 + 24 * entry->nr + 4;
 }
 
 static void *delta_against(void *buf, unsigned long size, struct object_entry *entry)
@@ -959,7 +960,8 @@ static void check_object(struct object_entry *entry)
 		 * delta.
 		 */
 		if (!no_reuse_delta) {
-			unsigned char c, *base_name;
+			unsigned char c;
+			const unsigned char *base_name;
 			unsigned long ofs;
 			/* there is at least 20 bytes left in the pack */
 			switch (entry->in_pack_type) {
diff --git a/cache.h b/cache.h
index a0e9727..cc8e84e 100644
--- a/cache.h
+++ b/cache.h
@@ -334,8 +334,9 @@ extern struct packed_git {
 	struct packed_git *next;
 	unsigned long index_size;
 	unsigned long pack_size;
-	unsigned int *index_base;
+	const void *index_data;
 	void *pack_base;
+	int index_version;
 	unsigned int pack_last_used;
 	unsigned int pack_use_cnt;
 	int pack_local;
@@ -374,7 +375,7 @@ extern int server_supports(const char *feature);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1);
 extern struct packed_git *parse_pack_index_file(const unsigned char *sha1,
-						char *idx_path);
+						const char *idx_path);
 
 extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
diff --git a/pack-check.c b/pack-check.c
index 8e123b7..7db44e9 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -6,7 +6,7 @@
 static int verify_packfile(struct packed_git *p)
 {
 	unsigned long index_size = p->index_size;
-	void *index_base = p->index_base;
+	const unsigned char *index_base = p->index_data;
 	SHA_CTX ctx;
 	unsigned char sha1[20];
 	struct pack_header *hdr;
@@ -42,7 +42,7 @@ static int verify_packfile(struct packed_git *p)
 	if (hashcmp(sha1, (unsigned char *)(p->pack_base) + p->pack_size - 20))
 		return error("Packfile %s SHA1 mismatch with itself",
 			     p->pack_name);
-	if (hashcmp(sha1, (unsigned char *)index_base + index_size - 40))
+	if (hashcmp(sha1, index_base + index_size - 40))
 		return error("Packfile %s SHA1 mismatch with idx",
 			     p->pack_name);
 
@@ -136,7 +136,7 @@ static void show_pack_info(struct packed_git *p)
 int verify_pack(struct packed_git *p, int verbose)
 {
 	unsigned long index_size = p->index_size;
-	void *index_base = p->index_base;
+	const unsigned char *index_base = p->index_data;
 	SHA_CTX ctx;
 	unsigned char sha1[20];
 	int ret;
@@ -146,7 +146,7 @@ int verify_pack(struct packed_git *p, int verbose)
 	SHA1_Init(&ctx);
 	SHA1_Update(&ctx, index_base, index_size - 20);
 	SHA1_Final(sha1, &ctx);
-	if (hashcmp(sha1, (unsigned char *)index_base + index_size - 20))
+	if (hashcmp(sha1, index_base + index_size - 20))
 		ret = error("Packfile index for %s SHA1 mismatch",
 			    p->pack_name);
 
diff --git a/pack-redundant.c b/pack-redundant.c
index edb5524..83812f3 100644
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
index 4814800..e0051fd 100644
--- a/pack.h
+++ b/pack.h
@@ -15,5 +15,33 @@ struct pack_header {
 	unsigned int hdr_entries;
 };
 
+/*
+ * The first four bytes of index formats later than version 1 should
+ * start with this signature, as all older git binaries would find this
+ * value illegal and abort reading the file.
+ *
+ * This is the case because the number of objects in a packfile
+ * cannot exceed 1,431,660,000 as every object would need at least
+ * 3 bytes of data and the overall packfile cannot exceed 4 GiB with
+ * version 1 of the index file due to the offsets limited to 32 bits.
+ * Clearly the signature exceeds this maximum.
+ *
+ * Very old git binaries will also compare the first 4 bytes to the
+ * next 4 bytes in the index and abort with a "non-monotonic index"
+ * error if the second 4 byte word is smaller than the first 4
+ * byte word.  This would be true in the proposed future index
+ * format as idx_signature would be greater than idx_version.
+ */
+#define PACK_IDX_SIGNATURE 0xff744f63	/* "\377tOc" */
+
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
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 09456d2..df31462 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -402,15 +402,15 @@ static int pack_used_ctr;
 static unsigned long pack_mapped;
 struct packed_git *packed_git;
 
-static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
-				void **idx_map_)
+static int check_packed_git_idx(const char *path,  struct packed_git *p)
 {
 	void *idx_map;
-	unsigned int *index;
+	struct pack_idx_header *hdr;
 	unsigned long idx_size;
-	int nr, i;
+	unsigned int nr, i, *index;
 	int fd = open(path, O_RDONLY);
 	struct stat st;
+
 	if (fd < 0)
 		return -1;
 	if (fstat(fd, &st)) {
@@ -423,14 +423,21 @@ static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
 	if (idx_map == MAP_FAILED)
 		return -1;
 
-	index = idx_map;
-	*idx_map_ = idx_map;
-	*idx_size_ = idx_size;
+	/* a future index format would start with this, as older git
+	 * binaries would fail the non-monotonic index check below.
+	 * give a nicer warning to the user if we can.
+	 */
+	hdr = idx_map;
+	if (hdr->idx_signature == htonl(PACK_IDX_SIGNATURE)) {
+		munmap(idx_map, idx_size);
+		return error("index file %s is a newer version"
+			" and is not supported by this binary"
+			" (try upgrading GIT to a newer version)",
+			path);
+	}
 
-	/* check index map */
-	if (idx_size < 4*256 + 20 + 20)
-		return error("index file too small");
 	nr = 0;
+	index = idx_map;
 	for (i = 0; i < 256; i++) {
 		unsigned int n = ntohl(index[i]);
 		if (n < nr)
@@ -448,6 +455,9 @@ static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
 	if (idx_size != 4*256 + nr * 24 + 20 + 20)
 		return error("wrong index file size");
 
+	p->index_version = 1;
+	p->index_data = idx_map;
+	p->index_size = idx_size;
 	return 0;
 }
 
@@ -521,7 +531,7 @@ int use_packed_git(struct packed_git *p)
 		/* Check if the pack file matches with the index file.
 		 * this is cheap.
 		 */
-		if (hashcmp((unsigned char *)(p->index_base) +
+		if (hashcmp((unsigned char *)(p->index_data) +
 			    p->index_size - 40,
 			    (unsigned char *)p->pack_base +
 			    p->pack_size - 20)) {
@@ -536,35 +546,34 @@ int use_packed_git(struct packed_git *p)
 struct packed_git *add_packed_git(char *path, int path_len, int local)
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
 	p->pack_base = NULL;
 	p->pack_last_used = 0;
 	p->pack_use_cnt = 0;
 	p->pack_local = local;
-	if ((path_len > 44) && !get_sha1_hex(path + path_len - 44, sha1))
-		hashcpy(p->sha1, sha1);
+	if (path_len < 40 || get_sha1_hex(path + path_len - 40, p->sha1))
+		hashclr(p->sha1);
 	return p;
 }
 
@@ -574,23 +583,19 @@ struct packed_git *parse_pack_index(unsigned char *sha1)
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
 	p->pack_base = NULL;
 	p->pack_last_used = 0;
@@ -1175,24 +1180,27 @@ int num_packed_objects(const struct packed_git *p)
 int nth_packed_object_sha1(const struct packed_git *p, int n,
 			   unsigned char* sha1)
 {
-	void *index = p->index_base + 256;
+	const unsigned char *index = p->index_data;
+	index += 4 * 256;
 	if (n < 0 || num_packed_objects(p) <= n)
 		return -1;
-	hashcpy(sha1, (unsigned char *) index + (24 * n) + 4);
+	hashcpy(sha1, index + 24 * n + 4);
 	return 0;
 }
 
 unsigned long find_pack_entry_one(const unsigned char *sha1,
 				  struct packed_git *p)
 {
-	unsigned int *level1_ofs = p->index_base;
+	const unsigned int *level1_ofs = p->index_data;
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
 			return ntohl(*((unsigned int *) ((char *) index + (24 * mi))));
 		if (cmp > 0)
-- 
1.5.6.3.499.geae9
