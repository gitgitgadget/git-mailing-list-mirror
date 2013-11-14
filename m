From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 10/14] name-hash.c: remove cache entries instead of marking
 them CE_UNHASHED
Date: Thu, 14 Nov 2013 20:22:27 +0100
Message-ID: <528522F3.4040209@gmail.com>
References: <52851FB5.4050406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 20:22:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh2Up-0002ao-IM
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 20:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561Ab3KNTW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 14:22:28 -0500
Received: from mail-wi0-f180.google.com ([209.85.212.180]:55362 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073Ab3KNTW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 14:22:26 -0500
Received: by mail-wi0-f180.google.com with SMTP id ey16so1483141wid.13
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 11:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=SQrfJ0nu0xqO/JYvH7icc6Io+jHcuLdRUUHLYCRqyTA=;
        b=qLFJjjT/5I+WSRJk5EDrJEs1Isw320BkkyqwqH+t9emlXUjEB3lzjyFVLYMZ7B2iHE
         jtqxna0vjqvJ1froChmhfFDxyMva/aLfPlwS3F26nGk4JbAKQ8B03sI8BI6+9IyZsLS3
         SytN9w4sPibC5G2BiH34Qt70v/EUv0pN7nR685F9Bl8x/cnTygfT9f/ICw/rDoC9AobG
         ceaN5dBoQ4gaYW/QFtxh0lMZUM11P1MxejSduGN3eoMv44XBC5sjOPRC1cDiKSMzinsD
         BNteVu6yi/wPsro254qXNyf/+/W/Hvybn64TzhFlGxjAd9vH4dzg35as41vwPmtYCr8g
         RtoQ==
X-Received: by 10.194.2.108 with SMTP id 12mr3567641wjt.64.1384456945377;
        Thu, 14 Nov 2013 11:22:25 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id qc10sm1587175wic.9.2013.11.14.11.22.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 11:22:24 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <52851FB5.4050406@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237871>

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
index 488eccf..9a3bd3f 100644
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
1.8.5.rc0.333.g5394214
