From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/3] fdopen_lock_file(): access a lockfile using stdio
Date: Wed,  1 Oct 2014 13:14:47 +0200
Message-ID: <1412162089-3233-2-git-send-email-mhagger@alum.mit.edu>
References: <1412162089-3233-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 13:15:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHsK-0005bH-I8
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 13:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbaJALPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 07:15:09 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42758 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751196AbaJALPA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 07:15:00 -0400
X-AuditID: 12074414-f79446d000001f1d-fe-542be2307020
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id C2.52.07965.032EB245; Wed,  1 Oct 2014 07:14:56 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91BEp6k028682
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 07:14:55 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412162089-3233-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42IRYndR1DV4pB1icKdVz6LrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7owpV2cwFixyqvh/cBN7A2O/aRcj
	B4eEgInE5yfMXYycQKaYxIV769m6GLk4hAQuM0q0Hn8C5Rxnkth37yAjSBWbgK7Eop5mJhBb
	REBNYmLbIRaQImaBxUwSEw5tYgNJCAu4SSx5eoodxGYRUJVY2vCXCWQbr4CzxLUGY4htchIb
	dv9nBAlzCrhIzLrCCRIWAqrYMe8T0wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdC30
	cjNL9FJTSjcxQgJRZAfjkZNyhxgFOBiVeHgVErRDhFgTy4orcw8xSnIwKYnyOj4ACvEl5adU
	ZiQWZ8QXleakFh9ilOBgVhLhzT4AlONNSaysSi3Kh0lJc7AoifN+W6zuJySQnliSmp2aWpBa
	BJOV4eBQkuBdBTJUsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQX8cXAyABJ8QDt
	vQHSzltckJgLFIVoPcWoy7Gu81s/kxBLXn5eqpQ4r/tDoCIBkKKM0jy4FbC084pRHOhjYd7n
	IKN4gCkLbtIroCVMQEuS14AtKUlESEkBI//u36CWneLtnH2nDmQq7Dt/vzbZP1/S5FSBTUuf
	z7fy9ToMklXny5e6Cu5MYd54LbZ4uu3njfHTps4MdfuxOmlPTUye592rfBvfVpdI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257743>

Add a new function, fdopen_lock_file(), which returns a FILE pointer
open to the lockfile. If a stream is open on a lock_file object, it is
closed using fclose() on commit, rollback, or close_lock_file().

This change will allow callers to use stdio to write to a lockfile
without having to muck around in the internal representation of the
lock_file object (callers will be rewritten in upcoming commits).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

I thought about adding second stdio-oriented entrance points analogous
to hold_lock_file_for_update(), hold_lock_file_for_append(), and
reopen_lock_file(), but it seemed simpler to add just the one new
function instead of three or four. If using stdio on lockfiles becomes
more popular, we might want to add some helper functions to make it a
bit more convenient.

In close_lock_file(), if ferror() returns an error, then errno is not
necessarily still set in a way that reflects the original error. I
don't see a way to ensure that errno is set correctly in this
situation. But hopefully, callers are monitoring their calls to
fwrite()/fprintf() etc and will have noticed write errors on their own
already. If anybody can suggest an improvement here, please let me
know.

 Documentation/technical/api-lockfile.txt | 34 +++++++++++++++--------
 lockfile.c                               | 46 ++++++++++++++++++++++++++++----
 lockfile.h                               |  4 +++
 3 files changed, 68 insertions(+), 16 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index d4484d1..93b5f23 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -42,9 +42,13 @@ The caller:
   of the final destination (e.g. `$GIT_DIR/index`) to
   `hold_lock_file_for_update` or `hold_lock_file_for_append`.
 
-* Writes new content for the destination file by writing to the file
-  descriptor returned by those functions (also available via
-  `lock->fd`).
+* Writes new content for the destination file by either:
+
+  * writing to the file descriptor returned by the `hold_lock_file_*`
+    functions (also available via `lock->fd`).
+
+  * calling `fdopen_lock_file` to get a `FILE` pointer for the open
+    file and writing to the file using stdio.
 
 When finished writing, the caller can:
 
@@ -70,10 +74,10 @@ any uncommitted changes.
 
 If you need to close the file descriptor you obtained from a
 `hold_lock_file_*` function yourself, do so by calling
-`close_lock_file`. You should never call `close(2)` yourself!
-Otherwise the `struct lock_file` structure would still think that the
-file descriptor needs to be closed, and a commit or rollback would
-result in duplicate calls to `close(2)`. Worse yet, if you `close(2)`
+`close_lock_file`. You should never call `close(2)` or `fclose(3)`
+yourself! Otherwise the `struct lock_file` structure would still think
+that the file descriptor needs to be closed, and a commit or rollback
+would result in duplicate calls to `close(2)`. Worse yet, if you close
 and then later open another file descriptor for a completely different
 purpose, then a commit or rollback might close that unrelated file
 descriptor.
@@ -143,6 +147,13 @@ hold_lock_file_for_append::
 	the existing contents of the file (if any) to the lockfile and
 	position its write pointer at the end of the file.
 
+fdopen_lock_file::
+
+	Associate a stdio stream with the lockfile. Return NULL
+	(*without* rolling back the lockfile) on error. The stream is
+	closed automatically when `close_lock_file` is called or when
+	the file is committed or rolled back.
+
 get_locked_file_path::
 
 	Return the path of the file that is locked by the specified
@@ -179,10 +190,11 @@ close_lock_file::
 
 	Take a pointer to the `struct lock_file` initialized with an
 	earlier call to `hold_lock_file_for_update` or
-	`hold_lock_file_for_append`, and close the file descriptor.
-	Return 0 upon success. On failure to `close(2)`, return a
-	negative value and roll back the lock file. Usually
-	`commit_lock_file`, `commit_lock_file_to`, or
+	`hold_lock_file_for_append`. Close the file descriptor (and
+	the file pointer if it has been opened using
+	`fdopen_lock_file`). Return 0 upon success. On failure to
+	`close(2)`, return a negative value and roll back the lock
+	file. Usually `commit_lock_file`, `commit_lock_file_to`, or
 	`rollback_lock_file` should eventually be called if
 	`close_lock_file` succeeds.
 
diff --git a/lockfile.c b/lockfile.c
index d27e61c..e046027 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -7,20 +7,29 @@
 
 static struct lock_file *volatile lock_file_list;
 
-static void remove_lock_files(void)
+static void remove_lock_files(int skip_fclose)
 {
 	pid_t me = getpid();
 
 	while (lock_file_list) {
-		if (lock_file_list->owner == me)
+		if (lock_file_list->owner == me) {
+			/* fclose() is not safe to call in a signal handler */
+			if (skip_fclose)
+				lock_file_list->fp = NULL;
 			rollback_lock_file(lock_file_list);
+		}
 		lock_file_list = lock_file_list->next;
 	}
 }
 
+static void remove_lock_files_on_exit(void)
+{
+	remove_lock_files(0);
+}
+
 static void remove_lock_files_on_signal(int signo)
 {
-	remove_lock_files();
+	remove_lock_files(1);
 	sigchain_pop(signo);
 	raise(signo);
 }
@@ -97,7 +106,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	if (!lock_file_list) {
 		/* One-time initialization */
 		sigchain_push_common(remove_lock_files_on_signal);
-		atexit(remove_lock_files);
+		atexit(remove_lock_files_on_exit);
 	}
 
 	if (lk->active)
@@ -106,6 +115,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	if (!lk->on_list) {
 		/* Initialize *lk and add it to lock_file_list: */
 		lk->fd = -1;
+		lk->fp = NULL;
 		lk->active = 0;
 		lk->owner = 0;
 		strbuf_init(&lk->filename, pathlen + LOCK_SUFFIX_LEN);
@@ -214,6 +224,17 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 	return fd;
 }
 
+FILE *fdopen_lock_file(struct lock_file *lk, const char *mode)
+{
+	if (!lk->active)
+		die("BUG: fdopen_lock_file() called for unlocked object");
+	if (lk->fp)
+		die("BUG: fdopen_lock_file() called twice for file '%s'", lk->filename.buf);
+
+	lk->fp = fdopen(lk->fd, mode);
+	return lk->fp;
+}
+
 char *get_locked_file_path(struct lock_file *lk)
 {
 	if (!lk->active)
@@ -226,17 +247,32 @@ char *get_locked_file_path(struct lock_file *lk)
 int close_lock_file(struct lock_file *lk)
 {
 	int fd = lk->fd;
+	FILE *fp = lk->fp;
+	int err;
 
 	if (fd < 0)
 		return 0;
 
 	lk->fd = -1;
-	if (close(fd)) {
+	if (fp) {
+		lk->fp = NULL;
+
+		/*
+		 * Note: no short-circuiting here; we want to fclose()
+		 * in any case!
+		 */
+		err = ferror(fp) | fclose(fp);
+	} else {
+		err = close(fd);
+	}
+
+	if (err) {
 		int save_errno = errno;
 		rollback_lock_file(lk);
 		errno = save_errno;
 		return -1;
 	}
+
 	return 0;
 }
 
diff --git a/lockfile.h b/lockfile.h
index 9059e89..dc066d1 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -34,6 +34,8 @@
  *   - active is set
  *   - filename holds the filename of the lockfile
  *   - fd holds a file descriptor open for writing to the lockfile
+ *   - fp holds a pointer to an open FILE object if and only if
+ *     fdopen_lock_file() has been called on the object
  *   - owner holds the PID of the process that locked the file
  *
  * - Locked, lockfile closed (after successful close_lock_file()).
@@ -56,6 +58,7 @@ struct lock_file {
 	struct lock_file *volatile next;
 	volatile sig_atomic_t active;
 	volatile int fd;
+	FILE *volatile fp;
 	volatile pid_t owner;
 	char on_list;
 	struct strbuf filename;
@@ -74,6 +77,7 @@ extern void unable_to_lock_message(const char *path, int err,
 extern NORETURN void unable_to_lock_die(const char *path, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
+extern FILE *fdopen_lock_file(struct lock_file *, const char *mode);
 extern char *get_locked_file_path(struct lock_file *);
 extern int commit_lock_file_to(struct lock_file *, const char *path);
 extern int commit_lock_file(struct lock_file *);
-- 
2.1.0
