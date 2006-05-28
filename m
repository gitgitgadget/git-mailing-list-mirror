From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2/4] Make "tree_entry" have a SHA1 instead of a union of
 object pointers
Date: Sun, 28 May 2006 15:10:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605281507110.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0605281453460.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon May 29 00:10:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkTSh-0005DK-Oc
	for gcvg-git@gmane.org; Mon, 29 May 2006 00:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWE1WKM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 18:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbWE1WKM
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 18:10:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13954 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750998AbWE1WKK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 18:10:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4SMA52g030548
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 28 May 2006 15:10:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4SMA4aK015812;
	Sun, 28 May 2006 15:10:05 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605281453460.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20903>


This is preparatory work for further cleanups, where we try to make
tree_entry look more like the more efficient tree-walk descriptor.

Instead of having a union of pointers to blob/tree/objects, this just 
makes "struct tree_entry" have the raw SHA1, and makes all the users use 
that instead (often that implies adding a "lookup_tree(..)" on the sha1, 
but sometimes the user just wanted the SHA1 in the first place, and it 
just avoids an unnecessary indirection).

Signed-off-by: Linus Torvalds <torvalds@osdl.org>

---
 blame.c             |    4 ++--
 builtin-read-tree.c |    7 ++++---
 builtin-rev-list.c  |    4 ++--
 fsck-objects.c      |    1 +
 http-push.c         |    4 ++--
 object.c            |    2 +-
 revision.c          |    4 ++--
 tree.c              |   25 ++++++++++++++-----------
 tree.h              |    8 ++------
 9 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/blame.c b/blame.c
index 99ceea8..88bfec2 100644
--- a/blame.c
+++ b/blame.c
@@ -149,7 +149,7 @@ static void free_patch(struct patch *p)
 	free(p);
 }
 
-static int get_blob_sha1_internal(unsigned char *sha1, const char *base,
+static int get_blob_sha1_internal(const unsigned char *sha1, const char *base,
 				  int baselen, const char *pathname,
 				  unsigned mode, int stage);
 
@@ -178,7 +178,7 @@ static int get_blob_sha1(struct tree *t,
 	return 0;
 }
 
-static int get_blob_sha1_internal(unsigned char *sha1, const char *base,
+static int get_blob_sha1_internal(const unsigned char *sha1, const char *base,
 				  int baselen, const char *pathname,
 				  unsigned mode, int stage)
 {
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 740a8c7..f0b8dad 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -160,9 +160,10 @@ #endif
 			}
 
 			if (posns[i]->directory) {
+				struct tree *tree = lookup_tree(posns[i]->sha1);
 				any_dirs = 1;
-				parse_tree(posns[i]->item.tree);
-				subposns[i] = posns[i]->item.tree->entries;
+				parse_tree(tree);
+				subposns[i] = tree->entries;
 				posns[i] = posns[i]->next;
 				src[i + merge] = &df_conflict_entry;
 				continue;
@@ -186,7 +187,7 @@ #endif
 
 			any_files = 1;
 
-			memcpy(ce->sha1, posns[i]->item.any->sha1, 20);
+			memcpy(ce->sha1, posns[i]->sha1, 20);
 			src[i + merge] = ce;
 			subposns[i] = &df_conflict_list;
 			posns[i] = posns[i]->next;
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 72c1549..94f520b 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -133,9 +133,9 @@ static struct object_list **process_tree
 	while (entry) {
 		struct tree_entry_list *next = entry->next;
 		if (entry->directory)
-			p = process_tree(entry->item.tree, p, &me, entry->name);
+			p = process_tree(lookup_tree(entry->sha1), p, &me, entry->name);
 		else
-			p = process_blob(entry->item.blob, p, &me, entry->name);
+			p = process_blob(lookup_blob(entry->sha1), p, &me, entry->name);
 		free(entry);
 		entry = next;
 	}
diff --git a/fsck-objects.c b/fsck-objects.c
index a0290b0..44b6465 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -441,6 +441,7 @@ int main(int argc, char **argv)
 {
 	int i, heads;
 
+	track_object_refs = 1;
 	setup_git_directory();
 
 	for (i = 1; i < argc; i++) {
diff --git a/http-push.c b/http-push.c
index b4327d9..f492a5d 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1733,9 +1733,9 @@ static struct object_list **process_tree
 	while (entry) {
 		struct tree_entry_list *next = entry->next;
 		if (entry->directory)
-			p = process_tree(entry->item.tree, p, &me, entry->name);
+			p = process_tree(lookup_tree(entry->sha1), p, &me, entry->name);
 		else
-			p = process_blob(entry->item.blob, p, &me, entry->name);
+			p = process_blob(lookup_blob(entry->sha1), p, &me, entry->name);
 		free(entry);
 		entry = next;
 	}
diff --git a/object.c b/object.c
index 1a7823c..9adc874 100644
--- a/object.c
+++ b/object.c
@@ -9,7 +9,7 @@ struct object **objs;
 static int nr_objs;
 int obj_allocs;
 
-int track_object_refs = 1;
+int track_object_refs = 0;
 
 static int hashtable_index(const unsigned char *sha1)
 {
diff --git a/revision.c b/revision.c
index 2294b16..35f8e3b 100644
--- a/revision.c
+++ b/revision.c
@@ -68,9 +68,9 @@ void mark_tree_uninteresting(struct tree
 	while (entry) {
 		struct tree_entry_list *next = entry->next;
 		if (entry->directory)
-			mark_tree_uninteresting(entry->item.tree);
+			mark_tree_uninteresting(lookup_tree(entry->sha1));
 		else
-			mark_blob_uninteresting(entry->item.blob);
+			mark_blob_uninteresting(lookup_blob(entry->sha1));
 		free(entry);
 		entry = next;
 	}
diff --git a/tree.c b/tree.c
index 1e76d9c..ba8742c 100644
--- a/tree.c
+++ b/tree.c
@@ -8,7 +8,7 @@ #include <stdlib.h>
 
 const char *tree_type = "tree";
 
-static int read_one_entry(unsigned char *sha1, const char *base, int baselen, const char *pathname, unsigned mode, int stage)
+static int read_one_entry(const unsigned char *sha1, const char *base, int baselen, const char *pathname, unsigned mode, int stage)
 {
 	int len;
 	unsigned int size;
@@ -89,7 +89,7 @@ int read_tree_recursive(struct tree *tre
 				      current->mode, match))
 			continue;
 
-		switch (fn(current->item.any->sha1, base, baselen,
+		switch (fn(current->sha1, base, baselen,
 			   current->name, current->mode, stage)) {
 		case 0:
 			continue;
@@ -107,7 +107,7 @@ int read_tree_recursive(struct tree *tre
 			memcpy(newbase, base, baselen);
 			memcpy(newbase + baselen, current->name, pathlen);
 			newbase[baselen + pathlen] = '/';
-			retval = read_tree_recursive(current->item.tree,
+			retval = read_tree_recursive(lookup_tree(current->sha1),
 						     newbase,
 						     baselen + pathlen + 1,
 						     stage, match, fn);
@@ -170,6 +170,7 @@ int parse_tree_buffer(struct tree *item,
 
 		entry = xmalloc(sizeof(struct tree_entry_list));
 		entry->name = path;
+		entry->sha1 = sha1;
 		entry->mode = mode;
 		entry->directory = S_ISDIR(mode) != 0;
 		entry->executable = (mode & S_IXUSR) != 0;
@@ -178,12 +179,6 @@ int parse_tree_buffer(struct tree *item,
 		entry->next = NULL;
 
 		update_tree_entry(&desc);
-
-		if (entry->directory) {
-			entry->item.tree = lookup_tree(sha1);
-		} else {
-			entry->item.blob = lookup_blob(sha1);
-		}
 		n_refs++;
 		*list_p = entry;
 		list_p = &entry->next;
@@ -193,8 +188,16 @@ int parse_tree_buffer(struct tree *item,
 		struct tree_entry_list *entry;
 		unsigned i = 0;
 		struct object_refs *refs = alloc_object_refs(n_refs);
-		for (entry = item->entries; entry; entry = entry->next)
-			refs->ref[i++] = entry->item.any;
+		for (entry = item->entries; entry; entry = entry->next) {
+			struct object *obj;
+
+			if (entry->directory)
+				obj = &lookup_tree(entry->sha1)->object;
+			else
+				obj = &lookup_blob(entry->sha1)->object;
+			refs->ref[i++] = obj;
+		}
+				
 		set_object_refs(&item->object, refs);
 	}
 
diff --git a/tree.h b/tree.h
index 066ac5d..a27bae4 100644
--- a/tree.h
+++ b/tree.h
@@ -13,11 +13,7 @@ struct tree_entry_list {
 	unsigned zeropad : 1;
 	unsigned int mode;
 	const char *name;
-	union {
-		struct object *any;
-		struct tree *tree;
-		struct blob *blob;
-	} item;
+	const unsigned char *sha1;
 };
 
 struct tree {
@@ -37,7 +33,7 @@ int parse_tree(struct tree *tree);
 struct tree *parse_tree_indirect(const unsigned char *sha1);
 
 #define READ_TREE_RECURSIVE 1
-typedef int (*read_tree_fn_t)(unsigned char *, const char *, int, const char *, unsigned int, int);
+typedef int (*read_tree_fn_t)(const unsigned char *, const char *, int, const char *, unsigned int, int);
 
 extern int read_tree_recursive(struct tree *tree,
 			       const char *base, int baselen,
