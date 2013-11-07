From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v4 10/14] name-hash.c: remove cache entries instead of marking
 them CE_UNHASHED
Date: Thu, 07 Nov 2013 15:39:46 +0100
Message-ID: <527BA632.4070106@gmail.com>
References: <527BA483.6040803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 15:39:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeQkO-0001P2-90
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 15:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033Ab3KGOjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 09:39:45 -0500
Received: from mail-bk0-f51.google.com ([209.85.214.51]:43222 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab3KGOjo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 09:39:44 -0500
Received: by mail-bk0-f51.google.com with SMTP id my12so265226bkb.24
        for <git@vger.kernel.org>; Thu, 07 Nov 2013 06:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=oAMyRfuExtWwfrAKSCY4stIKqU6zWVhvLHXWFl+yKzI=;
        b=v/7gQIny9WjWdjzdJrZA1Ntvk89wWAq+O2mOPtFPBA4Zk6I/DFFvGaZmXlpeUpuPy1
         ZtQZPQJPZbTq2mjsn7PqAcgeAj0wbVPIVr5BmnId1QbdmOJgvmYQVhVLTiGuuQ8wOCE1
         ng4+27EnQ6BikrEFCw9FbWIOgZx3FZU09DMFYMYyjKu2sPQcj4ECTE57YJGeZZOhWWhB
         VX7lj1EVw157M/46XJIRq3ottbzKVMfjvO8CKNJ0TtHHfCntIDwi/l88cJf6YSRMuj2T
         zeTXqkCYMWcmpBjopV3tQ+MGX55FkUlbSkuEM/1tlwbwkhUaD/cZJHZdUlvpERIxRNSh
         zVCw==
X-Received: by 10.204.69.202 with SMTP id a10mr2459922bkj.36.1383835182859;
        Thu, 07 Nov 2013 06:39:42 -0800 (PST)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id on10sm2564541bkb.13.2013.11.07.06.39.41
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Nov 2013 06:39:42 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <527BA483.6040803@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237405>

The new hashmap implementation supports remove, so really remove unused
cache entries from the name hashmap instead of just marking them.

The CE_UNHASHED flag and CE_STATE_MASK are no longer needed.

Keep the CE_HASHED flag to prevent adding entries twice.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h        |  6 ++----
 name-hash.c    | 46 ++++++++++++++++++++++------------------------
 read-cache.c   |  2 +-
 unpack-trees.c |  2 +-
 4 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/cache.h b/cache.h
index cedc7ae..05b8011 100644
--- a/cache.h
+++ b/cache.h
@@ -160,7 +160,6 @@ struct cache_entry {
 #define CE_ADDED             (1 << 19)
 
 #define CE_HASHED            (1 << 20)
-#define CE_UNHASHED          (1 << 21)
 #define CE_WT_REMOVE         (1 << 22) /* remove in work directory */
 #define CE_CONFLICTED        (1 << 23)
 
@@ -196,11 +195,10 @@ struct pathspec;
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
@@ -208,7 +206,7 @@ static inline void copy_cache_entry(struct cache_entry *dst,
 			offsetof(struct cache_entry, ce_stat_data));
 
 	/* Restore the hash state */
-	dst->ce_flags = (dst->ce_flags & ~CE_STATE_MASK) | state;
+	dst->ce_flags = (dst->ce_flags & ~CE_HASHED) | state;
 }
 
 static inline unsigned create_ce_flags(unsigned stage)
diff --git a/name-hash.c b/name-hash.c
index 1ec82a3..8871d8e 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -106,17 +106,29 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
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
@@ -125,31 +137,19 @@ static void lazy_init_name_hash(struct index_state *istate)
 
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
@@ -220,10 +220,8 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
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
 	return NULL;
diff --git a/read-cache.c b/read-cache.c
index 33dd676..00af9ad 100644
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
index f8985d4..82b652f 100644
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
1.8.4.msysgit.0.12.g88f5ed0
