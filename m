From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/2] use a LRU eviction policy for the delta base cache
Date: Mon, 19 Mar 2007 16:31:04 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703191628570.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 21:31:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTOVy-00084N-J0
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 21:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbXCSUbQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 16:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbXCSUbP
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 16:31:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46749 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495AbXCSUbN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 16:31:13 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF600DO53NS8020@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 19 Mar 2007 16:31:05 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42669>

This provides a smoother degradation in performance when the cache
gets trashed due to the delta_base_cache_limit being reached.  Limited
testing with really small delta_base_cache_limit values appears to confirm
this.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 sha1_file.c |   39 +++++++++++++++++++++++++++++++--------
 1 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 8a19d7e..9fe2bd6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1355,11 +1355,18 @@ static void *unpack_compressed_entry(struct packed_git *p,
 #define MAX_DELTA_CACHE (256)
 
 static size_t delta_base_cached;
+
+static struct delta_base_cache_lru_list {
+	struct delta_base_cache_lru_list *prev;
+	struct delta_base_cache_lru_list *next;
+} delta_base_cache_lru = { &delta_base_cache_lru, &delta_base_cache_lru };
+
 static struct delta_base_cache_entry {
+	struct delta_base_cache_lru_list lru;
+	void *data;
 	struct packed_git *p;
 	off_t base_offset;
 	unsigned long size;
-	void *data;
 	enum object_type type;
 } delta_base_cache[MAX_DELTA_CACHE];
 
@@ -1387,6 +1394,8 @@ static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
 found_cache_entry:
 	if (!keep_cache) {
 		ent->data = NULL;
+		ent->lru.next->prev = ent->lru.prev;
+		ent->lru.prev->next = ent->lru.next;
 		delta_base_cached -= ent->size;
 	}
 	else {
@@ -1404,6 +1413,8 @@ static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
 	if (ent->data) {
 		free(ent->data);
 		ent->data = NULL;
+		ent->lru.next->prev = ent->lru.prev;
+		ent->lru.prev->next = ent->lru.next;
 		delta_base_cached -= ent->size;
 	}
 }
@@ -1411,26 +1422,38 @@ static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
 static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	void *base, unsigned long base_size, enum object_type type)
 {
-	unsigned long i, hash = pack_entry_hash(p, base_offset);
+	unsigned long hash = pack_entry_hash(p, base_offset);
 	struct delta_base_cache_entry *ent = delta_base_cache + hash;
+	struct delta_base_cache_lru_list *lru;
 
 	release_delta_base_cache(ent);
 	delta_base_cached += base_size;
-	for (i = 0; delta_base_cached > delta_base_cache_limit
-		    && i < MAX_DELTA_CACHE ; i++) {
-		struct delta_base_cache_entry *f = delta_base_cache + i;
+
+	for (lru = delta_base_cache_lru.next;
+	     delta_base_cached > delta_base_cache_limit
+	     && lru != &delta_base_cache_lru;
+	     lru = lru->next) {
+		struct delta_base_cache_entry *f = (void *)lru;
 		if (f->type == OBJ_BLOB)
 			release_delta_base_cache(f);
 	}
-	for (i = 0; delta_base_cached > delta_base_cache_limit
-		    && i < MAX_DELTA_CACHE ; i++)
-		release_delta_base_cache(delta_base_cache + i);
+	for (lru = delta_base_cache_lru.next;
+	     delta_base_cached > delta_base_cache_limit
+	     && lru != &delta_base_cache_lru;
+	     lru = lru->next) {
+		struct delta_base_cache_entry *f = (void *)lru;
+		release_delta_base_cache(f);
+	}
 
 	ent->p = p;
 	ent->base_offset = base_offset;
 	ent->type = type;
 	ent->data = base;
 	ent->size = base_size;
+	ent->lru.next = &delta_base_cache_lru;
+	ent->lru.prev = delta_base_cache_lru.prev;
+	delta_base_cache_lru.prev->next = &ent->lru;
+	delta_base_cache_lru.prev = &ent->lru;
 }
 
 static void *unpack_delta_entry(struct packed_git *p,
-- 
1.5.1.rc1.596.ge11e-dirty
