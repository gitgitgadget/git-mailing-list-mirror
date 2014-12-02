From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/4] reflog.c: use a reflog transaction when writing during expire
Date: Mon,  1 Dec 2014 18:02:32 -0800
Message-ID: <1417485752-10502-4-git-send-email-sbeller@google.com>
References: <1417485752-10502-1-git-send-email-sbeller@google.com>
To: jrnieder@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 03:02:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvcnl-0006yi-BM
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 03:02:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211AbaLBCCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 21:02:40 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:60954 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158AbaLBCCi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 21:02:38 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so15542046igb.2
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 18:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=9A+21wtPK8MKtdUwJYxjPOl0iyn0KOBJa3Bsi3KMRhw=;
        b=I9MAD54fD9ihMHj38phxsnbsUF9mhBmKyJekV3XTvGJfTNdFXI15VlMSaLyUC/jHMQ
         1f1kTJwsaWya6LByZjw3olsvT3KE3dK+oClbdL8DuaQZ7Kv8aNYPIRYcbo6WhJOGZVE0
         Ll2GFMmUyW7ToeUP6fMY3PbcCOeOJrctDbjFOvkWPVTV0IkxByEDH9NpwDJO0VYWcYye
         sKXTyUOPCTIwG8lNNftQy1syiicSRol8QTPquuhVeLKLlJELe3J0eeCaEoTd6NiDYRS2
         cwHWlrL4CkXjOISNcxETCVWKTdJt3UZZVvdjBA9hNi9ixcfEwEERxwbx5qynUpRTYas9
         v/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=9A+21wtPK8MKtdUwJYxjPOl0iyn0KOBJa3Bsi3KMRhw=;
        b=jvXq2TlYs91OMtlQ3nPzt0W3kSwSq5enPIJEwm/0mpv1FqlEnnsWJXXi8WqSUtFwWV
         YeoSvDla8wzG4MqddlKqioacDIu9i0AWriWXEKm3CtFVGBLtThFXol/U3ErwUq8zHWQ8
         qZmrc5POaWYHlnNu5BWY5eyPh2MA2DcXyl7FL8lTPdKicn5s4biFFECm5jeZjHbbfB44
         d3gT7UmxK1Dzyq3O8oIVfzJS6GgXcKLJ/ZT99q47WRc9TP4Dd19ims/8VzL76HvaCK9W
         NhigKN0+Wl+2NWlmEdhhztpuE4AgFCE4oKNenyCZnNVQZcw7jN4cM4CVzep123OeBEx+
         hHCw==
X-Gm-Message-State: ALoCoQmLCikMFDhKi06Gn11fhOAJX9q70ltJBVRVUA9T3vTh0OE8jlukC/cRhSA8OPLR2xinYLZB
X-Received: by 10.107.149.13 with SMTP id x13mr31882358iod.35.1417485757243;
        Mon, 01 Dec 2014 18:02:37 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:21e7:446b:f329:a30a])
        by mx.google.com with ESMTPSA id b3sm575080igl.2.2014.12.01.18.02.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Dec 2014 18:02:36 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417485752-10502-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260521>

From: Ronnie Sahlberg <sahlberg@google.com>

Use a transaction for all updates during expire_reflog.

Change-Id: Ieb81b2660cefeeecf0bcb3cdbc1ef3cbb86e7eb8
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
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
2.2.0
