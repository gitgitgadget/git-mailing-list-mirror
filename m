From: Jeff King <peff@peff.net>
Subject: [PATCH v2 18/25] make add_object_array_with_context interface more
 sane
Date: Wed, 15 Oct 2014 18:42:57 -0400
Message-ID: <20141015224256.GR25630@peff.net>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:43:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeXHc-0000bQ-Mp
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbaJOWnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:43:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:59004 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750809AbaJOWm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:42:59 -0400
Received: (qmail 2583 invoked by uid 102); 15 Oct 2014 22:42:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:42:59 -0500
Received: (qmail 28188 invoked by uid 107); 15 Oct 2014 22:42:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:42:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:42:57 -0400
Content-Disposition: inline
In-Reply-To: <20141015223244.GA25368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When you resolve a sha1, you can optionally keep any context
found during the resolution, including the path and mode of
a tree entry (e.g., when looking up "HEAD:subdir/file.c").

The add_object_array_with_context function lets you then
attach that context to an entry in a list. Unfortunately,
the interface for doing so is horrible. The object_context
structure is large and most object_array users do not use
it. Therefore we keep a pointer to the structure to avoid
burdening other users too much. But that means when we do
use it that we must allocate the struct ourselves. And the
struct contains a fixed PATH_MAX-sized buffer, which makes
this wholly unsuitable for any large arrays.

We can observe that there is only a single user of the
"with_context" variant: builtin/grep.c. And in that use
case, the only element we care about is the path. We can
therefore store only the path as a pointer (the context's
mode field was redundant with the object_array_entry itself,
and nobody actually cared about the surrounding tree). This
still requires a strdup of the pathname, but at least we are
only consuming the minimum amount of memory for each string.

We can also handle the copying ourselves in
add_object_array_*, and free it as appropriate in
object_array_release_entry.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/grep.c |  8 ++++----
 object.c       | 23 +++++++++--------------
 object.h       |  4 ++--
 3 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index c86a142..4063882 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -456,10 +456,10 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 }
 
 static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
-		       struct object *obj, const char *name, struct object_context *oc)
+		       struct object *obj, const char *name, const char *path)
 {
 	if (obj->type == OBJ_BLOB)
-		return grep_sha1(opt, obj->sha1, name, 0, oc ? oc->path : NULL);
+		return grep_sha1(opt, obj->sha1, name, 0, path);
 	if (obj->type == OBJ_COMMIT || obj->type == OBJ_TREE) {
 		struct tree_desc tree;
 		void *data;
@@ -501,7 +501,7 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 	for (i = 0; i < nr; i++) {
 		struct object *real_obj;
 		real_obj = deref_tag(list->objects[i].item, NULL, 0);
-		if (grep_object(opt, pathspec, real_obj, list->objects[i].name, list->objects[i].context)) {
+		if (grep_object(opt, pathspec, real_obj, list->objects[i].name, list->objects[i].path)) {
 			hit = 1;
 			if (opt->status_only)
 				break;
@@ -821,7 +821,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			struct object *object = parse_object_or_die(sha1, arg);
 			if (!seen_dashdash)
 				verify_non_filename(prefix, arg);
-			add_object_array_with_context(object, arg, &list, xmemdupz(&oc, sizeof(struct object_context)));
+			add_object_array_with_path(object, arg, &list, oc.mode, oc.path);
 			continue;
 		}
 		if (!strcmp(arg, "--")) {
diff --git a/object.c b/object.c
index 6aeb1bb..df86bdd 100644
--- a/object.c
+++ b/object.c
@@ -307,10 +307,9 @@ int object_list_contains(struct object_list *list, struct object *obj)
  */
 static char object_array_slopbuf[1];
 
-static void add_object_array_with_mode_context(struct object *obj, const char *name,
-					       struct object_array *array,
-					       unsigned mode,
-					       struct object_context *context)
+void add_object_array_with_path(struct object *obj, const char *name,
+				struct object_array *array,
+				unsigned mode, const char *path)
 {
 	unsigned nr = array->nr;
 	unsigned alloc = array->alloc;
@@ -333,7 +332,10 @@ static void add_object_array_with_mode_context(struct object *obj, const char *n
 	else
 		entry->name = xstrdup(name);
 	entry->mode = mode;
-	entry->context = context;
+	if (path)
+		entry->path = xstrdup(path);
+	else
+		entry->path = NULL;
 	array->nr = ++nr;
 }
 
@@ -344,15 +346,7 @@ void add_object_array(struct object *obj, const char *name, struct object_array
 
 void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode)
 {
-	add_object_array_with_mode_context(obj, name, array, mode, NULL);
-}
-
-void add_object_array_with_context(struct object *obj, const char *name, struct object_array *array, struct object_context *context)
-{
-	if (context)
-		add_object_array_with_mode_context(obj, name, array, context->mode, context);
-	else
-		add_object_array_with_mode_context(obj, name, array, S_IFINVALID, context);
+	add_object_array_with_path(obj, name, array, mode, NULL);
 }
 
 /*
@@ -363,6 +357,7 @@ static void object_array_release_entry(struct object_array_entry *ent)
 {
 	if (ent->name != object_array_slopbuf)
 		free(ent->name);
+	free(ent->path);
 }
 
 void object_array_filter(struct object_array *array,
diff --git a/object.h b/object.h
index 2a755a2..e5178a5 100644
--- a/object.h
+++ b/object.h
@@ -18,8 +18,8 @@ struct object_array {
 		 * empty string.
 		 */
 		char *name;
+		char *path;
 		unsigned mode;
-		struct object_context *context;
 	} *objects;
 };
 
@@ -115,7 +115,7 @@ int object_list_contains(struct object_list *list, struct object *obj);
 /* Object array handling .. */
 void add_object_array(struct object *obj, const char *name, struct object_array *array);
 void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode);
-void add_object_array_with_context(struct object *obj, const char *name, struct object_array *array, struct object_context *context);
+void add_object_array_with_path(struct object *obj, const char *name, struct object_array *array, unsigned mode, const char *path);
 
 typedef int (*object_array_each_func_t)(struct object_array_entry *, void *);
 
-- 
2.1.2.596.g7379948
