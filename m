From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v3 09/11] name-hash.c: remove cache entries instead of marking
 them CE_UNHASHED
Date: Tue, 01 Oct 2013 11:39:45 +0200
Message-ID: <524A9861.2060907@gmail.com>
References: <524A96FF.5090604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 01 11:39:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQwQv-0006zM-Ea
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 11:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272Ab3JAJjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Oct 2013 05:39:54 -0400
Received: from mail-ea0-f182.google.com ([209.85.215.182]:59793 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995Ab3JAJjq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Oct 2013 05:39:46 -0400
Received: by mail-ea0-f182.google.com with SMTP id o10so3319626eaj.27
        for <git@vger.kernel.org>; Tue, 01 Oct 2013 02:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=OmfwP7YpcZzDXVMBQWARyhVbpFG5AL8l9aZ/+bG3ivs=;
        b=H+gfdBvjk6J2MNqLcsBvFYEa6dGpp4ooREleSMuPnLkBtEBlBlsFnuuCYXqHGpNWAw
         qxY+gSBTLHHt77TWNdeCy+gXD0vYpEZTnHt/gx6Imq+7fP96WcU5iq4RPj9ivWg+PNsC
         lZE2biIEyMX4kEyUIWpuGPMEsDiI48YWnVY3N5U4MmH+EwMx2O/zykfcdbXyHPaoBrI4
         NzTFmaMRKG349vYPztWAzrRnnUv/cJsXv40eFKbSxE9x/v0egqFBtx4zF4lbjJg7aO7a
         p/y8H10h9xjLRI9oRANqOBPB4aioQAcoUUNXLVVyYWMZwLnyFwn4sZxZVs1Ay6QL8BxW
         qtLA==
X-Received: by 10.14.107.68 with SMTP id n44mr45278052eeg.26.1380620385446;
        Tue, 01 Oct 2013 02:39:45 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id v8sm11086943eeo.12.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Oct 2013 02:39:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <524A96FF.5090604@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235653>

The new hashmap implementation supports remove, so really remove unused
cache entries from the name hashmap instead of just marking them.

The CE_UNHASHED flag and CE_STATE_MASK are no longer needed.

Keep the CE_HASHED flag to prevent adding entries twice.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 cache.h        |  6 ++----
 name-hash.c    | 46 ++++++++++++++++++++++------------------------
 read-cache.c   |  2 +-
 unpack-trees.c |  2 +-
 4 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/cache.h b/cache.h
index 46309c6..8833944 100644
--- a/cache.h
+++ b/cache.h
@@ -160,7 +160,6 @@ struct cache_entry {
 #define CE_ADDED             (1 << 19)
 
 #define CE_HASHED            (1 << 20)
-#define CE_UNHASHED          (1 << 21)
 #define CE_WT_REMOVE         (1 << 22) /* remove in work directory */
 #define CE_CONFLICTED        (1 << 23)
 
@@ -194,11 +193,10 @@ struct cache_entry {
  * Copy the sha1 and stat state of a cache entry from one to
  * another. But we never change the name, or the hash state!
  */
-#define CE_STATE_MASK (CE_HASHED | CE_UNHASHED)
 static inline void copy_cache_entry(struct cache_entry *dst,
 				    const struct cache_entry *src)
 {
-	unsigned int state = dst->ce_flags & CE_STATE_MASK;
+	unsigned int state = dst->ce_flags & CE_HASHED;
 
 	/* Don't copy hash chain and name */
 	memcpy(&dst->ce_stat_data, &src->ce_stat_data,
@@ -206,7 +204,7 @@ static inline void copy_cache_entry(struct cache_entry *dst,
 			offsetof(struct cache_entry, ce_stat_data));
 
 	/* Restore the hash state */
-	dst->ce_flags = (dst->ce_flags & ~CE_STATE_MASK) | state;
+	dst->ce_flags = (dst->ce_flags & ~CE_HASHED) | state;
 }
 
 static inline unsigned create_ce_flags(unsigned stage)
diff --git a/name-hash.c b/name-hash.c
index 4879ce4..4aac33f 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -105,17 +105,29 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 	hashmap_entry_init(ce, memihash(ce->name, ce_namelen(ce)));
 	hashmap_add(&istate->name_hash, ce);
 
-	if (ignore_case && !(ce->ce_flags & CE_UNHASHED))
+	if (ignore_case)
 		add_dir_entry(istate, ce);
 }
 
+static int cache_entry_cmp(const struct cache_entry *ce1,
+		const struct cache_entry *ce2, const void *remove)
+{
+	/*
+	 * For remove_name_hash, find the exact entry (pointer equality); for
+	 * index_name_exists, find all entries with matching hash code and
+	 * decide whether the entry matches in same_name.
+	 */
+	return remove ? !(ce1 == ce2) : 0;
+}
+
 static void lazy_init_name_hash(struct index_state *istate)
 {
 	int nr;
 
 	if (istate->name_hash_initialized)
 		return;
-	hashmap_init(&istate->name_hash, NULL, istate->cache_nr);
+	hashmap_init(&istate->name_hash, (hashmap_cmp_fn) cache_entry_cmp,
+			istate->cache_nr);
 	hashmap_init(&istate->dir_hash, (hashmap_cmp_fn) dir_entry_cmp, 0);
 	for (nr = 0; nr < istate->cache_nr; nr++)
 		hash_index_entry(istate, istate->cache[nr]);
@@ -124,31 +136,19 @@ static void lazy_init_name_hash(struct index_state *istate)
 
 void add_name_hash(struct index_state *istate, struct cache_entry *ce)
 {
-	/* if already hashed, add reference to directory entries */
-	if (ignore_case && (ce->ce_flags & CE_STATE_MASK) == CE_STATE_MASK)
-		add_dir_entry(istate, ce);
-
-	ce->ce_flags &= ~CE_UNHASHED;
 	if (istate->name_hash_initialized)
 		hash_index_entry(istate, ce);
 }
 
-/*
- * We don't actually *remove* it, we can just mark it invalid so that
- * we won't find it in lookups.
- *
- * Not only would we have to search the lists (simple enough), but
- * we'd also have to rehash other hash buckets in case this makes the
- * hash bucket empty (common). So it's much better to just mark
- * it.
- */
 void remove_name_hash(struct index_state *istate, struct cache_entry *ce)
 {
-	/* if already hashed, release reference to directory entries */
-	if (ignore_case && (ce->ce_flags & CE_STATE_MASK) == CE_HASHED)
-		remove_dir_entry(istate, ce);
+	if (!istate->name_hash_initialized || !(ce->ce_flags & CE_HASHED))
+		return;
+	ce->ce_flags &= ~CE_HASHED;
+	hashmap_remove(&istate->name_hash, ce, ce);
 
-	ce->ce_flags |= CE_UNHASHED;
+	if (ignore_case)
+		remove_dir_entry(istate, ce);
 }
 
 static int slow_same_name(const char *name1, int len1, const char *name2, int len2)
@@ -197,10 +197,8 @@ struct cache_entry *index_name_exists(struct index_state *istate, const char *na
 	hashmap_entry_init(&key, memihash(name, namelen));
 	ce = hashmap_get(&istate->name_hash, &key, NULL);
 	while (ce) {
-		if (!(ce->ce_flags & CE_UNHASHED)) {
-			if (same_name(ce, name, namelen, icase))
-				return ce;
-		}
+		if (same_name(ce, name, namelen, icase))
+			return ce;
 		ce = hashmap_get_next(&istate->name_hash, ce);
 	}
 
diff --git a/read-cache.c b/read-cache.c
index c3d5e35..0b5c44b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -58,7 +58,7 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
 
 	new = xmalloc(cache_entry_size(namelen));
 	copy_cache_entry(new, old);
-	new->ce_flags &= ~CE_STATE_MASK;
+	new->ce_flags &= ~CE_HASHED;
 	new->ce_namelen = namelen;
 	memcpy(new->name, new_name, namelen + 1);
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 9c108a2..92c7bc4 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -105,7 +105,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 static void do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 			 unsigned int set, unsigned int clear)
 {
-	clear |= CE_HASHED | CE_UNHASHED;
+	clear |= CE_HASHED;
 
 	if (set & CE_REMOVE)
 		set |= CE_WT_REMOVE;
-- 
1.8.4.11.g4f52745.dirty
