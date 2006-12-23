From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/17] Refactor packed_git to prepare for sliding mmap windows.
Date: Sat, 23 Dec 2006 02:33:44 -0500
Message-ID: <20061223073344.GD9837@spearce.org>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 08:33:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy1OB-0001nx-Tb
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 08:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbWLWHds (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 02:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbWLWHds
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 02:33:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38745 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbWLWHdr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 02:33:47 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy1Nh-00036R-Fv; Sat, 23 Dec 2006 02:33:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1378B20FB65; Sat, 23 Dec 2006 02:33:44 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35283>

The idea behind the sliding mmap window pack reader implementation
is to have multiple mmap regions active against the same pack file,
thereby allowing the process to mmap in only the active/hot sections
of the pack and reduce overall virtual address space usage.

To implement this we need to refactor the mmap related data
(pack_base, pack_use_cnt) out of struct packed_git and move them
into a new struct pack_window.

We are refactoring the code to support a single struct pack_window
per packfile, thereby emulating the prior behavior of mmap'ing the
entire pack file.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-pack-objects.c |    4 +-
 cache.h                |   13 +++++++++--
 pack-check.c           |    6 ++--
 sha1_file.c            |   53 ++++++++++++++++++++++-------------------------
 4 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 9e15beb..4a00a12 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -438,7 +438,7 @@ static unsigned long write_object(struct sha1file *f,
 		}
 
 		use_packed_git(p);
-		buf = (char *) p->pack_base
+		buf = p->windows->base
 			+ entry->in_pack_offset
 			+ entry->in_pack_header_size;
 		datalen = find_packed_object_size(p, entry->in_pack_offset)
@@ -943,7 +943,7 @@ static void check_object(struct object_entry *entry)
 		struct object_entry *base_entry = NULL;
 
 		use_packed_git(p);
-		buf = p->pack_base;
+		buf = p->windows->base;
 		buf += entry->in_pack_offset;
 
 		/* We want in_pack_type even if we do not reuse delta.
diff --git a/cache.h b/cache.h
index ad94c3f..bf1d776 100644
--- a/cache.h
+++ b/cache.h
@@ -336,14 +336,21 @@ extern struct alternate_object_database {
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
 
+struct pack_window {
+	struct pack_window *next;
+	unsigned char *base;
+	off_t offset;
+	size_t len;
+	unsigned int last_used;
+	unsigned int inuse_cnt;
+};
+
 extern struct packed_git {
 	struct packed_git *next;
 	unsigned long index_size;
 	unsigned long pack_size;
+	struct pack_window *windows;
 	unsigned int *index_base;
-	void *pack_base;
-	unsigned int pack_last_used;
-	unsigned int pack_use_cnt;
 	int pack_local;
 	unsigned char sha1[20];
 	/* something like ".git/objects/pack/xxxxx.pack" */
diff --git a/pack-check.c b/pack-check.c
index 491bad2..761cc85 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -13,7 +13,8 @@ static int verify_packfile(struct packed_git *p)
 	int nr_objects, err, i;
 
 	/* Header consistency check */
-	hdr = p->pack_base;
+	pack_base = p->windows->base;
+	hdr = (struct pack_header*)pack_base;
 	if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
 		return error("Packfile %s signature mismatch", p->pack_name);
 	if (!pack_version_ok(hdr->hdr_version))
@@ -26,7 +27,6 @@ static int verify_packfile(struct packed_git *p)
 			     num_packed_objects(p));
 
 	SHA1_Init(&ctx);
-	pack_base = p->pack_base;
 	SHA1_Update(&ctx, pack_base, pack_size - 20);
 	SHA1_Final(sha1, &ctx);
 	if (hashcmp(sha1, (unsigned char *)pack_base + pack_size - 20))
@@ -78,7 +78,7 @@ static void show_pack_info(struct packed_git *p)
 	int nr_objects, i;
 	unsigned int chain_histogram[MAX_CHAIN];
 
-	hdr = p->pack_base;
+	hdr = (struct pack_header*)p->windows->base;
 	nr_objects = ntohl(hdr->hdr_entries);
 	memset(chain_histogram, 0, sizeof(chain_histogram));
 
diff --git a/sha1_file.c b/sha1_file.c
index 4183f59..8377874 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -455,21 +455,23 @@ static int unuse_one_packed_git(void)
 	struct packed_git *p, *lru = NULL;
 
 	for (p = packed_git; p; p = p->next) {
-		if (p->pack_use_cnt || !p->pack_base)
+		if (!p->windows || p->windows->inuse_cnt)
 			continue;
-		if (!lru || p->pack_last_used < lru->pack_last_used)
+		if (!lru || p->windows->last_used < lru->windows->last_used)
 			lru = p;
 	}
 	if (!lru)
 		return 0;
-	munmap(lru->pack_base, lru->pack_size);
-	lru->pack_base = NULL;
+	munmap(lru->windows->base, lru->windows->len);
+	free(lru->windows);
+	lru->windows = NULL;
 	return 1;
 }
 
 void unuse_packed_git(struct packed_git *p)
 {
-	p->pack_use_cnt--;
+	if (p->windows)
+		p->windows->inuse_cnt--;
 }
 
 int use_packed_git(struct packed_git *p)
@@ -482,10 +484,10 @@ int use_packed_git(struct packed_git *p)
 			die("packfile %s not a regular file", p->pack_name);
 		p->pack_size = st.st_size;
 	}
-	if (!p->pack_base) {
+	if (!p->windows) {
 		int fd;
 		struct stat st;
-		void *map;
+		struct pack_window *win;
 		struct pack_header *hdr;
 
 		pack_mapped += p->pack_size;
@@ -500,16 +502,18 @@ int use_packed_git(struct packed_git *p)
 		}
 		if (st.st_size != p->pack_size)
 			die("packfile %s size mismatch.", p->pack_name);
-		map = mmap(NULL, p->pack_size, PROT_READ, MAP_PRIVATE, fd, 0);
+		win = xcalloc(1, sizeof(*win));
+		win->len = p->pack_size;
+		win->base = mmap(NULL, p->pack_size, PROT_READ, MAP_PRIVATE, fd, 0);
 		close(fd);
-		if (map == MAP_FAILED)
+		if (win->base == MAP_FAILED)
 			die("packfile %s cannot be mapped.", p->pack_name);
-		p->pack_base = map;
+		p->windows = win;
 
 		/* Check if we understand this pack file.  If we don't we're
 		 * likely too old to handle it.
 		 */
-		hdr = map;
+		hdr = (struct pack_header*)win->base;
 		if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
 			die("packfile %s isn't actually a pack.", p->pack_name);
 		if (!pack_version_ok(hdr->hdr_version))
@@ -522,13 +526,13 @@ int use_packed_git(struct packed_git *p)
 		 */
 		if (hashcmp((unsigned char *)(p->index_base) +
 			    p->index_size - 40,
-			    (unsigned char *)p->pack_base +
+			    p->windows->base +
 			    p->pack_size - 20)) {
 			die("packfile %s does not match index.", p->pack_name);
 		}
 	}
-	p->pack_last_used = pack_used_ctr++;
-	p->pack_use_cnt++;
+	p->windows->last_used = pack_used_ctr++;
+	p->windows->inuse_cnt++;
 	return 0;
 }
 
@@ -557,10 +561,7 @@ struct packed_git *add_packed_git(char *path, int path_len, int local)
 	p->index_size = idx_size;
 	p->pack_size = st.st_size;
 	p->index_base = idx_map;
-	p->next = NULL;
-	p->pack_base = NULL;
-	p->pack_last_used = 0;
-	p->pack_use_cnt = 0;
+	p->windows = NULL;
 	p->pack_local = local;
 	if ((path_len > 44) && !get_sha1_hex(path + path_len - 44, sha1))
 		hashcpy(p->sha1, sha1);
@@ -590,10 +591,7 @@ struct packed_git *parse_pack_index_file(const unsigned char *sha1, char *idx_pa
 	p->index_size = idx_size;
 	p->pack_size = 0;
 	p->index_base = idx_map;
-	p->next = NULL;
-	p->pack_base = NULL;
-	p->pack_last_used = 0;
-	p->pack_use_cnt = 0;
+	p->windows = NULL;
 	hashcpy(p->sha1, sha1);
 	return p;
 }
@@ -882,7 +880,7 @@ static unsigned long get_delta_base(struct packed_git *p,
 				    unsigned long delta_obj_offset,
 				    unsigned long *base_obj_offset)
 {
-	unsigned char *base_info = (unsigned char *) p->pack_base + offset;
+	unsigned char *base_info = p->windows->base + offset;
 	unsigned long base_offset;
 
 	/* there must be at least 20 bytes left regardless of delta type */
@@ -949,7 +947,7 @@ static int packed_delta_info(struct packed_git *p,
 
 		memset(&stream, 0, sizeof(stream));
 
-		stream.next_in = (unsigned char *) p->pack_base + offset;
+		stream.next_in = p->windows->base + offset;
 		stream.avail_in = p->pack_size - offset;
 		stream.next_out = delta_head;
 		stream.avail_out = sizeof(delta_head);
@@ -984,8 +982,7 @@ static unsigned long unpack_object_header(struct packed_git *p, unsigned long of
 	if (p->pack_size <= offset)
 		die("object offset outside of pack file");
 
-	used = unpack_object_header_gently((unsigned char *)p->pack_base +
-					   offset,
+	used = unpack_object_header_gently(p->windows->base + offset,
 					   p->pack_size - offset, type, sizep);
 	if (!used)
 		die("object offset outside of pack file");
@@ -1031,7 +1028,7 @@ void packed_object_info_detail(struct packed_git *p,
 			if (p->pack_size <= offset + 20)
 				die("pack file %s records an incomplete delta base",
 				    p->pack_name);
-			next_sha1 = (unsigned char *) p->pack_base + offset;
+			next_sha1 = p->windows->base + offset;
 			if (*delta_chain_length == 0)
 				hashcpy(base_sha1, next_sha1);
 			offset = find_pack_entry_one(next_sha1, p);
@@ -1081,7 +1078,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	buffer = xmalloc(size + 1);
 	buffer[size] = 0;
 	memset(&stream, 0, sizeof(stream));
-	stream.next_in = (unsigned char*)p->pack_base + offset;
+	stream.next_in = p->windows->base + offset;
 	stream.avail_in = p->pack_size - offset;
 	stream.next_out = buffer;
 	stream.avail_out = size;
-- 
1.4.4.3.g87d8
