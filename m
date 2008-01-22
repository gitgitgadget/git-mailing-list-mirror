From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: I'm a total push-over..
Date: Tue, 22 Jan 2008 15:37:30 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 00:38:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHShQ-000576-98
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 00:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756578AbYAVXh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 18:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754578AbYAVXh7
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 18:37:59 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42815 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754654AbYAVXh5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 18:37:57 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0MNbVYS007365
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Jan 2008 15:37:32 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0MNbUiY013557;
	Tue, 22 Jan 2008 15:37:30 -0800
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.823 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_33,J_CHICKENPOX_64,J_CHICKENPOX_66,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71478>


Ok, here's an interesting patch based on the current 'next' (since it very 
intimately requires the new in-memory index format).

What it does is to create a hash index of every single file added to the 
index. Right now that hash index isn't actually used for much: I 
implemented a "cache_name_exists()" function that uses it to efficiently 
look up a filename in the index without having to do the O(logn) binary 
search, but quite frankly, that's not why this patch is interesting.

No, the whole and only reason to create the hash of the filenames in the 
index is that by modifying the hash function, you can fairly easily do 
things like making it always hash equivalent names into the same bucket. 

That, in turn, means that suddenly questions like "does this name exists 
in the index under an _equivalent_ name?" becomes much much cheaper.

Guiding principles behind this patch:

 - it shouldn't be too costly. In fact, my primary goal here was to 
   actually speed up "git commit" with a fully populated kernel tree, by 
   being faster at checking whether a file already existed in the index. I 
   did succeed, but only barely:

	Best before:
		[torvalds@woody linux]$ time git commit > /dev/null
		real    0m0.255s
		user    0m0.168s
		sys     0m0.088s

	Best after:

		[torvalds@woody linux]$ time ~/git/git commit > /dev/null
		real    0m0.233s
		user    0m0.144s
		sys     0m0.088s

   so some things are actually faster (~8%).

   Caveat: that's really the best case. Other things are invariably going 
   to be slightly slower, since we populate that index cache, and quite 
   frankly, few things really use it to look things up. 

   That said, the cost is really quite small. The worst case is probably 
   doing a "git ls-files", which will do very little except puopulate the 
   index, and never actually looks anything up in it, just lists it.

	Before:
		[torvalds@woody linux]$ time git ls-files > /dev/null
		real    0m0.016s
		user    0m0.016s
		sys     0m0.000s

	After:
		[torvalds@woody linux]$ time ~/git/git ls-files > /dev/null
			real    0m0.021s
			user    0m0.012s
			sys     0m0.008s

   and while the thing has really gotten relatively much slower, we're 
   still talking about something almost unmeasurable (eg 5ms). And that 
   really should be pretty much the worst case.

   So we lose 5ms on one "benchmark", but win 22ms on another. Pick your 
   poison - this patch has the advantage that it will _likely_ speed up 
   the cases that are complex and expensive more than it slows down the 
   cases that are already so fast that nobody cares. But if you look at
   relative speedups/slowdowns, it doesn't look so good.

 - It should be simple and clean

   The code may be a bit subtle (the reasons I do hash removal the way I 
   do etc), but it re-uses the existing hash.c files, so it really is 
   fairly small and straightforward apart from a few odd details.

Now, this patch on its own doesn't really do much, but I think it's worth 
looking at, if only because if done correctly, the name hashing really can 
make an improvement to the whole issue of "do we have a filename that 
looks like this in the index already". And at least it gets real testing 
by being used even by default (ie there is a real use-case for it even 
without any insane filesystems).

NOTE NOTE NOTE! The current hash is a joke. I'm ashamed of it, I'm just 
not ashamed of it enough to really care. I took all the numbers out of my 
nether regions - I'm sure it's good enough that it works in practice, but 
the whole point was that you can make a really much fancier hash that 
hashes characters not directly, but by their upper-case value or something 
like that, and thus you get a case-insensitive hash, while still keeping 
the name and the index itself totally case sensitive.

And let's face it, it was kind of fun. These things are all _soo_ much 
simpler than all the issues you have to do in the kernel, so this is just 
a complete toy compared to all the things we do inside Linux to do the 
same thing with pluggable hashes on a per-path-component basis etc.

(User space developers are weenies. One of the most fun parts of git 
development for me has been how easy everything is ;)

		Linus

----
 cache.h      |    6 +++
 dir.c        |    2 +-
 read-cache.c |   97 ++++++++++++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 94 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index 3a47cdc..409738c 100644
--- a/cache.h
+++ b/cache.h
@@ -3,6 +3,7 @@
 
 #include "git-compat-util.h"
 #include "strbuf.h"
+#include "hash.h"
 
 #include SHA1_HEADER
 #include <zlib.h>
@@ -109,6 +110,7 @@ struct ondisk_cache_entry {
 };
 
 struct cache_entry {
+	struct cache_entry *next;
 	unsigned int ce_ctime;
 	unsigned int ce_mtime;
 	unsigned int ce_dev;
@@ -131,6 +133,7 @@ struct cache_entry {
 #define CE_UPDATE    (0x10000)
 #define CE_REMOVE    (0x20000)
 #define CE_UPTODATE  (0x40000)
+#define CE_UNHASHED  (0x80000)
 
 static inline unsigned create_ce_flags(size_t len, unsigned stage)
 {
@@ -188,6 +191,7 @@ struct index_state {
 	struct cache_tree *cache_tree;
 	time_t timestamp;
 	void *alloc;
+	struct hash_table name_hash;
 };
 
 extern struct index_state the_index;
@@ -211,6 +215,7 @@ extern struct index_state the_index;
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
+#define cache_name_exists(name, namelen) index_name_exists(&the_index, (name), (namelen))
 #endif
 
 enum object_type {
@@ -297,6 +302,7 @@ extern int read_index_from(struct index_state *, const char *path);
 extern int write_index(struct index_state *, int newfd);
 extern int discard_index(struct index_state *);
 extern int verify_path(const char *path);
+extern int index_name_exists(struct index_state *istate, const char *name, int namelen);
 extern int index_name_pos(struct index_state *, const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
diff --git a/dir.c b/dir.c
index 1b9cc7a..6543105 100644
--- a/dir.c
+++ b/dir.c
@@ -346,7 +346,7 @@ static struct dir_entry *dir_entry_new(const char *pathname, int len)
 
 struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
 {
-	if (cache_name_pos(pathname, len) >= 0)
+	if (cache_name_exists(pathname, len))
 		return NULL;
 
 	ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
diff --git a/read-cache.c b/read-cache.c
index 8ba8f0f..33a8ca5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -23,6 +23,70 @@
 
 struct index_state the_index;
 
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
+static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
+{
+	void **pos;
+	unsigned int hash = hash_name(ce->name, ce_namelen(ce));
+
+	istate->cache[nr] = ce;
+	pos = insert_hash(hash, ce, &istate->name_hash);
+	if (pos) {
+		ce->next = *pos;
+		*pos = ce;
+	}
+}
+
+/*
+ * We don't actually *remove* it, we can just mark it invalid so that
+ * we won't find it in lookups.
+ *
+ * Not only would we have to search the lists (simple enough), but
+ * we'd also have to rehash other hash buckets in case this makes the
+ * hash bucket empty (common). So it's much better to just mark
+ * it.
+ */
+static void remove_hash_entry(struct index_state *istate, struct cache_entry *ce)
+{
+	ce->ce_flags |= CE_UNHASHED;
+}
+
+static void replace_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
+{
+	struct cache_entry *old = istate->cache[nr];
+
+	if (ce != old) {
+		remove_hash_entry(istate, old);
+		set_index_entry(istate, nr, ce);
+	}
+	istate->cache_changed = 1;
+}
+
+int index_name_exists(struct index_state *istate, const char *name, int namelen)
+{
+	unsigned int hash = hash_name(name, namelen);
+	struct cache_entry *ce = lookup_hash(hash, &istate->name_hash);
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
+
 /*
  * This only updates the "non-critical" parts of the directory
  * cache, ie the parts that aren't tracked by GIT, and only used
@@ -323,6 +387,9 @@ int index_name_pos(struct index_state *istate, const char *name, int namelen)
 /* Remove entry, return true if there are more entries to go.. */
 int remove_index_entry_at(struct index_state *istate, int pos)
 {
+	struct cache_entry *ce = istate->cache[pos];
+
+	remove_hash_entry(istate, ce);
 	istate->cache_changed = 1;
 	istate->cache_nr--;
 	if (pos >= istate->cache_nr)
@@ -697,8 +764,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 
 	/* existing match? Just replace it. */
 	if (pos >= 0) {
-		istate->cache_changed = 1;
-		istate->cache[pos] = ce;
+		replace_index_entry(istate, pos, ce);
 		return 0;
 	}
 	pos = -pos-1;
@@ -758,7 +824,7 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
 		memmove(istate->cache + pos + 1,
 			istate->cache + pos,
 			(istate->cache_nr - pos - 1) * sizeof(ce));
-	istate->cache[pos] = ce;
+	set_index_entry(istate, pos, ce);
 	istate->cache_changed = 1;
 	return 0;
 }
@@ -887,11 +953,8 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 			has_errors = 1;
 			continue;
 		}
-		istate->cache_changed = 1;
-		/* You can NOT just free istate->cache[i] here, since it
-		 * might not be necessarily malloc()ed but can also come
-		 * from mmap(). */
-		istate->cache[i] = new;
+
+		replace_index_entry(istate, i, new);
 	}
 	return has_errors;
 }
@@ -966,6 +1029,20 @@ static void convert_from_disk(struct ondisk_cache_entry *ondisk, struct cache_en
 	memcpy(ce->name, ondisk->name, len + 1);
 }
 
+static inline size_t estimate_cache_size(size_t ondisk_size, unsigned int entries)
+{
+	long per_entry;
+
+	per_entry = sizeof(struct cache_entry) - sizeof(struct ondisk_cache_entry);
+
+	/*
+	 * Alignment can cause differences. This should be "alignof", but 
+	 * since that's a gcc'ism, just use the size of a pointer.
+	 */
+	per_entry += sizeof(void *);
+	return ondisk_size + entries*per_entry;
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int read_index_from(struct index_state *istate, const char *path)
 {
@@ -1016,7 +1093,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	 * has room for a few  more flags, we can allocate using the same
 	 * index size
 	 */
-	istate->alloc = xmalloc(mmap_size);
+	istate->alloc = xmalloc(estimate_cache_size(mmap_size, istate->cache_nr));
 
 	src_offset = sizeof(*hdr);
 	dst_offset = 0;
@@ -1027,7 +1104,7 @@ int read_index_from(struct index_state *istate, const char *path)
 		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
 		ce = (struct cache_entry *)((char *)istate->alloc + dst_offset);
 		convert_from_disk(disk_ce, ce);
-		istate->cache[i] = ce;
+		set_index_entry(istate, i, ce);
 
 		src_offset += ondisk_ce_size(ce);
 		dst_offset += ce_size(ce);
