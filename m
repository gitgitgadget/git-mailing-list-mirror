From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v4 07/14] name-hash.c: use new hash map implementation for
 directories
Date: Thu, 07 Nov 2013 15:38:13 +0100
Message-ID: <527BA5D5.5070109@gmail.com>
References: <527BA483.6040803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 15:38:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeQiv-0005qN-V5
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 15:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997Ab3KGOiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 09:38:15 -0500
Received: from mail-we0-f179.google.com ([74.125.82.179]:53871 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329Ab3KGOiN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 09:38:13 -0500
Received: by mail-we0-f179.google.com with SMTP id w61so626752wes.10
        for <git@vger.kernel.org>; Thu, 07 Nov 2013 06:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=xsIRfz6M1xmPdlFIA7rdElTd7USxtD0zGNsTICghQ3U=;
        b=VpVH89wQoBAJTFs1CTdQ+YyXgtjzwWgPAfFlrZJsolLHwGJ7VFKZGjC69umOlMFGN1
         MOlUEN8wAGXnrDzc1VEEc5jcdSf3QMmw8hPZz2WstKVLg7WWZrMiMwmKt8GuU1p7HqZU
         dQiN31mHQnCxUxZICwUmjr9MhikYy4o6W2LR9WDM7DMb/EHZU5mgyTojWiO8V+0Izwa7
         RL5MPy3QVBjvAGIhbbOYGZTD7TZyFC1RgN6RV/HqvK+d0pNgCppa5Cqm5u271AjtfCoA
         ZD/RRY5Etru3A2U3edye2Z3o0049s68+fFiXkn1j4dr8ubOsasFp4GJVsLKkoZYi6UUK
         7aTg==
X-Received: by 10.194.77.167 with SMTP id t7mr7735567wjw.27.1383835092252;
        Thu, 07 Nov 2013 06:38:12 -0800 (PST)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id fu1sm36112923wib.8.2013.11.07.06.38.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Nov 2013 06:38:11 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <527BA483.6040803@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237402>

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     |  3 ++-
 name-hash.c | 77 +++++++++++++++----------------------------------------------
 2 files changed, 20 insertions(+), 60 deletions(-)

diff --git a/cache.h b/cache.h
index d1f3c71..84e9ad6 100644
--- a/cache.h
+++ b/cache.h
@@ -4,6 +4,7 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
 #include "hash.h"
+#include "hashmap.h"
 #include "advice.h"
 #include "gettext.h"
 #include "convert.h"
@@ -278,7 +279,7 @@ struct index_state {
 	unsigned name_hash_initialized : 1,
 		 initialized : 1;
 	struct hash_table name_hash;
-	struct hash_table dir_hash;
+	struct hashmap dir_hash;
 };
 
 extern struct index_state the_index;
diff --git a/name-hash.c b/name-hash.c
index e5b6e1a..ae636f8 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -8,49 +8,28 @@
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 
-/*
- * This removes bit 5 if bit 6 is set.
- *
- * That will make US-ASCII characters hash to their upper-case
- * equivalent. We could easily do this one whole word at a time,
- * but that's for future worries.
- */
-static inline unsigned char icase_hash(unsigned char c)
-{
-	return c & ~((c & 0x40) >> 1);
-}
-
-static unsigned int hash_name(const char *name, int namelen)
-{
-	unsigned int hash = 0x123;
-
-	while (namelen--) {
-		unsigned char c = *name++;
-		c = icase_hash(c);
-		hash = hash*101 + c;
-	}
-	return hash;
-}
-
 struct dir_entry {
-	struct dir_entry *next;
+	struct hashmap_entry ent;
 	struct dir_entry *parent;
 	struct cache_entry *ce;
 	int nr;
 	unsigned int namelen;
 };
 
+static int dir_entry_cmp(const struct dir_entry *e1,
+		const struct dir_entry *e2, const char *name)
+{
+	return e1->namelen != e2->namelen || strncasecmp(e1->ce->name,
+			name ? name : e2->ce->name, e1->namelen);
+}
+
 static struct dir_entry *find_dir_entry(struct index_state *istate,
 		const char *name, unsigned int namelen)
 {
-	unsigned int hash = hash_name(name, namelen);
-	struct dir_entry *dir;
-
-	for (dir = lookup_hash(hash, &istate->dir_hash); dir; dir = dir->next)
-		if (dir->namelen == namelen &&
-		    !strncasecmp(dir->ce->name, name, namelen))
-			return dir;
-	return NULL;
+	struct dir_entry key;
+	hashmap_entry_init(&key, memihash(name, namelen));
+	key.namelen = namelen;
+	return hashmap_get(&istate->dir_hash, &key, name);
 }
 
 static struct dir_entry *hash_dir_entry(struct index_state *istate,
@@ -84,18 +63,11 @@ static struct dir_entry *hash_dir_entry(struct index_state *istate,
 	dir = find_dir_entry(istate, ce->name, namelen);
 	if (!dir) {
 		/* not found, create it and add to hash table */
-		void **pdir;
-		unsigned int hash = hash_name(ce->name, namelen);
-
 		dir = xcalloc(1, sizeof(struct dir_entry));
+		hashmap_entry_init(dir, memihash(ce->name, namelen));
 		dir->namelen = namelen;
 		dir->ce = ce;
-
-		pdir = insert_hash(hash, dir, &istate->dir_hash);
-		if (pdir) {
-			dir->next = *pdir;
-			*pdir = dir;
-		}
+		hashmap_add(&istate->dir_hash, dir);
 
 		/* recursively add missing parent directories */
 		dir->parent = hash_dir_entry(istate, ce, namelen);
@@ -134,7 +106,7 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 		return;
 	ce->ce_flags |= CE_HASHED;
 	ce->next = NULL;
-	hash = hash_name(ce->name, ce_namelen(ce));
+	hash = memihash(ce->name, ce_namelen(ce));
 	pos = insert_hash(hash, ce, &istate->name_hash);
 	if (pos) {
 		ce->next = *pos;
@@ -153,6 +125,7 @@ static void lazy_init_name_hash(struct index_state *istate)
 		return;
 	if (istate->cache_nr)
 		preallocate_hash(&istate->name_hash, istate->cache_nr);
+	hashmap_init(&istate->dir_hash, (hashmap_cmp_fn) dir_entry_cmp, 0);
 	for (nr = 0; nr < istate->cache_nr; nr++)
 		hash_index_entry(istate, istate->cache[nr]);
 	istate->name_hash_initialized = 1;
@@ -247,7 +220,7 @@ struct cache_entry *index_dir_exists(struct index_state *istate, const char *nam
 
 struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int icase)
 {
-	unsigned int hash = hash_name(name, namelen);
+	unsigned int hash = memihash(name, namelen);
 	struct cache_entry *ce;
 
 	lazy_init_name_hash(istate);
@@ -270,26 +243,12 @@ struct cache_entry *index_name_exists(struct index_state *istate, const char *na
 	return index_file_exists(istate, name, namelen, icase);
 }
 
-static int free_dir_entry(void *entry, void *unused)
-{
-	struct dir_entry *dir = entry;
-	while (dir) {
-		struct dir_entry *next = dir->next;
-		free(dir);
-		dir = next;
-	}
-	return 0;
-}
-
 void free_name_hash(struct index_state *istate)
 {
 	if (!istate->name_hash_initialized)
 		return;
 	istate->name_hash_initialized = 0;
-	if (ignore_case)
-		/* free directory entries */
-		for_each_hash(&istate->dir_hash, free_dir_entry, NULL);
 
 	free_hash(&istate->name_hash);
-	free_hash(&istate->dir_hash);
+	hashmap_free(&istate->dir_hash, free);
 }
-- 
1.8.4.msysgit.0.12.g88f5ed0
