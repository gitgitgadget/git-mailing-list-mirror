Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68AE6208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 12:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbdIEMOh (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 08:14:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:57148 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750932AbdIEMOf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 08:14:35 -0400
Received: (qmail 31286 invoked by uid 109); 5 Sep 2017 12:14:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 12:14:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12229 invoked by uid 111); 5 Sep 2017 12:15:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:15:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 08:14:33 -0400
Date:   Tue, 5 Sep 2017 08:14:33 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 07/20] lockfile: do not rollback lock on failed close
Message-ID: <20170905121433.w2w72qybntk3kv6y@sigill.intra.peff.net>
References: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the lockfile code is based on the tempfile code, it
has some of the same problems, including that close_lock_file()
erases the tempfile's filename buf, making it hard for the
caller to write a good error message.

In practice this comes up less for lockfiles than for
straight tempfiles, since we usually just report the
refname. But there is at least one buggy case in
write_ref_to_lockfile(). Besides, given the coupling between
the lockfile and tempfile modules, it's less confusing if
their close() functions have the same semantics.

Just as the previous commit did for close_tempfile(), let's
teach close_lock_file() and its wrapper close_ref() not to
rollback on error. And just as before, we'll give them new
"gently" names to catch any new callers that are added.

Signed-off-by: Jeff King <peff@peff.net>
---
 lockfile.h            | 30 ++++++++++++------------------
 read-cache.c          |  2 +-
 refs/files-backend.c  | 13 +++++++------
 refs/packed-backend.c |  3 ++-
 4 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/lockfile.h b/lockfile.h
index dd4259bc40..c45d2db324 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -69,7 +69,7 @@
  *   `rollback_lock_file()`.
  *
  * * Close the file descriptor without removing or renaming the
- *   lockfile by calling `close_lock_file()`, and later call
+ *   lockfile by calling `close_lock_file_gently()`, and later call
  *   `commit_lock_file()`, `commit_lock_file_to()`,
  *   `rollback_lock_file()`, or `reopen_lock_file()`.
  *
@@ -85,7 +85,7 @@
  *
  * If you need to close the file descriptor you obtained from a
  * `hold_lock_file_for_*()` function yourself, do so by calling
- * `close_lock_file()`. See "tempfile.h" for more information.
+ * `close_lock_file_gently()`. See "tempfile.h" for more information.
  *
  *
  * Under the covers, a lockfile is just a tempfile with a few helper
@@ -104,8 +104,8 @@
  *
  * Similarly, `commit_lock_file`, `commit_lock_file_to`, and
  * `close_lock_file` return 0 on success. On failure they set `errno`
- * appropriately, do their best to roll back the lockfile, and return
- * -1.
+ * appropriately and return -1. The `commit` variants (but not `close`)
+ * do their best to delete the temporary file before returning.
  */
 
 #include "tempfile.h"
@@ -202,8 +202,9 @@ extern NORETURN void unable_to_lock_die(const char *path, int err);
 /*
  * Associate a stdio stream with the lockfile (which must still be
  * open). Return `NULL` (*without* rolling back the lockfile) on
- * error. The stream is closed automatically when `close_lock_file()`
- * is called or when the file is committed or rolled back.
+ * error. The stream is closed automatically when
+ * `close_lock_file_gently()` is called or when the file is committed or
+ * rolled back.
  */
 static inline FILE *fdopen_lock_file(struct lock_file *lk, const char *mode)
 {
@@ -241,28 +242,21 @@ extern char *get_locked_file_path(struct lock_file *lk);
  * lockfile over the file being locked. Return 0 upon success. On
  * failure to `close(2)`, return a negative value and roll back the
  * lock file. Usually `commit_lock_file()`, `commit_lock_file_to()`,
- * or `rollback_lock_file()` should eventually be called if
- * `close_lock_file()` succeeds.
+ * or `rollback_lock_file()` should eventually be called.
  */
-static inline int close_lock_file(struct lock_file *lk)
+static inline int close_lock_file_gently(struct lock_file *lk)
 {
-	int ret = close_tempfile_gently(&lk->tempfile);
-	if (ret) {
-		int saved_errno = errno;
-		delete_tempfile(&lk->tempfile);
-		errno = saved_errno;
-	}
-	return ret;
+	return close_tempfile_gently(&lk->tempfile);
 }
 
 /*
- * Re-open a lockfile that has been closed using `close_lock_file()`
+ * Re-open a lockfile that has been closed using `close_lock_file_gently()`
  * but not yet committed or rolled back. This can be used to implement
  * a sequence of operations like the following:
  *
  * * Lock file.
  *
- * * Write new contents to lockfile, then `close_lock_file()` to
+ * * Write new contents to lockfile, then `close_lock_file_gently()` to
  *   cause the contents to be written to disk.
  *
  * * Pass the name of the lockfile to another program to allow it (and
diff --git a/read-cache.c b/read-cache.c
index 51686518e0..c3be65f8b0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2345,7 +2345,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	if (flags & COMMIT_LOCK)
 		return commit_locked_index(lock);
 	else if (flags & CLOSE_LOCK)
-		return close_lock_file(lock);
+		return close_lock_file_gently(lock);
 	else
 		return ret;
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index fccbc24ac4..bc1899cd4a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1402,9 +1402,9 @@ static int files_rename_ref(struct ref_store *ref_store,
 	return ret;
 }
 
-static int close_ref(struct ref_lock *lock)
+static int close_ref_gently(struct ref_lock *lock)
 {
-	if (close_lock_file(lock->lk))
+	if (close_lock_file_gently(lock->lk))
 		return -1;
 	return 0;
 }
@@ -1630,7 +1630,7 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 	fd = get_lock_file_fd(lock->lk);
 	if (write_in_full(fd, oid_to_hex(oid), GIT_SHA1_HEXSZ) != GIT_SHA1_HEXSZ ||
 	    write_in_full(fd, &term, 1) != 1 ||
-	    close_ref(lock) < 0) {
+	    close_ref_gently(lock) < 0) {
 		strbuf_addf(err,
 			    "couldn't write '%s'", get_lock_file_path(lock->lk));
 		unlock_ref(lock);
@@ -2372,7 +2372,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		 * the lockfile is still open. Close it to
 		 * free up the file descriptor:
 		 */
-		if (close_ref(lock)) {
+		if (close_ref_gently(lock)) {
 			strbuf_addf(err, "couldn't close '%s.lock'",
 				    update->refname);
 			return TRANSACTION_GENERIC_ERROR;
@@ -2848,14 +2848,15 @@ static int files_reflog_expire(struct ref_store *ref_store,
 			!(type & REF_ISSYMREF) &&
 			!is_null_oid(&cb.last_kept_oid);
 
-		if (close_lock_file(&reflog_lock)) {
+		if (close_lock_file_gently(&reflog_lock)) {
 			status |= error("couldn't write %s: %s", log_file,
 					strerror(errno));
+			rollback_lock_file(&reflog_lock);
 		} else if (update &&
 			   (write_in_full(get_lock_file_fd(lock->lk),
 				oid_to_hex(&cb.last_kept_oid), GIT_SHA1_HEXSZ) != GIT_SHA1_HEXSZ ||
 			    write_str_in_full(get_lock_file_fd(lock->lk), "\n") != 1 ||
-			    close_ref(lock) < 0)) {
+			    close_ref_gently(lock) < 0)) {
 			status |= error("couldn't write %s",
 					get_lock_file_path(lock->lk));
 			rollback_lock_file(&reflog_lock);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 412c85034f..dca887c0fe 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -545,8 +545,9 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 		return -1;
 	}
 
-	if (close_lock_file(&refs->lock)) {
+	if (close_lock_file_gently(&refs->lock)) {
 		strbuf_addf(err, "unable to close %s: %s", refs->path, strerror(errno));
+		rollback_lock_file(&refs->lock);
 		return -1;
 	}
 
-- 
2.14.1.721.gc5bc1565f1

