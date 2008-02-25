From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 05/10] builtin-fsck: move common object checking code to fsck.c
Date: Mon, 25 Feb 2008 22:54:55 +0100
Message-ID: <12039765002397-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12039765002329-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765004039-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765003484-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765002219-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 22:56:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTlIm-0006Td-MJ
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 22:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756526AbYBYVzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 16:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759792AbYBYVzS
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 16:55:18 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:55599 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759495AbYBYVzE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 16:55:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id D448D6CF006A;
	Mon, 25 Feb 2008 22:55:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FGbPHtDja0vZ; Mon, 25 Feb 2008 22:55:00 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 4E3E2680BF93; Mon, 25 Feb 2008 22:55:00 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12039765002219-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75074>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-fsck.c |  270 +++++++------------------------------------------------
 fsck.c         |  222 ++++++++++++++++++++++++++++++++++++++++++++++
 fsck.h         |    7 ++
 3 files changed, 264 insertions(+), 235 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 198466c..3b21745 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -55,13 +55,13 @@ static int objerror(struct object *obj, const char *err, ...)
 	return -1;
 }
 
-static int objwarning(struct object *obj, const char *err, ...)
+static int fsck_error_func(struct object *obj, int type, const char *err, ...)
 {
 	va_list params;
 	va_start(params, err);
-	objreport(obj, "warning", err, params);
+	objreport(obj, (type == FSCK_WARN)?"warning":"error", err, params);
 	va_end(params);
-	return -1;
+	return (type == FSCK_WARN)?0:1;
 }
 
 static int mark_object(struct object *obj, int type, void *data)
@@ -247,256 +247,56 @@ static void check_connectivity(void)
 	}
 }
 
-/*
- * The entries in a tree are ordered in the _path_ order,
- * which means that a directory entry is ordered by adding
- * a slash to the end of it.
- *
- * So a directory called "a" is ordered _after_ a file
- * called "a.c", because "a/" sorts after "a.c".
- */
-#define TREE_UNORDERED (-1)
-#define TREE_HAS_DUPS  (-2)
-
-static int verify_ordered(unsigned mode1, const char *name1, unsigned mode2, const char *name2)
+static int fsck_sha1(const unsigned char *sha1)
 {
-	int len1 = strlen(name1);
-	int len2 = strlen(name2);
-	int len = len1 < len2 ? len1 : len2;
-	unsigned char c1, c2;
-	int cmp;
-
-	cmp = memcmp(name1, name2, len);
-	if (cmp < 0)
+	struct object *obj = parse_object(sha1);
+	if (!obj) {
+		errors_found |= ERROR_OBJECT;
+		return error("%s: object corrupt or missing",
+			     sha1_to_hex(sha1));
+	}
+	if (obj->flags & SEEN)
 		return 0;
-	if (cmp > 0)
-		return TREE_UNORDERED;
-
-	/*
-	 * Ok, the first <len> characters are the same.
-	 * Now we need to order the next one, but turn
-	 * a '\0' into a '/' for a directory entry.
-	 */
-	c1 = name1[len];
-	c2 = name2[len];
-	if (!c1 && !c2)
-		/*
-		 * git-write-tree used to write out a nonsense tree that has
-		 * entries with the same name, one blob and one tree.  Make
-		 * sure we do not have duplicate entries.
-		 */
-		return TREE_HAS_DUPS;
-	if (!c1 && S_ISDIR(mode1))
-		c1 = '/';
-	if (!c2 && S_ISDIR(mode2))
-		c2 = '/';
-	return c1 < c2 ? 0 : TREE_UNORDERED;
-}
-
-static int fsck_tree(struct tree *item)
-{
-	int retval;
-	int has_full_path = 0;
-	int has_empty_name = 0;
-	int has_zero_pad = 0;
-	int has_bad_modes = 0;
-	int has_dup_entries = 0;
-	int not_properly_sorted = 0;
-	struct tree_desc desc;
-	unsigned o_mode;
-	const char *o_name;
-	const unsigned char *o_sha1;
+	obj->flags |= SEEN;
 
 	if (verbose)
-		fprintf(stderr, "Checking tree %s\n",
-				sha1_to_hex(item->object.sha1));
-
-	init_tree_desc(&desc, item->buffer, item->size);
-
-	o_mode = 0;
-	o_name = NULL;
-	o_sha1 = NULL;
-	while (desc.size) {
-		unsigned mode;
-		const char *name;
-		const unsigned char *sha1;
-
-		sha1 = tree_entry_extract(&desc, &name, &mode);
-
-		if (strchr(name, '/'))
-			has_full_path = 1;
-		if (!*name)
-			has_empty_name = 1;
-		has_zero_pad |= *(char *)desc.buffer == '0';
-		update_tree_entry(&desc);
-
-		switch (mode) {
-		/*
-		 * Standard modes..
-		 */
-		case S_IFREG | 0755:
-		case S_IFREG | 0644:
-		case S_IFLNK:
-		case S_IFDIR:
-		case S_IFGITLINK:
-			break;
-		/*
-		 * This is nonstandard, but we had a few of these
-		 * early on when we honored the full set of mode
-		 * bits..
-		 */
-		case S_IFREG | 0664:
-			if (!check_strict)
-				break;
-		default:
-			has_bad_modes = 1;
-		}
+		fprintf(stderr, "Checking %s %s\n",
+			typename(obj->type), sha1_to_hex(obj->sha1));
 
-		if (o_name) {
-			switch (verify_ordered(o_mode, o_name, mode, name)) {
-			case TREE_UNORDERED:
-				not_properly_sorted = 1;
-				break;
-			case TREE_HAS_DUPS:
-				has_dup_entries = 1;
-				break;
-			default:
-				break;
-			}
-		}
+	if(fsck_walk (obj, mark_used, 0))
+		objerror(obj, "broken links");
+	if (fsck_object (obj, check_strict, fsck_error_func))
+		return -1;
 
-		o_mode = mode;
-		o_name = name;
-		o_sha1 = sha1;
-	}
-	free(item->buffer);
-	item->buffer = NULL;
+	if (obj->type == OBJ_TREE) {
+		struct tree *item = (struct tree*) obj;
 
-	retval = 0;
-	if (has_full_path) {
-		objwarning(&item->object, "contains full pathnames");
-	}
-	if (has_empty_name) {
-		objwarning(&item->object, "contains empty pathname");
-	}
-	if (has_zero_pad) {
-		objwarning(&item->object, "contains zero-padded file modes");
-	}
-	if (has_bad_modes) {
-		objwarning(&item->object, "contains bad file modes");
+		free(item->buffer);
+		item->buffer = NULL;
 	}
-	if (has_dup_entries) {
-		retval = objerror(&item->object, "contains duplicate file entries");
-	}
-	if (not_properly_sorted) {
-		retval = objerror(&item->object, "not properly sorted");
-	}
-	return retval;
-}
 
-static int fsck_commit(struct commit *commit)
-{
-	char *buffer = commit->buffer;
-	unsigned char tree_sha1[20], sha1[20];
-	struct commit_graft *graft;
-	int parents = 0;
+	if (obj->type == OBJ_COMMIT) {
+		struct commit *commit = (struct commit*) obj;
 
-	if (verbose)
-		fprintf(stderr, "Checking commit %s\n",
-			sha1_to_hex(commit->object.sha1));
-
-	if (!commit->date)
-		return objerror(&commit->object, "invalid author/committer line");
-
-	if (memcmp(buffer, "tree ", 5))
-		return objerror(&commit->object, "invalid format - expected 'tree' line");
-	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
-		return objerror(&commit->object, "invalid 'tree' line format - bad sha1");
-	buffer += 46;
-	while (!memcmp(buffer, "parent ", 7)) {
-		if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
-			return objerror(&commit->object, "invalid 'parent' line format - bad sha1");
-		buffer += 48;
-		parents++;
-	}
-	graft = lookup_commit_graft(commit->object.sha1);
-	if (graft) {
-		struct commit_list *p = commit->parents;
-		parents = 0;
-		while (p) {
-			p = p->next;
-			parents++;
-		}
-		if (graft->nr_parent == -1 && !parents)
-			; /* shallow commit */
-		else if (graft->nr_parent != parents)
-			return objerror(&commit->object, "graft objects missing");
-	} else {
-		struct commit_list *p = commit->parents;
-		while (p && parents) {
-			p = p->next;
-			parents--;
-		}
-		if (p || parents)
-			return objerror(&commit->object, "parent objects missing");
-	}
-	if (memcmp(buffer, "author ", 7))
-		return objerror(&commit->object, "invalid format - expected 'author' line");
-	free(commit->buffer);
-	commit->buffer = NULL;
-	if (!commit->tree)
-		return objerror(&commit->object, "could not load commit's tree %s", tree_sha1);
-	if (!commit->parents && show_root)
-		printf("root %s\n", sha1_to_hex(commit->object.sha1));
-	return 0;
-}
+		free(commit->buffer);
+		commit->buffer = NULL;
 
-static int fsck_tag(struct tag *tag)
-{
-	struct object *tagged = tag->tagged;
+		if (!commit->parents && show_root)
+			printf("root %s\n", sha1_to_hex(commit->object.sha1));
+	}
 
-	if (verbose)
-		fprintf(stderr, "Checking tag %s\n",
-			sha1_to_hex(tag->object.sha1));
+	if (obj->type == OBJ_TAG) {
+		struct tag *tag = (struct tag*) obj;
 
-	if (!tagged) {
-		return objerror(&tag->object, "could not load tagged object");
+		if (show_tags && tag->tagged) {
+			printf("tagged %s %s", typename(tag->tagged->type), sha1_to_hex(tag->tagged->sha1));
+			printf(" (%s) in %s\n", tag->tag, sha1_to_hex(tag->object.sha1));
+		}
 	}
-	if (!show_tags)
-		return 0;
 
-	printf("tagged %s %s", typename(tagged->type), sha1_to_hex(tagged->sha1));
-	printf(" (%s) in %s\n", tag->tag, sha1_to_hex(tag->object.sha1));
 	return 0;
 }
 
-static int fsck_sha1(const unsigned char *sha1)
-{
-	struct object *obj = parse_object(sha1);
-	if (!obj) {
-		errors_found |= ERROR_OBJECT;
-		return error("%s: object corrupt or missing",
-			     sha1_to_hex(sha1));
-	}
-	if (obj->flags & SEEN)
-		return 0;
-	obj->flags |= SEEN;
-	if (fsck_walk(obj, mark_used, 0))
-		objerror(obj, "broken links");
-	if (obj->type == OBJ_BLOB)
-		return 0;
-	if (obj->type == OBJ_TREE)
-		return fsck_tree((struct tree *) obj);
-	if (obj->type == OBJ_COMMIT)
-		return fsck_commit((struct commit *) obj);
-	if (obj->type == OBJ_TAG)
-		return fsck_tag((struct tag *) obj);
-
-	/* By now, parse_object() would've returned NULL instead. */
-	return objerror(obj, "unknown type '%d' (internal fsck error)",
-			obj->type);
-}
-
 /*
  * This is the sorting chunk size: make it reasonably
  * big so that we can sort well..
diff --git a/fsck.c b/fsck.c
index b7f9354..3ce33ff 100644
--- a/fsck.c
+++ b/fsck.c
@@ -89,3 +89,225 @@ int fsck_walk(struct object *obj, fsck_walk_func walk, void *data)
 		return -1;
 	}
 }
+
+/*
+ * The entries in a tree are ordered in the _path_ order,
+ * which means that a directory entry is ordered by adding
+ * a slash to the end of it.
+ *
+ * So a directory called "a" is ordered _after_ a file
+ * called "a.c", because "a/" sorts after "a.c".
+ */
+#define TREE_UNORDERED (-1)
+#define TREE_HAS_DUPS  (-2)
+
+static int verify_ordered(unsigned mode1, const char *name1, unsigned mode2, const char *name2)
+{
+	int len1 = strlen(name1);
+	int len2 = strlen(name2);
+	int len = len1 < len2 ? len1 : len2;
+	unsigned char c1, c2;
+	int cmp;
+
+	cmp = memcmp(name1, name2, len);
+	if (cmp < 0)
+		return 0;
+	if (cmp > 0)
+		return TREE_UNORDERED;
+
+	/*
+	 * Ok, the first <len> characters are the same.
+	 * Now we need to order the next one, but turn
+	 * a '\0' into a '/' for a directory entry.
+	 */
+	c1 = name1[len];
+	c2 = name2[len];
+	if (!c1 && !c2)
+		/*
+		 * git-write-tree used to write out a nonsense tree that has
+		 * entries with the same name, one blob and one tree.  Make
+		 * sure we do not have duplicate entries.
+		 */
+		return TREE_HAS_DUPS;
+	if (!c1 && S_ISDIR(mode1))
+		c1 = '/';
+	if (!c2 && S_ISDIR(mode2))
+		c2 = '/';
+	return c1 < c2 ? 0 : TREE_UNORDERED;
+}
+
+static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
+{
+	int retval;
+	int has_full_path = 0;
+	int has_empty_name = 0;
+	int has_zero_pad = 0;
+	int has_bad_modes = 0;
+	int has_dup_entries = 0;
+	int not_properly_sorted = 0;
+	struct tree_desc desc;
+	unsigned o_mode;
+	const char *o_name;
+	const unsigned char *o_sha1;
+
+	init_tree_desc(&desc, item->buffer, item->size);
+
+	o_mode = 0;
+	o_name = NULL;
+	o_sha1 = NULL;
+	if (!desc.size)
+		return error_func (&item->object, FSCK_ERROR, "empty tree");
+
+	while (desc.size) {
+		unsigned mode;
+		const char *name;
+		const unsigned char *sha1;
+
+		sha1 = tree_entry_extract(&desc, &name, &mode);
+
+		if (strchr(name, '/'))
+			has_full_path = 1;
+		if (!*name)
+			has_empty_name = 1;
+		has_zero_pad |= *(char *)desc.buffer == '0';
+		update_tree_entry(&desc);
+
+		switch (mode) {
+		/*
+		 * Standard modes..
+		 */
+		case S_IFREG | 0755:
+		case S_IFREG | 0644:
+		case S_IFLNK:
+		case S_IFDIR:
+		case S_IFGITLINK:
+			break;
+		/*
+		 * This is nonstandard, but we had a few of these
+		 * early on when we honored the full set of mode
+		 * bits..
+		 */
+		case S_IFREG | 0664:
+			if (!strict)
+				break;
+		default:
+			has_bad_modes = 1;
+		}
+
+		if (o_name) {
+			switch (verify_ordered(o_mode, o_name, mode, name)) {
+			case TREE_UNORDERED:
+				not_properly_sorted = 1;
+				break;
+			case TREE_HAS_DUPS:
+				has_dup_entries = 1;
+				break;
+			default:
+				break;
+			}
+		}
+
+		o_mode = mode;
+		o_name = name;
+		o_sha1 = sha1;
+	}
+
+	retval = 0;
+	if (has_full_path) {
+		retval += error_func(&item->object, FSCK_WARN, "contains full pathnames");
+	}
+	if (has_empty_name) {
+		retval += error_func(&item->object, FSCK_WARN, "contains empty pathname");
+	}
+	if (has_zero_pad) {
+		retval += error_func(&item->object, FSCK_WARN, "contains zero-padded file modes");
+	}
+	if (has_bad_modes) {
+		retval += error_func(&item->object, FSCK_WARN, "contains bad file modes");
+	}
+	if (has_dup_entries) {
+		retval += error_func(&item->object, FSCK_ERROR, "contains duplicate file entries");
+	}
+	if (not_properly_sorted) {
+		retval += error_func(&item->object, FSCK_ERROR, "not properly sorted");
+	}
+	return retval;
+}
+
+static int fsck_commit(struct commit *commit, fsck_error error_func)
+{
+	char *buffer = commit->buffer;
+	unsigned char tree_sha1[20], sha1[20];
+	struct commit_graft *graft;
+	int parents = 0;
+
+	if (!commit->date)
+		return error_func(&commit->object, FSCK_ERROR, "invalid author/committer line");
+
+	if (memcmp(buffer, "tree ", 5))
+		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
+	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
+		return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
+	buffer += 46;
+	while (!memcmp(buffer, "parent ", 7)) {
+		if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
+			return error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
+		buffer += 48;
+		parents++;
+	}
+	graft = lookup_commit_graft(commit->object.sha1);
+	if (graft) {
+		struct commit_list *p = commit->parents;
+		parents = 0;
+		while (p) {
+			p = p->next;
+			parents++;
+		}
+		if (graft->nr_parent == -1 && !parents)
+			; /* shallow commit */
+		else if (graft->nr_parent != parents)
+			return error_func(&commit->object, FSCK_ERROR, "graft objects missing");
+	} else {
+		struct commit_list *p = commit->parents;
+		while (p && parents) {
+			p = p->next;
+			parents--;
+		}
+		if (p || parents)
+			return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
+	}
+	if (memcmp(buffer, "author ", 7))
+		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
+	if (!commit->tree)
+		return error_func(&commit->object, FSCK_ERROR, "could not load commit's tree %s", sha1_to_hex(tree_sha1));
+
+	return 0;
+}
+
+static int fsck_tag(struct tag *tag, fsck_error error_func)
+{
+	struct object *tagged = tag->tagged;
+
+	if (!tagged) {
+		return error_func(&tag->object, FSCK_ERROR, "could not load tagged object");
+	}
+	return 0;
+}
+
+int fsck_object(struct object *obj, int strict, fsck_error error_func)
+{
+	if (!obj)
+		return error_func(obj, FSCK_ERROR, "no valid object to fsck");
+
+	if (obj->type == OBJ_BLOB)
+		return 0;
+	if (obj->type == OBJ_TREE)
+		return fsck_tree((struct tree *) obj, strict, error_func);
+	if (obj->type == OBJ_COMMIT)
+		return fsck_commit((struct commit *) obj, error_func);
+	if (obj->type == OBJ_TAG)
+		return fsck_tag((struct tag *) obj, error_func);
+
+	return error_func(obj, FSCK_ERROR, "unknown type '%d' (internal fsck error)",
+			  obj->type);
+}
diff --git a/fsck.h b/fsck.h
index 4a1f02a..a5d60d0 100644
--- a/fsck.h
+++ b/fsck.h
@@ -1,6 +1,9 @@
 #ifndef GIT_FSCK_H
 #define GIT_FSCK_H
 
+#define FSCK_ERROR 1
+#define FSCK_WARN 2
+
 /* 
  * callback function for fsck_walk
  * type is the expected type of the object or OBJ_ANY
@@ -11,6 +14,9 @@
  */
 typedef int (*fsck_walk_func)(struct object *obj, int type, void *data);
 
+/* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
+typedef int (*fsck_error)(struct object *obj, int type, const char *err, ...);
+
 /* descend in all linked child objects
  * the return value is:
  *    -1	error in processing the object
@@ -19,5 +25,6 @@ typedef int (*fsck_walk_func)(struct object *obj, int type, void *data);
  *    0		everything OK
  */
 int fsck_walk(struct object *obj, fsck_walk_func walk, void *data);
+int fsck_object(struct object *obj, int strict, fsck_error error_func);
 
 #endif
-- 
1.5.4.3.g3c5f
