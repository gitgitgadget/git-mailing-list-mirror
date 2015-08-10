From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/16] tempfile: a new module for handling temporary files
Date: Mon, 10 Aug 2015 11:47:41 +0200
Message-ID: <17bde70a9d61398ef98533847ed6eb3eabdedda2.1439198011.git.mhagger@alum.mit.edu>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:48:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjgj-0001vA-S3
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714AbbHJJsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:48:07 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:47157 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753216AbbHJJsE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 05:48:04 -0400
X-AuditID: 12074411-f797e6d000007df3-84-55c8735383ef
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id BC.D6.32243.35378C55; Mon, 10 Aug 2015 05:48:03 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7A9lswu021057
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Aug 2015 05:48:02 -0400
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1439198011.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsUixO6iqBtcfCLUoPuXtEXXlW4mi4beK8wW
	T+beZba4vWI+swOLx9/3H5g8Hr7qYve4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujGX79zEX
	vLzLWNE/5RhTA+OejYxdjJwcEgImEuvu32aDsMUkLtxbD2RzcQgJXGaU+NozkxnCOcEkcezE
	TXaQKjYBXYlFPc1MILaIgJrExLZDLCA2s0C6xIkF7WC2sICvxK1TEBtYBFQlTpxfAbaBVyBK
	4ubXL6xdjBxA2+QkFlxIBwlzClhIbG/cwApiCwmYSzyed559AiPvAkaGVYxyiTmlubq5iZk5
	xanJusXJiXl5qUW6pnq5mSV6qSmlmxghISS4g3HGSblDjAIcjEo8vDM2Hw8VYk0sK67MPcQo
	ycGkJMprkX8iVIgvKT+lMiOxOCO+qDQntfgQowQHs5IIb3wGUI43JbGyKrUoHyYlzcGiJM7L
	t0TdT0ggPbEkNTs1tSC1CCYrw8GhJMF7rxCoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUo
	sbQkIx4UHfHFwPgASfEA7bUrAtlbXJCYCxSFaD3FqCglzvsHZK4ASCKjNA9uLCwxvGIUB/pS
	mHcPSBUPMKnAdb8CGswEMjgQbHBJIkJKqoFxsXyU/VUeOQ0Ra3u9GxIMu/x+9T6cb7h6l4Lo
	uX+MnHrbJfZZqB+xN1u/qU5mSqWzpob+rRtBz7YvO6hgw8/i2/fkSMetFffKD8oavnauWXpQ
	hSUzLyh3184lTUujbU5VVt/tn/fH+340w6F5bjf2JDvI7fhy/HnTnjtxW7cJ3Tii 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275588>

A lot of work went into defining the state diagram for lockfiles and
ensuring correct, race-resistant cleanup in all circumstances.

Most of that infrastructure can be applied directly to *any* temporary
file. So extract a new "tempfile" module from the "lockfile" module.
Reimplement lockfile on top of tempfile.

Subsequent commits will add more users of the new module.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Makefile   |   1 +
 lockfile.c | 261 ++++---------------------------------------------------------
 lockfile.h |  73 +++++++++++------
 tempfile.c | 238 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tempfile.h | 167 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 470 insertions(+), 270 deletions(-)
 create mode 100644 tempfile.c
 create mode 100644 tempfile.h

diff --git a/Makefile b/Makefile
index 54ec511..2573f89 100644
--- a/Makefile
+++ b/Makefile
@@ -786,6 +786,7 @@ LIB_OBJS += string-list.o
 LIB_OBJS += submodule.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
+LIB_OBJS += tempfile.o
 LIB_OBJS += trace.o
 LIB_OBJS += trailer.o
 LIB_OBJS += transport.o
diff --git a/lockfile.c b/lockfile.c
index 3904803..e1d68f7 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -2,90 +2,8 @@
  * Copyright (c) 2005, Junio C Hamano
  */
 
-/*
- * State diagram and cleanup
- * -------------------------
- *
- * This module keeps track of all locked files in `lock_file_list` for
- * use at cleanup. This list and the `lock_file` objects that comprise
- * it must be kept in self-consistent states at all time, because the
- * program can be interrupted any time by a signal, in which case the
- * signal handler will walk through the list attempting to clean up
- * any open lock files.
- *
- * The possible states of a `lock_file` object are as follows:
- *
- * - Uninitialized. In this state the object's `on_list` field must be
- *   zero but the rest of its contents need not be initialized. As
- *   soon as the object is used in any way, it is irrevocably
- *   registered in `lock_file_list`, and `on_list` is set.
- *
- * - Locked, lockfile open (after `hold_lock_file_for_update()`,
- *   `hold_lock_file_for_append()`, or `reopen_lock_file()`). In this
- *   state:
- *
- *   - the lockfile exists
- *   - `active` is set
- *   - `filename` holds the filename of the lockfile
- *   - `fd` holds a file descriptor open for writing to the lockfile
- *   - `fp` holds a pointer to an open `FILE` object if and only if
- *     `fdopen_lock_file()` has been called on the object
- *   - `owner` holds the PID of the process that locked the file
- *
- * - Locked, lockfile closed (after successful `close_lock_file()`).
- *   Same as the previous state, except that the lockfile is closed
- *   and `fd` is -1.
- *
- * - Unlocked (after `commit_lock_file()`, `commit_lock_file_to()`,
- *   `rollback_lock_file()`, a failed attempt to lock, or a failed
- *   `close_lock_file()`).  In this state:
- *
- *   - `active` is unset
- *   - `filename` is empty (usually, though there are transitory
- *     states in which this condition doesn't hold). Client code should
- *     *not* rely on the filename being empty in this state.
- *   - `fd` is -1
- *   - the object is left registered in the `lock_file_list`, and
- *     `on_list` is set.
- *
- * A lockfile is owned by the process that created it. The `lock_file`
- * has an `owner` field that records the owner's PID. This field is
- * used to prevent a forked process from closing a lockfile created by
- * its parent.
- */
-
 #include "cache.h"
 #include "lockfile.h"
-#include "sigchain.h"
-
-static struct lock_file *volatile lock_file_list;
-
-static void remove_lock_files(int skip_fclose)
-{
-	pid_t me = getpid();
-
-	while (lock_file_list) {
-		if (lock_file_list->owner == me) {
-			/* fclose() is not safe to call in a signal handler */
-			if (skip_fclose)
-				lock_file_list->fp = NULL;
-			rollback_lock_file(lock_file_list);
-		}
-		lock_file_list = lock_file_list->next;
-	}
-}
-
-static void remove_lock_files_on_exit(void)
-{
-	remove_lock_files(0);
-}
-
-static void remove_lock_files_on_signal(int signo)
-{
-	remove_lock_files(1);
-	sigchain_pop(signo);
-	raise(signo);
-}
 
 /*
  * path = absolute or relative path name
@@ -154,60 +72,17 @@ static void resolve_symlink(struct strbuf *path)
 /* Make sure errno contains a meaningful value on error */
 static int lock_file(struct lock_file *lk, const char *path, int flags)
 {
-	size_t pathlen = strlen(path);
-
-	if (!lock_file_list) {
-		/* One-time initialization */
-		sigchain_push_common(remove_lock_files_on_signal);
-		atexit(remove_lock_files_on_exit);
-	}
+	int fd;
+	struct strbuf filename = STRBUF_INIT;
 
-	if (lk->active)
-		die("BUG: cannot lock_file(\"%s\") using active struct lock_file",
-		    path);
-	if (!lk->on_list) {
-		/* Initialize *lk and add it to lock_file_list: */
-		lk->fd = -1;
-		lk->fp = NULL;
-		lk->active = 0;
-		lk->owner = 0;
-		strbuf_init(&lk->filename, pathlen + LOCK_SUFFIX_LEN);
-		lk->next = lock_file_list;
-		lock_file_list = lk;
-		lk->on_list = 1;
-	} else if (lk->filename.len) {
-		/* This shouldn't happen, but better safe than sorry. */
-		die("BUG: lock_file(\"%s\") called with improperly-reset lock_file object",
-		    path);
-	}
+	strbuf_addstr(&filename, path);
+	if (!(flags & LOCK_NO_DEREF))
+		resolve_symlink(&filename);
 
-	if (flags & LOCK_NO_DEREF) {
-		strbuf_add_absolute_path(&lk->filename, path);
-	} else {
-		struct strbuf resolved_path = STRBUF_INIT;
-
-		strbuf_add(&resolved_path, path, pathlen);
-		resolve_symlink(&resolved_path);
-		strbuf_add_absolute_path(&lk->filename, resolved_path.buf);
-		strbuf_release(&resolved_path);
-	}
-
-	strbuf_addstr(&lk->filename, LOCK_SUFFIX);
-	lk->fd = open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
-	if (lk->fd < 0) {
-		strbuf_reset(&lk->filename);
-		return -1;
-	}
-	lk->owner = getpid();
-	lk->active = 1;
-	if (adjust_shared_perm(lk->filename.buf)) {
-		int save_errno = errno;
-		error("cannot fix permission bits on %s", lk->filename.buf);
-		rollback_lock_file(lk);
-		errno = save_errno;
-		return -1;
-	}
-	return lk->fd;
+	strbuf_addstr(&filename, LOCK_SUFFIX);
+	fd = create_tempfile(&lk->tempfile, filename.buf);
+	strbuf_release(&filename);
+	return fd;
 }
 
 static int sleep_microseconds(long us)
@@ -353,109 +228,17 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 	return fd;
 }
 
-FILE *fdopen_lock_file(struct lock_file *lk, const char *mode)
-{
-	if (!lk->active)
-		die("BUG: fdopen_lock_file() called for unlocked object");
-	if (lk->fp)
-		die("BUG: fdopen_lock_file() called twice for file '%s'", lk->filename.buf);
-
-	lk->fp = fdopen(lk->fd, mode);
-	return lk->fp;
-}
-
-const char *get_lock_file_path(struct lock_file *lk)
-{
-	if (!lk->active)
-		die("BUG: get_lock_file_path() called for unlocked object");
-	return lk->filename.buf;
-}
-
-int get_lock_file_fd(struct lock_file *lk)
-{
-	if (!lk->active)
-		die("BUG: get_lock_file_fd() called for unlocked object");
-	return lk->fd;
-}
-
-FILE *get_lock_file_fp(struct lock_file *lk)
-{
-	if (!lk->active)
-		die("BUG: get_lock_file_fp() called for unlocked object");
-	return lk->fp;
-}
-
 char *get_locked_file_path(struct lock_file *lk)
 {
-	if (!lk->active)
-		die("BUG: get_locked_file_path() called for unlocked object");
-	if (lk->filename.len <= LOCK_SUFFIX_LEN ||
-	    strcmp(lk->filename.buf + lk->filename.len - LOCK_SUFFIX_LEN, LOCK_SUFFIX))
+	struct strbuf ret = STRBUF_INIT;
+
+	strbuf_addstr(&ret, get_tempfile_path(&lk->tempfile));
+	if (ret.len <= LOCK_SUFFIX_LEN ||
+	    strcmp(ret.buf + ret.len - LOCK_SUFFIX_LEN, LOCK_SUFFIX))
 		die("BUG: get_locked_file_path() called for malformed lock object");
 	/* remove ".lock": */
-	return xmemdupz(lk->filename.buf, lk->filename.len - LOCK_SUFFIX_LEN);
-}
-
-int close_lock_file(struct lock_file *lk)
-{
-	int fd = lk->fd;
-	FILE *fp = lk->fp;
-	int err;
-
-	if (fd < 0)
-		return 0;
-
-	lk->fd = -1;
-	if (fp) {
-		lk->fp = NULL;
-
-		/*
-		 * Note: no short-circuiting here; we want to fclose()
-		 * in any case!
-		 */
-		err = ferror(fp) | fclose(fp);
-	} else {
-		err = close(fd);
-	}
-
-	if (err) {
-		int save_errno = errno;
-		rollback_lock_file(lk);
-		errno = save_errno;
-		return -1;
-	}
-
-	return 0;
-}
-
-int reopen_lock_file(struct lock_file *lk)
-{
-	if (0 <= lk->fd)
-		die(_("BUG: reopen a lockfile that is still open"));
-	if (!lk->active)
-		die(_("BUG: reopen a lockfile that has been committed"));
-	lk->fd = open(lk->filename.buf, O_WRONLY);
-	return lk->fd;
-}
-
-int commit_lock_file_to(struct lock_file *lk, const char *path)
-{
-	if (!lk->active)
-		die("BUG: attempt to commit unlocked object to \"%s\"", path);
-
-	if (close_lock_file(lk))
-		return -1;
-
-	if (rename(lk->filename.buf, path)) {
-		int save_errno = errno;
-		rollback_lock_file(lk);
-		errno = save_errno;
-		return -1;
-	}
-
-	lk->active = 0;
-	strbuf_reset(&lk->filename);
-	return 0;
+	strbuf_setlen(&ret, ret.len - LOCK_SUFFIX_LEN);
+	return strbuf_detach(&ret, NULL);
 }
 
 int commit_lock_file(struct lock_file *lk)
@@ -471,15 +254,3 @@ int commit_lock_file(struct lock_file *lk)
 	free(result_path);
 	return 0;
 }
-
-void rollback_lock_file(struct lock_file *lk)
-{
-	if (!lk->active)
-		return;
-
-	if (!close_lock_file(lk)) {
-		unlink_or_warn(lk->filename.buf);
-		lk->active = 0;
-		strbuf_reset(&lk->filename);
-	}
-}
diff --git a/lockfile.h b/lockfile.h
index a204ab6..8131fa3 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -29,6 +29,8 @@
  * the file or the new contents of the file (assuming that the
  * filesystem implements `rename(2)` atomically).
  *
+ * Most of the heavy lifting is done by the tempfile module (see
+ * "tempfile.h").
  *
  * Calling sequence
  * ----------------
@@ -74,19 +76,19 @@
  * `hold_lock_file_for_update()` or `hold_lock_file_for_append()`.
  *
  * If the program exits before `commit_lock_file()`,
- * `commit_lock_file_to()`, or `rollback_lock_file()` is called, an
- * `atexit(3)` handler will close and remove the lockfile, thereby
- * rolling back any uncommitted changes.
+ * `commit_lock_file_to()`, or `rollback_lock_file()` is called, the
+ * tempfile module will close and remove the lockfile, thereby rolling
+ * back any uncommitted changes.
  *
  * If you need to close the file descriptor you obtained from a
  * `hold_lock_file_for_*()` function yourself, do so by calling
- * `close_lock_file()`. You should never call `close(2)` or
- * `fclose(3)` yourself, otherwise the `struct lock_file` structure
- * would still think that the file descriptor needs to be closed, and
- * a commit or rollback would result in duplicate calls to `close(2)`.
- * Worse yet, if you close and then later open another file descriptor
- * for a completely different purpose, then a commit or rollback might
- * close that unrelated file descriptor.
+ * `close_lock_file()`. See "tempfile.h" for more information.
+ *
+ *
+ * Under the covers, a lockfile is just a tempfile with a few helper
+ * functions. In particular, the state diagram and the cleanup
+ * machinery are all implemented in the tempfile module.
+ *
  *
  * Error handling
  * --------------
@@ -103,14 +105,10 @@
  * -1.
  */
 
+#include "tempfile.h"
+
 struct lock_file {
-	struct lock_file *volatile next;
-	volatile sig_atomic_t active;
-	volatile int fd;
-	FILE *volatile fp;
-	volatile pid_t owner;
-	char on_list;
-	struct strbuf filename;
+	struct tempfile tempfile;
 };
 
 /* String appended to a filename to derive the lockfile name: */
@@ -201,16 +199,29 @@ extern NORETURN void unable_to_lock_die(const char *path, int err);
  * error. The stream is closed automatically when `close_lock_file()`
  * is called or when the file is committed or rolled back.
  */
-extern FILE *fdopen_lock_file(struct lock_file *lk, const char *mode);
+static inline FILE *fdopen_lock_file(struct lock_file *lk, const char *mode)
+{
+	return fdopen_tempfile(&lk->tempfile, mode);
+}
 
 /*
  * Return the path of the lockfile. The return value is a pointer to a
  * field within the lock_file object and should not be freed.
  */
-extern const char *get_lock_file_path(struct lock_file *lk);
+static inline const char *get_lock_file_path(struct lock_file *lk)
+{
+	return get_tempfile_path(&lk->tempfile);
+}
 
-extern int get_lock_file_fd(struct lock_file *lk);
-extern FILE *get_lock_file_fp(struct lock_file *lk);
+static inline int get_lock_file_fd(struct lock_file *lk)
+{
+	return get_tempfile_fd(&lk->tempfile);
+}
+
+static inline FILE *get_lock_file_fp(struct lock_file *lk)
+{
+	return get_tempfile_fp(&lk->tempfile);
+}
 
 /*
  * Return the path of the file that is locked by the specified
@@ -227,7 +238,10 @@ extern char *get_locked_file_path(struct lock_file *lk);
  * or `rollback_lock_file()` should eventually be called if
  * `close_lock_file()` succeeds.
  */
-extern int close_lock_file(struct lock_file *lk);
+static inline int close_lock_file(struct lock_file *lk)
+{
+	return close_tempfile(&lk->tempfile);
+}
 
 /*
  * Re-open a lockfile that has been closed using `close_lock_file()`
@@ -248,7 +262,10 @@ extern int close_lock_file(struct lock_file *lk);
  *
  * * `commit_lock_file()` to make the final version permanent.
  */
-extern int reopen_lock_file(struct lock_file *lk);
+static inline int reopen_lock_file(struct lock_file *lk)
+{
+	return reopen_tempfile(&lk->tempfile);
+}
 
 /*
  * Commit the change represented by `lk`: close the file descriptor
@@ -265,7 +282,10 @@ extern int commit_lock_file(struct lock_file *lk);
  * Like `commit_lock_file()`, but rename the lockfile to the provided
  * `path`. `path` must be on the same filesystem as the lock file.
  */
-extern int commit_lock_file_to(struct lock_file *lk, const char *path);
+static inline int commit_lock_file_to(struct lock_file *lk, const char *path)
+{
+	return rename_tempfile(&lk->tempfile, path);
+}
 
 /*
  * Roll back `lk`: close the file descriptor and/or file pointer and
@@ -273,6 +293,9 @@ extern int commit_lock_file_to(struct lock_file *lk, const char *path);
  * for a `lock_file` object that has already been committed or rolled
  * back.
  */
-extern void rollback_lock_file(struct lock_file *lk);
+static inline void rollback_lock_file(struct lock_file *lk)
+{
+	delete_tempfile(&lk->tempfile);
+}
 
 #endif /* LOCKFILE_H */
diff --git a/tempfile.c b/tempfile.c
new file mode 100644
index 0000000..d835818
--- /dev/null
+++ b/tempfile.c
@@ -0,0 +1,238 @@
+/*
+ * State diagram and cleanup
+ * -------------------------
+ *
+ * If the program exits while a temporary file is active, we want to
+ * make sure that we remove it. This is done by remembering the active
+ * temporary files in a linked list, `tempfile_list`. An `atexit(3)`
+ * handler and a signal handler are registered, to clean up any active
+ * temporary files.
+ *
+ * Because the signal handler can run at any time, `tempfile_list` and
+ * the `tempfile` objects that comprise it must be kept in
+ * self-consistent states at all times.
+ *
+ * The possible states of a `tempfile` object are as follows:
+ *
+ * - Uninitialized. In this state the object's `on_list` field must be
+ *   zero but the rest of its contents need not be initialized. As
+ *   soon as the object is used in any way, it is irrevocably
+ *   registered in `tempfile_list`, and `on_list` is set.
+ *
+ * - Active, file open (after `create_tempfile()` or
+ *   `reopen_tempfile()`). In this state:
+ *
+ *   - the temporary file exists
+ *   - `active` is set
+ *   - `filename` holds the filename of the temporary file
+ *   - `fd` holds a file descriptor open for writing to it
+ *   - `fp` holds a pointer to an open `FILE` object if and only if
+ *     `fdopen_tempfile()` has been called on the object
+ *   - `owner` holds the PID of the process that created the file
+ *
+ * - Active, file closed (after successful `close_tempfile()`). Same
+ *   as the previous state, except that the temporary file is closed,
+ *   `fd` is -1, and `fp` is `NULL`.
+ *
+ * - Inactive (after `delete_tempfile()`, `rename_tempfile()`, a
+ *   failed attempt to create a temporary file, or a failed
+ *   `close_tempfile()`). In this state:
+ *
+ *   - `active` is unset
+ *   - `filename` is empty (usually, though there are transitory
+ *     states in which this condition doesn't hold). Client code should
+ *     *not* rely on the filename being empty in this state.
+ *   - `fd` is -1 and `fp` is `NULL`
+ *   - the object is left registered in the `tempfile_list`, and
+ *     `on_list` is set.
+ *
+ * A temporary file is owned by the process that created it. The
+ * `tempfile` has an `owner` field that records the owner's PID. This
+ * field is used to prevent a forked process from deleting a temporary
+ * file created by its parent.
+ */
+
+#include "cache.h"
+#include "tempfile.h"
+#include "sigchain.h"
+
+static struct tempfile *volatile tempfile_list;
+
+static void remove_tempfiles(int skip_fclose)
+{
+	pid_t me = getpid();
+
+	while (tempfile_list) {
+		if (tempfile_list->owner == me) {
+			/* fclose() is not safe to call in a signal handler */
+			if (skip_fclose)
+				tempfile_list->fp = NULL;
+			delete_tempfile(tempfile_list);
+		}
+		tempfile_list = tempfile_list->next;
+	}
+}
+
+static void remove_tempfiles_on_exit(void)
+{
+	remove_tempfiles(0);
+}
+
+static void remove_tempfiles_on_signal(int signo)
+{
+	remove_tempfiles(1);
+	sigchain_pop(signo);
+	raise(signo);
+}
+
+/* Make sure errno contains a meaningful value on error */
+int create_tempfile(struct tempfile *tempfile, const char *path)
+{
+	size_t pathlen = strlen(path);
+
+	if (!tempfile_list) {
+		/* One-time initialization */
+		sigchain_push_common(remove_tempfiles_on_signal);
+		atexit(remove_tempfiles_on_exit);
+	}
+
+	if (tempfile->active)
+		die("BUG: create_tempfile called for active object");
+	if (!tempfile->on_list) {
+		/* Initialize *tempfile and add it to tempfile_list: */
+		tempfile->fd = -1;
+		tempfile->fp = NULL;
+		tempfile->active = 0;
+		tempfile->owner = 0;
+		strbuf_init(&tempfile->filename, pathlen);
+		tempfile->next = tempfile_list;
+		tempfile_list = tempfile;
+		tempfile->on_list = 1;
+	} else if (tempfile->filename.len) {
+		/* This shouldn't happen, but better safe than sorry. */
+		die("BUG: create_tempfile called for improperly-reset object");
+	}
+
+	strbuf_add_absolute_path(&tempfile->filename, path);
+	tempfile->fd = open(tempfile->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
+	if (tempfile->fd < 0) {
+		strbuf_reset(&tempfile->filename);
+		return -1;
+	}
+	tempfile->owner = getpid();
+	tempfile->active = 1;
+	if (adjust_shared_perm(tempfile->filename.buf)) {
+		int save_errno = errno;
+		error("cannot fix permission bits on %s", tempfile->filename.buf);
+		delete_tempfile(tempfile);
+		errno = save_errno;
+		return -1;
+	}
+	return tempfile->fd;
+}
+
+FILE *fdopen_tempfile(struct tempfile *tempfile, const char *mode)
+{
+	if (!tempfile->active)
+		die("BUG: fdopen_tempfile() called for inactive object");
+	if (tempfile->fp)
+		die("BUG: fdopen_tempfile() called for open object");
+
+	tempfile->fp = fdopen(tempfile->fd, mode);
+	return tempfile->fp;
+}
+
+const char *get_tempfile_path(struct tempfile *tempfile)
+{
+	if (!tempfile->active)
+		die("BUG: get_tempfile_path() called for inactive object");
+	return tempfile->filename.buf;
+}
+
+int get_tempfile_fd(struct tempfile *tempfile)
+{
+	if (!tempfile->active)
+		die("BUG: get_tempfile_fd() called for inactive object");
+	return tempfile->fd;
+}
+
+FILE *get_tempfile_fp(struct tempfile *tempfile)
+{
+	if (!tempfile->active)
+		die("BUG: get_tempfile_fp() called for inactive object");
+	return tempfile->fp;
+}
+
+int close_tempfile(struct tempfile *tempfile)
+{
+	int fd = tempfile->fd;
+	FILE *fp = tempfile->fp;
+	int err;
+
+	if (fd < 0)
+		return 0;
+
+	tempfile->fd = -1;
+	if (fp) {
+		tempfile->fp = NULL;
+
+		/*
+		 * Note: no short-circuiting here; we want to fclose()
+		 * in any case!
+		 */
+		err = ferror(fp) | fclose(fp);
+	} else {
+		err = close(fd);
+	}
+
+	if (err) {
+		int save_errno = errno;
+		delete_tempfile(tempfile);
+		errno = save_errno;
+		return -1;
+	}
+
+	return 0;
+}
+
+int reopen_tempfile(struct tempfile *tempfile)
+{
+	if (0 <= tempfile->fd)
+		die("BUG: reopen_tempfile called for an open object");
+	if (!tempfile->active)
+		die("BUG: reopen_tempfile called for an inactive object");
+	tempfile->fd = open(tempfile->filename.buf, O_WRONLY);
+	return tempfile->fd;
+}
+
+int rename_tempfile(struct tempfile *tempfile, const char *path)
+{
+	if (!tempfile->active)
+		die("BUG: rename_tempfile called for inactive object");
+
+	if (close_tempfile(tempfile))
+		return -1;
+
+	if (rename(tempfile->filename.buf, path)) {
+		int save_errno = errno;
+		delete_tempfile(tempfile);
+		errno = save_errno;
+		return -1;
+	}
+
+	tempfile->active = 0;
+	strbuf_reset(&tempfile->filename);
+	return 0;
+}
+
+void delete_tempfile(struct tempfile *tempfile)
+{
+	if (!tempfile->active)
+		return;
+
+	if (!close_tempfile(tempfile)) {
+		unlink_or_warn(tempfile->filename.buf);
+		tempfile->active = 0;
+		strbuf_reset(&tempfile->filename);
+	}
+}
diff --git a/tempfile.h b/tempfile.h
new file mode 100644
index 0000000..bcc229f
--- /dev/null
+++ b/tempfile.h
@@ -0,0 +1,167 @@
+#ifndef TEMPFILE_H
+#define TEMPFILE_H
+
+/*
+ * Handle temporary files.
+ *
+ * The tempfile API allows temporary files to be created, deleted, and
+ * atomically renamed. Temporary files that are still active when the
+ * program ends are cleaned up automatically. Lockfiles (see
+ * "lockfile.h") are built on top of this API.
+ *
+ *
+ * Calling sequence
+ * ----------------
+ *
+ * The caller:
+ *
+ * * Allocates a `struct tempfile` either as a static variable or on
+ *   the heap, initialized to zeros. Once you use the structure to
+ *   call `create_tempfile()`, it belongs to the tempfile subsystem
+ *   and its storage must remain valid throughout the life of the
+ *   program (i.e. you cannot use an on-stack variable to hold this
+ *   structure).
+ *
+ * * Attempts to create a temporary file by calling
+ *   `create_tempfile()`.
+ *
+ * * Writes new content to the file by either:
+ *
+ *   * writing to the file descriptor returned by `create_tempfile()`
+ *     (also available via `tempfile->fd`).
+ *
+ *   * calling `fdopen_tempfile()` to get a `FILE` pointer for the
+ *     open file and writing to the file using stdio.
+ *
+ * When finished writing, the caller can:
+ *
+ * * Close the file descriptor and remove the temporary file by
+ *   calling `delete_tempfile()`.
+ *
+ * * Close the temporary file and rename it atomically to a specified
+ *   filename by calling `rename_tempfile()`. This relinquishes
+ *   control of the file.
+ *
+ * * Close the file descriptor without removing or renaming the
+ *   temporary file by calling `close_tempfile()`, and later call
+ *   `delete_tempfile()` or `rename_tempfile()`.
+ *
+ * Even after the temporary file is renamed or deleted, the `tempfile`
+ * object must not be freed or altered by the caller. However, it may
+ * be reused; just pass it to another call of `create_tempfile()`.
+ *
+ * If the program exits before `rename_tempfile()` or
+ * `delete_tempfile()` is called, an `atexit(3)` handler will close
+ * and remove the temporary file.
+ *
+ * If you need to close the file descriptor yourself, do so by calling
+ * `close_tempfile()`. You should never call `close(2)` or `fclose(3)`
+ * yourself, otherwise the `struct tempfile` structure would still
+ * think that the file descriptor needs to be closed, and a later
+ * cleanup would result in duplicate calls to `close(2)`. Worse yet,
+ * if you close and then later open another file descriptor for a
+ * completely different purpose, then the unrelated file descriptor
+ * might get closed.
+ *
+ *
+ * Error handling
+ * --------------
+ *
+ * `create_tempfile()` returns a file descriptor on success or -1 on
+ * failure. On errors, `errno` describes the reason for failure.
+ *
+ * `delete_tempfile()`, `rename_tempfile()`, and `close_tempfile()`
+ * return 0 on success. On failure they set `errno` appropriately, do
+ * their best to delete the temporary file, and return -1.
+ */
+
+struct tempfile {
+	struct tempfile *volatile next;
+	volatile sig_atomic_t active;
+	volatile int fd;
+	FILE *volatile fp;
+	volatile pid_t owner;
+	char on_list;
+	struct strbuf filename;
+};
+
+/*
+ * Attempt to create a temporary file at the specified `path`. Return
+ * a file descriptor for writing to it, or -1 on error. It is an error
+ * if a file already exists at that path.
+ */
+extern int create_tempfile(struct tempfile *tempfile, const char *path);
+
+/*
+ * Associate a stdio stream with the temporary file (which must still
+ * be open). Return `NULL` (*without* deleting the file) on error. The
+ * stream is closed automatically when `close_tempfile()` is called or
+ * when the file is deleted or renamed.
+ */
+extern FILE *fdopen_tempfile(struct tempfile *tempfile, const char *mode);
+
+static inline int is_tempfile_active(struct tempfile *tempfile)
+{
+	return tempfile->active;
+}
+
+/*
+ * Return the path of the lockfile. The return value is a pointer to a
+ * field within the lock_file object and should not be freed.
+ */
+extern const char *get_tempfile_path(struct tempfile *tempfile);
+
+extern int get_tempfile_fd(struct tempfile *tempfile);
+extern FILE *get_tempfile_fp(struct tempfile *tempfile);
+
+/*
+ * If the temporary file is still open, close it (and the file pointer
+ * too, if it has been opened using `fdopen_tempfile()`) without
+ * deleting the file. Return 0 upon success. On failure to `close(2)`,
+ * return a negative value and delete the file. Usually
+ * `delete_tempfile()` or `rename_tempfile()` should eventually be
+ * called if `close_tempfile()` succeeds.
+ */
+extern int close_tempfile(struct tempfile *tempfile);
+
+/*
+ * Re-open a temporary file that has been closed using
+ * `close_tempfile()` but not yet deleted or renamed. This can be used
+ * to implement a sequence of operations like the following:
+ *
+ * * Create temporary file.
+ *
+ * * Write new contents to file, then `close_tempfile()` to cause the
+ *   contents to be written to disk.
+ *
+ * * Pass the name of the temporary file to another program to allow
+ *   it (and nobody else) to inspect or even modify the file's
+ *   contents.
+ *
+ * * `reopen_tempfile()` to reopen the temporary file. Make further
+ *   updates to the contents.
+ *
+ * * `rename_tempfile()` to move the file to its permanent location.
+ */
+extern int reopen_tempfile(struct tempfile *tempfile);
+
+/*
+ * Close the file descriptor and/or file pointer and remove the
+ * temporary file associated with `tempfile`. It is a NOOP to call
+ * `delete_tempfile()` for a `tempfile` object that has already been
+ * deleted or renamed.
+ */
+extern void delete_tempfile(struct tempfile *tempfile);
+
+/*
+ * Close the file descriptor and/or file pointer if they are still
+ * open, and atomically rename the temporary file to `path`. `path`
+ * must be on the same filesystem as the lock file. Return 0 on
+ * success. On failure, delete the temporary file and return -1, with
+ * `errno` set to the value from the failing call to `close(2)` or
+ * `rename(2)`. It is a bug to call `rename_tempfile()` for a
+ * `tempfile` object that is not currently active.
+ */
+extern int rename_tempfile(struct tempfile *tempfile, const char *path);
+
+#endif /* TEMPFILE_H */
-- 
2.5.0
