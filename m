From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 32/41] refs.c: make delete_ref use a transaction
Date: Tue,  3 Jun 2014 14:37:50 -0700
Message-ID: <1401831479-3388-33-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:41:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwSo-0007fk-6v
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965383AbaFCVlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:41:12 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:40038 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934283AbaFCViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:09 -0400
Received: by mail-yh0-f73.google.com with SMTP id f73so1407834yha.0
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JY8+2w6ArftRrUOQTqoCqGxwMK549sRI9P8EX48T0SY=;
        b=Q2yi9pJMCORXyph83CKlenaqBQa3szz+g4ZJOJVlLWRJWUMfZACB3djfvVQvVI2Fx8
         xTTA3ImLHrWhaXfp/7O/bmDNUg3dSSp37ufUFHD1n7sFkFB5+wmJdsPZ2/69Wva+nFCw
         FX7zXgHB4PSuk/0cKc/zDc4bMjgS+YDgWIZG93tzqQaia4jDgV85JxifocVMRTHEMevE
         0KCpGmKABFUeXF34I0H9C8ilUs+TKE7u9J7JsJUBV+H6lJbBC1bQ4oMYhjr7yCsR+mw4
         doynN43IdwhvGnzxkyP4a3cRgU0q/WAn6UAXCvl0Qvj8s+bEZd8uFLQ30zrlctkda8Sg
         kxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JY8+2w6ArftRrUOQTqoCqGxwMK549sRI9P8EX48T0SY=;
        b=FZ6COlejsGnCkHM7URtBRPZDcVT0xU3+vBLnwdR1kk/oW8FBEokicW4mlDMbi6+w9A
         A9SFBilP8OEIzFTRUyBpUixqDxSgLrLYCkKoVS9M6TKRiEDf4OL6W6JB+YxBReDW0Y+U
         2LUXbVJJhH6PeZJSuzrlDZa29xqDZlVygBEwyJAD4WIBlThFYgjXBFKnvwjBUrn5w9AB
         j5/cqjxgyqjqNYBV3uf0/762LF5p0uhu8r02J8YoiBDLQdaeJldOI14dhPYDWllQXYlW
         119XkiuEHET3ziiOMvi76FE7m0O2DFF9aPpVRADoxqxnbb3deJi9Wvg76PYt1H5V5IFs
         EiyA==
X-Gm-Message-State: ALoCoQkepyfgIeNOsy+BkalW/D6ow4Qju6Z9uzpG0Ybi/WLBKRmcm4kRA3U/QsqNdXbksQHhG+Md
X-Received: by 10.58.219.37 with SMTP id pl5mr19335859vec.8.1401831488248;
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si28760yhp.6.2014.06.03.14.38.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 1BFA85A43D0;
	Tue,  3 Jun 2014 14:38:08 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EA3A4E00FA; Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250678>

Change delete_ref to use a ref transaction for the deletion. At the same time
since we no longer have any callers of repack_without_ref we can now delete
this function.

Change delete_ref to return 0 on success and 1 on failure instead of the
previous 0 on success either 1 or -1 on failure.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index e19041a..4cdbc26 100644
--- a/refs.c
+++ b/refs.c
@@ -2513,11 +2513,6 @@ static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
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
@@ -2557,24 +2552,21 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 
 int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 {
-	struct ref_lock *lock;
-	int ret = 0, flag = 0;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
-	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
-	if (!lock)
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_delete(transaction, refname, sha1, delopt,
+				   sha1 && !is_null_sha1(sha1), &err) ||
+	    ref_transaction_commit(transaction, NULL, &err)) {
+		error("%s", err.buf);
+		ref_transaction_free(transaction);
+		strbuf_release(&err);
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
2.0.0.567.g64a7adf
