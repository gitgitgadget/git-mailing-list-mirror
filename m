From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 32/35] Extract a function commit_lock_file_to()
Date: Tue, 16 Sep 2014 21:33:53 +0200
Message-ID: <1410896036-12750-33-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:43:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTyen-0004Cx-8J
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303AbaIPTnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:43:11 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:50620 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755232AbaIPTmi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:42:38 -0400
X-AuditID: 12074412-f792e6d000005517-52-541890e88980
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 1D.45.21783.8E098145; Tue, 16 Sep 2014 15:35:04 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBca001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:35:03 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqPtigkSIwYNWG4uuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFv8m1Fh0dnxldGD3+Pv+A5PHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DOeLpjA0tBg17Fk7u8DYybVLsYOTkkBEwkpi1oZYSw
	xSQu3FvP1sXIxSEkcJlRYuHMOWwgCSGBE0wSU3ZpgdhsAroSi3qamUCKRATaGCV2XdzMCuIw
	C3QzSrw/cZoJpEpYwEli97xOVhCbRUBVYtqFPWCTeAVcJW6+O8cMsU5OYsPu/0CrOTg4geJf
	9xWAmEICLhIH7/pNYORdwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXTC83s0QvNaV0EyMk
	6IR2MK4/KXeIUYCDUYmH1+OReIgQa2JZcWXuIUZJDiYlUd5/3RIhQnxJ+SmVGYnFGfFFpTmp
	xYcYJTiYlUR4f/gC5XhTEiurUovyYVLSHCxK4rw/F6v7CQmkJ5akZqemFqQWwWRlODiUJHhv
	9gM1ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIPiIr4YGBkgKR6gvR9B2nmLCxJz
	gaIQracYdTnWdX7rZxJiycvPS5US57UBKRIAKcoozYNbAUsxrxjFgT4W5n0HUsUDTE9wk14B
	LWECWnK2RwxkSUkiQkqqgTG/e8kW2csf9r+XD0iWcDh3Z+dK+/T/ZsYf1Mr2zeQv4e2bP885
	raXipcycwrJzny1VetQ0llztaDa2i/qle6TlimfnfdcbcodPTVY7q8vQ/2juhH0M 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257180>

commit_locked_index(), when writing to an alternate index file,
duplicates (poorly) the code in commit_lock_file(). And anyway, it
shouldn't have to know so much about the internal workings of lockfile
objects. So extract a new function commit_lock_file_to() that does the
work common to the two functions, and call it from both
commit_lock_file() and commit_locked_index().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-lockfile.txt | 14 ++++++++----
 cache.h                                  |  1 +
 lockfile.c                               | 39 +++++++++++++++++++++-----------
 read-cache.c                             | 13 +++--------
 4 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index 2514559..3ee4299 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -73,6 +73,12 @@ commit_lock_file::
 	`commit_lock_file()` for a `lock_file` object that is not
 	currently locked.
 
+commit_lock_file_to::
+
+	Like `commit_lock_file()`, except that it takes an explicit
+	`path` argument to which the lockfile should be renamed. The
+	`path` must be on the same filesystem as the lock file.
+
 rollback_lock_file::
 
 	Take a pointer to the `struct lock_file` initialized
@@ -91,10 +97,10 @@ Because the structure is used in an `atexit(3)` handler, its
 storage has to stay throughout the life of the program.  It
 cannot be an auto variable allocated on the stack.
 
-Call `commit_lock_file()` or `rollback_lock_file()` when you are
-done writing to the file descriptor.  If you do not call either
-and simply `exit(3)` from the program, an `atexit(3)` handler
-will close and remove the lockfile.
+Call `commit_lock_file()`, `commit_lock_file_to()`, or
+`rollback_lock_file()` when you are done writing to the file
+descriptor. If you do not call either and simply `exit(3)` from the
+program, an `atexit(3)` handler will close and remove the lockfile.
 
 If you need to close the file descriptor you obtained from
 `hold_lock_file_for_update` function yourself, do so by calling
diff --git a/cache.h b/cache.h
index 307cc8e..45688d5 100644
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
index 3d5ab4f..480c2ba 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -58,8 +58,9 @@
  * - Locked, lockfile closed (after close_lock_file()).  Same as the
  *   previous state, except that the lockfile is closed and fd is -1.
  *
- * - Unlocked (after commit_lock_file(), rollback_lock_file(), or a
- *   failed attempt to lock).  In this state:
+ * - Unlocked (after commit_lock_file(), commit_lock_file_to(),
+ *   rollback_lock_file(), or a failed attempt to lock).  In this
+ *   state:
  *   - active is unset
  *   - filename is empty (usually, though there are transitory
  *     states in which this condition doesn't hold)
@@ -290,24 +291,16 @@ int reopen_lock_file(struct lock_file *lk)
 	return lk->fd;
 }
 
-int commit_lock_file(struct lock_file *lk)
+int commit_lock_file_to(struct lock_file *lk, const char *path)
 {
-	static struct strbuf result_file = STRBUF_INIT;
 	int save_errno;
-	int err;
 
 	if (!lk->active)
-		die("BUG: attempt to commit unlocked object");
+		die("BUG: attempt to commit unlocked object to \"%s\"", path);
 
 	if (lk->fd >= 0 && close_lock_file(lk))
 		goto rollback;
-
-	/* remove ".lock": */
-	strbuf_add(&result_file, lk->filename.buf,
-		   lk->filename.len - LOCK_SUFFIX_LEN);
-	err = rename(lk->filename.buf, result_file.buf);
-	strbuf_reset(&result_file);
-	if (err)
+	if (rename(lk->filename.buf, path))
 		goto rollback;
 	lk->active = 0;
 	strbuf_reset(&lk->filename);
@@ -320,6 +313,26 @@ rollback:
 	return -1;
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
index c126916..f3eb5e9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2023,17 +2023,10 @@ void set_alternate_index_output(const char *name)
 
 static int commit_locked_index(struct lock_file *lk)
 {
-	if (alternate_index_output) {
-		if (lk->fd >= 0 && close_lock_file(lk))
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
