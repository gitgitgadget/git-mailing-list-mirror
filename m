From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 43/44] refs.c: make rename_ref use a transaction
Date: Thu, 15 May 2014 16:15:40 -0700
Message-ID: <1400195741-22996-44-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:17:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4tX-0006FX-KD
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210AbaEOXQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:16:15 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:57631 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756117AbaEOXPr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:47 -0400
Received: by mail-ve0-f202.google.com with SMTP id pa12so326358veb.1
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wV7F4037mk6IV/KXBSYq16vh5KbUeS1/yrDzM3KMEEo=;
        b=oi/t9VItiBRbxTnhVHab4Y8ErC4YqStbsbOj1Zkt/oHoc1N/vvA5BR8iLZy5CPOgMF
         kJ9DyzTOkzSHUjCiPdOF44rAfYNzXfmtf0oGNYYxsZkeRbYkZMhQ5YAuf6reYVt+R5QG
         8HjzcWJx7LGSFnoaY/SE8GevmjzLMMLR3FbpRZ9w7Rtw+dAkfCzIO1XF1/VoERBNup7h
         q8jHoGxqMEsGt3FqRCVqoX+1qh6WzJb55govqcsEUxj6/M1Arz4gB3+u+qszZxR7p8Kw
         CJmnPvd0b1PaepesupHLzMz9jU97d4YzWspD1pgsGdiWqq2d2f4JVApGakOub1yVLO0n
         TdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wV7F4037mk6IV/KXBSYq16vh5KbUeS1/yrDzM3KMEEo=;
        b=Z4EDIVN5cFANL0X2vdsXzckNthJD1jjpXhhoMMlApQNYHmI0S1ow5NqKdWiO6p+jJg
         F1l7agvT/wqnh7n91RPGYyTrf7WZhxftNXGSibm4TuAwN9E5/qZ/8Qay2edsBzgpsbGs
         0T01L3zqy9X+HFsU6g9Htx9+swozHCtxFSvOA/wc6X7ukgiL8L2xCj6tpZuNL37RH72g
         jbIkrwmdZLt2CZgtBA9nT035SW8m9+Sxqrj1+CYcK6qPvHGY1ZBCDcI8MXQTnSOAuZIc
         yvxD9g0ko5lswYuxbmauHfz4w7ft+zqDeBx+g62fKuxKuIgOQKj3bOaGrDhBIJ+hLpSD
         xX2Q==
X-Gm-Message-State: ALoCoQm82WgdYEfPaF5wT0pP5aOZo5uEK3l921daoJ9uauY1BDny2YJIji8NKHzM/V/KWclfjuVJ
X-Received: by 10.236.94.238 with SMTP id n74mr5471446yhf.27.1400195746595;
        Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si244845yhj.5.2014.05.15.16.15.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5257231C2BF;
	Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 347CDE0C53; Thu, 15 May 2014 16:15:46 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249242>

Change rename_ref to use a single transaction to perform the ref rename.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 73 ++++++++++++++++++------------------------------------------------
 1 file changed, 20 insertions(+), 53 deletions(-)

diff --git a/refs.c b/refs.c
index c471811..7ea3f42 100644
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
2.0.0.rc3.477.gffe78a2
