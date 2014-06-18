From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 11/14] reflog.c: use a reflog transaction when writing during expire
Date: Wed, 18 Jun 2014 10:09:03 -0700
Message-ID: <1403111346-18466-12-git-send-email-sahlberg@google.com>
References: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:09:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJMk-0007A7-MR
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605AbaFRRJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:09:32 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:42353 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919AbaFRRJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:09:10 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so300920oag.3
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IuEFiF6JtppCtjECVeEioymKdNFZf9QvodB7z3ZgQ1s=;
        b=XlQnmtBUzCsEdEKVBp96aItQY67m/x1n6R0zjzKy7xUetehGSqZXuRLJvwXusqeuHY
         Ld6l2LeLLvmiW1BdakxthSS8COj1g1D86tr1SsSSMTM+kQZAJixPg8emGeLSPPvuxrz/
         q3MNugxsvc4Q8is2aD9DNERnMU1tpmiSPHKIVPlO3FE6Mwh7jcSV0hiXRZbbo2OHd+yf
         DsPiuZTQzu6eFScNhMT7fGjqvU/1NPHpAeYx3n/vPfaTi0XAR7/qq9IHRC0woBIi79SY
         +MGpF8F4argM9JXaVxusma7j4cf+ABNegk7wNj6ERtBPkFyDog6xCbn0oMtIiSWGtc1R
         diog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IuEFiF6JtppCtjECVeEioymKdNFZf9QvodB7z3ZgQ1s=;
        b=P0DrkcpTRFkeDBZfGnu4ybx9HWFICUG3uoChKjVAmT3iX8XXPs/uOoYfzIrPCVIHsQ
         r6wDWR4RkhSsrX7PYRBKd5pxYZe81sJK1YEEYEEmnPk+F5nMFhiXeUKcRqpv7uLX8HBB
         mXhUWMVaFZs8omO516dtcnOF0n1ldk1n6np5ikeLspDZh9ZLILIFxDEeFb07ehXln2N2
         ClT+FW9QwzKrMgajurFEXIeGxMESukpvjJv2XiPDYGmAdvVfALc8Tt4HHClUxAzrIxD9
         lYou2oNhcVoSHqssUc7xQom3eOe7Q7ry0WDQgt/LGB2Yjr3zC5W1RFblvIuPosXuu3dH
         3ReA==
X-Gm-Message-State: ALoCoQnG7XFNO7Iydk4vdlNt7vELVuQpk74k2wYaqSGg9+rQHaqK/Q5GFucX2nE28OnZGuM9mii2
X-Received: by 10.43.124.136 with SMTP id go8mr1147862icc.26.1403111350199;
        Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si172923yhj.5.2014.06.18.10.09.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id F169731C80E;
	Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A0DCBE1167; Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.467.g08c0633
In-Reply-To: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252000>

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
index ad60231..1288c49 100644
--- a/refs.c
+++ b/refs.c
@@ -3493,7 +3493,7 @@ int transaction_update_reflog(struct ref_transaction *transaction,
 			      const char *refname,
 			      const unsigned char *new_sha1,
 			      const unsigned char *old_sha1,
-			      const unsigned char *email,
+			      const char *email,
 			      unsigned long timestamp, int tz,
 			      const char *msg, int flags,
 			      struct strbuf *err)
@@ -3769,7 +3769,7 @@ int transaction_commit(struct ref_transaction *transaction,
 
 	/*
 	 * Update all reflog files
-	 * We have already done all ref updates and deletes.
+	 * We have already committed all ref updates and deletes.
 	 * There is not much we can do here if there are any reflog
 	 * update errors other than complain.
 	 */
diff --git a/refs.h b/refs.h
index 1d7906c..0564955 100644
--- a/refs.h
+++ b/refs.h
@@ -343,7 +343,7 @@ int transaction_update_reflog(struct ref_transaction *transaction,
 			      const char *refname,
 			      const unsigned char *new_sha1,
 			      const unsigned char *old_sha1,
-			      const unsigned char *email,
+			      const char *email,
 			      unsigned long timestamp, int tz,
 			      const char *msg, int flags,
 			      struct strbuf *err);
-- 
2.0.0.467.g08c0633
