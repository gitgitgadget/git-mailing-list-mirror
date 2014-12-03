From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/14] hold_lock_file_for_update: pass error message back
 through a strbuf
Date: Tue, 2 Dec 2014 21:26:03 -0800
Message-ID: <20141203052602.GV6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 06:26:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw2S7-0001cW-P9
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 06:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbaLCF0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 00:26:10 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:43216 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbaLCF0G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 00:26:06 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so12182835igi.12
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 21:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qbZDlC8FXrzXmE10qwev481YszxEDMHWku3dcsvoJgI=;
        b=ary0S67o0ovBYodA1DEhycG4SXu7UplFNdLPgIYHNNeIjzCwJL+2wJQ+YTZ0ishcFC
         KtNff7N03DoaEkSJ+GoUdUCVF4JO29lIHlTBrtiUDQ6h+IlAFBVh7ui3JnbKUoiPB2Ss
         p6An4Dp6zXDBKHnG71DHV9zovt6sRpVN1+iMo2xIMc335OvDMXSWRMBZUWLlrar1v+Bv
         jRjoA/Z4wFBycSoG/BLB9u05b0gelYANcSSNlCo2u8p+JFllfDsu+TzXKBMS3EBx7A0O
         408fo3cLDoLD/UDYx9A38+iuauomBJc2RgWp0kNM+EcjVJSNjet1ORJv9PpBIocKESlI
         eKbA==
X-Received: by 10.107.162.134 with SMTP id l128mr2941557ioe.65.1417584365784;
        Tue, 02 Dec 2014 21:26:05 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id vf6sm13024577igb.6.2014.12.02.21.26.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 21:26:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203050217.GJ6527@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260636>

This makes it more obvious when callers forget to print a message on
error, while still giving callers a chance to clean up before exiting.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/technical/api-lockfile.txt | 33 +++++++-------------------------
 builtin/apply.c                          |  5 ++++-
 builtin/commit.c                         |  9 +++++----
 builtin/gc.c                             |  8 ++++++--
 bundle.c                                 | 10 +++++++---
 config.c                                 | 18 ++++++-----------
 credential-store.c                       |  8 ++++++--
 fast-import.c                            |  8 +++-----
 lockfile.c                               | 26 ++++++++++---------------
 lockfile.h                               |  8 ++++----
 read-cache.c                             |  9 +--------
 refs.c                                   | 17 +++++++++-------
 rerere.c                                 |  7 +++++--
 sequencer.c                              | 19 ++++++++++++++----
 shallow.c                                | 16 ++++++++++++----
 15 files changed, 101 insertions(+), 100 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index fa60cfd..8cb6704 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -87,21 +87,8 @@ Error handling
 --------------
 
 The `hold_lock_file_*` functions return a file descriptor on success
-or -1 on failure (unless `LOCK_DIE_ON_ERROR` is used; see below). On
-errors, `errno` describes the reason for failure. Errors can be
-reported by passing `errno` to one of the following helper functions:
-
-unable_to_lock_message::
-
-	Append an appropriate error message to a `strbuf`.
-
-unable_to_lock_error::
-
-	Emit an appropriate error message using `error()`.
-
-unable_to_lock_die::
-
-	Emit an appropriate error message and `die()`.
+or -1 on failure.  On errors, a message describing the reason for
+failure is appended to the strbuf specified using the 'err' argument.
 
 Similarly, `commit_lock_file`, `commit_lock_file_to`, and
 `close_lock_file` return 0 on success. On failure they set `errno`
@@ -111,7 +98,7 @@ appropriately, do their best to roll back the lockfile, and return -1.
 Flags
 -----
 
-The following flags can be passed to `hold_lock_file_for_update` or
+The following flag can be passed to `hold_lock_file_for_update` or
 `hold_lock_file_for_append`:
 
 LOCK_NO_DEREF::
@@ -136,22 +123,16 @@ LOCK_OUTSIDE_REPOSITORY:
 For example, this flag should be set when locking a configuration
 file in the user's home directory.
 
-LOCK_DIE_ON_ERROR::
-
-	If a lock is already taken for the file, `die()` with an error
-	message. If this option is not specified, trying to lock a
-	file that is already locked returns -1 to the caller.
-
-
 The functions
 -------------
 
 hold_lock_file_for_update::
 
 	Take a pointer to `struct lock_file`, the path of the file to
-	be locked (e.g. `$GIT_DIR/index`) and a flags argument (see
-	above). Attempt to create a lockfile for the destination and
-	return the file descriptor for writing to the file.
+	be locked (e.g. `$GIT_DIR/index`), a flags argument (see
+	above), and a strbuf for error messages. Attempt to create a
+	lockfile for the destination and return the file descriptor for
+	writing to the file.
 
 hold_lock_file_for_append::
 
diff --git a/builtin/apply.c b/builtin/apply.c
index cda438f..07626fb 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3711,6 +3711,7 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 	struct patch *patch;
 	struct index_state result = { NULL };
 	static struct lock_file lock;
+	struct strbuf err = STRBUF_INIT;
 
 	/* Once we start supporting the reverse patch, it may be
 	 * worth showing the new sha1 prefix, but until then...
@@ -3748,11 +3749,13 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 			die ("Could not add %s to temporary index", name);
 	}
 
-	hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
+	if (hold_lock_file_for_update(&lock, filename, 0, &err) < 0)
+		die("%s", err.buf);
 	if (write_locked_index(&result, &lock, COMMIT_LOCK))
 		die ("Could not write temporary index to %s", filename);
 
 	discard_index(&result);
+	strbuf_release(&err);
 }
 
 static void stat_patch_list(struct patch *patch)
diff --git a/builtin/commit.c b/builtin/commit.c
index edc4493..f64024c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -468,10 +468,11 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
 		die(_("unable to write new_index file"));
 
-	hold_lock_file_for_update(&false_lock,
-				  git_path("next-index-%"PRIuMAX,
-					   (uintmax_t) getpid()),
-				  LOCK_DIE_ON_ERROR);
+	if (hold_lock_file_for_update(&false_lock,
+				      git_path("next-index-%"PRIuMAX,
+					       (uintmax_t) getpid()), 0,
+				      &err) < 0)
+		die("%s", err.buf);
 
 	create_base_index(current_head);
 	add_remove_files(&partial);
diff --git a/builtin/gc.c b/builtin/gc.c
index 005adbe..86e9eca 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -190,6 +190,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	static struct lock_file lock;
 	char my_host[128];
 	struct strbuf sb = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	struct stat st;
 	uintmax_t pid;
 	FILE *fp;
@@ -202,8 +203,9 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	if (gethostname(my_host, sizeof(my_host)))
 		strcpy(my_host, "unknown");
 
-	fd = hold_lock_file_for_update(&lock, git_path("gc.pid"),
-				       LOCK_DIE_ON_ERROR);
+	fd = hold_lock_file_for_update(&lock, git_path("gc.pid"), 0, &err);
+	if (fd < 0)
+		die("%s", err.buf);
 	if (!force) {
 		static char locking_host[128];
 		int should_exit;
@@ -231,6 +233,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 			if (fd >= 0)
 				rollback_lock_file(&lock);
 			*ret_pid = pid;
+			strbuf_release(&err);
 			return locking_host;
 		}
 	}
@@ -245,6 +248,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	sigchain_push_common(remove_pidfile_on_signal);
 	atexit(remove_pidfile);
 
+	strbuf_release(&err);
 	return NULL;
 }
 
diff --git a/bundle.c b/bundle.c
index 2e2dbd5..db03782 100644
--- a/bundle.c
+++ b/bundle.c
@@ -417,9 +417,13 @@ int create_bundle(struct bundle_header *header, const char *path,
 	bundle_to_stdout = !strcmp(path, "-");
 	if (bundle_to_stdout)
 		bundle_fd = 1;
-	else
-		bundle_fd = hold_lock_file_for_update(&lock, path,
-						      LOCK_DIE_ON_ERROR);
+	else {
+		struct strbuf err = STRBUF_INIT;
+		bundle_fd = hold_lock_file_for_update(&lock, path, 0, &err);
+		if (bundle_fd < 0)
+			die("%s", err.buf);
+		strbuf_release(&err);
+	}
 
 	/* write signature */
 	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
diff --git a/config.c b/config.c
index dacde5f..4117ff0 100644
--- a/config.c
+++ b/config.c
@@ -1923,6 +1923,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
 	int fd = -1, in_fd;
 	int ret;
 	struct lock_file *lock = NULL;
+	struct strbuf err = STRBUF_INIT;
 	char *filename_buf = NULL;
 
 	/* parse-key returns negative; flip the sign to feed exit(3) */
@@ -1941,14 +1942,9 @@ int git_config_set_multivar_in_file(const char *config_filename,
 	 */
 	lock = xcalloc(1, sizeof(struct lock_file));
 	fd = hold_lock_file_for_update(lock, config_filename,
-				       LOCK_OUTSIDE_REPOSITORY);
+				       LOCK_OUTSIDE_REPOSITORY, &err);
 	if (fd < 0) {
-		struct strbuf err = STRBUF_INIT;
-
-		unable_to_lock_message(config_filename,
-				       LOCK_OUTSIDE_REPOSITORY, errno, &err);
 		error("%s", err.buf);
-		strbuf_release(&err);
 		free(store.key);
 		ret = CONFIG_NO_LOCK;
 		goto out_free;
@@ -2126,6 +2122,7 @@ out_free:
 	if (lock)
 		rollback_lock_file(lock);
 	free(filename_buf);
+	strbuf_release(&err);
 	return ret;
 
 write_err_out:
@@ -2203,6 +2200,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 	int ret = 0, remove = 0;
 	char *filename_buf = NULL;
 	struct lock_file *lock;
+	struct strbuf err = STRBUF_INIT;
 	int out_fd;
 	char buf[1024];
 	FILE *config_file;
@@ -2218,14 +2216,9 @@ int git_config_rename_section_in_file(const char *config_filename,
 
 	lock = xcalloc(1, sizeof(struct lock_file));
 	out_fd = hold_lock_file_for_update(lock, config_filename,
-					   LOCK_OUTSIDE_REPOSITORY);
+					   LOCK_OUTSIDE_REPOSITORY, &err);
 	if (out_fd < 0) {
-		struct strbuf err = STRBUF_INIT;
-
-		unable_to_lock_message(config_filename,
-				       LOCK_OUTSIDE_REPOSITORY, errno, &err);
 		ret = error("%s", err.buf);
-		strbuf_release(&err);
 		goto out;
 	}
 
@@ -2295,6 +2288,7 @@ unlock_and_out:
 		ret = error("could not commit config file %s", config_filename);
 out:
 	free(filename_buf);
+	strbuf_release(&err);
 	return ret;
 }
 
diff --git a/credential-store.c b/credential-store.c
index cd71156..beffa87 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -55,13 +55,17 @@ static void print_line(struct strbuf *buf)
 static void rewrite_credential_file(const char *fn, struct credential *c,
 				    struct strbuf *extra)
 {
-	hold_lock_file_for_update(&credential_lock, fn,
-				  LOCK_DIE_ON_ERROR | LOCK_OUTSIDE_REPOSITORY);
+	struct strbuf err = STRBUF_INIT;
+
+	if (hold_lock_file_for_update(&credential_lock, fn,
+				      LOCK_OUTSIDE_REPOSITORY, &err) < 0);
+		die("%s", err.buf);
 	if (extra)
 		print_line(extra);
 	parse_credential_file(fn, c, NULL, print_line);
 	if (commit_lock_file(&credential_lock) < 0)
 		die_errno("unable to commit credential store");
+	strbuf_release(&err);
 }
 
 static void store_credential(const char *fn, struct credential *c)
diff --git a/fast-import.c b/fast-import.c
index bf8faa9..736c37b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1794,21 +1794,19 @@ static void dump_marks_helper(FILE *f,
 static void dump_marks(void)
 {
 	static struct lock_file mark_lock;
+	struct strbuf err = STRBUF_INIT;
 	FILE *f;
 
 	if (!export_marks_file)
 		return;
 
 	if (hold_lock_file_for_update(&mark_lock, export_marks_file,
-				      LOCK_OUTSIDE_REPOSITORY) < 0) {
-		struct strbuf err = STRBUF_INIT;
-
-		unable_to_lock_message(export_marks_file,
-				       LOCK_OUTSIDE_REPOSITORY, errno, &err);
+				      LOCK_OUTSIDE_REPOSITORY, &err) < 0) {
 		failure |= error("%s", err.buf);
 		strbuf_release(&err);
 		return;
 	}
+	strbuf_release(&err);
 
 	f = fdopen_lock_file(&mark_lock, "w");
 	if (!f) {
diff --git a/lockfile.c b/lockfile.c
index 102584f..a79679b 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -98,8 +98,8 @@ static void resolve_symlink(struct strbuf *path)
 	strbuf_reset(&link);
 }
 
-/* Make sure errno contains a meaningful value on error */
-static int lock_file(struct lock_file *lk, const char *path, int flags)
+static int lock_file(struct lock_file *lk, const char *path,
+		     int flags, struct strbuf *err)
 {
 	size_t pathlen = strlen(path);
 
@@ -134,16 +134,16 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	strbuf_addstr(&lk->filename, LOCK_SUFFIX);
 	lk->fd = open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (lk->fd < 0) {
+		unable_to_lock_message(path, flags, errno, err);
 		strbuf_reset(&lk->filename);
 		return -1;
 	}
 	lk->owner = getpid();
 	lk->active = 1;
 	if (adjust_shared_perm(lk->filename.buf)) {
-		int save_errno = errno;
-		error("cannot fix permission bits on %s", lk->filename.buf);
+		strbuf_addf(err, "cannot fix permission bits on %s",
+			    lk->filename.buf);
 		rollback_lock_file(lk);
-		errno = save_errno;
 		return -1;
 	}
 	return lk->fd;
@@ -178,13 +178,10 @@ NORETURN void unable_to_lock_die(const char *path, int flags, int err)
 	die("%s", buf.buf);
 }
 
-/* This should return a meaningful errno on failure */
-int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
+int hold_lock_file_for_update(struct lock_file *lk, const char *path,
+			      int flags, struct strbuf *err)
 {
-	int fd = lock_file(lk, path, flags);
-	if (fd < 0 && (flags & LOCK_DIE_ON_ERROR))
-		unable_to_lock_die(path, flags, errno);
-	return fd;
+	return lock_file(lk, path, flags, err);
 }
 
 int hold_lock_file_for_append(struct lock_file *lk, const char *path,
@@ -192,14 +189,11 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path,
 {
 	int fd, orig_fd;
 
-	assert(!(flags & LOCK_DIE_ON_ERROR));
 	assert(err && !err->len);
 
-	fd = lock_file(lk, path, flags);
-	if (fd < 0) {
-		unable_to_lock_message(path, flags, errno, err);
+	fd = lock_file(lk, path, flags, err);
+	if (fd < 0)
 		return fd;
-	}
 
 	orig_fd = open(path, O_RDONLY);
 	if (orig_fd < 0) {
diff --git a/lockfile.h b/lockfile.h
index 779a992..6d0a9bb 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -68,14 +68,14 @@ struct lock_file {
 #define LOCK_SUFFIX ".lock"
 #define LOCK_SUFFIX_LEN 5
 
-#define LOCK_DIE_ON_ERROR 1
-#define LOCK_NO_DEREF 2
-#define LOCK_OUTSIDE_REPOSITORY 4
+#define LOCK_NO_DEREF 1
+#define LOCK_OUTSIDE_REPOSITORY 2
 
 extern void unable_to_lock_message(const char *path, int, int err,
 				   struct strbuf *buf);
 extern NORETURN void unable_to_lock_die(const char *path, int, int err);
-extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
+extern int hold_lock_file_for_update(struct lock_file *, const char *path,
+				     int, struct strbuf *err);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path,
 				     int, struct strbuf *err);
 extern FILE *fdopen_lock_file(struct lock_file *, const char *mode);
diff --git a/read-cache.c b/read-cache.c
index 2ce1a76..229eea0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1370,14 +1370,7 @@ static int read_index_extension(struct index_state *istate,
 
 int hold_locked_index(struct lock_file *lk, struct strbuf *err)
 {
-	const char *path;
-	int fd;
-
-	path = get_index_file();
-	fd = hold_lock_file_for_update(lk, path, 0);
-	if (fd < 0)
-		unable_to_lock_message(path, 0, errno, err);
-	return fd;
+	return hold_lock_file_for_update(lk, get_index_file(), 0, err);
 }
 
 int read_index(struct index_state *istate)
diff --git a/refs.c b/refs.c
index 39e43cf..f39c29c 100644
--- a/refs.c
+++ b/refs.c
@@ -2229,6 +2229,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const struct string_list *skip,
 					    int flags, int *type_p)
 {
+	struct strbuf err = STRBUF_INIT;
 	char *ref_file;
 	const char *orig_refname = refname;
 	struct ref_lock *lock;
@@ -2316,22 +2317,25 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		goto error_return;
 	}
 
-	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags);
+	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags, &err);
 	if (lock->lock_fd < 0) {
-		if (errno == ENOENT && --attempts_remaining > 0)
+		if (errno == ENOENT && --attempts_remaining > 0) {
 			/*
 			 * Maybe somebody just deleted one of the
 			 * directories leading to ref_file.  Try
 			 * again:
 			 */
+			strbuf_reset(&err);
 			goto retry;
-		else
-			unable_to_lock_die(ref_file, lflags, errno);
+		}
+		die("%s", err.buf);
 	}
+	strbuf_release(&err);
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 
  error_return:
 	unlock_ref(lock);
+	strbuf_release(&err);
 	errno = last_errno;
 	return NULL;
 }
@@ -2375,10 +2379,9 @@ int lock_packed_refs(struct strbuf *err)
 {
 	struct packed_ref_cache *packed_ref_cache;
 
-	if (hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0) < 0) {
-		unable_to_lock_message(git_path("packed-refs"), 0, errno, err);
+	if (hold_lock_file_for_update(&packlock,
+				      git_path("packed-refs"), 0, err) < 0)
 		return -1;
-	}
 
 	/*
 	 * Get the current packed-refs while holding the lock.  If the
diff --git a/rerere.c b/rerere.c
index 044e279..c1eaadd 100644
--- a/rerere.c
+++ b/rerere.c
@@ -600,6 +600,7 @@ static int is_rerere_enabled(void)
 
 int setup_rerere(struct string_list *merge_rr, int flags)
 {
+	struct strbuf err = STRBUF_INIT;
 	int fd;
 
 	git_rerere_config();
@@ -609,9 +610,11 @@ int setup_rerere(struct string_list *merge_rr, int flags)
 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
 		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
 	merge_rr_path = git_pathdup("MERGE_RR");
-	fd = hold_lock_file_for_update(&write_lock, merge_rr_path,
-				       LOCK_DIE_ON_ERROR);
+	fd = hold_lock_file_for_update(&write_lock, merge_rr_path, 0, &err);
+	if (fd < 0)
+		die("%s", err.buf);
 	read_rr(merge_rr);
+	strbuf_release(&err);
 	return fd;
 }
 
diff --git a/sequencer.c b/sequencer.c
index 3b3a869..c0d8864 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -204,14 +204,17 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 static void write_message(struct strbuf *msgbuf, const char *filename)
 {
 	static struct lock_file msg_file;
+	struct strbuf err = STRBUF_INIT;
 
-	int msg_fd = hold_lock_file_for_update(&msg_file, filename,
-					       LOCK_DIE_ON_ERROR);
+	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0, &err);
+	if (msg_fd < 0)
+		die("%s", err.buf);
 	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
 		die_errno(_("Could not write to %s"), filename);
 	strbuf_release(msgbuf);
 	if (commit_lock_file(&msg_file) < 0)
 		die(_("Error wrapping up %s"), filename);
+	strbuf_release(&err);
 }
 
 static struct tree *empty_tree(void)
@@ -854,14 +857,18 @@ static void save_head(const char *head)
 	const char *head_file = git_path(SEQ_HEAD_FILE);
 	static struct lock_file head_lock;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	int fd;
 
-	fd = hold_lock_file_for_update(&head_lock, head_file, LOCK_DIE_ON_ERROR);
+	fd = hold_lock_file_for_update(&head_lock, head_file, 0, &err);
+	if (fd < 0)
+		die("%s", err.buf);
 	strbuf_addf(&buf, "%s\n", head);
 	if (write_in_full(fd, buf.buf, buf.len) < 0)
 		die_errno(_("Could not write to %s"), head_file);
 	if (commit_lock_file(&head_lock) < 0)
 		die(_("Error wrapping up %s."), head_file);
+	strbuf_release(&err);
 }
 
 static int reset_for_rollback(const unsigned char *sha1)
@@ -935,9 +942,12 @@ static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 	const char *todo_file = git_path(SEQ_TODO_FILE);
 	static struct lock_file todo_lock;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	int fd;
 
-	fd = hold_lock_file_for_update(&todo_lock, todo_file, LOCK_DIE_ON_ERROR);
+	fd = hold_lock_file_for_update(&todo_lock, todo_file, 0, &err);
+	if (fd < 0)
+		die("%s", err.buf);
 	if (format_todo(&buf, todo_list, opts) < 0)
 		die(_("Could not format %s."), todo_file);
 	if (write_in_full(fd, buf.buf, buf.len) < 0) {
@@ -949,6 +959,7 @@ static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 		die(_("Error wrapping up %s."), todo_file);
 	}
 	strbuf_release(&buf);
+	strbuf_release(&err);
 }
 
 static void save_opts(struct replay_opts *opts)
diff --git a/shallow.c b/shallow.c
index cdd0775..4a30a77 100644
--- a/shallow.c
+++ b/shallow.c
@@ -259,10 +259,13 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
 			     const struct sha1_array *extra)
 {
 	struct strbuf sb = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	int fd;
 
-	fd = hold_lock_file_for_update(shallow_lock, git_path("shallow"),
-				       LOCK_DIE_ON_ERROR);
+	fd = hold_lock_file_for_update(shallow_lock,
+				       git_path("shallow"), 0, &err);
+	if (fd < 0)
+		die("%s", err.buf);
 	check_shallow_file_for_update();
 	if (write_shallow_commits(&sb, 0, extra)) {
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
@@ -276,6 +279,7 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
 		 */
 		*alternate_shallow_file = "";
 	strbuf_release(&sb);
+	strbuf_release(&err);
 }
 
 static int advertise_shallow_grafts_cb(const struct commit_graft *graft, void *cb)
@@ -301,6 +305,7 @@ void prune_shallow(int show_only)
 {
 	static struct lock_file shallow_lock;
 	struct strbuf sb = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	int fd;
 
 	if (show_only) {
@@ -308,8 +313,10 @@ void prune_shallow(int show_only)
 		strbuf_release(&sb);
 		return;
 	}
-	fd = hold_lock_file_for_update(&shallow_lock, git_path("shallow"),
-				       LOCK_DIE_ON_ERROR);
+	fd = hold_lock_file_for_update(&shallow_lock,
+				       git_path("shallow"), 0, &err);
+	if (fd < 0)
+		die("%s", err.buf);
 	check_shallow_file_for_update();
 	if (write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY)) {
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
@@ -321,6 +328,7 @@ void prune_shallow(int show_only)
 		rollback_lock_file(&shallow_lock);
 	}
 	strbuf_release(&sb);
+	strbuf_release(&err);
 }
 
 struct trace_key trace_shallow = TRACE_KEY_INIT(SHALLOW);
