From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 41/42] refs.c: make rename_ref use a transaction
Date: Thu,  1 May 2014 13:37:41 -0700
Message-ID: <1398976662-6962-42-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:38:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxke-0001Qi-QD
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbaEAUiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:18 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:61883 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468AbaEAUiB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:38:01 -0400
Received: by mail-ie0-f201.google.com with SMTP id rd18so797769iec.4
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QkYxUJgc+vs9vH8XU4lE0HkNXH+QXqJSbP5ePDY2gdA=;
        b=OavvLXjeMFNi6PJiDQXEJVZtD08ffVMkIh/pUVC1Fhqu9v3a+x6Zyb9r8sIg9pHMmK
         pELvL9r2ukr7enIf7D+RSuwJFlsw6U58xzPFDGt60lF6SUBJlylxURt2pQWEApeGL9gk
         RwEdDNnd/Cpx11ZN/VUGYWWW3QaXP6Bm2z/CZT7TNQzulrl0MrE+TBpoIFSQBjLiUq7k
         8CAiDnvtH+jgw5kit4kYRPvPa053UfJJZHooP66tSfjjG7uoMAqvQCXVYYotqJtirb3y
         UpXgJD/4IwhZJcCGp+vh1A/uiu04no7O8nrQInc99OWim63Ou9V0tK1soV9VnnnC12oJ
         uSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QkYxUJgc+vs9vH8XU4lE0HkNXH+QXqJSbP5ePDY2gdA=;
        b=jx9A05Q+0fliNkdP5wIjTPpSbzchFYpACIZ/xzi0EkoBM8o9L+jjuE2IRTO6ceGJzW
         GEDZpeVEJaTj9GWtul9SEa1qD8WAssWMMBLoJAcE3AJpg29uR9ZhBw9aq6xVDcCjusu/
         s0evkd0fQCINNufIlesenELCL4M4wljaEUFX1T/NDoYgSw5XnlnXilpRjluDE/eKIL1s
         zr9pQxcbdHe3vO1WSYuAYxSWRjqgKQulDF2MhElM1W5hHxBfCwZp37SII7DnBxOmsl6+
         sOhqP9o7QLYaenvWt59GG4cqPCweghlAzlkKimBNvOWY2yN+p62OsbgQkw8UigfFDnGv
         9cgw==
X-Gm-Message-State: ALoCoQm4pnSAEy8RD0x2hPkY1n/krmO6JyexKaFZA7Z5B4T8h9CWe8+W49g/VvQ93hEFSDgZiWd7
X-Received: by 10.50.35.229 with SMTP id l5mr2458751igj.0.1398976681475;
        Thu, 01 May 2014 13:38:01 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si3538118yhe.3.2014.05.01.13.38.01
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:38:01 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 31CCF31C1CC;
	Thu,  1 May 2014 13:38:01 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E9AF2E0A5B; Thu,  1 May 2014 13:38:00 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247846>

Change rename_ref to use a single transaction to perform the ref rename.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 73 ++++++++++++++++++------------------------------------------------
 1 file changed, 20 insertions(+), 53 deletions(-)

diff --git a/refs.c b/refs.c
index eb75927..810a4db 100644
--- a/refs.c
+++ b/refs.c
@@ -2586,9 +2586,10 @@ static int rename_tmp_log(const char *newrefname)
 
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
@@ -2599,7 +2600,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
-	symref = resolve_ref_unsafe(oldrefname, orig_sha1, 1, &flag);
+	symref = resolve_ref_unsafe(oldrefname, sha1, 1, &flag);
 	if (flag & REF_ISSYMREF)
 		return error("refname %s is a symbolic ref, renaming it is not supported",
 			oldrefname);
@@ -2621,62 +2622,28 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
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
2.0.0.rc1.351.g4d2c8e4
