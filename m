Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45323208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 12:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750731AbdIEMOe (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 08:14:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:57146 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751291AbdIEMOc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 08:14:32 -0400
Received: (qmail 31281 invoked by uid 109); 5 Sep 2017 12:14:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 12:14:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12226 invoked by uid 111); 5 Sep 2017 12:15:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:15:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 08:14:30 -0400
Date:   Tue, 5 Sep 2017 08:14:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 06/20] tempfile: do not delete tempfile on failed close
Message-ID: <20170905121429.3qpx7ygtx6dpqnmm@sigill.intra.peff.net>
References: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When close_tempfile() fails, we delete the tempfile and
reset the fields of the tempfile struct. This makes it
easier for callers to return without cleaning up, but it
also makes this common pattern:

  if (close_tempfile(tempfile))
	return error_errno("error closing %s", tempfile->filename.buf);

wrong, because the "filename" field has been reset after the
failed close. And it's not easy to fix, as in many cases we
don't have another copy of the filename (e.g., if it was
created via one of the mks_tempfile functions, and we just
have the original template string).

Let's drop the feature that a failed close automatically
deletes the file. This puts the burden on the caller to do
the deletion themselves, but this isn't that big a deal.
Callers which do:

  if (write(...) || close_tempfile(...)) {
	delete_tempfile(...);
	return -1;
  }

already had to call delete when the write() failed, and so
aren't affected. Likewise, any caller which just calls die()
in the error path is OK; we'll delete the tempfile during
the atexit handler.

Because this patch changes the semantics of close_tempfile()
without changing its signature, all callers need to be
manually checked and converted to the new scheme. This patch
covers all in-tree callers, but there may be others for
not-yet-merged topics. To catch these, we rename the
function to close_tempfile_gently(), which will attract
compile-time attention to new callers. (Technically the
original could be considered "gentle" already in that it
didn't die() on errors, but this one is even more so).

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c          |  2 +-
 gpg-interface.c |  2 +-
 lockfile.h      |  8 +++++++-
 read-cache.c    |  7 +++++--
 shallow.c       |  2 +-
 tempfile.c      | 31 ++++++++++++-------------------
 tempfile.h      | 25 +++++++++++++------------
 7 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/diff.c b/diff.c
index fdb974014b..20f68ec389 100644
--- a/diff.c
+++ b/diff.c
@@ -3739,7 +3739,7 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 		size = buf.len;
 	}
 	if (write_in_full(fd, blob, size) != size ||
-	    close_tempfile(&temp->tempfile))
+	    close_tempfile_gently(&temp->tempfile))
 		die_errno("unable to write temp-file");
 	temp->name = get_tempfile_path(&temp->tempfile);
 	oid_to_hex_r(temp->hex, oid);
diff --git a/gpg-interface.c b/gpg-interface.c
index 05ca6ecbfd..4ea2597ff4 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -210,7 +210,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	if (fd < 0)
 		return error_errno(_("could not create temporary file"));
 	if (write_in_full(fd, signature, signature_size) < 0 ||
-	    close_tempfile(&temp) < 0) {
+	    close_tempfile_gently(&temp) < 0) {
 		error_errno(_("failed writing detached signature to '%s'"),
 			    temp.filename.buf);
 		delete_tempfile(&temp);
diff --git a/lockfile.h b/lockfile.h
index 572064939c..dd4259bc40 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -246,7 +246,13 @@ extern char *get_locked_file_path(struct lock_file *lk);
  */
 static inline int close_lock_file(struct lock_file *lk)
 {
-	return close_tempfile(&lk->tempfile);
+	int ret = close_tempfile_gently(&lk->tempfile);
+	if (ret) {
+		int saved_errno = errno;
+		delete_tempfile(&lk->tempfile);
+		errno = saved_errno;
+	}
+	return ret;
 }
 
 /*
diff --git a/read-cache.c b/read-cache.c
index 40da87ea71..51686518e0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2309,8 +2309,11 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 
 	if (ce_flush(&c, newfd, istate->sha1))
 		return -1;
-	if (close_tempfile(tempfile))
-		return error(_("could not close '%s'"), tempfile->filename.buf);
+	if (close_tempfile_gently(tempfile)) {
+		error(_("could not close '%s'"), tempfile->filename.buf);
+		delete_tempfile(tempfile);
+		return -1;
+	}
 	if (stat(tempfile->filename.buf, &st))
 		return -1;
 	istate->timestamp.sec = (unsigned int)st.st_mtime;
diff --git a/shallow.c b/shallow.c
index f49e6ae122..36216febb6 100644
--- a/shallow.c
+++ b/shallow.c
@@ -296,7 +296,7 @@ const char *setup_temporary_shallow(const struct oid_array *extra)
 		fd = xmks_tempfile(&temp, git_path("shallow_XXXXXX"));
 
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len ||
-		    close_tempfile(&temp) < 0)
+		    close_tempfile_gently(&temp) < 0)
 			die_errno("failed to write to %s",
 				  get_tempfile_path(&temp));
 		strbuf_release(&sb);
diff --git a/tempfile.c b/tempfile.c
index 6843710670..c6740e562c 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -30,13 +30,12 @@
  *     `fdopen_tempfile()` has been called on the object
  *   - `owner` holds the PID of the process that created the file
  *
- * - Active, file closed (after successful `close_tempfile()`). Same
+ * - Active, file closed (after `close_tempfile_gently()`). Same
  *   as the previous state, except that the temporary file is closed,
  *   `fd` is -1, and `fp` is `NULL`.
  *
- * - Inactive (after `delete_tempfile()`, `rename_tempfile()`, a
- *   failed attempt to create a temporary file, or a failed
- *   `close_tempfile()`). In this state:
+ * - Inactive (after `delete_tempfile()`, `rename_tempfile()`, or a
+ *   failed attempt to create a temporary file). In this state:
  *
  *   - `active` is unset
  *   - `filename` is empty (usually, though there are transitory
@@ -235,7 +234,7 @@ FILE *get_tempfile_fp(struct tempfile *tempfile)
 	return tempfile->fp;
 }
 
-int close_tempfile(struct tempfile *tempfile)
+int close_tempfile_gently(struct tempfile *tempfile)
 {
 	int fd = tempfile->fd;
 	FILE *fp = tempfile->fp;
@@ -258,14 +257,7 @@ int close_tempfile(struct tempfile *tempfile)
 		err = close(fd);
 	}
 
-	if (err) {
-		int save_errno = errno;
-		delete_tempfile(tempfile);
-		errno = save_errno;
-		return -1;
-	}
-
-	return 0;
+	return err ? -1 : 0;
 }
 
 int reopen_tempfile(struct tempfile *tempfile)
@@ -283,8 +275,10 @@ int rename_tempfile(struct tempfile *tempfile, const char *path)
 	if (!tempfile->active)
 		die("BUG: rename_tempfile called for inactive object");
 
-	if (close_tempfile(tempfile))
+	if (close_tempfile_gently(tempfile)) {
+		delete_tempfile(tempfile);
 		return -1;
+	}
 
 	if (rename(tempfile->filename.buf, path)) {
 		int save_errno = errno;
@@ -303,9 +297,8 @@ void delete_tempfile(struct tempfile *tempfile)
 	if (!tempfile->active)
 		return;
 
-	if (!close_tempfile(tempfile)) {
-		unlink_or_warn(tempfile->filename.buf);
-		tempfile->active = 0;
-		strbuf_reset(&tempfile->filename);
-	}
+	close_tempfile_gently(tempfile);
+	unlink_or_warn(tempfile->filename.buf);
+	tempfile->active = 0;
+	strbuf_reset(&tempfile->filename);
 }
diff --git a/tempfile.h b/tempfile.h
index 2f0038decd..d854dcdd3e 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -47,7 +47,7 @@
  *   control of the file.
  *
  * * Close the file descriptor without removing or renaming the
- *   temporary file by calling `close_tempfile()`, and later call
+ *   temporary file by calling `close_tempfile_gently()`, and later call
  *   `delete_tempfile()` or `rename_tempfile()`.
  *
  * Even after the temporary file is renamed or deleted, the `tempfile`
@@ -59,7 +59,7 @@
  * and remove the temporary file.
  *
  * If you need to close the file descriptor yourself, do so by calling
- * `close_tempfile()`. You should never call `close(2)` or `fclose(3)`
+ * `close_tempfile_gently()`. You should never call `close(2)` or `fclose(3)`
  * yourself, otherwise the `struct tempfile` structure would still
  * think that the file descriptor needs to be closed, and a later
  * cleanup would result in duplicate calls to `close(2)`. Worse yet,
@@ -74,9 +74,10 @@
  * `create_tempfile()` returns a file descriptor on success or -1 on
  * failure. On errors, `errno` describes the reason for failure.
  *
- * `delete_tempfile()`, `rename_tempfile()`, and `close_tempfile()`
- * return 0 on success. On failure they set `errno` appropriately, do
- * their best to delete the temporary file, and return -1.
+ * `delete_tempfile()`, `rename_tempfile()`, and `close_tempfile_gently()`
+ * return 0 on success. On failure they set `errno` appropriately and return
+ * -1. `delete` and `rename` (but not `close`) do their best to delete the
+ * temporary file before returning.
  */
 
 struct tempfile {
@@ -203,7 +204,7 @@ static inline int xmks_tempfile(struct tempfile *tempfile,
 /*
  * Associate a stdio stream with the temporary file (which must still
  * be open). Return `NULL` (*without* deleting the file) on error. The
- * stream is closed automatically when `close_tempfile()` is called or
+ * stream is closed automatically when `close_tempfile_gently()` is called or
  * when the file is deleted or renamed.
  */
 extern FILE *fdopen_tempfile(struct tempfile *tempfile, const char *mode);
@@ -226,20 +227,20 @@ extern FILE *get_tempfile_fp(struct tempfile *tempfile);
  * If the temporary file is still open, close it (and the file pointer
  * too, if it has been opened using `fdopen_tempfile()`) without
  * deleting the file. Return 0 upon success. On failure to `close(2)`,
- * return a negative value and delete the file. Usually
- * `delete_tempfile()` or `rename_tempfile()` should eventually be
- * called if `close_tempfile()` succeeds.
+ * return a negative value. Usually `delete_tempfile()` or `rename_tempfile()`
+ * should eventually be called regardless of whether `close_tempfile_gently()`
+ * succeeds.
  */
-extern int close_tempfile(struct tempfile *tempfile);
+extern int close_tempfile_gently(struct tempfile *tempfile);
 
 /*
  * Re-open a temporary file that has been closed using
- * `close_tempfile()` but not yet deleted or renamed. This can be used
+ * `close_tempfile_gently()` but not yet deleted or renamed. This can be used
  * to implement a sequence of operations like the following:
  *
  * * Create temporary file.
  *
- * * Write new contents to file, then `close_tempfile()` to cause the
+ * * Write new contents to file, then `close_tempfile_gently()` to cause the
  *   contents to be written to disk.
  *
  * * Pass the name of the temporary file to another program to allow
-- 
2.14.1.721.gc5bc1565f1

