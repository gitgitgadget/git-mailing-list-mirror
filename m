From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/4] Add 'const' where appropriate to index handling functions
Date: Thu, 6 Mar 2008 12:46:09 -0800
Message-ID: <041234e39ea23286e4793a894b2444df2cb7dc8b.1204856187.git.torvalds@linux-foundation.org>
References: <cover.1204856187.git.torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 03:22:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXSDw-0001X7-57
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 03:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763335AbYCGCVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 21:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756865AbYCGCVY
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 21:21:24 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38750 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763279AbYCGCVX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2008 21:21:23 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m272Lghr010926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Mar 2008 18:21:43 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m272LIvr032709;
	Thu, 6 Mar 2008 18:21:19 -0800
In-Reply-To: <cover.1204856187.git.torvalds@linux-foundation.org>
X-Spam-Status: No, hits=-4.014 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76454>

This is in an effort to make the source index of 'unpack_trees()' as
being const, and thus making the compiler help us verify that we only
access it for reading.

The constification also extended to some of the hashing helpers that get
called indirectly.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 cache.h      |   10 +++++-----
 hash.c       |    6 +++---
 hash.h       |    4 ++--
 read-cache.c |   12 ++++++------
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/cache.h b/cache.h
index 6eb16cb..b519b7a 100644
--- a/cache.h
+++ b/cache.h
@@ -346,12 +346,12 @@ extern void verify_non_filename(const char *prefix, const char *name);
 /* Initialize and use the cache information */
 extern int read_index(struct index_state *);
 extern int read_index_from(struct index_state *, const char *path);
-extern int write_index(struct index_state *, int newfd);
+extern int write_index(const struct index_state *, int newfd);
 extern int discard_index(struct index_state *);
-extern int unmerged_index(struct index_state *);
+extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
 extern int index_name_exists(struct index_state *istate, const char *name, int namelen);
-extern int index_name_pos(struct index_state *, const char *name, int namelen);
+extern int index_name_pos(const struct index_state *, const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
 #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
@@ -368,8 +368,8 @@ extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
 #define CE_MATCH_IGNORE_VALID		01
 /* do not check the contents but report dirty on racily-clean entries */
 #define CE_MATCH_RACY_IS_DIRTY	02
-extern int ie_match_stat(struct index_state *, struct cache_entry *, struct stat *, unsigned int);
-extern int ie_modified(struct index_state *, struct cache_entry *, struct stat *, unsigned int);
+extern int ie_match_stat(const struct index_state *, struct cache_entry *, struct stat *, unsigned int);
+extern int ie_modified(const struct index_state *, struct cache_entry *, struct stat *, unsigned int);
 
 extern int ce_path_match(const struct cache_entry *ce, const char **pathspec);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, enum object_type type, const char *path);
diff --git a/hash.c b/hash.c
index d9ec82f..1cd4c9d 100644
--- a/hash.c
+++ b/hash.c
@@ -9,7 +9,7 @@
  * the existing entry, or the empty slot if none existed. The caller
  * can then look at the (*ptr) to see whether it existed or not.
  */
-static struct hash_table_entry *lookup_hash_entry(unsigned int hash, struct hash_table *table)
+static struct hash_table_entry *lookup_hash_entry(unsigned int hash, const struct hash_table *table)
 {
 	unsigned int size = table->size, nr = hash % size;
 	struct hash_table_entry *array = table->array;
@@ -66,7 +66,7 @@ static void grow_hash_table(struct hash_table *table)
 	free(old_array);
 }
 
-void *lookup_hash(unsigned int hash, struct hash_table *table)
+void *lookup_hash(unsigned int hash, const struct hash_table *table)
 {
 	if (!table->array)
 		return NULL;
@@ -81,7 +81,7 @@ void **insert_hash(unsigned int hash, void *ptr, struct hash_table *table)
 	return insert_hash_entry(hash, ptr, table);
 }
 
-int for_each_hash(struct hash_table *table, int (*fn)(void *))
+int for_each_hash(const struct hash_table *table, int (*fn)(void *))
 {
 	int sum = 0;
 	unsigned int i;
diff --git a/hash.h b/hash.h
index a8b0fbb..69e33a4 100644
--- a/hash.h
+++ b/hash.h
@@ -28,9 +28,9 @@ struct hash_table {
 	struct hash_table_entry *array;
 };
 
-extern void *lookup_hash(unsigned int hash, struct hash_table *table);
+extern void *lookup_hash(unsigned int hash, const struct hash_table *table);
 extern void **insert_hash(unsigned int hash, void *ptr, struct hash_table *table);
-extern int for_each_hash(struct hash_table *table, int (*fn)(void *));
+extern int for_each_hash(const struct hash_table *table, int (*fn)(void *));
 extern void free_hash(struct hash_table *table);
 
 static inline void init_hash(struct hash_table *table)
diff --git a/read-cache.c b/read-cache.c
index bf649a3..a92b25b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -255,13 +255,13 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	return changed;
 }
 
-static int is_racy_timestamp(struct index_state *istate, struct cache_entry *ce)
+static int is_racy_timestamp(const struct index_state *istate, struct cache_entry *ce)
 {
 	return (istate->timestamp &&
 		((unsigned int)istate->timestamp) <= ce->ce_mtime);
 }
 
-int ie_match_stat(struct index_state *istate,
+int ie_match_stat(const struct index_state *istate,
 		  struct cache_entry *ce, struct stat *st,
 		  unsigned int options)
 {
@@ -304,7 +304,7 @@ int ie_match_stat(struct index_state *istate,
 	return changed;
 }
 
-int ie_modified(struct index_state *istate,
+int ie_modified(const struct index_state *istate,
 		struct cache_entry *ce, struct stat *st, unsigned int options)
 {
 	int changed, changed_fs;
@@ -412,7 +412,7 @@ int cache_name_compare(const char *name1, int flags1, const char *name2, int fla
 	return 0;
 }
 
-int index_name_pos(struct index_state *istate, const char *name, int namelen)
+int index_name_pos(const struct index_state *istate, const char *name, int namelen)
 {
 	int first, last;
 
@@ -1201,7 +1201,7 @@ int discard_index(struct index_state *istate)
 	return 0;
 }
 
-int unmerged_index(struct index_state *istate)
+int unmerged_index(const struct index_state *istate)
 {
 	int i;
 	for (i = 0; i < istate->cache_nr; i++) {
@@ -1346,7 +1346,7 @@ static int ce_write_entry(SHA_CTX *c, int fd, struct cache_entry *ce)
 	return ce_write(c, fd, ondisk, size);
 }
 
-int write_index(struct index_state *istate, int newfd)
+int write_index(const struct index_state *istate, int newfd)
 {
 	SHA_CTX c;
 	struct cache_header hdr;
-- 
1.5.4.3.452.g67136


