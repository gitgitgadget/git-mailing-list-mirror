From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 32/32] Extract a function commit_lock_file_to()
Date: Sat,  6 Sep 2014 09:50:46 +0200
Message-ID: <1409989846-22401-33-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:52:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAnl-0000ZE-PS
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbaIFHws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:52:48 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42594 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751332AbaIFHwo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:52:44 -0400
X-AuditID: 12074413-f79ed6d000002501-12-540abd4be490
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 3B.53.09473.B4DBA045; Sat,  6 Sep 2014 03:52:43 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFHV006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:42 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixO6iqOu9lyvE4ME7LYuuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujKnT9rEUXNSu+NUxk6WBcbtyFyMnh4SAicS1HQcYIWwxiQv31rN1
	MXJxCAlcZpQ4c/o2M4RzjEni+J5mZpAqNgFdiUU9zUwgCRGBNkaJXRc3s4IkmAVSJDqed4ON
	EhZwknh06CGYzSKgKnH703mgZg4OXgFXic2PAiC2yUls2P0frIQTKDy9qRPMFhJwkWg/2c80
	gZF3ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQQBPewbjrpNwhRgEO
	RiUe3gIHrhAh1sSy4srcQ4ySHExKorx5y4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHg7JgPl
	eFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvM17gBoFi1LTUyvSMnNK
	ENJMHJwgw7mkRIpT81JSixJLSzLiQbERXwyMDpAUD9DeRpB23uKCxFygKETrKUZdjnWd3/qZ
	hFjy8vNSpcR5mUCKBECKMkrz4FbA0sorRnGgj4V5J4JU8QBTEtykV0BLmICWmKdzgiwpSURI
	STUwzrPfqHLwdVynQ3fW/l95C3p/1d96WRa7a63mVddV006sPrl6Ukj/+zkXXu7gmvTi9peT
	lvkrj4tyBPS3ucduPte4gWOHVET+Eu/1a0W83Wecf1C5tjzjsmfElgMqNzLKc/o9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256563>

commit_locked_index(), when writing to an alternate index file,
duplicates (poorly) the code in commit_lock_file(). And anyway, it
shouldn't have to know so much about the internal workings of lockfile
objects. So extract a new function commit_lock_file_to() that does the
work common to the two functions, and call it from both
commit_lock_file() and commit_locked_index().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-lockfile.txt | 14 ++++++++++----
 cache.h                                  |  1 +
 lockfile.c                               | 30 ++++++++++++++++++------------
 read-cache.c                             | 13 +++----------
 4 files changed, 32 insertions(+), 26 deletions(-)

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
index bea6296..cda91fc 100644
--- a/cache.h
+++ b/cache.h
@@ -589,6 +589,7 @@ extern void unable_to_lock_message(const char *path, int err,
 extern NORETURN void unable_to_lock_die(const char *path, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
+extern int commit_lock_file_to(struct lock_file *, const char *path);
 extern int commit_lock_file(struct lock_file *);
 extern int reopen_lock_file(struct lock_file *);
 extern void update_index_if_able(struct index_state *, struct lock_file *);
diff --git a/lockfile.c b/lockfile.c
index 4c6e720..e54d260 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -53,8 +53,9 @@
  * - Locked, lockfile closed (after close_lock_file()).  Same as the
  *   previous state, except that the lockfile is closed and fd is -1.
  *
- * - Unlocked (after commit_lock_file(), rollback_lock_file(), or a
- *   failed attempt to lock).  In this state:
+ * - Unlocked (after commit_lock_file(), commit_lock_file_to(),
+ *   rollback_lock_file(), or a failed attempt to lock).  In this
+ *   state:
  *   - active is unset
  *   - filename is the empty string (usually, though there are
  *     transitory states in which this condition doesn't hold)
@@ -277,24 +278,16 @@ int reopen_lock_file(struct lock_file *lk)
 	return lk->fd;
 }
 
-int commit_lock_file(struct lock_file *lk)
+int commit_lock_file_to(struct lock_file *lk, const char *path)
 {
-	static struct strbuf result_file = STRBUF_INIT;
 	int save_errno;
-	int err;
 
 	if (!lk->active)
 		die("BUG: attempt to commit unlocked object");
 
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
@@ -307,6 +300,19 @@ rollback:
 	return -1;
 }
 
+int commit_lock_file(struct lock_file *lk)
+{
+	static struct strbuf result_file = STRBUF_INIT;
+	int err;
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
index 158241d..11b80a0 100644
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
