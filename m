From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] list-objects: pass full pathname to callbacks
Date: Thu, 11 Feb 2016 17:28:36 -0500
Message-ID: <20160211222836.GE586@sigill.intra.peff.net>
References: <20160211222314.GA31625@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 23:28:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTzjA-0007oV-6r
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 23:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbcBKW2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 17:28:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:40764 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750918AbcBKW2i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 17:28:38 -0500
Received: (qmail 24635 invoked by uid 102); 11 Feb 2016 22:28:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Feb 2016 17:28:38 -0500
Received: (qmail 11789 invoked by uid 107); 11 Feb 2016 22:28:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Feb 2016 17:28:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2016 17:28:36 -0500
Content-Disposition: inline
In-Reply-To: <20160211222314.GA31625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286013>

When we find a blob at "a/b/c", we currently pass this to
our show_object_fn callbacks as two components: "a/b/" and
"c". Callbacks which want the full value then call
path_name(), which concatenates the two. But this is an
inefficient interface; the path is a strbuf, and we could
simply append "c" to it temporarily, then roll back the
length, without creating a new copy.

So we could improve this by teaching the callsites of
path_name() this trick (and there are only 3). But we can
also notice that no callback actually cares about the
broken-down representation, and simply pass each callback
the full path "a/b/c" as a string. The callback code becomes
even simpler, then, as we do not have to worry about freeing
an allocated buffer, nor rolling back our modification to
the strbuf.

This is theoretically less efficient, as some callbacks
would not bother to format the final path component. But in
practice this is not measurable. Since we use the same
strbuf over and over, our work to grow it is amortized, and
we really only pay to memcpy a few bytes.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 15 ++-------------
 builtin/rev-list.c     | 12 ++++--------
 list-objects.c         | 14 +++++++++-----
 list-objects.h         |  2 +-
 pack-bitmap-write.c    |  3 +--
 pack-bitmap.c          | 13 ++++---------
 reachable.c            |  5 ++---
 revision.c             | 17 ++---------------
 revision.h             |  3 +--
 9 files changed, 26 insertions(+), 58 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8bbb9bd..a6609f1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2284,21 +2284,11 @@ static void show_commit(struct commit *commit, void *data)
 		index_commit_for_bitmap(commit);
 }
 
-static void show_object(struct object *obj,
-			struct strbuf *path, const char *last,
-			void *data)
+static void show_object(struct object *obj, const char *name, void *data)
 {
-	char *name = path_name(path, last);
-
 	add_preferred_base_object(name);
 	add_object_entry(obj->oid.hash, obj->type, name, 0);
 	obj->flags |= OBJECT_ADDED;
-
-	/*
-	 * We will have generated the hash from the name,
-	 * but not saved a pointer to it - we can free it
-	 */
-	free((char *)name);
 }
 
 static void show_edge(struct commit *commit)
@@ -2480,8 +2470,7 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 }
 
 static void record_recent_object(struct object *obj,
-				 struct strbuf *path,
-				 const char *last,
+				 const char *name,
 				 void *data)
 {
 	sha1_array_append(&recent_objects, obj->oid.hash);
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index a92c3ca..275da0d 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -177,9 +177,7 @@ static void finish_commit(struct commit *commit, void *data)
 	free_commit_buffer(commit);
 }
 
-static void finish_object(struct object *obj,
-			  struct strbuf *path, const char *name,
-			  void *cb_data)
+static void finish_object(struct object *obj, const char *name, void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
 	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid))
@@ -188,15 +186,13 @@ static void finish_object(struct object *obj,
 		parse_object(obj->oid.hash);
 }
 
-static void show_object(struct object *obj,
-			struct strbuf *path, const char *component,
-			void *cb_data)
+static void show_object(struct object *obj, const char *name, void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
-	finish_object(obj, path, component, cb_data);
+	finish_object(obj, name, cb_data);
 	if (info->flags & REV_LIST_QUIET)
 		return;
-	show_object_with_name(stdout, obj, path, component);
+	show_object_with_name(stdout, obj, name);
 }
 
 static void show_edge(struct commit *commit)
diff --git a/list-objects.c b/list-objects.c
index 4397766..917cc5d 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -16,6 +16,7 @@ static void process_blob(struct rev_info *revs,
 			 void *cb_data)
 {
 	struct object *obj = &blob->object;
+	size_t pathlen;
 
 	if (!revs->blob_objects)
 		return;
@@ -24,7 +25,11 @@ static void process_blob(struct rev_info *revs,
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
 	obj->flags |= SEEN;
-	show(obj, path, name, cb_data);
+
+	pathlen = path->len;
+	strbuf_addstr(path, name);
+	show(obj, path->buf, cb_data);
+	strbuf_setlen(path, pathlen);
 }
 
 /*
@@ -86,9 +91,8 @@ static void process_tree(struct rev_info *revs,
 	}
 
 	obj->flags |= SEEN;
-	show(obj, base, name, cb_data);
-
 	strbuf_addstr(base, name);
+	show(obj, base->buf, cb_data);
 	if (base->len)
 		strbuf_addch(base, '/');
 
@@ -207,7 +211,7 @@ void traverse_commit_list(struct rev_info *revs,
 			continue;
 		if (obj->type == OBJ_TAG) {
 			obj->flags |= SEEN;
-			show_object(obj, NULL, name, data);
+			show_object(obj, name, data);
 			continue;
 		}
 		if (!path)
@@ -219,7 +223,7 @@ void traverse_commit_list(struct rev_info *revs,
 		}
 		if (obj->type == OBJ_BLOB) {
 			process_blob(revs, (struct blob *)obj, show_object,
-				     NULL, path, data);
+				     &base, path, data);
 			continue;
 		}
 		die("unknown pending object %s (%s)",
diff --git a/list-objects.h b/list-objects.h
index 69c4c7d..0cebf85 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -2,7 +2,7 @@
 #define LIST_OBJECTS_H
 
 typedef void (*show_commit_fn)(struct commit *, void *);
-typedef void (*show_object_fn)(struct object *, struct strbuf *, const char *, void *);
+typedef void (*show_object_fn)(struct object *, const char *, void *);
 void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, void *);
 
 typedef void (*show_edge_fn)(struct commit *);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 65ed342..c30bcd0 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -148,8 +148,7 @@ static uint32_t find_object_pos(const unsigned char *sha1)
 	return entry->in_pack_pos;
 }
 
-static void show_object(struct object *object, struct strbuf *path,
-			const char *last, void *data)
+static void show_object(struct object *object, const char *name, void *data)
 {
 	struct bitmap *base = data;
 	bitmap_set(base, find_object_pos(object->oid.hash));
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 51f790e..b949e51 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -414,19 +414,15 @@ static int ext_index_add_object(struct object *object, const char *name)
 	return bitmap_pos + bitmap_git.pack->num_objects;
 }
 
-static void show_object(struct object *object, struct strbuf *path,
-			const char *last, void *data)
+static void show_object(struct object *object, const char *name, void *data)
 {
 	struct bitmap *base = data;
 	int bitmap_pos;
 
 	bitmap_pos = bitmap_position(object->oid.hash);
 
-	if (bitmap_pos < 0) {
-		char *name = path_name(path, last);
+	if (bitmap_pos < 0)
 		bitmap_pos = ext_index_add_object(object, name);
-		free(name);
-	}
 
 	bitmap_set(base, bitmap_pos);
 }
@@ -894,9 +890,8 @@ struct bitmap_test_data {
 	size_t seen;
 };
 
-static void test_show_object(struct object *object,
-			     struct strbuf *path,
-			     const char *last, void *data)
+static void test_show_object(struct object *object, const char *name,
+			     void *data)
 {
 	struct bitmap_test_data *tdata = data;
 	int bitmap_pos;
diff --git a/reachable.c b/reachable.c
index e60f08d..ed35201 100644
--- a/reachable.c
+++ b/reachable.c
@@ -43,15 +43,14 @@ static int add_one_ref(const char *path, const struct object_id *oid,
  * The traversal will have already marked us as SEEN, so we
  * only need to handle any progress reporting here.
  */
-static void mark_object(struct object *obj, struct strbuf *path,
-			const char *name, void *data)
+static void mark_object(struct object *obj, const char *name, void *data)
 {
 	update_progress(data);
 }
 
 static void mark_commit(struct commit *c, void *data)
 {
-	mark_object(&c->object, NULL, NULL, data);
+	mark_object(&c->object, NULL, data);
 }
 
 struct recent_data {
diff --git a/revision.c b/revision.c
index 3c84781..82f3ca4 100644
--- a/revision.c
+++ b/revision.c
@@ -25,27 +25,14 @@ volatile show_early_output_fn_t show_early_output;
 static const char *term_bad;
 static const char *term_good;
 
-char *path_name(struct strbuf *path, const char *name)
+void show_object_with_name(FILE *out, struct object *obj, const char *name)
 {
-	struct strbuf ret = STRBUF_INIT;
-	if (path)
-		strbuf_addbuf(&ret, path);
-	strbuf_addstr(&ret, name);
-	return strbuf_detach(&ret, NULL);
-}
-
-void show_object_with_name(FILE *out, struct object *obj,
-			   struct strbuf *path, const char *component)
-{
-	char *name = path_name(path, component);
-	char *p;
+	const char *p;
 
 	fprintf(out, "%s ", oid_to_hex(&obj->oid));
 	for (p = name; *p && *p != '\n'; p++)
 		fputc(*p, out);
 	fputc('\n', out);
-
-	free(name);
 }
 
 static void mark_blob_uninteresting(struct blob *blob)
diff --git a/revision.h b/revision.h
index 7beab15..dca0d38 100644
--- a/revision.h
+++ b/revision.h
@@ -259,8 +259,7 @@ extern void mark_tree_uninteresting(struct tree *tree);
 
 char *path_name(struct strbuf *path, const char *name);
 
-extern void show_object_with_name(FILE *, struct object *,
-				  struct strbuf *, const char *);
+extern void show_object_with_name(FILE *, struct object *, const char *);
 
 extern void add_pending_object(struct rev_info *revs,
 			       struct object *obj, const char *name);
-- 
2.7.1.550.gf5fcbd3
