From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/7] make reflog filename independent from struct ref_lock
Date: Fri, 26 Jan 2007 17:26:05 -0500
Message-ID: <1169850371517-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 23:26:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAZWT-0004Os-Ju
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 23:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbXAZW0N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 17:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbXAZW0N
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 17:26:13 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60997 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbXAZW0M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 17:26:12 -0500
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCH00AEPYBNA4H0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 26 Jan 2007 17:26:11 -0500 (EST)
X-Mailer: git-send-email 1.5.0.rc2.g6e2c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37887>

This allows for ref_log_write() to be used in a more flexible way,
and is needed for future changes.

This is only code reorg with no behavior change.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-reflog.c |   10 ++++++----
 refs.c           |   44 ++++++++++++++++++++++----------------------
 refs.h           |    1 -
 3 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index b443ed9..b6612a9 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -242,7 +242,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	struct cmd_reflog_expire_cb *cmd = cb_data;
 	struct expire_reflog_cb cb;
 	struct ref_lock *lock;
-	char *newlog_path = NULL;
+	char *log_file, *newlog_path = NULL;
 	int status = 0;
 
 	if (strncmp(ref, "refs/", 5))
@@ -255,7 +255,8 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	lock = lock_ref_sha1(ref + 5, sha1);
 	if (!lock)
 		return error("cannot lock ref '%s'", ref);
-	if (!file_exists(lock->log_file))
+	log_file = xstrdup(git_path("logs/%s", ref));
+	if (!file_exists(log_file))
 		goto finish;
 	if (!cmd->dry_run) {
 		newlog_path = xstrdup(git_path("logs/%s.lock", ref));
@@ -271,13 +272,14 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 		if (fclose(cb.newlog))
 			status |= error("%s: %s", strerror(errno),
 					newlog_path);
-		if (rename(newlog_path, lock->log_file)) {
+		if (rename(newlog_path, log_file)) {
 			status |= error("cannot rename %s to %s",
-					newlog_path, lock->log_file);
+					newlog_path, log_file);
 			unlink(newlog_path);
 		}
 	}
 	free(newlog_path);
+	free(log_file);
 	unlock_ref(lock);
 	return status;
 }
diff --git a/refs.c b/refs.c
index 4323e9a..9395677 100644
--- a/refs.c
+++ b/refs.c
@@ -676,7 +676,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
 
 	lock->ref_name = xstrdup(ref);
-	lock->log_file = xstrdup(git_path("logs/%s", ref));
 	ref_file = git_path("%s", ref);
 	lock->force_write = lstat(ref_file, &st) && errno == ENOENT;
 
@@ -772,10 +771,10 @@ int delete_ref(const char *refname, unsigned char *sha1)
 	 */
 	ret |= repack_without_ref(refname);
 
-	err = unlink(lock->log_file);
+	err = unlink(git_path("logs/%s", lock->ref_name));
 	if (err && errno != ENOENT)
 		fprintf(stderr, "warning: unlink(%s) failed: %s",
-			lock->log_file, strerror(errno));
+			git_path("logs/%s", lock->ref_name), strerror(errno));
 	invalidate_cached_refs();
 	unlock_ref(lock);
 	return ret;
@@ -916,46 +915,47 @@ void unlock_ref(struct ref_lock *lock)
 			rollback_lock_file(lock->lk);
 	}
 	free(lock->ref_name);
-	free(lock->log_file);
 	free(lock);
 }
 
-static int log_ref_write(struct ref_lock *lock,
-	const unsigned char *sha1, const char *msg)
+static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
+			 const unsigned char *new_sha1, const char *msg)
 {
 	int logfd, written, oflags = O_APPEND | O_WRONLY;
 	unsigned maxlen, len;
-	char *logrec;
+	char *log_file, *logrec;
 	const char *committer;
 
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
 
+	log_file = git_path("logs/%s", ref_name);
+
 	if (log_all_ref_updates &&
-	    (!strncmp(lock->ref_name, "refs/heads/", 11) ||
-	     !strncmp(lock->ref_name, "refs/remotes/", 13))) {
-		if (safe_create_leading_directories(lock->log_file) < 0)
+	    (!strncmp(ref_name, "refs/heads/", 11) ||
+	     !strncmp(ref_name, "refs/remotes/", 13))) {
+		if (safe_create_leading_directories(log_file) < 0)
 			return error("unable to create directory for %s",
-				lock->log_file);
+				     log_file);
 		oflags |= O_CREAT;
 	}
 
-	logfd = open(lock->log_file, oflags, 0666);
+	logfd = open(log_file, oflags, 0666);
 	if (logfd < 0) {
 		if (!(oflags & O_CREAT) && errno == ENOENT)
 			return 0;
 
 		if ((oflags & O_CREAT) && errno == EISDIR) {
-			if (remove_empty_directories(lock->log_file)) {
+			if (remove_empty_directories(log_file)) {
 				return error("There are still logs under '%s'",
-					     lock->log_file);
+					     log_file);
 			}
-			logfd = open(lock->log_file, oflags, 0666);
+			logfd = open(log_file, oflags, 0666);
 		}
 
 		if (logfd < 0)
 			return error("Unable to append to %s: %s",
-				     lock->log_file, strerror(errno));
+				     log_file, strerror(errno));
 	}
 
 	committer = git_committer_info(-1);
@@ -963,8 +963,8 @@ static int log_ref_write(struct ref_lock *lock,
 		maxlen = strlen(committer) + strlen(msg) + 2*40 + 5;
 		logrec = xmalloc(maxlen);
 		len = snprintf(logrec, maxlen, "%s %s %s\t%s\n",
-			sha1_to_hex(lock->old_sha1),
-			sha1_to_hex(sha1),
+			sha1_to_hex(old_sha1),
+			sha1_to_hex(new_sha1),
 			committer,
 			msg);
 	}
@@ -972,15 +972,15 @@ static int log_ref_write(struct ref_lock *lock,
 		maxlen = strlen(committer) + 2*40 + 4;
 		logrec = xmalloc(maxlen);
 		len = snprintf(logrec, maxlen, "%s %s %s\n",
-			sha1_to_hex(lock->old_sha1),
-			sha1_to_hex(sha1),
+			sha1_to_hex(old_sha1),
+			sha1_to_hex(new_sha1),
 			committer);
 	}
 	written = len <= maxlen ? write_in_full(logfd, logrec, len) : -1;
 	free(logrec);
 	close(logfd);
 	if (written != len)
-		return error("Unable to append to %s", lock->log_file);
+		return error("Unable to append to %s", log_file);
 	return 0;
 }
 
@@ -1003,7 +1003,7 @@ int write_ref_sha1(struct ref_lock *lock,
 		return -1;
 	}
 	invalidate_cached_refs();
-	if (log_ref_write(lock, sha1, logmsg) < 0) {
+	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0) {
 		unlock_ref(lock);
 		return -1;
 	}
diff --git a/refs.h b/refs.h
index 33450f1..2d2ba14 100644
--- a/refs.h
+++ b/refs.h
@@ -3,7 +3,6 @@
 
 struct ref_lock {
 	char *ref_name;
-	char *log_file;
 	struct lock_file *lk;
 	unsigned char old_sha1[20];
 	int lock_fd;
-- 
1.5.0.rc2.g6e2c
