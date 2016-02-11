From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] list-objects: drop name_path entirely
Date: Thu, 11 Feb 2016 17:26:44 -0500
Message-ID: <20160211222644.GD586@sigill.intra.peff.net>
References: <20160211222314.GA31625@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 23:26:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTzhL-0006I0-IX
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 23:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbcBKW0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 17:26:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:40761 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750752AbcBKW0r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 17:26:47 -0500
Received: (qmail 24595 invoked by uid 102); 11 Feb 2016 22:26:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Feb 2016 17:26:47 -0500
Received: (qmail 11770 invoked by uid 107); 11 Feb 2016 22:26:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Feb 2016 17:26:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2016 17:26:44 -0500
Content-Disposition: inline
In-Reply-To: <20160211222314.GA31625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286012>

In the previous commit, we left name_path as a thin wrapper
around a strbuf. This patch drops it entirely. As a result,
every show_object_fn callback needs to be adjusted. However,
none of their code needs to be changed at all, because the
only use was to pass it to path_name(), which now handles
the bare strbuf.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c |  4 ++--
 builtin/rev-list.c     |  4 ++--
 list-objects.c         | 12 +++++-------
 list-objects.h         |  2 +-
 pack-bitmap-write.c    |  2 +-
 pack-bitmap.c          |  4 ++--
 reachable.c            |  2 +-
 revision.c             |  6 +++---
 revision.h             |  8 ++------
 9 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4dae5b1..8bbb9bd 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2285,7 +2285,7 @@ static void show_commit(struct commit *commit, void *data)
 }
 
 static void show_object(struct object *obj,
-			const struct name_path *path, const char *last,
+			struct strbuf *path, const char *last,
 			void *data)
 {
 	char *name = path_name(path, last);
@@ -2480,7 +2480,7 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 }
 
 static void record_recent_object(struct object *obj,
-				 const struct name_path *path,
+				 struct strbuf *path,
 				 const char *last,
 				 void *data)
 {
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3aa89a1..a92c3ca 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -178,7 +178,7 @@ static void finish_commit(struct commit *commit, void *data)
 }
 
 static void finish_object(struct object *obj,
-			  const struct name_path *path, const char *name,
+			  struct strbuf *path, const char *name,
 			  void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
@@ -189,7 +189,7 @@ static void finish_object(struct object *obj,
 }
 
 static void show_object(struct object *obj,
-			const struct name_path *path, const char *component,
+			struct strbuf *path, const char *component,
 			void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
diff --git a/list-objects.c b/list-objects.c
index 4f60a3e..4397766 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -11,7 +11,7 @@
 static void process_blob(struct rev_info *revs,
 			 struct blob *blob,
 			 show_object_fn show,
-			 struct name_path *path,
+			 struct strbuf *path,
 			 const char *name,
 			 void *cb_data)
 {
@@ -52,7 +52,7 @@ static void process_blob(struct rev_info *revs,
 static void process_gitlink(struct rev_info *revs,
 			    const unsigned char *sha1,
 			    show_object_fn show,
-			    struct name_path *path,
+			    struct strbuf *path,
 			    const char *name,
 			    void *cb_data)
 {
@@ -69,7 +69,6 @@ static void process_tree(struct rev_info *revs,
 	struct object *obj = &tree->object;
 	struct tree_desc desc;
 	struct name_entry entry;
-	struct name_path me;
 	enum interesting match = revs->diffopt.pathspec.nr == 0 ?
 		all_entries_interesting: entry_not_interesting;
 	int baselen = base->len;
@@ -87,8 +86,7 @@ static void process_tree(struct rev_info *revs,
 	}
 
 	obj->flags |= SEEN;
-	me.base = base;
-	show(obj, &me, name, cb_data);
+	show(obj, base, name, cb_data);
 
 	strbuf_addstr(base, name);
 	if (base->len)
@@ -113,12 +111,12 @@ static void process_tree(struct rev_info *revs,
 				     cb_data);
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(revs, entry.sha1,
-					show, &me, entry.path,
+					show, base, entry.path,
 					cb_data);
 		else
 			process_blob(revs,
 				     lookup_blob(entry.sha1),
-				     show, &me, entry.path,
+				     show, base, entry.path,
 				     cb_data);
 	}
 	strbuf_setlen(base, baselen);
diff --git a/list-objects.h b/list-objects.h
index 136a1da..69c4c7d 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -2,7 +2,7 @@
 #define LIST_OBJECTS_H
 
 typedef void (*show_commit_fn)(struct commit *, void *);
-typedef void (*show_object_fn)(struct object *, const struct name_path *, const char *, void *);
+typedef void (*show_object_fn)(struct object *, struct strbuf *, const char *, void *);
 void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, void *);
 
 typedef void (*show_edge_fn)(struct commit *);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 6bff970..65ed342 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -148,7 +148,7 @@ static uint32_t find_object_pos(const unsigned char *sha1)
 	return entry->in_pack_pos;
 }
 
-static void show_object(struct object *object, const struct name_path *path,
+static void show_object(struct object *object, struct strbuf *path,
 			const char *last, void *data)
 {
 	struct bitmap *base = data;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index dd8dc16..51f790e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -414,7 +414,7 @@ static int ext_index_add_object(struct object *object, const char *name)
 	return bitmap_pos + bitmap_git.pack->num_objects;
 }
 
-static void show_object(struct object *object, const struct name_path *path,
+static void show_object(struct object *object, struct strbuf *path,
 			const char *last, void *data)
 {
 	struct bitmap *base = data;
@@ -895,7 +895,7 @@ struct bitmap_test_data {
 };
 
 static void test_show_object(struct object *object,
-			     const struct name_path *path,
+			     struct strbuf *path,
 			     const char *last, void *data)
 {
 	struct bitmap_test_data *tdata = data;
diff --git a/reachable.c b/reachable.c
index 43616d4..e60f08d 100644
--- a/reachable.c
+++ b/reachable.c
@@ -43,7 +43,7 @@ static int add_one_ref(const char *path, const struct object_id *oid,
  * The traversal will have already marked us as SEEN, so we
  * only need to handle any progress reporting here.
  */
-static void mark_object(struct object *obj, const struct name_path *path,
+static void mark_object(struct object *obj, struct strbuf *path,
 			const char *name, void *data)
 {
 	update_progress(data);
diff --git a/revision.c b/revision.c
index 8dd0950..3c84781 100644
--- a/revision.c
+++ b/revision.c
@@ -25,17 +25,17 @@ volatile show_early_output_fn_t show_early_output;
 static const char *term_bad;
 static const char *term_good;
 
-char *path_name(const struct name_path *path, const char *name)
+char *path_name(struct strbuf *path, const char *name)
 {
 	struct strbuf ret = STRBUF_INIT;
 	if (path)
-		strbuf_addbuf(&ret, path->base);
+		strbuf_addbuf(&ret, path);
 	strbuf_addstr(&ret, name);
 	return strbuf_detach(&ret, NULL);
 }
 
 void show_object_with_name(FILE *out, struct object *obj,
-			   const struct name_path *path, const char *component)
+			   struct strbuf *path, const char *component)
 {
 	char *name = path_name(path, component);
 	char *p;
diff --git a/revision.h b/revision.h
index 2a26310..7beab15 100644
--- a/revision.h
+++ b/revision.h
@@ -257,14 +257,10 @@ extern void put_revision_mark(const struct rev_info *revs,
 extern void mark_parents_uninteresting(struct commit *commit);
 extern void mark_tree_uninteresting(struct tree *tree);
 
-struct name_path {
-	struct strbuf *base;
-};
-
-char *path_name(const struct name_path *path, const char *name);
+char *path_name(struct strbuf *path, const char *name);
 
 extern void show_object_with_name(FILE *, struct object *,
-				  const struct name_path *, const char *);
+				  struct strbuf *, const char *);
 
 extern void add_pending_object(struct rev_info *revs,
 			       struct object *obj, const char *name);
-- 
2.7.1.550.gf5fcbd3
