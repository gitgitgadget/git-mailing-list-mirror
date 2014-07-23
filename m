From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 11/15] reflog.c: use a reflog transaction when writing during expire
Date: Wed, 23 Jul 2014 10:03:51 -0700
Message-ID: <1406135035-26441-12-git-send-email-sahlberg@google.com>
References: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 19:04:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9zyF-0004nO-KZ
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 19:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbaGWREe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 13:04:34 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:41900 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932503AbaGWREA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 13:04:00 -0400
Received: by mail-ie0-f201.google.com with SMTP id tr6so416781ieb.4
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z7cpVkgQlj0V5AZAHuQEVAYAF7bkJ+udyIyBV6zyUjg=;
        b=N79d2weVckFRt/F2WH3iXEdyuEe4SutnqjdUv1g7tBHTR2aUQOpIAu7sThx8sggX3s
         MX5g8I+wddu5tLMgkKSRhhTh3uctn+tT95/SBGZ6ajjfKQ3WzPOwvZ/5uKR8eeNHBsmr
         xQ2a+yI/j2bHcwLlmbBj7qBcmicaXSO9M6TTWHu8XVBuCwTBS3E8eRyyV0s0FbEJCO2y
         g4pLDRMvEq+oLEW8Qp4gZYLGeG5J5fhPJg0ld8RkkBLWywMaFtYVgip3wWNODPap5guB
         TIt0LKOowwWBlK1aUR3vbbzjcGWZJLoUUTjmgBZhZlAK0ahIfzLbeMbtyz58n+Pj7aSG
         QQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z7cpVkgQlj0V5AZAHuQEVAYAF7bkJ+udyIyBV6zyUjg=;
        b=IJJVQI70EmoXpUdiRt1JPyUmxGIX7XG9BlohN5YItm6+Wkbx10BpxRKwwsoGqiIrSc
         CXuMuai4ykHHgUBlTQaciUX1yTe9FIO1i5r3wQjeQt930RSAofa34UE79GWbzB9t5wKn
         NCkaxToOaho+pjfud97WR7EM7UiQXl3gyRoNhGFxsQ4UFnh2DM1iHOYi1azZjdxQfErO
         Dbb10XB+DGwO6ld0UJ/3f6w1cF47IR0P/fm5qCYJanyaC3KjWhXXQNrErlyGYrna7ijN
         QNSEwWvyQc+clSw5HG8qGZ3bDVoj/Analfn6xD0URGWW+Io/JiKdpUXlhIRz/qBMzQqX
         9Iyw==
X-Gm-Message-State: ALoCoQmpdDoiW0nUTJv1J89mr9j42kMGTQWlR5UiLDEjDkoeQK5NjI1RUQODJ/0eMaDTySLa9H8e
X-Received: by 10.42.133.200 with SMTP id i8mr1306773ict.14.1406135039131;
        Wed, 23 Jul 2014 10:03:59 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j43si486951yhh.5.2014.07.23.10.03.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 10:03:59 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id DE8155A44A3;
	Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9E978E0670; Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.508.g763ab16
In-Reply-To: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254088>

Use a transaction for all updates during expire_reflog.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/reflog.c | 84 ++++++++++++++++++++++++--------------------------------
 refs.c           |  4 +--
 refs.h           |  2 +-
 3 files changed, 39 insertions(+), 51 deletions(-)

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
index 12ff916..4231fad 100644
--- a/refs.c
+++ b/refs.c
@@ -3490,7 +3490,7 @@ int transaction_update_reflog(struct ref_transaction *transaction,
 			      const char *refname,
 			      const unsigned char *new_sha1,
 			      const unsigned char *old_sha1,
-			      const unsigned char *email,
+			      const char *email,
 			      unsigned long timestamp, int tz,
 			      const char *msg, int flags,
 			      struct strbuf *err)
@@ -3775,7 +3775,7 @@ int transaction_commit(struct ref_transaction *transaction,
 
 	/*
 	 * Update all reflog files
-	 * We have already done all ref updates and deletes.
+	 * We have already committed all ref updates and deletes.
 	 * There is not much we can do here if there are any reflog
 	 * update errors other than complain.
 	 */
diff --git a/refs.h b/refs.h
index a8b7047..9ad12fe 100644
--- a/refs.h
+++ b/refs.h
@@ -336,7 +336,7 @@ int transaction_update_reflog(struct ref_transaction *transaction,
 			      const char *refname,
 			      const unsigned char *new_sha1,
 			      const unsigned char *old_sha1,
-			      const unsigned char *email,
+			      const char *email,
 			      unsigned long timestamp, int tz,
 			      const char *msg, int flags,
 			      struct strbuf *err);
-- 
2.0.1.508.g763ab16
