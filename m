From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 39/48] refs.c: make delete_ref use a transaction
Date: Thu, 19 Jun 2014 08:53:21 -0700
Message-ID: <1403193210-6028-40-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:55:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxegQ-00088b-6M
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933402AbaFSPy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:54:57 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:60327 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758070AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so295719pbc.0
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PxH1aMh9bH/pCbRjwcZ07D70G1YLzgwrsvqQu7ahCq8=;
        b=Tsg+kyotaABjVwaCXZRENUdGOMtqO4jQoEAv+cKWw6pn7L82CjXu818dUhUVomAlqQ
         8rsg2QKn4YN2fbq0yaIn3A6Z8ILbz591f+fz0EWrUyz/SbWSmpkmK0mwEom1kPjbTHNp
         hHtIF+XgqWrEg2Gseg2wg/Odhs1WIimrP9rPoRz+eUgOJ/riQiJQFyEk84Jk9o2jlWtZ
         umDKDwhXWL7UMNiW9PHhhBbr2kJ/wbNZ6B1vTdH4HsW0DCgF4zuqpAqSlNQtiSPZhJ9s
         L96LAZZqLVqYuD5Iomz7F1gXdhhIhXRgXMnUFqdF8RNxLWCtpUdRj9HxGWcVGVqhZQui
         /NbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PxH1aMh9bH/pCbRjwcZ07D70G1YLzgwrsvqQu7ahCq8=;
        b=AboatLOjWeGWGwMOxs8jo9tBzc1lTELLXbc7bXmHhlt3mqTMa3+Su/qhfONxfdIYb+
         INjOGw08qgl0WeyOqEg83cM9eCuoUxhVucMYL3WZ5hmdm3UuXhEUMUCK4sp4uepxkxO8
         /PRS5KKtE00fo6aecOZ/X5TyBNNVaC5oeAYf0t2Juit1+/wb9Ovh5Xg4Uvb0iybum0WI
         rEsRxje7vZeb0Ljn0VrejbC6EqTfVsvx1q7ZRBEC+kqsv4mwTpjzBjjs23RgSR8lpcYR
         m8D2VG8Pv1rxg2Wj4WqSrWS7PksrMvnS4i49M3fiSSTrRjbAgaLQ24pjExxsmGaUpWWV
         QNEg==
X-Gm-Message-State: ALoCoQlGt0/Y7iLZBVQe7B/CYZZ6PhnxUlst06mAwHNEnrok93qO6RGy4ZVs8rVpaqH71ZHPJaAN
X-Received: by 10.66.220.34 with SMTP id pt2mr1635969pac.8.1403193214371;
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j43si187569yhh.5.2014.06.19.08.53.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 32D785A42EE;
	Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 113C7E0B50; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252141>

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
index 7c46d13..15cc5f9 100644
--- a/refs.c
+++ b/refs.c
@@ -2544,11 +2544,6 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	return ret;
 }
 
-static int repack_without_ref(const char *refname)
-{
-	return repack_without_refs(&refname, 1, NULL);
-}
-
 static int delete_ref_loose(struct ref_lock *lock, int flag)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
@@ -2566,24 +2561,21 @@ static int delete_ref_loose(struct ref_lock *lock, int flag)
 
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
-	ret |= delete_ref_loose(lock, flag);
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
2.0.0.438.g337c581
