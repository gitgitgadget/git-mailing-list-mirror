From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 4/5] refs.c: update rename_ref to use a transaction
Date: Wed, 18 Jun 2014 10:24:30 -0700
Message-ID: <1403112271-21331-5-git-send-email-sahlberg@google.com>
References: <1403112271-21331-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:25:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJbX-0007nR-EC
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbaFRRYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:24:41 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:55567 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850AbaFRRYf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:24:35 -0400
Received: by mail-yh0-f74.google.com with SMTP id b6so146183yha.1
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=stQLDSUjuMHC0fLZD2/42CakR5Fh+gkNoJSyqct26AE=;
        b=SG1RrqIvv6qTa/j3qr9vwUIAdihHMXf6jluqbSpRBccV0d3xyJ1jUSB9yiqzh5pe7h
         019dVVIx/EhtLmaCyao2tGR7uiaoRrenZ7dC1XCW3+2AKjPwLNhrKA9oZbG0PPsVBVTE
         R/eUB4N9qU5jKKc4XogMK/SKi0G4/kehR3BceW8D2+sJyi7Q2u0ggY3K5b9jWvX4nMJV
         db0xpn4lcMxuTlN9x30/q9DevU2u9VE+X8wejB9XRRL1abfOi77wg9KrB9QQX8iAr6Bf
         UokSAzXPFVjhYzqVcMgqL8OhDQ7YWMt8L8BtxUieFcSiU+P2LrsafMEC2jxC2Gw5L2oE
         lJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=stQLDSUjuMHC0fLZD2/42CakR5Fh+gkNoJSyqct26AE=;
        b=GOgctgGS3vm8rCIT5Rhk8M2Vu9Y6NDwq8tC0zWpLXH9ErfimoOQsZSwwzfDQUihGck
         rn0aYe6/89EhoQde0NprpwbFa1keyDMGcOcr5oY1kCcsXNu6S5rjakl2a4GDM9Kf7wzJ
         yFwByOLUkx50z4RHW5SY1pxHbNLSg8NkEoWDgl/aS9W0pnNd8LmaVIuR6g6g2kzzy5MN
         BK7CjQ+V8VQSw3actoZr8ZlRSqCpJLwjQ4ldorRXHgDl4fcMde2u5LLvlgz7BYAPshzs
         T8LibuSvbUi/f5OdZ/Azf86Xn9hlnyhpF3bw4QgZ3+0ve7mGGKw0zHSMO3FoEfs93SlQ
         6sJg==
X-Gm-Message-State: ALoCoQlg1DnRha2JA0xJoCGBjLgMGFc8DL4Sl7ac6C3JnM28OHdaaZtgqVo5cDMasuZ25N2g3r8I
X-Received: by 10.236.1.198 with SMTP id 46mr106053yhd.16.1403112275208;
        Wed, 18 Jun 2014 10:24:35 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si175015yhl.7.2014.06.18.10.24.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jun 2014 10:24:35 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 066E331C813;
	Wed, 18 Jun 2014 10:24:35 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 955BBE0ED7; Wed, 18 Jun 2014 10:24:34 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.467.g08c0633
In-Reply-To: <1403112271-21331-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252012>

Change refs.c to use a single transaction to copy/rename both the refs and
its reflog. Since we are no longer using rename() to move the reflog file
we no longer need to disallow rename_ref for refs with a symlink for its
reflog so we can remove that test from the testsuite.

Change the function to return 1 on failure instead of either -1 or 1.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c            | 192 ++++++++++++++++++------------------------------------
 t/t3200-branch.sh |   7 --
 2 files changed, 65 insertions(+), 134 deletions(-)

diff --git a/refs.c b/refs.c
index 63c2122..89e5bc0 100644
--- a/refs.c
+++ b/refs.c
@@ -2616,81 +2616,42 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
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
-	symref = resolve_ref_unsafe(oldrefname, orig_sha1, 1, &flag);
-	if (flag & REF_ISSYMREF)
-		return error("refname %s is a symbolic ref, renaming it is not supported",
+	symref = resolve_ref_unsafe(oldrefname, sha1, 1, &flag);
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
@@ -2700,70 +2661,47 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
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
2.0.0.467.g08c0633
