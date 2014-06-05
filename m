From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 4/4] refs.c: update rename_ref to use a transaction
Date: Thu,  5 Jun 2014 16:17:14 -0700
Message-ID: <1402010234-7628-5-git-send-email-sahlberg@google.com>
References: <1402010234-7628-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 01:17:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsguV-0003jr-Do
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 01:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbaFEXRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 19:17:22 -0400
Received: from mail-yk0-f201.google.com ([209.85.160.201]:34713 "EHLO
	mail-yk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093AbaFEXRT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 19:17:19 -0400
Received: by mail-yk0-f201.google.com with SMTP id q9so78074ykb.4
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 16:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A82gb+cf9eXQXuhy4v8hPFyuwjf3MmVjhHDU/Z7vSMA=;
        b=K7ZlgUP5kLoPhJeLDBs+i5nScY/aqCoHnFSsI5smuPAtSTG73nUOvz8/saDaoIJygX
         QVeEaD21ytzuGDZiaTApyq0eOPkFnRTjBEQhot81IgaX8W0GQez1zD78ADr3gml8yr4s
         nhIHyFvFa7h5v6bNRWFi+S1v9Puz4g3XEnE9xq7PbDgWY3Vw/ZxsIZ+nPS/RJ+jRCPKr
         vBs+3m8JFsSXN8olOJgNm3vewWTCIQI3gnw6YB/sYlPwN8k14rAY/32mUEYf5EEoF6jC
         u4QBicgA0W75ns/3mH0LEJLUevto4xYMGwHEbbnXlQsDTmiTfy0ZzcPlXqBeyNhhKjuo
         18bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A82gb+cf9eXQXuhy4v8hPFyuwjf3MmVjhHDU/Z7vSMA=;
        b=cqM/ebSYce59Hu/DqYE0DVhOxvY1PTjFfp5GtF6hHe92SiAwJ04+u+UsiTGBVPGMpI
         K5osROeqo41+n4kol2OapCZcvpq/Wvojk6OgsUlCU4jYrxQJQvT06fRtq6ZkSNPfh+X4
         mYrcO8EzDBlmubnZn4bHBbOed0ym4wxRQ0P3c4Q8EwM+KmTzq8I3VANQMDnrlVl2DIgj
         nmUt92NeCSFCVRJpij679DRM3+nul9vnx8+4t7JZEG8MReeAmF4Fe1FW2iRmvljksME8
         YO1SeH0Vq7irCMxbuzHfDIZnMLzXb1ZP1NKW3GeNT4NZ82WU7tFhtu1TgMChXbnfXpXa
         V7AA==
X-Gm-Message-State: ALoCoQmm/iNxyhtAo+mVibdKpELMAfTwdPvHwhLaSDr0Ek3kN3BU+uWixM0Ko7hsC5i84n2SF7B3
X-Received: by 10.58.46.101 with SMTP id u5mr726997vem.16.1402010238260;
        Thu, 05 Jun 2014 16:17:18 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si648432yhm.0.2014.06.05.16.17.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jun 2014 16:17:18 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 10AF731C5B1;
	Thu,  5 Jun 2014 16:17:18 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B3840E0575; Thu,  5 Jun 2014 16:17:17 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.583.g402232d
In-Reply-To: <1402010234-7628-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250876>

Change refs.c to use a single transaction to copy/rename both the refs and
its reflog. Since we are no longer using rename() to move the reflog file
we no longer need to disallow rename_ref for refs with a symlink for its reflog
so we can remove that test from the testsuite.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c            | 140 +++++++++++++++++++++++++-----------------------------
 t/t3200-branch.sh |   7 ---
 2 files changed, 64 insertions(+), 83 deletions(-)

diff --git a/refs.c b/refs.c
index 3692a4d..4281011 100644
--- a/refs.c
+++ b/refs.c
@@ -2632,22 +2632,33 @@ static int rename_tmp_log(const char *newrefname)
 	return 0;
 }
 
-static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
-			  const char *logmsg);
+struct rename_reflog_cb {
+	struct ref_transaction *transaction;
+	const char *refname;
+	struct strbuf *err;
+};
+
+static int rename_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+			     const char *email, unsigned long timestamp, int tz,
+			     const char *message, void *cb_data)
+{
+	struct rename_reflog_cb *cb = cb_data;
+
+	return transaction_update_reflog(cb->transaction, cb->refname,
+					 nsha1, osha1, email, timestamp, tz,
+					 message, 0, cb->err);
+}
 
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
-	unsigned char sha1[20], orig_sha1[20];
-	int flag = 0, logmoved = 0;
-	struct ref_lock *lock;
-	struct stat loginfo;
-	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
+	unsigned char sha1[20];
+	int flag = 0, log;
+	struct ref_transaction *transaction = NULL;
+	struct strbuf err = STRBUF_INIT;
 	const char *symref = NULL;
+	struct rename_reflog_cb cb;
 
-	if (log && S_ISLNK(loginfo.st_mode))
-		return error("reflog for %s is a symlink", oldrefname);
-
-	symref = resolve_ref_unsafe(oldrefname, orig_sha1, 1, &flag);
+	symref = resolve_ref_unsafe(oldrefname, sha1, 1, &flag);
 	if (flag & REF_ISSYMREF)
 		return error("refname %s is a symbolic ref, renaming it is not supported",
 			oldrefname);
@@ -2656,77 +2667,54 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	if (!is_refname_available(newrefname, get_packed_refs(&ref_cache),
 				  &oldrefname, 1))
-		return 1;
+		return -1;
 
 	if (!is_refname_available(newrefname, get_loose_refs(&ref_cache),
 				  &oldrefname, 1))
-		return 1;
-
-	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
-		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
-			oldrefname, strerror(errno));
-
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
-	}
-
-	if (log && rename_tmp_log(newrefname))
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
+		return -1;
 
+	log = reflog_exists(oldrefname);
+	transaction = transaction_begin(&err);
+	if (!transaction)
+		goto fail;
+
+	if (strcmp(oldrefname, newrefname)) {
+		if (log && transaction_update_reflog(transaction, newrefname,
+						     sha1, sha1,
+						     git_committer_info(0),
+						     0, 0, NULL,
+						     REFLOG_TRUNCATE, &err))
+			goto fail;
+		cb.transaction = transaction;
+		cb.refname = newrefname;
+		cb.err = &err;
+		if (log && for_each_reflog_ent(oldrefname, rename_reflog_ent,
+					       &cb))
+			goto fail;
+
+		if (transaction_delete_sha1(transaction, oldrefname, sha1,
+					    REF_NODEREF,
+					    1, NULL, &err))
+			goto fail;
+	}
+	if (transaction_update_sha1(transaction, newrefname, sha1,
+				    NULL, 0, 0, NULL, &err))
+		goto fail;
+	if (log && transaction_update_reflog(transaction, newrefname, sha1,
+					     sha1, git_committer_info(0),
+					     0, 0, logmsg,
+					     REFLOG_EMAIL_IS_COMMITTER, &err))
+		goto fail;
+	if (transaction_commit(transaction, &err))
+		goto fail;
+	transaction_free(transaction);
 	return 0;
 
- rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL, NULL, 0);
-	if (!lock) {
-		error("unable to lock %s for rollback", oldrefname);
-		goto rollbacklog;
-	}
-
-	lock->force_write = 1;
-	flag = log_all_ref_updates;
-	log_all_ref_updates = 0;
-	if (write_ref_sha1(lock, orig_sha1, NULL))
-		error("unable to write current sha1 into %s", oldrefname);
-	log_all_ref_updates = flag;
-
- rollbacklog:
-	if (logmoved && rename(git_path("logs/%s", newrefname), git_path("logs/%s", oldrefname)))
-		error("unable to restore logfile %s from %s: %s",
-			oldrefname, newrefname, strerror(errno));
-	if (!logmoved && log &&
-	    rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", oldrefname)))
-		error("unable to restore logfile %s from "TMP_RENAMED_LOG": %s",
-			oldrefname, strerror(errno));
-
-	return 1;
+ fail:
+	error("rename_ref failed: %s", err.buf);
+	strbuf_release(&err);
+	transaction_free(transaction);
+	return -1;
 }
 
 int close_ref(struct ref_lock *lock)
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ac31b71..64f5bf2 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -293,13 +293,6 @@ test_expect_success 'renaming a symref is not allowed' '
 	test_path_is_missing .git/refs/heads/master3
 '
 
-test_expect_success SYMLINKS 'git branch -m u v should fail when the reflog for u is a symlink' '
-	git branch -l u &&
-	mv .git/logs/refs/heads/u real-u &&
-	ln -s real-u .git/logs/refs/heads/u &&
-	test_must_fail git branch -m u v
-'
-
 test_expect_success 'test tracking setup via --track' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-- 
2.0.0.583.g402232d
