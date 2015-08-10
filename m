From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/16] Move lockfile documentation to lockfile.h and lockfile.c
Date: Mon, 10 Aug 2015 11:47:36 +0200
Message-ID: <c795223dcaca8e092b10673d20def4f44156ca31.1439198011.git.mhagger@alum.mit.edu>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:48:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjhG-0002BU-9W
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768AbbHJJsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:48:38 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:45085 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754732AbbHJJsM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 05:48:12 -0400
X-AuditID: 1207440c-f79e16d000002a6e-fb-55c8734d99be
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id ED.F3.10862.D4378C55; Mon, 10 Aug 2015 05:47:57 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7A9lswp021057
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Aug 2015 05:47:56 -0400
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1439198011.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixO6iqOtbfCLU4OlKG4uuK91MFg29V5gt
	nsy9y2xxe8V8ZgcWj7/vPzB5PHzVxe5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGZt7N7MW
	nD/OWPF1vnkD48L5jF2MnBwSAiYS837vY4OwxSQu3FsPZHNxCAlcZpS4Nfs7K4Rzgkli16dW
	dpAqNgFdiUU9zUwgtoiAmsTEtkMsIDazQLrEiQXtYLawQJDE/En7wGpYBFQljn3vBtvGKxAl
	seIbyAYOoG1yEgsupIOEOQUsJLY3bmAFsYUEzCUezzvPPoGRdwEjwypGucSc0lzd3MTMnOLU
	ZN3i5MS8vNQiXUO93MwSvdSU0k2MkADi2cH4bZ3MIUYBDkYlHt4Zm4+HCrEmlhVX5h5ilORg
	UhLltcg/ESrEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhDc+AyjHm5JYWZValA+TkuZgURLnVV2i
	7ickkJ5YkpqdmlqQWgSTleHgUJLglS8CahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwt
	yYgHxUZ8MTA6QFI8QHvtQNp5iwsSc4GiEK2nGBWlxHn/FAIlBEASGaV5cGNhaeEVozjQl8K8
	e0CqeIApBa77FdBgJpDBgWCDSxIRUlINjB2/PKZsl3yYZPiiY4djwMrUlzLeq5aL5v6qTE5+
	eV7384xnAg/1264ZltYoPs/2Xp5za9Z6jX6Gj/qiR4vUN9R/ebVz06eDrDysQmHHmdqr7WPu
	+qt9mP9gronNnZqjO1sezXQRbT+x7qLa2vByYXdm32TD7ZeCcu4uFpe7PJ3ze0Wt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275602>

Rearrange/rewrite it somewhat to fit its new environment.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-lockfile.txt | 220 -----------------------
 lockfile.c                               |  53 ++++++
 lockfile.h                               | 290 ++++++++++++++++++++++++-------
 3 files changed, 283 insertions(+), 280 deletions(-)
 delete mode 100644 Documentation/technical/api-lockfile.txt

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
deleted file mode 100644
index 93b5f23..0000000
--- a/Documentation/technical/api-lockfile.txt
+++ /dev/null
@@ -1,220 +0,0 @@
-lockfile API
-============
-
-The lockfile API serves two purposes:
-
-* Mutual exclusion and atomic file updates. When we want to change a
-  file, we create a lockfile `<filename>.lock`, write the new file
-  contents into it, and then rename the lockfile to its final
-  destination `<filename>`. We create the `<filename>.lock` file with
-  `O_CREAT|O_EXCL` so that we can notice and fail if somebody else has
-  already locked the file, then atomically rename the lockfile to its
-  final destination to commit the changes and unlock the file.
-
-* Automatic cruft removal. If the program exits after we lock a file
-  but before the changes have been committed, we want to make sure
-  that we remove the lockfile. This is done by remembering the
-  lockfiles we have created in a linked list and setting up an
-  `atexit(3)` handler and a signal handler that clean up the
-  lockfiles. This mechanism ensures that outstanding lockfiles are
-  cleaned up if the program exits (including when `die()` is called)
-  or if the program dies on a signal.
-
-Please note that lockfiles only block other writers. Readers do not
-block, but they are guaranteed to see either the old contents of the
-file or the new contents of the file (assuming that the filesystem
-implements `rename(2)` atomically).
-
-
-Calling sequence
-----------------
-
-The caller:
-
-* Allocates a `struct lock_file` either as a static variable or on the
-  heap, initialized to zeros. Once you use the structure to call the
-  `hold_lock_file_*` family of functions, it belongs to the lockfile
-  subsystem and its storage must remain valid throughout the life of
-  the program (i.e. you cannot use an on-stack variable to hold this
-  structure).
-
-* Attempts to create a lockfile by passing that variable and the path
-  of the final destination (e.g. `$GIT_DIR/index`) to
-  `hold_lock_file_for_update` or `hold_lock_file_for_append`.
-
-* Writes new content for the destination file by either:
-
-  * writing to the file descriptor returned by the `hold_lock_file_*`
-    functions (also available via `lock->fd`).
-
-  * calling `fdopen_lock_file` to get a `FILE` pointer for the open
-    file and writing to the file using stdio.
-
-When finished writing, the caller can:
-
-* Close the file descriptor and rename the lockfile to its final
-  destination by calling `commit_lock_file` or `commit_lock_file_to`.
-
-* Close the file descriptor and remove the lockfile by calling
-  `rollback_lock_file`.
-
-* Close the file descriptor without removing or renaming the lockfile
-  by calling `close_lock_file`, and later call `commit_lock_file`,
-  `commit_lock_file_to`, `rollback_lock_file`, or `reopen_lock_file`.
-
-Even after the lockfile is committed or rolled back, the `lock_file`
-object must not be freed or altered by the caller. However, it may be
-reused; just pass it to another call of `hold_lock_file_for_update` or
-`hold_lock_file_for_append`.
-
-If the program exits before you have called one of `commit_lock_file`,
-`commit_lock_file_to`, `rollback_lock_file`, or `close_lock_file`, an
-`atexit(3)` handler will close and remove the lockfile, rolling back
-any uncommitted changes.
-
-If you need to close the file descriptor you obtained from a
-`hold_lock_file_*` function yourself, do so by calling
-`close_lock_file`. You should never call `close(2)` or `fclose(3)`
-yourself! Otherwise the `struct lock_file` structure would still think
-that the file descriptor needs to be closed, and a commit or rollback
-would result in duplicate calls to `close(2)`. Worse yet, if you close
-and then later open another file descriptor for a completely different
-purpose, then a commit or rollback might close that unrelated file
-descriptor.
-
-
-Error handling
---------------
-
-The `hold_lock_file_*` functions return a file descriptor on success
-or -1 on failure (unless `LOCK_DIE_ON_ERROR` is used; see below). On
-errors, `errno` describes the reason for failure. Errors can be
-reported by passing `errno` to one of the following helper functions:
-
-unable_to_lock_message::
-
-	Append an appropriate error message to a `strbuf`.
-
-unable_to_lock_error::
-
-	Emit an appropriate error message using `error()`.
-
-unable_to_lock_die::
-
-	Emit an appropriate error message and `die()`.
-
-Similarly, `commit_lock_file`, `commit_lock_file_to`, and
-`close_lock_file` return 0 on success. On failure they set `errno`
-appropriately, do their best to roll back the lockfile, and return -1.
-
-
-Flags
------
-
-The following flags can be passed to `hold_lock_file_for_update` or
-`hold_lock_file_for_append`:
-
-LOCK_NO_DEREF::
-
-	Usually symbolic links in the destination path are resolved
-	and the lockfile is created by adding ".lock" to the resolved
-	path. If `LOCK_NO_DEREF` is set, then the lockfile is created
-	by adding ".lock" to the path argument itself. This option is
-	used, for example, when locking a symbolic reference, which
-	for backwards-compatibility reasons can be a symbolic link
-	containing the name of the referred-to-reference.
-
-LOCK_DIE_ON_ERROR::
-
-	If a lock is already taken for the file, `die()` with an error
-	message. If this option is not specified, trying to lock a
-	file that is already locked returns -1 to the caller.
-
-
-The functions
--------------
-
-hold_lock_file_for_update::
-
-	Take a pointer to `struct lock_file`, the path of the file to
-	be locked (e.g. `$GIT_DIR/index`) and a flags argument (see
-	above). Attempt to create a lockfile for the destination and
-	return the file descriptor for writing to the file.
-
-hold_lock_file_for_append::
-
-	Like `hold_lock_file_for_update`, but before returning copy
-	the existing contents of the file (if any) to the lockfile and
-	position its write pointer at the end of the file.
-
-fdopen_lock_file::
-
-	Associate a stdio stream with the lockfile. Return NULL
-	(*without* rolling back the lockfile) on error. The stream is
-	closed automatically when `close_lock_file` is called or when
-	the file is committed or rolled back.
-
-get_locked_file_path::
-
-	Return the path of the file that is locked by the specified
-	lock_file object. The caller must free the memory.
-
-commit_lock_file::
-
-	Take a pointer to the `struct lock_file` initialized with an
-	earlier call to `hold_lock_file_for_update` or
-	`hold_lock_file_for_append`, close the file descriptor, and
-	rename the lockfile to its final destination. Return 0 upon
-	success. On failure, roll back the lock file and return -1,
-	with `errno` set to the value from the failing call to
-	`close(2)` or `rename(2)`. It is a bug to call
-	`commit_lock_file` for a `lock_file` object that is not
-	currently locked.
-
-commit_lock_file_to::
-
-	Like `commit_lock_file()`, except that it takes an explicit
-	`path` argument to which the lockfile should be renamed. The
-	`path` must be on the same filesystem as the lock file.
-
-rollback_lock_file::
-
-	Take a pointer to the `struct lock_file` initialized with an
-	earlier call to `hold_lock_file_for_update` or
-	`hold_lock_file_for_append`, close the file descriptor and
-	remove the lockfile. It is a NOOP to call
-	`rollback_lock_file()` for a `lock_file` object that has
-	already been committed or rolled back.
-
-close_lock_file::
-
-	Take a pointer to the `struct lock_file` initialized with an
-	earlier call to `hold_lock_file_for_update` or
-	`hold_lock_file_for_append`. Close the file descriptor (and
-	the file pointer if it has been opened using
-	`fdopen_lock_file`). Return 0 upon success. On failure to
-	`close(2)`, return a negative value and roll back the lock
-	file. Usually `commit_lock_file`, `commit_lock_file_to`, or
-	`rollback_lock_file` should eventually be called if
-	`close_lock_file` succeeds.
-
-reopen_lock_file::
-
-	Re-open a lockfile that has been closed (using
-	`close_lock_file`) but not yet committed or rolled back. This
-	can be used to implement a sequence of operations like the
-	following:
-
-	* Lock file.
-
-	* Write new contents to lockfile, then `close_lock_file` to
-	  cause the contents to be written to disk.
-
-	* Pass the name of the lockfile to another program to allow it
-	  (and nobody else) to inspect the contents you wrote, while
-	  still holding the lock yourself.
-
-	* `reopen_lock_file` to reopen the lockfile. Make further
-	  updates to the contents.
-
-	* `commit_lock_file` to make the final version permanent.
diff --git a/lockfile.c b/lockfile.c
index 5a93bc7..2369eff 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -1,6 +1,59 @@
 /*
  * Copyright (c) 2005, Junio C Hamano
  */
+
+/*
+ * State diagram and cleanup
+ * -------------------------
+ *
+ * This module keeps track of all locked files in `lock_file_list` for
+ * use at cleanup. This list and the `lock_file` objects that comprise
+ * it must be kept in self-consistent states at all time, because the
+ * program can be interrupted any time by a signal, in which case the
+ * signal handler will walk through the list attempting to clean up
+ * any open lock files.
+ *
+ * The possible states of a `lock_file` object are as follows:
+ *
+ * - Uninitialized. In this state the object's `on_list` field must be
+ *   zero but the rest of its contents need not be initialized. As
+ *   soon as the object is used in any way, it is irrevocably
+ *   registered in `lock_file_list`, and `on_list` is set.
+ *
+ * - Locked, lockfile open (after `hold_lock_file_for_update()`,
+ *   `hold_lock_file_for_append()`, or `reopen_lock_file()`). In this
+ *   state:
+ *
+ *   - the lockfile exists
+ *   - `active` is set
+ *   - `filename` holds the filename of the lockfile
+ *   - `fd` holds a file descriptor open for writing to the lockfile
+ *   - `fp` holds a pointer to an open `FILE` object if and only if
+ *     `fdopen_lock_file()` has been called on the object
+ *   - `owner` holds the PID of the process that locked the file
+ *
+ * - Locked, lockfile closed (after successful `close_lock_file()`).
+ *   Same as the previous state, except that the lockfile is closed
+ *   and `fd` is -1.
+ *
+ * - Unlocked (after `commit_lock_file()`, `commit_lock_file_to()`,
+ *   `rollback_lock_file()`, a failed attempt to lock, or a failed
+ *   `close_lock_file()`).  In this state:
+ *
+ *   - `active` is unset
+ *   - `filename` is empty (usually, though there are transitory
+ *     states in which this condition doesn't hold). Client code should
+ *     *not* rely on the filename being empty in this state.
+ *   - `fd` is -1
+ *   - the object is left registered in the `lock_file_list`, and
+ *     `on_list` is set.
+ *
+ * A lockfile is owned by the process that created it. The `lock_file`
+ * has an `owner` field that records the owner's PID. This field is
+ * used to prevent a forked process from closing a lockfile created by
+ * its parent.
+ */
+
 #include "cache.h"
 #include "lockfile.h"
 #include "sigchain.h"
diff --git a/lockfile.h b/lockfile.h
index b4abc61..a483cc9 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -4,54 +4,103 @@
 /*
  * File write-locks as used by Git.
  *
- * For an overview of how to use the lockfile API, please see
- *
- *     Documentation/technical/api-lockfile.txt
- *
- * This module keeps track of all locked files in lock_file_list for
- * use at cleanup. This list and the lock_file objects that comprise
- * it must be kept in self-consistent states at all time, because the
- * program can be interrupted any time by a signal, in which case the
- * signal handler will walk through the list attempting to clean up
- * any open lock files.
- *
- * A lockfile is owned by the process that created it. The lock_file
- * object has an "owner" field that records its owner. This field is
- * used to prevent a forked process from closing a lockfile created by
- * its parent.
- *
- * The possible states of a lock_file object are as follows:
- *
- * - Uninitialized.  In this state the object's on_list field must be
- *   zero but the rest of its contents need not be initialized.  As
- *   soon as the object is used in any way, it is irrevocably
- *   registered in the lock_file_list, and on_list is set.
- *
- * - Locked, lockfile open (after hold_lock_file_for_update(),
- *   hold_lock_file_for_append(), or reopen_lock_file()). In this
- *   state:
- *   - the lockfile exists
- *   - active is set
- *   - filename holds the filename of the lockfile
- *   - fd holds a file descriptor open for writing to the lockfile
- *   - fp holds a pointer to an open FILE object if and only if
- *     fdopen_lock_file() has been called on the object
- *   - owner holds the PID of the process that locked the file
- *
- * - Locked, lockfile closed (after successful close_lock_file()).
- *   Same as the previous state, except that the lockfile is closed
- *   and fd is -1.
- *
- * - Unlocked (after commit_lock_file(), commit_lock_file_to(),
- *   rollback_lock_file(), a failed attempt to lock, or a failed
- *   close_lock_file()).  In this state:
- *   - active is unset
- *   - filename is empty (usually, though there are transitory
- *     states in which this condition doesn't hold). Client code should
- *     *not* rely on the filename being empty in this state.
- *   - fd is -1
- *   - the object is left registered in the lock_file_list, and
- *     on_list is set.
+ * The lockfile API serves two purposes:
+ *
+ * * Mutual exclusion and atomic file updates. When we want to change
+ *   a file, we create a lockfile `<filename>.lock`, write the new
+ *   file contents into it, and then rename the lockfile to its final
+ *   destination `<filename>`. We create the `<filename>.lock` file
+ *   with `O_CREAT|O_EXCL` so that we can notice and fail if somebody
+ *   else has already locked the file, then atomically rename the
+ *   lockfile to its final destination to commit the changes and
+ *   unlock the file.
+ *
+ * * Automatic cruft removal. If the program exits after we lock a
+ *   file but before the changes have been committed, we want to make
+ *   sure that we remove the lockfile. This is done by remembering the
+ *   lockfiles we have created in a linked list and setting up an
+ *   `atexit(3)` handler and a signal handler that clean up the
+ *   lockfiles. This mechanism ensures that outstanding lockfiles are
+ *   cleaned up if the program exits (including when `die()` is
+ *   called) or if the program is terminated by a signal.
+ *
+ * Please note that lockfiles only block other writers. Readers do not
+ * block, but they are guaranteed to see either the old contents of
+ * the file or the new contents of the file (assuming that the
+ * filesystem implements `rename(2)` atomically).
+ *
+ *
+ * Calling sequence
+ * ----------------
+ *
+ * The caller:
+ *
+ * * Allocates a `struct lock_file` either as a static variable or on
+ *   the heap, initialized to zeros. Once you use the structure to
+ *   call the `hold_lock_file_for_*()` family of functions, it belongs
+ *   to the lockfile subsystem and its storage must remain valid
+ *   throughout the life of the program (i.e. you cannot use an
+ *   on-stack variable to hold this structure).
+ *
+ * * Attempts to create a lockfile by calling
+ *   `hold_lock_file_for_update()` or `hold_lock_file_for_append()`.
+ *
+ * * Writes new content for the destination file by either:
+ *
+ *   * writing to the file descriptor returned by the
+ *     `hold_lock_file_for_*()` functions (also available via
+ *     `lock->fd`).
+ *
+ *   * calling `fdopen_lock_file()` to get a `FILE` pointer for the
+ *     open file and writing to the file using stdio.
+ *
+ * When finished writing, the caller can:
+ *
+ * * Close the file descriptor and rename the lockfile to its final
+ *   destination by calling `commit_lock_file()` or
+ *   `commit_lock_file_to()`.
+ *
+ * * Close the file descriptor and remove the lockfile by calling
+ *   `rollback_lock_file()`.
+ *
+ * * Close the file descriptor without removing or renaming the
+ *   lockfile by calling `close_lock_file()`, and later call
+ *   `commit_lock_file()`, `commit_lock_file_to()`,
+ *   `rollback_lock_file()`, or `reopen_lock_file()`.
+ *
+ * Even after the lockfile is committed or rolled back, the
+ * `lock_file` object must not be freed or altered by the caller.
+ * However, it may be reused; just pass it to another call of
+ * `hold_lock_file_for_update()` or `hold_lock_file_for_append()`.
+ *
+ * If the program exits before `commit_lock_file()`,
+ * `commit_lock_file_to()`, or `rollback_lock_file()` is called, an
+ * `atexit(3)` handler will close and remove the lockfile, thereby
+ * rolling back any uncommitted changes.
+ *
+ * If you need to close the file descriptor you obtained from a
+ * `hold_lock_file_for_*()` function yourself, do so by calling
+ * `close_lock_file()`. You should never call `close(2)` or
+ * `fclose(3)` yourself, otherwise the `struct lock_file` structure
+ * would still think that the file descriptor needs to be closed, and
+ * a commit or rollback would result in duplicate calls to `close(2)`.
+ * Worse yet, if you close and then later open another file descriptor
+ * for a completely different purpose, then a commit or rollback might
+ * close that unrelated file descriptor.
+ *
+ * Error handling
+ * --------------
+ *
+ * The `hold_lock_file_for_*()` functions return a file descriptor on
+ * success or -1 on failure (unless `LOCK_DIE_ON_ERROR` is used; see
+ * "flags" below). On errors, `errno` describes the reason for
+ * failure. Errors can be reported by passing `errno` to
+ * `unable_to_lock_message()` or `unable_to_lock_die()`.
+ *
+ * Similarly, `commit_lock_file`, `commit_lock_file_to`, and
+ * `close_lock_file` return 0 on success. On failure they set `errno`
+ * appropriately, do their best to roll back the lockfile, and return
+ * -1.
  */
 
 struct lock_file {
@@ -68,16 +117,51 @@ struct lock_file {
 #define LOCK_SUFFIX ".lock"
 #define LOCK_SUFFIX_LEN 5
 
+
+/*
+ * Flags
+ * -----
+ *
+ * The following flags can be passed to `hold_lock_file_for_update()`
+ * or `hold_lock_file_for_append()`.
+ */
+
+/*
+ * If a lock is already taken for the file, `die()` with an error
+ * message. If this flag is not specified, trying to lock a file that
+ * is already locked returns -1 to the caller.
+ */
 #define LOCK_DIE_ON_ERROR 1
+
+/*
+ * Usually symbolic links in the destination path are resolved. This
+ * means that (1) the lockfile is created by adding ".lock" to the
+ * resolved path, and (2) upon commit, the resolved path is
+ * overwritten. However, if `LOCK_NO_DEREF` is set, then the lockfile
+ * is created by adding ".lock" to the path argument itself. This
+ * option is used, for example, when detaching a symbolic reference,
+ * which for backwards-compatibility reasons, can be a symbolic link
+ * containing the name of the referred-to-reference.
+ */
 #define LOCK_NO_DEREF 2
 
-extern void unable_to_lock_message(const char *path, int err,
-				   struct strbuf *buf);
-extern NORETURN void unable_to_lock_die(const char *path, int err);
+/*
+ * Attempt to create a lockfile for the file at `path` and return a
+ * file descriptor for writing to it, or -1 on error. If the file is
+ * currently locked, retry with quadratic backoff for at least
+ * timeout_ms milliseconds. If timeout_ms is 0, try exactly once; if
+ * timeout_ms is -1, retry indefinitely. The flags argument and error
+ * handling are described above.
+ */
 extern int hold_lock_file_for_update_timeout(
 		struct lock_file *lk, const char *path,
 		int flags, long timeout_ms);
 
+/*
+ * Attempt to create a lockfile for the file at `path` and return a
+ * file descriptor for writing to it, or -1 on error. The flags
+ * argument and error handling are described above.
+ */
 static inline int hold_lock_file_for_update(
 		struct lock_file *lk, const char *path,
 		int flags)
@@ -85,15 +169,101 @@ static inline int hold_lock_file_for_update(
 	return hold_lock_file_for_update_timeout(lk, path, flags, 0);
 }
 
-extern int hold_lock_file_for_append(struct lock_file *lk, const char *path,
-				     int flags);
+/*
+ * Like `hold_lock_file_for_update()`, but before returning copy the
+ * existing contents of the file (if any) to the lockfile and position
+ * its write pointer at the end of the file. The flags argument and
+ * error handling are described above.
+ */
+extern int hold_lock_file_for_append(struct lock_file *lk,
+				     const char *path, int flags);
+
+/*
+ * Append an appropriate error message to `buf` following the failure
+ * of `hold_lock_file_for_update()` or `hold_lock_file_for_append()`
+ * to lock `path`. `err` should be the `errno` set by the failing
+ * call.
+ */
+extern void unable_to_lock_message(const char *path, int err,
+				   struct strbuf *buf);
 
-extern FILE *fdopen_lock_file(struct lock_file *, const char *mode);
-extern char *get_locked_file_path(struct lock_file *);
-extern int commit_lock_file_to(struct lock_file *, const char *path);
-extern int commit_lock_file(struct lock_file *);
-extern int reopen_lock_file(struct lock_file *);
-extern int close_lock_file(struct lock_file *);
-extern void rollback_lock_file(struct lock_file *);
+/*
+ * Emit an appropriate error message and `die()` following the failure
+ * of `hold_lock_file_for_update()` or `hold_lock_file_for_append()`
+ * to lock `path`. `err` should be the `errno` set by the failing
+ * call.
+ */
+extern NORETURN void unable_to_lock_die(const char *path, int err);
+
+/*
+ * Associate a stdio stream with the lockfile (which must still be
+ * open). Return `NULL` (*without* rolling back the lockfile) on
+ * error. The stream is closed automatically when `close_lock_file()`
+ * is called or when the file is committed or rolled back.
+ */
+extern FILE *fdopen_lock_file(struct lock_file *lk, const char *mode);
+
+/*
+ * Return the path of the file that is locked by the specified
+ * lock_file object. The caller must free the memory.
+ */
+extern char *get_locked_file_path(struct lock_file *lk);
+
+/*
+ * If the lockfile is still open, close it (and the file pointer if it
+ * has been opened using `fdopen_lock_file()`) without renaming the
+ * lockfile over the file being locked. Return 0 upon success. On
+ * failure to `close(2)`, return a negative value and roll back the
+ * lock file. Usually `commit_lock_file()`, `commit_lock_file_to()`,
+ * or `rollback_lock_file()` should eventually be called if
+ * `close_lock_file()` succeeds.
+ */
+extern int close_lock_file(struct lock_file *lk);
+
+/*
+ * Re-open a lockfile that has been closed using `close_lock_file()`
+ * but not yet committed or rolled back. This can be used to implement
+ * a sequence of operations like the following:
+ *
+ * * Lock file.
+ *
+ * * Write new contents to lockfile, then `close_lock_file()` to
+ *   cause the contents to be written to disk.
+ *
+ * * Pass the name of the lockfile to another program to allow it (and
+ *   nobody else) to inspect the contents you wrote, while still
+ *   holding the lock yourself.
+ *
+ * * `reopen_lock_file()` to reopen the lockfile. Make further updates
+ *   to the contents.
+ *
+ * * `commit_lock_file()` to make the final version permanent.
+ */
+extern int reopen_lock_file(struct lock_file *lk);
+
+/*
+ * Commit the change represented by `lk`: close the file descriptor
+ * and/or file pointer if they are still open and rename the lockfile
+ * to its final destination. Return 0 upon success. On failure, roll
+ * back the lock file and return -1, with `errno` set to the value
+ * from the failing call to `close(2)` or `rename(2)`. It is a bug to
+ * call `commit_lock_file()` for a `lock_file` object that is not
+ * currently locked.
+ */
+extern int commit_lock_file(struct lock_file *lk);
+
+/*
+ * Like `commit_lock_file()`, but rename the lockfile to the provided
+ * `path`. `path` must be on the same filesystem as the lock file.
+ */
+extern int commit_lock_file_to(struct lock_file *lk, const char *path);
+
+/*
+ * Roll back `lk`: close the file descriptor and/or file pointer and
+ * remove the lockfile. It is a NOOP to call `rollback_lock_file()`
+ * for a `lock_file` object that has already been committed or rolled
+ * back.
+ */
+extern void rollback_lock_file(struct lock_file *lk);
 
 #endif /* LOCKFILE_H */
-- 
2.5.0
