From: Thomas Rast <trast@student.ethz.ch>
Subject: [POC PATCH 4/5] sha1_file: stuff various pack reading variables into a struct
Date: Fri, 9 Dec 2011 09:39:36 +0100
Message-ID: <21a0f7e2a7111bf09d34dfc76e8d1308cea6a7ac.1323419666.git.trast@student.ethz.ch>
References: <cover.1323419666.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Herman <eric@freesa.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 09 09:40:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYvzv-0005VI-RE
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 09:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab1LIIjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 03:39:51 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:15752 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752333Ab1LIIjp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 03:39:45 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 9 Dec
 2011 09:39:38 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 9 Dec
 2011 09:39:39 +0100
X-Mailer: git-send-email 1.7.8.431.g2abf2
In-Reply-To: <cover.1323419666.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186620>

In preparation for making these variables thread-local, put various
delta-cache related bits of pack reading state into a struct.  For now
the accessor function is a dummy that always returns a static instance
of this struct.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 sha1_file.c |   99 ++++++++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 67 insertions(+), 32 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 18648c3..7c367f9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1655,21 +1655,50 @@ static void *unpack_compressed_entry(struct packed_git *p,
 
 #define MAX_DELTA_CACHE (256)
 
-static size_t delta_base_cached;
-
-static struct delta_base_cache_lru_list {
+struct delta_base_cache_lru_list {
 	struct delta_base_cache_lru_list *prev;
 	struct delta_base_cache_lru_list *next;
-} delta_base_cache_lru = { &delta_base_cache_lru, &delta_base_cache_lru };
+};
+
+static struct delta_base_cache_lru_list main_delta_base_cache_lru = {
+	&main_delta_base_cache_lru, &main_delta_base_cache_lru
+};
 
-static struct delta_base_cache_entry {
+struct delta_base_cache_entry {
 	struct delta_base_cache_lru_list lru;
 	void *data;
 	struct packed_git *p;
 	off_t base_offset;
 	unsigned long size;
 	enum object_type type;
-} delta_base_cache[MAX_DELTA_CACHE];
+};
+
+static struct delta_base_cache_entry main_delta_base_cache[MAX_DELTA_CACHE];
+
+struct pack_context {
+	size_t delta_base_cached;
+	struct delta_base_cache_entry *delta_base_cache;
+	struct delta_base_cache_lru_list *delta_base_cache_lru;
+	struct packed_git *last_found;
+};
+
+static struct pack_context main_pack_context = {
+	0, main_delta_base_cache, &main_delta_base_cache_lru, (void*)1
+};
+
+static struct pack_context *pack_context_alloc(void)
+{
+	struct pack_context *ctx = xmalloc(sizeof(struct pack_context));
+	ctx->delta_base_cached = 0;
+	ctx->delta_base_cache_lru = xmalloc(sizeof(struct delta_base_cache_lru_list));
+	ctx->delta_base_cache_lru->prev = ctx->delta_base_cache_lru;
+	ctx->delta_base_cache_lru->next = ctx->delta_base_cache_lru;
+	ctx->delta_base_cache = xcalloc(MAX_DELTA_CACHE, sizeof(struct delta_base_cache_entry));
+	ctx->last_found = (void*)1;
+	return ctx;
+}
+
+#define get_thread_pack_context() (&main_pack_context)
 
 static unsigned long pack_entry_hash(struct packed_git *p, off_t base_offset)
 {
@@ -1683,7 +1712,8 @@ static unsigned long pack_entry_hash(struct packed_git *p, off_t base_offset)
 static int in_delta_base_cache(struct packed_git *p, off_t base_offset)
 {
 	unsigned long hash = pack_entry_hash(p, base_offset);
-	struct delta_base_cache_entry *ent = delta_base_cache + hash;
+	struct delta_base_cache_entry *ent
+		= get_thread_pack_context()->delta_base_cache + hash;
 	return (ent->data && ent->p == p && ent->base_offset == base_offset);
 }
 
@@ -1692,7 +1722,8 @@ static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
 {
 	void *ret;
 	unsigned long hash = pack_entry_hash(p, base_offset);
-	struct delta_base_cache_entry *ent = delta_base_cache + hash;
+	struct pack_context *ctx = get_thread_pack_context();
+	struct delta_base_cache_entry *ent = ctx->delta_base_cache + hash;
 
 	ret = ent->data;
 	if (!ret || ent->p != p || ent->base_offset != base_offset)
@@ -1702,7 +1733,7 @@ static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
 		ent->data = NULL;
 		ent->lru.next->prev = ent->lru.prev;
 		ent->lru.prev->next = ent->lru.next;
-		delta_base_cached -= ent->size;
+		ctx->delta_base_cached -= ent->size;
 	} else {
 		ret = xmemdupz(ent->data, ent->size);
 	}
@@ -1711,48 +1742,52 @@ static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
 	return ret;
 }
 
-static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
+static inline void release_delta_base_cache(struct pack_context *ctx,
+					    struct delta_base_cache_entry *ent)
 {
 	if (ent->data) {
 		free(ent->data);
 		ent->data = NULL;
 		ent->lru.next->prev = ent->lru.prev;
 		ent->lru.prev->next = ent->lru.next;
-		delta_base_cached -= ent->size;
+		ctx->delta_base_cached -= ent->size;
 	}
 }
 
 void clear_delta_base_cache(void)
 {
 	unsigned long p;
+	struct pack_context *ctx = get_thread_pack_context();
+	struct delta_base_cache_entry *delta_base_cache = ctx->delta_base_cache;
 	for (p = 0; p < MAX_DELTA_CACHE; p++)
-		release_delta_base_cache(&delta_base_cache[p]);
+		release_delta_base_cache(ctx, &delta_base_cache[p]);
 }
 
 static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	void *base, unsigned long base_size, enum object_type type)
 {
 	unsigned long hash = pack_entry_hash(p, base_offset);
-	struct delta_base_cache_entry *ent = delta_base_cache + hash;
+	struct pack_context *ctx = get_thread_pack_context();
+	struct delta_base_cache_entry *ent = ctx->delta_base_cache + hash;
 	struct delta_base_cache_lru_list *lru;
 
-	release_delta_base_cache(ent);
-	delta_base_cached += base_size;
+	release_delta_base_cache(ctx, ent);
+	ctx->delta_base_cached += base_size;
 
-	for (lru = delta_base_cache_lru.next;
-	     delta_base_cached > delta_base_cache_limit
-	     && lru != &delta_base_cache_lru;
+	for (lru = ctx->delta_base_cache_lru->next;
+	     ctx->delta_base_cached > delta_base_cache_limit
+	     && lru != ctx->delta_base_cache_lru;
 	     lru = lru->next) {
 		struct delta_base_cache_entry *f = (void *)lru;
 		if (f->type == OBJ_BLOB)
-			release_delta_base_cache(f);
+			release_delta_base_cache(ctx, f);
 	}
-	for (lru = delta_base_cache_lru.next;
-	     delta_base_cached > delta_base_cache_limit
-	     && lru != &delta_base_cache_lru;
+	for (lru = ctx->delta_base_cache_lru->next;
+	     ctx->delta_base_cached > delta_base_cache_limit
+	     && lru != ctx->delta_base_cache_lru;
 	     lru = lru->next) {
 		struct delta_base_cache_entry *f = (void *)lru;
-		release_delta_base_cache(f);
+		release_delta_base_cache(ctx, f);
 	}
 
 	ent->p = p;
@@ -1760,10 +1795,10 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	ent->type = type;
 	ent->data = base;
 	ent->size = base_size;
-	ent->lru.next = &delta_base_cache_lru;
-	ent->lru.prev = delta_base_cache_lru.prev;
-	delta_base_cache_lru.prev->next = &ent->lru;
-	delta_base_cache_lru.prev = &ent->lru;
+	ent->lru.next = ctx->delta_base_cache_lru;
+	ent->lru.prev = ctx->delta_base_cache_lru->prev;
+	ctx->delta_base_cache_lru->prev->next = &ent->lru;
+	ctx->delta_base_cache_lru->prev = &ent->lru;
 }
 
 static void *read_object(const unsigned char *sha1, enum object_type *type,
@@ -2021,14 +2056,14 @@ int is_pack_valid(struct packed_git *p)
 
 static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 {
-	static struct packed_git *last_found = (void *)1;
 	struct packed_git *p;
 	off_t offset;
+	struct pack_context *ctx = get_thread_pack_context();
 
 	prepare_packed_git();
 	if (!packed_git)
 		return 0;
-	p = (last_found == (void *)1) ? packed_git : last_found;
+	p = (ctx->last_found == (void *)1) ? packed_git : ctx->last_found;
 
 	do {
 		if (p->num_bad_objects) {
@@ -2055,16 +2090,16 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 			e->offset = offset;
 			e->p = p;
 			hashcpy(e->sha1, sha1);
-			last_found = p;
+			ctx->last_found = p;
 			return 1;
 		}
 
 		next:
-		if (p == last_found)
+		if (p == ctx->last_found)
 			p = packed_git;
 		else
 			p = p->next;
-		if (p == last_found)
+		if (p == ctx->last_found)
 			p = p->next;
 	} while (p);
 	return 0;
-- 
1.7.8.431.g2abf2
