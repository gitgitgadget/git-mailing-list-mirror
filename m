From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 11/11] reflog.c: use a reflog transaction when writing during expire
Date: Wed,  4 Jun 2014 11:57:52 -0700
Message-ID: <1401908272-7600-12-git-send-email-sahlberg@google.com>
References: <1401908272-7600-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 20:59:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsGP3-0008BH-Cn
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 20:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbaFDS6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 14:58:25 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:50087 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbaFDS6I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 14:58:08 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so1817777obc.2
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qgzytnv1b+tMjPA/ZpAkJapk3MwMbyjQ/Y0XDp6cMGw=;
        b=dZxz3qb0Loe/ZGTdgBxbLcUtki5qKnBxf6njGE8C31jtZKrd3U0w7epH8BXXL5zh2B
         FUUme9kdWG6v8+gS70dDPpavTu4tSZMZQzFl+x27xGREqcQqkZdDDZHW8JyHwrLhRHjX
         P9QCxLQTfhnmv+BkvZ5Yx+KloSL2jmaRjpDbDfr3Hbhn80ZALnAvoor2TVlzQT8dUtox
         kZh8anfq+ipSPcHW3D8JzBthiBaNnTA3xyq0FIiKJtuE/FfI+EZ2SSab1ybXMAvQ4Wh8
         fBHgrJZUFae9FNj5Pygi600MXZpYx2qA1PnhScfKwxOInOf9JPd1syICQ2iUU5m7TrBA
         +HRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qgzytnv1b+tMjPA/ZpAkJapk3MwMbyjQ/Y0XDp6cMGw=;
        b=BfSOVzTG6gTe5E/noPQH6mYPuIciYJYA3OmJVEa6frG70P9PJe234E53JKk1I8VDjG
         4dusxvne3p8gKHK0nZicDhnvmLUHe4UpmgyCInBILKgVYl672j5Vv5oUmf9M/7+mCDbY
         D8PzJosJizhXpoFO5t796gafhpd9W0aSJU6hznIoAzyoO8H+1z+bu3Heu6sXgcNzYtdy
         lfEA3BiA7ByL2pVgnYDgx+bDlJKVQjzIQYJ/3KJeIVjPV3urpgQSI7jNPTsZ3eBMwGxt
         tme7ahwtjLk28SKMvEHA6t2dqqd0C9JqlC9h8ywBnRELXWbqqx98/HFXMHUluUP8i0sh
         Nn4w==
X-Gm-Message-State: ALoCoQknHs77MzPeFMrL/Y00JbL7dM626xYk8/ECCJD91bm9YcoHdT+zR3KWwUtpmPjKWfPSUbqn
X-Received: by 10.50.80.13 with SMTP id n13mr3219202igx.0.1401908287315;
        Wed, 04 Jun 2014 11:58:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si330911yhp.6.2014.06.04.11.58.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jun 2014 11:58:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 112952F42FC;
	Wed,  4 Jun 2014 11:58:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BD4F0E0E3B; Wed,  4 Jun 2014 11:58:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.578.gb9e379f
In-Reply-To: <1401908272-7600-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250770>

Use a transaction for all updates during expire_reflog.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/reflog.c | 84 ++++++++++++++++++++++++--------------------------------
 refs.c           |  2 +-
 2 files changed, 37 insertions(+), 49 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index e8a8fb1..f11fee3 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -32,8 +32,11 @@ struct cmd_reflog_expire_cb {
 	int recno;
 };
 
+static struct strbuf err = STRBUF_INIT;
+
 struct expire_reflog_cb {
-	FILE *newlog;
+	struct ref_transaction *t;
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
@@ -420,32 +421,19 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
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
-				lock->lk->filename);
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
+		    transaction_update_sha1(cb.t, cb.refname,
+					    cb.last_kept_sha1, sha1,
+					    0, 1, NULL, &err)) {
+			status |= error("%s", err.buf);
+		} else if (transaction_commit(cb.t, &err)) {
+			status |= error("%s", err.buf);
 		}
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
index eb64d8b..767baf9 100644
--- a/refs.c
+++ b/refs.c
@@ -3741,7 +3741,7 @@ int transaction_commit(struct ref_transaction *transaction,
 
 	/*
 	 * Update all reflog files
-	 * We have already done all ref updates and deletes.
+	 * We have already committed all ref updates and deletes.
 	 * There is not much we can do here if there are any reflog
 	 * update errors other than complain.
 	 */
-- 
2.0.0.578.gb9e379f
