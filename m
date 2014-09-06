From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 23/32] lockfile: avoid transitory invalid states
Date: Sat,  6 Sep 2014 09:50:37 +0200
Message-ID: <1409989846-22401-24-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 10:00:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAuo-0005XB-9Q
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 10:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbaIFIAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 04:00:06 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:64348 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751526AbaIFIAE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 04:00:04 -0400
X-AuditID: 12074412-f792e6d000005517-7b-540abd3e16a9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id D0.9E.21783.E3DBA045; Sat,  6 Sep 2014 03:52:30 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFHM006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:29 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixO6iqGu3lyvE4OQFS4uuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujHurOApmmVV8PHqctYFxl1YXIyeHhICJxO6DTewQtpjEhXvr2boY
	uTiEBC4zSuze/BzKOcYk8XbNTkaQKjYBXYlFPc1MIAkRgTZGiV0XN7OCJJgFUiQ6nneDFQkL
	OEs8O3+ZCcRmEVCVuH5lORuIzSvgKvGhdwMTxDo5iQ27/4PVcwLFpzd1gtlCAi4S7Sf7mSYw
	8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuml5tZopeaUrqJERJoQjsY15+UO8QowMGo
	xMNb4MAVIsSaWFZcmXuIUZKDSUmUN285UIgvKT+lMiOxOCO+qDQntfgQowQHs5IIb8dkoBxv
	SmJlVWpRPkxKmoNFSZz352J1PyGB9MSS1OzU1ILUIpisDAeHkgSvyx6gRsGi1PTUirTMnBKE
	NBMHJ8hwLimR4tS8lNSixNKSjHhQbMQXA6MDJMUDtJcVpJ23uCAxFygK0XqKUZdjXee3fiYh
	lrz8vFQpcV4mkCIBkKKM0jy4FbC08opRHOhjYV4xkCoeYEqCm/QKaAkT0BLzdE6QJSWJCCmp
	BkaJ2W/0DkZqZy+8t4SVT/vd98OST1hn317arr7CSE3qfZpOJsOlsxLhf4/pdC+cylOaKhjw
	reP+f/cbURHKcWauDQ/71jh8UzjdbsKmMzXybdVVwyi/RfurBWfUum78K/CTr1zW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256582>

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
 lockfile.c   | 45 ++++++++++++++++++++++++++++++---------------
 read-cache.c |  1 +
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/cache.h b/cache.h
index 41d829b..e739482 100644
--- a/cache.h
+++ b/cache.h
@@ -575,6 +575,7 @@ extern int refresh_index(struct index_state *, unsigned int flags, const struct
 
 struct lock_file {
 	struct lock_file *next;
+	volatile sig_atomic_t active;
 	int fd;
 	pid_t owner;
 	char on_list;
diff --git a/lockfile.c b/lockfile.c
index a7cdb64..920585d 100644
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
@@ -39,19 +42,25 @@
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
@@ -184,9 +193,12 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
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
@@ -208,6 +220,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		return -1;
 	}
 	lk->owner = getpid();
+	lk->active = 1;
 	if (adjust_shared_perm(lk->filename)) {
 		int save_errno = errno;
 		error("cannot fix permission bits on %s", lk->filename);
@@ -297,7 +310,7 @@ int reopen_lock_file(struct lock_file *lk)
 {
 	if (0 <= lk->fd)
 		die(_("BUG: reopen a lockfile that is still open"));
-	if (!lk->filename[0])
+	if (!lk->active)
 		die(_("BUG: reopen a lockfile that has been committed"));
 	lk->fd = open(lk->filename, O_WRONLY);
 	return lk->fd;
@@ -308,7 +321,7 @@ int commit_lock_file(struct lock_file *lk)
 	char result_file[PATH_MAX];
 	int save_errno;
 
-	if (!lk->filename[0])
+	if (!lk->active)
 		die("BUG: attempt to commit unlocked object");
 
 	if (lk->fd >= 0 && close_lock_file(lk))
@@ -321,6 +334,7 @@ int commit_lock_file(struct lock_file *lk)
 	if (rename(lk->filename, result_file))
 		goto rollback;
 
+	lk->active = 0;
 	lk->filename[0] = 0;
 	return 0;
 
@@ -341,11 +355,12 @@ int hold_locked_index(struct lock_file *lk, int die_on_error)
 
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
index 5d3c8bd..3d43dda 100644
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
