From: Troy Telford <ttelford.groups@gmail.com>
Subject: [PATCH] Support 64-bit indexes for pack files.
Date: Mon, 26 Feb 2007 15:40:26 -0700
Message-ID: <200702261540.27080.ttelford.groups@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 01:41:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLqPh-0004Jn-7g
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 01:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbXB0Alu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 19:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbXB0Alu
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 19:41:50 -0500
Received: from zoot.lnxi.com ([63.145.151.20]:40023 "EHLO zoot.lnxi.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750935AbXB0Als (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 19:41:48 -0500
X-Greylist: delayed 7253 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Feb 2007 19:41:48 EST
Received: from rygel.lnxi.com ([::ffff:192.168.40.106])
	by zoot.lnxi.com with ESMTP (TLS encrypted); Mon, 26 Feb 2007 15:40:29 -0700
User-Agent: KMail/1.9.6
Content-Disposition: inline
X-Length: 25306
X-UID: 290
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40680>

As I've not been involved with git development before, I'm
aware that this may already be on somebody's 'todo' list.  It was an itch
I needed to scratch, as I have a repository whose size is multiple gigabytes,
and 'git clone' (by default) forces everything into a single
packfile with >=git-1.5.0.

Since I'm an insane form of lazy, needed the C practice, and wanted to
avoid those few keystrokes needed to tweak the default push/fetch behavior,
I'm attempting to either fix git or break it in a new and interesting way.

The patch introduces a new packfile index version, which adds a:
 * header to the index file (index version info).
 * leaves the object indexes within the index at 32-bit
 * extends the offsets used to describe the packfile to 64-bit.

The new index format is only used when the associated  packfile 
becomes large enough to warrant a 64-bit index; otherwise the original
index format is used.

Operations such as git-fsck, checkouts, diffs, and branches
all appear to work properly on x86-64 architectures.  I've done
testing on both x86 and x86_64 architectures, using a git repository
with a single 5.4 GB packfile.

32-bit architectures still have issues using the 64-bit
indexes (git- fsck, pull/fetch return various errors) so it's not yet
complete.

I did have quite a bit of help from Eric Biederman, whom
I'd like to acknowledge and thank for his help.

Signed-off-by: Troy Telford <ttelford.groups@gmail.com>
---
 builtin-pack-objects.c |   50 ++++++++++++-
 cache.h                |   13 ++-
 index-pack.c           |   30 ++++++-
 pack-check.c           |    8 +-
 pack-redundant.c       |   83 +++++++++++++++------
 pack.h                 |    4 +
 sha1_file.c            |  193 +++++++++++++++++++++++++++++++++++-------------
 show-index.c           |   81 +++++++++++++++-----
 8 files changed, 349 insertions(+), 113 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index b5ed9ce..92087c1 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -101,7 +101,7 @@ static int object_ix_hashsz;
  * get the object sha1 from the main index.
  */
 struct revindex_entry {
-	unsigned int offset;
+	off_t offset;
 	unsigned int nr;
 };
 struct pack_revindex {
@@ -163,12 +163,12 @@ static int cmp_offset(const void *a_, const void *b_)
 /*
  * Ordered list of offsets of objects in the pack.
  */
-static void prepare_pack_revindex(struct pack_revindex *rix)
+static void prepare_pack_revindex_v0(struct pack_revindex *rix)
 {
 	struct packed_git *p = rix->p;
 	int num_ent = num_packed_objects(p);
 	int i;
-	void *index = p->index_base + 256;
+	void *index = p->index.base + 256;
 
 	rix->revindex = xmalloc(sizeof(*rix->revindex) * (num_ent + 1));
 	for (i = 0; i < num_ent; i++) {
@@ -184,6 +184,43 @@ static void prepare_pack_revindex(struct pack_revindex *rix)
 	qsort(rix->revindex, num_ent, sizeof(*rix->revindex), cmp_offset);
 }
 
+static void prepare_pack_revindex_v1(struct pack_revindex *rix)
+{
+	struct packed_git *p = rix->p;
+	int num_ent = num_packed_objects(p);
+	int i;
+	uint32_t *index = p->index.base + 256 + 2;
+
+	rix->revindex = xmalloc(sizeof(*rix->revindex) * (num_ent + 1));
+	for (i = 0; i < num_ent; i++) {
+		off_t offset;
+		offset = ntohl(*(index + (7 * i)));
+		offset <<=32;
+		offset |= ntohl(*(index + ((7 * i) + 1)));
+		rix->revindex[i].offset = offset;
+		rix->revindex[i].nr = i;
+	}
+	/* This knows the pack format -- the 20-byte trailer
+	 * follows immediately after the last object data.
+	 */
+	rix->revindex[num_ent].offset = p->pack_size - 20;
+	rix->revindex[num_ent].nr = -1;
+	qsort(rix->revindex, num_ent, sizeof(*rix->revindex), cmp_offset);
+}
+static void prepare_pack_revindex(struct pack_revindex *rix)
+{
+	switch (rix->p->index.version)
+	{
+	case 0:
+		return prepare_pack_revindex_v0(rix);
+	case 1:
+		return prepare_pack_revindex_v1(rix);
+	default:
+		die("Unsupported Pack Version");
+
+	}
+}
+
 static struct revindex_entry * find_packed_object(struct packed_git *p,
 						  unsigned int ofs)
 {
@@ -224,7 +261,12 @@ static unsigned char *find_packed_object_name(struct packed_git *p,
 					      unsigned long ofs)
 {
 	struct revindex_entry *entry = find_packed_object(p, ofs);
-	return (unsigned char *)(p->index_base + 256) + 24 * entry->nr + 4;
+	if (p->index.version == 0)
+		return (unsigned char *)(p->index.base + 256) + 24 * entry->nr + 4;
+	else if (p->index.version == 1)
+		return (unsigned char *)(p->index.base + 256 + 2) + 28 * entry->nr + 8;
+	else
+		die("Unsupported index version");
 }
 
 static void *delta_against(void *buf, unsigned long size, struct object_entry *entry)
diff --git a/cache.h b/cache.h
index 04f8e63..b329ca4 100644
--- a/cache.h
+++ b/cache.h
@@ -362,12 +362,17 @@ struct pack_window {
 	unsigned int inuse_cnt;
 };
 
+struct index_info {
+	off_t	size;
+	uint32_t *base;
+	uint32_t version;
+};
+
 extern struct packed_git {
 	struct packed_git *next;
 	struct pack_window *windows;
-	uint32_t *index_base;
-	off_t index_size;
 	off_t pack_size;
+	struct index_info index;
 	int pack_fd;
 	int pack_local;
 	unsigned char sha1[20];
@@ -376,7 +381,7 @@ extern struct packed_git {
 } *packed_git;
 
 struct pack_entry {
-	unsigned int offset;
+	off_t offset;
 	unsigned char sha1[20];
 	struct packed_git *p;
 };
@@ -420,7 +425,7 @@ extern void unuse_pack(struct pack_window **);
 extern struct packed_git *add_packed_git(char *, int, int);
 extern int num_packed_objects(const struct packed_git *p);
 extern int nth_packed_object_sha1(const struct packed_git *, int, unsigned char*);
-extern unsigned long find_pack_entry_one(const unsigned char *, struct packed_git *);
+extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
 extern void *unpack_entry(struct packed_git *, unsigned long, char *, unsigned long *);
 extern unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern void packed_object_info_detail(struct packed_git *, unsigned long, char *, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
diff --git a/index-pack.c b/index-pack.c
index fa9a0e7..cc22ea2 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -12,7 +12,7 @@ static const char index_pack_usage[] =
 
 struct object_entry
 {
-	unsigned long offset;
+	off_t offset;
 	unsigned long size;
 	unsigned int hdr_size;
 	enum object_type type;
@@ -83,7 +83,7 @@ static unsigned display_progress(unsigned n, unsigned total, unsigned last_pc)
 
 /* We always read in 4kB chunks. */
 static unsigned char input_buffer[4096];
-static unsigned long input_offset, input_len, consumed_bytes;
+static off_t input_offset, input_len, consumed_bytes;
 static SHA_CTX input_ctx;
 static int input_fd, output_fd, pack_fd;
 
@@ -707,6 +707,13 @@ static const char *write_index_file(const char *index_name, unsigned char *sha1)
 		die("unable to create %s: %s", index_name, strerror(errno));
 	f = sha1fd(fd, index_name);
 
+	if ( consumed_bytes >= 0xffffffffUL )
+	{
+		struct pack_idx_header hdr;
+		hdr.idx_signature = htonl(PACK_IDX_SIGNATURE);
+		hdr.idx_version = htonl(1);
+		sha1write(f, &hdr, sizeof(hdr));
+	}
 	/*
 	 * Write the first-level table (the list is sorted,
 	 * but we use a 256-entry lookup to be able to avoid
@@ -736,9 +743,22 @@ static const char *write_index_file(const char *index_name, unsigned char *sha1)
 	list = sorted_by_sha;
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = *list++;
-		unsigned int offset = htonl(obj->offset);
-		sha1write(f, &offset, 4);
-		sha1write(f, obj->sha1, 20);
+		if ( consumed_bytes < 0xffffffffUL )
+		{
+			unsigned int offset = htonl(obj->offset);
+			sha1write(f, &offset, 4);
+			sha1write(f, obj->sha1, 20);
+		}
+		else
+		{
+			uint32_t low;
+			uint32_t high;
+			low=htonl(obj->offset & 0xffffffff);
+			high=htonl((obj->offset >>32) & 0xffffffff);
+			sha1write(f, &high, 4);
+			sha1write(f, &low, 4);
+			sha1write(f, obj->sha1, 20);
+		}
 		SHA1_Update(&ctx, obj->sha1, 20);
 	}
 	sha1write(f, sha1, 20);
diff --git a/pack-check.c b/pack-check.c
index 08a9fd8..12ee933 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -4,8 +4,8 @@
 static int verify_packfile(struct packed_git *p,
 		struct pack_window **w_curs)
 {
-	unsigned long index_size = p->index_size;
-	void *index_base = p->index_base;
+	off_t index_size = p->index.size;
+	void *index_base = p->index.base;
 	SHA_CTX ctx;
 	unsigned char sha1[20];
 	unsigned long offset = 0, pack_sig = p->pack_size - 20;
@@ -123,8 +123,8 @@ static void show_pack_info(struct packed_git *p)
 
 int verify_pack(struct packed_git *p, int verbose)
 {
-	unsigned long index_size = p->index_size;
-	void *index_base = p->index_base;
+	off_t index_size = p->index.size;
+	void *index_base = p->index.base;
 	SHA_CTX ctx;
 	unsigned char sha1[20];
 	int ret;
diff --git a/pack-redundant.c b/pack-redundant.c
index edb5524..d327ae4 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -246,15 +246,29 @@ static struct pack_list * pack_list_difference(const struct pack_list *A,
 static void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
 {
 	int p1_off, p2_off;
+	int p1_inc, p2_inc;
 	unsigned char *p1_base, *p2_base;
 	struct llist_item *p1_hint = NULL, *p2_hint = NULL;
 
-	p1_off = p2_off = 256 * 4 + 4;
-	p1_base = (unsigned char *) p1->pack->index_base;
-	p2_base = (unsigned char *) p2->pack->index_base;
+	if (p1->pack->index.version == 0) {
+		p1_off = 256 * 4 + 4;
+		p1_inc = 24;
+	} else {
+		p1_off = 256 * 4 + 8 + 8;
+		p1_inc = 28;
+	}
+	if (p2->pack->index.version == 0) {
+		p2_off = 256 * 4 + 4;
+		p2_inc = 24;
+	} else {
+		p2_off = 256 * 4 + 8 + 8;
+		p2_inc = 28;
+	}
+	p1_base = (unsigned char *) p1->pack->index.base;
+	p2_base = (unsigned char *) p2->pack->index.base;
 
-	while (p1_off <= p1->pack->index_size - 3 * 20 &&
-	       p2_off <= p2->pack->index_size - 3 * 20)
+	while (p1_off <= p1->pack->index.size - 3 * 20 &&
+	       p2_off <= p2->pack->index.size - 3 * 20)
 	{
 		int cmp = hashcmp(p1_base + p1_off, p2_base + p2_off);
 		/* cmp ~ p1 - p2 */
@@ -263,14 +277,14 @@ static void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
 					p1_base + p1_off, p1_hint);
 			p2_hint = llist_sorted_remove(p2->unique_objects,
 					p1_base + p1_off, p2_hint);
-			p1_off+=24;
-			p2_off+=24;
+			p1_off+=p1_inc;
+			p2_off+=p2_inc;
 			continue;
 		}
 		if (cmp < 0) { /* p1 has the object, p2 doesn't */
-			p1_off+=24;
+			p1_off+=p1_inc;
 		} else { /* p2 has the object, p1 doesn't */
-			p2_off+=24;
+			p2_off+=p2_inc;
 		}
 	}
 }
@@ -351,27 +365,41 @@ static size_t sizeof_union(struct packed_git *p1, struct packed_git *p2)
 {
 	size_t ret = 0;
 	int p1_off, p2_off;
+	int p1_inc, p2_inc;
 	unsigned char *p1_base, *p2_base;
 
-	p1_off = p2_off = 256 * 4 + 4;
-	p1_base = (unsigned char *)p1->index_base;
-	p2_base = (unsigned char *)p2->index_base;
+	if (p1->index.version == 0) {
+		p1_off = 256 * 4 + 4;
+		p1_inc = 24;
+	} else {
+		p1_off = 256 * 4 + 8 + 8;
+		p1_inc = 28;
+	}
+	if (p2->index.version == 0) {
+		p2_off = 256 * 4 + 4;
+		p2_inc = 24;
+	} else {
+		p2_off = 256 * 4 + 8 + 8;
+		p2_inc = 28;
+	}
+	p1_base = (unsigned char *)p1->index.base;
+	p2_base = (unsigned char *)p2->index.base;
 
-	while (p1_off <= p1->index_size - 3 * 20 &&
-	       p2_off <= p2->index_size - 3 * 20)
+	while (p1_off <= p1->index.size - 3 * 20 &&
+	       p2_off <= p2->index.size - 3 * 20)
 	{
 		int cmp = hashcmp(p1_base + p1_off, p2_base + p2_off);
 		/* cmp ~ p1 - p2 */
 		if (cmp == 0) {
 			ret++;
-			p1_off+=24;
-			p2_off+=24;
+			p1_off+=p1_inc;
+			p2_off+=p2_inc;
 			continue;
 		}
 		if (cmp < 0) { /* p1 has the object, p2 doesn't */
-			p1_off+=24;
+			p1_off+=p1_inc;
 		} else { /* p2 has the object, p1 doesn't */
-			p2_off+=24;
+			p2_off+=p2_inc;
 		}
 	}
 	return ret;
@@ -401,7 +429,7 @@ static inline size_t pack_set_bytecount(struct pack_list *pl)
 	size_t ret = 0;
 	while (pl) {
 		ret += pl->pack->pack_size;
-		ret += pl->pack->index_size;
+		ret += pl->pack->index.size;
 		pl = pl->next;
 	}
 	return ret;
@@ -534,6 +562,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 {
 	struct pack_list l;
 	size_t off;
+	int inc;
 	unsigned char *base;
 
 	if (!p->pack_local && !(alt_odb || verbose))
@@ -541,12 +570,18 @@ static struct pack_list * add_pack(struct packed_git *p)
 
 	l.pack = p;
 	llist_init(&l.all_objects);
-
-	off = 256 * 4 + 4;
-	base = (unsigned char *)p->index_base;
-	while (off <= p->index_size - 3 * 20) {
+	if (p->index.version == 0) {
+		off = 256 * 4 + 4;
+		inc = 24;
+	}
+	if (p->index.version == 1) {
+		off = 256 * 4 + 8 + 8;
+		inc = 28;
+	}
+	base = (unsigned char *)p->index.base;
+	while (off <= p->index.size - 3 * 20) {
 		llist_insert_back(l.all_objects, base + off);
-		off += 24;
+		off += inc;
 	}
 	/* this list will be pruned in cmp_two_packs later */
 	l.unique_objects = llist_copy(l.all_objects);
diff --git a/pack.h b/pack.h
index deb427e..fbf7992 100644
--- a/pack.h
+++ b/pack.h
@@ -41,6 +41,10 @@ struct pack_header {
  * byte word.  This would be true in the proposed future index
  * format as idx_signature would be greater than idx_version.
  */
+struct pack_idx_header {
+	uint32_t idx_signature;
+	uint32_t idx_version;
+};
 #define PACK_IDX_SIGNATURE 0xff744f63	/* "\377tOc" */
 
 extern int verify_pack(struct packed_git *, int);
diff --git a/sha1_file.c b/sha1_file.c
index 2c87031..c5ab5cc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -430,12 +430,9 @@ void pack_report()
 		pack_mapped, peak_pack_mapped);
 }
 
-static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
-				void **idx_map_)
+static int check_packed_git_idx(const char *path, struct index_info * idx )
 {
-	void *idx_map;
 	uint32_t *index;
-	unsigned long idx_size;
 	int nr, i;
 	int fd = open(path, O_RDONLY);
 	struct stat st;
@@ -445,46 +442,73 @@ static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
 		close(fd);
 		return -1;
 	}
-	idx_size = st.st_size;
-	idx_map = xmmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	idx->size = st.st_size;
+	idx->base = xmmap(NULL, idx->size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 
-	index = idx_map;
-	*idx_map_ = idx_map;
-	*idx_size_ = idx_size;
+	index = idx->base;
 
-	/* check index map */
-	if (idx_size < 4*256 + 20 + 20)
+	if (idx->size < 8)
 		return error("index file %s is too small", path);
-
+	if (index[0] != htonl(PACK_IDX_SIGNATURE))
+	{
+		/* check index map */
+		if (idx->size < 4*256 + 20 + 20)
+			return error("index file %s is too small", path);
+		nr = 0;
+		for (i = 0; i < 256; i++) {
+			unsigned int n = ntohl(index[i]);
+			if (n < nr)
+				return error("non-monotonic index %s", path);
+			nr = n;
+		}
+		/*
+		 * Total size:
+		 *  - 256 index entries 4 bytes each
+		 *  - 24-byte entries * nr (20-byte sha1 + 4-byte offset)
+		 *  	(on 32-bit indexes)
+		 *  - 20-byte SHA1 of the packfile
+		 *  - 20-byte SHA1 file checksum
+		 */
+		if (idx->size != 4*256 + nr * 24 + 20 + 20)
+			return error("wrong index file size in %s", path);
+		idx->version = 0;
+	}
+	else if (index[0] == htonl(PACK_IDX_SIGNATURE) && ntohl(index[1]) == 1 )
+	{
+		index += 2;
+		/* check index map */
+		if (idx->size < 8 + 4*256 + 20 + 20 )
+			return error("index file %s is too small", path);
+		nr = 0;
+		for (i = 0; i < 256; i++) {
+			unsigned int n = ntohl(index[i]);
+			if (n < nr)
+				return error("non-monotonic index %s", path);
+			nr = n;
+		}
+		/*
+		 * Total size:
+		 *  - (4+4) byte header
+		 *  - 256 index entries 4 bytes each
+		 *  - 28-byte entries * nr (20-byte sha1 + 8 byte offset)
+		 *  	(on 64-bit indexes)
+		 *  - 20-byte SHA1 of the packfile
+		 *  - 20-byte SHA1 file checksum
+		 */
+		if (idx->size != 8 + 4*256 + nr * 28 + 20 + 20)
+			return error("wrong index file size in %s", path);
+		idx->version = 1;
+	}
 	/* a future index format would start with this, as older git
 	 * binaries would fail the non-monotonic index check below.
 	 * give a nicer warning to the user if we can.
 	 */
-	if (index[0] == htonl(PACK_IDX_SIGNATURE))
+	else if (index[0] == htonl(PACK_IDX_SIGNATURE))
 		return error("index file %s is a newer version"
 			" and is not supported by this binary"
 			" (try upgrading GIT to a newer version)",
 			path);
-
-	nr = 0;
-	for (i = 0; i < 256; i++) {
-		unsigned int n = ntohl(index[i]);
-		if (n < nr)
-			return error("non-monotonic index %s", path);
-		nr = n;
-	}
-
-	/*
-	 * Total size:
-	 *  - 256 index entries 4 bytes each
-	 *  - 24-byte entries * nr (20-byte sha1 + 4-byte offset)
-	 *  - 20-byte SHA1 of the packfile
-	 *  - 20-byte SHA1 file checksum
-	 */
-	if (idx_size != 4*256 + nr * 24 + 20 + 20)
-		return error("wrong index file size in %s", path);
-
 	return 0;
 }
 
@@ -605,7 +629,7 @@ static int open_packed_git_1(struct packed_git *p)
 		return error("end of packfile %s is unavailable", p->pack_name);
 	if (read_in_full(p->pack_fd, sha1, sizeof(sha1)) != sizeof(sha1))
 		return error("packfile %s signature is unavailable", p->pack_name);
-	idx_sha1 = ((unsigned char *)p->index_base) + p->index_size - 40;
+	idx_sha1 = ((unsigned char *)p->index.base) + p->index.size - 40;
 	if (hashcmp(sha1, idx_sha1))
 		return error("packfile %s does not match index", p->pack_name);
 	return 0;
@@ -703,17 +727,16 @@ struct packed_git *add_packed_git(char *path, int path_len, int local)
 {
 	struct stat st;
 	struct packed_git *p;
-	unsigned long idx_size;
-	void *idx_map;
+	struct index_info idx;
 	unsigned char sha1[20];
 
-	if (check_packed_git_idx(path, &idx_size, &idx_map))
+	if (check_packed_git_idx(path, &idx))
 		return NULL;
 
 	/* do we have a corresponding .pack file? */
 	strcpy(path + path_len - 4, ".pack");
 	if (stat(path, &st) || !S_ISREG(st.st_mode)) {
-		munmap(idx_map, idx_size);
+		munmap(idx.base, idx.size);
 		return NULL;
 	}
 	/* ok, it looks sane as far as we can check without
@@ -721,9 +744,8 @@ struct packed_git *add_packed_git(char *path, int path_len, int local)
 	 */
 	p = xmalloc(sizeof(*p) + path_len + 2);
 	strcpy(p->pack_name, path);
-	p->index_size = idx_size;
+	p->index = idx;
 	p->pack_size = st.st_size;
-	p->index_base = idx_map;
 	p->next = NULL;
 	p->windows = NULL;
 	p->pack_fd = -1;
@@ -742,20 +764,18 @@ struct packed_git *parse_pack_index(unsigned char *sha1)
 struct packed_git *parse_pack_index_file(const unsigned char *sha1, char *idx_path)
 {
 	struct packed_git *p;
-	unsigned long idx_size;
-	void *idx_map;
+	struct index_info idx;
 	char *path;
 
-	if (check_packed_git_idx(idx_path, &idx_size, &idx_map))
+	if (check_packed_git_idx(idx_path, &idx))
 		return NULL;
 
 	path = sha1_pack_name(sha1);
 
 	p = xmalloc(sizeof(*p) + strlen(path) + 2);
 	strcpy(p->pack_name, path);
-	p->index_size = idx_size;
+	p->index = idx;
 	p->pack_size = 0;
-	p->index_base = idx_map;
 	p->next = NULL;
 	p->windows = NULL;
 	p->pack_fd = -1;
@@ -1318,7 +1338,7 @@ static void *unpack_delta_entry(struct packed_git *p,
 	return result;
 }
 
-void *unpack_entry(struct packed_git *p, unsigned long offset,
+void *unpack_entry(struct packed_git *p, off_t offset,
 			  char *type, unsigned long *sizep)
 {
 	struct pack_window *w_curs = NULL;
@@ -1350,27 +1370,56 @@ void *unpack_entry(struct packed_git *p, unsigned long offset,
 
 int num_packed_objects(const struct packed_git *p)
 {
+	int objects = 0;
 	/* See check_packed_git_idx() */
-	return (p->index_size - 20 - 20 - 4*256) / 24;
+	if (p->index.version == 0)
+		objects = (p->index.size - 20 - 20 - 4*256) / 24;
+	else if (p->index.version == 1)
+		objects = (p->index.size - 8 - 20 - 20 - 4*256) / 28;
+	return objects;
 }
 
-int nth_packed_object_sha1(const struct packed_git *p, int n,
-			   unsigned char* sha1)
+static int nth_packed_object_sha1_v0(const struct packed_git *p, int n,
+					unsigned char* sha1)
 {
-	void *index = p->index_base + 256;
+	void *index = p->index.base + 256;
 	if (n < 0 || num_packed_objects(p) <= n)
 		return -1;
 	hashcpy(sha1, (unsigned char *) index + (24 * n) + 4);
 	return 0;
 }
 
-unsigned long find_pack_entry_one(const unsigned char *sha1,
+static int nth_packed_object_sha1_v1(const struct packed_git *p, int n,
+					unsigned char* sha1)
+{
+	void *index = p->index.base + 256 + 2;
+	if (n < 0 || num_packed_objects(p) <= n)
+		return -1;
+	hashcpy(sha1, (unsigned char *) index + (28 * n) + 8);
+	return 0;
+}
+
+int nth_packed_object_sha1(const struct packed_git *p, int n,
+			   unsigned char* sha1)
+{
+	switch  (p->index.version)
+	{
+	case 0:
+		return nth_packed_object_sha1_v0(p, n, sha1);
+	case 1:
+		return nth_packed_object_sha1_v1(p, n, sha1);
+	default:
+		die("Unsupported Pack Version v%d\n", p->index.version);
+	}
+}
+
+static off_t find_pack_entry_one_v0(const unsigned char *sha1,
 				  struct packed_git *p)
 {
-	uint32_t *level1_ofs = p->index_base;
+	uint32_t *level1_ofs = p->index.base;
 	int hi = ntohl(level1_ofs[*sha1]);
 	int lo = ((*sha1 == 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
-	void *index = p->index_base + 256;
+	void *index = p->index.base + 256;
 
 	do {
 		int mi = (lo + hi) / 2;
@@ -1385,6 +1434,46 @@ unsigned long find_pack_entry_one(const unsigned char *sha1,
 	return 0;
 }
 
+static off_t find_pack_entry_one_v1(const unsigned char *sha1,
+				  struct packed_git *p)
+{
+	uint32_t *level1_ofs = p->index.base + 2;
+	int hi = ntohl(level1_ofs[*sha1]);
+	int lo = ((*sha1 == 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
+	uint32_t *index = p->index.base + 256 + 2;
+
+	do {
+		int mi = (lo + hi) / 2;
+		int cmp = hashcmp((unsigned char *)(index + (7 * mi) + 2), sha1);
+		if (!cmp){
+			off_t offset;
+			offset = ntohl(*(index + (7 * mi)));
+			offset <<=32;
+			offset |= ntohl(*(index + ((7 * mi) + 1)));
+			return  offset;
+		}
+		if (cmp > 0)
+			hi = mi;
+		else
+			lo = mi+1;
+	} while (lo < hi);
+	return 0;
+}
+
+off_t find_pack_entry_one(const unsigned char *sha1,
+				  struct packed_git *p)
+{
+	switch (p->index.version)
+	{
+	case 0:
+		return find_pack_entry_one_v0(sha1, p);
+	case 1:
+		return find_pack_entry_one_v1(sha1, p);
+	default:
+		die("Unsupported Pack Version: v%d\n", p->index.version);
+	}
+}
+
 static int matches_pack_name(struct packed_git *p, const char *ig)
 {
 	const char *last_c, *c;
diff --git a/show-index.c b/show-index.c
index a30a2de..c7ff161 100644
--- a/show-index.c
+++ b/show-index.c
@@ -1,28 +1,69 @@
 #include "cache.h"
+#include "pack.h"
+#include <stdio.h>
 
 int main(int argc, char **argv)
 {
-	int i;
-	unsigned nr;
-	unsigned int entry[6];
-	static unsigned int top_index[256];
+	struct pack_idx_header hdr;
 
-	if (fread(top_index, sizeof(top_index), 1, stdin) != 1)
-		die("unable to read index");
-	nr = 0;
-	for (i = 0; i < 256; i++) {
-		unsigned n = ntohl(top_index[i]);
-		if (n < nr)
-			die("corrupt index file");
-		nr = n;
-	}
-	for (i = 0; i < nr; i++) {
-		unsigned offset;
+	if (fread(&hdr, sizeof(hdr), 1, stdin) != 1)
+		die("unable to read header");
+	if (PACK_IDX_SIGNATURE != ntohl(hdr.idx_signature))
+	{
+		int i;
+		unsigned nr;
+		unsigned int entry[6];
+		static unsigned int top_index[256];
+		top_index[0] = hdr.idx_signature;
+		top_index[1] = hdr.idx_version;
+		if (fread(top_index+2, sizeof(top_index) - sizeof(top_index[0])*2, 1, stdin) != 1)
+			die("unable to read index");
+		nr = 0;
+		for (i = 0; i < 256; i++) {
+			unsigned n = ntohl(top_index[i]);
+			if (n < nr)
+				die("corrupt index file");
+			nr = n;
+		}
+		for (i = 0; i < nr; i++) {
+			unsigned offset;
 
-		if (fread(entry, 24, 1, stdin) != 1)
-			die("unable to read entry %u/%u", i, nr);
-		offset = ntohl(entry[0]);
-		printf("%u %s\n", offset, sha1_to_hex((void *)(entry+1)));
+			if (fread(entry, 24, 1, stdin) != 1)
+				die("unable to read entry %u/%u", i, nr);
+			offset = ntohl(entry[0]);
+			printf("%u %s\n", offset, sha1_to_hex((void *)(entry+1)));
+		}
+		return 0;
+	}
+	else if (1 == ntohl(hdr.idx_version))
+	{
+		unsigned int nr;
+		unsigned int i;
+		unsigned int entry[7];
+		uint32_t top_index[256];
+		if (fread(top_index, sizeof(top_index), 1, stdin) != 1)
+			die("unable to read index");
+		nr = 0;
+		for (i = 0; i < 256; i++) {
+			unsigned int n;
+			n = ntohl(top_index[i]);
+			if (n < nr)
+				die("corrupt version 1 index file");
+			nr = n;
+		}
+		for (i = 0; i < nr; i++) {
+			off_t offset;
+			if (fread(entry, 28, 1, stdin) != 1)
+				die("unable to read entry %u/%u", i, nr);
+			offset = ntohl(entry[0]);
+			offset <<= 32;
+			offset |= ntohl (entry[1]);
+			printf("%llu %s\n", (unsigned long long) offset,
+				sha1_to_hex((void *)(entry+2)));
+		}
+		return 0;
 	}
-	return 0;
+	else
+		die("Unsupported header version %d.",
+			hdr.idx_version);
 }
-- 
1.5.0.1
