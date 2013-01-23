From: Jonathon Mah <jmah@me.com>
Subject: [PATCH] parse_object: clear "parsed" when freeing buffers
Date: Wed, 23 Jan 2013 13:25:04 -0800
Message-ID: <8988071A-1DF3-463E-8AF9-AE4EA200D786@me.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 22:25:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty7p9-0004Fb-KL
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 22:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513Ab3AWVZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 16:25:14 -0500
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:57968 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751167Ab3AWVZM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 16:25:12 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhUTACRUAFFHynyrPGdsb2JhbAANN75WAwEBAQE4gwATgWMtiCaqDpNpjHuDV2EDiGGOR4gxihKBTg
Received: from c-71-202-124-171.hsd1.ca.comcast.net (HELO [192.168.120.21]) ([71.202.124.171])
  by ipmail07.adl2.internode.on.net with ESMTP; 24 Jan 2013 07:55:07 +1030
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214366>

Add a new function "free_object_buffer", which marks the object as
un-parsed and frees the buffer. Only trees and commits have buffers;
other types are not affected. If the tree or commit buffer is already
NULL, the "parsed" flag is still cleared so callers can control the free
themselves (index-pack.c uses this).

Several areas of code would free buffers for object structs that
contained them ("struct tree" and "struct commit"), but without clearing
the "parsed" flag. parse_object would clear the flag for "struct tree",
but commits would remain in an invalid state (marked as parsed but with
a NULL buffer). Because the objects are uniqued (ccdc6037fee), the
invalid objects stay around and can lead to bad behavior.

In particular, running pickaxe on all refs in a repository with a cached
textconv could segfault. If the textconv cache ref was evaluated first
by cmd_log_walk, a subsequent notes_cache_match_validity call would
dereference NULL.

Signed-off-by: Jonathon Mah <me@JonathonMah.com>
---

I found an old email where Jeff noted that this would be bad (yet the buffer manipulation remained).
<http://permalink.gmane.org/gmane.comp.version-control.git/188000>

 builtin/fsck.c                   | 17 ++---------------
 builtin/index-pack.c             |  3 +++
 builtin/log.c                    |  9 +++------
 builtin/reflog.c                 |  3 +--
 builtin/rev-list.c               |  3 +--
 http-push.c                      |  3 +--
 list-objects.c                   |  3 +--
 object.c                         | 25 +++++++++++++++++++++++--
 object.h                         |  3 +++
 reachable.c                      |  3 +--
 revision.c                       |  3 +--
 t/t4042-diff-textconv-caching.sh | 11 +++++++++++
 upload-pack.c                    |  3 +--
 walker.c                         |  5 +----
 14 files changed, 53 insertions(+), 41 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index bb9a2cd..82b3612 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -133,10 +133,7 @@ static int traverse_one_object(struct object *obj)
 			return 1; /* error already displayed */
 	}
 	result = fsck_walk(obj, mark_object, obj);
-	if (tree) {
-		free(tree->buffer);
-		tree->buffer = NULL;
-	}
+	free_object_buffer(obj);
 	return result;
 }
 
@@ -303,26 +300,16 @@ static int fsck_obj(struct object *obj)
 	if (fsck_object(obj, check_strict, fsck_error_func))
 		return -1;
 
-	if (obj->type == OBJ_TREE) {
-		struct tree *item = (struct tree *) obj;
-
-		free(item->buffer);
-		item->buffer = NULL;
-	}
+	free_object_buffer(obj);
 
 	if (obj->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *) obj;
-
-		free(commit->buffer);
-		commit->buffer = NULL;
-
 		if (!commit->parents && show_root)
 			printf("root %s\n", sha1_to_hex(commit->object.sha1));
 	}
 
 	if (obj->type == OBJ_TAG) {
 		struct tag *tag = (struct tag *) obj;
-
 		if (show_tags && tag->tagged) {
 			printf("tagged %s %s", typename(tag->tagged->type), sha1_to_hex(tag->tagged->sha1));
 			printf(" (%s) in %s\n", tag->tag, sha1_to_hex(tag->object.sha1));
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 43d364b..0eb39ae 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -750,13 +750,16 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			if (fsck_walk(obj, mark_link, NULL))
 				die(_("Not all child objects of %s are reachable"), sha1_to_hex(obj->sha1));
 
+			/* set buffer to NULL so it isn't freed */
 			if (obj->type == OBJ_TREE) {
 				struct tree *item = (struct tree *) obj;
 				item->buffer = NULL;
+				free_object_buffer(obj);
 			}
 			if (obj->type == OBJ_COMMIT) {
 				struct commit *commit = (struct commit *) obj;
 				commit->buffer = NULL;
+				free_object_buffer(obj);
 			}
 			obj->flags |= FLAG_CHECKED;
 		}
diff --git a/builtin/log.c b/builtin/log.c
index e7b7db1..433b874 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -305,11 +305,9 @@ static int cmd_log_walk(struct rev_info *rev)
 			 * but we didn't actually show the commit.
 			 */
 			rev->max_count++;
-		if (!rev->reflog_info) {
+		if (!rev->reflog_info)
 			/* we allow cycles in reflog ancestry */
-			free(commit->buffer);
-			commit->buffer = NULL;
-		}
+			free_object_buffer(&commit->object);
 		free_commit_list(commit->parents);
 		commit->parents = NULL;
 		if (saved_nrl < rev->diffopt.needed_rename_limit)
@@ -1399,8 +1397,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		    reopen_stdout(numbered_files ? NULL : commit, NULL, &rev, quiet))
 			die(_("Failed to create output files"));
 		shown = log_tree_commit(&rev, commit);
-		free(commit->buffer);
-		commit->buffer = NULL;
+		free_object_buffer(&commit->object);
 
 		/* We put one extra blank line between formatted
 		 * patches and this flag is used by log-tree code
diff --git a/builtin/reflog.c b/builtin/reflog.c
index b3c9e27..c9a660f 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -94,8 +94,7 @@ static int tree_is_complete(const unsigned char *sha1)
 			complete = 0;
 		}
 	}
-	free(tree->buffer);
-	tree->buffer = NULL;
+	free_object_buffer(tree->buffer);
 
 	if (complete)
 		tree->object.flags |= SEEN;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 67701be..6855892 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -170,8 +170,7 @@ static void finish_commit(struct commit *commit, void *data)
 		free_commit_list(commit->parents);
 		commit->parents = NULL;
 	}
-	free(commit->buffer);
-	commit->buffer = NULL;
+	free_object_buffer(&commit->object);
 }
 
 static void finish_object(struct object *obj,
diff --git a/http-push.c b/http-push.c
index 8701c12..042a410 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1347,8 +1347,7 @@ static struct object_list **process_tree(struct tree *tree,
 			break;
 		}
 
-	free(tree->buffer);
-	tree->buffer = NULL;
+	free_object_buffer(obj);
 	return p;
 }
 
diff --git a/list-objects.c b/list-objects.c
index 3dd4a96..fb4b531 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -123,8 +123,7 @@ static void process_tree(struct rev_info *revs,
 				     cb_data);
 	}
 	strbuf_setlen(base, baselen);
-	free(tree->buffer);
-	tree->buffer = NULL;
+	free_object_buffer(obj);
 }
 
 static void mark_edge_parents_uninteresting(struct commit *commit,
diff --git a/object.c b/object.c
index 4af3451..8e161f8 100644
--- a/object.c
+++ b/object.c
@@ -149,8 +149,6 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 		struct tree *tree = lookup_tree(sha1);
 		if (tree) {
 			obj = &tree->object;
-			if (!tree->buffer)
-				tree->object.parsed = 0;
 			if (!tree->object.parsed) {
 				if (parse_tree_buffer(tree, buffer, size))
 					return NULL;
@@ -225,6 +223,29 @@ struct object *parse_object(const unsigned char *sha1)
 	return NULL;
 }
 
+void free_object_buffer(struct object *item)
+{
+	if (!item)
+		return;
+
+	if (item->type == OBJ_TREE) {
+		struct tree *tree = (struct tree *)item;
+		tree->object.parsed = 0;
+		tree->size = 0;
+		if (tree->buffer) {
+			free(tree->buffer);
+			tree->buffer = NULL;
+		}
+	} else if (item->type == OBJ_COMMIT) {
+		struct commit *commit = (struct commit *)item;
+		commit->object.parsed = 0;
+		if (commit->buffer) {
+			free(commit->buffer);
+			commit->buffer = NULL;
+		}
+	}
+}
+
 struct object_list *object_list_insert(struct object *item,
 				       struct object_list **list_p)
 {
diff --git a/object.h b/object.h
index 6a97b6b..cbc730c 100644
--- a/object.h
+++ b/object.h
@@ -63,6 +63,9 @@ struct object *parse_object(const unsigned char *sha1);
  */
 struct object *parse_object_buffer(const unsigned char *sha1, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
 
+/** If the object's type has a buffer, it's freed and marked as un-parsed. */
+void free_object_buffer(struct object *item);
+
 /** Returns the object, with potentially excess memory allocated. **/
 struct object *lookup_unknown_object(const unsigned  char *sha1);
 
diff --git a/reachable.c b/reachable.c
index bf79706..c29d3e0 100644
--- a/reachable.c
+++ b/reachable.c
@@ -80,8 +80,7 @@ static void process_tree(struct tree *tree,
 		else
 			process_blob(lookup_blob(entry.sha1), p, &me, entry.path, cp);
 	}
-	free(tree->buffer);
-	tree->buffer = NULL;
+	free_object_buffer(obj);
 }
 
 static void process_tag(struct tag *tag, struct object_array *p,
diff --git a/revision.c b/revision.c
index 95d21e6..43c5eec 100644
--- a/revision.c
+++ b/revision.c
@@ -133,8 +133,7 @@ void mark_tree_uninteresting(struct tree *tree)
 	 * We don't care about the tree any more
 	 * after it has been marked uninteresting.
 	 */
-	free(tree->buffer);
-	tree->buffer = NULL;
+	free_object_buffer(obj);
 }
 
 void mark_parents_uninteresting(struct commit *commit)
diff --git a/t/t4042-diff-textconv-caching.sh b/t/t4042-diff-textconv-caching.sh
index 91f8198..d7e26ca 100755
--- a/t/t4042-diff-textconv-caching.sh
+++ b/t/t4042-diff-textconv-caching.sh
@@ -106,4 +106,15 @@ test_expect_success 'switching diff driver produces correct results' '
 	test_cmp expect actual
 '
 
+cat >expect <<EOF
+./helper other (refs/notes/textconv/magic)
+one
+EOF
+# add empty commit on master to make bug more reproducible
+test_expect_success 'pickaxe with cached textconv' '
+	git commit --allow-empty -m another &&
+	git log -S other --pretty=tformat:%s%d --all >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/upload-pack.c b/upload-pack.c
index 6142421..1feacbc 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -81,8 +81,7 @@ static void show_commit(struct commit *commit, void *data)
 		die("broken output pipe");
 	fputc('\n', pack_pipe);
 	fflush(pack_pipe);
-	free(commit->buffer);
-	commit->buffer = NULL;
+	free_object_buffer(&commit->object);
 }
 
 static void show_object(struct object *obj,
diff --git a/walker.c b/walker.c
index be389dc..bae4876 100644
--- a/walker.c
+++ b/walker.c
@@ -56,10 +56,7 @@ static int process_tree(struct walker *walker, struct tree *tree)
 		if (!obj || process(walker, obj))
 			return -1;
 	}
-	free(tree->buffer);
-	tree->buffer = NULL;
-	tree->size = 0;
-	tree->object.parsed = 0;
+	free_object_buffer(&tree->object);
 	return 0;
 }
 
-- 
1.8.1.1





Jonathon Mah
me@JonathonMah.com
