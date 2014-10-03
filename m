From: Jeff King <peff@peff.net>
Subject: [PATCH 09/16] prune: factor out loose-object directory traversal
Date: Fri, 3 Oct 2014 16:29:43 -0400
Message-ID: <20141003202943.GI16293@peff.net>
References: <20141003202045.GA15205@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 22:29:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa9U5-0001Pe-Lp
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 22:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468AbaJCU3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 16:29:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:54843 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751048AbaJCU3p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 16:29:45 -0400
Received: (qmail 3065 invoked by uid 102); 3 Oct 2014 20:29:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 15:29:45 -0500
Received: (qmail 15085 invoked by uid 107); 3 Oct 2014 20:29:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 16:29:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2014 16:29:43 -0400
Content-Disposition: inline
In-Reply-To: <20141003202045.GA15205@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257860>

Prune has to walk $GIT_DIR/objects/?? in order to find the
set of loose objects to prune. Other parts of the code
(e.g., count-objects) want to do the same. Let's factor it
out into a reusable for_each-style function.

Note that this is not quite a straight code movement. There
are two differences:

  1. The original code iterated from 0 to 256, trying to
     opendir("$GIT_DIR/%02x"). The new code just does a
     readdir() on the object directory, and descends into
     any matching directories. This is faster on
     already-pruned repositories, and should not ever be
     slower (nobody ever creates other files in the object
     directory).

  2. The original code had strange behavior when it found a
     file of the form "[0-9a-f]{2}/.{38}" that did _not_
     contain all hex digits. It executed a "break" from the
     loop, meaning that we stopped pruning in that directory
     (but still pruned other directories!). This was
     probably a bug; we do not want to process the file as
     an object, but we should keep going otherwise.

Signed-off-by: Jeff King <peff@peff.net>
---
I admit the speedup in (1) almost certainly doesn't matter. It is real,
and I found out about it while writing a different program that was
basically "count-objects" across a large number of repositories. However
for a single repo it's probably not big enough to matter (calling
count-objects in a loop while get dominated by the startup costs). The
end result is a little more obvious IMHO, but that's subjective.

 builtin/prune.c | 87 ++++++++++++++++------------------------------------
 cache.h         | 31 +++++++++++++++++++
 sha1_file.c     | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+), 61 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index 144a3bd..8286680 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -31,11 +31,23 @@ static int prune_tmp_file(const char *fullpath)
 	return 0;
 }
 
-static int prune_object(const char *fullpath, const unsigned char *sha1)
+static int prune_object(const unsigned char *sha1, const char *fullpath,
+			void *data)
 {
 	struct stat st;
-	if (lstat(fullpath, &st))
-		return error("Could not stat '%s'", fullpath);
+
+	/*
+	 * Do we know about this object?
+	 * It must have been reachable
+	 */
+	if (lookup_object(sha1))
+		return 0;
+
+	if (lstat(fullpath, &st)) {
+		/* report errors, but do not stop pruning */
+		error("Could not stat '%s'", fullpath);
+		return 0;
+	}
 	if (st.st_mtime > expire)
 		return 0;
 	if (show_only || verbose) {
@@ -48,68 +60,20 @@ static int prune_object(const char *fullpath, const unsigned char *sha1)
 	return 0;
 }
 
-static int prune_dir(int i, struct strbuf *path)
+static int prune_cruft(const char *basename, const char *path, void *data)
 {
-	size_t baselen = path->len;
-	DIR *dir = opendir(path->buf);
-	struct dirent *de;
-
-	if (!dir)
-		return 0;
-
-	while ((de = readdir(dir)) != NULL) {
-		char name[100];
-		unsigned char sha1[20];
-
-		if (is_dot_or_dotdot(de->d_name))
-			continue;
-		if (strlen(de->d_name) == 38) {
-			sprintf(name, "%02x", i);
-			memcpy(name+2, de->d_name, 39);
-			if (get_sha1_hex(name, sha1) < 0)
-				break;
-
-			/*
-			 * Do we know about this object?
-			 * It must have been reachable
-			 */
-			if (lookup_object(sha1))
-				continue;
-
-			strbuf_addf(path, "/%s", de->d_name);
-			prune_object(path->buf, sha1);
-			strbuf_setlen(path, baselen);
-			continue;
-		}
-		if (starts_with(de->d_name, "tmp_obj_")) {
-			strbuf_addf(path, "/%s", de->d_name);
-			prune_tmp_file(path->buf);
-			strbuf_setlen(path, baselen);
-			continue;
-		}
-		fprintf(stderr, "bad sha1 file: %s/%s\n", path->buf, de->d_name);
-	}
-	closedir(dir);
-	if (!show_only)
-		rmdir(path->buf);
+	if (starts_with(basename, "tmp_obj_"))
+		prune_tmp_file(path);
+	else
+		fprintf(stderr, "bad sha1 file: %s\n", path);
 	return 0;
 }
 
-static void prune_object_dir(const char *path)
+static int prune_subdir(const char *basename, const char *path, void *data)
 {
-	struct strbuf buf = STRBUF_INIT;
-	size_t baselen;
-	int i;
-
-	strbuf_addstr(&buf, path);
-	strbuf_addch(&buf, '/');
-	baselen = buf.len;
-
-	for (i = 0; i < 256; i++) {
-		strbuf_addf(&buf, "%02x", i);
-		prune_dir(i, &buf);
-		strbuf_setlen(&buf, baselen);
-	}
+	if (!show_only)
+		rmdir(path);
+	return 0;
 }
 
 /*
@@ -173,7 +137,8 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 
 	mark_reachable_objects(&revs, 1, progress);
 	stop_progress(&progress);
-	prune_object_dir(get_object_directory());
+	for_each_loose_file_in_objdir(get_object_directory(), prune_object,
+				      prune_cruft, prune_subdir, NULL);
 
 	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);
 	remove_temporary_files(get_object_directory());
diff --git a/cache.h b/cache.h
index cd16e25..7abe7f6 100644
--- a/cache.h
+++ b/cache.h
@@ -1239,6 +1239,37 @@ extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsig
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
 
+/*
+ * Iterate over the files in the loose-object parts of the object
+ * directory "path", triggering the following callbacks:
+ *
+ *  - loose_object is called for each loose object we find.
+ *
+ *  - loose_cruft is called for any files that do not appear to be
+ *    loose objects.
+ *
+ *  - loose_subdir is called for each top-level hashed subdirectory
+ *    of the object directory (e.g., "$OBJDIR/f0"). It is called
+ *    after the objects in the directory are processed.
+ *
+ * Any callback that is NULL will be ignored. Callbacks returning non-zero
+ * will end the iteration.
+ */
+typedef int each_loose_object_fn(const unsigned char *sha1,
+				 const char *path,
+				 void *data);
+typedef int each_loose_cruft_fn(const char *basename,
+				const char *path,
+				void *data);
+typedef int each_loose_subdir_fn(const char *basename,
+				 const char *path,
+				 void *data);
+int for_each_loose_file_in_objdir(const char *path,
+				  each_loose_object_fn obj_cb,
+				  each_loose_cruft_fn cruft_cb,
+				  each_loose_subdir_fn subdir_cb,
+				  void *data);
+
 struct object_info {
 	/* Request */
 	enum object_type *typep;
diff --git a/sha1_file.c b/sha1_file.c
index bae1c15..9fdad47 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3218,3 +3218,98 @@ void assert_sha1_type(const unsigned char *sha1, enum object_type expect)
 		die("%s is not a valid '%s' object", sha1_to_hex(sha1),
 		    typename(expect));
 }
+
+static int opendir_error(const char *path)
+{
+	if (errno == ENOENT)
+		return 0;
+	return error("unable to open %s: %s", path, strerror(errno));
+}
+
+static int for_each_file_in_obj_subdir(struct strbuf *path,
+				       const char *prefix,
+				       each_loose_object_fn obj_cb,
+				       each_loose_cruft_fn cruft_cb,
+				       each_loose_subdir_fn subdir_cb,
+				       void *data)
+{
+	size_t baselen = path->len;
+	DIR *dir = opendir(path->buf);
+	struct dirent *de;
+	int r = 0;
+
+	if (!dir)
+		return opendir_error(path->buf);
+
+	while ((de = readdir(dir))) {
+		if (is_dot_or_dotdot(de->d_name))
+			continue;
+
+		strbuf_setlen(path, baselen);
+		strbuf_addf(path, "/%s", de->d_name);
+
+		if (strlen(de->d_name) == 38)  {
+			char hex[41];
+			unsigned char sha1[20];
+
+			memcpy(hex, prefix, 2);
+			memcpy(hex + 2, de->d_name, 38);
+			hex[40] = 0;
+			if (!get_sha1_hex(hex, sha1)) {
+				if (obj_cb) {
+					r = obj_cb(sha1, path->buf, data);
+					if (r)
+						break;
+				}
+				continue;
+			}
+		}
+
+		if (cruft_cb) {
+			r = cruft_cb(de->d_name, path->buf, data);
+			if (r)
+				break;
+		}
+	}
+	if (!r && subdir_cb)
+		r = subdir_cb(de->d_name, path->buf, data);
+	closedir(dir);
+	return r;
+}
+
+int for_each_loose_file_in_objdir(const char *path,
+			    each_loose_object_fn obj_cb,
+			    each_loose_cruft_fn cruft_cb,
+			    each_loose_subdir_fn subdir_cb,
+			    void *data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	size_t baselen;
+	DIR *dir = opendir(path);
+	struct dirent *de;
+	int r = 0;
+
+	if (!dir)
+		return opendir_error(path);
+
+	strbuf_addstr(&buf, path);
+	baselen = buf.len;
+
+	while ((de = readdir(dir))) {
+		if (!isxdigit(de->d_name[0]) ||
+		    !isxdigit(de->d_name[1]) ||
+		    de->d_name[2])
+			continue;
+
+		strbuf_addf(&buf, "/%s", de->d_name);
+		r = for_each_file_in_obj_subdir(&buf, de->d_name, obj_cb,
+						cruft_cb, subdir_cb, data);
+		strbuf_setlen(&buf, baselen);
+		if (r)
+			break;
+	}
+
+	closedir(dir);
+	strbuf_release(&buf);
+	return r;
+}
-- 
2.1.1.566.gdb1f904
