From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 33/39] Extract a function commit_lock_file_to()
Date: Fri, 26 Sep 2014 12:08:33 +0200
Message-ID: <1411726119-31598-34-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:17:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSag-0003Kt-3d
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756537AbaIZKRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:17:14 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:56890 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755969AbaIZKRM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:17:12 -0400
X-AuditID: 1207440f-f79156d000006a5c-a0-54253b682d4a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id A7.ED.27228.86B35245; Fri, 26 Sep 2014 06:09:44 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lMI013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:42 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1M2wVg0x2Laew6LrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7ox9jxvYC+Y6VMx7W9/AeNKki5GT
	Q0LAROLtww1MELaYxIV769m6GLk4hAQuM0rsXXeSCcLZxCRxcf5WZpAqNgFdiUU9zWAdIgJq
	EhPbDrGAFDELLGaSmHBoExtIQljASWLdsUZ2EJtFQFVi7td7jCA2r4CrxIbzS9gg1slJbNj9
	HyzOCRRv3H4NzBYScJFoWT+ZZQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuiZ6uZkl
	eqkppZsYIcHIv4Oxa73MIUYBDkYlHt4b61RChFgTy4orcw8xSnIwKYnyfrFQDRHiS8pPqcxI
	LM6ILyrNSS0+xCjBwawkwnvHCCjHm5JYWZValA+TkuZgURLnVV+i7ickkJ5YkpqdmlqQWgST
	leHgUJLgtbICahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHxUZ8MTA6QFI8QHu5
	QNp5iwsSc4GiEK2nGHU51nV+62cSYsnLz0uVEuc9YglUJABSlFGaB7cClnpeMYoDfSzMKwIy
	igeYtuAmvQJawgS0ROmIMsiSkkSElFQD47oL8+TtGC3cuOaeu/JcuTP349VTf6d27k1cLh3+
	x7NThiNlarr/s/5D3yM/nU1LnnHm6sNJx+Jn3jEXCg2s33Ji9ZutJ/d4GiclthrM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257540>

commit_locked_index(), when writing to an alternate index file,
duplicates (poorly) the code in commit_lock_file(). And anyway, it
shouldn't have to know so much about the internal workings of lockfile
objects. So extract a new function commit_lock_file_to() that does the
work common to the two functions, and call it from both
commit_lock_file() and commit_locked_index().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-lockfile.txt | 36 ++++++++++++++++------------
 cache.h                                  |  1 +
 lockfile.c                               | 40 +++++++++++++++++++++-----------
 read-cache.c                             | 13 +++--------
 4 files changed, 51 insertions(+), 39 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index d7882df..0b8db64 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -48,14 +48,14 @@ The caller:
 When finished writing, the caller can:
 
 * Close the file descriptor and rename the lockfile to its final
-  destination by calling `commit_lock_file`.
+  destination by calling `commit_lock_file` or `commit_lock_file_to`.
 
 * Close the file descriptor and remove the lockfile by calling
   `rollback_lock_file`.
 
 * Close the file descriptor without removing or renaming the lockfile
-  by calling `close_lock_file`, and later call `commit_lock_file` or
-  `rollback_lock_file`.
+  by calling `close_lock_file`, and later call `commit_lock_file`,
+  `commit_lock_file_to`, or `rollback_lock_file`.
 
 At this point, the `lock_file` object must not be freed or altered,
 because it is still registered in the `lock_file_list`. However, it
@@ -63,20 +63,19 @@ may be reused; just pass it to another call of
 `hold_lock_file_for_update` or `hold_lock_file_for_append`.
 
 If the program exits before you have called one of `commit_lock_file`,
-`rollback_lock_file`, or `close_lock_file`, an `atexit(3)` handler
-will close and remove the lockfile, essentially rolling back any
-uncommitted changes.
+`commit_lock_file_to`, `rollback_lock_file`, or `close_lock_file`, an
+`atexit(3)` handler will close and remove the lockfile, essentially
+rolling back any uncommitted changes.
 
 If you need to close the file descriptor you obtained from a
 `hold_lock_file_*` function yourself, do so by calling
 `close_lock_file`. You should never call `close(2)` yourself!
 Otherwise the `struct lock_file` structure would still think that the
-file descriptor needs to be closed, and a later call to
-`commit_lock_file` or `rollback_lock_file` or program exit would
+file descriptor needs to be closed, and a commit or rollback would
 result in duplicate calls to `close(2)`. Worse yet, if you `close(2)`
 and then later open another file descriptor for a completely different
-purpose, then a call to `commit_lock_file` or `rollback_lock_file`
-might close that unrelated file descriptor.
+purpose, then a commit or rollback might close that unrelated file
+descriptor.
 
 
 Error handling
@@ -99,9 +98,9 @@ unable_to_lock_die::
 
 	Emit an appropriate error message and `die()`.
 
-Similarly, `commit_lock_file` and `close_lock_file` return 0 on
-success. On failure they set `errno` appropriately, do their best to
-roll back the lockfile, and return -1.
+Similarly, `commit_lock_file`, `commit_lock_file_to`, and
+`close_lock_file` return 0 on success. On failure they set `errno`
+appropriately, do their best to roll back the lockfile, and return -1.
 
 
 Flags
@@ -155,6 +154,12 @@ commit_lock_file::
 	`commit_lock_file` for a `lock_file` object that is not
 	currently locked.
 
+commit_lock_file_to::
+
+	Like `commit_lock_file()`, except that it takes an explicit
+	`path` argument to which the lockfile should be renamed. The
+	`path` must be on the same filesystem as the lock file.
+
 rollback_lock_file::
 
 	Take a pointer to the `struct lock_file` initialized with an
@@ -171,5 +176,6 @@ close_lock_file::
 	`hold_lock_file_for_append`, and close the file descriptor.
 	Return 0 upon success. On failure to `close(2)`, return a
 	negative value and roll back the lock file. Usually
-	`commit_lock_file` or `rollback_lock_file` should eventually
-	be called if `close_lock_file` succeeds.
+	`commit_lock_file`, `commit_lock_file_to`, or
+	`rollback_lock_file` should eventually be called if
+	`close_lock_file` succeeds.
diff --git a/cache.h b/cache.h
index 433fae5..30883b3 100644
--- a/cache.h
+++ b/cache.h
@@ -590,6 +590,7 @@ extern void unable_to_lock_message(const char *path, int err,
 extern NORETURN void unable_to_lock_die(const char *path, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
+extern int commit_lock_file_to(struct lock_file *, const char *path);
 extern int commit_lock_file(struct lock_file *);
 extern int reopen_lock_file(struct lock_file *);
 extern void update_index_if_able(struct index_state *, struct lock_file *);
diff --git a/lockfile.c b/lockfile.c
index 56ad7e8..cf7f4d0 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -43,9 +43,9 @@
  *   Same as the previous state, except that the lockfile is closed
  *   and fd is -1.
  *
- * - Unlocked (after commit_lock_file(), rollback_lock_file(), a
- *   failed attempt to lock, or a failed close_lock_file()).  In this
- *   state:
+ * - Unlocked (after commit_lock_file(), commit_lock_file_to(),
+ *   rollback_lock_file(), a failed attempt to lock, or a failed
+ *   close_lock_file()).  In this state:
  *   - active is unset
  *   - filename is empty (usually, though there are transitory
  *     states in which this condition doesn't hold). Client code should
@@ -284,23 +284,15 @@ int reopen_lock_file(struct lock_file *lk)
 	return lk->fd;
 }
 
-int commit_lock_file(struct lock_file *lk)
+int commit_lock_file_to(struct lock_file *lk, const char *path)
 {
-	static struct strbuf result_file = STRBUF_INIT;
-	int err;
-
 	if (!lk->active)
-		die("BUG: attempt to commit unlocked object");
+		die("BUG: attempt to commit unlocked object to \"%s\"", path);
 
 	if (close_lock_file(lk))
 		return -1;
 
-	/* remove ".lock": */
-	strbuf_add(&result_file, lk->filename.buf,
-		   lk->filename.len - LOCK_SUFFIX_LEN);
-	err = rename(lk->filename.buf, result_file.buf);
-	strbuf_reset(&result_file);
-	if (err) {
+	if (rename(lk->filename.buf, path)) {
 		int save_errno = errno;
 		rollback_lock_file(lk);
 		errno = save_errno;
@@ -312,6 +304,26 @@ int commit_lock_file(struct lock_file *lk)
 	return 0;
 }
 
+int commit_lock_file(struct lock_file *lk)
+{
+	static struct strbuf result_file = STRBUF_INIT;
+	int err;
+
+	if (!lk->active)
+		die("BUG: attempt to commit unlocked object");
+
+	if (lk->filename.len <= LOCK_SUFFIX_LEN ||
+	    strcmp(lk->filename.buf + lk->filename.len - LOCK_SUFFIX_LEN, LOCK_SUFFIX))
+		die("BUG: lockfile filename corrupt");
+
+	/* remove ".lock": */
+	strbuf_add(&result_file, lk->filename.buf,
+		   lk->filename.len - LOCK_SUFFIX_LEN);
+	err = commit_lock_file_to(lk, result_file.buf);
+	strbuf_reset(&result_file);
+	return err;
+}
+
 int hold_locked_index(struct lock_file *lk, int die_on_error)
 {
 	return hold_lock_file_for_update(lk, get_index_file(),
diff --git a/read-cache.c b/read-cache.c
index 91bf876..e887e23 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2041,17 +2041,10 @@ void set_alternate_index_output(const char *name)
 
 static int commit_locked_index(struct lock_file *lk)
 {
-	if (alternate_index_output) {
-		if (close_lock_file(lk))
-			return -1;
-		if (rename(lk->filename.buf, alternate_index_output))
-			return -1;
-		lk->active = 0;
-		strbuf_reset(&lk->filename);
-		return 0;
-	} else {
+	if (alternate_index_output)
+		return commit_lock_file_to(lk, alternate_index_output);
+	else
 		return commit_lock_file(lk);
-	}
 }
 
 static int do_write_locked_index(struct index_state *istate, struct lock_file *lock,
-- 
2.1.0
