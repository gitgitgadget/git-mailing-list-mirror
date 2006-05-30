From: Linus Torvalds <torvalds@osdl.org>
Subject: tree_entry(): new tree-walking helper function
Date: Tue, 30 May 2006 09:45:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605300931170.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue May 30 18:46:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fl7Lv-00075D-8m
	for gcvg-git@gmane.org; Tue, 30 May 2006 18:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWE3Qpw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 12:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWE3Qpw
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 12:45:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60092 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932316AbWE3Qpv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 May 2006 12:45:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4UGjk2g006016
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 30 May 2006 09:45:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4UGjji9020201;
	Tue, 30 May 2006 09:45:45 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21036>


This adds a "tree_entry()" function that combines the common operation of 
doing a "tree_entry_extract()" + "update_tree_entry()".

It also has a simplified calling convention, designed for simple loops 
that traverse over a whole tree: the arguments are pointers to the tree 
descriptor and a name_entry structure to fill in, and it returns a boolean 
"true" if there was an entry left to be gotten in the tree.

This allows tree traversal with

	struct tree_desc desc;
	struct name_entry entry;

	desc.buf = tree->buffer;
	desc.size = tree->size;
	while (tree_entry(&desc, &entry) {
		... use "entry.{path, sha1, mode, pathlen}" ...
	}

which is not only shorter than writing it out in full, it's hopefully less 
error prone too.

[ It's actually a tad faster too - we don't need to recalculate the entry 
  pathlength in both extract and update, but need to do it only once.  
  Also, some callers can avoid doing a "strlen()" on the result, since 
  it's returned as part of the name_entry structure.

  However, by now we're talking just 1% speedup on "git-rev-list --objects 
  --all", and we're definitely at the point where tree walking is no 
  longer the issue any more. ]

NOTE! Not everybody wants to use this new helper function, since some of 
the tree walkers very much on purpose do the descriptor update separately 
from the entry extraction. So the "extract + update" sequence still 
remains as the core sequence, this is just a simplified interface.

We should probably add a silly two-line inline helper function for 
initializing the descriptor from the "struct tree" too, just to cut down 
on the noise from that common "desc" initializer.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This is another of my "I'm not going to push this patch very aggressively" 
series. I think it's a cleanup, and it removes more lines than it adds and 
seems to make things more readable, but is it worth it? You decide.

 builtin-grep.c      |   26 ++++++++++----------------
 builtin-read-tree.c |   36 +++++++++++++-----------------------
 builtin-rev-list.c  |   16 +++++-----------
 builtin-tar-tree.c  |   21 ++++++++-------------
 fetch.c             |   16 +++++-----------
 http-push.c         |   16 +++++-----------
 pack-objects.c      |   27 +++++++++++----------------
 revision.c          |   16 +++++-----------
 tree-walk.c         |   33 +++++++++++++++++++++++++++++++--
 tree-walk.h         |    5 ++++-
 tree.c              |   41 +++++++++++++++--------------------------
 11 files changed, 112 insertions(+), 141 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 53de8a8..acc4eea 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -578,11 +578,9 @@ static int grep_tree(struct grep_opt *op
 		     struct tree_desc *tree,
 		     const char *tree_name, const char *base)
 {
-	unsigned mode;
 	int len;
 	int hit = 0;
-	const char *path;
-	const unsigned char *sha1;
+	struct name_entry entry;
 	char *down;
 	char *path_buf = xmalloc(PATH_MAX + strlen(tree_name) + 100);
 
@@ -597,36 +595,32 @@ static int grep_tree(struct grep_opt *op
 	}
 	len = strlen(path_buf);
 
-	while (tree->size) {
-		int pathlen;
-		sha1 = tree_entry_extract(tree, &path, &mode);
-		pathlen = strlen(path);
-		strcpy(path_buf + len, path);
+	while (tree_entry(tree, &entry)) {
+		strcpy(path_buf + len, entry.path);
 
-		if (S_ISDIR(mode))
+		if (S_ISDIR(entry.mode))
 			/* Match "abc/" against pathspec to
 			 * decide if we want to descend into "abc"
 			 * directory.
 			 */
-			strcpy(path_buf + len + pathlen, "/");
+			strcpy(path_buf + len + entry.pathlen, "/");
 
 		if (!pathspec_matches(paths, down))
 			;
-		else if (S_ISREG(mode))
-			hit |= grep_sha1(opt, sha1, path_buf);
-		else if (S_ISDIR(mode)) {
+		else if (S_ISREG(entry.mode))
+			hit |= grep_sha1(opt, entry.sha1, path_buf);
+		else if (S_ISDIR(entry.mode)) {
 			char type[20];
 			struct tree_desc sub;
 			void *data;
-			data = read_sha1_file(sha1, type, &sub.size);
+			data = read_sha1_file(entry.sha1, type, &sub.size);
 			if (!data)
 				die("unable to read tree (%s)",
-				    sha1_to_hex(sha1));
+				    sha1_to_hex(entry.sha1));
 			sub.buf = data;
 			hit |= grep_tree(opt, paths, &sub, tree_name, down);
 			free(data);
 		}
-		update_tree_entry(tree);
 	}
 	return hit;
 }
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index d70411f..0c6ba3d 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -54,28 +54,23 @@ typedef int (*merge_fn_t)(struct cache_e
 static struct tree_entry_list *create_tree_entry_list(struct tree *tree)
 {
 	struct tree_desc desc;
+	struct name_entry one;
 	struct tree_entry_list *ret = NULL;
 	struct tree_entry_list **list_p = &ret;
 
 	desc.buf = tree->buffer;
 	desc.size = tree->size;
 
-	while (desc.size) {
-		unsigned mode;
-		const char *path;
-		const unsigned char *sha1;
+	while (tree_entry(&desc, &one)) {
 		struct tree_entry_list *entry;
 
-		sha1 = tree_entry_extract(&desc, &path, &mode);
-		update_tree_entry(&desc);
-
 		entry = xmalloc(sizeof(struct tree_entry_list));
-		entry->name = path;
-		entry->sha1 = sha1;
-		entry->mode = mode;
-		entry->directory = S_ISDIR(mode) != 0;
-		entry->executable = (mode & S_IXUSR) != 0;
-		entry->symlink = S_ISLNK(mode) != 0;
+		entry->name = one.path;
+		entry->sha1 = one.sha1;
+		entry->mode = one.mode;
+		entry->directory = S_ISDIR(one.mode) != 0;
+		entry->executable = (one.mode & S_IXUSR) != 0;
+		entry->symlink = S_ISLNK(one.mode) != 0;
 		entry->next = NULL;
 
 		*list_p = entry;
@@ -846,27 +841,22 @@ static int read_cache_unmerged(void)
 static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
 {
 	struct tree_desc desc;
+	struct name_entry entry;
 	int cnt;
 
 	memcpy(it->sha1, tree->object.sha1, 20);
 	desc.buf = tree->buffer;
 	desc.size = tree->size;
 	cnt = 0;
-	while (desc.size) {
-		unsigned mode;
-		const char *name;
-		const unsigned char *sha1;
-
-		sha1 = tree_entry_extract(&desc, &name, &mode);
-		update_tree_entry(&desc);
-		if (!S_ISDIR(mode))
+	while (tree_entry(&desc, &entry)) {
+		if (!S_ISDIR(entry.mode))
 			cnt++;
 		else {
 			struct cache_tree_sub *sub;
-			struct tree *subtree = lookup_tree(sha1);
+			struct tree *subtree = lookup_tree(entry.sha1);
 			if (!subtree->object.parsed)
 				parse_tree(subtree);
-			sub = cache_tree_sub(it, name);
+			sub = cache_tree_sub(it, entry.path);
 			sub->cache_tree = cache_tree();
 			prime_cache_tree_rec(sub->cache_tree, subtree);
 			cnt += sub->cache_tree->entry_count;
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 6e2b898..17c04b9 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -114,6 +114,7 @@ static struct object_list **process_tree
 {
 	struct object *obj = &tree->object;
 	struct tree_desc desc;
+	struct name_entry entry;
 	struct name_path me;
 
 	if (!revs.tree_objects)
@@ -132,18 +133,11 @@ static struct object_list **process_tree
 	desc.buf = tree->buffer;
 	desc.size = tree->size;
 
-	while (desc.size) {
-		unsigned mode;
-		const char *name;
-		const unsigned char *sha1;
-
-		sha1 = tree_entry_extract(&desc, &name, &mode);
-		update_tree_entry(&desc);
-
-		if (S_ISDIR(mode))
-			p = process_tree(lookup_tree(sha1), p, &me, name);
+	while (tree_entry(&desc, &entry)) {
+		if (S_ISDIR(entry.mode))
+			p = process_tree(lookup_tree(entry.sha1), p, &me, name);
 		else
-			p = process_blob(lookup_blob(sha1), p, &me, name);
+			p = process_blob(lookup_blob(entry.sha1), p, &me, name);
 	}
 	free(tree->buffer);
 	tree->buffer = NULL;
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 2d5e06f..5f740cf 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -271,30 +271,25 @@ static void write_global_extended_header
 static void traverse_tree(struct tree_desc *tree, struct strbuf *path)
 {
 	int pathlen = path->len;
+	struct name_entry entry;
 
-	while (tree->size) {
-		const char *name;
-		const unsigned char *sha1;
-		unsigned mode;
+	while (tree_entry(tree, &entry)) {
 		void *eltbuf;
 		char elttype[20];
 		unsigned long eltsize;
 
-		sha1 = tree_entry_extract(tree, &name, &mode);
-		update_tree_entry(tree);
-
-		eltbuf = read_sha1_file(sha1, elttype, &eltsize);
+		eltbuf = read_sha1_file(entry.sha1, elttype, &eltsize);
 		if (!eltbuf)
-			die("cannot read %s", sha1_to_hex(sha1));
+			die("cannot read %s", sha1_to_hex(entry.sha1));
 
 		path->len = pathlen;
-		strbuf_append_string(path, name);
-		if (S_ISDIR(mode))
+		strbuf_append_string(path, entry.path);
+		if (S_ISDIR(entry.mode))
 			strbuf_append_string(path, "/");
 
-		write_entry(sha1, path, mode, eltbuf, eltsize);
+		write_entry(entry.sha1, path, entry.mode, eltbuf, eltsize);
 
-		if (S_ISDIR(mode)) {
+		if (S_ISDIR(entry.mode)) {
 			struct tree_desc subtree;
 			subtree.buf = eltbuf;
 			subtree.size = eltsize;
diff --git a/fetch.c b/fetch.c
index b03c201..e9347ba 100644
--- a/fetch.c
+++ b/fetch.c
@@ -39,25 +39,19 @@ static int process(struct object *obj);
 static int process_tree(struct tree *tree)
 {
 	struct tree_desc desc;
+	struct name_entry entry;
 
 	if (parse_tree(tree))
 		return -1;
 
 	desc.buf = tree->buffer;
 	desc.size = tree->size;
-	while (desc.size) {
-		unsigned mode;
-		const char *name;
-		const unsigned char *sha1;
-
-		sha1 = tree_entry_extract(&desc, &name, &mode);
-		update_tree_entry(&desc);
-
-		if (S_ISDIR(mode)) {
-			struct tree *tree = lookup_tree(sha1);
+	while (tree_entry(&desc, &entry)) {
+		if (S_ISDIR(entry.mode)) {
+			struct tree *tree = lookup_tree(entry.sha1);
 			process_tree(tree);
 		} else {
-			struct blob *blob = lookup_blob(sha1);
+			struct blob *blob = lookup_blob(entry.sha1);
 			process(&blob->object);
 		}
 	}
diff --git a/http-push.c b/http-push.c
index 72ad89c..b1c018a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1715,6 +1715,7 @@ static struct object_list **process_tree
 {
 	struct object *obj = &tree->object;
 	struct tree_desc desc;
+	struct name_entry entry;
 	struct name_path me;
 
 	obj->flags |= LOCAL;
@@ -1734,18 +1735,11 @@ static struct object_list **process_tree
 	desc.buf = tree->buffer;
 	desc.size = tree->size;
 
-	while (desc.size) {
-		unsigned mode;
-		const char *name;
-		const unsigned char *sha1;
-
-		sha1 = tree_entry_extract(&desc, &name, &mode);
-		update_tree_entry(&desc);
-
-		if (S_ISDIR(mode))
-			p = process_tree(lookup_tree(sha1), p, &me, name);
+	while (tree_entry(&desc, &entry)) {
+		if (S_ISDIR(entry.mode))
+			p = process_tree(lookup_tree(entry.sha1), p, &me, name);
 		else
-			p = process_blob(lookup_blob(sha1), p, &me, name);
+			p = process_blob(lookup_blob(entry.sha1), p, &me, name);
 	}
 	free(tree->buffer);
 	tree->buffer = NULL;
diff --git a/pack-objects.c b/pack-objects.c
index 77284cf..3590cd5 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -690,25 +690,20 @@ static void add_pbase_object(struct tree
 			     const char *name,
 			     int cmplen)
 {
-	while (tree->size) {
-		const unsigned char *sha1;
-		const char *entry_name;
-		int entry_len;
-		unsigned mode;
+	struct name_entry entry;
+
+	while (tree_entry(tree,&entry)) {
 		unsigned long size;
 		char type[20];
 
-		sha1 = tree_entry_extract(tree, &entry_name, &mode);
-		update_tree_entry(tree);
-		entry_len = strlen(entry_name);
-		if (entry_len != cmplen ||
-		    memcmp(entry_name, name, cmplen) ||
-		    !has_sha1_file(sha1) ||
-		    sha1_object_info(sha1, type, &size))
+		if (entry.pathlen != cmplen ||
+		    memcmp(entry.path, name, cmplen) ||
+		    !has_sha1_file(entry.sha1) ||
+		    sha1_object_info(entry.sha1, type, &size))
 			continue;
 		if (name[cmplen] != '/') {
 			unsigned hash = name_hash(up, name);
-			add_object_entry(sha1, hash, 1);
+			add_object_entry(entry.sha1, hash, 1);
 			return;
 		}
 		if (!strcmp(type, tree_type)) {
@@ -718,15 +713,15 @@ static void add_pbase_object(struct tree
 			const char *down = name+cmplen+1;
 			int downlen = name_cmp_len(down);
 
-			tree = pbase_tree_get(sha1);
+			tree = pbase_tree_get(entry.sha1);
 			if (!tree)
 				return;
 			sub.buf = tree->tree_data;
 			sub.size = tree->tree_size;
 
 			me.up = up;
-			me.elem = entry_name;
-			me.len = entry_len;
+			me.elem = entry.path;
+			me.len = entry.pathlen;
 			add_pbase_object(&sub, &me, down, downlen);
 			pbase_tree_put(tree);
 		}
diff --git a/revision.c b/revision.c
index 8e93e40..6a6952c 100644
--- a/revision.c
+++ b/revision.c
@@ -54,6 +54,7 @@ static void mark_blob_uninteresting(stru
 void mark_tree_uninteresting(struct tree *tree)
 {
 	struct tree_desc desc;
+	struct name_entry entry;
 	struct object *obj = &tree->object;
 
 	if (obj->flags & UNINTERESTING)
@@ -66,18 +67,11 @@ void mark_tree_uninteresting(struct tree
 
 	desc.buf = tree->buffer;
 	desc.size = tree->size;
-	while (desc.size) {
-		unsigned mode;
-		const char *name;
-		const unsigned char *sha1;
-
-		sha1 = tree_entry_extract(&desc, &name, &mode);
-		update_tree_entry(&desc);
-
-		if (S_ISDIR(mode))
-			mark_tree_uninteresting(lookup_tree(sha1));
+	while (tree_entry(&desc, &entry)) {
+		if (S_ISDIR(entry.mode))
+			mark_tree_uninteresting(lookup_tree(entry.sha1));
 		else
-			mark_blob_uninteresting(lookup_blob(sha1));
+			mark_blob_uninteresting(lookup_blob(entry.sha1));
 	}
 
 	/*
diff --git a/tree-walk.c b/tree-walk.c
index 3922058..297c697 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -37,7 +37,7 @@ static void entry_extract(struct tree_de
 
 void update_tree_entry(struct tree_desc *desc)
 {
-	void *buf = desc->buf;
+	const void *buf = desc->buf;
 	unsigned long size = desc->size;
 	int len = strlen(buf) + 1 + 20;
 
@@ -63,7 +63,7 @@ static const char *get_mode(const char *
 
 const unsigned char *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned int *modep)
 {
-	void *tree = desc->buf;
+	const void *tree = desc->buf;
 	unsigned long size = desc->size;
 	int len = strlen(tree)+1;
 	const unsigned char *sha1 = tree + len;
@@ -78,6 +78,35 @@ const unsigned char *tree_entry_extract(
 	return sha1;
 }
 
+int tree_entry(struct tree_desc *desc, struct name_entry *entry)
+{
+	const void *tree = desc->buf, *path;
+	unsigned long len, size = desc->size;
+
+	if (!size)
+		return 0;
+
+	path = get_mode(tree, &entry->mode);
+	if (!path)
+		die("corrupt tree file");
+
+	entry->path = path;
+	len = strlen(path);
+	entry->pathlen = len;
+
+	path += len + 1;
+	entry->sha1 = path;
+
+	path += 20;
+	len = path - tree;
+	if (len > size)
+		die("corrupt tree file");
+
+	desc->buf = path;
+	desc->size = size - len;
+	return 1;
+}
+
 void traverse_trees(int n, struct tree_desc *t, const char *base, traverse_callback_t callback)
 {
 	struct name_entry *entry = xmalloc(n*sizeof(*entry));
diff --git a/tree-walk.h b/tree-walk.h
index 47438fe..e57befa 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -2,7 +2,7 @@ #ifndef TREE_WALK_H
 #define TREE_WALK_H
 
 struct tree_desc {
-	void *buf;
+	const void *buf;
 	unsigned long size;
 };
 
@@ -16,6 +16,9 @@ struct name_entry {
 void update_tree_entry(struct tree_desc *);
 const unsigned char *tree_entry_extract(struct tree_desc *, const char **, unsigned int *);
 
+/* Helper function that does both of the above and returns true for success */
+int tree_entry(struct tree_desc *, struct name_entry *);
+
 void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1);
 
 typedef void (*traverse_callback_t)(int n, unsigned long mask, struct name_entry *entry, const char *base);
diff --git a/tree.c b/tree.c
index fb18724..9bbe2da 100644
--- a/tree.c
+++ b/tree.c
@@ -79,6 +79,7 @@ int read_tree_recursive(struct tree *tre
 			read_tree_fn_t fn)
 {
 	struct tree_desc desc;
+	struct name_entry entry;
 
 	if (parse_tree(tree))
 		return -1;
@@ -86,18 +87,11 @@ int read_tree_recursive(struct tree *tre
 	desc.buf = tree->buffer;
 	desc.size = tree->size;
 
-	while (desc.size) {
-		unsigned mode;
-		const char *name;
-		const unsigned char *sha1;
-
-		sha1 = tree_entry_extract(&desc, &name, &mode);
-		update_tree_entry(&desc);
-
-		if (!match_tree_entry(base, baselen, name, mode, match))
+	while (tree_entry(&desc, &entry)) {
+		if (!match_tree_entry(base, baselen, entry.path, entry.mode, match))
 			continue;
 
-		switch (fn(sha1, base, baselen, name, mode, stage)) {
+		switch (fn(entry.sha1, base, baselen, entry.path, entry.mode, stage)) {
 		case 0:
 			continue;
 		case READ_TREE_RECURSIVE:
@@ -105,18 +99,17 @@ int read_tree_recursive(struct tree *tre
 		default:
 			return -1;
 		}
-		if (S_ISDIR(mode)) {
+		if (S_ISDIR(entry.mode)) {
 			int retval;
-			int pathlen = strlen(name);
 			char *newbase;
 
-			newbase = xmalloc(baselen + 1 + pathlen);
+			newbase = xmalloc(baselen + 1 + entry.pathlen);
 			memcpy(newbase, base, baselen);
-			memcpy(newbase + baselen, name, pathlen);
-			newbase[baselen + pathlen] = '/';
-			retval = read_tree_recursive(lookup_tree(sha1),
+			memcpy(newbase + baselen, entry.path, entry.pathlen);
+			newbase[baselen + entry.pathlen] = '/';
+			retval = read_tree_recursive(lookup_tree(entry.sha1),
 						     newbase,
-						     baselen + pathlen + 1,
+						     baselen + entry.pathlen + 1,
 						     stage, match, fn);
 			free(newbase);
 			if (retval)
@@ -156,6 +149,7 @@ static int track_tree_refs(struct tree *
 	int n_refs = 0, i;
 	struct object_refs *refs;
 	struct tree_desc desc;
+	struct name_entry entry;
 
 	/* Count how many entries there are.. */
 	desc.buf = item->buffer;
@@ -170,18 +164,13 @@ static int track_tree_refs(struct tree *
 	refs = alloc_object_refs(n_refs);
 	desc.buf = item->buffer;
 	desc.size = item->size;
-	while (desc.size) {
-		unsigned mode;
-		const char *name;
-		const unsigned char *sha1;
+	while (tree_entry(&desc, &entry)) {
 		struct object *obj;
 
-		sha1 = tree_entry_extract(&desc, &name, &mode);
-		update_tree_entry(&desc);
-		if (S_ISDIR(mode))
-			obj = &lookup_tree(sha1)->object;
+		if (S_ISDIR(entry.mode))
+			obj = &lookup_tree(entry.sha1)->object;
 		else
-			obj = &lookup_blob(sha1)->object;
+			obj = &lookup_blob(entry.sha1)->object;
 		refs->ref[i++] = obj;
 	}
 	set_object_refs(&item->object, refs);
