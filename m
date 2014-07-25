From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 4/5] refs.c: update rename_ref to use a transaction
Date: Fri, 25 Jul 2014 09:58:40 -0700
Message-ID: <1406307521-10339-5-git-send-email-sahlberg@google.com>
References: <1406307521-10339-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 18:59:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAipo-0005kX-Hb
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 18:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934695AbaGYQ7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 12:59:01 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:61245 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934613AbaGYQ6t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 12:58:49 -0400
Received: by mail-qa0-f73.google.com with SMTP id s7so767640qap.2
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2AhHBUagaS2aoZdBhWt0gL/qvCbGiSQTQeyuF/9TWfg=;
        b=d8aUCoIIa7UgckQRJuZvInHXpEZR10Agn7PIDS+rZAdCAoRXQuxjgIjcmSNLEyedSm
         ApYahUJX2rf4njcAUlyHrgBEglr8eYrZkQU37ShipAPY2p68rmKvV+LJ85w8IlpQH6in
         +8qSx7NzEOcAzcLQ9sbtcw7IzUOgWw5KzVtPhNmt4ahvfZoGeBKQPbM47I99o/bHEXxa
         zYnscUoDWT9Qfpo9CpFqIXdeTrQkTIzMa0c/XfZkRRi8TnpKEnDsHva9qjtgrRcUjNDf
         6Qcs6pjuFBcFXU6DnOk8jAbW0k1kGkOqulUoXeyFHAHCQ14tyepPTLsftA+xggNeL38z
         sPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2AhHBUagaS2aoZdBhWt0gL/qvCbGiSQTQeyuF/9TWfg=;
        b=QYqudLX91w6tymWGdWxr9I/e25uJ3qw1TGhMVeTao6PgR9B3PsPYgqcZUO+EriK26+
         ZD/kfy8iWnO4FNb9s2U+6pxQfz6ZdCFDbcdXXT3GupblDAKoH8T6UjfmhnpJ36wAoNhA
         NVMwDZtsdQw2fQUlt+gnt4rJ07kC2i4Hl+O2ItsgEhIzkMDWIjSnNn0s4nRJk7YCSh89
         mB7v1XXm+boDPxXkqaJBReIbwkBldotwV3r9eJqpS+cli75Dr7XAcLHWqXSUW73r7J0e
         v4+xrDRkBHDaOnalC2xlVPZf4xE/aNMM4ka9YNpfNIkSBL2ZsmfflOp5CMT3ynyfyQ9P
         rurw==
X-Gm-Message-State: ALoCoQkw4bW/JH6Gh9lvYK3DH+buJmsq5FjXhxea8+6gxafg62yalfv44nfsZZX1oIiyGpXdUgz4
X-Received: by 10.52.190.129 with SMTP id gq1mr7242586vdc.2.1406307528499;
        Fri, 25 Jul 2014 09:58:48 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id p3si1291708yho.7.2014.07.25.09.58.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Jul 2014 09:58:48 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 43F9731C33D;
	Fri, 25 Jul 2014 09:58:48 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DE4B1E0AC8; Fri, 25 Jul 2014 09:58:47 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.508.g763ab16
In-Reply-To: <1406307521-10339-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254236>

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

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c            | 192 ++++++++++++++++++------------------------------------
 t/t3200-branch.sh |   7 --
 2 files changed, 65 insertions(+), 134 deletions(-)

diff --git a/refs.c b/refs.c
index 0d800f1..a5053bf 100644
--- a/refs.c
+++ b/refs.c
@@ -2616,82 +2616,43 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
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
+	struct ref_transaction *transaction;
+	const char *refname;
+	struct strbuf *err;
+};
 
-static int rename_tmp_log(const char *newrefname)
+static int rename_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+			     const char *email, unsigned long timestamp, int tz,
+			     const char *message, void *cb_data)
 {
-	int attempts_remaining = 4;
-
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
+	struct rename_reflog_cb *cb = cb_data;
 
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
+	return transaction_update_reflog(cb->transaction, cb->refname,
+					 nsha1, osha1, email, timestamp, tz,
+					 message, 0, cb->err);
 }
 
-static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
-			  const char *logmsg);
-
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
-	symref = resolve_ref_unsafe(oldrefname, orig_sha1,
+	symref = resolve_ref_unsafe(oldrefname, sha1,
 				    RESOLVE_REF_READING, &flag);
-	if (flag & REF_ISSYMREF)
-		return error("refname %s is a symbolic ref, renaming it is not supported",
+	if (flag & REF_ISSYMREF) {
+		error("refname %s is a symbolic ref, renaming it is not supported",
 			oldrefname);
-	if (!symref)
-		return error("refname %s not found", oldrefname);
+		return 1;
+	}
+	if (!symref) {
+		error("refname %s not found", oldrefname);
+		return 1;
+	}
 
 	if (!is_refname_available(newrefname, get_packed_refs(&ref_cache),
 				  &oldrefname, 1))
@@ -2701,70 +2662,47 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 				  &oldrefname, 1))
 		return 1;
 
-	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
-		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
-			oldrefname, strerror(errno));
-
-	if (delete_ref(oldrefname, orig_sha1, REF_NODEREF)) {
-		error("unable to delete old %s", oldrefname);
-		goto rollback;
-	}
-
-	if (!read_ref_full(newrefname, sha1, RESOLVE_REF_READING, NULL) &&
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
-
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
+ fail:
+	error("rename_ref failed: %s", err.buf);
+	strbuf_release(&err);
+	transaction_free(transaction);
 	return 1;
 }
 
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
2.0.1.508.g763ab16
