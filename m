From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 35/44] refs.c: make delete_ref use a transaction
Date: Fri, 16 May 2014 10:37:23 -0700
Message-ID: <1400261852-31303-36-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:38:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM5H-0007V6-Ul
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758030AbaEPRiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:38:11 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:65265 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758095AbaEPRhk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:40 -0400
Received: by mail-ve0-f202.google.com with SMTP id pa12so491203veb.5
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XqxL8alsy3+S7DLpG5b4ppm7bq26Y9FMmcu9FpiaplU=;
        b=pe648Twn02ryOHhFNWHeN21/2NI5Cwa/8VOIpk3Y9QSw5iAbRMPM9IlIP1k+1k/Dgu
         NZ4kNvo/3C9vSOqZbKURvfp/WwHh8JRqGQ4NqHl9WGCXvjens2GUvUL5FlYWXF0J8CYl
         rEm3AvQvs84g4pJGJ9iYJyTyS+JIrtLNvOM5wTPbI+BXXiWSJwp2yetmuSHomNh+kMHD
         eL35TcG1g18h2FKmKqZ8aYvn/OcMLv0Qm9C2fqlCVdO0qM2aLZCJW2hRcwlA/XcVlmCj
         PioC7Fq7DGEYP1w0SMMqHPx6M5vD350ffjQzlcKmdlcVs8CHJ2XdqBc4zkOk/A8WfW6q
         7kfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XqxL8alsy3+S7DLpG5b4ppm7bq26Y9FMmcu9FpiaplU=;
        b=bcHYIKAUqn8Vm9U13aVufg0Geuj+pxv5HQku1WoVi47VaG4SzB2WysaG6yoS3UEgdT
         wR9ZWjVTy6Gki7/wcC4LjtbNEY17T2bvq2Wd6W4l8i0kPeETIPPsTu2LzJdItgFoiLe5
         CdpYNCvOETPJbuoRJPjDFPdiXh2G7NGeux5Sa4kH0NZzQXaBK+KQ+oo4lzzzIR1stWpY
         k5JfochwO9WVM+I+klwtx5spwhgIU5uWZzfe6YgCv0tcKJuZ0oa4a46iOH9ykShpzoVj
         NZfS054Ef5rEcvlhhGSSEegw/85xsYQYwB626UOwqRGXNfFhysUHukrAzL3jcSQ1A9g7
         QZxg==
X-Gm-Message-State: ALoCoQn9xwYEjnYBxIGwuh9IkTR+qO0qapm9VlVvS1zjAdMam/mnzMg6C668Am/2Q+Z0iQ4HKp0a
X-Received: by 10.236.1.198 with SMTP id 46mr7500924yhd.16.1400261858388;
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k43si442533yhq.3.2014.05.16.10.37.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 41E8F5A427A;
	Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1DF0DE0746; Fri, 16 May 2014 10:37:38 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249364>

Change delete_ref to use a ref transaction for the deletion. At the same time
since we no longer have any callers of repack_without_ref we can now delete
this function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 3a5f1e5..b16cf4c 100644
--- a/refs.c
+++ b/refs.c
@@ -2495,11 +2495,6 @@ static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	return ret;
 }
 
-static int repack_without_ref(const char *refname)
-{
-	return repack_without_refs(&refname, 1, NULL);
-}
-
 static int add_err_if_unremovable(const char *op, const char *file,
 				  struct strbuf *e, int rc)
 {
@@ -2543,24 +2538,18 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 
 int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 {
-	struct ref_lock *lock;
-	int ret = 0, flag = 0;
+	struct ref_transaction *transaction;
 
-	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
-	if (!lock)
+	transaction = ref_transaction_begin();
+	if (!transaction ||
+	    ref_transaction_delete(transaction, refname, sha1, delopt,
+				   sha1 && !is_null_sha1(sha1), NULL) ||
+	    ref_transaction_commit(transaction, NULL, NULL)) {
+		ref_transaction_free(transaction);
 		return 1;
-	ret |= delete_ref_loose(lock, flag, NULL);
-
-	/* removing the loose one could have resurrected an earlier
-	 * packed one.  Also, if it was not loose we need to repack
-	 * without it.
-	 */
-	ret |= repack_without_ref(lock->ref_name);
-
-	unlink_or_warn(git_path("logs/%s", lock->ref_name));
-	clear_loose_ref_cache(&ref_cache);
-	unlock_ref(lock);
-	return ret;
+	}
+	ref_transaction_free(transaction);
+	return 0;
 }
 
 /*
-- 
2.0.0.rc3.510.g20c254b
