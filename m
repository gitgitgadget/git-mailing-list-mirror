From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 09/14] name-hash.c: use new hash map implementation for
 cache entries
Date: Thu, 14 Nov 2013 20:21:58 +0100
Message-ID: <528522D6.9000309@gmail.com>
References: <52851FB5.4050406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 20:22:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh2UN-0002BK-CW
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 20:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488Ab3KNTV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 14:21:59 -0500
Received: from mail-we0-f181.google.com ([74.125.82.181]:54982 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755514Ab3KNTV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 14:21:58 -0500
Received: by mail-we0-f181.google.com with SMTP id w61so2577925wes.12
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 11:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=D8XW5QTqNQpbSv4WIIXf0MaqiSUy5x+0Ez14pMYEjv8=;
        b=1FK5mxhM3OoDzGzTHU2QAcT9+uBi29TlErlTd1p27LmTAST5pHhlcp0FC9+cWe1JUp
         /G2gXGhH2cJ3xxFZQFEutQ2vR06hDvN2VCCRmP4UqRSQdUgvfvsghOZTEOgGzzsNuOYr
         G+msxcuY5LISrqLQUJblEiukZknPeMShsCRUxb8QHyoZORh84uxExJLMQ5VOhCWSqHFh
         yeg37bcmKU9t8Bxoa/PjVj3vQtph1+R7dXYOlYysLnRbwydrqtVknbRL6/SeMocC0tzH
         NuscWHmVQH7q1uYuhD3eMonm6xrwaw2+JrXInP4NjstoD/i2QTMCddTS/bizR9SwEhID
         k9ig==
X-Received: by 10.194.84.10 with SMTP id u10mr3489550wjy.94.1384456916353;
        Thu, 14 Nov 2013 11:21:56 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id bs15sm1440207wib.10.2013.11.14.11.21.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 11:21:55 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <52851FB5.4050406@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237870>

Note: the "ce->next = NULL;" in unpack-trees.c::do_add_entry can safely be
removed, as ce->next (now ce->ent.next) is always properly initialized in
name-hash.c::hash_index_entry.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h        |  8 +++++---
 name-hash.c    | 24 ++++++++----------------
 unpack-trees.c |  1 -
 3 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/cache.h b/cache.h
index 84e9ad6..cedc7ae 100644
--- a/cache.h
+++ b/cache.h
@@ -131,12 +131,12 @@ struct stat_data {
 };
 
 struct cache_entry {
+	struct hashmap_entry ent;
 	struct stat_data ce_stat_data;
 	unsigned int ce_mode;
 	unsigned int ce_flags;
 	unsigned int ce_namelen;
 	unsigned char sha1[20];
-	struct cache_entry *next;
 	char name[FLEX_ARRAY]; /* more */
 };
 
@@ -203,7 +203,9 @@ static inline void copy_cache_entry(struct cache_entry *dst,
 	unsigned int state = dst->ce_flags & CE_STATE_MASK;
 
 	/* Don't copy hash chain and name */
-	memcpy(dst, src, offsetof(struct cache_entry, next));
+	memcpy(&dst->ce_stat_data, &src->ce_stat_data,
+			offsetof(struct cache_entry, name) -
+			offsetof(struct cache_entry, ce_stat_data));
 
 	/* Restore the hash state */
 	dst->ce_flags = (dst->ce_flags & ~CE_STATE_MASK) | state;
@@ -278,7 +280,7 @@ struct index_state {
 	struct cache_time timestamp;
 	unsigned name_hash_initialized : 1,
 		 initialized : 1;
-	struct hash_table name_hash;
+	struct hashmap name_hash;
 	struct hashmap dir_hash;
 };
 
diff --git a/name-hash.c b/name-hash.c
index effe96d..488eccf 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -100,19 +100,11 @@ static void remove_dir_entry(struct index_state *istate, struct cache_entry *ce)
 
 static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 {
-	void **pos;
-	unsigned int hash;
-
 	if (ce->ce_flags & CE_HASHED)
 		return;
 	ce->ce_flags |= CE_HASHED;
-	ce->next = NULL;
-	hash = memihash(ce->name, ce_namelen(ce));
-	pos = insert_hash(hash, ce, &istate->name_hash);
-	if (pos) {
-		ce->next = *pos;
-		*pos = ce;
-	}
+	hashmap_entry_init(ce, memihash(ce->name, ce_namelen(ce)));
+	hashmap_add(&istate->name_hash, ce);
 
 	if (ignore_case && !(ce->ce_flags & CE_UNHASHED))
 		add_dir_entry(istate, ce);
@@ -124,8 +116,7 @@ static void lazy_init_name_hash(struct index_state *istate)
 
 	if (istate->name_hash_initialized)
 		return;
-	if (istate->cache_nr)
-		preallocate_hash(&istate->name_hash, istate->cache_nr);
+	hashmap_init(&istate->name_hash, NULL, istate->cache_nr);
 	hashmap_init(&istate->dir_hash, (hashmap_cmp_fn) dir_entry_cmp, 0);
 	for (nr = 0; nr < istate->cache_nr; nr++)
 		hash_index_entry(istate, istate->cache[nr]);
@@ -221,18 +212,19 @@ struct cache_entry *index_dir_exists(struct index_state *istate, const char *nam
 
 struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int icase)
 {
-	unsigned int hash = memihash(name, namelen);
 	struct cache_entry *ce;
+	struct hashmap_entry key;
 
 	lazy_init_name_hash(istate);
-	ce = lookup_hash(hash, &istate->name_hash);
 
+	hashmap_entry_init(&key, memihash(name, namelen));
+	ce = hashmap_get(&istate->name_hash, &key, NULL);
 	while (ce) {
 		if (!(ce->ce_flags & CE_UNHASHED)) {
 			if (same_name(ce, name, namelen, icase))
 				return ce;
 		}
-		ce = ce->next;
+		ce = hashmap_get_next(&istate->name_hash, ce);
 	}
 	return NULL;
 }
@@ -250,6 +242,6 @@ void free_name_hash(struct index_state *istate)
 		return;
 	istate->name_hash_initialized = 0;
 
-	free_hash(&istate->name_hash);
+	hashmap_free(&istate->name_hash, 0);
 	hashmap_free(&istate->dir_hash, 1);
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index ad3e9a0..f8985d4 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -110,7 +110,6 @@ static void do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 	if (set & CE_REMOVE)
 		set |= CE_WT_REMOVE;
 
-	ce->next = NULL;
 	ce->ce_flags = (ce->ce_flags & ~clear) | set;
 	add_index_entry(&o->result, ce,
 			ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
-- 
1.8.5.rc0.333.g5394214
