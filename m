From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] create_symref: modernize variable names
Date: Tue, 29 Dec 2015 00:56:44 -0500
Message-ID: <20151229055644.GA17012@sigill.intra.peff.net>
References: <20151229055558.GA12848@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 06:56:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDnHA-0006m0-8G
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 06:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbbL2F4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 00:56:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:46499 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753147AbbL2F4r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 00:56:47 -0500
Received: (qmail 13939 invoked by uid 102); 29 Dec 2015 05:56:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 28 Dec 2015 23:56:47 -0600
Received: (qmail 18373 invoked by uid 107); 29 Dec 2015 05:56:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 00:56:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 00:56:44 -0500
Content-Disposition: inline
In-Reply-To: <20151229055558.GA12848@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283068>

Once upon a time, create_symref() was used only to point
HEAD at a branch name, and the variable names reflect that
(e.g., calling the path git_HEAD). However, it is much more
generic these days (and has been for some time). Let's
update the variable names to make it easier to follow:

  - `ref_target` is now just `refname`. This is closer to
    the `ref` that is already in `cache.h`, but with the
    extra twist that "name" makes it clear this is the name
    and not a ref struct. Dropping "target" hopefully makes
    it clear that we are talking about the symref itself,
    not what it points to.

  - `git_HEAD` is now `ref_path`; the on-disk path
    corresponding to `ref`.

  - `refs_heads_master` is now just `target`; i.e., what the
    symref points at. This term also matches what is in
    the symlink(2) manpage (at least on Linux).

  - the buffer to hold the symref file's contents was simply
    called `ref`. It's now `buf` (admittedly also generic,
    but at least not actively introducing confusion with the
    other variable holding the refname).

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.h               |  2 +-
 refs/files-backend.c | 41 ++++++++++++++++++++---------------------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/refs.h b/refs.h
index 7a04077..3c3da29 100644
--- a/refs.h
+++ b/refs.h
@@ -292,7 +292,7 @@ extern char *shorten_unambiguous_ref(const char *refname, int strict);
 /** rename ref, return 0 on success **/
 extern int rename_ref(const char *oldref, const char *newref, const char *logmsg);
 
-extern int create_symref(const char *ref, const char *refs_heads_master, const char *logmsg);
+extern int create_symref(const char *refname, const char *target, const char *logmsg);
 
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index c648b5e..d6f9123 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2811,58 +2811,57 @@ static int commit_ref_update(struct ref_lock *lock,
 	return 0;
 }
 
-int create_symref(const char *ref_target, const char *refs_heads_master,
-		  const char *logmsg)
+int create_symref(const char *refname, const char *target, const char *logmsg)
 {
 	char *lockpath = NULL;
-	char ref[1000];
+	char buf[1000];
 	int fd, len, written;
-	char *git_HEAD = git_pathdup("%s", ref_target);
+	char *ref_path = git_pathdup("%s", refname);
 	unsigned char old_sha1[20], new_sha1[20];
 	struct strbuf err = STRBUF_INIT;
 
-	if (logmsg && read_ref(ref_target, old_sha1))
+	if (logmsg && read_ref(refname, old_sha1))
 		hashclr(old_sha1);
 
-	if (safe_create_leading_directories(git_HEAD) < 0)
-		return error("unable to create directory for %s", git_HEAD);
+	if (safe_create_leading_directories(ref_path) < 0)
+		return error("unable to create directory for %s", ref_path);
 
 #ifndef NO_SYMLINK_HEAD
 	if (prefer_symlink_refs) {
-		unlink(git_HEAD);
-		if (!symlink(refs_heads_master, git_HEAD))
+		unlink(ref_path);
+		if (!symlink(target, ref_path))
 			goto done;
 		fprintf(stderr, "no symlink - falling back to symbolic ref\n");
 	}
 #endif
 
-	len = snprintf(ref, sizeof(ref), "ref: %s\n", refs_heads_master);
-	if (sizeof(ref) <= len) {
-		error("refname too long: %s", refs_heads_master);
+	len = snprintf(buf, sizeof(buf), "ref: %s\n", target);
+	if (sizeof(buf) <= len) {
+		error("refname too long: %s", target);
 		goto error_free_return;
 	}
-	lockpath = mkpathdup("%s.lock", git_HEAD);
+	lockpath = mkpathdup("%s.lock", ref_path);
 	fd = open(lockpath, O_CREAT | O_EXCL | O_WRONLY, 0666);
 	if (fd < 0) {
 		error("Unable to open %s for writing", lockpath);
 		goto error_free_return;
 	}
-	written = write_in_full(fd, ref, len);
+	written = write_in_full(fd, buf, len);
 	if (close(fd) != 0 || written != len) {
 		error("Unable to write to %s", lockpath);
 		goto error_unlink_return;
 	}
-	if (rename(lockpath, git_HEAD) < 0) {
-		error("Unable to create %s", git_HEAD);
+	if (rename(lockpath, ref_path) < 0) {
+		error("Unable to create %s", ref_path);
 		goto error_unlink_return;
 	}
-	if (adjust_shared_perm(git_HEAD)) {
+	if (adjust_shared_perm(ref_path)) {
 		error("Unable to fix permissions on %s", lockpath);
 	error_unlink_return:
 		unlink_or_warn(lockpath);
 	error_free_return:
 		free(lockpath);
-		free(git_HEAD);
+		free(ref_path);
 		return -1;
 	}
 	free(lockpath);
@@ -2870,13 +2869,13 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 #ifndef NO_SYMLINK_HEAD
 	done:
 #endif
-	if (logmsg && !read_ref(refs_heads_master, new_sha1) &&
-		log_ref_write(ref_target, old_sha1, new_sha1, logmsg, 0, &err)) {
+	if (logmsg && !read_ref(target, new_sha1) &&
+		log_ref_write(refname, old_sha1, new_sha1, logmsg, 0, &err)) {
 		error("%s", err.buf);
 		strbuf_release(&err);
 	}
 
-	free(git_HEAD);
+	free(ref_path);
 	return 0;
 }
 
-- 
2.7.0.rc2.368.g1cbb535
