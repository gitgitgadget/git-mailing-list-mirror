From: Jeff King <peff@peff.net>
Subject: [PATCH 06/17] prefer git_pathdup to git_path in some
 possibly-dangerous cases
Date: Mon, 10 Aug 2015 05:35:31 -0400
Message-ID: <20150810093531.GF30981@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 11:35:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjUa-0004HX-UA
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbbHJJfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:35:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:42824 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753302AbbHJJfg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 05:35:36 -0400
Received: (qmail 30908 invoked by uid 102); 10 Aug 2015 09:35:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 04:35:36 -0500
Received: (qmail 3118 invoked by uid 107); 10 Aug 2015 09:35:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 05:35:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 05:35:31 -0400
Content-Disposition: inline
In-Reply-To: <20150810092731.GA9027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275572>

Because git_path uses a static buffer that is shared with
calls to git_path, mkpath, etc, it can be dangerous to
assign the result to a variable or pass it to a non-trivial
function. The value may change unexpectedly due to other
calls.

None of the cases changed here has a known bug, but they're
worth converting away from git_path because:

  1. It's easy to use git_pathdup in these cases.

  2. They use constructs (like assignment) that make it
     hard to tell whether they're safe or not.

The extra malloc overhead should be trivial, as an
allocation should be an order of magnitude cheaper than a
system call (which we are clearly about to make, since we
are constructing a filename). The real cost is that we must
remember to free the result.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c |  4 +++-
 fast-import.c  |  4 +++-
 http-backend.c |  3 ++-
 notes-merge.c  |  3 ++-
 refs.c         | 14 ++++++++------
 unpack-trees.c |  4 +++-
 6 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index f4b87e9..0794703 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -243,13 +243,14 @@ static void check_unreachable_object(struct object *obj)
 			printf("dangling %s %s\n", typename(obj->type),
 			       sha1_to_hex(obj->sha1));
 		if (write_lost_and_found) {
-			const char *filename = git_path("lost-found/%s/%s",
+			char *filename = git_pathdup("lost-found/%s/%s",
 				obj->type == OBJ_COMMIT ? "commit" : "other",
 				sha1_to_hex(obj->sha1));
 			FILE *f;
 
 			if (safe_create_leading_directories_const(filename)) {
 				error("Could not create lost-found");
+				free(filename);
 				return;
 			}
 			if (!(f = fopen(filename, "w")))
@@ -262,6 +263,7 @@ static void check_unreachable_object(struct object *obj)
 			if (fclose(f))
 				die_errno("Could not finish '%s'",
 					  filename);
+			free(filename);
 		}
 		return;
 	}
diff --git a/fast-import.c b/fast-import.c
index 2ad4fee..ad8848b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -407,7 +407,7 @@ static void dump_marks_helper(FILE *, uintmax_t, struct mark_set *);
 
 static void write_crash_report(const char *err)
 {
-	const char *loc = git_path("fast_import_crash_%"PRIuMAX, (uintmax_t) getpid());
+	char *loc = git_pathdup("fast_import_crash_%"PRIuMAX, (uintmax_t) getpid());
 	FILE *rpt = fopen(loc, "w");
 	struct branch *b;
 	unsigned long lu;
@@ -415,6 +415,7 @@ static void write_crash_report(const char *err)
 
 	if (!rpt) {
 		error("can't write crash report %s: %s", loc, strerror(errno));
+		free(loc);
 		return;
 	}
 
@@ -488,6 +489,7 @@ static void write_crash_report(const char *err)
 	fputs("-------------------\n", rpt);
 	fputs("END OF CRASH REPORT\n", rpt);
 	fclose(rpt);
+	free(loc);
 }
 
 static void end_packfile(void);
diff --git a/http-backend.c b/http-backend.c
index b977c00..bac40ef 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -164,7 +164,7 @@ static void send_strbuf(const char *type, struct strbuf *buf)
 
 static void send_local_file(const char *the_type, const char *name)
 {
-	const char *p = git_path("%s", name);
+	char *p = git_pathdup("%s", name);
 	size_t buf_alloc = 8192;
 	char *buf = xmalloc(buf_alloc);
 	int fd;
@@ -191,6 +191,7 @@ static void send_local_file(const char *the_type, const char *name)
 	}
 	close(fd);
 	free(buf);
+	free(p);
 }
 
 static void get_text_file(char *name)
diff --git a/notes-merge.c b/notes-merge.c
index 0b2b82c..b3d1dab 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -295,7 +295,7 @@ static void write_buf_to_worktree(const unsigned char *obj,
 				  const char *buf, unsigned long size)
 {
 	int fd;
-	const char *path = git_path(NOTES_MERGE_WORKTREE "/%s", sha1_to_hex(obj));
+	char *path = git_pathdup(NOTES_MERGE_WORKTREE "/%s", sha1_to_hex(obj));
 	if (safe_create_leading_directories_const(path))
 		die_errno("unable to create directory for '%s'", path);
 	if (file_exists(path))
@@ -320,6 +320,7 @@ static void write_buf_to_worktree(const unsigned char *obj,
 	}
 
 	close(fd);
+	free(path);
 }
 
 static void write_note_to_worktree(const unsigned char *obj,
diff --git a/refs.c b/refs.c
index 2db2975..93b250e 100644
--- a/refs.c
+++ b/refs.c
@@ -1288,12 +1288,12 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
  */
 static struct packed_ref_cache *get_packed_ref_cache(struct ref_cache *refs)
 {
-	const char *packed_refs_file;
+	char *packed_refs_file;
 
 	if (*refs->name)
-		packed_refs_file = git_path_submodule(refs->name, "packed-refs");
+		packed_refs_file = git_pathdup_submodule(refs->name, "packed-refs");
 	else
-		packed_refs_file = git_path("packed-refs");
+		packed_refs_file = git_pathdup("packed-refs");
 
 	if (refs->packed &&
 	    !stat_validity_check(&refs->packed->validity, packed_refs_file))
@@ -1312,6 +1312,7 @@ static struct packed_ref_cache *get_packed_ref_cache(struct ref_cache *refs)
 			fclose(f);
 		}
 	}
+	free(packed_refs_file);
 	return refs->packed;
 }
 
@@ -1481,14 +1482,15 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
 {
 	int fd, len;
 	char buffer[128], *p;
-	const char *path;
+	char *path;
 
 	if (recursion > MAXDEPTH || strlen(refname) > MAXREFLEN)
 		return -1;
 	path = *refs->name
-		? git_path_submodule(refs->name, "%s", refname)
-		: git_path("%s", refname);
+		? git_pathdup_submodule(refs->name, "%s", refname)
+		: git_pathdup("%s", refname);
 	fd = open(path, O_RDONLY);
+	free(path);
 	if (fd < 0)
 		return resolve_gitlink_packed_ref(refs, refname, sha1);
 
diff --git a/unpack-trees.c b/unpack-trees.c
index d6cf849..7bb446a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1029,10 +1029,12 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout) {
-		if (add_excludes_from_file_to_list(git_path("info/sparse-checkout"), "", 0, &el, 0) < 0)
+		char *sparse = git_pathdup("info/sparse-checkout");
+		if (add_excludes_from_file_to_list(sparse, "", 0, &el, 0) < 0)
 			o->skip_sparse_checkout = 1;
 		else
 			o->el = &el;
+		free(sparse);
 	}
 
 	memset(&o->result, 0, sizeof(o->result));
-- 
2.5.0.414.g670f2a4
