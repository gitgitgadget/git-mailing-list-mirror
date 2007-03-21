From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/3] Initialize tree descriptors with a helper function rather
 than by hand.
Date: Wed, 21 Mar 2007 10:08:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703211007480.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703210955370.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 21 18:08:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU4Io-0001vO-SO
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 18:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933104AbXCURIg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 13:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933138AbXCURIg
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 13:08:36 -0400
Received: from smtp.osdl.org ([65.172.181.24]:44266 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933104AbXCURIf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 13:08:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2LH8QcD029067
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Mar 2007 10:08:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2LH8P8Z030863;
	Wed, 21 Mar 2007 09:08:26 -0800
In-Reply-To: <Pine.LNX.4.64.0703210955370.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.97 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42805>


This removes slightly more lines than it adds, but the real reason for
doing this is that future optimizations will require more setup of the
tree descriptor, and so we want to do it in one place.

Also renamed the "desc.buf" field to "desc.buffer" just to trigger
compiler errors for old-style manual initializations, making sure I
didn't miss anything.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 builtin-fsck.c         |    5 ++---
 builtin-grep.c         |   11 +++++++----
 builtin-pack-objects.c |    6 ++----
 builtin-read-tree.c    |    3 +--
 builtin-reflog.c       |   10 +++++-----
 fetch.c                |    3 +--
 http-push.c            |    3 +--
 list-objects.c         |    3 +--
 reachable.c            |    3 +--
 revision.c             |   12 +++++-------
 tree-diff.c            |   22 ++++++++++++----------
 tree-walk.c            |   24 +++++++++++++++---------
 tree-walk.h            |    5 +++--
 tree.c                 |    9 +++------
 unpack-trees.c         |    3 +--
 15 files changed, 60 insertions(+), 62 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index b8e71b6..21f1f9e 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -227,8 +227,7 @@ static int fsck_tree(struct tree *item)
 	const char *o_name;
 	const unsigned char *o_sha1;
 
-	desc.buf = item->buffer;
-	desc.size = item->size;
+	init_tree_desc(&desc, item->buffer, item->size);
 
 	o_mode = 0;
 	o_name = NULL;
@@ -242,7 +241,7 @@ static int fsck_tree(struct tree *item)
 
 		if (strchr(name, '/'))
 			has_full_path = 1;
-		has_zero_pad |= *(char *)desc.buf == '0';
+		has_zero_pad |= *(char *)desc.buffer == '0';
 		update_tree_entry(&desc);
 
 		switch (mode) {
diff --git a/builtin-grep.c b/builtin-grep.c
index 1348cc9..981f3d4 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -388,11 +388,13 @@ static int grep_tree(struct grep_opt *opt, const char **paths,
 			enum object_type type;
 			struct tree_desc sub;
 			void *data;
-			data = read_sha1_file(entry.sha1, &type, &sub.size);
+			unsigned long size;
+
+			data = read_sha1_file(entry.sha1, &type, &size);
 			if (!data)
 				die("unable to read tree (%s)",
 				    sha1_to_hex(entry.sha1));
-			sub.buf = data;
+			init_tree_desc(&sub, data, size);
 			hit |= grep_tree(opt, paths, &sub, tree_name, down);
 			free(data);
 		}
@@ -408,12 +410,13 @@ static int grep_object(struct grep_opt *opt, const char **paths,
 	if (obj->type == OBJ_COMMIT || obj->type == OBJ_TREE) {
 		struct tree_desc tree;
 		void *data;
+		unsigned long size;
 		int hit;
 		data = read_object_with_reference(obj->sha1, tree_type,
-						  &tree.size, NULL);
+						  &size, NULL);
 		if (!data)
 			die("unable to read tree (%s)", sha1_to_hex(obj->sha1));
-		tree.buf = data;
+		init_tree_desc(&tree, data, size);
 		hit = grep_tree(opt, paths, &tree, name, "");
 		free(data);
 		return hit;
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 9231b65..b5f9648 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -873,8 +873,7 @@ static void add_pbase_object(struct tree_desc *tree,
 			tree = pbase_tree_get(entry.sha1);
 			if (!tree)
 				return;
-			sub.buf = tree->tree_data;
-			sub.size = tree->tree_size;
+			init_tree_desc(&sub, tree->tree_data, tree->tree_size);
 
 			add_pbase_object(&sub, down, downlen, fullname);
 			pbase_tree_put(tree);
@@ -937,8 +936,7 @@ static void add_preferred_base_object(const char *name, unsigned hash)
 		}
 		else {
 			struct tree_desc tree;
-			tree.buf = it->pcache.tree_data;
-			tree.size = it->pcache.tree_size;
+			init_tree_desc(&tree, it->pcache.tree_data, it->pcache.tree_size);
 			add_pbase_object(&tree, name, cmplen, name);
 		}
 	}
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index e477155..82df941 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -55,8 +55,7 @@ static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
 	int cnt;
 
 	hashcpy(it->sha1, tree->object.sha1);
-	desc.buf = tree->buffer;
-	desc.size = tree->size;
+	init_tree_desc(&desc, tree->buffer, tree->size);
 	cnt = 0;
 	while (tree_entry(&desc, &entry)) {
 		if (!S_ISDIR(entry.mode))
diff --git a/builtin-reflog.c b/builtin-reflog.c
index 186aabc..4c39f1d 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -52,18 +52,18 @@ static int tree_is_complete(const unsigned char *sha1)
 	if (tree->object.flags & INCOMPLETE)
 		return 0;
 
-	desc.buf = tree->buffer;
-	desc.size = tree->size;
-	if (!desc.buf) {
+	if (!tree->buffer) {
 		enum object_type type;
-		void *data = read_sha1_file(sha1, &type, &desc.size);
+		unsigned long size;
+		void *data = read_sha1_file(sha1, &type, &size);
 		if (!data) {
 			tree->object.flags |= INCOMPLETE;
 			return 0;
 		}
-		desc.buf = data;
 		tree->buffer = data;
+		tree->size = size;
 	}
+	init_tree_desc(&desc, tree->buffer, tree->size);
 	complete = 1;
 	while (tree_entry(&desc, &entry)) {
 		if (!has_sha1_file(entry.sha1) ||
diff --git a/fetch.c b/fetch.c
index f69be82..8e29d31 100644
--- a/fetch.c
+++ b/fetch.c
@@ -42,8 +42,7 @@ static int process_tree(struct tree *tree)
 	if (parse_tree(tree))
 		return -1;
 
-	desc.buf = tree->buffer;
-	desc.size = tree->size;
+	init_tree_desc(&desc, tree->buffer, tree->size);
 	while (tree_entry(&desc, &entry)) {
 		struct object *obj = NULL;
 
diff --git a/http-push.c b/http-push.c
index cbb02d3..724720c 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1750,8 +1750,7 @@ static struct object_list **process_tree(struct tree *tree,
 	me.elem = name;
 	me.elem_len = strlen(name);
 
-	desc.buf = tree->buffer;
-	desc.size = tree->size;
+	init_tree_desc(&desc, tree->buffer, tree->size);
 
 	while (tree_entry(&desc, &entry)) {
 		if (S_ISDIR(entry.mode))
diff --git a/list-objects.c b/list-objects.c
index f1fa21c..2ba2c95 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -49,8 +49,7 @@ static void process_tree(struct rev_info *revs,
 	me.elem = name;
 	me.elem_len = strlen(name);
 
-	desc.buf = tree->buffer;
-	desc.size = tree->size;
+	init_tree_desc(&desc, tree->buffer, tree->size);
 
 	while (tree_entry(&desc, &entry)) {
 		if (S_ISDIR(entry.mode))
diff --git a/reachable.c b/reachable.c
index 01760d7..ff3dd34 100644
--- a/reachable.c
+++ b/reachable.c
@@ -42,8 +42,7 @@ static void process_tree(struct tree *tree,
 	me.elem = name;
 	me.elem_len = strlen(name);
 
-	desc.buf = tree->buffer;
-	desc.size = tree->size;
+	init_tree_desc(&desc, tree->buffer, tree->size);
 
 	while (tree_entry(&desc, &entry)) {
 		if (S_ISDIR(entry.mode))
diff --git a/revision.c b/revision.c
index c680dcb..adc381c 100644
--- a/revision.c
+++ b/revision.c
@@ -62,8 +62,7 @@ void mark_tree_uninteresting(struct tree *tree)
 	if (parse_tree(tree) < 0)
 		die("bad tree %s", sha1_to_hex(obj->sha1));
 
-	desc.buf = tree->buffer;
-	desc.size = tree->size;
+	init_tree_desc(&desc, tree->buffer, tree->size);
 	while (tree_entry(&desc, &entry)) {
 		if (S_ISDIR(entry.mode))
 			mark_tree_uninteresting(lookup_tree(entry.sha1));
@@ -275,18 +274,17 @@ int rev_same_tree_as_empty(struct rev_info *revs, struct tree *t1)
 {
 	int retval;
 	void *tree;
+	unsigned long size;
 	struct tree_desc empty, real;
 
 	if (!t1)
 		return 0;
 
-	tree = read_object_with_reference(t1->object.sha1, tree_type, &real.size, NULL);
+	tree = read_object_with_reference(t1->object.sha1, tree_type, &size, NULL);
 	if (!tree)
 		return 0;
-	real.buf = tree;
-
-	empty.buf = "";
-	empty.size = 0;
+	init_tree_desc(&real, tree, size);
+	init_tree_desc(&empty, "", 0);
 
 	tree_difference = REV_TREE_SAME;
 	revs->pruning.has_changes = 0;
diff --git a/tree-diff.c b/tree-diff.c
index b2f35dc..3678805 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -154,12 +154,13 @@ static void show_entry(struct diff_options *opt, const char *prefix, struct tree
 		char *newbase = malloc_base(base, baselen, path, pathlen);
 		struct tree_desc inner;
 		void *tree;
+		unsigned long size;
 
-		tree = read_sha1_file(sha1, &type, &inner.size);
+		tree = read_sha1_file(sha1, &type, &size);
 		if (!tree || type != OBJ_TREE)
 			die("corrupt tree sha %s", sha1_to_hex(sha1));
 
-		inner.buf = tree;
+		init_tree_desc(&inner, tree, size);
 		show_tree(opt, prefix, &inner, newbase, baselen + 1 + pathlen);
 
 		free(tree);
@@ -227,16 +228,17 @@ int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const cha
 {
 	void *tree1, *tree2;
 	struct tree_desc t1, t2;
+	unsigned long size1, size2;
 	int retval;
 
-	tree1 = read_object_with_reference(old, tree_type, &t1.size, NULL);
+	tree1 = read_object_with_reference(old, tree_type, &size1, NULL);
 	if (!tree1)
 		die("unable to read source tree (%s)", sha1_to_hex(old));
-	tree2 = read_object_with_reference(new, tree_type, &t2.size, NULL);
+	tree2 = read_object_with_reference(new, tree_type, &size2, NULL);
 	if (!tree2)
 		die("unable to read destination tree (%s)", sha1_to_hex(new));
-	t1.buf = tree1;
-	t2.buf = tree2;
+	init_tree_desc(&t1, tree1, size1);
+	init_tree_desc(&t2, tree2, size2);
 	retval = diff_tree(&t1, &t2, base, opt);
 	free(tree1);
 	free(tree2);
@@ -247,15 +249,15 @@ int diff_root_tree_sha1(const unsigned char *new, const char *base, struct diff_
 {
 	int retval;
 	void *tree;
+	unsigned long size;
 	struct tree_desc empty, real;
 
-	tree = read_object_with_reference(new, tree_type, &real.size, NULL);
+	tree = read_object_with_reference(new, tree_type, &size, NULL);
 	if (!tree)
 		die("unable to read root tree (%s)", sha1_to_hex(new));
-	real.buf = tree;
+	init_tree_desc(&real, tree, size);
 
-	empty.size = 0;
-	empty.buf = "";
+	init_tree_desc(&empty, "", 0);
 	retval = diff_tree(&empty, &real, base, opt);
 	free(tree);
 	return retval;
diff --git a/tree-walk.c b/tree-walk.c
index 1869bae..c65492c 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -2,6 +2,12 @@
 #include "tree-walk.h"
 #include "tree.h"
 
+void init_tree_desc(struct tree_desc *desc, const void *buffer, unsigned long size)
+{
+	desc->buffer = buffer;
+	desc->size = size;
+}
+
 void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1)
 {
 	unsigned long size = 0;
@@ -12,8 +18,7 @@ void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1)
 		if (!buf)
 			die("unable to read tree %s", sha1_to_hex(sha1));
 	}
-	desc->size = size;
-	desc->buf = buf;
+	init_tree_desc(desc, buf, size);
 	return buf;
 }
 
@@ -36,13 +41,13 @@ static void entry_extract(struct tree_desc *t, struct name_entry *a)
 
 void update_tree_entry(struct tree_desc *desc)
 {
-	const void *buf = desc->buf;
+	const void *buf = desc->buffer;
 	unsigned long size = desc->size;
 	int len = strlen(buf) + 1 + 20;
 
 	if (size < len)
 		die("corrupt tree file");
-	desc->buf = (char *) buf + len;
+	desc->buffer = (char *) buf + len;
 	desc->size = size - len;
 }
 
@@ -62,7 +67,7 @@ static const char *get_mode(const char *str, unsigned int *modep)
 
 const unsigned char *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned int *modep)
 {
-	const void *tree = desc->buf;
+	const void *tree = desc->buffer;
 	unsigned long size = desc->size;
 	int len = strlen(tree)+1;
 	const unsigned char *sha1 = (unsigned char *) tree + len;
@@ -79,7 +84,7 @@ const unsigned char *tree_entry_extract(struct tree_desc *desc, const char **pat
 
 int tree_entry(struct tree_desc *desc, struct name_entry *entry)
 {
-	const void *tree = desc->buf;
+	const void *tree = desc->buffer;
 	const char *path;
 	unsigned long len, size = desc->size;
 
@@ -101,7 +106,7 @@ int tree_entry(struct tree_desc *desc, struct name_entry *entry)
 	if (len > size)
 		die("corrupt tree file");
 
-	desc->buf = path;
+	desc->buffer = path;
 	desc->size = size - len;
 	return 1;
 }
@@ -196,10 +201,11 @@ int get_tree_entry(const unsigned char *tree_sha1, const char *name, unsigned ch
 {
 	int retval;
 	void *tree;
+	unsigned long size;
 	struct tree_desc t;
 	unsigned char root[20];
 
-	tree = read_object_with_reference(tree_sha1, tree_type, &t.size, root);
+	tree = read_object_with_reference(tree_sha1, tree_type, &size, root);
 	if (!tree)
 		return -1;
 
@@ -208,7 +214,7 @@ int get_tree_entry(const unsigned char *tree_sha1, const char *name, unsigned ch
 		return 0;
 	}
 
-	t.buf = tree;
+	init_tree_desc(&t, tree, size);
 	retval = find_tree_entry(&t, name, sha1, mode);
 	free(tree);
 	return retval;
diff --git a/tree-walk.h b/tree-walk.h
index 149393a..ca0c29f 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -2,8 +2,8 @@
 #define TREE_WALK_H
 
 struct tree_desc {
-	const void *buf;
-	unsigned long size;
+	const void *buffer;
+	unsigned int size;
 };
 
 struct name_entry {
@@ -18,6 +18,7 @@ static inline int tree_entry_len(const char *name, const unsigned char *sha1)
 }
 
 void update_tree_entry(struct tree_desc *);
+void init_tree_desc(struct tree_desc *desc, const void *buf, unsigned long size);
 const unsigned char *tree_entry_extract(struct tree_desc *, const char **, unsigned int *);
 
 /* Helper function that does both of the above and returns true for success */
diff --git a/tree.c b/tree.c
index 705a481..d188c0f 100644
--- a/tree.c
+++ b/tree.c
@@ -83,8 +83,7 @@ int read_tree_recursive(struct tree *tree,
 	if (parse_tree(tree))
 		return -1;
 
-	desc.buf = tree->buffer;
-	desc.size = tree->size;
+	init_tree_desc(&desc, tree->buffer, tree->size);
 
 	while (tree_entry(&desc, &entry)) {
 		if (!match_tree_entry(base, baselen, entry.path, entry.mode, match))
@@ -152,16 +151,14 @@ static void track_tree_refs(struct tree *item)
 	struct name_entry entry;
 
 	/* Count how many entries there are.. */
-	desc.buf = item->buffer;
-	desc.size = item->size;
+	init_tree_desc(&desc, item->buffer, item->size);
 	while (tree_entry(&desc, &entry))
 		n_refs++;
 
 	/* Allocate object refs and walk it again.. */
 	i = 0;
 	refs = alloc_object_refs(n_refs);
-	desc.buf = item->buffer;
-	desc.size = item->size;
+	init_tree_desc(&desc, item->buffer, item->size);
 	while (tree_entry(&desc, &entry)) {
 		struct object *obj;
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 2e2232c..ee10eea 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -27,8 +27,7 @@ static struct tree_entry_list *create_tree_entry_list(struct tree *tree)
 	if (!tree->object.parsed)
 		parse_tree(tree);
 
-	desc.buf = tree->buffer;
-	desc.size = tree->size;
+	init_tree_desc(&desc, tree->buffer, tree->size);
 
 	while (tree_entry(&desc, &one)) {
 		struct tree_entry_list *entry;
-- 
1.5.1.rc1.13.g0872-dirty
