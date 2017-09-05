Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E66E2208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 12:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbdIEMPO (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 08:15:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:57212 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751526AbdIEMPK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 08:15:10 -0400
Received: (qmail 31404 invoked by uid 109); 5 Sep 2017 12:15:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 12:15:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12402 invoked by uid 111); 5 Sep 2017 12:15:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:15:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 08:15:08 -0400
Date:   Tue, 5 Sep 2017 08:15:08 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 17/20] tempfile: auto-allocate tempfiles on heap
Message-ID: <20170905121508.filu4vnf7jrgnj2l@sigill.intra.peff.net>
References: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit taught the tempfile code to give up
ownership over tempfiles that have been renamed or deleted.
That makes it possible to use a stack variable like this:

  struct tempfile t;

  create_tempfile(&t, ...);
  ...
  if (!err)
          rename_tempfile(&t, ...);
  else
          delete_tempfile(&t);

But doing it this way has a high potential for creating
memory errors. The tempfile we pass to create_tempfile()
ends up on a global linked list, and it's not safe for it to
go out of scope until we've called one of those two
deactivation functions.

Imagine that we add an early return from the function that
forgets to call delete_tempfile(). With a static or heap
tempfile variable, the worst case is that the tempfile hangs
around until the program exits (and some functions like
setup_shallow_temporary rely on this intentionally, creating
a tempfile and then leaving it for later cleanup).

But with a stack variable as above, this is a serious memory
error: the variable goes out of scope and may be filled with
garbage by the time the tempfile code looks at it.  Let's
see if we can make it harder to get this wrong.

Since many callers need to allocate arbitrary numbers of
tempfiles, we can't rely on static storage as a general
solution. So we need to turn to the heap. We could just ask
all callers to pass us a heap variable, but that puts the
burden on them to call free() at the right time.

Instead, let's have the tempfile code handle the heap
allocation _and_ the deallocation (when the tempfile is
deactivated and removed from the list).

This changes the return value of all of the creation
functions. For the cleanup functions (delete and rename),
we'll add one extra bit of safety: instead of taking a
tempfile pointer, we'll take a pointer-to-pointer and set it
to NULL after freeing the object. This makes it safe to
double-call functions like delete_tempfile(), as the second
call treats the NULL input as a noop. Several callsites
follow this pattern.

The resulting patch does have a fair bit of noise, as each
caller needs to be converted to handle:

  1. Storing a pointer instead of the struct itself.

  2. Passing the pointer instead of taking the struct
     address.

  3. Handling a "struct tempfile *" return instead of a file
     descriptor.

We could play games to make this less noisy. For example, by
defining the tempfile like this:

  struct tempfile {
	struct heap_allocated_part_of_tempfile {
                int fd;
                ...etc
        } *actual_data;
  }

Callers would continue to have a "struct tempfile", and it
would be "active" only when the inner pointer was non-NULL.
But that just makes things more awkward in the long run.
There aren't that many callers, so we can simply bite
the bullet and adjust all of them. And the compiler makes it
easy for us to find them all.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/gc.c               |  8 ++---
 credential-cache--daemon.c |  5 ++-
 diff.c                     | 15 ++++----
 gpg-interface.c            | 16 ++++-----
 lockfile.c                 |  7 ++--
 lockfile.h                 | 16 ++++-----
 read-cache.c               | 25 +++++++-------
 refs/files-backend.c       |  4 +--
 refs/packed-backend.c      | 11 +++---
 shallow.c                  | 13 ++++---
 tempfile.c                 | 66 +++++++++++++++++++----------------
 tempfile.h                 | 85 +++++++++++++++++++++-------------------------
 trailer.c                  |  6 ++--
 13 files changed, 136 insertions(+), 141 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 3c78fcb9b1..c22787ac72 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -47,7 +47,7 @@ static struct argv_array prune = ARGV_ARRAY_INIT;
 static struct argv_array prune_worktrees = ARGV_ARRAY_INIT;
 static struct argv_array rerere = ARGV_ARRAY_INIT;
 
-static struct tempfile pidfile;
+static struct tempfile *pidfile;
 static struct lock_file log_lock;
 
 static struct string_list pack_garbage = STRING_LIST_INIT_DUP;
@@ -78,7 +78,7 @@ static void process_log_file(void)
 		 */
 		int saved_errno = errno;
 		fprintf(stderr, _("Failed to fstat %s: %s"),
-			get_tempfile_path(&log_lock.tempfile),
+			get_tempfile_path(log_lock.tempfile),
 			strerror(saved_errno));
 		fflush(stderr);
 		commit_lock_file(&log_lock);
@@ -242,7 +242,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	int fd;
 	char *pidfile_path;
 
-	if (is_tempfile_active(&pidfile))
+	if (is_tempfile_active(pidfile))
 		/* already locked */
 		return NULL;
 
@@ -293,7 +293,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	write_in_full(fd, sb.buf, sb.len);
 	strbuf_release(&sb);
 	commit_lock_file(&lock);
-	register_tempfile(&pidfile, pidfile_path);
+	pidfile = register_tempfile(pidfile_path);
 	free(pidfile_path);
 	return NULL;
 }
diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 0d5c625094..4dfbc8c9f9 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -5,8 +5,6 @@
 #include "unix-socket.h"
 #include "parse-options.h"
 
-static struct tempfile socket_file;
-
 struct credential_cache_entry {
 	struct credential item;
 	timestamp_t expiration;
@@ -260,6 +258,7 @@ static void init_socket_directory(const char *path)
 
 int cmd_main(int argc, const char **argv)
 {
+	struct tempfile *socket_file;
 	const char *socket_path;
 	int ignore_sighup = 0;
 	static const char *usage[] = {
@@ -285,7 +284,7 @@ int cmd_main(int argc, const char **argv)
 		die("socket directory must be an absolute path");
 
 	init_socket_directory(socket_path);
-	register_tempfile(&socket_file, socket_path);
+	socket_file = register_tempfile(socket_path);
 
 	if (ignore_sighup)
 		signal(SIGHUP, SIG_IGN);
diff --git a/diff.c b/diff.c
index 20f68ec389..7df2227a3c 100644
--- a/diff.c
+++ b/diff.c
@@ -459,7 +459,7 @@ static struct diff_tempfile {
 	 * If this diff_tempfile instance refers to a temporary file,
 	 * this tempfile object is used to manage its lifetime.
 	 */
-	struct tempfile tempfile;
+	struct tempfile *tempfile;
 } diff_temp[2];
 
 struct emit_callback {
@@ -1414,7 +1414,7 @@ static void remove_tempfile(void)
 {
 	int i;
 	for (i = 0; i < ARRAY_SIZE(diff_temp); i++) {
-		if (is_tempfile_active(&diff_temp[i].tempfile))
+		if (is_tempfile_active(diff_temp[i].tempfile))
 			delete_tempfile(&diff_temp[i].tempfile);
 		diff_temp[i].name = NULL;
 	}
@@ -3720,7 +3720,6 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 			   const struct object_id *oid,
 			   int mode)
 {
-	int fd;
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf template = STRBUF_INIT;
 	char *path_dup = xstrdup(path);
@@ -3730,18 +3729,18 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 	strbuf_addstr(&template, "XXXXXX_");
 	strbuf_addstr(&template, base);
 
-	fd = mks_tempfile_ts(&temp->tempfile, template.buf, strlen(base) + 1);
-	if (fd < 0)
+	temp->tempfile = mks_tempfile_ts(template.buf, strlen(base) + 1);
+	if (!temp->tempfile)
 		die_errno("unable to create temp-file");
 	if (convert_to_working_tree(path,
 			(const char *)blob, (size_t)size, &buf)) {
 		blob = buf.buf;
 		size = buf.len;
 	}
-	if (write_in_full(fd, blob, size) != size ||
-	    close_tempfile_gently(&temp->tempfile))
+	if (write_in_full(temp->tempfile->fd, blob, size) != size ||
+	    close_tempfile_gently(temp->tempfile))
 		die_errno("unable to write temp-file");
-	temp->name = get_tempfile_path(&temp->tempfile);
+	temp->name = get_tempfile_path(temp->tempfile);
 	oid_to_hex_r(temp->hex, oid);
 	xsnprintf(temp->mode, sizeof(temp->mode), "%06o", mode);
 	strbuf_release(&buf);
diff --git a/gpg-interface.c b/gpg-interface.c
index 4ea2597ff4..4feacf16e5 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -202,17 +202,17 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 			 struct strbuf *gpg_output, struct strbuf *gpg_status)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
-	static struct tempfile temp;
-	int fd, ret;
+	struct tempfile *temp;
+	int ret;
 	struct strbuf buf = STRBUF_INIT;
 
-	fd = mks_tempfile_t(&temp, ".git_vtag_tmpXXXXXX");
-	if (fd < 0)
+	temp = mks_tempfile_t(".git_vtag_tmpXXXXXX");
+	if (!temp)
 		return error_errno(_("could not create temporary file"));
-	if (write_in_full(fd, signature, signature_size) < 0 ||
-	    close_tempfile_gently(&temp) < 0) {
+	if (write_in_full(temp->fd, signature, signature_size) < 0 ||
+	    close_tempfile_gently(temp) < 0) {
 		error_errno(_("failed writing detached signature to '%s'"),
-			    temp.filename.buf);
+			    temp->filename.buf);
 		delete_tempfile(&temp);
 		return -1;
 	}
@@ -221,7 +221,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 			 gpg_program,
 			 "--status-fd=1",
 			 "--keyid-format=long",
-			 "--verify", temp.filename.buf, "-",
+			 "--verify", temp->filename.buf, "-",
 			 NULL);
 
 	if (!gpg_status)
diff --git a/lockfile.c b/lockfile.c
index aa69210d8b..efcb7d7dfe 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -72,7 +72,6 @@ static void resolve_symlink(struct strbuf *path)
 /* Make sure errno contains a meaningful value on error */
 static int lock_file(struct lock_file *lk, const char *path, int flags)
 {
-	int fd;
 	struct strbuf filename = STRBUF_INIT;
 
 	strbuf_addstr(&filename, path);
@@ -80,9 +79,9 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		resolve_symlink(&filename);
 
 	strbuf_addstr(&filename, LOCK_SUFFIX);
-	fd = create_tempfile(&lk->tempfile, filename.buf);
+	lk->tempfile = create_tempfile(filename.buf);
 	strbuf_release(&filename);
-	return fd;
+	return lk->tempfile ? lk->tempfile->fd : -1;
 }
 
 /*
@@ -191,7 +190,7 @@ char *get_locked_file_path(struct lock_file *lk)
 {
 	struct strbuf ret = STRBUF_INIT;
 
-	strbuf_addstr(&ret, get_tempfile_path(&lk->tempfile));
+	strbuf_addstr(&ret, get_tempfile_path(lk->tempfile));
 	if (ret.len <= LOCK_SUFFIX_LEN ||
 	    strcmp(ret.buf + ret.len - LOCK_SUFFIX_LEN, LOCK_SUFFIX))
 		die("BUG: get_locked_file_path() called for malformed lock object");
diff --git a/lockfile.h b/lockfile.h
index c45d2db324..6ed336e2bc 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -111,7 +111,7 @@
 #include "tempfile.h"
 
 struct lock_file {
-	struct tempfile tempfile;
+	struct tempfile *tempfile;
 };
 
 /* String appended to a filename to derive the lockfile name: */
@@ -180,7 +180,7 @@ static inline int hold_lock_file_for_update(
  */
 static inline int is_lock_file_locked(struct lock_file *lk)
 {
-	return is_tempfile_active(&lk->tempfile);
+	return is_tempfile_active(lk->tempfile);
 }
 
 /*
@@ -208,7 +208,7 @@ extern NORETURN void unable_to_lock_die(const char *path, int err);
  */
 static inline FILE *fdopen_lock_file(struct lock_file *lk, const char *mode)
 {
-	return fdopen_tempfile(&lk->tempfile, mode);
+	return fdopen_tempfile(lk->tempfile, mode);
 }
 
 /*
@@ -217,17 +217,17 @@ static inline FILE *fdopen_lock_file(struct lock_file *lk, const char *mode)
  */
 static inline const char *get_lock_file_path(struct lock_file *lk)
 {
-	return get_tempfile_path(&lk->tempfile);
+	return get_tempfile_path(lk->tempfile);
 }
 
 static inline int get_lock_file_fd(struct lock_file *lk)
 {
-	return get_tempfile_fd(&lk->tempfile);
+	return get_tempfile_fd(lk->tempfile);
 }
 
 static inline FILE *get_lock_file_fp(struct lock_file *lk)
 {
-	return get_tempfile_fp(&lk->tempfile);
+	return get_tempfile_fp(lk->tempfile);
 }
 
 /*
@@ -246,7 +246,7 @@ extern char *get_locked_file_path(struct lock_file *lk);
  */
 static inline int close_lock_file_gently(struct lock_file *lk)
 {
-	return close_tempfile_gently(&lk->tempfile);
+	return close_tempfile_gently(lk->tempfile);
 }
 
 /*
@@ -270,7 +270,7 @@ static inline int close_lock_file_gently(struct lock_file *lk)
  */
 static inline int reopen_lock_file(struct lock_file *lk)
 {
-	return reopen_tempfile(&lk->tempfile);
+	return reopen_tempfile(lk->tempfile);
 }
 
 /*
diff --git a/read-cache.c b/read-cache.c
index c3be65f8b0..b211c57af6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2311,7 +2311,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		return -1;
 	if (close_tempfile_gently(tempfile)) {
 		error(_("could not close '%s'"), tempfile->filename.buf);
-		delete_tempfile(tempfile);
+		delete_tempfile(&tempfile);
 		return -1;
 	}
 	if (stat(tempfile->filename.buf, &st))
@@ -2337,7 +2337,7 @@ static int commit_locked_index(struct lock_file *lk)
 static int do_write_locked_index(struct index_state *istate, struct lock_file *lock,
 				 unsigned flags)
 {
-	int ret = do_write_index(istate, &lock->tempfile, 0);
+	int ret = do_write_index(istate, lock->tempfile, 0);
 	if (ret)
 		return ret;
 	assert((flags & (COMMIT_LOCK | CLOSE_LOCK)) !=
@@ -2420,34 +2420,33 @@ static int clean_shared_index_files(const char *current_hex)
 	return 0;
 }
 
-static struct tempfile temporary_sharedindex;
-
 static int write_shared_index(struct index_state *istate,
 			      struct lock_file *lock, unsigned flags)
 {
+	struct tempfile *temp;
 	struct split_index *si = istate->split_index;
-	int fd, ret;
+	int ret;
 
-	fd = mks_tempfile(&temporary_sharedindex, git_path("sharedindex_XXXXXX"));
-	if (fd < 0) {
+	temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
+	if (!temp) {
 		hashclr(si->base_sha1);
 		return do_write_locked_index(istate, lock, flags);
 	}
 	move_cache_to_base_index(istate);
-	ret = do_write_index(si->base, &temporary_sharedindex, 1);
+	ret = do_write_index(si->base, temp, 1);
 	if (ret) {
-		delete_tempfile(&temporary_sharedindex);
+		delete_tempfile(&temp);
 		return ret;
 	}
-	ret = adjust_shared_perm(get_tempfile_path(&temporary_sharedindex));
+	ret = adjust_shared_perm(get_tempfile_path(temp));
 	if (ret) {
 		int save_errno = errno;
-		error("cannot fix permission bits on %s", get_tempfile_path(&temporary_sharedindex));
-		delete_tempfile(&temporary_sharedindex);
+		error("cannot fix permission bits on %s", get_tempfile_path(temp));
+		delete_tempfile(&temp);
 		errno = save_errno;
 		return ret;
 	}
-	ret = rename_tempfile(&temporary_sharedindex,
+	ret = rename_tempfile(&temp,
 			      git_path("sharedindex.%s", sha1_to_hex(si->base->sha1)));
 	if (!ret) {
 		hashcpy(si->base_sha1, si->base->sha1);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index bc1899cd4a..36fe8a986b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1747,12 +1747,12 @@ static int create_symref_locked(struct files_ref_store *refs,
 
 	if (!fdopen_lock_file(lock->lk, "w"))
 		return error("unable to fdopen %s: %s",
-			     lock->lk->tempfile.filename.buf, strerror(errno));
+			     lock->lk->tempfile->filename.buf, strerror(errno));
 
 	update_symref_reflog(refs, lock, refname, target, logmsg);
 
 	/* no error check; commit_ref will check ferror */
-	fprintf(lock->lk->tempfile.fp, "ref: %s\n", target);
+	fprintf(lock->lk->tempfile->fp, "ref: %s\n", target);
 	if (commit_ref(lock) < 0)
 		return error("unable to write symref for %s: %s", refname,
 			     strerror(errno));
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index dca887c0fe..321608a114 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -75,7 +75,7 @@ struct packed_ref_store {
 	 * "packed-refs" file. Note that this (and thus the enclosing
 	 * `packed_ref_store`) must not be freed.
 	 */
-	struct tempfile tempfile;
+	struct tempfile *tempfile;
 };
 
 struct ref_store *packed_ref_store_create(const char *path,
@@ -628,7 +628,8 @@ int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
 	 */
 	packed_refs_path = get_locked_file_path(&refs->lock);
 	strbuf_addf(&sb, "%s.new", packed_refs_path);
-	if (create_tempfile(&refs->tempfile, sb.buf) < 0) {
+	refs->tempfile = create_tempfile(sb.buf);
+	if (!refs->tempfile) {
 		strbuf_addf(err, "unable to create file %s: %s",
 			    sb.buf, strerror(errno));
 		strbuf_release(&sb);
@@ -636,7 +637,7 @@ int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
 	}
 	strbuf_release(&sb);
 
-	out = fdopen_tempfile(&refs->tempfile, "w");
+	out = fdopen_tempfile(refs->tempfile, "w");
 	if (!out) {
 		strbuf_addf(err, "unable to fdopen packed-refs tempfile: %s",
 			    strerror(errno));
@@ -645,7 +646,7 @@ int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
 
 	if (fprintf(out, "%s", PACKED_REFS_HEADER) < 0) {
 		strbuf_addf(err, "error writing to %s: %s",
-			    get_tempfile_path(&refs->tempfile), strerror(errno));
+			    get_tempfile_path(refs->tempfile), strerror(errno));
 		goto error;
 	}
 
@@ -657,7 +658,7 @@ int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
 		if (write_packed_entry(out, iter->refname, iter->oid->hash,
 				       peel_error ? NULL : peeled.hash)) {
 			strbuf_addf(err, "error writing to %s: %s",
-				    get_tempfile_path(&refs->tempfile),
+				    get_tempfile_path(refs->tempfile),
 				    strerror(errno));
 			ref_iterator_abort(iter);
 			goto error;
diff --git a/shallow.c b/shallow.c
index 36216febb6..1cc1c76415 100644
--- a/shallow.c
+++ b/shallow.c
@@ -288,19 +288,18 @@ int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
 
 const char *setup_temporary_shallow(const struct oid_array *extra)
 {
-	static struct tempfile temp;
+	struct tempfile *temp;
 	struct strbuf sb = STRBUF_INIT;
-	int fd;
 
 	if (write_shallow_commits(&sb, 0, extra)) {
-		fd = xmks_tempfile(&temp, git_path("shallow_XXXXXX"));
+		temp = xmks_tempfile(git_path("shallow_XXXXXX"));
 
-		if (write_in_full(fd, sb.buf, sb.len) != sb.len ||
-		    close_tempfile_gently(&temp) < 0)
+		if (write_in_full(temp->fd, sb.buf, sb.len) != sb.len ||
+		    close_tempfile_gently(temp) < 0)
 			die_errno("failed to write to %s",
-				  get_tempfile_path(&temp));
+				  get_tempfile_path(temp));
 		strbuf_release(&sb);
-		return get_tempfile_path(&temp);
+		return get_tempfile_path(temp);
 	}
 	/*
 	 * is_repository_shallow() sees empty string as "no shallow
diff --git a/tempfile.c b/tempfile.c
index f82a5f3676..5fdafdd2d2 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -91,14 +91,16 @@ static void remove_tempfiles_on_signal(int signo)
 	raise(signo);
 }
 
-static void prepare_tempfile_object(struct tempfile *tempfile)
+static struct tempfile *new_tempfile(void)
 {
+	struct tempfile *tempfile = xmalloc(sizeof(*tempfile));
 	tempfile->fd = -1;
 	tempfile->fp = NULL;
 	tempfile->active = 0;
 	tempfile->owner = 0;
 	INIT_LIST_HEAD(&tempfile->list);
 	strbuf_init(&tempfile->filename, 0);
+	return tempfile;
 }
 
 static void activate_tempfile(struct tempfile *tempfile)
@@ -124,12 +126,13 @@ static void deactivate_tempfile(struct tempfile *tempfile)
 	tempfile->active = 0;
 	strbuf_release(&tempfile->filename);
 	volatile_list_del(&tempfile->list);
+	free(tempfile);
 }
 
 /* Make sure errno contains a meaningful value on error */
-int create_tempfile(struct tempfile *tempfile, const char *path)
+struct tempfile *create_tempfile(const char *path)
 {
-	prepare_tempfile_object(tempfile);
+	struct tempfile *tempfile = new_tempfile();
 
 	strbuf_add_absolute_path(&tempfile->filename, path);
 	tempfile->fd = open(tempfile->filename.buf,
@@ -140,48 +143,47 @@ int create_tempfile(struct tempfile *tempfile, const char *path)
 				    O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (tempfile->fd < 0) {
 		deactivate_tempfile(tempfile);
-		return -1;
+		return NULL;
 	}
 	activate_tempfile(tempfile);
 	if (adjust_shared_perm(tempfile->filename.buf)) {
 		int save_errno = errno;
 		error("cannot fix permission bits on %s", tempfile->filename.buf);
-		delete_tempfile(tempfile);
+		delete_tempfile(&tempfile);
 		errno = save_errno;
-		return -1;
+		return NULL;
 	}
-	return tempfile->fd;
+
+	return tempfile;
 }
 
-void register_tempfile(struct tempfile *tempfile, const char *path)
+struct tempfile *register_tempfile(const char *path)
 {
-	prepare_tempfile_object(tempfile);
+	struct tempfile *tempfile = new_tempfile();
 	strbuf_add_absolute_path(&tempfile->filename, path);
 	activate_tempfile(tempfile);
+	return tempfile;
 }
 
-int mks_tempfile_sm(struct tempfile *tempfile,
-		    const char *template, int suffixlen, int mode)
+struct tempfile *mks_tempfile_sm(const char *template, int suffixlen, int mode)
 {
-	prepare_tempfile_object(tempfile);
+	struct tempfile *tempfile = new_tempfile();
 
 	strbuf_add_absolute_path(&tempfile->filename, template);
 	tempfile->fd = git_mkstemps_mode(tempfile->filename.buf, suffixlen, mode);
 	if (tempfile->fd < 0) {
 		deactivate_tempfile(tempfile);
-		return -1;
+		return NULL;
 	}
 	activate_tempfile(tempfile);
-	return tempfile->fd;
+	return tempfile;
 }
 
-int mks_tempfile_tsm(struct tempfile *tempfile,
-		     const char *template, int suffixlen, int mode)
+struct tempfile *mks_tempfile_tsm(const char *template, int suffixlen, int mode)
 {
+	struct tempfile *tempfile = new_tempfile();
 	const char *tmpdir;
 
-	prepare_tempfile_object(tempfile);
-
 	tmpdir = getenv("TMPDIR");
 	if (!tmpdir)
 		tmpdir = "/tmp";
@@ -190,25 +192,25 @@ int mks_tempfile_tsm(struct tempfile *tempfile,
 	tempfile->fd = git_mkstemps_mode(tempfile->filename.buf, suffixlen, mode);
 	if (tempfile->fd < 0) {
 		deactivate_tempfile(tempfile);
-		return -1;
+		return NULL;
 	}
 	activate_tempfile(tempfile);
-	return tempfile->fd;
+	return tempfile;
 }
 
-int xmks_tempfile_m(struct tempfile *tempfile, const char *template, int mode)
+struct tempfile *xmks_tempfile_m(const char *template, int mode)
 {
-	int fd;
+	struct tempfile *tempfile;
 	struct strbuf full_template = STRBUF_INIT;
 
 	strbuf_add_absolute_path(&full_template, template);
-	fd = mks_tempfile_m(tempfile, full_template.buf, mode);
-	if (fd < 0)
+	tempfile = mks_tempfile_m(full_template.buf, mode);
+	if (!tempfile)
 		die_errno("Unable to create temporary file '%s'",
 			  full_template.buf);
 
 	strbuf_release(&full_template);
-	return fd;
+	return tempfile;
 }
 
 FILE *fdopen_tempfile(struct tempfile *tempfile, const char *mode)
@@ -281,33 +283,39 @@ int reopen_tempfile(struct tempfile *tempfile)
 	return tempfile->fd;
 }
 
-int rename_tempfile(struct tempfile *tempfile, const char *path)
+int rename_tempfile(struct tempfile **tempfile_p, const char *path)
 {
+	struct tempfile *tempfile = *tempfile_p;
+
 	if (!is_tempfile_active(tempfile))
 		BUG("rename_tempfile called for inactive object");
 
 	if (close_tempfile_gently(tempfile)) {
-		delete_tempfile(tempfile);
+		delete_tempfile(tempfile_p);
 		return -1;
 	}
 
 	if (rename(tempfile->filename.buf, path)) {
 		int save_errno = errno;
-		delete_tempfile(tempfile);
+		delete_tempfile(tempfile_p);
 		errno = save_errno;
 		return -1;
 	}
 
 	deactivate_tempfile(tempfile);
+	*tempfile_p = NULL;
 	return 0;
 }
 
-void delete_tempfile(struct tempfile *tempfile)
+void delete_tempfile(struct tempfile **tempfile_p)
 {
+	struct tempfile *tempfile = *tempfile_p;
+
 	if (!is_tempfile_active(tempfile))
 		return;
 
 	close_tempfile_gently(tempfile);
 	unlink_or_warn(tempfile->filename.buf);
 	deactivate_tempfile(tempfile);
+	*tempfile_p = NULL;
 }
diff --git a/tempfile.h b/tempfile.h
index e32b4df092..b8f4b5e145 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -17,22 +17,18 @@
  *
  * The caller:
  *
- * * Allocates a `struct tempfile`. Once the structure is passed to
- *   `create_tempfile()`, its storage must remain valid until
- *   `delete_tempfile()` or `rename_tempfile()` is called on it.
- *
  * * Attempts to create a temporary file by calling
- *   `create_tempfile()`.
+ *   `create_tempfile()`. The resources used for the temporary file are
+ *   managed by the tempfile API.
  *
  * * Writes new content to the file by either:
  *
- *   * writing to the file descriptor returned by `create_tempfile()`
- *     (also available via `tempfile->fd`).
+ *   * writing to the `tempfile->fd` file descriptor
  *
  *   * calling `fdopen_tempfile()` to get a `FILE` pointer for the
  *     open file and writing to the file using stdio.
  *
- *   Note that the file descriptor returned by create_tempfile()
+ *   Note that the file descriptor created by create_tempfile()
  *   is marked O_CLOEXEC, so the new contents must be written by
  *   the current process, not any spawned one.
  *
@@ -50,7 +46,7 @@
  *   `delete_tempfile()` or `rename_tempfile()`.
  *
  * After the temporary file is renamed or deleted, the `tempfile`
- * object may be reused or freed.
+ * object is no longer valid and should not be reused.
  *
  * If the program exits before `rename_tempfile()` or
  * `delete_tempfile()` is called, an `atexit(3)` handler will close
@@ -69,8 +65,8 @@
  * Error handling
  * --------------
  *
- * `create_tempfile()` returns a file descriptor on success or -1 on
- * failure. On errors, `errno` describes the reason for failure.
+ * `create_tempfile()` returns an allocated tempfile on success or NULL
+ * on failure. On errors, `errno` describes the reason for failure.
  *
  * `delete_tempfile()`, `rename_tempfile()`, and `close_tempfile_gently()`
  * return 0 on success. On failure they set `errno` appropriately and return
@@ -89,10 +85,10 @@ struct tempfile {
 
 /*
  * Attempt to create a temporary file at the specified `path`. Return
- * a file descriptor for writing to it, or -1 on error. It is an error
- * if a file already exists at that path.
+ * a tempfile (whose "fd" member can be used for writing to it), or
+ * NULL on error. It is an error if a file already exists at that path.
  */
-extern int create_tempfile(struct tempfile *tempfile, const char *path);
+extern struct tempfile *create_tempfile(const char *path);
 
 /*
  * Register an existing file as a tempfile, meaning that it will be
@@ -100,7 +96,7 @@ extern int create_tempfile(struct tempfile *tempfile, const char *path);
  * but it can be worked with like any other closed tempfile (for
  * example, it can be opened using reopen_tempfile()).
  */
-extern void register_tempfile(struct tempfile *tempfile, const char *path);
+extern struct tempfile *register_tempfile(const char *path);
 
 
 /*
@@ -132,70 +128,65 @@ extern void register_tempfile(struct tempfile *tempfile, const char *path);
  * know the (absolute) path of the file that was created, it can be
  * read from tempfile->filename.
  *
- * On success, the functions return a file descriptor that is open for
- * writing the temporary file. On errors, they return -1 and set errno
- * appropriately (except for the "x" variants, which die() on errors).
+ * On success, the functions return a tempfile whose "fd" member is open
+ * for writing the temporary file. On errors, they return NULL and set
+ * errno appropriately (except for the "x" variants, which die() on
+ * errors).
  */
 
 /* See "mks_tempfile functions" above. */
-extern int mks_tempfile_sm(struct tempfile *tempfile,
-			   const char *template, int suffixlen, int mode);
+extern struct tempfile *mks_tempfile_sm(const char *template,
+					int suffixlen, int mode);
 
 /* See "mks_tempfile functions" above. */
-static inline int mks_tempfile_s(struct tempfile *tempfile,
-				 const char *template, int suffixlen)
+static inline struct tempfile *mks_tempfile_s(const char *template,
+					      int suffixlen)
 {
-	return mks_tempfile_sm(tempfile, template, suffixlen, 0600);
+	return mks_tempfile_sm(template, suffixlen, 0600);
 }
 
 /* See "mks_tempfile functions" above. */
-static inline int mks_tempfile_m(struct tempfile *tempfile,
-				 const char *template, int mode)
+static inline struct tempfile *mks_tempfile_m(const char *template, int mode)
 {
-	return mks_tempfile_sm(tempfile, template, 0, mode);
+	return mks_tempfile_sm(template, 0, mode);
 }
 
 /* See "mks_tempfile functions" above. */
-static inline int mks_tempfile(struct tempfile *tempfile,
-			       const char *template)
+static inline struct tempfile *mks_tempfile(const char *template)
 {
-	return mks_tempfile_sm(tempfile, template, 0, 0600);
+	return mks_tempfile_sm(template, 0, 0600);
 }
 
 /* See "mks_tempfile functions" above. */
-extern int mks_tempfile_tsm(struct tempfile *tempfile,
-			    const char *template, int suffixlen, int mode);
+extern struct tempfile *mks_tempfile_tsm(const char *template,
+					 int suffixlen, int mode);
 
 /* See "mks_tempfile functions" above. */
-static inline int mks_tempfile_ts(struct tempfile *tempfile,
-				  const char *template, int suffixlen)
+static inline struct tempfile *mks_tempfile_ts(const char *template,
+					       int suffixlen)
 {
-	return mks_tempfile_tsm(tempfile, template, suffixlen, 0600);
+	return mks_tempfile_tsm(template, suffixlen, 0600);
 }
 
 /* See "mks_tempfile functions" above. */
-static inline int mks_tempfile_tm(struct tempfile *tempfile,
-				  const char *template, int mode)
+static inline struct tempfile *mks_tempfile_tm(const char *template, int mode)
 {
-	return mks_tempfile_tsm(tempfile, template, 0, mode);
+	return mks_tempfile_tsm(template, 0, mode);
 }
 
 /* See "mks_tempfile functions" above. */
-static inline int mks_tempfile_t(struct tempfile *tempfile,
-				 const char *template)
+static inline struct tempfile *mks_tempfile_t(const char *template)
 {
-	return mks_tempfile_tsm(tempfile, template, 0, 0600);
+	return mks_tempfile_tsm(template, 0, 0600);
 }
 
 /* See "mks_tempfile functions" above. */
-extern int xmks_tempfile_m(struct tempfile *tempfile,
-			   const char *template, int mode);
+extern struct tempfile *xmks_tempfile_m(const char *template, int mode);
 
 /* See "mks_tempfile functions" above. */
-static inline int xmks_tempfile(struct tempfile *tempfile,
-				const char *template)
+static inline struct tempfile *xmks_tempfile(const char *template)
 {
-	return xmks_tempfile_m(tempfile, template, 0600);
+	return xmks_tempfile_m(template, 0600);
 }
 
 /*
@@ -257,7 +248,7 @@ extern int reopen_tempfile(struct tempfile *tempfile);
  * `delete_tempfile()` for a `tempfile` object that has already been
  * deleted or renamed.
  */
-extern void delete_tempfile(struct tempfile *tempfile);
+extern void delete_tempfile(struct tempfile **tempfile_p);
 
 /*
  * Close the file descriptor and/or file pointer if they are still
@@ -268,6 +259,6 @@ extern void delete_tempfile(struct tempfile *tempfile);
  * `rename(2)`. It is a bug to call `rename_tempfile()` for a
  * `tempfile` object that is not currently active.
  */
-extern int rename_tempfile(struct tempfile *tempfile, const char *path);
+extern int rename_tempfile(struct tempfile **tempfile_p, const char *path);
 
 #endif /* TEMPFILE_H */
diff --git a/trailer.c b/trailer.c
index c30e3a0c04..3ba157ed0d 100644
--- a/trailer.c
+++ b/trailer.c
@@ -995,7 +995,7 @@ static void free_all(struct list_head *head)
 	}
 }
 
-static struct tempfile trailers_tempfile;
+static struct tempfile *trailers_tempfile;
 
 static FILE *create_in_place_tempfile(const char *file)
 {
@@ -1017,9 +1017,9 @@ static FILE *create_in_place_tempfile(const char *file)
 		strbuf_add(&template, file, tail - file + 1);
 	strbuf_addstr(&template, "git-interpret-trailers-XXXXXX");
 
-	xmks_tempfile_m(&trailers_tempfile, template.buf, st.st_mode);
+	trailers_tempfile = xmks_tempfile_m(template.buf, st.st_mode);
 	strbuf_release(&template);
-	outfile = fdopen_tempfile(&trailers_tempfile, "w");
+	outfile = fdopen_tempfile(trailers_tempfile, "w");
 	if (!outfile)
 		die_errno(_("could not open temporary file"));
 
-- 
2.14.1.721.gc5bc1565f1

