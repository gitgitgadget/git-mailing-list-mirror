From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/24] expire_reflog(): use a lock_file for rewriting the reflog file
Date: Fri, 12 Dec 2014 09:56:46 +0100
Message-ID: <1418374623-5566-8-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:58:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM3L-0005Ff-N7
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934699AbaLLI6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:58:19 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:59490 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934049AbaLLI5W (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:22 -0500
X-AuditID: 1207440e-f79d26d000001b6e-4f-548aadf1539d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 4C.45.07022.1FDAA845; Fri, 12 Dec 2014 03:57:22 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nH023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:20 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqPtpbVeIQdsXJouuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFps3t7M4sHn8ff+ByWPnrLvsHgs2lXpcvKTs8XmTXABrFLdNUmJJ
	WXBmep6+XQJ3xp0bbSwFlxUrlkxYxNjAeEuqi5GTQ0LAROLL8pvsELaYxIV769m6GLk4hAQu
	M0psnnmYHcI5xiTR1XWFCaSKTUBXYlFPM5gtIqAmMbHtEAuIzSxwglFidkNIFyMHh7BAhMSp
	ziyQMIuAqsT5l5/YQMK8As4SHd1uIKaEgJzE1nXeIBWcAi4SF1uegA0RAqrYuqKTdQIj7wJG
	hlWMcok5pbm6uYmZOcWpybrFyYl5ealFusZ6uZkleqkppZsYIWHFt4Oxfb3MIUYBDkYlHt4J
	yV0hQqyJZcWVuYcYJTmYlER5v08GCvEl5adUZiQWZ8QXleakFh9ilOBgVhLh/RsFlONNSays
	Si3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfAeXQPUKFiUmp5akZaZU4KQZuLg
	BBnOJSVSnJqXklqUWFqSEQ+KivhiYFyApHiA9rKtBdlbXJCYCxSFaD3FqCglznsaZK4ASCKj
	NA9uLCxZvGIUB/pSmPcMSBUPMNHAdb8CGswENHj5lg6QwSWJCCmpBsbedNY7tVP0TCI3ayrd
	3yfav8SUxd+t9mywzqqWqAhHDYOUy16bGZtOVYtc/lZtolq76euceUL+v0V9tGaLKWmU/dP1
	mquq7CfjHbWT9Sz7rclPTjxI+HNmfn6ry5R/VVNX3JnyXlatw+rR0SiuY7cTzujL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261340>

We don't actually need the locking functionality, because we already
hold the lock on the reference itself, which is how the reflog file is
locked. But the lock_file code can do some of the bookkeeping for us,
and it is more careful than the old code here was. For example:

* It correctly handles the case that the reflog lock file already
  exists for some reason or cannot be opened.

* It correctly cleans up the lockfile if the program dies.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/reflog.c | 60 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 37b33c9..ba5b3d3 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -352,9 +352,10 @@ static int push_tip_to_list(const char *refname, const unsigned char *sha1, int
 static int expire_reflog(const char *refname, const unsigned char *sha1,
 			 struct cmd_reflog_expire_cb *cmd)
 {
+	static struct lock_file reflog_lock;
 	struct expire_reflog_cb cb;
 	struct ref_lock *lock;
-	char *log_file, *newlog_path = NULL;
+	char *log_file;
 	struct commit *tip_commit;
 	struct commit_list *tips;
 	int status = 0;
@@ -362,8 +363,9 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 	memset(&cb, 0, sizeof(cb));
 
 	/*
-	 * we take the lock for the ref itself to prevent it from
-	 * getting updated.
+	 * The reflog file is locked by holding the lock on the
+	 * reference itself, plus we might need to update the
+	 * reference if --updateref was specified:
 	 */
 	lock = lock_any_ref_for_update(refname, sha1, 0, NULL);
 	if (!lock)
@@ -372,10 +374,29 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 		unlock_ref(lock);
 		return 0;
 	}
+
 	log_file = git_pathdup("logs/%s", refname);
 	if (!cmd->dry_run) {
-		newlog_path = git_pathdup("logs/%s.lock", refname);
-		cb.newlog = fopen(newlog_path, "w");
+		/*
+		 * Even though holding $GIT_DIR/logs/$reflog.lock has
+		 * no locking implications, we use the lock_file
+		 * machinery here anyway because it does a lot of the
+		 * work we need, including cleaning up if the program
+		 * exits unexpectedly.
+		 */
+		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0) {
+			struct strbuf err = STRBUF_INIT;
+			unable_to_lock_message(log_file, errno, &err);
+			error("%s", err.buf);
+			strbuf_release(&err);
+			goto failure;
+		}
+		cb.newlog = fdopen_lock_file(&reflog_lock, "w");
+		if (!cb.newlog) {
+			error("cannot fdopen %s (%s)",
+			      reflog_lock.filename.buf, strerror(errno));
+			goto failure;
+		}
 	}
 
 	cb.cmd = cmd;
@@ -423,32 +444,33 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 	}
 
 	if (cb.newlog) {
-		if (fclose(cb.newlog)) {
-			status |= error("%s: %s", strerror(errno),
-					newlog_path);
-			unlink(newlog_path);
+		if (close_lock_file(&reflog_lock)) {
+			status |= error("couldn't write %s: %s", log_file,
+					strerror(errno));
 		} else if (cmd->updateref &&
 			(write_in_full(lock->lock_fd,
 				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
 			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
 			 close_ref(lock) < 0)) {
-			status |= error("Couldn't write %s",
+			status |= error("couldn't write %s",
 					lock->lk->filename.buf);
-			unlink(newlog_path);
-		} else if (rename(newlog_path, log_file)) {
-			status |= error("cannot rename %s to %s",
-					newlog_path, log_file);
-			unlink(newlog_path);
+			rollback_lock_file(&reflog_lock);
+		} else if (commit_lock_file(&reflog_lock)) {
+			status |= error("unable to commit reflog '%s' (%s)",
+					log_file, strerror(errno));
 		} else if (cmd->updateref && commit_ref(lock)) {
-			status |= error("Couldn't set %s", lock->ref_name);
-		} else {
-			adjust_shared_perm(log_file);
+			status |= error("couldn't set %s", lock->ref_name);
 		}
 	}
-	free(newlog_path);
 	free(log_file);
 	unlock_ref(lock);
 	return status;
+
+ failure:
+	rollback_lock_file(&reflog_lock);
+	free(log_file);
+	unlock_ref(lock);
+	return -1;
 }
 
 static int collect_reflog(const char *ref, const unsigned char *sha1, int unused, void *cb_data)
-- 
2.1.3
