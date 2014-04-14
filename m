From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 17/25] lockfile: avoid transitory invalid states
Date: Mon, 14 Apr 2014 15:54:47 +0200
Message-ID: <1397483695-10888-18-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:56:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhNM-00021R-2b
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232AbaDNN4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:56:23 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:63326 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755214AbaDNNzg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:36 -0400
X-AuditID: 12074414-f79d96d000002d2b-d2-534be8d7dd30
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id CF.53.11563.7D8EB435; Mon, 14 Apr 2014 09:55:35 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt09H010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:34 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqHv9hXewwb0F6hZdV7qZLBp6rzBb
	rPxZY3F7xXxmi1+Hn7Bb/GjpYbY486aR0aKz4yujA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh6L
	H3h5fN4k53H3/04mj9vPtrEEcERx2yQllpQFZ6bn6dslcGc83JBXMM+k4smcX0wNjB81uhg5
	OSQETCROnrrPBGGLSVy4t56ti5GLQ0jgMqPEljvrGCGck0wSr440s4NUsQnoSizqaQbrEBFQ
	k5jYdogFpIhZoJ1J4tCOXrCEsICzxOv/T1lBbBYBVYnJ7dfA4rwCrhKL569gh1gnJ3Hy2GSg
	Gg4OTqD4wg9ZIGEhAReJu1+msE5g5F3AyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdCLzez
	RC81pXQTIyQURXYwHjkpd4hRgINRiYe3Y453sBBrYllxZe4hRkkOJiVR3owbQCG+pPyUyozE
	4oz4otKc1OJDjBIczEoivK5bgXK8KYmVValF+TApaQ4WJXHeb4vV/YQE0hNLUrNTUwtSi2Cy
	MhwcShK8W58DNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDIiO+GBgbICkeoL1J
	IO28xQWJuUBRiNZTjIpS4rwlIAkBkERGaR7cWFiCecUoDvSlMO99kCoeYHKC634FNJgJaDBL
	O9jgkkSElFQDI8eJEk0ey7hlk10EdH7Ne3Q2Zv2nxH0Z8tNesnHcn33sx9EzK2PfzJwaob2h
	ffJc7QlPG2x3c6xZqNe7JepS0px/P94EzTkjX6lyf9f3OSl1HPsFA5ZuCj0nXvf2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246238>

Because remove_lock_file() can be called any time by the signal
handler, it is important that any lock_file objects that are in the
lock_file_list are always in a valid state.  And since lock_file
objects are often reused (but are never removed from lock_file_list),
that means we have to be careful whenever mutating a lock_file object
to always keep it in a well-defined state.

This was formerly not the case, because part of the state was recorded
by whether lk->filename was the empty string or a valid filename.  It
is wrong to assume that this string can be updated atomically; for
example, even

    strcpy(lk->filename, value)

is unsafe.  But the old code was even more reckless; for example,

    strcpy(lk->filename, path);
    if (!(flags & LOCK_NODEREF))
            resolve_symlink(lk->filename, max_path_len);
    strcat(lk->filename, ".lock");

During the call to resolve_symlink(), lk->filename contained the name
of the file that was being locked, not the name of the lockfile.  If a
signal would have been raised during that interval, then the signal
handler would have deleted the valuable file!

We could probably continue to use the filename field to encode the
state by being careful to write characters 1..N-1 of the filename
first, and then overwrite the NUL at filename[0] with the first
character of the filename, but that would be awkward and error-prone.

So, instead of using the filename field to determine whether the
lock_file object is active, add a new field "lock_file::active" for
this purpose.  Be careful to set this field only when filename really
contains the name of a file that should be deleted on cleanup.

Helped-by: Johannes Sixt <j.sixt@viscovery.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h    |  1 +
 lockfile.c | 45 +++++++++++++++++++++++++++++++++------------
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/cache.h b/cache.h
index 825cd0a..b7af173 100644
--- a/cache.h
+++ b/cache.h
@@ -539,6 +539,7 @@ extern int refresh_index(struct index_state *, unsigned int flags, const struct
 
 struct lock_file {
 	struct lock_file *next;
+	volatile sig_atomic_t active;
 	int fd;
 	pid_t owner;
 	char on_list;
diff --git a/lockfile.c b/lockfile.c
index 1453a7a..50a0541 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -27,11 +27,14 @@
  * Instead of (3), the change can be rolled back by deleting lockfile.
  *
  * This module keeps track of all locked files in lock_file_list.
- * When the first file is locked, it registers an atexit(3) handler;
- * when the program exits, the handler rolls back any files that have
- * been locked but were never committed or rolled back.
+ * When the first file is locked, it registers an atexit(3) handler
+ * and a signal handler; when the program exits, the handler rolls
+ * back any files that have been locked but were never committed or
+ * rolled back.
  *
- * A lock_file object can be in several states:
+ * Because the signal handler can be called at any time, a lock_file
+ * object must always be in a well-defined state.  The possible states
+ * are as follows:
  *
  * - Uninitialized.  In this state the object's on_list field must be
  *   zero but the rest of its contents need not be initialized.  As
@@ -39,18 +42,29 @@
  *   registered in the lock_file_list, and on_list is set.
  *
  * - Locked, lockfile open (after hold_lock_file_for_update() or
- *   hold_lock_file_for_append()).  In this state, the lockfile
- *   exists, filename holds the filename of the lockfile, fd holds a
- *   file descriptor open for writing to the lockfile, and owner holds
- *   the PID of the process that locked the file.
+ *   hold_lock_file_for_append()).  In this state:
+ *   - the lockfile exists
+ *   - active is set
+ *   - filename holds the filename of the lockfile
+ *   - fd holds a file descriptor open for writing to the lockfile
+ *   - owner holds the PID of the process that locked the file
  *
- * - Locked, lockfile closed (after close_lock_file()).  Same as the
- *   previous state, except that the lockfile is closed and fd is -1.
+ * - Locked, lockfile closed (after close_lock_file() or an
+ *   unsuccessful commit_lock_file()).  Same as the previous state,
+ *   except that the lockfile is closed and fd is -1.
  *
  * - Unlocked (after commit_lock_file(), rollback_lock_file(), or a
  *   failed attempt to lock).  In this state, filename[0] == '\0' and
  *   fd is -1.  The object is left registered in the lock_file_list,
  *   and on_list is set.
+ * - Unlocked (after rollback_lock_file(), a successful
+ *   commit_lock_file(), or a failed attempt to lock).  In this state:
+ *   - active is unset
+ *   - filename[0] == '\0' (usually, though there are transitory states
+ *     in which this condition doesn't hold)
+ *   - fd is -1
+ *   - the object is left registered in the lock_file_list, and
+ *     on_list is set.
  *
  * See Documentation/api-lockfile.txt for more information.
  */
@@ -183,9 +197,12 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		atexit(remove_lock_file);
 	}
 
+	assert(!lk->active);
+
 	if (!lk->on_list) {
 		/* Initialize *lk and add it to lock_file_list: */
 		lk->fd = -1;
+		lk->active = 0;
 		lk->owner = 0;
 		lk->on_list = 1;
 		lk->filename[0] = 0;
@@ -205,6 +222,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		return -1;
 	}
 	lk->owner = getpid();
+	lk->active = 1;
 	if (adjust_shared_perm(lk->filename)) {
 		error("cannot fix permission bits on %s", lk->filename);
 		rollback_lock_file(lk);
@@ -292,7 +310,7 @@ int commit_lock_file(struct lock_file *lk)
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
 
-	if (!lk->filename[0])
+	if (!lk->active)
 		die("BUG: attempt to commit unlocked object");
 
 	strcpy(result_file, lk->filename);
@@ -301,6 +319,7 @@ int commit_lock_file(struct lock_file *lk)
 
 	if (rename(lk->filename, result_file))
 		return -1;
+	lk->active = 0;
 	lk->filename[0] = 0;
 	return 0;
 }
@@ -325,6 +344,7 @@ int commit_locked_index(struct lock_file *lk)
 			return -1;
 		if (rename(lk->filename, alternate_index_output))
 			return -1;
+		lk->active = 0;
 		lk->filename[0] = 0;
 		return 0;
 	}
@@ -334,10 +354,11 @@ int commit_locked_index(struct lock_file *lk)
 
 void rollback_lock_file(struct lock_file *lk)
 {
-	if (lk->filename[0]) {
+	if (lk->active) {
 		if (lk->fd >= 0)
 			close_lock_file(lk);
 		unlink_or_warn(lk->filename);
+		lk->active = 0;
 		lk->filename[0] = 0;
 	}
 }
-- 
1.9.1
