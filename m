From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 07/13] reflog.c: use a reflog transaction when writing during expire
Date: Thu,  4 Dec 2014 00:29:17 -0800
Message-ID: <1417681763-32334-8-git-send-email-sbeller@google.com>
References: <1417681763-32334-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 04 09:29:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwRnM-0005j2-Vg
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 09:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbaLDI3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 03:29:45 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:61332 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbaLDI3m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 03:29:42 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so14808672ieb.7
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 00:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i+uGkBiU4+wV8eI/YRY8d7qn103bHoqpL7dKNEK+QQM=;
        b=oTVKs2FE9+o18LYH8ujzXu1/QPKgTmchqpW4sy5EK/5aFxvl+tGN1o/9wnct2UR7SH
         JhSatpYGOeN1CTJZqN4tQJkhKdZc+sJJtCDgaXqZzOxjjt+yJmTJ50n5OkKfOLuN4m8x
         UHG2rCt9rn6t0b3U55O0Si0L7J6RP1dEwJiwI3mbtejKDsqAZtctlGH9um0+40Iimnuu
         pgN4YuJl/1llGTpTeOOF4vNxeBbD8M54EeDjGcRtSsQ9/wY5P6SdRCz3bHKt8V/MXJZ7
         lOmbQmeXJCTew2I1RswLW8wq8Vj7nVMexdlDpXUZlnlXn9lhOZDFPOE/Hhw7ruKmamer
         D2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i+uGkBiU4+wV8eI/YRY8d7qn103bHoqpL7dKNEK+QQM=;
        b=Bb98UTX0VqqW96UBMejYqR/AQDP4Fn5RPZ2BR7IBxYQHcU/k0Dd/TVcRbLXoV7f7Xp
         1zLpPlG8lcYO5kCyKhw4FECB3XQJyklLlibvXxqldwZjf2k9o/rUqT9GRB4VSxEtKoQs
         EKlRjJLJRi0n75v4r0QIbALqgekVPYUH9Wj5qZBpCfehBkjKQGyY0K6HDgY3iUAq2WMg
         UkFwD6iRXUsL18HEMZmX+VGVeb9ecmh0jiiaIseftv77I7JVj3QIOB5iY1y2+gBBz2EU
         jwX3GVhNgFqenhc9Ztm5AbbSbGemIIueMURfoZP4OuC5fjNzW2RSKMnUA1ah8qPQKtio
         yHdg==
X-Gm-Message-State: ALoCoQkhabp0SqjYwcA/lyCl1HkNbno2AKSC5twX8G/orDsvV0K+mdyp/B/dqemqgTjhtQT2j1Q1
X-Received: by 10.107.132.78 with SMTP id g75mr8581995iod.21.1417681781861;
        Thu, 04 Dec 2014 00:29:41 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5d2c:9a2d:3064:bc4])
        by mx.google.com with ESMTPSA id a1sm14054283ioa.27.2014.12.04.00.29.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 00:29:41 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417681763-32334-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260736>

From: Ronnie Sahlberg <sahlberg@google.com>

Use a transaction for all updates during expire_reflog.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    Jonathan writes:
    > This doesn't match the signature of each_reflog_ent_fn.  Would putting
    > err in the cb_data struct work?
    
    That's what I do in this update.

 builtin/reflog.c | 84 ++++++++++++++++++++++++--------------------------------
 1 file changed, 36 insertions(+), 48 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 2d85d26..e13427c 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -33,7 +33,8 @@ struct cmd_reflog_expire_cb {
 };
 
 struct expire_reflog_cb {
-	FILE *newlog;
+	struct transaction *t;
+	const char *refname;
 	enum {
 		UE_NORMAL,
 		UE_ALWAYS,
@@ -43,6 +44,7 @@ struct expire_reflog_cb {
 	unsigned long mark_limit;
 	struct cmd_reflog_expire_cb *cmd;
 	unsigned char last_kept_sha1[20];
+	struct strbuf *err;
 };
 
 struct collected_reflog {
@@ -316,20 +318,18 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
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
+					      email, timestamp, tz, message,
+					      cb->err))
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
@@ -353,29 +353,26 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 {
 	struct cmd_reflog_expire_cb *cmd = cb_data;
 	struct expire_reflog_cb cb;
-	struct ref_lock *lock;
-	char *log_file, *newlog_path = NULL;
 	struct commit *tip_commit;
 	struct commit_list *tips;
+	struct strbuf err = STRBUF_INIT;
 	int status = 0;
 
 	memset(&cb, 0, sizeof(cb));
+	cb.refname = ref;
+	cb.err = &err;
 
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
+	if (transaction_truncate_reflog(cb.t, cb.refname, &err)) {
+		status |= error("%s", err.buf);
+		goto cleanup;
 	}
-
 	cb.cmd = cmd;
 
 	if (!cmd->expire_unreachable || !strcmp(ref, "HEAD")) {
@@ -407,7 +404,10 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 		mark_reachable(&cb);
 	}
 
-	for_each_reflog_ent(ref, expire_reflog_ent, &cb);
+	if (for_each_reflog_ent(ref, expire_reflog_ent, &cb)) {
+		status |= error("%s", err.buf);
+		goto cleanup;
+	}
 
 	if (cb.unreachable_expire_kind != UE_ALWAYS) {
 		if (cb.unreachable_expire_kind == UE_HEAD) {
@@ -420,32 +420,20 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
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
2.2.0
