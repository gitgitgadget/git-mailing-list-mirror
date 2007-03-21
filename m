From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/3] Switch over tree descriptors to contain a pre-parsed
 entry
Date: Wed, 21 Mar 2007 10:09:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703211008290.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703210955370.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 21 18:10:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU4Kb-0002kQ-3e
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 18:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933148AbXCURKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 13:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933144AbXCURKF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 13:10:05 -0400
Received: from smtp.osdl.org ([65.172.181.24]:44336 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933138AbXCURKC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 13:10:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2LH9ucD029143
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Mar 2007 10:09:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2LH9us4030881;
	Wed, 21 Mar 2007 09:09:56 -0800
In-Reply-To: <Pine.LNX.4.64.0703210955370.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.972 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42806>


This makes the tree descriptor contain a "struct name_entry" as part of 
it, and it gets filled in so that it always contains a valid entry. On 
some benchmarks, it improves performance by up to 15%.

That makes tree entry "extract" trivial, and means that we only actually
need to decode each tree entry just once: we decode the first one when
we initialize the tree descriptor, and each subsequent one when doing
"update_tree_entry()".  In particular, this means that we don't need to
do strlen() both at extract time _and_ at update time.

Finally, it also allows more sharing of code (entry_extract(), that
wanted a "struct name_entry", just got totally trivial, along with the
"tree_entry()" function).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 tree-walk.c |  101 +++++++++++++++++++++++++---------------------------------
 tree-walk.h |   18 +++++++---
 2 files changed, 57 insertions(+), 62 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index c65492c..3cb757b 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -2,10 +2,42 @@
 #include "tree-walk.h"
 #include "tree.h"
 
+static const char *get_mode(const char *str, unsigned int *modep)
+{
+	unsigned char c;
+	unsigned int mode = 0;
+
+	while ((c = *str++) != ' ') {
+		if (c < '0' || c > '7')
+			return NULL;
+		mode = (mode << 3) + (c - '0');
+	}
+	*modep = mode;
+	return str;
+}
+
+static void decode_tree_entry(struct tree_desc *desc, const void *buf, unsigned long size)
+{
+	const char *path;
+	unsigned int mode, len;
+
+	path = get_mode(buf, &mode);
+	if (!path)
+		die("corrupt tree file");
+	len = strlen(path) + 1;
+
+	/* Initialize the descriptor entry */
+	desc->entry.path = path;
+	desc->entry.mode = mode;
+	desc->entry.sha1 = (const unsigned char *)(path + len);
+}
+
 void init_tree_desc(struct tree_desc *desc, const void *buffer, unsigned long size)
 {
 	desc->buffer = buffer;
 	desc->size = size;
+	if (size)
+		decode_tree_entry(desc, buffer, size);
 }
 
 void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1)
@@ -36,78 +68,33 @@ static void entry_clear(struct name_entry *a)
 
 static void entry_extract(struct tree_desc *t, struct name_entry *a)
 {
-	a->sha1 = tree_entry_extract(t, &a->path, &a->mode);
+	*a = t->entry;
 }
 
 void update_tree_entry(struct tree_desc *desc)
 {
 	const void *buf = desc->buffer;
+	const void *end = desc->entry.sha1 + 20;
 	unsigned long size = desc->size;
-	int len = strlen(buf) + 1 + 20;
+	unsigned long len = end - buf;
 
 	if (size < len)
 		die("corrupt tree file");
-	desc->buffer = (char *) buf + len;
-	desc->size = size - len;
-}
-
-static const char *get_mode(const char *str, unsigned int *modep)
-{
-	unsigned char c;
-	unsigned int mode = 0;
-
-	while ((c = *str++) != ' ') {
-		if (c < '0' || c > '7')
-			return NULL;
-		mode = (mode << 3) + (c - '0');
-	}
-	*modep = mode;
-	return str;
-}
-
-const unsigned char *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned int *modep)
-{
-	const void *tree = desc->buffer;
-	unsigned long size = desc->size;
-	int len = strlen(tree)+1;
-	const unsigned char *sha1 = (unsigned char *) tree + len;
-	const char *path;
-	unsigned int mode;
-
-	path = get_mode(tree, &mode);
-	if (!path || size < len + 20)
-		die("corrupt tree file");
-	*pathp = path;
-	*modep = canon_mode(mode);
-	return sha1;
+	buf = end;
+	size -= len;
+	desc->buffer = buf;
+	desc->size = size;
+	if (size)
+		decode_tree_entry(desc, buf, size);
 }
 
 int tree_entry(struct tree_desc *desc, struct name_entry *entry)
 {
-	const void *tree = desc->buffer;
-	const char *path;
-	unsigned long len, size = desc->size;
-
-	if (!size)
+	if (!desc->size)
 		return 0;
 
-	path = get_mode(tree, &entry->mode);
-	if (!path)
-		die("corrupt tree file");
-
-	entry->path = path;
-	len = strlen(path);
-
-	path += len + 1;
-	entry->sha1 = (const unsigned char *) path;
-
-	path += 20;
-	len = path - (char *) tree;
-	if (len > size)
-		die("corrupt tree file");
-
-	desc->buffer = path;
-	desc->size = size - len;
+	*entry = desc->entry;
+	update_tree_entry(desc);
 	return 1;
 }
 
diff --git a/tree-walk.h b/tree-walk.h
index ca0c29f..43458cf 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -1,17 +1,25 @@
 #ifndef TREE_WALK_H
 #define TREE_WALK_H
 
-struct tree_desc {
-	const void *buffer;
-	unsigned int size;
-};
-
 struct name_entry {
 	const unsigned char *sha1;
 	const char *path;
 	unsigned int mode;
 };
 
+struct tree_desc {
+	const void *buffer;
+	struct name_entry entry;
+	unsigned int size;
+};
+
+static inline const unsigned char *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned int *modep)
+{
+	*pathp = desc->entry.path;
+	*modep = canon_mode(desc->entry.mode);
+	return desc->entry.sha1;
+}
+
 static inline int tree_entry_len(const char *name, const unsigned char *sha1)
 {
 	return (char *)sha1 - (char *)name - 1;
-- 
1.5.1.rc1.13.g0872-dirty
