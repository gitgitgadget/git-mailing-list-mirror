From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 23/35] lockfile: avoid transitory invalid states
Date: Tue, 16 Sep 2014 21:33:44 +0200
Message-ID: <1410896036-12750-24-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:35:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTyWm-0000Qt-E1
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170AbaIPTez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:34:55 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:53874 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754708AbaIPTev (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:34:51 -0400
X-AuditID: 12074414-f79446d000001f1d-1c-541890da95e0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 1F.EA.07965.AD098145; Tue, 16 Sep 2014 15:34:50 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcR001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:49 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsUixO6iqHtrgkSIwc4j5hZdV7qZLBp6rzBb
	PJl7l9ni9or5zBY/WnqYLf5NqLHo7PjK6MDu8ff9ByaPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b
	5DxuP9vGEsAexW2TlFhSFpyZnqdvl8CdsbthF0vBNYuK+Z9/sDQwrtTpYuTkkBAwkTh7+ysj
	hC0mceHeerYuRi4OIYHLjBL/bs5nh3BOMEmsbb/IBFLFJqArsainmQkkISLQxiix6+JmVhCH
	WaCbUeL9idNgVcICzhITzpxgBbFZBFQl2p+vZQGxeQVcJe43PILaJyexYfd/IJuDgxMo/nVf
	AYgpJOAicfCu3wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdC30cjNL9FJTSjcxQgJP
	ZAfjkZNyhxgFOBiVeHg9HomHCLEmlhVX5h5ilORgUhLl/dctESLEl5SfUpmRWJwRX1Sak1p8
	iFGCg1lJhPeHL1CONyWxsiq1KB8mJc3BoiTO+22xup+QQHpiSWp2ampBahFMVoaDQ0mCd14/
	UKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KDbii4HRAZLiAdq7GaSdt7ggMRco
	CtF6ilGXY13nt34mIZa8/LxUKXFeG5AiAZCijNI8uBWwNPOKURzoY2HeLSBVPMAUBTfpFdAS
	JqAlZ3vEQJaUJCKkpBoYF4Tzrnn7quDOy0tLF71Nm1S2NlXh5mX+A6GCfVM3clnl+WrHsiRO
	a/XoKDfZfyL5m+CMFvu4+8273x+4mRUsG/9mXYGP253pvp4huu580bdfJR7/7VVg 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257155>

Because remove_lock_file() can be called any time by the signal
handler, it is important that any lock_file objects that are in the
lock_file_list are always in a valid state.  And since lock_file
objects are often reused (but are never removed from lock_file_list),
that means we have to be careful whenever mutating a lock_file object
to always keep it in a well-defined state.

This was formerly not the case, because part of the state was encoded
by setting lk->filename to the empty string vs. a valid filename.  It
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
signal were raised during that interval, then the signal handler would
have deleted the valuable file!

We could probably continue to use the filename field to encode the
state by being careful to write characters 1..N-1 of the filename
first, and then overwrite the NUL at filename[0] with the first
character of the filename, but that would be awkward and error-prone.

So, instead of using the filename field to determine whether the
lock_file object is active, add a new field "lock_file::active" for
this purpose.  Be careful to set this field only when filename really
contains the name of a file that should be deleted on cleanup.

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h      |  1 +
 lockfile.c   | 47 ++++++++++++++++++++++++++++++++---------------
 read-cache.c |  1 +
 3 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/cache.h b/cache.h
index e4e7c56..a367220 100644
--- a/cache.h
+++ b/cache.h
@@ -576,6 +576,7 @@ extern int refresh_index(struct index_state *, unsigned int flags, const struct
 
 struct lock_file {
 	struct lock_file *next;
+	volatile sig_atomic_t active;
 	int fd;
 	pid_t owner;
 	char on_list;
diff --git a/lockfile.c b/lockfile.c
index 6ae5c84..55fbb41 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -27,16 +27,19 @@
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
  * A lock_file is owned by the process that created it. The lock_file
  * object has an "owner" field that records its owner. This field is
  * used to prevent a forked process from closing a lock_file of its
  * parent.
  *
- * A lock_file object can be in several states:
+ * Because the signal handler can be called at any time, a lock_file
+ * object must always be in a well-defined state.  The possible states
+ * are as follows:
  *
  * - Uninitialized.  In this state the object's on_list field must be
  *   zero but the rest of its contents need not be initialized.  As
@@ -44,19 +47,25 @@
  *   registered in the lock_file_list, and on_list is set.
  *
  * - Locked, lockfile open (after hold_lock_file_for_update(),
- *   hold_lock_file_for_append(), or reopen_lock_file()). In this
- *   state, the lockfile exists, filename holds the filename of the
- *   lockfile, fd holds a file descriptor open for writing to the
- *   lockfile, and owner holds the PID of the process that locked the
- *   file.
+ *   hold_lock_file_for_append(), or reopen_lock_file()).  In this
+ *   state:
+ *   - the lockfile exists
+ *   - active is set
+ *   - filename holds the filename of the lockfile
+ *   - fd holds a file descriptor open for writing to the lockfile
+ *   - owner holds the PID of the process that locked the file
  *
  * - Locked, lockfile closed (after close_lock_file()).  Same as the
  *   previous state, except that the lockfile is closed and fd is -1.
  *
  * - Unlocked (after commit_lock_file(), rollback_lock_file(), or a
- *   failed attempt to lock).  In this state, filename[0] == '\0' and
- *   fd is -1.  The object is left registered in the lock_file_list,
- *   and on_list is set.
+ *   failed attempt to lock).  In this state:
+ *   - active is unset
+ *   - filename[0] == '\0' (usually, though there are transitory states
+ *     in which this condition doesn't hold)
+ *   - fd is -1
+ *   - the object is left registered in the lock_file_list, and
+ *     on_list is set.
  *
  * See Documentation/api-lockfile.txt for more information.
  */
@@ -189,9 +198,14 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		atexit(remove_lock_file);
 	}
 
+	if (lk->active)
+		die("BUG: lock_file(\"%s\") called with an active lock_file object",
+		    path);
+
 	if (!lk->on_list) {
 		/* Initialize *lk and add it to lock_file_list: */
 		lk->fd = -1;
+		lk->active = 0;
 		lk->owner = 0;
 		lk->on_list = 1;
 		lk->filename[0] = 0;
@@ -213,6 +227,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		return -1;
 	}
 	lk->owner = getpid();
+	lk->active = 1;
 	if (adjust_shared_perm(lk->filename)) {
 		int save_errno = errno;
 		error("cannot fix permission bits on %s", lk->filename);
@@ -302,7 +317,7 @@ int reopen_lock_file(struct lock_file *lk)
 {
 	if (0 <= lk->fd)
 		die(_("BUG: reopen a lockfile that is still open"));
-	if (!lk->filename[0])
+	if (!lk->active)
 		die(_("BUG: reopen a lockfile that has been committed"));
 	lk->fd = open(lk->filename, O_WRONLY);
 	return lk->fd;
@@ -313,7 +328,7 @@ int commit_lock_file(struct lock_file *lk)
 	char result_file[PATH_MAX];
 	int save_errno;
 
-	if (!lk->filename[0])
+	if (!lk->active)
 		die("BUG: attempt to commit unlocked object");
 
 	if (lk->fd >= 0 && close_lock_file(lk))
@@ -326,6 +341,7 @@ int commit_lock_file(struct lock_file *lk)
 	if (rename(lk->filename, result_file))
 		goto rollback;
 
+	lk->active = 0;
 	lk->filename[0] = 0;
 	return 0;
 
@@ -346,11 +362,12 @@ int hold_locked_index(struct lock_file *lk, int die_on_error)
 
 void rollback_lock_file(struct lock_file *lk)
 {
-	if (!lk->filename[0])
+	if (!lk->active)
 		return;
 
 	if (lk->fd >= 0)
 		close_lock_file(lk);
 	unlink_or_warn(lk->filename);
+	lk->active = 0;
 	lk->filename[0] = 0;
 }
diff --git a/read-cache.c b/read-cache.c
index b5917e0..e64bc87 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2028,6 +2028,7 @@ static int commit_locked_index(struct lock_file *lk)
 			return -1;
 		if (rename(lk->filename, alternate_index_output))
 			return -1;
+		lk->active = 0;
 		lk->filename[0] = 0;
 		return 0;
 	} else {
-- 
2.1.0
