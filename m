From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 06/16] refs.c: update rename_ref to use a transaction
Date: Fri,  7 Nov 2014 11:38:55 -0800
Message-ID: <1415389145-6391-7-git-send-email-sahlberg@google.com>
References: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 20:39:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpNt-0004Pd-PE
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:39:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbaKGTjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:39:22 -0500
Received: from mail-qa0-f73.google.com ([209.85.216.73]:38818 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbaKGTjM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:39:12 -0500
Received: by mail-qa0-f73.google.com with SMTP id f12so283073qad.2
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 11:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e1nbI7S5WGLsNF4CWjSP5VW9nOEUJmAzzbV3eGSfw+E=;
        b=Vv5ns321PFvoNRrI16tmmOD5bEX+2lRJPYCLUEqw6hiPyK0d1Gn0V2ZPKBfbr/ULdQ
         qHLvg+RysDyBwvowTlwwok6L5vr84K6Kq5Ha+JWy7sbiUwYEwXdF3a0qQeLFodkkUhqo
         os+clI02P6Lcay4RlRksqSq3m/O3O8BJwWxXz/GV88SOUgHq5xZrZ1wn8357lqDc1+1G
         l6euhJc2j59QB6X8WKB8wCobU5WUqQchoN+yIJt8mTO3vhRNDavaWx1UrDg0Mys7KAoH
         Gw0k1MEhiFqyj3hR52mDylxCM/OglhMfZ3vzK2XF8jw3SwEyhtRrXmCr6dpuvk12JHMN
         I0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e1nbI7S5WGLsNF4CWjSP5VW9nOEUJmAzzbV3eGSfw+E=;
        b=QYrUs8PoQ5WzkACLoQNOcsqmTBYxskA6shQ6Qrsb4mjcxJAvIzfbRBGU0OUc+mF/tZ
         Z3QOxqeXhpRvs7kcxEiaTRO9mAkD3Ftvsh6FBXKA/QOvHreQUFeRKzCJq7gHC/GbvSxf
         XJUlSQflXJ6yngHlEKCZK+2PYwkn+4Cv4Gq9x0im7kyfyMTP9/eYwROliOxOFSFDI1yQ
         YVuH/enSKf0Ja/8dxclQTX/a27GWxEEiXIq5LzMQ1qE0aMithNLPpqbChYL9E4SrY2DV
         ObAUaMMS7iqMAITuc2i8g2fnfOZbm5HSpxjAgmKbx0onqEqWbQ9gdXMZ3FfHWwMTNUtA
         BcKQ==
X-Gm-Message-State: ALoCoQkFL/Ga8bQcOOwfDO1G3B8PmAAbWFgtITCP1wDdXQ6ZORDXoh2y7HKNnqsGV1cEI6OChUFx
X-Received: by 10.236.11.194 with SMTP id 42mr10452754yhx.19.1415389151020;
        Fri, 07 Nov 2014 11:39:11 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id t28si402542yhb.4.2014.11.07.11.39.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 11:39:11 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id xzafQ6uy.1; Fri, 07 Nov 2014 11:39:10 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 95BE5E0A99; Fri,  7 Nov 2014 11:39:09 -0800 (PST)
X-Mailer: git-send-email 2.1.2.810.gfbd2bf7.dirty
In-Reply-To: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change refs.c to use a single transaction to perform the rename.
Change the function to return 1 on failure instead of either -1 or 1.

These changes make the rename_ref operation atomic.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c            | 168 ++++++++++++++----------------------------------------
 t/t3200-branch.sh |   7 ---
 2 files changed, 43 insertions(+), 132 deletions(-)

diff --git a/refs.c b/refs.c
index 8ca6add..9a3c7fe 100644
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
@@ -2859,91 +2805,63 @@ static int copy_reflog_into_strbuf(const char *refname, struct strbuf *buf)
 
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
+		if (log && transaction_rename_reflog(transaction, oldrefname,
+						     newrefname, &err))
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
