From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 11/15] reflog.c: use a reflog transaction when writing during expire
Date: Mon,  3 Nov 2014 08:55:53 -0800
Message-ID: <1415033757-9539-12-git-send-email-sahlberg@google.com>
References: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 17:56:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlKvj-0001jq-Oi
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 17:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbaKCQ4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 11:56:21 -0500
Received: from mail-qg0-f73.google.com ([209.85.192.73]:64856 "EHLO
	mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbaKCQ4H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 11:56:07 -0500
Received: by mail-qg0-f73.google.com with SMTP id z107so738965qgd.4
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 08:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BlL6FDxetqBM+CPESXU00A/OoDCJ2QX1F1yNqstxIuM=;
        b=ddi7q5iF6bHspXY3UqMgM7X21qrlz85cPqPZEfJ7pZvR3eNJQhADsJRbyCpI07CDtA
         F7Gs3XHPrLSv+8KdjyF4WLKxKMRyz8RkfyqErd51iWrJV4NA4ZAC/XIhuzR3WtpRWAuy
         M/U2Al1YY2WQhC686PNaF0ue2pP+3jc7wr3W4jp3Lzf0lFieR5H5+pqI2bWbTPNY54L1
         u2pe/xDif4R/oHZxBGETQB5HOcEfB/rbEdHS2VsUkgCx5CD0B26HklT7W98T6mugQ7UR
         q6olF6NNMcYoIJ1tqBMZ5m2eqHgc1hC1AgJstxFgrbcbQJxM6fspUMBYrYNzlbLHluUj
         QYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BlL6FDxetqBM+CPESXU00A/OoDCJ2QX1F1yNqstxIuM=;
        b=WFyaEjYx0s4C0ku55HmRlKAeF3V0JbaaK916oxFBFFAq+xTZw+85r7pKnmz2YLcL0B
         s8HswjcvbRVpBfqoeEnOJy6JHbZ8q7sC4ckt7/sPlNQP8QXv8D+Rckl9D9ISfb1omhvZ
         Wa7iZxlhgzPSqNEIOMDmn9cvzFgxgeiAfmaGWrocc6jQ2EB3SZrt9n/prvQ25yl8URyB
         mxQDg4xziQo609K6Pg7vH6z0BhI1LXaaNYdrQ+f3NMEquPmcGeIlJm3s5dfb52zQr9wg
         zGIAdoFNyHu9Y5nqEkn8FoQdkzQmzpDKVqJlLlC0o4Q/SAIvT/nLYlIdNAYv0EsoAu1b
         aXPg==
X-Gm-Message-State: ALoCoQmLthwCu+/mlGN0poyydXwvbhvhLlll8MNhL4/8Nu4/oC8Q0YTdOXBcWawH0b+BWemXx/4I
X-Received: by 10.236.22.106 with SMTP id s70mr19817501yhs.7.1415033764223;
        Mon, 03 Nov 2014 08:56:04 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id s23si959287yhf.0.2014.11.03.08.56.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 08:56:04 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id w7NlcWZ8.2; Mon, 03 Nov 2014 08:56:04 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8BADCE10A1; Mon,  3 Nov 2014 08:56:02 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use a transaction for all updates during expire_reflog.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/reflog.c | 85 ++++++++++++++++++++++++--------------------------------
 refs.c           |  4 +--
 refs.h           |  2 +-
 3 files changed, 40 insertions(+), 51 deletions(-)

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
 
diff --git a/refs.c b/refs.c
index 1c3e674..a4bdfaf 100644
--- a/refs.c
+++ b/refs.c
@@ -3622,7 +3622,7 @@ int transaction_update_reflog(struct transaction *transaction,
 			      const char *refname,
 			      const unsigned char *new_sha1,
 			      const unsigned char *old_sha1,
-			      const unsigned char *email,
+			      const char *email,
 			      unsigned long timestamp, int tz,
 			      const char *msg, int flags,
 			      struct strbuf *err)
@@ -3903,7 +3903,7 @@ int transaction_commit(struct transaction *transaction,
 
 	/*
 	 * Update all reflog files
-	 * We have already done all ref updates and deletes.
+	 * We have already committed all ref updates and deletes.
 	 * There is not much we can do here if there are any reflog
 	 * update errors other than complain.
 	 */
diff --git a/refs.h b/refs.h
index bf96b36..9f70b89 100644
--- a/refs.h
+++ b/refs.h
@@ -343,7 +343,7 @@ int transaction_update_reflog(struct transaction *transaction,
 			      const char *refname,
 			      const unsigned char *new_sha1,
 			      const unsigned char *old_sha1,
-			      const unsigned char *email,
+			      const char *email,
 			      unsigned long timestamp, int tz,
 			      const char *msg, int flags,
 			      struct strbuf *err);
-- 
2.1.0.rc2.206.gedb03e5
