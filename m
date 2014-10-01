From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 32/38] Extract a function commit_lock_file_to()
Date: Wed,  1 Oct 2014 12:28:36 +0200
Message-ID: <1412159322-2622-33-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:30:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHAf-0002vs-EW
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbaJAK3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:49 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42567 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751743AbaJAK3o (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:44 -0400
X-AuditID: 12074414-f79446d000001f1d-a0-542bd7982174
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id E8.61.07965.897DB245; Wed,  1 Oct 2014 06:29:44 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6V026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:42 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1J1xXTvE4OcWSYuuK91MFg29V5gt
	nsy9y2zx9uYSRovbK+YzW/xo6WG2+DehxqKz4yujA4fH3/cfmDx2zrrL7rFgU6nHw1dd7B7P
	evcwely8pOzxeZOcx+1n21gCOKK4bZISS8qCM9Pz9O0SuDPO3d/KWtDgUNHz9TxbA+Nqky5G
	Tg4JAROJmzdvM0PYYhIX7q1n62Lk4hASuMwocXjZZnYI5ziTxLr7Z5lAqtgEdCUW9TSD2SIC
	ahIT2w6xgBQxCyxmkphwaBMbSEJYwEnid/NPsCIWAVWJ9u2X2UFsXgEXiYb9p1kg1slJbNj9
	nxHE5gSKL7/cDBYXEnCW2HHnK9MERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt9HIz
	S/RSU0o3MULCUWQH45GTcocYBTgYlXh4FRK0Q4RYE8uKK3MPMUpyMCmJ8i66BBTiS8pPqcxI
	LM6ILyrNSS0+xCjBwawkwpt9ACjHm5JYWZValA+TkuZgURLn/bZY3U9IID2xJDU7NbUgtQgm
	K8PBoSTBy3ANqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFB3xxcD4AEnxAO11
	BmnnLS5IzAWKQrSeYtTlWNf5rZ9JiCUvPy9VSpw3E6RIAKQoozQPbgUs+bxiFAf6WJg3HKSK
	B5i44Ca9AlrCBLQkeQ3YkpJEhJRUA2NcrPd1manux2fxHtBZsF3F/n/HNB9F+w2rN+yu538n
	ffyP2oIdcoVylzSju4XLtluntsz5c57/aYitj2fSwcsdy5dH8M+NDH7QO/XOrhw9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257722>

commit_locked_index(), when writing to an alternate index file,
duplicates (poorly) the code in commit_lock_file(). And anyway, it
shouldn't have to know so much about the internal workings of lockfile
objects. So extract a new function commit_lock_file_to() that does the
work common to the two functions, and call it from both
commit_lock_file() and commit_locked_index().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-lockfile.txt | 34 ++++++++++++++++-----------
 cache.h                                  |  1 +
 lockfile.c                               | 40 +++++++++++++++++++++-----------
 read-cache.c                             | 13 +++--------
 4 files changed, 50 insertions(+), 38 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index 9805da0..aa7d822 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -49,14 +49,14 @@ The caller:
 When finished writing, the caller can:
 
 * Close the file descriptor and rename the lockfile to its final
-  destination by calling `commit_lock_file`.
+  destination by calling `commit_lock_file` or `commit_lock_file_to`.
 
 * Close the file descriptor and remove the lockfile by calling
   `rollback_lock_file`.
 
 * Close the file descriptor without removing or renaming the lockfile
   by calling `close_lock_file`, and later call `commit_lock_file`,
-  `rollback_lock_file`, or `reopen_lock_file`.
+  `commit_lock_file_to`, `rollback_lock_file`, or `reopen_lock_file`.
 
 Even after the lockfile is committed or rolled back, the `lock_file`
 object must not be freed or altered by the caller. However, it may be
@@ -64,20 +64,19 @@ reused; just pass it to another call of `hold_lock_file_for_update` or
 `hold_lock_file_for_append`.
 
 If the program exits before you have called one of `commit_lock_file`,
-`rollback_lock_file`, or `close_lock_file`, an `atexit(3)` handler
-will close and remove the lockfile, rolling back any uncommitted
-changes.
+`commit_lock_file_to`, `rollback_lock_file`, or `close_lock_file`, an
+`atexit(3)` handler will close and remove the lockfile, rolling back
+any uncommitted changes.
 
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
@@ -100,9 +99,9 @@ unable_to_lock_die::
 
 	Emit an appropriate error message and `die()`.
 
-Similarly, `commit_lock_file` and `close_lock_file` return 0 on
-success. On failure they set `errno` appropriately, do their best to
-roll back the lockfile, and return -1.
+Similarly, `commit_lock_file`, `commit_lock_file_to`, and
+`close_lock_file` return 0 on success. On failure they set `errno`
+appropriately, do their best to roll back the lockfile, and return -1.
 
 
 Flags
@@ -156,6 +155,12 @@ commit_lock_file::
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
@@ -172,8 +177,9 @@ close_lock_file::
 	`hold_lock_file_for_append`, and close the file descriptor.
 	Return 0 upon success. On failure to `close(2)`, return a
 	negative value and roll back the lock file. Usually
-	`commit_lock_file` or `rollback_lock_file` should eventually
-	be called if `close_lock_file` succeeds.
+	`commit_lock_file`, `commit_lock_file_to`, or
+	`rollback_lock_file` should eventually be called if
+	`close_lock_file` succeeds.
 
 reopen_lock_file::
 
diff --git a/cache.h b/cache.h
index f81d95f..414e93c 100644
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
