From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/4] Add cache-tree.
Date: Sun, 23 Apr 2006 16:52:20 -0700
Message-ID: <7vhd4jetor.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 24 01:52:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXoNP-0006Gh-El
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 01:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWDWXwY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Apr 2006 19:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWDWXwY
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Apr 2006 19:52:24 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:55550 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751462AbWDWXwX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Apr 2006 19:52:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060423235221.MVVZ15879.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 23 Apr 2006 19:52:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19075>

The cache_tree data structure is to cache tree object names that
would result from the current index file.

The idea is to have an optional file to record each tree object
name that corresponds to a directory path in the cache when we
run write_cache(), and read it back when we run read_cache().
During various index manupulations, we selectively invalidate
the parts so that the next write-tree can bypass regenerating
tree objects for unchanged parts of the directory hierarchy.

We could perhaps make the cache-tree data an optional part of
the index file, but that would involve the index format updates,
so unless we need it for performance reasons, the current plan
is to use a separate file, $GIT_DIR/index.aux to store this
information and link it with the index file with the checksum
that is already used for index file integrity check.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This is just the data structure and its maintenance, and not
   tied to the rest of the system yet, which will be done with
   the next two patches.

 Makefile     |    2 
 cache-tree.c |  522 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 cache-tree.h |   29 +++
 3 files changed, 552 insertions(+), 1 deletions(-)
 create mode 100644 cache-tree.c
 create mode 100644 cache-tree.h

c37a2dc93fb49dada5eec78f002eea9354e4fb4f
diff --git a/Makefile b/Makefile
index d9a3a82..518c3c1 100644
--- a/Makefile
+++ b/Makefile
@@ -204,7 +204,7 @@ DIFF_OBJS = \
 	diffcore-delta.o log-tree.o
 
 LIB_OBJS = \
-	blob.o commit.o connect.o csum-file.o \
+	blob.o commit.o connect.o csum-file.o cache-tree.o \
 	date.o diff-delta.o entry.o exec_cmd.o ident.o index.o \
 	object.o pack-check.o patch-delta.o path.o pkt-line.o \
 	quote.o read-cache.o refs.o run-command.o \
diff --git a/cache-tree.c b/cache-tree.c
new file mode 100644
index 0000000..c79da33
--- /dev/null
+++ b/cache-tree.c
@@ -0,0 +1,522 @@
+#include "cache.h"
+#include "tree.h"
+#include "cache-tree.h"
+
+#define DEBUG 0
+
+struct cache_tree *cache_tree(void)
+{
+	struct cache_tree *it = xcalloc(1, sizeof(struct cache_tree));
+	it->entry_count = -1; 
+	return it;
+}
+
+void cache_tree_free(struct cache_tree *it)
+{
+	int i;
+
+	if (!it)
+		return;
+	for (i = 0; i < it->subtree_nr; i++)
+		cache_tree_free(it->down[i]->cache_tree);
+	free(it->down);
+	free(it);
+}
+
+static struct cache_tree_sub *find_subtree(struct cache_tree *it,
+					   const char *path,
+					   int pathlen,
+					   int create)
+{
+	int i;
+	struct cache_tree_sub *down;
+	for (i = 0; i < it->subtree_nr; i++) {
+		down = it->down[i];
+		if (down->namelen == pathlen &&
+		    !memcmp(down->name, path, pathlen))
+			return down;
+	}
+	if (!create)
+		return NULL;
+	if (it->subtree_alloc <= it->subtree_nr) {
+		it->subtree_alloc = alloc_nr(it->subtree_alloc);
+		it->down = xrealloc(it->down, it->subtree_alloc *
+				    sizeof(*it->down));
+	}
+	down = xmalloc(sizeof(*down) + pathlen + 1);
+	down->cache_tree = NULL; /* cache_tree(); */
+	down->namelen = pathlen;
+	memcpy(down->name, path, pathlen);
+	down->name[pathlen] = 0; /* not strictly needed */
+	it->down[it->subtree_nr++] = down;
+	return down;
+}
+
+void cache_tree_invalidate_path(struct cache_tree *it, const char *path)
+{
+	/* a/b/c
+	 * ==> invalidate self
+	 * ==> find "a", have it invalidate "b/c"
+	 * a
+	 * ==> invalidate self
+	 * ==> if "a" exists as a subtree, remove it.
+	 */
+	const char *slash;
+	int namelen;
+	struct cache_tree_sub *down;
+
+	if (!it)
+		return;
+	slash = strchr(path, '/');
+	it->entry_count = -1; 
+	if (!slash) {
+		int i;
+		namelen = strlen(path);
+		for (i = 0; i < it->subtree_nr; i++) {
+			if (it->down[i]->namelen == namelen &&
+			    !memcmp(it->down[i]->name, path, namelen))
+				break;
+		}
+		if (i < it->subtree_nr) {
+			cache_tree_free(it->down[i]->cache_tree);
+			free(it->down[i]);
+			/* 0 1 2 3 4 5
+			 *       ^     ^subtree_nr = 6
+			 *       i
+			 * move 4 and 5 up one place (2 entries)
+			 * 2 = 6 - 3 - 1 = subtree_nr - i - 1
+			 */
+			memmove(it->down+i, it->down+i+1,
+				sizeof(struct cache_tree_sub *) *
+				(it->subtree_nr - i - 1));
+			it->subtree_nr--;
+		}
+		return;
+	}
+	namelen = slash - path;
+	down = find_subtree(it, path, namelen, 0);
+	if (down)
+		cache_tree_invalidate_path(down->cache_tree, slash + 1);
+}
+
+static int verify_cache(struct cache_entry **cache,
+			int entries)
+{
+	int i, funny;
+
+	/* Verify that the tree is merged */
+	funny = 0;
+	for (i = 0; i < entries; i++) {
+		struct cache_entry *ce = cache[i];
+		if (ce_stage(ce)) {
+			if (10 < ++funny) {
+				fprintf(stderr, "...\n");
+				break;
+			}
+			fprintf(stderr, "%s: unmerged (%s)\n",
+				ce->name, sha1_to_hex(ce->sha1));
+		}
+	}
+	if (funny)
+		return -1;
+
+	/* Also verify that the cache does not have path and path/file
+	 * at the same time.  At this point we know the cache has only
+	 * stage 0 entries.
+	 */
+	funny = 0;
+	for (i = 0; i < entries - 1; i++) {
+		/* path/file always comes after path because of the way
+		 * the cache is sorted.  Also path can appear only once,
+		 * which means conflicting one would immediately follow.
+		 */
+		const char *this_name = cache[i]->name;
+		const char *next_name = cache[i+1]->name;
+		int this_len = strlen(this_name);
+		if (this_len < strlen(next_name) &&
+		    strncmp(this_name, next_name, this_len) == 0 &&
+		    next_name[this_len] == '/') {
+			if (10 < ++funny) {
+				fprintf(stderr, "...\n");
+				break;
+			}
+			fprintf(stderr, "You have both %s and %s\n",
+				this_name, next_name);
+		}
+	}
+	if (funny)
+		return -1;
+	return 0;
+}
+
+static void discard_unused_subtrees(struct cache_tree *it)
+{
+	struct cache_tree_sub **down = it->down;
+	int nr = it->subtree_nr;
+	int dst, src;
+	for (dst = src = 0; src < nr; src++) {
+		struct cache_tree_sub *s = down[src];
+		if (s->used)
+			down[dst++] = s;
+		else {
+			cache_tree_free(s->cache_tree);
+			free(s);
+			it->subtree_nr--;
+		}
+	}
+}
+
+static int update_one(struct cache_tree *it,
+		      struct cache_entry **cache,
+		      int entries,
+		      const char *base,
+		      int baselen,
+		      int missing_ok)
+{
+	unsigned long size, offset;
+	char *buffer;
+	int i;
+
+	if (0 <= it->entry_count)
+		return it->entry_count;
+
+	/*
+	 * We first scan for subtrees and update them; we start by
+	 * marking existing subtrees -- the ones that are unmarked
+	 * should not be in the result.
+	 */
+	for (i = 0; i < it->subtree_nr; i++)
+		it->down[i]->used = 0;
+
+	/*
+	 * Find the subtrees and update them.
+	 */
+	for (i = 0; i < entries; i++) {
+		struct cache_entry *ce = cache[i];
+		struct cache_tree_sub *sub;
+		const char *path, *slash;
+		int pathlen, sublen, subcnt;
+
+		path = ce->name;
+		pathlen = ce_namelen(ce);
+		if (pathlen <= baselen || memcmp(base, path, baselen))
+			break; /* at the end of this level */
+
+		slash = strchr(path + baselen, '/');
+		if (!slash)
+			continue;
+		/*
+		 * a/bbb/c (base = a/, slash = /c)
+		 * ==>
+		 * path+baselen = bbb/c, sublen = 3
+		 */
+		sublen = slash - (path + baselen);
+		sub = find_subtree(it, path + baselen, sublen, 1);
+		if (!sub->cache_tree)
+			sub->cache_tree = cache_tree();
+		subcnt = update_one(sub->cache_tree,
+				    cache + i, entries - i,
+				    path,
+				    baselen + sublen + 1,
+				    missing_ok);
+		i += subcnt - 1;
+		sub->used = 1;
+	}
+
+	discard_unused_subtrees(it);
+
+	/*
+	 * Then write out the tree object for this level.
+	 */
+	size = 8192;
+	buffer = xmalloc(size);
+	offset = 0;
+
+	for (i = 0; i < entries; i++) {
+		struct cache_entry *ce = cache[i];
+		struct cache_tree_sub *sub;
+		const char *path, *slash;
+		int pathlen, entlen;
+		const unsigned char *sha1;
+		unsigned mode;
+
+		path = ce->name;
+		pathlen = ce_namelen(ce);
+		if (pathlen <= baselen || memcmp(base, path, baselen))
+			break; /* at the end of this level */
+
+		slash = strchr(path + baselen, '/');
+		if (slash) {
+			entlen = slash - (path + baselen);
+			sub = find_subtree(it, path + baselen, entlen, 0);
+			if (!sub)
+				die("cache-tree.c: '%.*s' in '%s' not found",
+				    entlen, path + baselen, path);
+			i += sub->cache_tree->entry_count - 1;
+			sha1 = sub->cache_tree->sha1;
+			mode = S_IFDIR;
+		}
+		else {
+			sha1 = ce->sha1;
+			mode = ntohl(ce->ce_mode);
+			entlen = pathlen - baselen;
+		}
+		if (!missing_ok && !has_sha1_file(sha1))
+			return error("invalid object %s", sha1_to_hex(sha1));
+
+		if (!ce->ce_mode)
+			continue; /* entry being removed */
+
+		if (size < offset + entlen + 100) {
+			size = alloc_nr(offset + entlen + 100);
+			buffer = xrealloc(buffer, size);
+		}
+		offset += sprintf(buffer + offset,
+				  "%o %.*s", mode, entlen, path + baselen);
+		buffer[offset++] = 0;
+		memcpy(buffer + offset, sha1, 20);
+		offset += 20;
+
+#if DEBUG
+		fprintf(stderr, "cache-tree %o %.*s\n",
+			mode, entlen, path + baselen);
+#endif
+	}
+
+	write_sha1_file(buffer, offset, tree_type, it->sha1);
+	free(buffer);
+	it->entry_count = i;
+#if DEBUG
+	fprintf(stderr, "cache-tree (%d ent, %d subtree) %s\n",
+		it->entry_count, it->subtree_nr,
+		sha1_to_hex(it->sha1));
+#endif
+	return i;
+}
+
+int cache_tree_update(struct cache_tree *it,
+		      struct cache_entry **cache,
+		      int entries,
+		      int missing_ok)
+{
+	int i;
+	i = verify_cache(cache, entries);
+	if (i)
+		return i;
+	i = update_one(it, cache, entries, "", 0, missing_ok);
+	if (i < 0)
+		return i;
+	return 0;
+}
+
+static void *write_one(struct cache_tree *it,
+		       char *path,
+		       int pathlen,
+		       char *buffer,
+		       unsigned long *size,
+		       unsigned long *offset)
+{
+	int i;
+
+	/* One "cache-tree" entry consists of the following:
+	 * path (NUL terminated)
+	 * entry_count, subtree_nr ("%d %d\n")
+	 * tree-sha1 (missing if invalid)
+	 * subtree_nr "cache-tree" entries for subtrees.
+	 */
+	if (*size < *offset + pathlen + 100) {
+		*size = alloc_nr(*offset + pathlen + 100);
+		buffer = xrealloc(buffer, *size);
+	}
+	*offset += sprintf(buffer + *offset, "%.*s%c%d %d\n",
+			   pathlen, path, 0,
+			   it->entry_count, it->subtree_nr);
+
+#if DEBUG
+	if (0 <= it->entry_count)
+		fprintf(stderr, "cache-tree <%.*s> (%d ent, %d subtree) %s\n",
+			pathlen, path, it->entry_count, it->subtree_nr,
+			sha1_to_hex(it->sha1));
+	else
+		fprintf(stderr, "cache-tree <%.*s> (%d subtree) invalid\n",
+			pathlen, path, it->subtree_nr);
+#endif
+
+	if (0 <= it->entry_count) {
+		memcpy(buffer + *offset, it->sha1, 20);
+		*offset += 20;
+	}
+	for (i = 0; i < it->subtree_nr; i++) {
+		struct cache_tree_sub *down = it->down[i];
+		int len = pathlen + down->namelen;
+		memcpy(path + pathlen, down->name, down->namelen);
+		path[len] = '/';
+		buffer = write_one(down->cache_tree, path, len+1,
+				   buffer, size, offset);
+	}
+	return buffer;
+}
+
+static void *cache_tree_write(const unsigned char *cache_sha1,
+			      struct cache_tree *root,
+			      unsigned long *offset_p)
+{
+	char path[PATH_MAX];
+	unsigned long size = 8192;
+	char *buffer = xmalloc(size);
+
+	/* the cache checksum of the corresponding index file. */
+	memcpy(buffer, cache_sha1, 20);
+	*offset_p = 20;
+	path[0] = 0;
+	return write_one(root, path, 0, buffer, &size, offset_p);
+}
+
+static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
+{
+	const char *buf = *buffer;
+	unsigned long size = *size_p;
+	struct cache_tree *it;
+	int i, subtree_nr;
+
+	it = NULL;
+	/* skip name, but make sure name exists */
+	while (size && *buf) {
+		size--;
+		buf++;
+	}
+	if (!size)
+		goto free_return;
+	buf++; size--;
+	it = cache_tree();
+	if (sscanf(buf, "%d %d\n", &it->entry_count, &subtree_nr) != 2)
+		goto free_return;
+	while (size && *buf && *buf != '\n') {
+		size--;
+		buf++;
+	}
+	if (!size)
+		goto free_return;
+	buf++; size--;
+	if (0 <= it->entry_count) {
+		if (size < 20)
+			goto free_return;
+		memcpy(it->sha1, buf, 20);
+		buf += 20;
+		size -= 20;
+	}
+
+#if DEBUG
+	if (0 <= it->entry_count)
+		fprintf(stderr, "cache-tree <%s> (%d ent, %d subtree) %s\n",
+			*buffer, it->entry_count, subtree_nr,
+			sha1_to_hex(it->sha1));
+	else
+		fprintf(stderr, "cache-tree <%s> (%d subtrees) invalid\n",
+			*buffer, subtree_nr);
+#endif
+
+	/*
+	 * Just a heuristic -- we do not add directories that often but
+	 * we do not want to have to extend it immediately when we do,
+	 * hence +2.
+	 */
+	it->subtree_alloc = subtree_nr + 2;
+	it->down = xcalloc(it->subtree_alloc, sizeof(struct cache_tree_sub *));
+	for (i = 0; i < subtree_nr; i++) {
+		/* read each subtree */
+		struct cache_tree *sub;
+		const char *name = buf;
+		int namelen;
+		sub = read_one(&buf, &size);
+		if (!sub)
+			goto free_return;
+		namelen = strlen(name);
+		it->down[i] = find_subtree(it, name, namelen, 1);
+		it->down[i]->cache_tree = sub;
+	}
+	if (subtree_nr != it->subtree_nr)
+		die("cache-tree: internal error");
+	*buffer = buf;
+	*size_p = size;
+	return it;
+
+ free_return:
+	cache_tree_free(it);
+	return NULL;
+}
+
+static struct cache_tree *cache_tree_read(unsigned char *sha1,
+					  const char *buffer,
+					  unsigned long size)
+{
+	/* check the cache-tree matches the index */
+	if (memcmp(buffer, sha1, 20))
+		return NULL; /* checksum mismatch */
+	if (buffer[20])
+		return NULL; /* not the whole tree */
+	buffer += 20;
+	size -= 20;
+	return read_one(&buffer, &size);
+}
+
+struct cache_tree *read_cache_tree(unsigned char *sha1)
+{
+	int fd;
+	struct stat st;
+	char path[PATH_MAX];
+	unsigned long size = 0;
+	void *map;
+	struct cache_tree *it;
+
+	sprintf(path, "%s.aux", get_index_file());
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return cache_tree();
+
+	if (fstat(fd, &st))
+		return cache_tree();
+	size = st.st_size;
+	map = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+	if (map == MAP_FAILED)
+		return cache_tree();
+	it = cache_tree_read(sha1, map, size);
+	munmap(map, size);
+	if (!it)
+		return cache_tree();
+	return it;
+}
+
+int write_cache_tree(const unsigned char *sha1, struct cache_tree *root)
+{
+	char path[PATH_MAX];
+	unsigned long size = 0;
+	void *buf, *buffer;
+	int fd, ret = -1;
+
+	sprintf(path, "%s.aux", get_index_file());
+	if (!root) {
+		unlink(path);
+		return -1;
+	}
+	fd = open(path, O_WRONLY|O_CREAT, 0666);
+	if (fd < 0)
+		return -1;
+	buffer = buf = cache_tree_write(sha1, root, &size);
+	while (size) {
+		int written = xwrite(fd, buf, size);
+		if (written <= 0)
+			goto fail;
+		buf += written;
+		size -= written;
+	}
+	ret = 0;
+
+ fail:
+	close(fd);
+	free(buffer);
+	if (ret)
+		unlink(path);
+	return ret;
+}
diff --git a/cache-tree.h b/cache-tree.h
new file mode 100644
index 0000000..7b149af
--- /dev/null
+++ b/cache-tree.h
@@ -0,0 +1,29 @@
+#ifndef CACHE_TREE_H
+#define CACHE_TREE_H
+
+struct cache_tree;
+struct cache_tree_sub {
+	struct cache_tree *cache_tree;
+	int namelen;
+	int used;
+	char name[FLEX_ARRAY];
+};
+
+struct cache_tree {
+	int entry_count; /* negative means "invalid" */
+	unsigned char sha1[20];
+	int subtree_nr;
+	int subtree_alloc;
+	struct cache_tree_sub **down;
+};
+
+struct cache_tree *cache_tree(void);
+void cache_tree_free(struct cache_tree *);
+void cache_tree_invalidate_path(struct cache_tree *, const char *);
+
+int write_cache_tree(const unsigned char *, struct cache_tree *);
+struct cache_tree *read_cache_tree(unsigned char *);
+int cache_tree_update(struct cache_tree *, struct cache_entry **, int, int);
+
+
+#endif
-- 
1.3.0.g623a
