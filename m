From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/23] expire_reflog(): use a lock_file for rewriting the reflog file
Date: Fri,  5 Dec 2014 00:08:19 +0100
Message-ID: <1417734515-11812-8-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:09:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfWD-0002vY-Qf
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825AbaLDXIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:08:55 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:44999 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933321AbaLDXIw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:08:52 -0500
X-AuditID: 1207440f-f792a6d000001284-d1-5480e98399e5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id CB.89.04740.389E0845; Thu,  4 Dec 2014 18:08:52 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8de4027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:08:50 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsUixO6iqNvysiHEoG8Rk0XXlW4mi4beK8wW
	b28uYbS4vWI+s0Vv3ydWi82b21kc2Dz+vv/A5LFz1l12jwWbSj0uXlL2+LxJLoA1itsmKbGk
	LDgzPU/fLoE74/GsiywFzyQrHvVfYm5gPCfSxcjJISFgItE++yIbhC0mceHeeiCbi0NI4DKj
	xIOHe1kgnGNMEt+mLGECqWIT0JVY1NMMZosIqEnMXDUbrINZ4ASjxK/J3YwgCWGBUIn9q8+y
	g9gsAqoS/19+AovzCrhILH9znLmLkQNonZzE1nXeIGFOAVeJqTNbwUqEgEqebVrIPoGRdwEj
	wypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXRO93MwSvdSU0k2MkODi38HYtV7mEKMAB6MSD2/B
	7voQIdbEsuLK3EOMkhxMSqK8Z582hAjxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4TU+ApTjTUms
	rEotyodJSXOwKInzqi9R9xMSSE8sSc1OTS1ILYLJynBwKEnwcr0AahQsSk1PrUjLzClBSDNx
	cIIM55ISKU7NS0ktSiwtyYgHxUZ8MTA6QFI8QHv/PgfZW1yQmAsUhWg9xagoJc57FiQhAJLI
	KM2DGwtLGa8YxYG+FOb9A1LFA0w3cN2vgAYzAQ0+21ALMrgkESEl1cAYv7FZ8PfGjVHL3NOj
	LI9/Se6ur9Xt1PKV03m+tMP8asjB5YlL3j2tdGx/KsQ3QfCb0iOpLT+aT23adpF3qrZsy97L
	fF9cZ688E/Fxpf73/JlLCr5xuYtF3Tz6uWLGj8Vf9rwrOh64/HaL0pTfnGUs76NV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260814>

We don't actually need the locking functionality, because we already
hold the lock on the reference itself, which is how the reflog file is
locked. But the lock_file code still does some of the bookkeeping for
us and is more careful than the old code here was.

For example:

* Correctly handle the case that the reflog lock file already exists
  for some reason or cannot be opened.

* Correctly clean up the lockfile if the program dies.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/reflog.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index a282e60..d344d45 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -349,12 +349,14 @@ static int push_tip_to_list(const char *refname, const unsigned char *sha1, int
 	return 0;
 }
 
+static struct lock_file reflog_lock;
+
 static int expire_reflog(const char *refname, const unsigned char *sha1, void *cb_data)
 {
 	struct cmd_reflog_expire_cb *cmd = cb_data;
 	struct expire_reflog_cb cb;
 	struct ref_lock *lock;
-	char *log_file, *newlog_path = NULL;
+	char *log_file;
 	struct commit *tip_commit;
 	struct commit_list *tips;
 	int status = 0;
@@ -372,10 +374,14 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
 		unlock_ref(lock);
 		return 0;
 	}
+
 	log_file = git_pathdup("logs/%s", refname);
 	if (!cmd->dry_run) {
-		newlog_path = git_pathdup("logs/%s.lock", refname);
-		cb.newlog = fopen(newlog_path, "w");
+		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0)
+			goto failure;
+		cb.newlog = fdopen_lock_file(&reflog_lock, "w");
+		if (!cb.newlog)
+			goto failure;
 	}
 
 	cb.cmd = cmd;
@@ -423,10 +429,9 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
 	}
 
 	if (cb.newlog) {
-		if (fclose(cb.newlog)) {
-			status |= error("%s: %s", strerror(errno),
-					newlog_path);
-			unlink(newlog_path);
+		if (close_lock_file(&reflog_lock)) {
+			status |= error("Couldn't write %s: %s", log_file,
+					strerror(errno));
 		} else if (cmd->updateref &&
 			(write_in_full(lock->lock_fd,
 				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
@@ -434,21 +439,23 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
 			 close_ref(lock) < 0)) {
 			status |= error("Couldn't write %s",
 					lock->lk->filename.buf);
-			unlink(newlog_path);
-		} else if (rename(newlog_path, log_file)) {
-			status |= error("cannot rename %s to %s",
-					newlog_path, log_file);
-			unlink(newlog_path);
+			rollback_lock_file(&reflog_lock);
+		} else if (commit_lock_file(&reflog_lock)) {
+			status |= error("cannot rename %s.lock to %s",
+					log_file, log_file);
 		} else if (cmd->updateref && commit_ref(lock)) {
 			status |= error("Couldn't set %s", lock->ref_name);
-		} else {
-			adjust_shared_perm(log_file);
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
