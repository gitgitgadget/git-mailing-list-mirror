From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2] merge: fix cache_entry use-after-free
Date: Mon, 12 Oct 2015 18:03:33 -0400
Message-ID: <1444687413-928-1-git-send-email-dturner@twitter.com>
Cc: Keith McGuigan <kmcguigan@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 00:04:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZllCm-0007kr-HO
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 00:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbbJLWEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 18:04:08 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:32811 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbbJLWDl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 18:03:41 -0400
Received: by qgeb31 with SMTP id b31so28444315qge.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 15:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kO9o6HajPTBjVk6M9FICTYFtSIB8eOCPR1xoXQoFNlw=;
        b=G3dDuWTWs6pUZ5jWaSbEwrxeh8fJnhCdaErrx2FNqVmNpv7R+DDvL8FHYgkQocSJhY
         UBoRwjFOfCluD/7mqvNB8546MbRKw+rCnlL35OS/dWkDYigYeUDpEeW/eT8nUtZxGk3d
         dfIjWnR1Ju1dpAhmayAsJ3mfSg3KBCtmpp3A2cZ2OtLEEyN6QktaN1gsudBVDVSsuWOf
         NHWMoN2SW//P8tSzhCrNAWgE/SUlgSJnRBkHJTT2eXFq0Lbl1BTe8XOGuZ2nnyWL5tm6
         Pyz3dfBescirgmGoLR4gnSP6PIkG16SCfJOHVvcISu0yAu+PtfiWjfCcgaD5eJYsAP6P
         ix7Q==
X-Gm-Message-State: ALoCoQleqAz64e+unGsWePUT2+9jmi81bDlWrbCo1vrUxYfmcYzBJVrjtpE0t64amwDcLDz5rv6E
X-Received: by 10.140.147.129 with SMTP id 123mr16707825qht.12.1444687420350;
        Mon, 12 Oct 2015 15:03:40 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 200sm7873431qhh.26.2015.10.12.15.03.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 15:03:39 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279465>

From: Keith McGuigan <kmcguigan@twitter.com>

During merges, we would previously free entries that we no longer need
in the destination index.  But those entries might also be stored in
the dir_entry cache, and when a later call to add_to_index found them,
they would be used after being freed.

To prevent this, add a ref count for struct cache_entry.  Whenever
a cache entry is added to a data structure, the ref count is incremented;
when it is removed from the data structure, it is decremented.  When
it hits zero, the cache_entry is freed.

Signed-off-by: Keith McGuigan <kmcguigan@twitter.com>
---

This version addresses Junio's comments on v1.  It adds a missing
add_ce_ref, and fixes a formatting nit.

 cache.h        | 27 +++++++++++++++++++++++++++
 name-hash.c    |  7 ++++++-
 read-cache.c   |  6 +++++-
 split-index.c  | 13 ++++++++-----
 unpack-trees.c |  6 ++++--
 5 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index 752031e..738f76d 100644
--- a/cache.h
+++ b/cache.h
@@ -149,6 +149,7 @@ struct stat_data {
 
 struct cache_entry {
 	struct hashmap_entry ent;
+	unsigned int ref_count; /* count the number of refs to this in dir_hash */
 	struct stat_data ce_stat_data;
 	unsigned int ce_mode;
 	unsigned int ce_flags;
@@ -213,6 +214,32 @@ struct cache_entry {
 struct pathspec;
 
 /*
+ * Increment the cache_entry reference count.  Should be called
+ * whenever a pointer to a cache_entry is retained in a data structure,
+ * thus marking it as alive.
+ */
+static inline void add_ce_ref(struct cache_entry *ce)
+{
+	assert(ce != NULL && ce->ref_count >= 0);
+	ce->ref_count++;
+}
+
+/*
+ * Decrement the cache_entry reference count.  Should be called whenever
+ * a pointer to a cache_entry is dropped.  Once the counter drops to 0
+ * the cache_entry memory will be safely freed.
+ */
+static inline void drop_ce_ref(struct cache_entry *ce)
+{
+	if (ce != NULL) {
+		assert(ce->ref_count >= 0);
+		if (--ce->ref_count < 1) {
+			free(ce);
+		}
+	}
+}
+
+/*
  * Copy the sha1 and stat state of a cache entry from one to
  * another. But we never change the name, or the hash state!
  */
diff --git a/name-hash.c b/name-hash.c
index 702cd05..f12c919 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -66,6 +66,7 @@ static struct dir_entry *hash_dir_entry(struct index_state *istate,
 		dir = xcalloc(1, sizeof(struct dir_entry));
 		hashmap_entry_init(dir, memihash(ce->name, namelen));
 		dir->namelen = namelen;
+		add_ce_ref(ce);
 		dir->ce = ce;
 		hashmap_add(&istate->dir_hash, dir);
 
@@ -92,7 +93,9 @@ static void remove_dir_entry(struct index_state *istate, struct cache_entry *ce)
 	struct dir_entry *dir = hash_dir_entry(istate, ce, ce_namelen(ce));
 	while (dir && !(--dir->nr)) {
 		struct dir_entry *parent = dir->parent;
-		hashmap_remove(&istate->dir_hash, dir, NULL);
+		struct dir_entry *removed = hashmap_remove(&istate->dir_hash, dir, NULL);
+		assert(removed == dir);
+		drop_ce_ref(dir->ce);
 		free(dir);
 		dir = parent;
 	}
@@ -105,6 +108,7 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 	ce->ce_flags |= CE_HASHED;
 	hashmap_entry_init(ce, memihash(ce->name, ce_namelen(ce)));
 	hashmap_add(&istate->name_hash, ce);
+	add_ce_ref(ce);
 
 	if (ignore_case)
 		add_dir_entry(istate, ce);
@@ -147,6 +151,7 @@ void remove_name_hash(struct index_state *istate, struct cache_entry *ce)
 		return;
 	ce->ce_flags &= ~CE_HASHED;
 	hashmap_remove(&istate->name_hash, ce, ce);
+	drop_ce_ref(ce);
 
 	if (ignore_case)
 		remove_dir_entry(istate, ce);
diff --git a/read-cache.c b/read-cache.c
index 87204a5..8b685bb 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -52,7 +52,9 @@ static const char *alternate_index_output;
 
 static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
 {
+	/* istate->cache[nr] is assumed to not hold a live value */
 	istate->cache[nr] = ce;
+	add_ce_ref(ce);
 	add_name_hash(istate, ce);
 }
 
@@ -62,7 +64,7 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
 
 	replace_index_entry_in_base(istate, old, ce);
 	remove_name_hash(istate, old);
-	free(old);
+	drop_ce_ref(old);
 	set_index_entry(istate, nr, ce);
 	ce->ce_flags |= CE_UPDATE_IN_BASE;
 	istate->cache_changed |= CE_ENTRY_CHANGED;
@@ -75,6 +77,7 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
 
 	new = xmalloc(cache_entry_size(namelen));
 	copy_cache_entry(new, old);
+	new->ref_count = 0;
 	new->ce_flags &= ~CE_HASHED;
 	new->ce_namelen = namelen;
 	new->index = 0;
@@ -1426,6 +1429,7 @@ static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *on
 {
 	struct cache_entry *ce = xmalloc(cache_entry_size(len));
 
+	ce->ref_count = 0;
 	ce->ce_stat_data.sd_ctime.sec = get_be32(&ondisk->ctime.sec);
 	ce->ce_stat_data.sd_mtime.sec = get_be32(&ondisk->mtime.sec);
 	ce->ce_stat_data.sd_ctime.nsec = get_be32(&ondisk->ctime.nsec);
diff --git a/split-index.c b/split-index.c
index 968b780..61b5631 100644
--- a/split-index.c
+++ b/split-index.c
@@ -124,7 +124,7 @@ static void replace_entry(size_t pos, void *data)
 	src->ce_flags |= CE_UPDATE_IN_BASE;
 	src->ce_namelen = dst->ce_namelen;
 	copy_cache_entry(dst, src);
-	free(src);
+	drop_ce_ref(src);
 	si->nr_replacements++;
 }
 
@@ -227,7 +227,7 @@ void prepare_to_write_split_index(struct index_state *istate)
 			base->ce_flags = base_flags;
 			if (ret)
 				ce->ce_flags |= CE_UPDATE_IN_BASE;
-			free(base);
+			drop_ce_ref(base);
 			si->base->cache[ce->index - 1] = ce;
 		}
 		for (i = 0; i < si->base->cache_nr; i++) {
@@ -302,7 +302,7 @@ void save_or_free_index_entry(struct index_state *istate, struct cache_entry *ce
 	    ce == istate->split_index->base->cache[ce->index - 1])
 		ce->ce_flags |= CE_REMOVE;
 	else
-		free(ce);
+		drop_ce_ref(ce);
 }
 
 void replace_index_entry_in_base(struct index_state *istate,
@@ -314,8 +314,11 @@ void replace_index_entry_in_base(struct index_state *istate,
 	    istate->split_index->base &&
 	    old->index <= istate->split_index->base->cache_nr) {
 		new->index = old->index;
-		if (old != istate->split_index->base->cache[new->index - 1])
-			free(istate->split_index->base->cache[new->index - 1]);
+		if (old != istate->split_index->base->cache[new->index - 1]) {
+			struct cache_entry *ce = istate->split_index->base->cache[new->index - 1];
+			drop_ce_ref(ce);
+		}
 		istate->split_index->base->cache[new->index - 1] = new;
+		add_ce_ref(new);
 	}
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index f932e80..1a0a637 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -606,8 +606,10 @@ static int unpack_nondirectories(int n, unsigned long mask,
 					o);
 		for (i = 0; i < n; i++) {
 			struct cache_entry *ce = src[i + o->merge];
-			if (ce != o->df_conflict_entry)
-				free(ce);
+			if (ce != o->df_conflict_entry) {
+				drop_ce_ref(ce);
+				src[i + o->merge] = NULL;
+			}
 		}
 		return rc;
 	}
-- 
2.4.2.644.g97b850b-twtrsrc
