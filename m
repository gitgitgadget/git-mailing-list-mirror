From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 43/44] refs.c: make rename_ref use a transaction
Date: Thu, 15 May 2014 10:29:58 -0700
Message-ID: <1400174999-26786-44-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:31:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzVL-0001TL-IC
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755781AbaEORbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:31:10 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:48764 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755701AbaEORaK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:10 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so288779obc.0
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GSQJyiv71IUDEGRQow/rAyhhQad33YEqQhmZO+j8B1I=;
        b=QaEyAMsM8SyhNJQo26pNkZ//42YUHFffsvQwi2JtHnRxyOQulddUXwRJuZ6Zb2vzJq
         gTqSV00RFzmW0KRS3XGweIO3PGxU5Xq+OS2SkgRd4GCGmPGX2yh1ewtw9EewHRf+rMRu
         g0K0GuvHG3ax/BTbYp5amSH/VWQ0oy392Kv9e8yG2oXPPtiVFL1lhMfYAA8PG9sIJYfp
         V1y8kHwQ2zsyF1wIB0PzfTMSnHIQLZ6L6av8uaJEDX6qxCz17UY75nTZiv8fuo1koeWe
         9awtxPFpqcVbc5WXFA+rzBme8Fq5W/59dfJ8W5A9QEM39ADUyQpgRAH+q9Dfps44x2DN
         CCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GSQJyiv71IUDEGRQow/rAyhhQad33YEqQhmZO+j8B1I=;
        b=b/Aw40993xwVqn4QEJjRdgUD05xE08g94FohJ30Yv5lupXXLotfOCremlgtQy2q5wo
         jDunFq49lXApIf4DymQtqUiaWXqXSORocTw9BFtE43KYKLyjMH+BZqCP8eK6/y9weT9x
         HgohWCEYqr/GtDLkSsXx3gEpoSyMr7SRaCpQ1YIObAgcEr0C6adJgrfV9VBedneKxvtV
         223tlxdxhfHZy/S7BXYOJTdFrA3JPJvSJv+SAoBXUw0J40BfurScpQ9LSDdye2GFGnf0
         dC7xbVnrmBKtL/D6ApaZBRhyS7Szhp2nQPH6ZhxcQbX83olOrkAwLlbzWhhikAl/194k
         /YfQ==
X-Gm-Message-State: ALoCoQkrNC3o4gc5qowrnAxhjI+ja2v7Lv0I1pv2QMemIzRp0houtZ11j1glu1GsT3J0QQGuCL+E
X-Received: by 10.182.252.166 with SMTP id zt6mr5491367obc.17.1400175007889;
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si272587yhb.6.2014.05.15.10.30.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 91A4731C2D7;
	Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 734E9E1129; Thu, 15 May 2014 10:30:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249144>

Change rename_ref to use a single transaction to perform the ref rename.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 73 ++++++++++++++++++------------------------------------------------
 1 file changed, 20 insertions(+), 53 deletions(-)

diff --git a/refs.c b/refs.c
index c940509..336df40 100644
--- a/refs.c
+++ b/refs.c
@@ -2602,9 +2602,10 @@ static int rename_tmp_log(const char *newrefname)
 
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
-	unsigned char sha1[20], orig_sha1[20];
-	int flag = 0, logmoved = 0;
-	struct ref_lock *lock;
+	unsigned char sha1[20];
+	int flag = 0;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
 	const char *symref = NULL;
@@ -2615,7 +2616,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
-	symref = resolve_ref_unsafe(oldrefname, orig_sha1, 1, &flag);
+	symref = resolve_ref_unsafe(oldrefname, sha1, 1, &flag);
 	if (flag & REF_ISSYMREF)
 		return error("refname %s is a symbolic ref, renaming it is not supported",
 			oldrefname);
@@ -2637,62 +2638,28 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE))
 		return error("unable to pack refs");
 
-	if (delete_ref(oldrefname, orig_sha1, REF_NODEREF)) {
-		error("unable to delete old %s", oldrefname);
-		goto rollback;
-	}
-
-	if (!read_ref_full(newrefname, sha1, 1, NULL) &&
-	    delete_ref(newrefname, sha1, REF_NODEREF)) {
-		if (errno==EISDIR) {
-			if (remove_empty_directories(git_path("%s", newrefname))) {
-				error("Directory not empty: %s", newrefname);
-				goto rollback;
-			}
-		} else {
-			error("unable to delete existing %s", newrefname);
-			goto rollback;
-		}
+	transaction = ref_transaction_begin();
+	if (!transaction ||
+	    ref_transaction_delete(transaction, oldrefname, sha1,
+				   REF_NODEREF | REF_ISPACKONLY,
+				   1, NULL) ||
+	    ref_transaction_update(transaction, newrefname, sha1,
+				   NULL, 0, 0, logmsg) ||
+	    ref_transaction_commit(transaction, &err)) {
+		ref_transaction_rollback(transaction);
+		error("rename_ref failed: %s", err.buf);
+		strbuf_release(&err);
+		goto rollbacklog;
 	}
+	ref_transaction_free(transaction);
 
 	if (log && rename_tmp_log(newrefname))
-		goto rollback;
-
-	logmoved = log;
-
-	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL, NULL, 0);
-	if (!lock) {
-		error("unable to lock %s for update", newrefname);
-		goto rollback;
-	}
-	lock->force_write = 1;
-	hashcpy(lock->old_sha1, orig_sha1);
-	if (write_ref_sha1(lock, orig_sha1, logmsg)) {
-		error("unable to write current sha1 into %s", newrefname);
-		goto rollback;
-	}
-
-	return 0;
-
- rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL, NULL, 0);
-	if (!lock) {
-		error("unable to lock %s for rollback", oldrefname);
 		goto rollbacklog;
-	}
 
-	lock->force_write = 1;
-	flag = log_all_ref_updates;
-	log_all_ref_updates = 0;
-	if (write_ref_sha1(lock, orig_sha1, NULL))
-		error("unable to write current sha1 into %s", oldrefname);
-	log_all_ref_updates = flag;
+	return 0;
 
  rollbacklog:
-	if (logmoved && rename(git_path("logs/%s", newrefname), git_path("logs/%s", oldrefname)))
-		error("unable to restore logfile %s from %s: %s",
-			oldrefname, newrefname, strerror(errno));
-	if (!logmoved && log &&
+	if (log &&
 	    rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", oldrefname)))
 		error("unable to restore logfile %s from "TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
-- 
2.0.0.rc3.477.g0f8edf7
