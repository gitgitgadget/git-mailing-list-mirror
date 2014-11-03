From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 07/17] refs.c: update rename_ref to use a transaction
Date: Mon,  3 Nov 2014 11:02:09 -0800
Message-ID: <1415041339-18450-8-git-send-email-sahlberg@google.com>
References: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:03:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlMuF-0001m8-Ji
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452AbaKCTCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:02:49 -0500
Received: from mail-pa0-f73.google.com ([209.85.220.73]:37504 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355AbaKCTCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:02:25 -0500
Received: by mail-pa0-f73.google.com with SMTP id lj1so1994102pab.4
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xyzj3ZTj0HjIaWu+7X6ZuIchgNWb8YNSSzaYoyLh3aw=;
        b=gJoirjC320bi0lAXP5928gxsUc5RBtkvrUqtfzjyRe/vFDmq/hHGM4/9dToJcdFnA2
         SdRKEvgg6FQo0SOe80q6rUodMdnSV+h4JipdEkJO7r1rWOdBR56xW+RuDrrul/bk4vlO
         At6BjYMpGwrZ60w7gNgyatOdW/j0aRFf45+wG0Eni5w9vd4EoYGNIKpT0CL4+FHvi7PY
         H5U4PGykFSwVtXbYaOLi/sWQ8RFR5J/p7nxcNUOy2wfzwjHS7nGvNCOnBnXtwhGvUhj8
         2y6qyTiZ97X79glbGtKBE9W/XtqGLvJJsByZuolDoDjKynuUyiYZIedec5NPaH6tNhb0
         /J5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xyzj3ZTj0HjIaWu+7X6ZuIchgNWb8YNSSzaYoyLh3aw=;
        b=E9RYiezIYO6nxwV8HfBYv8l621YoJ7Q8VSZp2UXz0CHjPR/tqjcVtf6BvK6NazJrv4
         ij8JBi3uWyOBq021an3AHPSoFeYLfMOU8+zkuI8bh9GwgpzxGxgRQ0fQFG4mr8AQXO2P
         ndJrF+yrAxlc/2i4J7pmDfUPDTyM0L7HdpqA4arcYJ3UglIDni53R49kWkDLYqwqgF5F
         w/FC1oIeRE9CWypd3vLDiVS7CsN8E57zsYZOqYZnRu4waYlQ1ccnSSDcggaUiMH2vCk5
         624xi+N/BfwKoh9mJIjWbtB5uZp/CLrFanIfdVijfvcHnzubI5UsA+JTWDP+DQP80k6E
         cmrA==
X-Gm-Message-State: ALoCoQnKxYMgPg1AxEyEWvAGMv5SQ+qzl7iD0Gz18N/TtK1c/u0rwIwC6Yhx/73fBzDr3B6JORT7
X-Received: by 10.66.163.199 with SMTP id yk7mr2622655pab.41.1415041344320;
        Mon, 03 Nov 2014 11:02:24 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id t28si974950yhb.4.2014.11.03.11.02.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:02:24 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id au0S175a.1; Mon, 03 Nov 2014 11:02:24 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E1765E1109; Mon,  3 Nov 2014 11:02:22 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change refs.c to use a single transaction to perform the rename.
Change the function to return 1 on failure instead of either -1 or 1.

These changes make the rename_ref operation atomic.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c            | 173 +++++++++++++++---------------------------------------
 t/t3200-branch.sh |   7 ---
 2 files changed, 48 insertions(+), 132 deletions(-)

diff --git a/refs.c b/refs.c
index 1c968f5..44d38ab 100644
--- a/refs.c
+++ b/refs.c
@@ -2757,60 +2757,6 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
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
-
-static int rename_tmp_log(const char *newrefname)
-{
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
-}
-
 static int rename_ref_available(const char *oldname, const char *newname)
 {
 	struct string_list skip = STRING_LIST_INIT_NODUP;
@@ -2859,91 +2805,68 @@ static int copy_reflog_into_strbuf(const char *refname, struct strbuf *buf)
 
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
-	unsigned char sha1[20], orig_sha1[20];
-	int flag = 0, logmoved = 0;
-	struct ref_lock *lock;
-	struct stat loginfo;
-	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
+	unsigned char sha1[20];
+	int flag = 0;
+	int log;
+	struct transaction *transaction = NULL;
+	struct strbuf err = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
 	const char *symref = NULL;
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
+	if (!rename_ref_available(oldrefname, newrefname))
+		return 1;
 
-	logmoved = log;
+	log = reflog_exists(oldrefname);
+	if (log && copy_reflog_into_strbuf(oldrefname, &buf))
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
+	transaction = transaction_begin(&err);
+	if (!transaction)
+		goto fail;
+
+	if (strcmp(oldrefname, newrefname)) {
+		if (transaction_delete_ref(transaction, oldrefname, sha1,
+					   REF_NODEREF, 1, NULL, &err))
+			goto fail;
+		if (log && transaction_replace_reflog(transaction, newrefname,
+						      &buf, &err))
+			goto fail;
+		if (log && transaction_update_reflog(transaction, newrefname,
+				     sha1, sha1, &ci, logmsg,
+				     REFLOG_COMMITTER_INFO_IS_VALID, &err))
+			goto fail;
 	}
 
+	if (transaction_update_ref(transaction, newrefname, sha1,
+				   NULL, 0, 0, NULL, &err))
+		goto fail;
+	if (transaction_commit(transaction, &err))
+		goto fail;
+	transaction_free(transaction);
+	strbuf_release(&buf);
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
+	strbuf_release(&buf);
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
