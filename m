Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 804D8208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 12:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbdIEMPX (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 08:15:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:57216 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751562AbdIEMPS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 08:15:18 -0400
Received: (qmail 31414 invoked by uid 109); 5 Sep 2017 12:15:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 12:15:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12408 invoked by uid 111); 5 Sep 2017 12:15:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:15:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 08:15:15 -0400
Date:   Tue, 5 Sep 2017 08:15:15 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 19/20] ref_lock: stop leaking lock_files
Message-ID: <20170905121515.xejuaiadexhmya2f@sigill.intra.peff.net>
References: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the tempfile code recently relaxed the rule that
tempfile structs (and thus locks) need to hang around
forever, we no longer have to leak our lock_file structs.

In fact, we don't even need to heap-allocate them anymore,
since their lifetime can just match that of the surrounding
ref_lock (and if we forget to delete a lock, the effect is
the same as before: it will eventually go away at program
exit).

Note that there is a check in unlock_ref() to only rollback
a lock file if it has been allocated. We don't need that
check anymore; we zero the ref_lock (and thus the
lock_file), so at worst we pass a NULL pointer to
delete_tempfile(), which considers that a noop.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs/files-backend.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 36fe8a986b..f3455609d6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -12,7 +12,7 @@
 
 struct ref_lock {
 	char *ref_name;
-	struct lock_file *lk;
+	struct lock_file lk;
 	struct object_id old_oid;
 };
 
@@ -418,9 +418,7 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 
 static void unlock_ref(struct ref_lock *lock)
 {
-	/* Do not free lock->lk -- atexit() still looks at them */
-	if (lock->lk)
-		rollback_lock_file(lock->lk);
+	rollback_lock_file(&lock->lk);
 	free(lock->ref_name);
 	free(lock);
 }
@@ -534,11 +532,8 @@ static int lock_raw_ref(struct files_ref_store *refs,
 		goto error_return;
 	}
 
-	if (!lock->lk)
-		lock->lk = xcalloc(1, sizeof(struct lock_file));
-
 	if (hold_lock_file_for_update_timeout(
-			    lock->lk, ref_file.buf, LOCK_NO_DEREF,
+			    &lock->lk, ref_file.buf, LOCK_NO_DEREF,
 			    get_files_ref_lock_timeout_ms()) < 0) {
 		if (errno == ENOENT && --attempts_remaining > 0) {
 			/*
@@ -949,11 +944,9 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 		goto error_return;
 	}
 
-	lock->lk = xcalloc(1, sizeof(struct lock_file));
-
 	lock->ref_name = xstrdup(refname);
 
-	if (raceproof_create_file(ref_file.buf, create_reflock, lock->lk)) {
+	if (raceproof_create_file(ref_file.buf, create_reflock, &lock->lk)) {
 		last_errno = errno;
 		unable_to_lock_message(ref_file.buf, errno, err);
 		goto error_return;
@@ -1404,14 +1397,14 @@ static int files_rename_ref(struct ref_store *ref_store,
 
 static int close_ref_gently(struct ref_lock *lock)
 {
-	if (close_lock_file_gently(lock->lk))
+	if (close_lock_file_gently(&lock->lk))
 		return -1;
 	return 0;
 }
 
 static int commit_ref(struct ref_lock *lock)
 {
-	char *path = get_locked_file_path(lock->lk);
+	char *path = get_locked_file_path(&lock->lk);
 	struct stat st;
 
 	if (!lstat(path, &st) && S_ISDIR(st.st_mode)) {
@@ -1435,7 +1428,7 @@ static int commit_ref(struct ref_lock *lock)
 		free(path);
 	}
 
-	if (commit_lock_file(lock->lk))
+	if (commit_lock_file(&lock->lk))
 		return -1;
 	return 0;
 }
@@ -1627,12 +1620,12 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 		unlock_ref(lock);
 		return -1;
 	}
-	fd = get_lock_file_fd(lock->lk);
+	fd = get_lock_file_fd(&lock->lk);
 	if (write_in_full(fd, oid_to_hex(oid), GIT_SHA1_HEXSZ) != GIT_SHA1_HEXSZ ||
 	    write_in_full(fd, &term, 1) != 1 ||
 	    close_ref_gently(lock) < 0) {
 		strbuf_addf(err,
-			    "couldn't write '%s'", get_lock_file_path(lock->lk));
+			    "couldn't write '%s'", get_lock_file_path(&lock->lk));
 		unlock_ref(lock);
 		return -1;
 	}
@@ -1709,7 +1702,7 @@ static int create_ref_symlink(struct ref_lock *lock, const char *target)
 {
 	int ret = -1;
 #ifndef NO_SYMLINK_HEAD
-	char *ref_path = get_locked_file_path(lock->lk);
+	char *ref_path = get_locked_file_path(&lock->lk);
 	unlink(ref_path);
 	ret = symlink(target, ref_path);
 	free(ref_path);
@@ -1745,14 +1738,14 @@ static int create_symref_locked(struct files_ref_store *refs,
 		return 0;
 	}
 
-	if (!fdopen_lock_file(lock->lk, "w"))
+	if (!fdopen_lock_file(&lock->lk, "w"))
 		return error("unable to fdopen %s: %s",
-			     lock->lk->tempfile->filename.buf, strerror(errno));
+			     lock->lk.tempfile->filename.buf, strerror(errno));
 
 	update_symref_reflog(refs, lock, refname, target, logmsg);
 
 	/* no error check; commit_ref will check ferror */
-	fprintf(lock->lk->tempfile->fp, "ref: %s\n", target);
+	fprintf(lock->lk.tempfile->fp, "ref: %s\n", target);
 	if (commit_ref(lock) < 0)
 		return error("unable to write symref for %s: %s", refname,
 			     strerror(errno));
@@ -2853,12 +2846,12 @@ static int files_reflog_expire(struct ref_store *ref_store,
 					strerror(errno));
 			rollback_lock_file(&reflog_lock);
 		} else if (update &&
-			   (write_in_full(get_lock_file_fd(lock->lk),
+			   (write_in_full(get_lock_file_fd(&lock->lk),
 				oid_to_hex(&cb.last_kept_oid), GIT_SHA1_HEXSZ) != GIT_SHA1_HEXSZ ||
-			    write_str_in_full(get_lock_file_fd(lock->lk), "\n") != 1 ||
+			    write_str_in_full(get_lock_file_fd(&lock->lk), "\n") != 1 ||
 			    close_ref_gently(lock) < 0)) {
 			status |= error("couldn't write %s",
-					get_lock_file_path(lock->lk));
+					get_lock_file_path(&lock->lk));
 			rollback_lock_file(&reflog_lock);
 		} else if (commit_lock_file(&reflog_lock)) {
 			status |= error("unable to write reflog '%s' (%s)",
-- 
2.14.1.721.gc5bc1565f1

