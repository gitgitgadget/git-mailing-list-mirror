From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/4] reflog.c: use a reflog transaction when writing during expire
Date: Wed, 26 Nov 2014 21:34:45 -0800
Message-ID: <1417066485-24921-5-git-send-email-sbeller@google.com>
References: <20141120181701.GB15945@google.com>
 <1417066485-24921-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, gitster@pobox.com, mhagger@alum.mit.edu,
	jrnieder@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 06:35:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtrjJ-0005DC-0d
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 06:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbaK0Fez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2014 00:34:55 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:57613 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbaK0Fey (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2014 00:34:54 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so3967623ieb.21
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 21:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NdW7Ah3xrOoRLYtSFZEh5ZI302zvLDbuWyCTCs4HuN4=;
        b=KXtsfTnooB+sWt/368TleQBnDnskEynr7UlB8JEEaRjfx2Q9S9c2aMCaDh1NiaeLwk
         z/mviZLzQds/MBNJoQC5tbgQ+OLQ0+sfQplLqn+E+8Z85mB7rgC/l9pSptYUKuhqGvsM
         cGdZy9+T2yNOV3Z3D91LDPAt3PJxEsyxkNuyc0KmbLqAhtP29dVsKsawX19LyQ3iNghq
         qMPUjdyDjzRn7VGPzrFn6I1Rf+GX4Z4vnzHJA7Id1UrVRHLEJFqwz2O1R65porcI9Otp
         1BobWRwayGraxnGmC3aQ/nFBbZK9cuh+dW0pEZwdOWLEg5wsRoxLjBOLUg40d5OjxYcg
         +qFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NdW7Ah3xrOoRLYtSFZEh5ZI302zvLDbuWyCTCs4HuN4=;
        b=JWn/tvlh15wG2yJv1RhD9mTJGbn8Y/V52xz3ddPZQ1BiPPgRxJg4wTxT2Yu5SnS3UU
         a8Oxv+adK2FQX+IYZ3IhCSomYzXmFKGYP/8su2+/MU4hVXMY8tzkN1hjN6vm/bE64oxZ
         cHzCH0s7YTDooswXk4LBREDWAinD45UXRh7QnrLH2F2o1smvW8O35/GZqWSVRZvDf5Mn
         blPTpKULmZ5QF1UmkQOSzIF4XIoiSlTngFCOLDKxYwCw+z0D1Y00R03m0N2X0AkNnuqs
         aoNEyMBfhlopeMJKOcwagOTEtnv/ze4S85I/yYW5oBE5ue7pE7JzzBQwZ+DQBP7/Flha
         8ioA==
X-Gm-Message-State: ALoCoQlCf4Fpbfm/rXPQCT+OBJsxVmBLJCFBrFN3I5pKRQ4oG3VMpZ52KoGqVq2NY4OxtRm3z2ER
X-Received: by 10.50.43.197 with SMTP id y5mr26215156igl.33.1417066493175;
        Wed, 26 Nov 2014 21:34:53 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:3190:a053:325e:48b2])
        by mx.google.com with ESMTPSA id d140sm3103114ioe.38.2014.11.26.21.34.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Nov 2014 21:34:52 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc3
In-Reply-To: <1417066485-24921-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260337>

From: Ronnie Sahlberg <sahlberg@google.com>

Use a transaction for all updates during expire_reflog.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/reflog.c | 85 ++++++++++++++++++++++++--------------------------------
 1 file changed, 37 insertions(+), 48 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 2d85d26..6bb7454 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -32,8 +32,11 @@ struct cmd_reflog_expire_cb {
 	int recno;
 };
 
+static struct strbuf err = STRBUF_INIT;
+
 struct expire_reflog_cb {
-	FILE *newlog;
+	struct transaction *t;
+	const char *refname;
 	enum {
 		UE_NORMAL,
 		UE_ALWAYS,
@@ -316,20 +319,18 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
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
+		if (transaction_update_reflog(cb->t, cb->refname, nsha1, osha1,
+					      email, timestamp, tz, message, 0,
+					      &err))
+			return -1;
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
@@ -353,29 +354,26 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 {
 	struct cmd_reflog_expire_cb *cmd = cb_data;
 	struct expire_reflog_cb cb;
-	struct ref_lock *lock;
-	char *log_file, *newlog_path = NULL;
 	struct commit *tip_commit;
 	struct commit_list *tips;
 	int status = 0;
 
 	memset(&cb, 0, sizeof(cb));
+	cb.refname = ref;
 
-	/*
-	 * we take the lock for the ref itself to prevent it from
-	 * getting updated.
-	 */
-	lock = lock_any_ref_for_update(ref, sha1, 0, NULL);
-	if (!lock)
-		return error("cannot lock ref '%s'", ref);
-	log_file = git_pathdup("logs/%s", ref);
 	if (!reflog_exists(ref))
 		goto finish;
-	if (!cmd->dry_run) {
-		newlog_path = git_pathdup("logs/%s.lock", ref);
-		cb.newlog = fopen(newlog_path, "w");
+	cb.t = transaction_begin(&err);
+	if (!cb.t) {
+		status |= error("%s", err.buf);
+		goto cleanup;
+	}
+	if (transaction_update_reflog(cb.t, cb.refname, null_sha1, null_sha1,
+				      NULL, 0, 0, NULL, REFLOG_TRUNCATE,
+				      &err)) {
+		status |= error("%s", err.buf);
+		goto cleanup;
 	}
-
 	cb.cmd = cmd;
 
 	if (!cmd->expire_unreachable || !strcmp(ref, "HEAD")) {
@@ -407,7 +405,10 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 		mark_reachable(&cb);
 	}
 
-	for_each_reflog_ent(ref, expire_reflog_ent, &cb);
+	if (for_each_reflog_ent(ref, expire_reflog_ent, &cb)) {
+		status |= error("%s", err.buf);
+		goto cleanup;
+	}
 
 	if (cb.unreachable_expire_kind != UE_ALWAYS) {
 		if (cb.unreachable_expire_kind == UE_HEAD) {
@@ -420,32 +421,20 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
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
-			status |= error("Couldn't write %s",
-					lock->lk->filename.buf);
-			unlink(newlog_path);
-		} else if (rename(newlog_path, log_file)) {
-			status |= error("cannot rename %s to %s",
-					newlog_path, log_file);
-			unlink(newlog_path);
-		} else if (cmd->updateref && commit_ref(lock)) {
-			status |= error("Couldn't set %s", lock->ref_name);
-		} else {
-			adjust_shared_perm(log_file);
+	if (!cmd->dry_run) {
+		if (cmd->updateref &&
+		    transaction_update_ref(cb.t, cb.refname,
+					   cb.last_kept_sha1, sha1,
+					   0, 1, NULL, &err)) {
+			status |= error("%s", err.buf);
+			goto cleanup;
 		}
+		if (transaction_commit(cb.t, &err))
+			status |= error("%s", err.buf);
 	}
-	free(newlog_path);
-	free(log_file);
-	unlock_ref(lock);
+ cleanup:
+	transaction_free(cb.t);
+	strbuf_release(&err);
 	return status;
 }
 
-- 
2.2.0.rc3
