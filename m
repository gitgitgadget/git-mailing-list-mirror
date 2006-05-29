From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 10/10] Remove last vestiges of generic tree_entry_list
Date: Mon, 29 May 2006 12:21:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605291220550.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon May 29 21:22:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FknJF-00013z-Sa
	for gcvg-git@gmane.org; Mon, 29 May 2006 21:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWE2TVr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 15:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWE2TVr
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 15:21:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25050 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751245AbWE2TVq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 15:21:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4TJLV2g015273
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 May 2006 12:21:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4TJLSrI015705;
	Mon, 29 May 2006 12:21:30 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
X-Spam-Status: No, hits=1.479 required=5 tests=DOMAIN_BODY
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20965>


The old tree_entry_list is dead, long live the unified single tree
parser.

Yes, we now still have a compatibility function to create a bogus
tree_entry_list in builtin-read-tree.c, but that is now entirely local
to that very messy piece of code.

I'd love to clean read-tree.c up too, but I'm too scared right now, so
the best I can do is to just contain the damage, and try to make sure
that no new users of the tree_entry_list sprout up by not having it as
an exported interface any more.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
 builtin-read-tree.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 tree.c              |   42 ------------------------------------------
 tree.h              |   13 -------------
 3 files changed, 43 insertions(+), 55 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 480e6ed..b413e91 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -33,6 +33,16 @@ static struct object_list *trees = NULL;
 static struct cache_entry df_conflict_entry = { 
 };
 
+struct tree_entry_list {
+	struct tree_entry_list *next;
+	unsigned directory : 1;
+	unsigned executable : 1;
+	unsigned symlink : 1;
+	unsigned int mode;
+	const char *name;
+	const unsigned char *sha1;
+};
+
 static struct tree_entry_list df_conflict_list = {
 	.name = NULL,
 	.next = &df_conflict_list
@@ -40,6 +50,39 @@ static struct tree_entry_list df_conflic
 
 typedef int (*merge_fn_t)(struct cache_entry **src);
 
+static struct tree_entry_list *create_tree_entry_list(struct tree *tree)
+{
+	struct tree_desc desc;
+	struct tree_entry_list *ret = NULL;
+	struct tree_entry_list **list_p = &ret;
+
+	desc.buf = tree->buffer;
+	desc.size = tree->size;
+
+	while (desc.size) {
+		unsigned mode;
+		const char *path;
+		const unsigned char *sha1;
+		struct tree_entry_list *entry;
+
+		sha1 = tree_entry_extract(&desc, &path, &mode);
+		update_tree_entry(&desc);
+
+		entry = xmalloc(sizeof(struct tree_entry_list));
+		entry->name = path;
+		entry->sha1 = sha1;
+		entry->mode = mode;
+		entry->directory = S_ISDIR(mode) != 0;
+		entry->executable = (mode & S_IXUSR) != 0;
+		entry->symlink = S_ISLNK(mode) != 0;
+		entry->next = NULL;
+
+		*list_p = entry;
+		list_p = &entry->next;
+	}
+	return ret;
+}
+
 static int entcmp(const char *name1, int dir1, const char *name2, int dir2)
 {
 	int len1 = strlen(name1);
diff --git a/tree.c b/tree.c
index 47318ef..fb18724 100644
--- a/tree.c
+++ b/tree.c
@@ -201,48 +201,6 @@ int parse_tree_buffer(struct tree *item,
 	return 0;
 }
 
-struct tree_entry_list *create_tree_entry_list(struct tree *tree)
-{
-	struct tree_desc desc;
-	struct tree_entry_list *ret = NULL;
-	struct tree_entry_list **list_p = &ret;
-
-	desc.buf = tree->buffer;
-	desc.size = tree->size;
-
-	while (desc.size) {
-		unsigned mode;
-		const char *path;
-		const unsigned char *sha1;
-		struct tree_entry_list *entry;
-
-		sha1 = tree_entry_extract(&desc, &path, &mode);
-		update_tree_entry(&desc);
-
-		entry = xmalloc(sizeof(struct tree_entry_list));
-		entry->name = path;
-		entry->sha1 = sha1;
-		entry->mode = mode;
-		entry->directory = S_ISDIR(mode) != 0;
-		entry->executable = (mode & S_IXUSR) != 0;
-		entry->symlink = S_ISLNK(mode) != 0;
-		entry->next = NULL;
-
-		*list_p = entry;
-		list_p = &entry->next;
-	}
-	return ret;
-}
-
-void free_tree_entry_list(struct tree_entry_list *list)
-{
-	while (list) {
-		struct tree_entry_list *next = list->next;
-		free(list);
-		list = next;
-	}
-}
-
 int parse_tree(struct tree *item)
 {
 	 char type[20];
diff --git a/tree.h b/tree.h
index 6a87546..dd25c53 100644
--- a/tree.h
+++ b/tree.h
@@ -5,25 +5,12 @@ #include "object.h"
 
 extern const char *tree_type;
 
-struct tree_entry_list {
-	struct tree_entry_list *next;
-	unsigned directory : 1;
-	unsigned executable : 1;
-	unsigned symlink : 1;
-	unsigned int mode;
-	const char *name;
-	const unsigned char *sha1;
-};
-
 struct tree {
 	struct object object;
 	void *buffer;
 	unsigned long size;
 };
 
-struct tree_entry_list *create_tree_entry_list(struct tree *);
-void free_tree_entry_list(struct tree_entry_list *);
-
 struct tree *lookup_tree(const unsigned char *sha1);
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size);
-- 
1.3.3.gcd01d
