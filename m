From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/7] Move name hashing functions into a file of its own
Date: Sat, 22 Mar 2008 10:25:34 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803221022480.3020@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221021220.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank <streamlake@tiscali.it>, Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 18:27:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd7Um-0003Cd-W4
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 18:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbYCVR0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 13:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753735AbYCVR0W
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 13:26:22 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50390 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753641AbYCVR0U (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Mar 2008 13:26:20 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MHPZcq001944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 22 Mar 2008 10:25:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MHPYug019366;
	Sat, 22 Mar 2008 10:25:34 -0700
In-Reply-To: <alpine.LFD.1.00.0803221021220.3020@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.756 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77829>


From: Linus Torvalds <torvalds@woody.linux-foundation.org>
Date: Fri, 21 Mar 2008 13:16:24 -0700

It's really totally separate functionality, and if we want to start
doing case-insensitive hash lookups, I'd rather do it when it's
separated out.

It also renames "remove_index_entry()" to "remove_name_hash()", because 
that really describes the thing better. It doesn't actually remove the 
index entry, that's done by "remove_index_entry_at()", which is something 
very different, despite the similarity in names.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This makes no code changes what-so-ever apart from the movement/renaming, 
just moves things around a bit, and makes a function that used to be 
static (add_name_hash()) be exported because it's now in a different file.

 Makefile            |    1 +
 builtin-read-tree.c |    2 +-
 cache.h             |   31 ++++++++++++----------
 name-hash.c         |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 read-cache.c        |   65 ++-------------------------------------------
 5 files changed, 95 insertions(+), 77 deletions(-)
 create mode 100644 name-hash.c

diff --git a/Makefile b/Makefile
index 7c70b00..6d35662 100644
--- a/Makefile
+++ b/Makefile
@@ -421,6 +421,7 @@ LIB_OBJS += log-tree.o
 LIB_OBJS += mailmap.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += merge-file.o
+LIB_OBJS += name-hash.o
 LIB_OBJS += object.o
 LIB_OBJS += pack-check.o
 LIB_OBJS += pack-revindex.o
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index e9cfd2b..7ac3088 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -40,7 +40,7 @@ static int read_cache_unmerged(void)
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 		if (ce_stage(ce)) {
-			remove_index_entry(ce);
+			remove_name_hash(ce);
 			if (last && !strcmp(ce->name, last->name))
 				continue;
 			cache_tree_invalidate_path(active_cache_tree, ce->name);
diff --git a/cache.h b/cache.h
index 2a1e7ec..2afc788 100644
--- a/cache.h
+++ b/cache.h
@@ -153,20 +153,6 @@ static inline void copy_cache_entry(struct cache_entry *dst, struct cache_entry
 	dst->ce_flags = (dst->ce_flags & ~CE_STATE_MASK) | state;
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
-static inline void remove_index_entry(struct cache_entry *ce)
-{
-	ce->ce_flags |= CE_UNHASHED;
-}
-
 static inline unsigned create_ce_flags(size_t len, unsigned stage)
 {
 	if (len >= CE_NAMEMASK)
@@ -241,6 +227,23 @@ struct index_state {
 
 extern struct index_state the_index;
 
+/* Name hashing */
+extern void add_name_hash(struct index_state *istate, struct cache_entry *ce);
+/*
+ * We don't actually *remove* it, we can just mark it invalid so that
+ * we won't find it in lookups.
+ *
+ * Not only would we have to search the lists (simple enough), but
+ * we'd also have to rehash other hash buckets in case this makes the
+ * hash bucket empty (common). So it's much better to just mark
+ * it.
+ */
+static inline void remove_name_hash(struct cache_entry *ce)
+{
+	ce->ce_flags |= CE_UNHASHED;
+}
+
+
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
 #define active_cache (the_index.cache)
 #define active_nr (the_index.cache_nr)
diff --git a/name-hash.c b/name-hash.c
new file mode 100644
index 0000000..e56eb16
--- /dev/null
+++ b/name-hash.c
@@ -0,0 +1,73 @@
+/*
+ * name-hash.c
+ *
+ * Hashing names in the index state
+ *
+ * Copyright (C) 2008 Linus Torvalds
+ */
+#define NO_THE_INDEX_COMPATIBILITY_MACROS
+#include "cache.h"
+
+static unsigned int hash_name(const char *name, int namelen)
+{
+	unsigned int hash = 0x123;
+
+	do {
+		unsigned char c = *name++;
+		hash = hash*101 + c;
+	} while (--namelen);
+	return hash;
+}
+
+static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
+{
+	void **pos;
+	unsigned int hash;
+
+	if (ce->ce_flags & CE_HASHED)
+		return;
+	ce->ce_flags |= CE_HASHED;
+	ce->next = NULL;
+	hash = hash_name(ce->name, ce_namelen(ce));
+	pos = insert_hash(hash, ce, &istate->name_hash);
+	if (pos) {
+		ce->next = *pos;
+		*pos = ce;
+	}
+}
+
+static void lazy_init_name_hash(struct index_state *istate)
+{
+	int nr;
+
+	if (istate->name_hash_initialized)
+		return;
+	for (nr = 0; nr < istate->cache_nr; nr++)
+		hash_index_entry(istate, istate->cache[nr]);
+	istate->name_hash_initialized = 1;
+}
+
+void add_name_hash(struct index_state *istate, struct cache_entry *ce)
+{
+	ce->ce_flags &= ~CE_UNHASHED;
+	if (istate->name_hash_initialized)
+		hash_index_entry(istate, ce);
+}
+
+int index_name_exists(struct index_state *istate, const char *name, int namelen)
+{
+	unsigned int hash = hash_name(name, namelen);
+	struct cache_entry *ce;
+
+	lazy_init_name_hash(istate);
+	ce = lookup_hash(hash, &istate->name_hash);
+
+	while (ce) {
+		if (!(ce->ce_flags & CE_UNHASHED)) {
+			if (!cache_name_compare(name, namelen, ce->name, ce->ce_flags))
+				return 1;
+		}
+		ce = ce->next;
+	}
+	return 0;
+}
diff --git a/read-cache.c b/read-cache.c
index a92b25b..5dc998d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -23,80 +23,21 @@
 
 struct index_state the_index;
 
-static unsigned int hash_name(const char *name, int namelen)
-{
-	unsigned int hash = 0x123;
-
-	do {
-		unsigned char c = *name++;
-		hash = hash*101 + c;
-	} while (--namelen);
-	return hash;
-}
-
-static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
-{
-	void **pos;
-	unsigned int hash;
-
-	if (ce->ce_flags & CE_HASHED)
-		return;
-	ce->ce_flags |= CE_HASHED;
-	ce->next = NULL;
-	hash = hash_name(ce->name, ce_namelen(ce));
-	pos = insert_hash(hash, ce, &istate->name_hash);
-	if (pos) {
-		ce->next = *pos;
-		*pos = ce;
-	}
-}
-
-static void lazy_init_name_hash(struct index_state *istate)
-{
-	int nr;
-
-	if (istate->name_hash_initialized)
-		return;
-	for (nr = 0; nr < istate->cache_nr; nr++)
-		hash_index_entry(istate, istate->cache[nr]);
-	istate->name_hash_initialized = 1;
-}
-
 static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
 {
-	ce->ce_flags &= ~CE_UNHASHED;
 	istate->cache[nr] = ce;
-	if (istate->name_hash_initialized)
-		hash_index_entry(istate, ce);
+	add_name_hash(istate, ce);
 }
 
 static void replace_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
 {
 	struct cache_entry *old = istate->cache[nr];
 
-	remove_index_entry(old);
+	remove_name_hash(old);
 	set_index_entry(istate, nr, ce);
 	istate->cache_changed = 1;
 }
 
-int index_name_exists(struct index_state *istate, const char *name, int namelen)
-{
-	unsigned int hash = hash_name(name, namelen);
-	struct cache_entry *ce;
-
-	lazy_init_name_hash(istate);
-	ce = lookup_hash(hash, &istate->name_hash);
-
-	while (ce) {
-		if (!(ce->ce_flags & CE_UNHASHED)) {
-			if (!cache_name_compare(name, namelen, ce->name, ce->ce_flags))
-				return 1;
-		}
-		ce = ce->next;
-	}
-	return 0;
-}
-
 /*
  * This only updates the "non-critical" parts of the directory
  * cache, ie the parts that aren't tracked by GIT, and only used
@@ -438,7 +379,7 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 {
 	struct cache_entry *ce = istate->cache[pos];
 
-	remove_index_entry(ce);
+	remove_name_hash(ce);
 	istate->cache_changed = 1;
 	istate->cache_nr--;
 	if (pos >= istate->cache_nr)
-- 
1.5.5.rc0.28.g61a0.dirty
