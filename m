From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Rename and extend read_tree_with_tree_or_commit_sha1
Date: Thu, 28 Apr 2005 12:15:43 -0700
Message-ID: <7vu0lq7lwg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 21:12:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DREPy-0003kG-RZ
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 21:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVD1TQt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 15:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbVD1TQt
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 15:16:49 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:15055 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262237AbVD1TPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 15:15:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428191542.DQIV20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Apr 2005 15:15:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch renames read_tree_with_tree_or_commit_sha1() to
read_object_with_reference() and extends it to automatically
dereference not just "commit" objects but "tag" objects.  With
this patch, you can say e.g.:

    ls-tree $tag
    read-tree -m $(merge-base $tag $HEAD) $tag $HEAD
    diff-cache $tag
    diff-tree $tag $HEAD

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

cache.h      |    7 +++---
diff-cache.c |    2 -
diff-tree.c  |    4 +--
git-mktag.c  |    2 -
ls-tree.c    |    2 -
read-tree.c  |    2 -
sha1_file.c  |   67 +++++++++++++++++++++++++++++++----------------------------
7 files changed, 46 insertions(+), 40 deletions(-)

# - 04/28 11:25 Show Index: line from built-in diff driver.
# + 04/28 11:59 Rename and extend read_tree_with_tree_or_commit_sha1
Index: cache.h
--- k/cache.h  (mode:100644)
+++ l/cache.h  (mode:100644)
@@ -143,9 +143,10 @@ extern int error(const char *err, ...);
 
 extern int cache_name_compare(const char *name1, int len1, const char *name2, int len2);
 
-extern void *read_tree_with_tree_or_commit_sha1(const unsigned char *sha1,
-						unsigned long *size,
-						unsigned char *tree_sha1_ret);
+extern void *read_object_with_reference(const unsigned char *sha1,
+					const unsigned char *required_type,
+					unsigned long *size,
+					unsigned char *sha1_ret);
 
 static inline void *xmalloc(int size)
 {
Index: diff-cache.c
--- k/diff-cache.c  (mode:100644)
+++ l/diff-cache.c  (mode:100644)
@@ -180,7 +180,7 @@ int main(int argc, char **argv)
 
 	mark_merge_entries();
 
-	tree = read_tree_with_tree_or_commit_sha1(tree_sha1, &size, 0);
+	tree = read_object_with_reference(tree_sha1, "tree", &size, 0);
 	if (!tree)
 		die("bad tree object %s", argv[1]);
 	if (read_tree(tree, size, 1))
Index: diff-tree.c
--- k/diff-tree.c  (mode:100644)
+++ l/diff-tree.c  (mode:100644)
@@ -238,10 +238,10 @@ static int diff_tree_sha1(const unsigned
 	unsigned long size1, size2;
 	int retval;
 
-	tree1 = read_tree_with_tree_or_commit_sha1(old, &size1, 0);
+	tree1 = read_object_with_reference(old, "tree", &size1, 0);
 	if (!tree1)
 		die("unable to read source tree (%s)", sha1_to_hex(old));
-	tree2 = read_tree_with_tree_or_commit_sha1(new, &size2, 0);
+	tree2 = read_object_with_reference(new, "tree", &size2, 0);
 	if (!tree2)
 		die("unable to read destination tree (%s)", sha1_to_hex(new));
 	retval = diff_tree(tree1, size1, tree2, size2, base);
Index: git-mktag.c
--- k/git-mktag.c  (mode:100644)
+++ l/git-mktag.c  (mode:100644)
@@ -114,7 +114,7 @@ int main(int argc, char **argv)
 	// Read the signature
 	size = read(0, buffer, MAXSIZE);
 
-	// Verify it for some basic sanity: it needs to start with "object <sha1>\ntag "
+	// Verify it for some basic sanity: it needs to start with "object <sha1>\ntype "
 	if (verify_tag(buffer, size) < 0)
 		die("invalid tag signature file");
 
Index: ls-tree.c
--- k/ls-tree.c  (mode:100644)
+++ l/ls-tree.c  (mode:100644)
@@ -73,7 +73,7 @@ static int list(unsigned char *sha1)
 	void *buffer;
 	unsigned long size;
 
-	buffer = read_tree_with_tree_or_commit_sha1(sha1, &size, 0);
+	buffer = read_object_with_reference(sha1, "tree", &size, 0);
 	if (!buffer)
 		die("unable to read sha1 file");
 	list_recursive(buffer, "tree", size, NULL);
Index: read-tree.c
--- k/read-tree.c  (mode:100644)
+++ l/read-tree.c  (mode:100644)
@@ -12,7 +12,7 @@ static int unpack_tree(unsigned char *sh
 	void *buffer;
 	unsigned long size;
 
-	buffer = read_tree_with_tree_or_commit_sha1(sha1, &size, 0);
+	buffer = read_object_with_reference(sha1, "tree", &size, 0);
 	if (!buffer)
 		return -1;
 	return read_tree(buffer, size, stage);
Index: sha1_file.c
--- k/sha1_file.c  (mode:100644)
+++ l/sha1_file.c  (mode:100644)
@@ -189,44 +189,49 @@ void * read_sha1_file(const unsigned cha
 	return NULL;
 }
 
-void *read_tree_with_tree_or_commit_sha1(const unsigned char *sha1,
-					 unsigned long *size,
-					 unsigned char *tree_sha1_return)
+void *read_object_with_reference(const unsigned char *sha1,
+				 const unsigned char *required_type,
+				 unsigned long *size,
+				 unsigned char *actual_sha1_return)
 {
 	char type[20];
 	void *buffer;
 	unsigned long isize;
-	int was_commit = 0;
-	unsigned char tree_sha1[20];
+	unsigned char actual_sha1[20];
 
-	buffer = read_sha1_file(sha1, type, &isize);
-
-	/* 
-	 * We might have read a commit instead of a tree, in which case
-	 * we parse out the tree_sha1 and attempt to read from there.
-	 * (buffer + 5) is because the tree sha1 is always at offset 5
-	 * in a commit record ("tree ").
-	 */
-	if (buffer &&
-	    !strcmp(type, "commit") &&
-	    !get_sha1_hex(buffer + 5, tree_sha1)) {
-		free(buffer);
-		buffer = read_sha1_file(tree_sha1, type, &isize);
-		was_commit = 1;
-	}
+	memcpy(actual_sha1, sha1, 20);
+	while (1) {
+		int ref_length = -1;
+		const char *ref_type = NULL;
+
+		buffer = read_sha1_file(actual_sha1, type, &isize);
+		if (!buffer)
+			return NULL;
+		if (!strcmp(type, required_type)) {
+			*size = isize;
+			if (actual_sha1_return)
+				memcpy(actual_sha1_return, actual_sha1, 20);
+			return buffer;
+		}
+		/* Handle references */
+		else if (!strcmp(type, "commit"))
+			ref_type = "tree ";
+		else if (!strcmp(type, "tag"))
+			ref_type = "object ";
+		else {
+			free(buffer);
+			return NULL;
+		}
+		ref_length = strlen(ref_type);
 
-	/*
-	 * Now do we have something and if so is it a tree?
-	 */
-	if (!buffer || strcmp(type, "tree")) {
-		free(buffer);
-		return NULL;
+		if (memcmp(buffer, ref_type, ref_length) ||
+		    get_sha1_hex(buffer + ref_length, actual_sha1)) {
+			free(buffer);
+			return NULL;
+		}
+		/* Now we have the ID of the referred-to object in
+		 * actual_sha1.  Check again. */
 	}
-
-	*size = isize;
-	if (tree_sha1_return)
-		memcpy(tree_sha1_return, was_commit ? tree_sha1 : sha1, 20);
-	return buffer;
 }
 
 int write_sha1_file(char *buf, unsigned long len, const char *type, unsigned char *returnsha1)

