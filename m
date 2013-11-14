From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 07/14] name-hash.c: use new hash map implementation for
 directories
Date: Thu, 14 Nov 2013 20:20:58 +0100
Message-ID: <5285229A.7060902@gmail.com>
References: <52851FB5.4050406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 20:21:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh2TR-0001Ml-2X
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 20:21:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab3KNTVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 14:21:01 -0500
Received: from mail-wi0-f175.google.com ([209.85.212.175]:42321 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708Ab3KNTVA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 14:21:00 -0500
Received: by mail-wi0-f175.google.com with SMTP id hm11so7648086wib.14
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 11:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=j/WTVm2DaJXGVGd2NSeZj2prJCJQ7IozAR2eH/ojMpY=;
        b=XZgPR7ECHbYV4Ga8iyZisf9KBeEaSx/+H5veO/pzNqQjsIG+NzOkGbGNUhfMnK3FUS
         qdHUvE6PMoDDo27l9/ATf522utSPe48favZTY037SUJHoRATd6YGq90uqc7b63Y2ePSB
         vAD9vp8Xj7l9FkpK1Z9rKHl01CSGFq8TcKpUhZWm8SdDf12k87/O4+KApqXk7pGyL+ZK
         S97TGdsyO4oC5xDFFEafnhP57dim4Anop1Q1TxUsylXPq23xIJpHVCnSuQDBo/l3kCox
         3Pdgj45j/nefq7Ifp4tOtE0e+Slm/h/riOA7vSlSnnJgqt/qJQ2HqGyn/7Dc+PYm3a2S
         9rPg==
X-Received: by 10.194.2.108 with SMTP id 12mr3560874wjt.64.1384456857653;
        Thu, 14 Nov 2013 11:20:57 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id mq4sm1593493wic.1.2013.11.14.11.20.56
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 11:20:57 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <52851FB5.4050406@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237868>

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
index e5b6e1a..c75fadf 100644
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
+	hashmap_free(&istate->dir_hash, 1);
 }
-- 
1.8.5.rc0.333.g5394214
