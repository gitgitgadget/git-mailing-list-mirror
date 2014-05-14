From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 10/31] reflog.c: use a reflog transaction when writing during expire
Date: Wed, 14 May 2014 15:13:09 -0700
Message-ID: <1400105610-21194-11-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:15:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhSO-0000lQ-C2
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbaENWPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:15:04 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:34994 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbaENWNg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:36 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so56762obc.4
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I4p2HW0DBc+tlzaT5kVolWFR8EDn7t8mUoQI70VI3Uc=;
        b=one+LHbvu1yCOW0YpDVHQKWnwOLVeQkIoEZ89wjKAYKiBh6MDqfwh2LsUyQxSlYCCj
         hLttGh/yIP58vzqqVaEcG8SvYtsIXydGgyzL2lLCkE3+H9nsqqf7h+HPkHegsIFKDMCp
         0Y8Cu1HajDEPyG84XMK5RnhTco0n1VWskTJNNMpFniPQfhgguIQRPOS1ABU2T1JSy0dQ
         5cqGbGyKC0ywo/fCH2mZ5OWynLoaVHwaK5AjXQuUPrTbuvTlrDsmqUG4p5x8um+u1GUA
         v0lmLcjhj2vjxOeWirTn2HNz0cKmh6cLQjqk481UbauOTVnN0MPYxcOssSuKvfxLiTJl
         mbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I4p2HW0DBc+tlzaT5kVolWFR8EDn7t8mUoQI70VI3Uc=;
        b=dWGxXlOEx8hnpjDI7fbp3o/ce1qEGfU8OJ+VJY4F1+xTtzWaagbTc7ktXz5vfFCzgX
         Ls44yqlEkvRVIhy3MtZBDCun4xA0ttOfyJmzkMynpHvwAC+2Eu8RkA3058fKd9E+n572
         m6OSrm2H/B/GmStDhF1tInJFV+VUIBa3Cxp8cwzjlvazo8Uo7IZzewoC0kbE86DQq/ZL
         oGkXPiKnSLaUU/+qS+7lwPDADcrD5ffZLUjT4IXB0RwbknOKo2PKwDmSs8Fb3jm3z2M4
         Fr2Jjl3mmA9SRvUSoi0+Lkydzv7DupwY4eFAyg4vcQVnV0YbBQ117sCmiANfxgDWcAMv
         fvHg==
X-Gm-Message-State: ALoCoQmX+njvNKfdkhlLCP/I2DZgLY8QsEggRicJ0zQhMhdq2B/3N43iZqfrvu2vP7n0yuIdzREX
X-Received: by 10.182.106.229 with SMTP id gx5mr3144719obb.31.1400105615945;
        Wed, 14 May 2014 15:13:35 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id h18si153002yhj.0.2014.05.14.15.13.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:35 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id AD0495A41E5;
	Wed, 14 May 2014 15:13:35 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6DE41E0973; Wed, 14 May 2014 15:13:35 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249035>

Use a transaction when doing the updates of the reflog during expire_reflog.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/reflog.c | 54 ++++++++++++++++++++++--------------------------------
 refs.c           |  4 ++--
 2 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index e8a8fb1..5f07647 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -33,7 +33,8 @@ struct cmd_reflog_expire_cb {
 };
 
 struct expire_reflog_cb {
-	FILE *newlog;
+	struct ref_transaction *t;
+	const char *refname;
 	enum {
 		UE_NORMAL,
 		UE_ALWAYS,
@@ -316,20 +317,16 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	if (cb->cmd->recno && --(cb->cmd->recno) == 0)
 		goto prune;
 
-	if (cb->newlog) {
-		char sign = (tz < 0) ? '-' : '+';
-		int zone = (tz < 0) ? (-tz) : tz;
-		fprintf(cb->newlog, "%s %s %s %lu %c%04d\t%s",
-			sha1_to_hex(osha1), sha1_to_hex(nsha1),
-			email, timestamp, sign, zone,
-			message);
+	if (cb->t) {
+		transaction_update_reflog(cb->t, cb->refname, nsha1, osha1,
+					  email, timestamp, tz, message, 0);
 		hashcpy(cb->last_kept_sha1, nsha1);
 	}
 	if (cb->cmd->verbose)
 		printf("keep %s", message);
 	return 0;
  prune:
-	if (!cb->newlog)
+	if (!cb->t)
 		printf("would prune %s", message);
 	else if (cb->cmd->verbose)
 		printf("prune %s", message);
@@ -354,12 +351,12 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	struct cmd_reflog_expire_cb *cmd = cb_data;
 	struct expire_reflog_cb cb;
 	struct ref_lock *lock;
-	char *log_file, *newlog_path = NULL;
 	struct commit *tip_commit;
 	struct commit_list *tips;
 	int status = 0;
 
 	memset(&cb, 0, sizeof(cb));
+	cb.refname = ref;
 
 	/*
 	 * we take the lock for the ref itself to prevent it from
@@ -368,12 +365,14 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	lock = lock_any_ref_for_update(ref, sha1, 0, NULL);
 	if (!lock)
 		return error("cannot lock ref '%s'", ref);
-	log_file = git_pathdup("logs/%s", ref);
 	if (!reflog_exists(ref))
 		goto finish;
 	if (!cmd->dry_run) {
-		newlog_path = git_pathdup("logs/%s.lock", ref);
-		cb.newlog = fopen(newlog_path, "w");
+		cb.t = transaction_begin();
+		transaction_update_reflog(cb.t, cb.refname,
+					  null_sha1, null_sha1, NULL,
+					  0, 0, NULL,
+					  REFLOG_TRUNCATE);
 	}
 
 	cb.cmd = cmd;
@@ -420,31 +419,22 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 		}
 	}
  finish:
-	if (cb.newlog) {
-		if (fclose(cb.newlog)) {
-			status |= error("%s: %s", strerror(errno),
-					newlog_path);
-			unlink(newlog_path);
-		} else if (cmd->updateref &&
-			(write_in_full(lock->lock_fd,
-				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
-			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
-			 close_ref(lock) < 0)) {
+	if (cb.t) {
+		if (cmd->updateref &&
+		    (write_in_full(lock->lock_fd,
+				   sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
+		     write_str_in_full(lock->lock_fd, "\n") != 1 ||
+		     close_ref(lock) < 0)) {
 			status |= error("Couldn't write %s",
 				lock->lk->filename);
-			unlink(newlog_path);
-		} else if (rename(newlog_path, log_file)) {
-			status |= error("cannot rename %s to %s",
-					newlog_path, log_file);
-			unlink(newlog_path);
+			transaction_rollback(cb.t);
+		} else if (transaction_commit(cb.t, NULL)) {
+			status |= error("cannot commit reflog for %s", ref);
 		} else if (cmd->updateref && commit_ref(lock)) {
 			status |= error("Couldn't set %s", lock->ref_name);
-		} else {
-			adjust_shared_perm(log_file);
 		}
+		transaction_free(cb.t);
 	}
-	free(newlog_path);
-	free(log_file);
 	unlock_ref(lock);
 	return status;
 }
diff --git a/refs.c b/refs.c
index e7ede03..5a5f9df 100644
--- a/refs.c
+++ b/refs.c
@@ -2766,8 +2766,8 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 		      committer);
 	if (msglen)
 		len += copy_msg(logrec + len - 1, msg) - 1;
-	written = len <= maxlen ? write_in_full(fd, logrec, len) : -1;
 
+	written = len <= maxlen ? write_in_full(fd, logrec, len) : -1;
 	free(logrec);
 	if (written != len)
 		return -1;
@@ -3634,7 +3634,7 @@ int transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
-	/* Update all reflog files
+	/* Update all reflog files.
 	   We have already done all ref updates and deletes.
 	   There is not much we can do here if there are any reflog
 	   update errors, other than complain.
-- 
2.0.0.rc3.506.g3739a35
