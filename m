From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v3 06/11] name-hash.c: use new hash map implementation for
 directories
Date: Tue, 01 Oct 2013 11:37:55 +0200
Message-ID: <524A97F3.3070809@gmail.com>
References: <524A96FF.5090604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 01 11:38:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQwP2-0005Yg-Uh
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 11:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210Ab3JAJh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Oct 2013 05:37:57 -0400
Received: from mail-ea0-f176.google.com ([209.85.215.176]:51299 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205Ab3JAJh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Oct 2013 05:37:56 -0400
Received: by mail-ea0-f176.google.com with SMTP id q16so3219301ead.7
        for <git@vger.kernel.org>; Tue, 01 Oct 2013 02:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=XyVPRGtu5C857ochDkSGOX6Vm/J18Eb5CvXM2qKjbiY=;
        b=J8Aq94kLQoOF09ncBVJw50NP45mZIHuFmze0lJCVuqshyZniaoTOgpYaKWoicMG1ww
         5fMccjGng/TELOa/PqjlxN4IHizt9CsA7j2j+0IuIR57IY2C7DwygI+cyWdmR4H32skw
         IK8hJejDR3RNg+znvuczt8nI96jUqFay4kP6qM2QW8jq/1Rp440G241smqsXwzPfuvIo
         nKsnWpCwjxuyXrj4TGevJfZDEDh8qJe5Frypyhq1NwMaTxyysV+1/Xm0HjFTgY8Kh1Gz
         iTZ++QW8MFQxhHRwnrx42lRNI41NGssDeDbBS6bBoKq3eRHft3t/6QWMxjHTJ2JxT46y
         i8UQ==
X-Received: by 10.14.208.194 with SMTP id q42mr44710671eeo.31.1380620275325;
        Tue, 01 Oct 2013 02:37:55 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id h52sm11143065eez.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Oct 2013 02:37:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <524A96FF.5090604@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235650>

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 cache.h     |  3 ++-
 name-hash.c | 77 +++++++++++++++----------------------------------------------
 2 files changed, 20 insertions(+), 60 deletions(-)

diff --git a/cache.h b/cache.h
index 85b544f..bf6e2f0 100644
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
@@ -276,7 +277,7 @@ struct index_state {
 	unsigned name_hash_initialized : 1,
 		 initialized : 1;
 	struct hash_table name_hash;
-	struct hash_table dir_hash;
+	struct hashmap dir_hash;
 };
 
 extern struct index_state the_index;
diff --git a/name-hash.c b/name-hash.c
index 617c86c..aa57666 100644
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
@@ -83,18 +62,11 @@ static struct dir_entry *hash_dir_entry(struct index_state *istate,
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
 		dir->parent = hash_dir_entry(istate, ce, namelen - 1);
@@ -133,7 +105,7 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 		return;
 	ce->ce_flags |= CE_HASHED;
 	ce->next = NULL;
-	hash = hash_name(ce->name, ce_namelen(ce));
+	hash = memihash(ce->name, ce_namelen(ce));
 	pos = insert_hash(hash, ce, &istate->name_hash);
 	if (pos) {
 		ce->next = *pos;
@@ -152,6 +124,7 @@ static void lazy_init_name_hash(struct index_state *istate)
 		return;
 	if (istate->cache_nr)
 		preallocate_hash(&istate->name_hash, istate->cache_nr);
+	hashmap_init(&istate->dir_hash, (hashmap_cmp_fn) dir_entry_cmp, 0);
 	for (nr = 0; nr < istate->cache_nr; nr++)
 		hash_index_entry(istate, istate->cache[nr]);
 	istate->name_hash_initialized = 1;
@@ -224,7 +197,7 @@ static int same_name(const struct cache_entry *ce, const char *name, int namelen
 
 struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int icase)
 {
-	unsigned int hash = hash_name(name, namelen);
+	unsigned int hash = memihash(name, namelen);
 	struct cache_entry *ce;
 
 	lazy_init_name_hash(istate);
@@ -263,26 +236,12 @@ struct cache_entry *index_name_exists(struct index_state *istate, const char *na
 	return NULL;
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
1.8.4.11.g4f52745.dirty
