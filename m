From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] bug in unpack_trees
Date: Wed, 5 Mar 2008 16:35:39 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0803051613230.12253@woody.linux-foundation.org>
References: <20080304115940.GA5260@sigill.intra.peff.net> <alpine.LFD.1.00.0803041325370.12253@woody.linux-foundation.org> <alpine.LNX.1.00.0803050130190.19665@iabervon.org> <alpine.LFD.1.00.0803050750400.12253@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	John Goerzen <jgoerzen@complete.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 01:37:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX47P-0007N4-Fu
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 01:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932792AbYCFAhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 19:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933595AbYCFAhC
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 19:37:02 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50465 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932339AbYCFAg5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 19:36:57 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m260Zxdj024460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Mar 2008 16:36:01 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m260ZeuP032409;
	Wed, 5 Mar 2008 16:35:40 -0800
In-Reply-To: <alpine.LFD.1.00.0803050750400.12253@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.007 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76301>



On Wed, 5 Mar 2008, Linus Torvalds wrote:
> 
> I'm still working on it, but it's nastier than I was hoping for. Maybe you 
> can come up with a better solution.

Ok, this doesn't actually fix the bug that Jeff found, because I tried 
very hard to make sure it has the exact same behaviour as we used to have, 
but what it does is to re-implement unpack_trees() in terms of 
traverse_trees().

I'm planning on splitting this diff up a bit, but before I do that I 
wanted to send it out to people to look at, to see if somebody can find 
any issues with it.

Quite frankly, I'm not happy about how it adds more lines than it deletes, 
but if you look at the patch, you'll quickly see the reason for why I 
think this is a huge improvement anyway: compare the functions I add to 
the ones I remove.

In particular, I remove the function from hell: unpack_trees_rec() used to 
be this really quite unreadable 206-line monster function with a loop and 
various rather hard to understand non-local behaviours (hands up anybody 
who understands how skip_entry works, or the df_conflict_list thing?).

Yes, I could have tried to just split that one function up, but I wanted 
to also really try to get rid of the whole use of that tree_entry_list, 
and just rewrite it to use an existing tree walker. Of course, I had to 
make the existing tree walker a bit smarter in the process.

The new code isn't exactly simple either, but it tries to be much more 
"local", and while the replacement for unpack_trees_rec() is still 
complicated, it's now split into several smaller functions, but perhaps 
most importantly, the "top-level" function (called "unpack_callback()") 
now just handles unpacking one name at a time.

In short, I think this is an improvement, but it is a fairly big patch, 
and it essentially totally rewrites what used to be one of the most 
complicated functions in git. So maybe there's some bug there, but 
hopefully it's now much more straightforward and less arbitrary.

[ Btw, the complexity is now in another part - it's in the code that 
  compares git pathnames without even linearizing it - see the whole dance 
  in "do_compare_entry()" where we recursively walk the chain of directory 
  traversal entries in order to compare a cache_entry to the name of a 
  directory walk.

  So the number of lines in "unpack-trees.c" actually *does* go down 
  despite the functions being split up - which usually causes more lines 
  rather then fewer - but that decrease in line numbers is more than made 
  up for by the new helper functions to compare and linearize the tree 
  traversal name (setup_traverse_info, make_traverse_path and the afore- 
  mentioned compare_entry).

  Maybe I could have done the tree traversal without that whole change to 
  how we keep track of the base, but I wanted to keep track of some 
  recursive info anyway, so handling the name there in that info structure 
  seemed like a really good idea. ]

Comments?

		Linus

----
 cache.h        |    1 +
 merge-tree.c   |   59 ++++---
 read-cache.c   |   35 ++++
 tree-walk.c    |   72 ++++++--
 tree-walk.h    |   23 ++-
 unpack-trees.c |  530 ++++++++++++++++++++++++++------------------------------
 6 files changed, 394 insertions(+), 326 deletions(-)

diff --git a/cache.h b/cache.h
index e230302..6eb16cb 100644
--- a/cache.h
+++ b/cache.h
@@ -536,6 +536,7 @@ extern int create_symref(const char *ref, const char *refs_heads_master, const c
 extern int validate_headref(const char *ref);
 
 extern int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
+extern int df_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
 extern int cache_name_compare(const char *name1, int len1, const char *name2, int len2);
 
 extern void *read_object_with_reference(const unsigned char *sha1,
diff --git a/merge-tree.c b/merge-tree.c
index e083246..eed0408 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -168,7 +168,13 @@ static struct merge_list *create_entry(unsigned stage, unsigned mode, const unsi
 	return res;
 }
 
-static void resolve(const char *base, struct name_entry *branch1, struct name_entry *result)
+static char *traverse_path(const struct traverse_info *info, const struct name_entry *n)
+{
+	char *path = xmalloc(traverse_path_len(info, n) + 1);
+	return make_traverse_path(path, info, n);
+}
+
+static void resolve(const struct traverse_info *info, struct name_entry *branch1, struct name_entry *result)
 {
 	struct merge_list *orig, *final;
 	const char *path;
@@ -177,7 +183,7 @@ static void resolve(const char *base, struct name_entry *branch1, struct name_en
 	if (!branch1)
 		return;
 
-	path = xstrdup(mkpath("%s%s", base, result->path));
+	path = traverse_path(info, result);
 	orig = create_entry(2, branch1->mode, branch1->sha1, path);
 	final = create_entry(0, result->mode, result->sha1, path);
 
@@ -186,9 +192,8 @@ static void resolve(const char *base, struct name_entry *branch1, struct name_en
 	add_merge_entry(final);
 }
 
-static int unresolved_directory(const char *base, struct name_entry n[3])
+static int unresolved_directory(const struct traverse_info *info, struct name_entry n[3])
 {
-	int baselen, pathlen;
 	char *newbase;
 	struct name_entry *p;
 	struct tree_desc t[3];
@@ -204,13 +209,7 @@ static int unresolved_directory(const char *base, struct name_entry n[3])
 	}
 	if (!S_ISDIR(p->mode))
 		return 0;
-	baselen = strlen(base);
-	pathlen = tree_entry_len(p->path, p->sha1);
-	newbase = xmalloc(baselen + pathlen + 2);
-	memcpy(newbase, base, baselen);
-	memcpy(newbase + baselen, p->path, pathlen);
-	memcpy(newbase + baselen + pathlen, "/", 2);
-
+	newbase = traverse_path(info, p);
 	buf0 = fill_tree_descriptor(t+0, n[0].sha1);
 	buf1 = fill_tree_descriptor(t+1, n[1].sha1);
 	buf2 = fill_tree_descriptor(t+2, n[2].sha1);
@@ -223,8 +222,7 @@ static int unresolved_directory(const char *base, struct name_entry n[3])
 	return 1;
 }
 
-
-static struct merge_list *link_entry(unsigned stage, const char *base, struct name_entry *n, struct merge_list *entry)
+static struct merge_list *link_entry(unsigned stage, const struct traverse_info *info, struct name_entry *n, struct merge_list *entry)
 {
 	const char *path;
 	struct merge_list *link;
@@ -234,17 +232,17 @@ static struct merge_list *link_entry(unsigned stage, const char *base, struct na
 	if (entry)
 		path = entry->path;
 	else
-		path = xstrdup(mkpath("%s%s", base, n->path));
+		path = traverse_path(info, n);
 	link = create_entry(stage, n->mode, n->sha1, path);
 	link->link = entry;
 	return link;
 }
 
-static void unresolved(const char *base, struct name_entry n[3])
+static void unresolved(const struct traverse_info *info, struct name_entry n[3])
 {
 	struct merge_list *entry = NULL;
 
-	if (unresolved_directory(base, n))
+	if (unresolved_directory(info, n))
 		return;
 
 	/*
@@ -252,9 +250,9 @@ static void unresolved(const char *base, struct name_entry n[3])
 	 * list has the stages in order - link_entry adds new
 	 * links at the front.
 	 */
-	entry = link_entry(3, base, n + 2, entry);
-	entry = link_entry(2, base, n + 1, entry);
-	entry = link_entry(1, base, n + 0, entry);
+	entry = link_entry(3, info, n + 2, entry);
+	entry = link_entry(2, info, n + 1, entry);
+	entry = link_entry(1, info, n + 0, entry);
 
 	add_merge_entry(entry);
 }
@@ -288,36 +286,41 @@ static void unresolved(const char *base, struct name_entry n[3])
  * The successful merge rules are the same as for the three-way merge
  * in git-read-tree.
  */
-static void threeway_callback(int n, unsigned long mask, struct name_entry *entry, const char *base)
+static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, struct traverse_info *info)
 {
 	/* Same in both? */
 	if (same_entry(entry+1, entry+2)) {
 		if (entry[0].sha1) {
-			resolve(base, NULL, entry+1);
-			return;
+			resolve(info, NULL, entry+1);
+			return mask;
 		}
 	}
 
 	if (same_entry(entry+0, entry+1)) {
 		if (entry[2].sha1 && !S_ISDIR(entry[2].mode)) {
-			resolve(base, entry+1, entry+2);
-			return;
+			resolve(info, entry+1, entry+2);
+			return mask;
 		}
 	}
 
 	if (same_entry(entry+0, entry+2)) {
 		if (entry[1].sha1 && !S_ISDIR(entry[1].mode)) {
-			resolve(base, NULL, entry+1);
-			return;
+			resolve(info, NULL, entry+1);
+			return mask;
 		}
 	}
 
-	unresolved(base, entry);
+	unresolved(info, entry);
+	return mask;
 }
 
 static void merge_trees(struct tree_desc t[3], const char *base)
 {
-	traverse_trees(3, t, base, threeway_callback);
+	struct traverse_info info;
+
+	setup_traverse_info(&info, base);
+	info.fn = threeway_callback;
+	traverse_trees(3, t, &info);
 }
 
 static void *get_tree_descriptor(struct tree_desc *desc, const char *rev)
diff --git a/read-cache.c b/read-cache.c
index 657f0c5..bf649a3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -351,6 +351,41 @@ int base_name_compare(const char *name1, int len1, int mode1,
 	return (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
 }
 
+/*
+ * df_name_compare() is identical to base_name_compare(), except it
+ * compares conflicting directory/file entries as equal. Note that
+ * while a directory name compares as equal to a regular file, they
+ * then individually compare _differently_ to a filename that has
+ * a dot after the basename (because '\0' < '.' < '/').
+ *
+ * This is used by routines that want to traverse the git namespace
+ * but then handle conflicting entries together when possible.
+ */
+int df_name_compare(const char *name1, int len1, int mode1,
+		    const char *name2, int len2, int mode2)
+{
+	int len = len1 < len2 ? len1 : len2, cmp;
+	unsigned char c1, c2;
+
+	cmp = memcmp(name1, name2, len);
+	if (cmp)
+		return cmp;
+	/* Directories and files compare equal (same length, same name) */
+	if (len1 == len2)
+		return 0;
+	c1 = name1[len];
+	if (!c1 && S_ISDIR(mode1))
+		c1 = '/';
+	c2 = name2[len];
+	if (!c2 && S_ISDIR(mode2))
+		c2 = '/';
+	if (c1 == '/' && !c2)
+		return 0;
+	if (c2 == '/' && !c1)
+		return 0;
+	return c1 - c2;
+}
+
 int cache_name_compare(const char *name1, int flags1, const char *name2, int flags2)
 {
 	int len1 = flags1 & CE_NAMEMASK;
diff --git a/tree-walk.c b/tree-walk.c
index 142205d..5134baf 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -62,9 +62,9 @@ void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1)
 
 static int entry_compare(struct name_entry *a, struct name_entry *b)
 {
-	return base_name_compare(
-			a->path, tree_entry_len(a->path, a->sha1), a->mode,
-			b->path, tree_entry_len(b->path, b->sha1), b->mode);
+	int len1 = tree_entry_len(a->path, a->sha1);
+	int len2 = tree_entry_len(b->path, b->sha1);
+	return df_name_compare(a->path, len1, a->mode, b->path, len2, b->mode);
 }
 
 static void entry_clear(struct name_entry *a)
@@ -104,21 +104,55 @@ int tree_entry(struct tree_desc *desc, struct name_entry *entry)
 	return 1;
 }
 
-void traverse_trees(int n, struct tree_desc *t, const char *base, traverse_callback_t callback)
+void setup_traverse_info(struct traverse_info *info, const char *base)
 {
+	int pathlen = strlen(base);
+
+	memset(info, 0, sizeof(*info));
+	if (pathlen && base[pathlen-1] == '/')
+		pathlen--;
+	info->pathlen = pathlen ? pathlen + 1 : 0;
+	info->name.path = base;
+	info->name.sha1 = (void *)(base + pathlen + 1);
+}
+
+char *make_traverse_path(char *path, const struct traverse_info *info, const struct name_entry *n)
+{
+	int len = tree_entry_len(n->path, n->sha1);
+	int pathlen = info->pathlen;
+
+	path[pathlen + len] = 0;
+	for (;;) {
+		memcpy(path + pathlen, n->path, len);
+		if (!pathlen)
+			break;
+		path[--pathlen] = '/';
+		n = &info->name;
+		len = tree_entry_len(n->path, n->sha1);
+		info = info->prev;
+		pathlen -= len;
+	}
+	return path;
+}
+
+int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
+{
+	int ret = 0;
 	struct name_entry *entry = xmalloc(n*sizeof(*entry));
 
 	for (;;) {
 		unsigned long mask = 0;
+		unsigned long dirmask = 0;
+		struct name_entry *p = entry;
 		int i, last;
 
 		last = -1;
-		for (i = 0; i < n; i++) {
+		for (i = 0; i < n; i++, p++) {
 			if (!t[i].size)
 				continue;
-			entry_extract(t+i, entry+i);
+			entry_extract(t+i, p);
 			if (last >= 0) {
-				int cmp = entry_compare(entry+i, entry+last);
+				int cmp = entry_compare(p, entry+last);
 
 				/*
 				 * Is the new name bigger than the old one?
@@ -130,9 +164,13 @@ void traverse_trees(int n, struct tree_desc *t, const char *base, traverse_callb
 				 * Is the new name smaller than the old one?
 				 * Ignore all old ones
 				 */
-				if (cmp < 0)
+				if (cmp < 0) {
 					mask = 0;
+					dirmask = 0;
+				}
 			}
+			if (S_ISDIR(p->mode))
+				dirmask |= 1ul << i;
 			mask |= 1ul << i;
 			last = i;
 		}
@@ -140,19 +178,25 @@ void traverse_trees(int n, struct tree_desc *t, const char *base, traverse_callb
 			break;
 
 		/*
-		 * Update the tree entries we've walked, and clear
-		 * all the unused name-entries.
+		 * Clear all the unused name-entries.
 		 */
 		for (i = 0; i < n; i++) {
-			if (mask & (1ul << i)) {
-				update_tree_entry(t+i);
+			if (mask & (1ul << i))
 				continue;
-			}
 			entry_clear(entry + i);
 		}
-		callback(n, mask, entry, base);
+		ret = info->fn(n, mask, dirmask, entry, info);
+		if (ret < 0)
+			break;
+		mask = ret;
+		ret = 0;
+		for (i = 0; i < n; i++) {
+			if (mask & (1ul << i))
+				update_tree_entry(t + i);
+		}
 	}
 	free(entry);
+	return ret;
 }
 
 static int find_tree_entry(struct tree_desc *t, const char *name, unsigned char *result, unsigned *mode)
diff --git a/tree-walk.h b/tree-walk.h
index db0fbdc..42110a4 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -33,10 +33,27 @@ int tree_entry(struct tree_desc *, struct name_entry *);
 
 void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1);
 
-typedef void (*traverse_callback_t)(int n, unsigned long mask, struct name_entry *entry, const char *base);
-
-void traverse_trees(int n, struct tree_desc *t, const char *base, traverse_callback_t callback);
+struct traverse_info;
+typedef int (*traverse_callback_t)(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, struct traverse_info *);
+int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info);
+
+struct traverse_info {
+	struct traverse_info *prev;
+	struct name_entry name;
+	int pathlen;
+
+	unsigned long conflicts;
+	traverse_callback_t fn;
+	void *data;
+};
 
 int get_tree_entry(const unsigned char *, const char *, unsigned char *, unsigned *);
+extern char *make_traverse_path(char *path, const struct traverse_info *info, const struct name_entry *n);
+extern void setup_traverse_info(struct traverse_info *info, const char *base);
+
+static inline int traverse_path_len(const struct traverse_info *info, const struct name_entry *n)
+{
+	return info->pathlen + tree_entry_len(n->path, n->sha1);
+}
 
 #endif
diff --git a/unpack-trees.c b/unpack-trees.c
index 3e448d8..ee9be29 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -7,270 +7,12 @@
 #include "progress.h"
 #include "refs.h"
 
-#define DBRT_DEBUG 1
-
-struct tree_entry_list {
-	struct tree_entry_list *next;
-	unsigned int mode;
-	const char *name;
-	const unsigned char *sha1;
-};
-
-static struct tree_entry_list *create_tree_entry_list(struct tree_desc *desc)
-{
-	struct name_entry one;
-	struct tree_entry_list *ret = NULL;
-	struct tree_entry_list **list_p = &ret;
-
-	while (tree_entry(desc, &one)) {
-		struct tree_entry_list *entry;
-
-		entry = xmalloc(sizeof(struct tree_entry_list));
-		entry->name = one.path;
-		entry->sha1 = one.sha1;
-		entry->mode = one.mode;
-		entry->next = NULL;
-
-		*list_p = entry;
-		list_p = &entry->next;
-	}
-	return ret;
-}
-
-static int entcmp(const char *name1, int dir1, const char *name2, int dir2)
-{
-	int len1 = strlen(name1);
-	int len2 = strlen(name2);
-	int len = len1 < len2 ? len1 : len2;
-	int ret = memcmp(name1, name2, len);
-	unsigned char c1, c2;
-	if (ret)
-		return ret;
-	c1 = name1[len];
-	c2 = name2[len];
-	if (!c1 && dir1)
-		c1 = '/';
-	if (!c2 && dir2)
-		c2 = '/';
-	ret = (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
-	if (c1 && c2 && !ret)
-		ret = len1 - len2;
-	return ret;
-}
-
 static inline void remove_entry(int remove)
 {
 	if (remove >= 0)
 		remove_cache_entry_at(remove);
 }
 
-static int unpack_trees_rec(struct tree_entry_list **posns, int len,
-			    const char *base, struct unpack_trees_options *o,
-			    struct tree_entry_list *df_conflict_list)
-{
-	int remove;
-	int baselen = strlen(base);
-	int src_size = len + 1;
-	int retval = 0;
-
-	do {
-		int i;
-		const char *first;
-		int firstdir = 0;
-		int pathlen;
-		unsigned ce_size;
-		struct tree_entry_list **subposns;
-		struct cache_entry **src;
-		int any_files = 0;
-		int any_dirs = 0;
-		char *cache_name;
-		int ce_stage;
-		int skip_entry = 0;
-
-		/* Find the first name in the input. */
-
-		first = NULL;
-		cache_name = NULL;
-
-		/* Check the cache */
-		if (o->merge && o->pos < active_nr) {
-			/* This is a bit tricky: */
-			/* If the index has a subdirectory (with
-			 * contents) as the first name, it'll get a
-			 * filename like "foo/bar". But that's after
-			 * "foo", so the entry in trees will get
-			 * handled first, at which point we'll go into
-			 * "foo", and deal with "bar" from the index,
-			 * because the base will be "foo/". The only
-			 * way we can actually have "foo/bar" first of
-			 * all the things is if the trees don't
-			 * contain "foo" at all, in which case we'll
-			 * handle "foo/bar" without going into the
-			 * directory, but that's fine (and will return
-			 * an error anyway, with the added unknown
-			 * file case.
-			 */
-
-			cache_name = active_cache[o->pos]->name;
-			if (strlen(cache_name) > baselen &&
-			    !memcmp(cache_name, base, baselen)) {
-				cache_name += baselen;
-				first = cache_name;
-			} else {
-				cache_name = NULL;
-			}
-		}
-
-#if DBRT_DEBUG > 1
-		if (first)
-			fprintf(stderr, "index %s\n", first);
-#endif
-		for (i = 0; i < len; i++) {
-			if (!posns[i] || posns[i] == df_conflict_list)
-				continue;
-#if DBRT_DEBUG > 1
-			fprintf(stderr, "%d %s\n", i + 1, posns[i]->name);
-#endif
-			if (!first || entcmp(first, firstdir,
-					     posns[i]->name,
-					     S_ISDIR(posns[i]->mode)) > 0) {
-				first = posns[i]->name;
-				firstdir = S_ISDIR(posns[i]->mode);
-			}
-		}
-		/* No name means we're done */
-		if (!first)
-			goto leave_directory;
-
-		pathlen = strlen(first);
-		ce_size = cache_entry_size(baselen + pathlen);
-
-		src = xcalloc(src_size, sizeof(struct cache_entry *));
-
-		subposns = xcalloc(len, sizeof(struct tree_list_entry *));
-
-		remove = -1;
-		if (cache_name && !strcmp(cache_name, first)) {
-			any_files = 1;
-			src[0] = active_cache[o->pos];
-			remove = o->pos;
-			if (o->skip_unmerged && ce_stage(src[0]))
-				skip_entry = 1;
-		}
-
-		for (i = 0; i < len; i++) {
-			struct cache_entry *ce;
-
-			if (!posns[i] ||
-			    (posns[i] != df_conflict_list &&
-			     strcmp(first, posns[i]->name))) {
-				continue;
-			}
-
-			if (posns[i] == df_conflict_list) {
-				src[i + o->merge] = o->df_conflict_entry;
-				continue;
-			}
-
-			if (S_ISDIR(posns[i]->mode)) {
-				struct tree *tree = lookup_tree(posns[i]->sha1);
-				struct tree_desc t;
-				any_dirs = 1;
-				parse_tree(tree);
-				init_tree_desc(&t, tree->buffer, tree->size);
-				subposns[i] = create_tree_entry_list(&t);
-				posns[i] = posns[i]->next;
-				src[i + o->merge] = o->df_conflict_entry;
-				continue;
-			}
-
-			if (skip_entry) {
-				subposns[i] = df_conflict_list;
-				posns[i] = posns[i]->next;
-				continue;
-			}
-
-			if (!o->merge)
-				ce_stage = 0;
-			else if (i + 1 < o->head_idx)
-				ce_stage = 1;
-			else if (i + 1 > o->head_idx)
-				ce_stage = 3;
-			else
-				ce_stage = 2;
-
-			ce = xcalloc(1, ce_size);
-			ce->ce_mode = create_ce_mode(posns[i]->mode);
-			ce->ce_flags = create_ce_flags(baselen + pathlen,
-						       ce_stage);
-			memcpy(ce->name, base, baselen);
-			memcpy(ce->name + baselen, first, pathlen + 1);
-
-			any_files = 1;
-
-			hashcpy(ce->sha1, posns[i]->sha1);
-			src[i + o->merge] = ce;
-			subposns[i] = df_conflict_list;
-			posns[i] = posns[i]->next;
-		}
-		if (any_files) {
-			if (skip_entry) {
-				o->pos++;
-				while (o->pos < active_nr &&
-				       !strcmp(active_cache[o->pos]->name,
-					       src[0]->name))
-					o->pos++;
-			} else if (o->merge) {
-				int ret;
-
-#if DBRT_DEBUG > 1
-				fprintf(stderr, "%s:\n", first);
-				for (i = 0; i < src_size; i++) {
-					fprintf(stderr, " %d ", i);
-					if (src[i])
-						fprintf(stderr, "%06x %s\n", src[i]->ce_mode, sha1_to_hex(src[i]->sha1));
-					else
-						fprintf(stderr, "\n");
-				}
-#endif
-				ret = o->fn(src, o, remove);
-				if (ret < 0)
-					return ret;
-
-#if DBRT_DEBUG > 1
-				fprintf(stderr, "Added %d entries\n", ret);
-#endif
-				o->pos += ret;
-			} else {
-				remove_entry(remove);
-				for (i = 0; i < src_size; i++) {
-					if (src[i]) {
-						add_cache_entry(src[i], ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
-					}
-				}
-			}
-		}
-		if (any_dirs) {
-			char *newbase = xmalloc(baselen + 2 + pathlen);
-			memcpy(newbase, base, baselen);
-			memcpy(newbase + baselen, first, pathlen);
-			newbase[baselen + pathlen] = '/';
-			newbase[baselen + pathlen + 1] = '\0';
-			if (unpack_trees_rec(subposns, len, newbase, o,
-					     df_conflict_list)) {
-				retval = -1;
-				goto leave_directory;
-			}
-			free(newbase);
-		}
-		free(subposns);
-		free(src);
-	} while (1);
-
- leave_directory:
-	return retval;
-}
-
 /* Unlink the last component and attempt to remove leading
  * directories, in case this unlink is the removal of the
  * last entry in the directory -- empty directories are removed.
@@ -346,15 +88,241 @@ static void check_updates(struct unpack_trees_options *o)
 	stop_progress(&progress);
 }
 
-int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
+static inline int call_unpack_fn(struct cache_entry **src, struct unpack_trees_options *o, int remove)
+{
+	int ret = o->fn(src, o, remove);
+	if (ret > 0) {
+		o->pos += ret;
+		ret = 0;
+	}
+	return ret;
+}
+
+static int unpack_index_entry(struct cache_entry *ce, struct unpack_trees_options *o)
+{
+	struct cache_entry *src[5] = { ce, };
+	if (ce_stage(ce)) {
+		if (o->skip_unmerged) {
+			o->pos++;
+		} else {
+			remove_entry(o->pos);
+		}
+		return 0;
+	}
+	return call_unpack_fn(src, o, o->pos);
+}
+
+int traverse_trees_recursive(int n, unsigned long dirmask, unsigned long df_conflicts, struct name_entry *names, struct traverse_info *info)
+{
+	int i;
+	struct tree_desc t[3];
+	struct traverse_info newinfo;
+	struct name_entry *p;
+
+	p = names;
+	while (!p->mode)
+		p++;
+
+	newinfo = *info;
+	newinfo.prev = info;
+	newinfo.name = *p;
+	newinfo.pathlen += tree_entry_len(p->path, p->sha1) + 1;
+	newinfo.conflicts |= df_conflicts;
+
+	for (i = 0; i < n; i++, dirmask >>= 1) {
+		const unsigned char *sha1 = NULL;
+		if (dirmask & 1)
+			sha1 = names[i].sha1;
+		fill_tree_descriptor(t+i, sha1);
+	}
+	traverse_trees(n, t, &newinfo);
+	return 0;
+}
+
+/*
+ * Compare the traverse-path to the cache entry without actually
+ * having to generate the textual representation of the traverse
+ * path.
+ *
+ * NOTE! This *only* compares up to the size of the traverse path
+ * itself - the caller needs to do the final check for the cache
+ * entry having more data at the end!
+ */
+static int do_compare_entry(const struct cache_entry *ce, const struct traverse_info *info, const struct name_entry *n)
+{
+	int len, pathlen, ce_len;
+	const char *ce_name;
+
+	if (info->prev) {
+		int cmp = do_compare_entry(ce, info->prev, &info->name);
+		if (cmp)
+			return cmp;
+	}
+	pathlen = info->pathlen;
+	ce_len = ce_namelen(ce);
+
+	/* If ce_len < pathlen then we must have previously hit "name == directory" entry */
+	if (ce_len < pathlen)
+		return -1;
+
+	ce_len -= pathlen;
+	ce_name = ce->name + pathlen;
+
+	len = tree_entry_len(n->path, n->sha1);
+	return df_name_compare(ce_name, ce_len, S_IFREG, n->path, len, n->mode);
+}
+
+static int compare_entry(const struct cache_entry *ce, const struct traverse_info *info, const struct name_entry *n)
+{
+	int cmp = do_compare_entry(ce, info, n);
+	if (cmp)
+		return cmp;
+
+	/*
+	 * Even if the beginning compared identically, the ce should
+	 * compare as bigger than a directory leading up to it!
+	 */
+	return ce_namelen(ce) > traverse_path_len(info, n);
+}
+
+static struct cache_entry *create_ce_entry(const struct traverse_info *info, const struct name_entry *n, int stage)
+{
+	int len = traverse_path_len(info, n);
+	struct cache_entry *ce = xcalloc(1, cache_entry_size(len));
+
+	ce->ce_mode = create_ce_mode(n->mode);
+	ce->ce_flags = create_ce_flags(len, stage);
+	hashcpy(ce->sha1, n->sha1);
+	make_traverse_path(ce->name, info, n);
+
+	return ce;
+}
+
+static int unpack_nondirectories(int n, unsigned long mask, unsigned long dirmask, struct cache_entry *src[5],
+	const struct name_entry *names, const struct traverse_info *info, int remove)
 {
-	struct tree_entry_list **posns;
 	int i;
-	struct tree_entry_list df_conflict_list;
+	struct unpack_trees_options *o = info->data;
+	unsigned long conflicts;
+
+	/* Do we have *only* directories? Nothing to do */
+	if (mask == dirmask && !src[0])
+		return 0;
+
+	conflicts = info->conflicts;
+	if (o->merge)
+		conflicts >>= 1;
+	conflicts |= dirmask;
+
+	/*
+	 * Ok, we've filled in up to any potential index entry in src[0],
+	 * now do the rest.
+	 */
+	for (i = 0; i < n; i++) {
+		int stage;
+		unsigned int bit = 1ul << i;
+		if (conflicts & bit) {
+			src[i + o->merge] = o->df_conflict_entry;
+			continue;
+		}
+		if (!(mask & bit))
+			continue;
+		if (!o->merge)
+			stage = 0;
+		else if (i + 1 < o->head_idx)
+			stage = 1;
+		else if (i + 1 > o->head_idx)
+			stage = 3;
+		else
+			stage = 2;
+		src[i + o->merge] = create_ce_entry(info, names + i, stage);
+	}
+
+	if (o->merge)
+		return call_unpack_fn(src, o, remove);
+
+	n += o->merge;
+	remove_entry(remove);
+	for (i = 0; i < n; i++)
+		add_cache_entry(src[i], ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
+	return 0;
+}
+
+static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
+{
+	struct cache_entry *src[5] = { NULL, };
+	struct unpack_trees_options *o = info->data;
+	int remove = -1;
+	const struct name_entry *p = names;
+
+	/* Find first entry with a real name (we could use "mask" too) */
+	while (!p->mode)
+		p++;
+
+	/* Are we supposed to look at the index too? */
+	if (o->merge) {
+		while (o->pos < active_nr) {
+			struct cache_entry *ce = active_cache[o->pos];
+			int cmp = compare_entry(ce, info, p);
+			if (cmp < 0) {
+				if (unpack_index_entry(ce, o) < 0)
+					return -1;
+				continue;
+			}
+			if (!cmp) {
+				if (ce_stage(ce)) {
+					/*
+					 * If we skip unmerged index entries, we'll skip this
+					 * entry *and* the tree entries associated with it!
+					 */
+					if (o->skip_unmerged)
+						return mask;
+					remove_entry(o->pos);
+					continue;
+				}
+				src[0] = ce;
+				remove = o->pos;
+			}
+			break;
+		}
+	}
+
+	if (unpack_nondirectories(n, mask, dirmask, src, names, info, remove) < 0)
+		return -1;
+
+	/* Now handle any directories.. */
+	if (dirmask) {
+		unsigned long conflicts = mask & ~dirmask;
+		if (o->merge) {
+			conflicts <<= 1;
+			if (src[0])
+				conflicts |= 1;
+		}
+		traverse_trees_recursive(n, dirmask, conflicts, names, info);
+		return mask;
+	}
+
+	return mask;
+}
+
+static int unpack_failed(struct unpack_trees_options *o, const char *message)
+{
+	if (!o->gently) {
+		if (message)
+			return error(message);
+		return -1;
+	}
+	discard_cache();
+	read_cache();
+	return -1;
+}
+
+int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
+{
 	static struct cache_entry *dfc;
 
-	memset(&df_conflict_list, 0, sizeof(df_conflict_list));
-	df_conflict_list.next = &df_conflict_list;
+	if (len > 4)
+		die("unpack_trees takes at most four trees");
 	memset(&state, 0, sizeof(state));
 	state.base_dir = "";
 	state.force = 1;
@@ -368,29 +336,29 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->df_conflict_entry = dfc;
 
 	if (len) {
-		posns = xmalloc(len * sizeof(struct tree_entry_list *));
-		for (i = 0; i < len; i++)
-			posns[i] = create_tree_entry_list(t+i);
-
-		if (unpack_trees_rec(posns, len, o->prefix ? o->prefix : "",
-				     o, &df_conflict_list)) {
-			if (o->gently) {
-				discard_cache();
-				read_cache();
-			}
-			return -1;
-		}
+		const char *prefix = o->prefix ? o->prefix : "";
+		struct traverse_info info;
+
+		setup_traverse_info(&info, prefix);
+		info.fn = unpack_callback;
+		info.data = o;
+
+		if (traverse_trees(len, t, &info) < 0)
+			return unpack_failed(o, NULL);
 	}
 
-	if (o->trivial_merges_only && o->nontrivial_merge) {
-		if (o->gently) {
-			discard_cache();
-			read_cache();
+	/* Any left-over entries in the index? */
+	if (o->merge) {
+		while (o->pos < active_nr) {
+			struct cache_entry *ce = active_cache[o->pos];
+			if (unpack_index_entry(ce, o) < 0)
+				return unpack_failed(o, NULL);
 		}
-		return o->gently ? -1 :
-			error("Merge requires file-level merging");
 	}
 
+	if (o->trivial_merges_only && o->nontrivial_merge)
+		return unpack_failed(o, "Merge requires file-level merging");
+
 	check_updates(o);
 	return 0;
 }
