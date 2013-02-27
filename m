From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2] name-hash.c: fix endless loop with core.ignorecase=true
Date: Thu, 28 Feb 2013 00:57:48 +0100
Message-ID: <512E9D7C.2030803@gmail.com>
References: <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com> <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com> <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com> <20130210111732.GA24377@lanh> <CABPQNSZ282Lre=sy-+ZQdJA9JnGqQguq2bQDOwvjb0fP+1-w8Q@mail.gmail.com> <CACsJy8AWyJ=dW5f44huWyPPe4X62xyi+R9CNM5Tg6u6TYf+thQ@mail.gmail.com> <511AAA92.4030508@gmail.com> <CACsJy8C=2xKcsby048WWCFNhgKObGwrzeCOJPVVqgj88AfSHQw@mail.gmail.com> <20130213181851.GA5603@sigill.intra.peff.net> <511BF6D7.3030404@gmail.com> <20130213225529.GA25353@sigill.intra.peff.net> <511C3454.6080204@gmail.com> <512E1C0F.3050506@gmail.com> <7v621dk8aa.fsf@alter.siamese.dyndns.org> <512E8014.3090107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	kusmabite@gmail.com, Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 01:00:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAqt4-0002dW-Nm
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 00:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757661Ab3B0X5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 18:57:48 -0500
Received: from mail-ee0-f51.google.com ([74.125.83.51]:37295 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab3B0X5r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 18:57:47 -0500
Received: by mail-ee0-f51.google.com with SMTP id d17so968836eek.10
        for <git@vger.kernel.org>; Wed, 27 Feb 2013 15:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=i2FjTi/HNaaE//j7DJlEtajtaSLEFe/ezgMkxMPTtlQ=;
        b=iEg7rTzUZN93sGk4CuuXDxSOsGU6y80VNjdch9uN2NU0+lDaA735KG5tRUdCTYJtTE
         E8D95GQ1w84aFRDKcH8a4CaPxTDSE0pFwjUdL/m7KC8pgtVEW+MA4JPmWmOoc6S/MxAW
         4VgQRxF6YV2oB0DaZCuMfB8ApP0c3EkhYttl6MPi87aY2q/yarUAhixDBvyUIZP3txjM
         ANkoocB52SpQekLxz+XestBlwfDdIKYxMsXqx4wr7GFEU2vqaLpDp7YnXoacQKaJ1Yew
         z4hhv/k6Q/ksJxhBOeEYBILewDdc0qxvIRYahMB0ioXBtXj6263nG6n2Jjx6cxIdbjSz
         8hUA==
X-Received: by 10.14.216.2 with SMTP id f2mr10718948eep.44.1362009466503;
        Wed, 27 Feb 2013 15:57:46 -0800 (PST)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id s3sm8926432eem.4.2013.02.27.15.57.44
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 27 Feb 2013 15:57:45 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <512E8014.3090107@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217228>

With core.ignorecase=true, name-hash.c builds a case insensitive index of
all tracked directories. Currently, the existing cache entry structures are
added multiple times to the same hashtable (with different name lengths and
hash codes). However, there's only one dir_next pointer, which gets
completely messed up in case of hash collisions. In the worst case, this
causes an endless loop if ce == ce->dir_next (see t7062).

Use a separate hashtable and separate structures for the directory index
so that each directory entry has its own next pointer. Use reference
counting to track which directory entry contains files.

There are only slight changes to the name-hash.c API:
- new free_name_hash() used by read_cache.c::discard_index()
- remove_name_hash() takes an additional index_state parameter
- index_name_exists() for a directory (trailing '/') may return a cache
  entry that has been removed (CE_UNHASHED). This is not a problem as the
  return value is only used to check if the directory exists (dir.c) or to
  normalize casing of directory names (read-cache.c).

Getting rid of cache_entry.dir_next reduces memory consumption, especially
with core.ignorecase=false (which doesn't use that member at all).

With core.ignorecase=true, building the directory index is slightly faster
as we add / check the parent directory first (instead of going through all
directory levels for each file in the index). E.g. with WebKit (~200k
files, ~7k dirs), time spent in lazy_init_name_hash is reduced from 176ms
to 130ms.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
Also available here:
https://github.com/kblees/git/tree/kb/name-hash-fix-endless-loop-v2
git pull git://github.com/kblees/git.git kb/name-hash-fix-endless-loop-v2

 cache.h                        |  17 +---
 name-hash.c                    | 182 +++++++++++++++++++++++++++++++----------
 read-cache.c                   |   9 +-
 t/t7062-wtstatus-ignorecase.sh |  20 +++++
 4 files changed, 166 insertions(+), 62 deletions(-)
 create mode 100755 t/t7062-wtstatus-ignorecase.sh

diff --git a/cache.h b/cache.h
index e493563..898e346 100644
--- a/cache.h
+++ b/cache.h
@@ -131,7 +131,6 @@ struct cache_entry {
 	unsigned int ce_namelen;
 	unsigned char sha1[20];
 	struct cache_entry *next;
-	struct cache_entry *dir_next;
 	char name[FLEX_ARRAY]; /* more */
 };
 
@@ -267,25 +266,15 @@ struct index_state {
 	unsigned name_hash_initialized : 1,
 		 initialized : 1;
 	struct hash_table name_hash;
+	struct hash_table dir_hash;
 };
 
 extern struct index_state the_index;
 
 /* Name hashing */
 extern void add_name_hash(struct index_state *istate, struct cache_entry *ce);
-/*
- * We don't actually *remove* it, we can just mark it invalid so that
- * we won't find it in lookups.
- *
- * Not only would we have to search the lists (simple enough), but
- * we'd also have to rehash other hash buckets in case this makes the
- * hash bucket empty (common). So it's much better to just mark
- * it.
- */
-static inline void remove_name_hash(struct cache_entry *ce)
-{
-	ce->ce_flags |= CE_UNHASHED;
-}
+extern void remove_name_hash(struct index_state *istate, struct cache_entry *ce);
+extern void free_name_hash(struct index_state *istate);
 
 
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
diff --git a/name-hash.c b/name-hash.c
index 942c459..6d7e198 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -32,38 +32,96 @@ static unsigned int hash_name(const char *name, int namelen)
 	return hash;
 }
 
-static void hash_index_entry_directories(struct index_state *istate, struct cache_entry *ce)
+struct dir_entry {
+	struct dir_entry *next;
+	struct dir_entry *parent;
+	struct cache_entry *ce;
+	int nr;
+	unsigned int namelen;
+};
+
+static struct dir_entry *find_dir_entry(struct index_state *istate,
+		const char *name, unsigned int namelen)
+{
+	unsigned int hash = hash_name(name, namelen);
+	struct dir_entry *dir;
+
+	for (dir = lookup_hash(hash, &istate->dir_hash); dir; dir = dir->next)
+		if (dir->namelen == namelen &&
+		    !strncasecmp(dir->ce->name, name, namelen))
+			return dir;
+	return NULL;
+}
+
+static struct dir_entry *hash_dir_entry(struct index_state *istate,
+		struct cache_entry *ce, int namelen)
 {
 	/*
 	 * Throw each directory component in the hash for quick lookup
 	 * during a git status. Directory components are stored with their
 	 * closing slash.  Despite submodules being a directory, they never
 	 * reach this point, because they are stored without a closing slash
-	 * in the cache.
+	 * in index_state.name_hash (as ordinary cache_entries).
 	 *
-	 * Note that the cache_entry stored with the directory does not
-	 * represent the directory itself.  It is a pointer to an existing
-	 * filename, and its only purpose is to represent existence of the
-	 * directory in the cache.  It is very possible multiple directory
-	 * hash entries may point to the same cache_entry.
+	 * Note that the cache_entry stored with the dir_entry merely
+	 * supplies the name of the directory (up to dir_entry.namelen). We
+	 * track the number of 'active' files in a directory in dir_entry.nr,
+	 * so we can tell if the directory is still relevant, e.g. for git
+	 * status. However, if cache_entries are removed, we cannot pinpoint
+	 * an exact cache_entry that's still active. It is very possible that
+	 * multiple dir_entries point to the same cache_entry.
 	 */
-	unsigned int hash;
-	void **pos;
+	struct dir_entry *dir;
+
+	/* get length of parent directory */
+	while (namelen > 0 && !is_dir_sep(ce->name[namelen - 1]))
+		namelen--;
+	if (namelen <= 0)
+		return NULL;
+
+	/* lookup existing entry for that directory */
+	dir = find_dir_entry(istate, ce->name, namelen);
+	if (!dir) {
+		/* not found, create it and add to hash table */
+		void **pdir;
+		unsigned int hash = hash_name(ce->name, namelen);
 
-	const char *ptr = ce->name;
-	while (*ptr) {
-		while (*ptr && *ptr != '/')
-			++ptr;
-		if (*ptr == '/') {
-			++ptr;
-			hash = hash_name(ce->name, ptr - ce->name);
-			pos = insert_hash(hash, ce, &istate->name_hash);
-			if (pos) {
-				ce->dir_next = *pos;
-				*pos = ce;
-			}
+		dir = xcalloc(1, sizeof(struct dir_entry));
+		dir->namelen = namelen;
+		dir->ce = ce;
+
+		pdir = insert_hash(hash, dir, &istate->dir_hash);
+		if (pdir) {
+			dir->next = *pdir;
+			*pdir = dir;
 		}
+
+		/* recursively add missing parent directories */
+		dir->parent = hash_dir_entry(istate, ce, namelen - 1);
 	}
+	return dir;
+}
+
+static void add_dir_entry(struct index_state *istate, struct cache_entry *ce)
+{
+	/* Add reference to the directory entry (and parents if 0). */
+	struct dir_entry *dir = hash_dir_entry(istate, ce, ce_namelen(ce));
+	while (dir && !(dir->nr++))
+		dir = dir->parent;
+}
+
+static void remove_dir_entry(struct index_state *istate, struct cache_entry *ce)
+{
+	/*
+	 * Release reference to the directory entry (and parents if 0).
+	 *
+	 * Note: we do not remove / free the entry because there's no
+	 * hash.[ch]::remove_hash and dir->next may point to other entries
+	 * that are still valid, so we must not free the memory.
+	 */
+	struct dir_entry *dir = hash_dir_entry(istate, ce, ce_namelen(ce));
+	while (dir && dir->nr && !(--dir->nr))
+		dir = dir->parent;
 }
 
 static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
@@ -74,7 +132,7 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 	if (ce->ce_flags & CE_HASHED)
 		return;
 	ce->ce_flags |= CE_HASHED;
-	ce->next = ce->dir_next = NULL;
+	ce->next = NULL;
 	hash = hash_name(ce->name, ce_namelen(ce));
 	pos = insert_hash(hash, ce, &istate->name_hash);
 	if (pos) {
@@ -82,8 +140,8 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 		*pos = ce;
 	}
 
-	if (ignore_case)
-		hash_index_entry_directories(istate, ce);
+	if (ignore_case && !(ce->ce_flags & CE_UNHASHED))
+		add_dir_entry(istate, ce);
 }
 
 static void lazy_init_name_hash(struct index_state *istate)
@@ -99,11 +157,33 @@ static void lazy_init_name_hash(struct index_state *istate)
 
 void add_name_hash(struct index_state *istate, struct cache_entry *ce)
 {
+	/* if already hashed, add reference to directory entries */
+	if (ignore_case && (ce->ce_flags & CE_STATE_MASK) == CE_STATE_MASK)
+		add_dir_entry(istate, ce);
+
 	ce->ce_flags &= ~CE_UNHASHED;
 	if (istate->name_hash_initialized)
 		hash_index_entry(istate, ce);
 }
 
+/*
+ * We don't actually *remove* it, we can just mark it invalid so that
+ * we won't find it in lookups.
+ *
+ * Not only would we have to search the lists (simple enough), but
+ * we'd also have to rehash other hash buckets in case this makes the
+ * hash bucket empty (common). So it's much better to just mark
+ * it.
+ */
+void remove_name_hash(struct index_state *istate, struct cache_entry *ce)
+{
+	/* if already hashed, release reference to directory entries */
+	if (ignore_case && (ce->ce_flags & CE_STATE_MASK) == CE_HASHED)
+		remove_dir_entry(istate, ce);
+
+	ce->ce_flags |= CE_UNHASHED;
+}
+
 static int slow_same_name(const char *name1, int len1, const char *name2, int len2)
 {
 	if (len1 != len2)
@@ -137,18 +217,7 @@ static int same_name(const struct cache_entry *ce, const char *name, int namelen
 	if (!icase)
 		return 0;
 
-	/*
-	 * If the entry we're comparing is a filename (no trailing slash), then compare
-	 * the lengths exactly.
-	 */
-	if (name[namelen - 1] != '/')
-		return slow_same_name(name, namelen, ce->name, len);
-
-	/*
-	 * For a directory, we point to an arbitrary cache_entry filename.  Just
-	 * make sure the directory portion matches.
-	 */
-	return slow_same_name(name, namelen, ce->name, namelen < len ? namelen : len);
+	return slow_same_name(name, namelen, ce->name, len);
 }
 
 struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int icase)
@@ -164,27 +233,54 @@ struct cache_entry *index_name_exists(struct index_state *istate, const char *na
 			if (same_name(ce, name, namelen, icase))
 				return ce;
 		}
-		if (icase && name[namelen - 1] == '/')
-			ce = ce->dir_next;
-		else
-			ce = ce->next;
+		ce = ce->next;
 	}
 
 	/*
-	 * Might be a submodule.  Despite submodules being directories,
+	 * When looking for a directory (trailing '/'), it might be a
+	 * submodule or a directory. Despite submodules being directories,
 	 * they are stored in the name hash without a closing slash.
-	 * When ignore_case is 1, directories are stored in the name hash
-	 * with their closing slash.
+	 * When ignore_case is 1, directories are stored in a separate hash
+	 * table *with* their closing slash.
 	 *
 	 * The side effect of this storage technique is we have need to
+	 * lookup the directory in a separate hash table, and if not found
 	 * remove the slash from name and perform the lookup again without
 	 * the slash.  If a match is made, S_ISGITLINK(ce->mode) will be
 	 * true.
 	 */
 	if (icase && name[namelen - 1] == '/') {
+		struct dir_entry *dir = find_dir_entry(istate, name, namelen);
+		if (dir && dir->nr)
+			return dir->ce;
+
 		ce = index_name_exists(istate, name, namelen - 1, icase);
 		if (ce && S_ISGITLINK(ce->ce_mode))
 			return ce;
 	}
 	return NULL;
 }
+
+static int free_dir_entry(void *entry, void *unused)
+{
+	struct dir_entry *dir = entry;
+	while (dir) {
+		struct dir_entry *next = dir->next;
+		free(dir);
+		dir = next;
+	}
+	return 0;
+}
+
+void free_name_hash(struct index_state *istate)
+{
+	if (!istate->name_hash_initialized)
+		return;
+	istate->name_hash_initialized = 0;
+	if (ignore_case)
+		/* free directory entries */
+		for_each_hash(&istate->dir_hash, free_dir_entry, NULL);
+
+	free_hash(&istate->name_hash);
+	free_hash(&istate->dir_hash);
+}
diff --git a/read-cache.c b/read-cache.c
index 827ae55..47eb9d8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -46,7 +46,7 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
 {
 	struct cache_entry *old = istate->cache[nr];
 
-	remove_name_hash(old);
+	remove_name_hash(istate, old);
 	set_index_entry(istate, nr, ce);
 	istate->cache_changed = 1;
 }
@@ -460,7 +460,7 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 	struct cache_entry *ce = istate->cache[pos];
 
 	record_resolve_undo(istate, ce);
-	remove_name_hash(ce);
+	remove_name_hash(istate, ce);
 	istate->cache_changed = 1;
 	istate->cache_nr--;
 	if (pos >= istate->cache_nr)
@@ -483,7 +483,7 @@ void remove_marked_cache_entries(struct index_state *istate)
 
 	for (i = j = 0; i < istate->cache_nr; i++) {
 		if (ce_array[i]->ce_flags & CE_REMOVE)
-			remove_name_hash(ce_array[i]);
+			remove_name_hash(istate, ce_array[i]);
 		else
 			ce_array[j++] = ce_array[i];
 	}
@@ -1515,8 +1515,7 @@ int discard_index(struct index_state *istate)
 	istate->cache_changed = 0;
 	istate->timestamp.sec = 0;
 	istate->timestamp.nsec = 0;
-	istate->name_hash_initialized = 0;
-	free_hash(&istate->name_hash);
+	free_name_hash(istate);
 	cache_tree_free(&(istate->cache_tree));
 	istate->initialized = 0;
 
diff --git a/t/t7062-wtstatus-ignorecase.sh b/t/t7062-wtstatus-ignorecase.sh
new file mode 100755
index 0000000..73709db
--- /dev/null
+++ b/t/t7062-wtstatus-ignorecase.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+
+test_description='git-status with core.ignorecase=true'
+
+. ./test-lib.sh
+
+test_expect_success 'status with hash collisions' '
+	# note: "V/", "V/XQANY/" and "WURZAUP/" produce the same hash code
+	# in name-hash.c::hash_name
+	mkdir V &&
+	mkdir V/XQANY &&
+	mkdir WURZAUP &&
+	touch V/XQANY/test &&
+	git config core.ignorecase true &&
+	git add . &&
+	# test is successful if git status completes (no endless loop)
+	git status
+'
+
+test_done
-- 
1.8.1.2.7987.g4a34b82
