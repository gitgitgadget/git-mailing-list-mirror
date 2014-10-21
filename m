From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 05/15] refs.c: update rename_ref to use a transaction
Date: Tue, 21 Oct 2014 13:36:50 -0700
Message-ID: <1413923820-14457-6-git-send-email-sahlberg@google.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:37:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggBo-000100-Qj
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933305AbaJUUhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:37:33 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:62541 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933095AbaJUUhF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:37:05 -0400
Received: by mail-qc0-f201.google.com with SMTP id m20so200350qcx.2
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7DGXaOZFNYqoKrPvFzKZO1WrnXmrHwE5MSHGCEVJs8s=;
        b=iu9sU8nmdreNkFFH0KSLElC30CC8zhlp7XTW+dpG/FgP2RJnHcwmacswkUoTg+xdeG
         V90ybQYSiU9Do9Z/CZteYbQaUo6YJHTrVhA+Xdt9YGZLjILgLLiijDMEm86ythq+0j2J
         UtRec9Kic4EEid439YCViAIIeUkJJrvI30YZR54fz9ciTE7aW2gjZRHJB3NMF7vgZE58
         Bg/rG1r73YRv9dFG9N+E72VjCuUG8maATxrAqWfeJuQj5nS3Ch3KWk29TlwBUuggOWDm
         +4GuIc5viFlTTCzgoS6f0/hP5qhdH/brHP7SrG8OzI0+1TIXKGJYl+8EWEEZeqnsmJuw
         UWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7DGXaOZFNYqoKrPvFzKZO1WrnXmrHwE5MSHGCEVJs8s=;
        b=nCA4L6Kl4O6MJtRwf8d/aGNXTlCeyUbpdl1UxJqiLmNv+jHCmFjhKnhOvDBc5nmG3D
         Mo2L5M0tNkHnTxBGKhAezq9hg0gzqz+faKFw7m7QGQEDAuf1Hck/TUZr+3WxTBAMzNgb
         DlY6qz7FLRlPtMVZQ8wBi0gPZvpx9IOEpVXBA3ooaSz2ls2vZ1ni9uFj13cMnoXOwSJq
         3n2muXIKw+4LBcgE5ZBl9qojzKdDdN7zXo/B2w2DGGxfPm6TfrX+MKFnvnLNHH7XSPPb
         0kItSzdPc9Khw/0FuTeJVtn6UxMEfugCnbad148ptCspAbRsiaFGVOmmBeDw3QE7E7zk
         HH+A==
X-Gm-Message-State: ALoCoQmSQvN5KaJR8F10PWchRnYuZzYw8Y7SWQKRI2yyLs1d8i6oVqgb728ZvDpZvm3oQE8TOZIl
X-Received: by 10.224.45.132 with SMTP id e4mr19896246qaf.2.1413923823373;
        Tue, 21 Oct 2014 13:37:03 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n24si593312yha.6.2014.10.21.13.37.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:37:03 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id uS7AyPzZ.1; Tue, 21 Oct 2014 13:37:03 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 928BDE0952; Tue, 21 Oct 2014 13:37:02 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
In-Reply-To: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit 0295e9cebc41020ee84da275549b164a8770ffba upstream.

Change refs.c to use a single transaction to copy/rename both the refs and
its reflog. Since we are no longer using rename() to move the reflog file
we no longer need to disallow rename_ref for refs with a symlink for its
reflog so we can remove that test from the testsuite.

Change the function to return 1 on failure instead of either -1 or 1.

These changes make the rename_ref operation atomic. This also eliminates the
need to use rename() to shift the reflog around via a temporary filename.
As an extension to this, since we no longer use rename() on the reflog file,
we can now safely perform renames even if the reflog is a symbolic link
and thus can remove the check and fail for that condition.

Change-Id: I59477d410a34298a29cf0cbf32328b9053b158fe
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c            | 192 ++++++++++++++++++++----------------------------------
 t/t3200-branch.sh |   7 --
 2 files changed, 70 insertions(+), 129 deletions(-)

diff --git a/refs.c b/refs.c
index b9c8f91..f43fef4 100644
--- a/refs.c
+++ b/refs.c
@@ -2752,58 +2752,26 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	return 0;
 }
 
-/*
- * People using contrib's git-new-workdir have .git/logs/refs ->
- * /some/other/path/.git/logs/refs, and that may live on another device.
- *
- * IOW, to avoid cross device rename errors, the temporary renamed log must
- * live into logs/refs.
- */
-#define TMP_RENAMED_LOG  "logs/refs/.tmp-renamed-log"
+struct rename_reflog_cb {
+	struct transaction *transaction;
+	const char *refname;
+	struct strbuf *err;
+};
 
-static int rename_tmp_log(const char *newrefname)
+static int rename_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+			     const char *id, unsigned long timestamp, int tz,
+			     const char *message, void *cb_data)
 {
-	int attempts_remaining = 4;
+	struct rename_reflog_cb *cb = cb_data;
+	struct reflog_committer_info ci;
 
- retry:
-	switch (safe_create_leading_directories(git_path("logs/%s", newrefname))) {
-	case SCLD_OK:
-		break; /* success */
-	case SCLD_VANISHED:
-		if (--attempts_remaining > 0)
-			goto retry;
-		/* fall through */
-	default:
-		error("unable to create directory for %s", newrefname);
-		return -1;
-	}
-
-	if (rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", newrefname))) {
-		if ((errno==EISDIR || errno==ENOTDIR) && --attempts_remaining > 0) {
-			/*
-			 * rename(a, b) when b is an existing
-			 * directory ought to result in ISDIR, but
-			 * Solaris 5.8 gives ENOTDIR.  Sheesh.
-			 */
-			if (remove_empty_directories(git_path("logs/%s", newrefname))) {
-				error("Directory not empty: logs/%s", newrefname);
-				return -1;
-			}
-			goto retry;
-		} else if (errno == ENOENT && --attempts_remaining > 0) {
-			/*
-			 * Maybe another process just deleted one of
-			 * the directories in the path to newrefname.
-			 * Try again from the beginning.
-			 */
-			goto retry;
-		} else {
-			error("unable to move logfile "TMP_RENAMED_LOG" to logs/%s: %s",
-				newrefname, strerror(errno));
-			return -1;
-		}
-	}
-	return 0;
+	memset(&ci, 0, sizeof(ci));
+	ci.id = id;
+	ci.timestamp = timestamp;
+	ci.tz = tz;
+	return transaction_update_reflog(cb->transaction, cb->refname,
+					 nsha1, osha1, &ci, message, 0,
+					 cb->err);
 }
 
 static int rename_ref_available(const char *oldname, const char *newname)
@@ -2823,91 +2791,71 @@ static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
 
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
-	unsigned char sha1[20], orig_sha1[20];
-	int flag = 0, logmoved = 0;
-	struct ref_lock *lock;
-	struct stat loginfo;
-	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
+	unsigned char sha1[20];
+	int flag = 0, log;
+	struct transaction *transaction = NULL;
+	struct strbuf err = STRBUF_INIT;
 	const char *symref = NULL;
+	struct rename_reflog_cb cb;
+	struct reflog_committer_info ci;
 
-	if (log && S_ISLNK(loginfo.st_mode))
-		return error("reflog for %s is a symlink", oldrefname);
+	memset(&ci, 0, sizeof(ci));
+	ci.committer_info = git_committer_info(0);
 
 	symref = resolve_ref_unsafe(oldrefname, RESOLVE_REF_READING,
-				    orig_sha1, &flag);
-	if (flag & REF_ISSYMREF)
-		return error("refname %s is a symbolic ref, renaming it is not supported",
-			oldrefname);
-	if (!symref)
-		return error("refname %s not found", oldrefname);
-
-	if (!rename_ref_available(oldrefname, newrefname))
+				    sha1, &flag);
+	if (flag & REF_ISSYMREF) {
+		error("refname %s is a symbolic ref, renaming it is not "
+		      "supported", oldrefname);
 		return 1;
-
-	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
-		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
-			oldrefname, strerror(errno));
-
-	if (delete_ref(oldrefname, orig_sha1, REF_NODEREF)) {
-		error("unable to delete old %s", oldrefname);
-		goto rollback;
 	}
-
-	if (!read_ref_full(newrefname, RESOLVE_REF_READING, sha1, NULL) &&
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
+	if (!symref) {
+		error("refname %s not found", oldrefname);
+		return 1;
 	}
 
-	if (log && rename_tmp_log(newrefname))
-		goto rollback;
-
-	logmoved = log;
+	if (!rename_ref_available(oldrefname, newrefname))
+		return 1;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, 0, NULL);
-	if (!lock) {
-		error("unable to lock %s for update", newrefname);
-		goto rollback;
-	}
-	lock->force_write = 1;
-	hashcpy(lock->old_sha1, orig_sha1);
-	if (write_ref_sha1(lock, orig_sha1, logmsg)) {
-		error("unable to write current sha1 into %s", newrefname);
-		goto rollback;
+	log = reflog_exists(oldrefname);
+	transaction = transaction_begin(&err);
+	if (!transaction)
+		goto fail;
+
+	if (strcmp(oldrefname, newrefname)) {
+		if (log && transaction_update_reflog(transaction, newrefname,
+						     sha1, sha1, &ci, NULL,
+						     REFLOG_TRUNCATE, &err))
+			goto fail;
+		cb.transaction = transaction;
+		cb.refname = newrefname;
+		cb.err = &err;
+		if (log && for_each_reflog_ent(oldrefname, rename_reflog_ent,
+					       &cb))
+			goto fail;
+
+		if (transaction_delete_ref(transaction, oldrefname, sha1,
+					   REF_NODEREF,
+					   1, NULL, &err))
+			goto fail;
 	}
-
+	if (transaction_update_ref(transaction, newrefname, sha1,
+				   NULL, 0, 0, NULL, &err))
+		goto fail;
+	if (log && transaction_update_reflog(transaction, newrefname, sha1,
+					     sha1, &ci, logmsg,
+					     REFLOG_COMMITTER_INFO_IS_VALID,
+					     &err))
+		goto fail;
+	if (transaction_commit(transaction, &err))
+		goto fail;
+	transaction_free(transaction);
 	return 0;
 
- rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, 0, NULL);
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
+ fail:
+	error("rename_ref failed: %s", err.buf);
+	strbuf_release(&err);
+	transaction_free(transaction);
 	return 1;
 }
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 432921b..c6c53e4 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -302,13 +302,6 @@ test_expect_success 'renaming a symref is not allowed' '
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
2.1.0.rc2.206.gedb03e5
