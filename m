From: Jeff King <peff@peff.net>
Subject: [PATCH 05/17] remove hold_lock_file_for_append
Date: Mon, 10 Aug 2015 05:35:14 -0400
Message-ID: <20150810093514.GE30981@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jim Hill <gjthill@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 11:35:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjUL-00047X-FC
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287AbbHJJfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:35:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:42818 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751523AbbHJJfT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 05:35:19 -0400
Received: (qmail 30898 invoked by uid 102); 10 Aug 2015 09:35:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 04:35:20 -0500
Received: (qmail 3099 invoked by uid 107); 10 Aug 2015 09:35:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 05:35:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 05:35:14 -0400
Content-Disposition: inline
In-Reply-To: <20150810092731.GA9027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275571>

From: Jim Hill <gjthill@gmail.com>

No users of hold_lock_file_for_append remain, so remove it.

hold_lock_file_for_append copies its target file internally.
This makes it too heavyweight for true append-only logging
and too limited for anything else (which probably wants to
process the contents). It shouldn't be used.

[jk: tweaked commit message, and dropped declaration and
     documentation, too]

Signed-off-by: Jim Hill <gjthill@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
And this is the obvious continuation of the last patch.

 Documentation/technical/api-lockfile.txt | 26 ++++++++--------------
 lockfile.c                               | 38 --------------------------------
 lockfile.h                               |  7 ++----
 3 files changed, 11 insertions(+), 60 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index 93b5f23..0f5c481 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -40,7 +40,7 @@ The caller:
 
 * Attempts to create a lockfile by passing that variable and the path
   of the final destination (e.g. `$GIT_DIR/index`) to
-  `hold_lock_file_for_update` or `hold_lock_file_for_append`.
+  `hold_lock_file_for_update`.
 
 * Writes new content for the destination file by either:
 
@@ -64,8 +64,7 @@ When finished writing, the caller can:
 
 Even after the lockfile is committed or rolled back, the `lock_file`
 object must not be freed or altered by the caller. However, it may be
-reused; just pass it to another call of `hold_lock_file_for_update` or
-`hold_lock_file_for_append`.
+reused; just pass it to another call of `hold_lock_file_for_update`.
 
 If the program exits before you have called one of `commit_lock_file`,
 `commit_lock_file_to`, `rollback_lock_file`, or `close_lock_file`, an
@@ -111,8 +110,7 @@ appropriately, do their best to roll back the lockfile, and return -1.
 Flags
 -----
 
-The following flags can be passed to `hold_lock_file_for_update` or
-`hold_lock_file_for_append`:
+The following flags can be passed to `hold_lock_file_for_update`:
 
 LOCK_NO_DEREF::
 
@@ -141,12 +139,6 @@ hold_lock_file_for_update::
 	above). Attempt to create a lockfile for the destination and
 	return the file descriptor for writing to the file.
 
-hold_lock_file_for_append::
-
-	Like `hold_lock_file_for_update`, but before returning copy
-	the existing contents of the file (if any) to the lockfile and
-	position its write pointer at the end of the file.
-
 fdopen_lock_file::
 
 	Associate a stdio stream with the lockfile. Return NULL
@@ -162,8 +154,8 @@ get_locked_file_path::
 commit_lock_file::
 
 	Take a pointer to the `struct lock_file` initialized with an
-	earlier call to `hold_lock_file_for_update` or
-	`hold_lock_file_for_append`, close the file descriptor, and
+	earlier call to `hold_lock_file_for_update`,
+	close the file descriptor, and
 	rename the lockfile to its final destination. Return 0 upon
 	success. On failure, roll back the lock file and return -1,
 	with `errno` set to the value from the failing call to
@@ -180,8 +172,8 @@ commit_lock_file_to::
 rollback_lock_file::
 
 	Take a pointer to the `struct lock_file` initialized with an
-	earlier call to `hold_lock_file_for_update` or
-	`hold_lock_file_for_append`, close the file descriptor and
+	earlier call to `hold_lock_file_for_update`,
+	close the file descriptor and
 	remove the lockfile. It is a NOOP to call
 	`rollback_lock_file()` for a `lock_file` object that has
 	already been committed or rolled back.
@@ -189,8 +181,8 @@ rollback_lock_file::
 close_lock_file::
 
 	Take a pointer to the `struct lock_file` initialized with an
-	earlier call to `hold_lock_file_for_update` or
-	`hold_lock_file_for_append`. Close the file descriptor (and
+	earlier call to `hold_lock_file_for_update`.
+	Close the file descriptor (and
 	the file pointer if it has been opened using
 	`fdopen_lock_file`). Return 0 upon success. On failure to
 	`close(2)`, return a negative value and roll back the lock
diff --git a/lockfile.c b/lockfile.c
index 993bb82..b1ceec6 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -249,44 +249,6 @@ int hold_lock_file_for_update_timeout(struct lock_file *lk, const char *path,
 	return fd;
 }
 
-int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
-{
-	int fd, orig_fd;
-
-	fd = lock_file(lk, path, flags);
-	if (fd < 0) {
-		if (flags & LOCK_DIE_ON_ERROR)
-			unable_to_lock_die(path, errno);
-		return fd;
-	}
-
-	orig_fd = open(path, O_RDONLY);
-	if (orig_fd < 0) {
-		if (errno != ENOENT) {
-			int save_errno = errno;
-
-			if (flags & LOCK_DIE_ON_ERROR)
-				die("cannot open '%s' for copying", path);
-			rollback_lock_file(lk);
-			error("cannot open '%s' for copying", path);
-			errno = save_errno;
-			return -1;
-		}
-	} else if (copy_fd(orig_fd, fd)) {
-		int save_errno = errno;
-
-		if (flags & LOCK_DIE_ON_ERROR)
-			die("failed to prepare '%s' for appending", path);
-		close(orig_fd);
-		rollback_lock_file(lk);
-		errno = save_errno;
-		return -1;
-	} else {
-		close(orig_fd);
-	}
-	return fd;
-}
-
 FILE *fdopen_lock_file(struct lock_file *lk, const char *mode)
 {
 	if (!lk->active)
diff --git a/lockfile.h b/lockfile.h
index b4abc61..1373f5c 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -27,8 +27,8 @@
  *   soon as the object is used in any way, it is irrevocably
  *   registered in the lock_file_list, and on_list is set.
  *
- * - Locked, lockfile open (after hold_lock_file_for_update(),
- *   hold_lock_file_for_append(), or reopen_lock_file()). In this
+ * - Locked, lockfile open (after hold_lock_file_for_update()
+ *   or reopen_lock_file()). In this
  *   state:
  *   - the lockfile exists
  *   - active is set
@@ -85,9 +85,6 @@ static inline int hold_lock_file_for_update(
 	return hold_lock_file_for_update_timeout(lk, path, flags, 0);
 }
 
-extern int hold_lock_file_for_append(struct lock_file *lk, const char *path,
-				     int flags);
-
 extern FILE *fdopen_lock_file(struct lock_file *, const char *mode);
 extern char *get_locked_file_path(struct lock_file *);
 extern int commit_lock_file_to(struct lock_file *, const char *path);
-- 
2.5.0.414.g670f2a4
