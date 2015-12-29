From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] create_symref: use existing ref-lock code
Date: Tue, 29 Dec 2015 00:57:01 -0500
Message-ID: <20151229055701.GB17012@sigill.intra.peff.net>
References: <20151229055558.GA12848@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 06:58:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDnIk-0008IY-22
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 06:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbbL2F5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 00:57:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:46504 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753496AbbL2F5E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 00:57:04 -0500
Received: (qmail 14000 invoked by uid 102); 29 Dec 2015 05:57:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 28 Dec 2015 23:57:03 -0600
Received: (qmail 18391 invoked by uid 107); 29 Dec 2015 05:57:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 00:57:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 00:57:01 -0500
Content-Disposition: inline
In-Reply-To: <20151229055558.GA12848@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283070>

The create_symref() function predates the existence of
"struct lock_file", let alone the more recent "struct
ref_lock". Instead, it just does its own manual dot-locking.
Besides being more code, this has a few downsides:

 - if git is interrupted while holding the lock, we don't
   clean up the lockfile

 - we don't do the usual directory/filename conflict check.
   So you can sometimes create a symref "refs/heads/foo/bar",
   even if "refs/heads/foo" exists (namely, if the refs are
   packed and we do not hit the d/f conflict in the
   filesystem).

This patch refactors create_symref() to use the "struct
ref_lock" interface, which handles both of these things.
There are a few bonus cleanups that come along with it:

 - we leaked ref_path in some error cases

 - the symref contents were stored in a fixed-size buffer,
   putting an artificial (albeit large) limitation on the
   length of the refname. We now write through fprintf, and
   handle refnames of any size.

 - we called adjust_shared_perm only after the file was
   renamed into place, creating a potential race with
   readers in a shared repository. The lockfile code now
   handles this when creating the lockfile, making it
   atomic.

 - the legacy prefer_symlink_refs path did not do any
   locking at all. Admittedly, it is not atomic from a
   reader's perspective (as it unlinks and re-creates the
   symlink to overwrite), but at least it cannot conflict
   with other writers now.

 - the result of this patch is hopefully more readable. It
   eliminates three goto labels. Two were for error checking
   that is now simplified, and the third was to reach shared
   code that has been pulled into its own function.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs/files-backend.c    | 109 ++++++++++++++++++++++++------------------------
 t/t1401-symbolic-ref.sh |   8 ++++
 2 files changed, 62 insertions(+), 55 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index d6f9123..3d1994d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2811,74 +2811,73 @@ static int commit_ref_update(struct ref_lock *lock,
 	return 0;
 }
 
-int create_symref(const char *refname, const char *target, const char *logmsg)
+static int create_ref_symlink(struct ref_lock *lock, const char *target)
 {
-	char *lockpath = NULL;
-	char buf[1000];
-	int fd, len, written;
-	char *ref_path = git_pathdup("%s", refname);
-	unsigned char old_sha1[20], new_sha1[20];
-	struct strbuf err = STRBUF_INIT;
-
-	if (logmsg && read_ref(refname, old_sha1))
-		hashclr(old_sha1);
-
-	if (safe_create_leading_directories(ref_path) < 0)
-		return error("unable to create directory for %s", ref_path);
-
+	int ret = -1;
 #ifndef NO_SYMLINK_HEAD
-	if (prefer_symlink_refs) {
-		unlink(ref_path);
-		if (!symlink(target, ref_path))
-			goto done;
+	char *ref_path = get_locked_file_path(lock->lk);
+	unlink(ref_path);
+	ret = symlink(target, ref_path);
+	free(ref_path);
+
+	if (ret)
 		fprintf(stderr, "no symlink - falling back to symbolic ref\n");
-	}
 #endif
+	return ret;
+}
 
-	len = snprintf(buf, sizeof(buf), "ref: %s\n", target);
-	if (sizeof(buf) <= len) {
-		error("refname too long: %s", target);
-		goto error_free_return;
-	}
-	lockpath = mkpathdup("%s.lock", ref_path);
-	fd = open(lockpath, O_CREAT | O_EXCL | O_WRONLY, 0666);
-	if (fd < 0) {
-		error("Unable to open %s for writing", lockpath);
-		goto error_free_return;
-	}
-	written = write_in_full(fd, buf, len);
-	if (close(fd) != 0 || written != len) {
-		error("Unable to write to %s", lockpath);
-		goto error_unlink_return;
-	}
-	if (rename(lockpath, ref_path) < 0) {
-		error("Unable to create %s", ref_path);
-		goto error_unlink_return;
-	}
-	if (adjust_shared_perm(ref_path)) {
-		error("Unable to fix permissions on %s", lockpath);
-	error_unlink_return:
-		unlink_or_warn(lockpath);
-	error_free_return:
-		free(lockpath);
-		free(ref_path);
-		return -1;
-	}
-	free(lockpath);
-
-#ifndef NO_SYMLINK_HEAD
-	done:
-#endif
+static void update_symref_reflog(struct ref_lock *lock, const char *refname,
+				 const char *target, const char *logmsg)
+{
+	struct strbuf err = STRBUF_INIT;
+	unsigned char new_sha1[20];
 	if (logmsg && !read_ref(target, new_sha1) &&
-		log_ref_write(refname, old_sha1, new_sha1, logmsg, 0, &err)) {
+	    log_ref_write(refname, lock->old_oid.hash, new_sha1, logmsg, 0, &err)) {
 		error("%s", err.buf);
 		strbuf_release(&err);
 	}
+}
 
-	free(ref_path);
+static int create_symref_locked(struct ref_lock *lock, const char *refname,
+				const char *target, const char *logmsg)
+{
+	if (prefer_symlink_refs && !create_ref_symlink(lock, target)) {
+		update_symref_reflog(lock, refname, target, logmsg);
+		return 0;
+	}
+
+	if (!fdopen_lock_file(lock->lk, "w"))
+		return error("unable to fdopen %s: %s",
+			     lock->lk->tempfile.filename.buf, strerror(errno));
+
+	/* no error check; commit_ref will check ferror */
+	fprintf(lock->lk->tempfile.fp, "ref: %s\n", target);
+	if (commit_ref(lock) < 0)
+		return error("unable to write symref for %s: %s", refname,
+			     strerror(errno));
+	update_symref_reflog(lock, refname, target, logmsg);
 	return 0;
 }
 
+int create_symref(const char *refname, const char *target, const char *logmsg)
+{
+	struct strbuf err = STRBUF_INIT;
+	struct ref_lock *lock;
+	int ret;
+
+	lock = lock_ref_sha1_basic(refname, NULL, NULL, NULL, REF_NODEREF, NULL,
+				   &err);
+	if (!lock) {
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
+
+	ret = create_symref_locked(lock, refname, target, logmsg);
+	unlock_ref(lock);
+	return ret;
+}
+
 int reflog_exists(const char *refname)
 {
 	struct stat st;
diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 1f0dff3..5db876c 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -114,4 +114,12 @@ test_expect_success 'symbolic-ref writes reflog entry' '
 	test_cmp expect actual
 '
 
+test_expect_success 'symbolic-ref does not create ref d/f conflicts' '
+	git checkout -b df &&
+	test_commit df &&
+	test_must_fail git symbolic-ref refs/heads/df/conflict refs/heads/df &&
+	git pack-refs --all --prune &&
+	test_must_fail git symbolic-ref refs/heads/df/conflict refs/heads/df
+'
+
 test_done
-- 
2.7.0.rc2.368.g1cbb535
