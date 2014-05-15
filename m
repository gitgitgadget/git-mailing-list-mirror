From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 35/44] refs.c: make delete_ref use a transaction
Date: Thu, 15 May 2014 10:29:50 -0700
Message-ID: <1400174999-26786-36-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:31:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzV3-0000ja-H5
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766AbaEORbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:31:14 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:34645 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755694AbaEORaK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:10 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so257166pab.5
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lwgYJmNMLxuPuGgd1NGfbw0ERjm+veljAVSyG5qMYJo=;
        b=kdQnPT3J0s6/zusaLOH2JJTpGzKzM+O4JsxoFlamvDQjm38Ukak8HpYKxdERIatJBF
         MKaw2rLaoiZLNc6ocIe69KSpLijrxNiHYWTYpjVPQ7zCBqzjrklymHcRn6Vyi47cqfsi
         q4ZHP2m8WClGAXjZOQpVQz1+o/f1MtYDY/KBvpD+bwj6YEPeZEVevie6Fic7tX2DJaXD
         +9ibgc6rvOVM5FupS1O2NuB9BCVk9zRHzSOMlWWG/6NsetnOtxWyXJfXsj0kPmAy7BB2
         pFu7+wJpojz0RMeBos9Gl0JfcuflByL4StIKkuiHMSW1xx96gHG4PE7K4ahijSJlxp2s
         2VTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lwgYJmNMLxuPuGgd1NGfbw0ERjm+veljAVSyG5qMYJo=;
        b=fSdwCSK3cOZ+x5RO/kYC83E6by6R1D4psyFvArp47GRcttPIxjXyhDcECvxovEP5gG
         nGBZK03cesdhU+2Y96NI4Wtd5fPYdJx2AvEXGX35bDKJ/f+wMs0QE6D+aXwEKHfFsgmT
         Ffs/zkqdu34snRT+C1imfPepb0ft8vmbi1iPKPUmGMv1+gJ5tPxL++Y4zeynFR2i+hfC
         nofYCs8G/99Q+mH/43ij6gMWKSQwQbJwLMmpHoc233DgwZ5RnJrmBFFoLs11ec4esXIW
         d1ii6lizmiYirC4H8xDPJ0TOSN0C8Q6oB0AQdCNvLGDIDkfezB7IxjS+TmLCfDJXTdvY
         epMA==
X-Gm-Message-State: ALoCoQmzzGHn0yuP89TXIRgwKK4cFD4SR7bGcxPcelO/OP5hBzjeX5YxvIXdbkwbgMleb9G5lYLk
X-Received: by 10.66.66.35 with SMTP id c3mr3060345pat.7.1400175007693;
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si199314yhj.5.2014.05.15.10.30.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 3E1BC5A42E1;
	Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1A2A7E1530; Thu, 15 May 2014 10:30:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249138>

Change delete_ref to use a ref transaction for the deletion. At the same time
since we no longer have any callers of repack_without_ref we can now delete
this function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 88ab012..e7bd95d 100644
--- a/refs.c
+++ b/refs.c
@@ -2488,11 +2488,6 @@ static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	return ret;
 }
 
-static int repack_without_ref(const char *refname)
-{
-	return repack_without_refs(&refname, 1, NULL);
-}
-
 static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
@@ -2515,24 +2510,18 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 
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
+				   sha1 && !is_null_sha1(sha1)) ||
+	    ref_transaction_commit(transaction, NULL, NULL)) {
+		ref_transaction_rollback(transaction);
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
2.0.0.rc3.477.g0f8edf7
