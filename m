From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/3] Remove "pathlen" from "struct name_entry"
Date: Wed, 21 Mar 2007 10:07:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703211007160.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703210955370.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 21 18:08:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU4IG-0001fq-Mk
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 18:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933140AbXCURHy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 13:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933144AbXCURHy
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 13:07:54 -0400
Received: from smtp.osdl.org ([65.172.181.24]:44222 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933140AbXCURHx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 13:07:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2LH7lcD029034
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Mar 2007 10:07:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2LH7khM030854;
	Wed, 21 Mar 2007 09:07:47 -0800
In-Reply-To: <Pine.LNX.4.64.0703210955370.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.97 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42804>


Since we have the "tree_entry_len()" helper function these days, and
don't need to do a full strlen(), there's no point in saving the path
length - it's just redundant information.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 builtin-grep.c         |    2 +-
 builtin-pack-objects.c |    2 +-
 merge-tree.c           |    9 +++++----
 tree-walk.c            |    6 ++----
 tree-walk.h            |    1 -
 tree.c                 |    9 +++++----
 6 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 4510d35..1348cc9 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -378,7 +378,7 @@ static int grep_tree(struct grep_opt *opt, const char **paths,
 			 * decide if we want to descend into "abc"
 			 * directory.
 			 */
-			strcpy(path_buf + len + entry.pathlen, "/");
+			strcpy(path_buf + len + tree_entry_len(entry.path, entry.sha1), "/");
 
 		if (!pathspec_matches(paths, down))
 			;
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 73d448b..9231b65 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -854,7 +854,7 @@ static void add_pbase_object(struct tree_desc *tree,
 		unsigned long size;
 		enum object_type type;
 
-		if (entry.pathlen != cmplen ||
+		if (tree_entry_len(entry.path, entry.sha1) != cmplen ||
 		    memcmp(entry.path, name, cmplen) ||
 		    !has_sha1_file(entry.sha1) ||
 		    (type = sha1_object_info(entry.sha1, &size)) < 0)
diff --git a/merge-tree.c b/merge-tree.c
index b2867ba..3b8d9e6 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -188,7 +188,7 @@ static void resolve(const char *base, struct name_entry *branch1, struct name_en
 
 static int unresolved_directory(const char *base, struct name_entry n[3])
 {
-	int baselen;
+	int baselen, pathlen;
 	char *newbase;
 	struct name_entry *p;
 	struct tree_desc t[3];
@@ -205,10 +205,11 @@ static int unresolved_directory(const char *base, struct name_entry n[3])
 	if (!S_ISDIR(p->mode))
 		return 0;
 	baselen = strlen(base);
-	newbase = xmalloc(baselen + p->pathlen + 2);
+	pathlen = tree_entry_len(p->path, p->sha1);
+	newbase = xmalloc(baselen + pathlen + 2);
 	memcpy(newbase, base, baselen);
-	memcpy(newbase + baselen, p->path, p->pathlen);
-	memcpy(newbase + baselen + p->pathlen, "/", 2);
+	memcpy(newbase + baselen, p->path, pathlen);
+	memcpy(newbase + baselen + pathlen, "/", 2);
 
 	buf0 = fill_tree_descriptor(t+0, n[0].sha1);
 	buf1 = fill_tree_descriptor(t+1, n[1].sha1);
diff --git a/tree-walk.c b/tree-walk.c
index a4a4e2a..1869bae 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -20,8 +20,8 @@ void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1)
 static int entry_compare(struct name_entry *a, struct name_entry *b)
 {
 	return base_name_compare(
-			a->path, a->pathlen, a->mode,
-			b->path, b->pathlen, b->mode);
+			a->path, tree_entry_len(a->path, a->sha1), a->mode,
+			b->path, tree_entry_len(b->path, b->sha1), b->mode);
 }
 
 static void entry_clear(struct name_entry *a)
@@ -32,7 +32,6 @@ static void entry_clear(struct name_entry *a)
 static void entry_extract(struct tree_desc *t, struct name_entry *a)
 {
 	a->sha1 = tree_entry_extract(t, &a->path, &a->mode);
-	a->pathlen = tree_entry_len(a->path, a->sha1);
 }
 
 void update_tree_entry(struct tree_desc *desc)
@@ -93,7 +92,6 @@ int tree_entry(struct tree_desc *desc, struct name_entry *entry)
 
 	entry->path = path;
 	len = strlen(path);
-	entry->pathlen = len;
 
 	path += len + 1;
 	entry->sha1 = (const unsigned char *) path;
diff --git a/tree-walk.h b/tree-walk.h
index a0d7afd..149393a 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -10,7 +10,6 @@ struct name_entry {
 	const unsigned char *sha1;
 	const char *path;
 	unsigned int mode;
-	int pathlen;
 };
 
 static inline int tree_entry_len(const char *name, const unsigned char *sha1)
diff --git a/tree.c b/tree.c
index 24f8fb6..705a481 100644
--- a/tree.c
+++ b/tree.c
@@ -101,14 +101,15 @@ int read_tree_recursive(struct tree *tree,
 		if (S_ISDIR(entry.mode)) {
 			int retval;
 			char *newbase;
+			unsigned int pathlen = tree_entry_len(entry.path, entry.sha1);
 
-			newbase = xmalloc(baselen + 1 + entry.pathlen);
+			newbase = xmalloc(baselen + 1 + pathlen);
 			memcpy(newbase, base, baselen);
-			memcpy(newbase + baselen, entry.path, entry.pathlen);
-			newbase[baselen + entry.pathlen] = '/';
+			memcpy(newbase + baselen, entry.path, pathlen);
+			newbase[baselen + pathlen] = '/';
 			retval = read_tree_recursive(lookup_tree(entry.sha1),
 						     newbase,
-						     baselen + entry.pathlen + 1,
+						     baselen + pathlen + 1,
 						     stage, match, fn);
 			free(newbase);
 			if (retval)
-- 
1.5.1.rc1.13.g0872-dirty
