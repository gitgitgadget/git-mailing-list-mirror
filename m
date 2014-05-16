From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 43/44] refs.c: make rename_ref use a transaction
Date: Fri, 16 May 2014 10:37:31 -0700
Message-ID: <1400261852-31303-44-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:38:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM5g-00008b-Mm
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758017AbaEPRiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:38:10 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:59118 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758099AbaEPRhk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:40 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so886490yhl.5
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1qHnHfHE29NsOi96VW6yh8UiIyqo9SIdu+J2/l8P7Xc=;
        b=OKhAezV8k7tGFxH9m31hxtSRhOyx/11BIXwXPXEdhvAJh4EFIwLG0Pd0heuLhGqvO/
         Tht43hVnd1D890OA/gGmSUubK2ee+KLKb+f8YMsBpBElwiZMNmDD7UOOo5e7jZZwRG9j
         LlKYFDnc16Na2UnULdq8LjZw9HC1JRyQ82ZuRYbQnFKf9B/lHx1lIyuJr0SHTW1Heupd
         X/3x8rzwrTSAUYrAC/CuFB2/6TZZHSkMeXxd5yssmSjOOG1Z+Zt6xy5VspiFrWlThbxA
         tmyBzxtaHTa/vHIPgFTWLNYMI/z+6c2zJATwTFmJsZO8UJVsb4KNqkcs0As/HCowPlF5
         bNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1qHnHfHE29NsOi96VW6yh8UiIyqo9SIdu+J2/l8P7Xc=;
        b=dnqmg8ZT9kc9rhtoEtuuKC0Kn35Fd+tIDVnNVSqzuSVgtbhZO6GetbzpZtqxHO8UkL
         10pogsktBji9nSRSnr3cYXl6xygvGkv89iArvMm0264KFeYIB/WQH5zBY7zpsSq6t1iP
         rZJ4j80DnVpyP5lCiFUyb1sdRNxKFi6VnSqJDZe9y4iHqthzAOTi3N43CJzfyClneQWT
         e4BRufGoPjO1ulxRkcRpiGdUFZO0OGYtb2BH1wPVE05caHxAxgIxoREsT0EPdvdNyewD
         lvHhwrIl2vB0Oj/13qFgKlp94Om1jVMB9kKIgAu7Qr6NmvK3TUc5YhrZ69cGmP4Q6Ao7
         YfbQ==
X-Gm-Message-State: ALoCoQltD9w0pz4Hm61y6jGQBZTiL525yRiGFWNGW2pkZLY3/annOuG1W1VLIa8Pi3EQRBUIjg7o
X-Received: by 10.58.141.200 with SMTP id rq8mr1137112veb.31.1400261858925;
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n43si191485yhe.1.2014.05.16.10.37.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A98B731C211;
	Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8BBA7E0B9F; Fri, 16 May 2014 10:37:38 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249369>

Change rename_ref to use a single transaction to perform the ref rename.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 73 ++++++++++++++++++------------------------------------------------
 1 file changed, 20 insertions(+), 53 deletions(-)

diff --git a/refs.c b/refs.c
index 3967333..71e3059 100644
--- a/refs.c
+++ b/refs.c
@@ -2630,9 +2630,10 @@ static int rename_tmp_log(const char *newrefname)
 
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
@@ -2643,7 +2644,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
-	symref = resolve_ref_unsafe(oldrefname, orig_sha1, 1, &flag);
+	symref = resolve_ref_unsafe(oldrefname, sha1, 1, &flag);
 	if (flag & REF_ISSYMREF)
 		return error("refname %s is a symbolic ref, renaming it is not supported",
 			oldrefname);
@@ -2665,62 +2666,28 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
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
+				   1, NULL, &err) ||
+	    ref_transaction_update(transaction, newrefname, sha1,
+				   NULL, 0, 0, logmsg, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
+		ref_transaction_free(transaction);
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
2.0.0.rc3.510.g20c254b
