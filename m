From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug] Segfault in git status
Date: Mon, 18 Feb 2008 17:26:09 -0800
Message-ID: <7vfxvpn3da.fsf@gitster.siamese.dyndns.org>
References: <F8D3F7F0-3A98-4576-BD89-6E5C682B351C@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dane Jensen <careo@fastmail.fm>
X-From: git-owner@vger.kernel.org Tue Feb 19 02:27:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRHGV-0003w6-BD
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 02:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772AbYBSB0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 20:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754393AbYBSB0s
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 20:26:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42758 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbYBSB0r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 20:26:47 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CD1AF412F;
	Mon, 18 Feb 2008 20:26:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 7C8B6412E; Mon, 18 Feb 2008 20:26:41 -0500 (EST)
In-Reply-To: <F8D3F7F0-3A98-4576-BD89-6E5C682B351C@fastmail.fm> (Dane
 Jensen's message of "Mon, 18 Feb 2008 00:36:52 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74364>

Dane Jensen <careo@fastmail.fm> writes:

> This was in OS X 10.5.2 with git compiled from cf5c51e. Falling back
> to 1.5.4.2 cleared it up, so with the help of git bisect I've narrowed
> the bug down to cf55870.

Do you have this issue only on OSX?  Do you have the issue on
any commit, or a particular commit?

What does the change between HEAD, index and the work tree
involve in the commit that causes the problem?  Can you make
repository available to the public for diagnosis (if it is "Only
on OSX", I may not be able to help much with, but never hurt to
ask)?

Just to double check, can you see if reverting the commit (and
another commit that immediately follows) fixes the issue for
you?

A patch to do the revert for cf5c51e is attached.

---

 cache.h      |    7 ---
 dir.c        |    2 +-
 read-cache.c |  118 +++++-----------------------------------------------------
 3 files changed, 11 insertions(+), 116 deletions(-)

diff --git a/cache.h b/cache.h
index e1000bc..fd7716c 100644
--- a/cache.h
+++ b/cache.h
@@ -3,7 +3,6 @@
 
 #include "git-compat-util.h"
 #include "strbuf.h"
-#include "hash.h"
 
 #include SHA1_HEADER
 #include <zlib.h>
@@ -110,7 +109,6 @@ struct ondisk_cache_entry {
 };
 
 struct cache_entry {
-	struct cache_entry *next;
 	unsigned int ce_ctime;
 	unsigned int ce_mtime;
 	unsigned int ce_dev;
@@ -133,7 +131,6 @@ struct cache_entry {
 #define CE_UPDATE    (0x10000)
 #define CE_REMOVE    (0x20000)
 #define CE_UPTODATE  (0x40000)
-#define CE_UNHASHED  (0x80000)
 
 static inline unsigned create_ce_flags(size_t len, unsigned stage)
 {
@@ -203,8 +200,6 @@ struct index_state {
 	struct cache_tree *cache_tree;
 	time_t timestamp;
 	void *alloc;
-	unsigned name_hash_initialized : 1;
-	struct hash_table name_hash;
 };
 
 extern struct index_state the_index;
@@ -228,7 +223,6 @@ extern struct index_state the_index;
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
-#define cache_name_exists(name, namelen) index_name_exists(&the_index, (name), (namelen))
 #endif
 
 enum object_type {
@@ -315,7 +309,6 @@ extern int read_index_from(struct index_state *, const char *path);
 extern int write_index(struct index_state *, int newfd);
 extern int discard_index(struct index_state *);
 extern int verify_path(const char *path);
-extern int index_name_exists(struct index_state *istate, const char *name, int namelen);
 extern int index_name_pos(struct index_state *, const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
diff --git a/dir.c b/dir.c
index 1f507da..4d20871 100644
--- a/dir.c
+++ b/dir.c
@@ -371,7 +371,7 @@ static struct dir_entry *dir_entry_new(const char *pathname, int len)
 
 struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
 {
-	if (cache_name_exists(pathname, len))
+	if (cache_name_pos(pathname, len) >= 0)
 		return NULL;
 
 	ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
diff --git a/read-cache.c b/read-cache.c
index e45f4b3..07abd5d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -23,90 +23,6 @@
 
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
-	unsigned int hash = hash_name(ce->name, ce_namelen(ce));
-
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
-static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
-{
-	istate->cache[nr] = ce;
-	if (istate->name_hash_initialized)
-		hash_index_entry(istate, ce);
-}
-
-/*
- * We don't actually *remove* it, we can just mark it invalid so that
- * we won't find it in lookups.
- *
- * Not only would we have to search the lists (simple enough), but
- * we'd also have to rehash other hash buckets in case this makes the
- * hash bucket empty (common). So it's much better to just mark
- * it.
- */
-static void remove_hash_entry(struct index_state *istate, struct cache_entry *ce)
-{
-	ce->ce_flags |= CE_UNHASHED;
-}
-
-static void replace_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
-{
-	struct cache_entry *old = istate->cache[nr];
-
-	if (ce != old) {
-		remove_hash_entry(istate, old);
-		set_index_entry(istate, nr, ce);
-	}
-	istate->cache_changed = 1;
-}
-
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
@@ -411,9 +327,6 @@ int index_name_pos(struct index_state *istate, const char *name, int namelen)
 /* Remove entry, return true if there are more entries to go.. */
 int remove_index_entry_at(struct index_state *istate, int pos)
 {
-	struct cache_entry *ce = istate->cache[pos];
-
-	remove_hash_entry(istate, ce);
 	istate->cache_changed = 1;
 	istate->cache_nr--;
 	if (pos >= istate->cache_nr)
@@ -789,7 +702,8 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 
 	/* existing match? Just replace it. */
 	if (pos >= 0) {
-		replace_index_entry(istate, pos, ce);
+		istate->cache_changed = 1;
+		istate->cache[pos] = ce;
 		return 0;
 	}
 	pos = -pos-1;
@@ -849,7 +763,7 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
 		memmove(istate->cache + pos + 1,
 			istate->cache + pos,
 			(istate->cache_nr - pos - 1) * sizeof(ce));
-	set_index_entry(istate, pos, ce);
+	istate->cache[pos] = ce;
 	istate->cache_changed = 1;
 	return 0;
 }
@@ -978,8 +892,11 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 			has_errors = 1;
 			continue;
 		}
-
-		replace_index_entry(istate, i, new);
+		istate->cache_changed = 1;
+		/* You can NOT just free istate->cache[i] here, since it
+		 * might not be necessarily malloc()ed but can also come
+		 * from mmap(). */
+		istate->cache[i] = new;
 	}
 	return has_errors;
 }
@@ -1054,20 +971,6 @@ static void convert_from_disk(struct ondisk_cache_entry *ondisk, struct cache_en
 	memcpy(ce->name, ondisk->name, len + 1);
 }
 
-static inline size_t estimate_cache_size(size_t ondisk_size, unsigned int entries)
-{
-	long per_entry;
-
-	per_entry = sizeof(struct cache_entry) - sizeof(struct ondisk_cache_entry);
-
-	/*
-	 * Alignment can cause differences. This should be "alignof", but
-	 * since that's a gcc'ism, just use the size of a pointer.
-	 */
-	per_entry += sizeof(void *);
-	return ondisk_size + entries*per_entry;
-}
-
 /* remember to discard_cache() before reading a different cache! */
 int read_index_from(struct index_state *istate, const char *path)
 {
@@ -1118,7 +1021,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	 * has room for a few  more flags, we can allocate using the same
 	 * index size
 	 */
-	istate->alloc = xmalloc(estimate_cache_size(mmap_size, istate->cache_nr));
+	istate->alloc = xmalloc(mmap_size);
 
 	src_offset = sizeof(*hdr);
 	dst_offset = 0;
@@ -1129,7 +1032,7 @@ int read_index_from(struct index_state *istate, const char *path)
 		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
 		ce = (struct cache_entry *)((char *)istate->alloc + dst_offset);
 		convert_from_disk(disk_ce, ce);
-		set_index_entry(istate, i, ce);
+		istate->cache[i] = ce;
 
 		src_offset += ondisk_ce_size(ce);
 		dst_offset += ce_size(ce);
@@ -1167,7 +1070,6 @@ int discard_index(struct index_state *istate)
 	istate->cache_nr = 0;
 	istate->cache_changed = 0;
 	istate->timestamp = 0;
-	free_hash(&istate->name_hash);
 	cache_tree_free(&(istate->cache_tree));
 	free(istate->alloc);
 	istate->alloc = NULL;
