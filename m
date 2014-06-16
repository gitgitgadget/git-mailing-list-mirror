From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 11/14] reflog.c: use a reflog transaction when writing during expire
Date: Mon, 16 Jun 2014 09:51:42 -0700
Message-ID: <1402937505-6091-12-git-send-email-sahlberg@google.com>
References: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 18:52:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwa97-00035X-Sq
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 18:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbaFPQwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 12:52:04 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:51384 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241AbaFPQvw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 12:51:52 -0400
Received: by mail-ve0-f201.google.com with SMTP id jz11so851793veb.4
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tnkoX8+HBIpa6KmVRutUVbpqEMuTmOBpQx2YMvTHxvs=;
        b=PTuRyfx1vuBU5pnj9FSn0Ve+RKY0WFsppChHzI2mYSiTNCPKtQaWv1pPBrcov/hZFw
         EkM39VmEqZDFrrWSzYkpRmH4yj9rCcCmg97S7eTKHAlS1Anq2ri7jh6CwM9jmh3UzmlE
         XvoyBYxBVTJCes5s5pnJQaCa/d0zJm5so778voY5cMvdzIPYi8VEvcN4+oUyWPj792yN
         sz50R/N6y/Ggnfdd5IjZR6JZ5ZB5tYg0+WSFveUduemw1C9dtrWgZAOo1JhgQCXlnkbM
         TMGkZvdlpHAZBn0+MbDj5fVhJOt2sXaOIXVOMGbxj7ZJLtzQm6hXx+Cz9/VRFU6qnnKD
         xV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tnkoX8+HBIpa6KmVRutUVbpqEMuTmOBpQx2YMvTHxvs=;
        b=cDuOaDa8CmBgsnN4UNRCOWRXgy9aK/oEsccOiP2VtJ6TkvlSe6Xom7zYZmtuH9JrNY
         zy3QKJZHYNT0Z9AelhnU/Tc/jN+8gQLsxBCBK2fU7s/DqufZd+Zq5SpNS++U+MvG4JQp
         3LMxQ65eVk3nlbXNczLI8cRr0kZC0+zKi4L3Ygy7a8KCx/wRkKOEyy+Cu/OaYQfyY2gd
         zDjK/k5qltdHk2P30qi/69x9LYPqFClezBEPKQLdVL46IGbbcwXCtxBT5JMFrpSX0DDI
         Wpe+jEuta7oPVzQHDFgXt5Nt2OJdASC3e4LBUDzA+gOa6fbwUQWlxWTSGhjRTzUsUAp9
         n7ig==
X-Gm-Message-State: ALoCoQmE5rp4KJH+nl5tgTX6Ps7OIRVF0WGNzTqUzhQj37ut9ECkKKVdRbBfrbU2KNAfxWRAwwWb
X-Received: by 10.236.141.11 with SMTP id f11mr2542635yhj.54.1402937509872;
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si983797yhb.3.2014.06.16.09.51.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A855531C675;
	Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 41DE1E0EC6; Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.770.gd892650.dirty
In-Reply-To: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251728>

Use a transaction for all updates during expire_reflog.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/reflog.c | 85 ++++++++++++++++++++++++--------------------------------
 refs.c           |  4 +--
 refs.h           |  2 +-
 3 files changed, 39 insertions(+), 52 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index d45344a..c3db3fb 100644
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
-		newlog_path = mkpathdup("%s.lock", log_file);
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
@@ -420,32 +421,18 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
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
-		}
+	if (!cmd->dry_run) {
+		if (cmd->updateref &&
+		    transaction_update_sha1(cb.t, cb.refname,
+					    cb.last_kept_sha1, sha1,
+					    0, 1, NULL, &err)) {
+			status |= error("%s", err.buf);
+		} else if (transaction_commit(cb.t, &err))
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
index 3b90457..4069da1 100644
--- a/refs.c
+++ b/refs.c
@@ -3514,7 +3514,7 @@ int transaction_update_reflog(struct ref_transaction *transaction,
 			      const char *refname,
 			      const unsigned char *new_sha1,
 			      const unsigned char *old_sha1,
-			      const unsigned char *email,
+			      const char *email,
 			      unsigned long timestamp, int tz,
 			      const char *msg, int flags,
 			      struct strbuf *err)
@@ -3790,7 +3790,7 @@ int transaction_commit(struct ref_transaction *transaction,
 
 	/*
 	 * Update all reflog files
-	 * We have already done all ref updates and deletes.
+	 * We have already committed all ref updates and deletes.
 	 * There is not much we can do here if there are any reflog
 	 * update errors other than complain.
 	 */
diff --git a/refs.h b/refs.h
index b0e339b..e321721 100644
--- a/refs.h
+++ b/refs.h
@@ -342,7 +342,7 @@ int transaction_update_reflog(struct ref_transaction *transaction,
 			      const char *refname,
 			      const unsigned char *new_sha1,
 			      const unsigned char *old_sha1,
-			      const unsigned char *email,
+			      const char *email,
 			      unsigned long timestamp, int tz,
 			      const char *msg, int flags,
 			      struct strbuf *err);
-- 
2.0.0.770.gd892650.dirty
