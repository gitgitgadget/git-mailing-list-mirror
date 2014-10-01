From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 23/38] lockfile: avoid transitory invalid states
Date: Wed,  1 Oct 2014 12:28:27 +0200
Message-ID: <1412159322-2622-24-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:29:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHA9-0002ef-20
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbaJAK3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:33 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:53417 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751644AbaJAK33 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:29 -0400
X-AuditID: 12074411-f79d86d000006a97-1b-542bd7890cf9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 81.AE.27287.987DB245; Wed,  1 Oct 2014 06:29:29 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6M026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:27 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1O28rh1i0DGB2aLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7owvh3cwFRwyrDjQeJatgfGiWhcj
	J4eEgInEwgcbWSBsMYkL99azdTFycQgJXGaUWHBuCyOEc5xJYtvEQ+wgVWwCuhKLepqZQGwR
	ATWJiW2HWECKmAUWM0lMOLSJDSQhLOAs0bNpBVgRi4CqxOtHl8GaeQVcJJ7sP8QMsU5OYsPu
	/4wgNidQfPnlZrAzhIB6d9z5yjSBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1TvdzM
	Er3UlNJNjJBwFNzBOOOk3CFGAQ5GJR5ehQTtECHWxLLiytxDjJIcTEqivIsuAYX4kvJTKjMS
	izPii0pzUosPMUpwMCuJ8GYfAMrxpiRWVqUW5cOkpDlYlMR5+Zao+wkJpCeWpGanphakFsFk
	ZTg4lCR4Ga4BNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDoiO+GBgfICkeoL3O
	IO28xQWJuUBRiNZTjLoc6zq/9TMJseTl56VKifNmghQJgBRllObBrYAln1eM4kAfC/OGg1Tx
	ABMX3KRXQEuYgJYkrwFbUpKIkJJqYOxX/reb5emLL0bRi8RmdDlO+jVjfqLCjHmeR68tnF17
	flvf1IiKuhuHrl131Y7Xm+ModObYnraVgSYrrbI15tpsSHy3wCVWVCNYu/d50wyH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257710>

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
 lockfile.c   | 37 ++++++++++++++++++++++++++-----------
 read-cache.c |  1 +
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index 24891a8..8e25fce 100644
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
index 728ce49..d35ac44 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -23,7 +23,7 @@
  * used to prevent a forked process from closing a lockfile created by
  * its parent.
  *
- * A lock_file object can be in several states:
+ * The possible states of a lock_file object are as follows:
  *
  * - Uninitialized.  In this state the object's on_list field must be
  *   zero but the rest of its contents need not be initialized.  As
@@ -32,19 +32,27 @@
  *
  * - Locked, lockfile open (after hold_lock_file_for_update(),
  *   hold_lock_file_for_append(), or reopen_lock_file()). In this
- *   state, the lockfile exists, filename holds the filename of the
- *   lockfile, fd holds a file descriptor open for writing to the
- *   lockfile, and owner holds the PID of the process that locked the
- *   file.
+ *   state:
+ *   - the lockfile exists
+ *   - active is set
+ *   - filename holds the filename of the lockfile
+ *   - fd holds a file descriptor open for writing to the lockfile
+ *   - owner holds the PID of the process that locked the file
  *
  * - Locked, lockfile closed (after successful close_lock_file()).
  *   Same as the previous state, except that the lockfile is closed
  *   and fd is -1.
  *
  * - Unlocked (after commit_lock_file(), rollback_lock_file(), a
- *   failed attempt to lock, or a failed close_lock_file()). In this
- *   state, filename[0] == '\0' and fd is -1. The object is left
- *   registered in the lock_file_list, and on_list is set.
+ *   failed attempt to lock, or a failed close_lock_file()).  In this
+ *   state:
+ *   - active is unset
+ *   - filename[0] == '\0' (usually, though there are transitory states
+ *     in which this condition doesn't hold). Client code should *not*
+ *     rely on this fact!
+ *   - fd is -1
+ *   - the object is left registered in the lock_file_list, and
+ *     on_list is set.
  */
 
 static struct lock_file *lock_file_list;
@@ -175,9 +183,13 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		atexit(remove_lock_file);
 	}
 
+	if (lk->active)
+		die("BUG: cannot lock_file(\"%s\") using active struct lock_file",
+		    path);
 	if (!lk->on_list) {
 		/* Initialize *lk and add it to lock_file_list: */
 		lk->fd = -1;
+		lk->active = 0;
 		lk->owner = 0;
 		lk->filename[0] = 0;
 		lk->next = lock_file_list;
@@ -199,6 +211,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		return -1;
 	}
 	lk->owner = getpid();
+	lk->active = 1;
 	if (adjust_shared_perm(lk->filename)) {
 		int save_errno = errno;
 		error("cannot fix permission bits on %s", lk->filename);
@@ -298,7 +311,7 @@ int reopen_lock_file(struct lock_file *lk)
 {
 	if (0 <= lk->fd)
 		die(_("BUG: reopen a lockfile that is still open"));
-	if (!lk->filename[0])
+	if (!lk->active)
 		die(_("BUG: reopen a lockfile that has been committed"));
 	lk->fd = open(lk->filename, O_WRONLY);
 	return lk->fd;
@@ -308,7 +321,7 @@ int commit_lock_file(struct lock_file *lk)
 {
 	char result_file[PATH_MAX];
 
-	if (!lk->filename[0])
+	if (!lk->active)
 		die("BUG: attempt to commit unlocked object");
 
 	if (close_lock_file(lk))
@@ -325,6 +338,7 @@ int commit_lock_file(struct lock_file *lk)
 		return -1;
 	}
 
+	lk->active = 0;
 	lk->filename[0] = 0;
 	return 0;
 }
@@ -339,11 +353,12 @@ int hold_locked_index(struct lock_file *lk, int die_on_error)
 
 void rollback_lock_file(struct lock_file *lk)
 {
-	if (!lk->filename[0])
+	if (!lk->active)
 		return;
 
 	if (!close_lock_file(lk)) {
 		unlink_or_warn(lk->filename);
+		lk->active = 0;
 		lk->filename[0] = 0;
 	}
 }
diff --git a/read-cache.c b/read-cache.c
index 5ffb1d7..af69f34 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2046,6 +2046,7 @@ static int commit_locked_index(struct lock_file *lk)
 			return -1;
 		if (rename(lk->filename, alternate_index_output))
 			return -1;
+		lk->active = 0;
 		lk->filename[0] = 0;
 		return 0;
 	} else {
-- 
2.1.0
