From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v4 00/32] Lockfile correctness and refactoring
Date: Sun, 07 Sep 2014 16:21:54 +0200
Message-ID: <540C6A02.9070403@web.de>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Sep 07 16:22:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQdM1-0001Qk-0o
	for gcvg-git-2@plane.gmane.org; Sun, 07 Sep 2014 16:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbaIGOWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2014 10:22:03 -0400
Received: from mout.web.de ([212.227.17.12]:59269 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752193AbaIGOWB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2014 10:22:01 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LtFQN-1YOseW1Cqh-012tUO; Sun, 07 Sep 2014 16:21:55
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Provags-ID: V03:K0:PaCqTq7aWc4IIfPg1+8BeUlty/G/QbK3bYoFqdTs2URF2FpbT2R
 0wbMN4P/OpfzXIToG7FnAiII1UHr4k2iFvhGcEfV4nPIKHBpypieP0zfQD6aVSeYRNd9iht
 odkn20/PVjCTGB31ipoORy/KIQOXDyOEJEvUwRQv2dFJ/aCB665/AtAkQISD2rMtG8KtQGs
 frYjrC5xzT/581KNqDwcA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256621>


On 2014-09-06 09.50, Michael Haggerty wrote:
> Sorry for the long delay since v3. This version mostly cleans up a
> couple more places where the lockfile object was left in an
> ill-defined state. 
No problem with the delay.
The most important question is if we do the lk->active handling right.
Set it to false as seen as possible, and to true as late as possible,
then die() cleanly.
So the ->acive handling looks (more or less, please see below) and
deserves another critical review, may be.

Instead of commenting each patch, I collected a mixture of small questions
and possible suggestions into a diff file.

diff --git a/lockfile.c b/lockfile.c
index e54d260..7f27ea2 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -18,6 +18,10 @@
  *    Usually, if $FILENAME is a symlink, then it is resolved, and the
  *    file ultimately pointed to is the one that is locked and later
  *    replaced.  However, if LOCK_NODEREF is used, then $FILENAME
+LOCK_NODEREF can be read either as
+LOCK_NODE_REF or LOCK_NO_DEREF
+should we change it ?
+
  *    itself is locked and later replaced, even if it is a symlink.
  *
  * 2. Write the new file contents to the lockfile.
@@ -46,9 +50,18 @@
  *   state:
  *   - the lockfile exists
  *   - active is set
- *   - filename holds the filename of the lockfile
+ *   - filename holds the filename of the lockfile in a strbuf
  *   - fd holds a file descriptor open for writing to the lockfile
  *   - owner holds the PID of the process that locked the file
+question: Why do we need the PID here ?
+Do we open a lock file and do a fork() ?
+And if yes, the child gets a new PID, what happens when the
+child gets a signal ?
+Who "owns" the lockfile, the parent, the child, both ?
+The child has access to all data, the fd is open and can be used,
+why do we not allow a rollback, when the child dies ?
+
+
  *
  * - Locked, lockfile closed (after close_lock_file()).  Same as the
  *   previous state, except that the lockfile is closed and fd is -1.
@@ -57,7 +70,7 @@
  *   rollback_lock_file(), or a failed attempt to lock).  In this
  *   state:
  *   - active is unset
- *   - filename is the empty string (usually, though there are
+ *   - filename is an empty string buffer (usually, though there are
  *     transitory states in which this condition doesn't hold)
  *   - fd is -1
  *   - the object is left registered in the lock_file_list, and
@@ -68,7 +81,7 @@
 
 static struct lock_file *volatile lock_file_list;
 
-static void remove_lock_file(void)
+static void remove_lock_files(void)
 {
     pid_t me = getpid();
 
@@ -79,9 +92,9 @@ static void remove_lock_file(void)
     }
 }
 
-static void remove_lock_file_on_signal(int signo)
+static void remove_lock_files_on_signal(int signo)
 {
-    remove_lock_file();
+    remove_lock_files();
     sigchain_pop(signo);
     raise(signo);
 }
@@ -93,7 +106,7 @@ static void remove_lock_file_on_signal(int signo)
  * "/", if any).  If path is empty or the root directory ("/"), set
  * path to the empty string.
  */
-static void trim_last_path_elm(struct strbuf *path)
+static void trim_last_path_elem(struct strbuf *path)
 {
     int i = path->len;
 
@@ -143,7 +156,7 @@ static void resolve_symlink(struct strbuf *path)
              * link is a relative path, so replace the
              * last element of p with it.
              */
-            trim_last_path_elm(path);
+            trim_last_path_elem(path);
 
         strbuf_addbuf(path, &link);
     }
@@ -153,13 +166,16 @@ static void resolve_symlink(struct strbuf *path)
 /* Make sure errno contains a meaningful value on error */
 static int lock_file(struct lock_file *lk, const char *path, int flags)
 {
+    struct stat st;
+    int mode = 0666;
     if (!lock_file_list) {
         /* One-time initialization */
-        sigchain_push_common(remove_lock_file_on_signal);
-        atexit(remove_lock_file);
+        sigchain_push_common(remove_lock_files_on_signal);
+        atexit(remove_lock_files);
     }
 
-    assert(!lk->active);
+  if (lk->active)
+        die("lk->active %s", path);
 
     if (!lk->on_list) {
         /* Initialize *lk and add it to lock_file_list: */
@@ -167,16 +183,25 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
         lk->active = 0;
         lk->owner = 0;
         lk->on_list = 1;
-        strbuf_init(&lk->filename, 0);
+        strbuf_init(&lk->filename, strlen(path) + LOCK_SUFFIX_LEN);
         lk->next = lock_file_list;
         lock_file_list = lk;
     }
 
+    strbuf_reset(&lk->filename); /* Better to be save */
     strbuf_addstr(&lk->filename, path);
     if (!(flags & LOCK_NODEREF))
         resolve_symlink(&lk->filename);
     strbuf_addstr(&lk->filename, LOCK_SUFFIX);
-    lk->fd = open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
+    /*
+     * adjust_shared_perm() will widen permissions if needed,
+     * otherwise keep permissions restrictive
+     *
+     */
+    if (!stat(path, &st))
+        mode = st.st_mode & 07777;
+
+    lk->fd = open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, mode);
     if (lk->fd < 0) {
         strbuf_reset(&lk->filename);
         return -1;
@@ -268,7 +293,7 @@ int close_lock_file(struct lock_file *lk)
     return close(fd);
 }
 
-int reopen_lock_file(struct lock_file *lk)
+int reopen_lock_file_UNUSED_CAN_IT_BE_REMOVED(struct lock_file *lk)
 {
     if (0 <= lk->fd)
         die(_("BUG: reopen a lockfile that is still open"));
@@ -283,7 +308,7 @@ int commit_lock_file_to(struct lock_file *lk, const char *path)
     int save_errno;
 
     if (!lk->active)
-        die("BUG: attempt to commit unlocked object");
+        die("BUG: attempt to commit unlocked object %s", path);
 
     if (lk->fd >= 0 && close_lock_file(lk))
         goto rollback;
@@ -325,10 +350,12 @@ void rollback_lock_file(struct lock_file *lk)
 {
     if (!lk->active)
         return;
+    lk->active = 0; /* We are going to de-activate,
+                       so active is no longer valid already here ? */
 
     if (lk->fd >= 0)
         close_lock_file(lk);
     unlink_or_warn(lk->filename.buf);
-    lk->active = 0;
+    //lk->active = 0;
     strbuf_reset(&lk->filename);
 }
