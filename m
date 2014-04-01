From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 22/22] lockfile: allow new file contents to be written while retaining lock
Date: Tue,  1 Apr 2014 17:58:30 +0200
Message-ID: <1396367910-7299-23-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 17:59:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV15t-0006X1-3l
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 17:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbaDAP7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 11:59:18 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:54282 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751822AbaDAP7L (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:59:11 -0400
X-AuditID: 12074412-f79d46d000002e58-5d-533ae24e56e1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 44.4C.11864.E42EA335; Tue,  1 Apr 2014 11:59:10 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWbQ027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:59:09 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqOv3yCrY4FunnEXXlW4mi4beK8wW
	t1fMZ7b4dfgJu8WPlh5mB1aPv+8/MHnsnHWX3eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M7Yta6DvWB2UsWB/f8YGxj/+ncxcnJICJhINH97yQhhi0lcuLeerYuRi0NI4DKjxJGF
	jxkhnGNMEsu33WABqWIT0JVY1NPMBGKLCKhJTGw7BBZnFkiRePV3F5gtLBAtsfbkQXYQm0VA
	VWLyiRZWEJtXwEXie+stqG1yElN+LwCr4QSKX3qwB6xGSMBZ4vSbxcwTGHkXMDKsYpRLzCnN
	1c1NzMwpTk3WLU5OzMtLLdI108vNLNFLTSndxAgJKqEdjOtPyh1iFOBgVOLhPXDeKliINbGs
	uDL3EKMkB5OSKO+Pu0AhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIryzbgLleFMSK6tSi/JhUtIc
	LErivD8Xq/sJCaQnlqRmp6YWpBbBZGU4OJQkeOUfAjUKFqWmp1akZeaUIKSZODhBhnNJiRSn
	5qWkFiWWlmTEg2IjvhgYHSApHqC9iiDtvMUFiblAUYjWU4yKUuK8LA+AEgIgiYzSPLixsFTx
	ilEc6EthXl2Qdh5gmoHrfgU0mAloMPc6sMEliQgpqQbGffGWepcXxd4JOXkgdop01pLyxLd1
	UWy6um+dDt1NF73TqGZeJe3XsKG0pHBvOasu6x3j32vns2wNquFp4M4VOi66qEuoxe1ayOe4
	lut11iwMVxM3dPneCJ/+K/JVC+feGREyfC7se3e/Klglc17ahINxs11Lt/Fj66bW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245596>

Add a new option flag, LOCK_SEPARATE_STAGING_FILE, that can be passed
to hold_lock_file_for_update() or hold_lock_file_for_append() to use a
staging file that is independent of the lock file.

Add a new function activate_staging_file() that activates the contents
that have been written to the staging file without releasing the lock.

This functionality can be used to ensure that changes to two files are
seen by other processes in one order even if correctness requires the
locks to be released in another order.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-lockfile.txt |  54 ++++++++----
 cache.h                                  |   4 +
 lockfile.c                               | 140 ++++++++++++++++++++++++++-----
 3 files changed, 162 insertions(+), 36 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index 95ed03b..06b49f9 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -43,6 +43,13 @@ LOCK_DIE_ON_ERROR::
 	If a lock is already taken for the file, `die()` with an error
 	message.  If this option is not specified, return a negative
 	integer to the caller on failure.
+
+LOCK_SEPARATE_STAGING_FILE::
+
+	Use a separate file (not the lockfile) for staging the new
+	file contents.  This option makes it possible to call
+	activate_staging_file() to overwrite the old file while
+	retaining the file lock.
 --
 
 hold_lock_file_for_append::
@@ -64,23 +71,39 @@ unable_to_lock_index_die::
 
 commit_lock_file::
 
-	Take a pointer to the `struct lock_file` initialized
-	with an earlier call to `hold_lock_file_for_update()`,
-	close the file descriptor and rename the lockfile to its
-	final destination.  Returns 0 upon success, a negative
-	value on failure to close(2) or rename(2).
+	Take a pointer to the `struct lock_file` initialized with an
+	earlier call to `hold_lock_file_for_update()` or
+	`hold_lock_file_for_append()`.  Close the file descriptor.
+	Then, if the lock was created with the
+	LOCK_SEPARATE_STAGING_FILE flag, rename the staging file on
+	top of the locked file (if `activate_staging_file()` hasn't
+	already been called) and delete the lockfile; otherwise,
+	rename the lockfile to its final destination.  Returns 0 upon
+	success, a negative value on failure to close(2) or rename(2).
+
+activate_staging_file::
+
+	Write the contents of the separate staging file over those of
+	the locked file while retaining the lock.  This function may
+	only be called if the lock was created with the
+	LOCK_SEPARATE_STAGING_FILE flag.
 
 rollback_lock_file::
 
-	Take a pointer to the `struct lock_file` initialized
-	with an earlier call to `hold_lock_file_for_update()`,
-	close the file descriptor and remove the lockfile.
+	Take a pointer to the `struct lock_file` initialized with an
+	earlier call to `hold_lock_file_for_update()`, close the file
+	descriptor, remove the separate staging file (if any), and
+	remove the lockfile.  Please note that if
+	`activate_staging_file()` has already been called, then the
+	contents committed at that time will remain active.
 
 close_lock_file::
 	Take a pointer to the `struct lock_file` initialized
 	with an earlier call to `hold_lock_file_for_update()`,
 	and close the file descriptor.  Returns 0 upon success,
-	a negative value on failure to close(2).
+	a negative value on failure to close(2).  This function must
+	only be called if the lock was created without the
+	LOCK_SEPARATE_STAGING_FILE flag.
 
 Because the structure is used in an `atexit(3)` handler, its
 storage has to stay throughout the life of the program.  It
@@ -94,11 +117,10 @@ will close and remove the lockfile.
 If you need to close the file descriptor you obtained from
 `hold_lock_file_for_update` function yourself, do so by calling
 `close_lock_file()`.  You should never call `close(2)` yourself!
-Otherwise the `struct
-lock_file` structure still remembers that the file descriptor
-needs to be closed, and a later call to `commit_lock_file()` or
-`rollback_lock_file()` will result in duplicate calls to
-`close(2)`.  Worse yet, if you `close(2)`, open another file
-descriptor for completely different purpose, and then call
-`commit_lock_file()` or `rollback_lock_file()`, they may close
+Otherwise the `struct lock_file` structure still remembers that the
+file descriptor needs to be closed, and a later call to
+`commit_lock_file()` or `rollback_lock_file()` will result in
+duplicate calls to `close(2)`.  Worse yet, if you `close(2)`, open
+another file descriptor for completely different purpose, and then
+call `commit_lock_file()` or `rollback_lock_file()`, they may close
 that unrelated file descriptor.
diff --git a/cache.h b/cache.h
index 3b9dbd4..50fdc68 100644
--- a/cache.h
+++ b/cache.h
@@ -541,12 +541,16 @@ struct lock_file {
 	struct strbuf filename;
 	struct strbuf staging_filename;
 };
+
 #define LOCK_DIE_ON_ERROR 1
 #define LOCK_NODEREF 2
+#define LOCK_SEPARATE_STAGING_FILE 4
+
 extern int unable_to_lock_error(const char *path, int err);
 extern NORETURN void unable_to_lock_index_die(const char *path, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
+extern int activate_staging_file(struct lock_file *);
 extern int commit_lock_file(struct lock_file *);
 extern void update_index_if_able(struct index_state *, struct lock_file *);
 
diff --git a/lockfile.c b/lockfile.c
index c06e134..336b914 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -40,8 +40,16 @@
  *   used in any way, it is initialized, permanently registered in the
  *   lock_file_list, and flags & LOCK_FLAGS_ON_LIST is set.
  *
- * - Locked, lockfile open (after hold_lock_file_for_update() or
- *   hold_lock_file_for_append()).  In this state, the lockfile
+ * - Initialized but unlocked (after commit_lock_file(),
+ *   rollback_lock_file(), or a failed attempt to lock).  In this
+ *   state, filename and staging_filename are the empty string.  The
+ *   object is left registered in the lock_file_list, and flags ==
+ *   LOCK_FLAGS_ON_LIST.
+ *
+ * - Locked, lockfile open for writing (after
+ *   hold_lock_file_for_update() or hold_lock_file_for_append()
+ *   without the LOCK_SEPARATE_STAGING_FILE flag).  In this state,
+ *   flags & LOCK_FLAGS_SEPARATE_STAGING_FILE is not set, the lockfile
  *   exists, filename holds the filename of the locked file,
  *   staging_filename holds the filename of the lockfile, fd holds a
  *   file descriptor open for writing to the lockfile, and owner holds
@@ -50,11 +58,21 @@
  * - Locked, lockfile closed (after close_lock_file()).  Same as the
  *   previous state, except that the lockfile is closed and fd is -1.
  *
- * - Unlocked (after commit_lock_file(), rollback_lock_file(), or a
- *   failed attempt to lock).  In this state, filename and
- *   staging_filename are the empty string and fd is -1.  The object is left
- *   registered in the lock_file_list, and flags & LOCK_FLAGS_ON_LIST
- *   is set.
+ * - Locked, separate staging file open for writing (after
+ *   hold_lock_file_for_update() or hold_lock_file_for_append() with
+ *   the LOCK_SEPARATE_STAGING_FILE flag).  In this state, flags &
+ *   LOCK_FLAGS_SEPARATE_STAGING_FILE is set, the lockfile exists but
+ *   is closed, filename holds the filename of the locked file,
+ *   staging_filename holds the filename of the separate staging file,
+ *   fd holds a file descriptor open for writing to the separate
+ *   staging file, and owner holds the PID of the process that locked
+ *   the file.
+ *
+ * - Locked, staging file closed and activated (after
+ *   activate_staging_file()).  Same as the previous state, except
+ *   that the separate staging file has already been closed and
+ *   renamed on top of the file, staging_filename is the empty string,
+ *   and fd is -1.
  *
  * See Documentation/api-lockfile.txt for more information.
  */
@@ -64,6 +82,9 @@
 /* This lock_file instance is in the lock_file_list */
 #define LOCK_FLAGS_ON_LIST 0x01
 
+/* A separate staging file is being used */
+#define LOCK_FLAGS_SEPARATE_STAGING_FILE 0x02
+
 static struct lock_file *lock_file_list;
 static const char *alternate_index_output;
 
@@ -155,9 +176,31 @@ static void resolve_symlink(struct strbuf *path)
 	strbuf_release(&link);
 }
 
-/* We append ".lock" to the filename to derive the lockfile name: */
+/*
+ * We append ".lock" to the filename to derive the lockfile name, and
+ * ".new" to derive the staging file name.  The longer of the two:
+ */
 #define LOCK_SUFFIX_LEN 5
 
+static int open_staging_file(struct lock_file *lk)
+{
+	strbuf_setlen(&lk->staging_filename, lk->filename.len);
+	strbuf_addstr(&lk->staging_filename, ".new");
+	lk->fd = open(lk->staging_filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
+	if (lk->fd < 0) {
+		return -1;
+	}
+	if (adjust_shared_perm(lk->staging_filename.buf)) {
+		error("cannot fix permission bits on %s", lk->staging_filename.buf);
+		if (close(lk->fd))
+			error("cannot close staging file %s", lk->staging_filename.buf);
+		lk->fd = -1;
+		unlink_or_warn(lk->staging_filename.buf);
+		return -1;
+	}
+	return 0;
+}
+
 static int lock_file(struct lock_file *lk, const char *path, int flags)
 {
 	size_t path_len = strlen(path);
@@ -199,11 +242,22 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	if (adjust_shared_perm(lk->staging_filename.buf)) {
 		error("cannot fix permission bits on %s",
 		      lk->staging_filename.buf);
-		rollback_lock_file(lk);
-		return -1;
+		goto rollback_and_fail;
+	}
+	if (flags & LOCK_SEPARATE_STAGING_FILE) {
+		if (close_lock_file(lk))
+			goto rollback_and_fail;
+
+		lk->flags |= LOCK_FLAGS_SEPARATE_STAGING_FILE;
+		if (open_staging_file(lk))
+			goto rollback_and_fail;
 	}
 
 	return lk->fd;
+
+rollback_and_fail:
+	rollback_lock_file(lk);
+	return -1;
 }
 
 static char *unable_to_lock_message(const char *path, int err)
@@ -271,19 +325,54 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 	return fd;
 }
 
-int close_lock_file(struct lock_file *lk)
+static int close_staging_file(struct lock_file *lk)
 {
 	int fd = lk->fd;
+
 	lk->fd = -1;
 	return close(fd);
 }
 
-int commit_lock_file(struct lock_file *lk)
+int close_lock_file(struct lock_file *lk)
 {
-	if (lk->fd >= 0 && close_lock_file(lk))
-		return -1;
-	if (rename(lk->staging_filename.buf, lk->filename.buf))
+	assert(!(lk->flags & LOCK_FLAGS_SEPARATE_STAGING_FILE));
+	return close_staging_file(lk);
+}
+
+int activate_staging_file(struct lock_file *lk)
+{
+	int err;
+
+	assert(lk->flags & LOCK_FLAGS_SEPARATE_STAGING_FILE);
+	assert(lk->fd >= 0);
+	assert(lk->staging_filename.len);
+
+	if (close_staging_file(lk))
 		return -1;
+
+	err = rename(lk->staging_filename.buf, lk->filename.buf);
+	strbuf_setlen(&lk->staging_filename, 0);
+
+	return err;
+}
+
+int commit_lock_file(struct lock_file *lk)
+{
+	if (lk->flags & LOCK_FLAGS_SEPARATE_STAGING_FILE) {
+		if (lk->staging_filename.len) {
+			assert(lk->fd >= 0);
+			if (activate_staging_file(lk))
+				return -1;
+		}
+		strbuf_addbuf(&lk->staging_filename, &lk->filename);
+		strbuf_addstr(&lk->staging_filename, ".lock");
+		unlink_or_warn(lk->staging_filename.buf);
+	} else {
+		if (lk->fd >= 0 && close_lock_file(lk))
+			return -1;
+		if (rename(lk->staging_filename.buf, lk->filename.buf))
+			return -1;
+	}
 	reset_lock_file(lk);
 	return 0;
 }
@@ -318,10 +407,21 @@ int commit_locked_index(struct lock_file *lk)
 
 void rollback_lock_file(struct lock_file *lk)
 {
-	if (lk->filename.len) {
-		if (lk->fd >= 0)
-			close_lock_file(lk);
-		unlink_or_warn(lk->staging_filename.buf);
-		reset_lock_file(lk);
+	if (!lk->filename.len)
+		return;
+
+	if (lk->fd >= 0)
+		close_staging_file(lk);
+
+	if (lk->flags & LOCK_FLAGS_SEPARATE_STAGING_FILE) {
+		if (lk->staging_filename.len) {
+			unlink_or_warn(lk->staging_filename.buf);
+			strbuf_setlen(&lk->staging_filename, 0);
+		}
+		strbuf_addbuf(&lk->staging_filename, &lk->filename);
+		strbuf_addstr(&lk->staging_filename, ".lock");
 	}
+
+	unlink_or_warn(lk->staging_filename.buf);
+	reset_lock_file(lk);
 }
-- 
1.9.0
