From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/8] refs.c: use a reflog transaction when writing during expire
Date: Fri,  5 Dec 2014 18:46:33 -0800
Message-ID: <1417833995-25687-7-git-send-email-sbeller@google.com>
References: <1417833995-25687-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 06 03:47:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx5Oo-0004w5-Ao
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 03:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbaLFCrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 21:47:05 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33028 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbaLFCqr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 21:46:47 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so271783igb.17
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 18:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A9rT04Uh0NOaC1hIZzx2E2BeiXN3gfTk/I2MkneW75U=;
        b=A/CeSqCCgDSyi1YRh4AnL86bi+WkN05/xSJTrqXjDDejmQ+ba4ST8lUPzKY9L3h5AP
         /DVC5GuIlSFAa/rZOxhkePiIY9I+JRveBuLLH66g1kVWc5jyJhCbujqPZGkghLmZSiF+
         Tb60c3n7iBpI4vn1GX2NyNh74fqxGeIfgNPI4xgJwLfGDu3iwqg6O+0L7odOVinYbuRy
         dd92ONTS9OKbDOiH5hCW/W2C6YPYD5tiG7/6QN2CSFdHojhuyGprWKyFkxiUnRDZkC8d
         gjNwLy2g14bzA3i1vOlYIK1jHxRrFcrOfXHSo3Ga9KVyOlioZiT4DgsRa3CnEQ0G9Gaw
         LZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A9rT04Uh0NOaC1hIZzx2E2BeiXN3gfTk/I2MkneW75U=;
        b=Rs504Vl4r8a3nKg214jNOQGq8cSLPBZ4phdLD/JE2Y0qKrbFXBIpGEov4l4DYSqRsq
         PkebtKIjNsEF1SlvnUFUQvT30rWEthYFrNv7Y9t8OvUAkh66g9Jxlu09KHOtW3DPuUFB
         MyjqipnfgsUNqae83FA62orX7DU6cxleslSr6a5b3DFFMIeeUG2KwzFIE1AkAfllO6h1
         VijAoZaguyd/uAzKSO3aRE4HbgPFk8sV9WHXGgndMFhGzp9jig4I8jOTyS6rjxIAKC0E
         O12JJCd0MS+CeluSQk7lCMBwkAFA5QAaSkGPt7MONuwQuAL53elBxgDW57gFte38C6zP
         Ejlg==
X-Gm-Message-State: ALoCoQkYEeITfyKJU4eNfeiwJAdPhL8JiRfsgLYbqjDdLZC/jhFsEMvgL/lBMr3nsf7zdGUBhAsc
X-Received: by 10.50.112.165 with SMTP id ir5mr5498820igb.44.1417834005964;
        Fri, 05 Dec 2014 18:46:45 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:4022:de56:febc:d879])
        by mx.google.com with ESMTPSA id l7sm160735igv.12.2014.12.05.18.46.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Dec 2014 18:46:45 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417833995-25687-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260931>

From: Ronnie Sahlberg <sahlberg@google.com>

Use a transaction for all updates during expire_reflog.

[sb: This was once a patch series on its own. I cherry-picked these
patches on top of Michaels series to cleanup the refs api. So any
anomalies and bugs may be introduced by me.]

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    Maybe we can leave out the first patch of the series
    as this one deletes the changes made in the first patch of the series.
    
    Originally authored by Ronnie for the reflogs.c file,
    cherrypicked over to the refs.c file by Stefan

 refs.c | 85 +++++++++++++++++++++++++++---------------------------------------
 1 file changed, 35 insertions(+), 50 deletions(-)

diff --git a/refs.c b/refs.c
index 57f4941..295ea09 100644
--- a/refs.c
+++ b/refs.c
@@ -4100,8 +4100,10 @@ struct expire_reflog_cb {
 	unsigned int flags;
 	reflog_expiry_select_fn *select_fn;
 	void *policy_cb;
-	FILE *newlog;
+	struct transaction *t;
+	const char *refname;
 	unsigned char last_kept_sha1[20];
+	struct strbuf *err;
 };
 
 static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
@@ -4116,15 +4118,18 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 
 	if ((*cb->select_fn)(osha1, nsha1, email, timestamp, tz,
 			     message, policy_cb)) {
-		if (!cb->newlog)
+		if (!cb->t)
 			printf("would prune %s", message);
 		else if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
 			printf("prune %s", message);
 	} else {
-		if (cb->newlog) {
-			fprintf(cb->newlog, "%s %s %s %lu %+05d\t%s",
-				sha1_to_hex(osha1), sha1_to_hex(nsha1),
-				email, timestamp, tz, message);
+		if (cb->t) {
+			if (transaction_update_reflog(cb->t, cb->refname,
+						      nsha1, osha1,
+						      email, timestamp,
+						      tz, message,
+						      cb->err))
+				return -1;
 			hashcpy(cb->last_kept_sha1, nsha1);
 		}
 		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
@@ -4133,8 +4138,6 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-static struct lock_file reflog_lock;
-
 extern int reflog_expire(const char *refname, const unsigned char *sha1,
 			 unsigned int flags,
 			 reflog_expiry_prepare_fn prepare_fn,
@@ -4143,66 +4146,48 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 			 void *policy_cb_data)
 {
 	struct expire_reflog_cb cb;
-	struct ref_lock *lock;
-	char *log_file;
 	int status = 0;
+	struct strbuf err = STRBUF_INIT;
 
 	memset(&cb, 0, sizeof(cb));
 	cb.flags = flags;
 	cb.policy_cb = policy_cb_data;
 	cb.select_fn = select_fn;
+	cb.err = &err;
+	cb.refname = refname;
 
 	/*
-	 * we take the lock for the ref itself to prevent it from
-	 * getting updated.
+	 * todo: we need to take the lock for the ref itself to
+	 * prevent it from getting updated.
 	 */
-	lock = lock_ref_sha1_basic(refname, sha1, NULL, 0, NULL);
-	if (!lock)
-		return error("cannot lock ref '%s'", refname);
-	if (!reflog_exists(refname)) {
-		unlock_ref(lock);
-		return 0;
+	cb.t = transaction_begin(&err);
+	if (!cb.t) {
+		status |= error("%s", err.buf);
+		goto cleanup;
 	}
-
-	log_file = git_pathdup("logs/%s", refname);
-	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
-		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0)
-			goto failure;
-		cb.newlog = fdopen_lock_file(&reflog_lock, "w");
-		if (!cb.newlog)
-			goto failure;
+	if (transaction_delete_reflog(cb.t, cb.refname, &err)) {
+		status |= error("%s", err.buf);
+		goto cleanup;
 	}
 
 	(*prepare_fn)(refname, sha1, cb.policy_cb);
 	for_each_reflog_ent(refname, expire_reflog_ent, &cb);
 	(*cleanup_fn)(cb.policy_cb);
 
+
 	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
-		if (close_lock_file(&reflog_lock)) {
-			status |= error("Couldn't write %s: %s", log_file,
-					strerror(errno));
-		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
-			(write_in_full(lock->lock_fd,
-				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
-			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
-			 close_ref(lock) < 0)) {
-			status |= error("Couldn't write %s",
-					lock->lk->filename.buf);
-			rollback_lock_file(&reflog_lock);
-		} else if (commit_lock_file(&reflog_lock)) {
-			status |= error("cannot rename %s.lock to %s",
-					log_file, log_file);
-		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) && commit_ref(lock)) {
-			status |= error("Couldn't set %s", lock->ref_name);
+		if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
+		    transaction_update_ref(cb.t, cb.refname,
+					   cb.last_kept_sha1, sha1,
+					   0, 1, NULL, &err)) {
+			status |= error("%s", err.buf);
+			goto cleanup;
 		}
+		if (transaction_commit(cb.t, &err))
+			status |= error("%s", err.buf);
 	}
-	free(log_file);
-	unlock_ref(lock);
+cleanup:
+	transaction_free(cb.t);
+	strbuf_release(&err);
 	return status;
-
- failure:
-	rollback_lock_file(&reflog_lock);
-	free(log_file);
-	unlock_ref(lock);
-	return -1;
 }
-- 
2.2.0
