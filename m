From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 31/31] refs.c: use the transaction to manage the reflog in rename_refs
Date: Wed, 14 May 2014 15:13:30 -0700
Message-ID: <1400105610-21194-32-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:14:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhR3-0006WZ-DP
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbaENWN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:13:58 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:46373 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420AbaENWNo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:44 -0400
Received: by mail-vc0-f202.google.com with SMTP id hr9so443095vcb.5
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ihxRkvkv9sYaDc4czughp02djBDOctgBY/dsZnsG0m8=;
        b=eg80oxQDc27Dwo4DJpb/PDD940R6zrpjAewi3W+vamSJmQnU/r7POCwpIHGfzy6De9
         HgBnOFUFWiFTz8+DbaTB16ehC+0RwVPdZ3NepibZME7/Q63f1NJQwDhR4VpQO3TWHTCZ
         uoFa3+CmyYOwU3x7tT7bjdKWgbQuEy/Bq2nxaJJ5avN14ARF1jolfucXftkUXG6r2hqz
         SeHr8hMr4WAHArZPLmkzScDGQkjA/aK/HQTUk5f1McGi0FuJkoYs9LLhbXbOu+huNJbc
         AYDjHUf4A8LvZLplLf7fIdSYojIO1wYpg1Pnz+Bl/Dj6r78HcMFKaYA1Wd1OlgKS9uzP
         y6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ihxRkvkv9sYaDc4czughp02djBDOctgBY/dsZnsG0m8=;
        b=QZgOOkdHrj1JzerUnk/2V1aa7+BNQGtYGegcYJNY2hgDBPrQC6SBKh11YVaM3aCbgl
         8cK+vO7U5fNY/l5rznZ2fef7Naky7YAz1L4m3mrWvOcNxEX+r7BzvqI0kZ2puh4bGv5R
         Hsl83cW6QJUDuFcHOkHMLbNitukcG4cCM2ktXU9TJF5a2kc3usBkesCRqPgt5fUCMbhu
         l9m3rv4amZoSnuIw/LEyeuWwMG/Rmk/4mYFAHrHd3gITDTR2h3Qgnyiu+lpxeZ/ktco3
         FeJniTAuGXRRU38B/Mcz2CmLg2aU5LTsfO0DtBfuu8A8S3pPFQ+iKC9EfgWZs+cILQGf
         NCdw==
X-Gm-Message-State: ALoCoQmvUEuJNslLEM2eHLOGgo+YFICecjM3SZ4+HW77V1ElgHDuHWBQDJbyT4a70QF0eMA+WAsU
X-Received: by 10.236.133.201 with SMTP id q49mr1802287yhi.1.1400105623489;
        Wed, 14 May 2014 15:13:43 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si78062yhj.5.2014.05.14.15.13.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 3F2005A41E5;
	Wed, 14 May 2014 15:13:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 03172E038E; Wed, 14 May 2014 15:13:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249016>

We have a transaction in rename_ref to managing the ref during the rename.
Use this transaction to manage the changes to the reflog too.
This now means that rename_ref is almost completely agnostic about how refs
storage is implemented and should be easier to migrate if/when we allow a
different store for refs, such as a database.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 62 ++++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/refs.c b/refs.c
index bcce8fe..829c89a 100644
--- a/refs.c
+++ b/refs.c
@@ -2633,6 +2633,24 @@ struct ref_update {
 	const char refname[FLEX_ARRAY];
 };
 
+struct rename_reflog_cb {
+       struct ref_transaction *t;
+       const char *refname;
+};
+
+static int rename_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+			     const char *email, unsigned long timestamp, int tz,
+			     const char *message, void *cb_data)
+{
+       struct rename_reflog_cb *cb = cb_data;
+
+       transaction_update_reflog(cb->t, cb->refname, nsha1, osha1,
+				 email, timestamp, tz, message, 0,
+				 NULL);
+
+       return 0;
+}
+
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
 	unsigned char sha1[20];
@@ -2664,40 +2682,44 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 				  get_loose_refs(&ref_cache), NULL, 0))
 		return 1;
 
-	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
-		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
-			oldrefname, strerror(errno));
-
 	if (pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE))
 		return error("unable to pack refs");
 
 	transaction = transaction_begin();
-	if (!transaction ||
-	    transaction_delete_sha1(transaction, oldrefname, sha1,
+	if (log) {
+		struct rename_reflog_cb cb;
+
+		transaction_update_reflog(transaction, newrefname,
+					  null_sha1, null_sha1, NULL,
+					  0, 0, NULL,
+					  REFLOG_TRUNCATE,
+					  NULL);
+
+		cb.t = transaction;
+		cb.refname = newrefname;
+		for_each_reflog_ent(oldrefname, rename_reflog_ent, &cb);
+
+		transaction_update_reflog(transaction, newrefname,
+					  sha1, sha1,
+					  git_committer_info(0),
+					  0, 0, logmsg,
+					  REFLOG_EMAIL_IS_COMMITTER,
+					  &err);
+	}
+
+	if (transaction_delete_sha1(transaction, oldrefname, sha1,
 				    REF_NODEREF | REF_ISPACKONLY,
 				    1, NULL, &err) ||
 	    transaction_update_sha1(transaction, newrefname, sha1,
-				    NULL, 0, 0, logmsg, &err) ||
+				    NULL, 0, 0, NULL, &err) ||
 	    transaction_commit(transaction, &err)) {
 		transaction_rollback(transaction);
 		error("rename_ref failed: %s", err.buf);
 		strbuf_release(&err);
-		goto rollbacklog;
+		return 1;
 	}
 	transaction_free(transaction);
-
-	if (log && rename_tmp_log(newrefname))
-		goto rollbacklog;
-
 	return 0;
-
- rollbacklog:
-	if (log &&
-	    rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", oldrefname)))
-		error("unable to restore logfile %s from "TMP_RENAMED_LOG": %s",
-			oldrefname, strerror(errno));
-
-	return 1;
 }
 
 static int close_ref(struct ref_lock *lock)
-- 
2.0.0.rc3.506.g3739a35
