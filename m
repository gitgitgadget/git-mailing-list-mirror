From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 18/25] lockfile: avoid transitory invalid states
Date: Mon,  7 Apr 2014 01:34:00 +0200
Message-ID: <1396827247-28465-19-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:36:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwc4-00074B-J4
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706AbaDFXgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:36:08 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:62009 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754651AbaDFXfR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:35:17 -0400
X-AuditID: 12074412-f79d46d000002e58-c2-5341e4b4bb75
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 67.8D.11864.4B4E1435; Sun,  6 Apr 2014 19:35:16 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbX5011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:35:15 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqLvliWOwwZQLOhZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO+Pl05fMBd9MK/pOZjcwXtLqYuTgkBAwkTgz17OL
	kRPIFJO4cG89WxcjF4eQwGVGiSP9+1khnONMEqcPNTCCVLEJ6Eos6mlmArFFBNQkJrYdYgEp
	Yha4wSjxbt9hFpCEsICzxPTebmYQm0VAVWLBpQVsIDavgKvEkiuzGCHWyUmcPDaZFcTmBIqv
	mzwXrFdIwAVozj22CYy8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmunlZpbopaaUbmKE
	BJ7QDsb1J+UOMQpwMCrx8K445BgsxJpYVlyZe4hRkoNJSZTX8h5QiC8pP6UyI7E4I76oNCe1
	+BCjBAezkgjvgRtAOd6UxMqq1KJ8mJQ0B4uSOO/Pxep+QgLpiSWp2ampBalFMFkZDg4lCd6+
	x0CNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aDIiC8GxgZIigdobwRIO29xQWIu
	UBSi9RSjopQ478xHQAkBkERGaR7cWFg6ecUoDvSlMK8BSDsPMBXBdb8CGswENLghzA5kcEki
	QkqqgVFy+4p5qx4mCK2Y7+bnb/J7Q0/I56dTmhMW82ZfddZ4Uzvxys8s3t08hzccvvBkkXzz
	zbe+v170f7tx7LVs3dPu/PL1/TlfvHc/qKhi47N6l1N38be/z4Pm5G0GYayt+ds6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245817>

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

So, instead of encoding part of the lock_file state in the filename
field, add a new bit "LOCK_FLAGS_LOCKFILE_ACTIVE" to flags, and use
this bit to distinguish between a lock_file object that is active
vs. one that is inactive.  Be careful to set this bit only when
filename really contains the name of a file that should be deleted on
cleanup.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 55 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 24aaa53..b955cca 100644
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
  * - Uninitialized.  In this state the object's flags field must be
  *   zero but the rest of its contents need not be initialized.  As
@@ -40,18 +43,25 @@
  *   is set.
  *
  * - Locked, lockfile open (after hold_lock_file_for_update() or
- *   hold_lock_file_for_append()).  In this state, the lockfile
- *   exists, filename holds the filename of the lockfile, fd holds a
- *   file descriptor open for writing to the lockfile, and owner holds
- *   the PID of the process that locked the file.
+ *   hold_lock_file_for_append()).  In this state:
+ *   - the lockfile exists
+ *   - flags & LOCK_FLAGS_LOCKFILE_ACTIVE is set
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
- * - Unlocked (after commit_lock_file(), rollback_lock_file(), or a
- *   failed attempt to lock).  In this state, filename[0] == '\0' and
- *   fd is -1.  The object is left registered in the lock_file_list,
- *   and flags & LOCK_FLAGS_ON_LIST is set.
+ * - Unlocked (after rollback_lock_file(), a successful
+ *   commit_lock_file(), or a failed attempt to lock).  In this state:
+ *   - flags & LOCK_FLAGS_LOCKFILE_ACTIVE is unset
+ *   - filename[0] == '\0' (usually, though there are transitory states
+ *     in which this condition doesn't hold)
+ *   - fd is -1
+ *   - the object is left registered in the lock_file_list,
+ *     and flags & LOCK_FLAGS_ON_LIST is set.
  *
  * See Documentation/api-lockfile.txt for more information.
  */
@@ -61,6 +71,13 @@
 /* This lock_file instance is in the lock_file_list */
 #define LOCK_FLAGS_ON_LIST 0x01
 
+/*
+ * The filename field points at an active lockfile (i.e., a file that
+ * needs to be deleted if the process dies)
+ */
+#define LOCK_FLAGS_LOCKFILE_ACTIVE 0x02
+
+
 static struct lock_file *lock_file_list;
 static const char *alternate_index_output;
 
@@ -192,6 +209,8 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		atexit(remove_lock_file);
 	}
 
+	assert(!(lk->flags & LOCK_FLAGS_LOCKFILE_ACTIVE));
+
 	if (!(lk->flags & LOCK_FLAGS_ON_LIST)) {
 		/* Initialize *lk and add it to lock_file_list: */
 		lk->fd = -1;
@@ -214,6 +233,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		return -1;
 	}
 	lk->owner = getpid();
+	lk->flags |= LOCK_FLAGS_LOCKFILE_ACTIVE;
 	if (adjust_shared_perm(lk->filename)) {
 		error("cannot fix permission bits on %s", lk->filename);
 		rollback_lock_file(lk);
@@ -301,7 +321,7 @@ int commit_lock_file(struct lock_file *lk)
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
 
-	if (!lk->filename[0])
+	if (!(lk->flags & LOCK_FLAGS_LOCKFILE_ACTIVE))
 		return 0;
 
 	strcpy(result_file, lk->filename);
@@ -310,6 +330,7 @@ int commit_lock_file(struct lock_file *lk)
 
 	if (rename(lk->filename, result_file))
 		return -1;
+	lk->flags &= ~LOCK_FLAGS_LOCKFILE_ACTIVE;
 	lk->filename[0] = 0;
 	return 0;
 }
@@ -334,6 +355,7 @@ int commit_locked_index(struct lock_file *lk)
 			return -1;
 		if (rename(lk->filename, alternate_index_output))
 			return -1;
+		lk->flags &= ~LOCK_FLAGS_LOCKFILE_ACTIVE;
 		lk->filename[0] = 0;
 		return 0;
 	}
@@ -343,10 +365,11 @@ int commit_locked_index(struct lock_file *lk)
 
 void rollback_lock_file(struct lock_file *lk)
 {
-	if (lk->filename[0]) {
+	if (lk->flags & LOCK_FLAGS_LOCKFILE_ACTIVE) {
 		if (lk->fd >= 0)
 			close_lock_file(lk);
 		unlink_or_warn(lk->filename);
+		lk->flags &= ~LOCK_FLAGS_LOCKFILE_ACTIVE;
 		lk->filename[0] = 0;
 	}
 }
-- 
1.9.1
