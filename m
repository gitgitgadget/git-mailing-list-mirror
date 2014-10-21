From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 11/15] reflog.c: use a reflog transaction when writing during expire
Date: Tue, 21 Oct 2014 12:24:18 -0700
Message-ID: <1413919462-3458-12-git-send-email-sahlberg@google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:31:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgf9u-0003lN-NF
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 21:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932860AbaJUTbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 15:31:47 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:58864 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932856AbaJUTbk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 15:31:40 -0400
Received: by mail-vc0-f202.google.com with SMTP id hy10so124733vcb.1
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 12:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kvvyVS42Ox6TTSCE4mDs3p4OvD0aTcg5tPwQzGd/jIU=;
        b=PeiBwzWRGcI9IbGwr74HWgbsjg7mCLEWp5mdgGM7jLTNt8KJBxJso9lS0rzzCqksIX
         6OfrnGKTAOEfGxesjIqRyTeELT7SkWI4K+y9Y2yHKqW42h8bl6clkh4UPer0OF8NLpvA
         I6kFOENZyDG8IUOeGtiQyq/OzsJcqg0QuRHWIFChsnqrFOdrZZdKQGzKVr1UGa0z7Vjd
         nyYrdf9OCc7pI/do6NW2u8Hck8bRSYq/U36bRKLoyxqBq1IVZv+0qqOPef1dWflEY65Q
         t8oQgdo649veAt6rpI5cjQg5PwYQH+b1ZG+vTuxYbwOEBjYdluCzKa6+F1lBzTxLQq0k
         3ZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kvvyVS42Ox6TTSCE4mDs3p4OvD0aTcg5tPwQzGd/jIU=;
        b=Qsia7LSm3hnJ6XBaK5DhA0+ng9C4lElNvuEm7DJFddV9GaVfffjTFEpwTdcWuO7cxu
         glspI0ZKpqZ2jlibLdecHOzDwtz3VYHeosKA9CeQWrkIIoUU2XiYkPmZVWBz8wqhlqmi
         9aRpADDuI9fwCEzFjS0DYoYKRz/Is7Wu6HnuFKkvIcgi6VjiK61E9TA/4wl+GxeuXJlr
         9WZh0K1rYIUVP6JHtdh4xcISletVah0vjoWz3ofegPiO7CBQhQL9QzZeBLfWbR82qsuS
         L7q2WmjJx4tXC+O4NgE9joMLv7D3WJgfgQ2ckOQHNsQV/uGIkGo6unppOoti+Pqc2M8V
         iahg==
X-Gm-Message-State: ALoCoQntZBSj2QhrOB6M3x7bFxsw1hpHuleWj/O8lZSrYU4BLTvaYSxsdbxckv5uHBZmQ3LO/lN8
X-Received: by 10.236.104.233 with SMTP id i69mr23498009yhg.37.1413919899631;
        Tue, 21 Oct 2014 12:31:39 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id s23si586946yhf.0.2014.10.21.12.31.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 12:31:39 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id Fex7D8Na.1; Tue, 21 Oct 2014 12:31:39 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A1001E10B8; Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.728.g406752a
In-Reply-To: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit 5ac378cd8fad09a836d17fec379780854838bde5 upstream.

Use a transaction for all updates during expire_reflog.

Change-Id: Ieb81b2660cefeeecf0bcb3cdbc1ef3cbb86e7eb8
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
index f7e947f..3189f11 100644
--- a/refs.c
+++ b/refs.c
@@ -3620,7 +3620,7 @@ int transaction_update_reflog(struct transaction *transaction,
 			      const char *refname,
 			      const unsigned char *new_sha1,
 			      const unsigned char *old_sha1,
-			      const unsigned char *email,
+			      const char *email,
 			      unsigned long timestamp, int tz,
 			      const char *msg, int flags,
 			      struct strbuf *err)
@@ -3901,7 +3901,7 @@ int transaction_commit(struct transaction *transaction,
 
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
