From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/5] Make 'traverse_tree()' use linked structure rather than 'const char *base'
Date: Wed, 5 Mar 2008 18:59:29 -0800
Message-ID: <71685f79add8cb0982d74745cf3277fc2287c306.1204777699.git.torvalds@linux-foundation.org>
References: <cover.1204777699.git.torvalds@linux-foundation.org>
To: undisclosed-recipients:;
X-From: git-owner@vger.kernel.org Thu Mar 06 05:37:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX7rU-0003rr-IW
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 05:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756444AbYCFEhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 23:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756512AbYCFEhH
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 23:37:07 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33804 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756353AbYCFEhF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 23:37:05 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m264bEbd006313
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Mar 2008 20:37:16 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m264atac008862;
	Wed, 5 Mar 2008 20:36:55 -0800
In-Reply-To: <cover.1204777699.git.torvalds@linux-foundation.org>
X-Spam-Status: No, hits=-3.922 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76321>

This makes the calling convention a bit less obvious, but a lot more
flexible.  Instead of allocating and extending a new 'base' string, we
just link the top-most name into a linked list of the 'info' structure
when traversing a subdirectory, and we can generate the basename by
following the list.

Perhaps even more importantly, the linked list of info structures also
gives us a place to naturally save off other information than just the
directory name.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 merge-tree.c |   51 +++++++++++++++++++++++++++------------------------
 tree-walk.c  |   35 +++++++++++++++++++++++++++++++++--
 tree-walk.h  |   20 ++++++++++++++++++--
 3 files changed, 78 insertions(+), 28 deletions(-)

diff --git a/merge-tree.c b/merge-tree.c
index e083246..a3511b7 100644
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
@@ -224,7 +223,7 @@ static int unresolved_directory(const char *base, struct name_entry n[3])
 }
 
 
-static struct merge_list *link_entry(unsigned stage, const char *base, struct name_entry *n, struct merge_list *entry)
+static struct merge_list *link_entry(unsigned stage, const struct traverse_info *info, struct name_entry *n, struct merge_list *entry)
 {
 	const char *path;
 	struct merge_list *link;
@@ -234,17 +233,17 @@ static struct merge_list *link_entry(unsigned stage, const char *base, struct na
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
@@ -252,9 +251,9 @@ static void unresolved(const char *base, struct name_entry n[3])
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
@@ -288,36 +287,40 @@ static void unresolved(const char *base, struct name_entry n[3])
  * The successful merge rules are the same as for the three-way merge
  * in git-read-tree.
  */
-static void threeway_callback(int n, unsigned long mask, struct name_entry *entry, const char *base)
+static void threeway_callback(int n, unsigned long mask, struct name_entry *entry, struct traverse_info *info)
 {
 	/* Same in both? */
 	if (same_entry(entry+1, entry+2)) {
 		if (entry[0].sha1) {
-			resolve(base, NULL, entry+1);
+			resolve(info, NULL, entry+1);
 			return;
 		}
 	}
 
 	if (same_entry(entry+0, entry+1)) {
 		if (entry[2].sha1 && !S_ISDIR(entry[2].mode)) {
-			resolve(base, entry+1, entry+2);
+			resolve(info, entry+1, entry+2);
 			return;
 		}
 	}
 
 	if (same_entry(entry+0, entry+2)) {
 		if (entry[1].sha1 && !S_ISDIR(entry[1].mode)) {
-			resolve(base, NULL, entry+1);
+			resolve(info, NULL, entry+1);
 			return;
 		}
 	}
 
-	unresolved(base, entry);
+	unresolved(info, entry);
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
diff --git a/tree-walk.c b/tree-walk.c
index 142205d..f9f7d22 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -104,7 +104,38 @@ int tree_entry(struct tree_desc *desc, struct name_entry *entry)
 	return 1;
 }
 
-void traverse_trees(int n, struct tree_desc *t, const char *base, traverse_callback_t callback)
+void setup_traverse_info(struct traverse_info *info, const char *base)
+{
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
+void traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 {
 	struct name_entry *entry = xmalloc(n*sizeof(*entry));
 
@@ -150,7 +181,7 @@ void traverse_trees(int n, struct tree_desc *t, const char *base, traverse_callb
 			}
 			entry_clear(entry + i);
 		}
-		callback(n, mask, entry, base);
+		info->fn(n, mask, entry, info);
 	}
 	free(entry);
 }
diff --git a/tree-walk.h b/tree-walk.h
index db0fbdc..7c4ae64 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -33,10 +33,26 @@ int tree_entry(struct tree_desc *, struct name_entry *);
 
 void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1);
 
-typedef void (*traverse_callback_t)(int n, unsigned long mask, struct name_entry *entry, const char *base);
+struct traverse_info;
+typedef void (*traverse_callback_t)(int n, unsigned long mask, struct name_entry *entry, struct traverse_info *);
+void traverse_trees(int n, struct tree_desc *t, struct traverse_info *info);
 
-void traverse_trees(int n, struct tree_desc *t, const char *base, traverse_callback_t callback);
+struct traverse_info {
+	struct traverse_info *prev;
+	struct name_entry name;
+	int pathlen;
+
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
-- 
1.5.4.3.452.g67136


