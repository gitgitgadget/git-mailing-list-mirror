From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 41/42] refs.c: make rename_ref use a transaction
Date: Wed, 14 May 2014 14:17:15 -0700
Message-ID: <1400102236-30082-42-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:19:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgaT-0005tc-8l
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831AbaENVSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:18:20 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:52858 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbaENVRe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:34 -0400
Received: by mail-vc0-f202.google.com with SMTP id hr9so429377vcb.5
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZPl1Nl3b5CWNXu/KUVfdzDf5BuRYzHD8+c4uPNaE4jo=;
        b=gKCi/7ZmRfLFWKMpIHKA1xAJph2RSfJjVjZOmjU5GgxO3TYsEMTQxzycSqBpzQlBph
         pVBT//HE0LZZg8IPon+1xgrda5YPyx3rct7+tos+oaZ12PPRsUILD+0kp0hfgWvouhrd
         WVIvZPCSvorDmVZNC+Hy9ttmoVYgb5LGbVjb6GjxNsZXQ4gG30AJyLIdCA0NYByrUQn6
         qM2s1Iui/IKmGpQP0IY/1Qb3tXPdqyKj4zLbZVw4LSDuXNbti+ib9NMQnu2b8Ggtj2LA
         Df8XAwR3sLcY700uV4DrANZuQ8XJPrptS206DXVbR3uptvStdAOYEdE+KNKtOhWr1PnN
         WAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZPl1Nl3b5CWNXu/KUVfdzDf5BuRYzHD8+c4uPNaE4jo=;
        b=LqiCHDWZH7DEBvdNX2MZBhzc5S0VhPcBWzELoX+oaZOrtWHmPmboBGyqHc38iS9D3y
         KwfHzkK1wVyU+cqE3vVwLgoqyZRk+KUgOp/n9/FnJ3CyGstQhcBbjBlprstHVCWQyM2P
         eAJhNlerJEUsgqzYzs42V8zv7jLAoN182rXg719Y8Eg4suc9XzPXuqO9frdU5b3K9QIz
         Mu+CT0Nsly6GHJBPC+q6GCxEcdLWHgXlfcw4ywuV3cQ9HrkY6PmyNacTVoAusXhD0vs5
         I9YatpRLEs2vzmBT50PF9n7doGuaqhBggO1rZ59fKHwGEPqSqDkkYGj1lFnQwd1ekVzR
         lfWA==
X-Gm-Message-State: ALoCoQmjUXHwfyEctY64i0hzHPeALi1V5XaKX8pOE5Nr5KZV/8y3mlCn8vlQrsEe9Gac8u8FnqjN
X-Received: by 10.236.159.39 with SMTP id r27mr2842974yhk.7.1400102253781;
        Wed, 14 May 2014 14:17:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id k43si145580yhq.3.2014.05.14.14.17.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8264531C1F8;
	Wed, 14 May 2014 14:17:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 44D67E0973; Wed, 14 May 2014 14:17:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248970>

Change rename_ref to use a single transaction to perform the ref rename.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 73 ++++++++++++++++++------------------------------------------------
 1 file changed, 20 insertions(+), 53 deletions(-)

diff --git a/refs.c b/refs.c
index 7569f4e..8e12386 100644
--- a/refs.c
+++ b/refs.c
@@ -2591,9 +2591,10 @@ static int rename_tmp_log(const char *newrefname)
 
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
@@ -2604,7 +2605,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
-	symref = resolve_ref_unsafe(oldrefname, orig_sha1, 1, &flag);
+	symref = resolve_ref_unsafe(oldrefname, sha1, 1, &flag);
 	if (flag & REF_ISSYMREF)
 		return error("refname %s is a symbolic ref, renaming it is not supported",
 			oldrefname);
@@ -2626,62 +2627,28 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
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
2.0.0.rc3.471.g2055d11.dirty
