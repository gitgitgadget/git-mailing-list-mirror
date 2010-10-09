From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 06/21] notes.h/c: Propagate combine_notes_fn return value to add_note() and beyond
Date: Sat,  9 Oct 2010 03:11:26 +0200
Message-ID: <1286586701-3586-7-git-send-email-johan@herland.net>
References: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 03:13:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4Nzv-0002nk-JJ
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 03:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760047Ab0JIBND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 21:13:03 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:63598 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759990Ab0JIBNC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 21:13:02 -0400
Received: from pd9587e9f.dip.t-dialin.net ([217.88.126.159] helo=localhost.localdomain)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1P4Nzg-0001bt-Ew; Sat, 09 Oct 2010 03:13:00 +0200
X-Mailer: git-send-email 1.7.3.1.104.g92b87a
In-Reply-To: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158558>

The combine_notes_fn functions uses a non-zero return value to indicate
failure. However, this return value was converted to a call to die()
in note_tree_insert().

Instead, propagate this return value out to add_note(), and return it
from there to enable the caller to handle errors appropriately.

Existing add_note() callers are updated to die() upon failure, thus
preserving the current behaviour. The only exceptions are copy_note()
and notes_cache_put() where we are able to propagate the add_note()
return value instead.

This patch has been improved by the following contributions:
- Jonathan Nieder: Future-proof by always checking add_note() return value

Cc: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/notes.c |   11 +++++----
 notes-cache.c   |    3 +-
 notes.c         |   59 ++++++++++++++++++++++++++++--------------------------
 notes.h         |   11 +++++++--
 4 files changed, 46 insertions(+), 38 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index fbc347c..35f6eb6 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -573,8 +573,8 @@ static int add(int argc, const char **argv, const char *prefix)
 
 	if (is_null_sha1(new_note))
 		remove_note(t, object);
-	else
-		add_note(t, object, new_note, combine_notes_overwrite);
+	else if (add_note(t, object, new_note, combine_notes_overwrite))
+		die("confused: combine_notes_overwrite failed");
 
 	snprintf(logmsg, sizeof(logmsg), "Notes %s by 'git notes %s'",
 		 is_null_sha1(new_note) ? "removed" : "added", "add");
@@ -653,7 +653,8 @@ static int copy(int argc, const char **argv, const char *prefix)
 		goto out;
 	}
 
-	add_note(t, object, from_note, combine_notes_overwrite);
+	if (add_note(t, object, from_note, combine_notes_overwrite))
+		die("confused: combine_notes_overwrite failed");
 	commit_notes(t, "Notes added by 'git notes copy'");
 out:
 	free_notes(t);
@@ -712,8 +713,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 
 	if (is_null_sha1(new_note))
 		remove_note(t, object);
-	else
-		add_note(t, object, new_note, combine_notes_overwrite);
+	else if (add_note(t, object, new_note, combine_notes_overwrite))
+		die("confused: combine_notes_overwrite failed");
 
 	snprintf(logmsg, sizeof(logmsg), "Notes %s by 'git notes %s'",
 		 is_null_sha1(new_note) ? "removed" : "added", argv[0]);
diff --git a/notes-cache.c b/notes-cache.c
index dee6d62..4c8984e 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -89,6 +89,5 @@ int notes_cache_put(struct notes_cache *c, unsigned char key_sha1[20],
 
 	if (write_sha1_file(data, size, "blob", value_sha1) < 0)
 		return -1;
-	add_note(&c->tree, key_sha1, value_sha1, NULL);
-	return 0;
+	return add_note(&c->tree, key_sha1, value_sha1, NULL);
 }
diff --git a/notes.c b/notes.c
index 0c13a36..c4203ce 100644
--- a/notes.c
+++ b/notes.c
@@ -235,13 +235,14 @@ static void note_tree_remove(struct notes_tree *t, struct int_node *tree,
  * - Else, create a new int_node, holding both the node-at-location and the
  *   node-to-be-inserted, and store the new int_node into the location.
  */
-static void note_tree_insert(struct notes_tree *t, struct int_node *tree,
+static int note_tree_insert(struct notes_tree *t, struct int_node *tree,
 		unsigned char n, struct leaf_node *entry, unsigned char type,
 		combine_notes_fn combine_notes)
 {
 	struct int_node *new_node;
 	struct leaf_node *l;
 	void **p = note_tree_search(t, &tree, &n, entry->key_sha1);
+	int ret = 0;
 
 	assert(GET_PTR_TYPE(entry) == 0); /* no type bits set */
 	l = (struct leaf_node *) CLR_PTR_TYPE(*p);
@@ -252,26 +253,21 @@ static void note_tree_insert(struct notes_tree *t, struct int_node *tree,
 			free(entry);
 		else
 			*p = SET_PTR_TYPE(entry, type);
-		return;
+		return 0;
 	case PTR_TYPE_NOTE:
 		switch (type) {
 		case PTR_TYPE_NOTE:
 			if (!hashcmp(l->key_sha1, entry->key_sha1)) {
 				/* skip concatenation if l == entry */
 				if (!hashcmp(l->val_sha1, entry->val_sha1))
-					return;
+					return 0;
 
-				if (combine_notes(l->val_sha1, entry->val_sha1))
-					die("failed to combine notes %s and %s"
-					    " for object %s",
-					    sha1_to_hex(l->val_sha1),
-					    sha1_to_hex(entry->val_sha1),
-					    sha1_to_hex(l->key_sha1));
-
-				if (is_null_sha1(l->val_sha1))
+				ret = combine_notes(l->val_sha1,
+						    entry->val_sha1);
+				if (!ret && is_null_sha1(l->val_sha1))
 					note_tree_remove(t, tree, n, entry);
 				free(entry);
-				return;
+				return ret;
 			}
 			break;
 		case PTR_TYPE_SUBTREE:
@@ -280,7 +276,7 @@ static void note_tree_insert(struct notes_tree *t, struct int_node *tree,
 				/* unpack 'entry' */
 				load_subtree(t, entry, tree, n);
 				free(entry);
-				return;
+				return 0;
 			}
 			break;
 		}
@@ -291,9 +287,8 @@ static void note_tree_insert(struct notes_tree *t, struct int_node *tree,
 			*p = NULL;
 			load_subtree(t, l, tree, n);
 			free(l);
-			note_tree_insert(t, tree, n, entry, type,
-					 combine_notes);
-			return;
+			return note_tree_insert(t, tree, n, entry, type,
+						combine_notes);
 		}
 		break;
 	}
@@ -303,13 +298,17 @@ static void note_tree_insert(struct notes_tree *t, struct int_node *tree,
 	       GET_PTR_TYPE(*p) == PTR_TYPE_SUBTREE);
 	if (is_null_sha1(entry->val_sha1)) { /* skip insertion of empty note */
 		free(entry);
-		return;
+		return 0;
 	}
 	new_node = (struct int_node *) xcalloc(sizeof(struct int_node), 1);
-	note_tree_insert(t, new_node, n + 1, l, GET_PTR_TYPE(*p),
-			 combine_notes);
-	*p = SET_PTR_TYPE(new_node, PTR_TYPE_INTERNAL);
-	note_tree_insert(t, new_node, n + 1, entry, type, combine_notes);
+	ret = note_tree_insert(t, new_node, n + 1, l, GET_PTR_TYPE(*p),
+			       combine_notes);
+	if (!ret) {
+		*p = SET_PTR_TYPE(new_node, PTR_TYPE_INTERNAL);
+		ret = note_tree_insert(t, new_node, n + 1, entry, type,
+				       combine_notes);
+	}
+	return ret;
 }
 
 /* Free the entire notes data contained in the given tree */
@@ -452,8 +451,12 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 				l->key_sha1[19] = (unsigned char) len;
 				type = PTR_TYPE_SUBTREE;
 			}
-			note_tree_insert(t, node, n, l, type,
-					 combine_notes_concatenate);
+			if (note_tree_insert(t, node, n, l, type,
+					     combine_notes_concatenate))
+				die("Failed to load %s %s into notes tree "
+				    "from %s",
+				    type == PTR_TYPE_NOTE ? "note" : "subtree",
+				    sha1_to_hex(l->key_sha1), t->ref);
 		}
 		continue;
 
@@ -1014,7 +1017,7 @@ void init_display_notes(struct display_notes_opt *opt)
 	string_list_clear(&display_notes_refs, 0);
 }
 
-void add_note(struct notes_tree *t, const unsigned char *object_sha1,
+int add_note(struct notes_tree *t, const unsigned char *object_sha1,
 		const unsigned char *note_sha1, combine_notes_fn combine_notes)
 {
 	struct leaf_node *l;
@@ -1028,7 +1031,7 @@ void add_note(struct notes_tree *t, const unsigned char *object_sha1,
 	l = (struct leaf_node *) xmalloc(sizeof(struct leaf_node));
 	hashcpy(l->key_sha1, object_sha1);
 	hashcpy(l->val_sha1, note_sha1);
-	note_tree_insert(t, t->root, 0, l, PTR_TYPE_NOTE, combine_notes);
+	return note_tree_insert(t, t->root, 0, l, PTR_TYPE_NOTE, combine_notes);
 }
 
 void remove_note(struct notes_tree *t, const unsigned char *object_sha1)
@@ -1204,7 +1207,7 @@ void format_display_notes(const unsigned char *object_sha1,
 
 int copy_note(struct notes_tree *t,
 	      const unsigned char *from_obj, const unsigned char *to_obj,
-	      int force, combine_notes_fn combine_fn)
+	      int force, combine_notes_fn combine_notes)
 {
 	const unsigned char *note = get_note(t, from_obj);
 	const unsigned char *existing_note = get_note(t, to_obj);
@@ -1213,9 +1216,9 @@ int copy_note(struct notes_tree *t,
 		return 1;
 
 	if (note)
-		add_note(t, to_obj, note, combine_fn);
+		return add_note(t, to_obj, note, combine_notes);
 	else if (existing_note)
-		add_note(t, to_obj, null_sha1, combine_fn);
+		return add_note(t, to_obj, null_sha1, combine_notes);
 
 	return 0;
 }
diff --git a/notes.h b/notes.h
index 79ea797..b372575 100644
--- a/notes.h
+++ b/notes.h
@@ -104,11 +104,13 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
  * note with the empty note (using the given combine_notes function) results
  * in a new/changed note.
  *
+ * Returns zero on success; non-zero means combine_notes failed.
+ *
  * IMPORTANT: The changes made by add_note() to the given notes_tree structure
  * are not persistent until a subsequent call to write_notes_tree() returns
  * zero.
  */
-void add_note(struct notes_tree *t, const unsigned char *object_sha1,
+int add_note(struct notes_tree *t, const unsigned char *object_sha1,
 		const unsigned char *note_sha1, combine_notes_fn combine_notes);
 
 /*
@@ -131,7 +133,10 @@ const unsigned char *get_note(struct notes_tree *t,
 /*
  * Copy a note from one object to another in the given notes_tree.
  *
- * Fails if the to_obj already has a note unless 'force' is true.
+ * Returns 1 if the to_obj already has a note and 'force' is false. Otherwise,
+ * returns non-zero if 'force' is true, but the given combine_notes function
+ * failed to combine from_obj's note with to_obj's existing note.
+ * Returns zero on success.
  *
  * IMPORTANT: The changes made by copy_note() to the given notes_tree structure
  * are not persistent until a subsequent call to write_notes_tree() returns
@@ -139,7 +144,7 @@ const unsigned char *get_note(struct notes_tree *t,
  */
 int copy_note(struct notes_tree *t,
 	      const unsigned char *from_obj, const unsigned char *to_obj,
-	      int force, combine_notes_fn combine_fn);
+	      int force, combine_notes_fn combine_notes);
 
 /*
  * Flags controlling behaviour of for_each_note()
-- 
1.7.3.1.104.g92b87a
