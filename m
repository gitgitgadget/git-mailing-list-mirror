From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 35/44] refs.c: make delete_ref use a transaction
Date: Thu, 15 May 2014 16:15:32 -0700
Message-ID: <1400195741-22996-36-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:17:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4u4-0007kY-Kt
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbaEOXQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:16:57 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:65137 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756056AbaEOXPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:46 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so346608pbc.2
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1tEaOH8TfLIgaeV/O022tVjrLfJIYGVF5x0t7TSDekc=;
        b=NNqoT9NzOQLeU1yJzuQ8rFUoZbBQeAbwOG5klGWIKRj8sq27fu/lMpTHbsNPQSbafu
         gkEpioHcp4aj2CsK1lpju9Ysi3qSh1fGag/iw8MXbvOQRXQdiSj79rbM9/67WpCaaoBO
         KzyJptKg/codM6V7f/MjWwr1xtQWQQevmFdrsBal8/nWkj7KqkAWamDoxkqFcr3UbAqg
         UhE7qVGaj2DZeJday84ZE/LGfkERWDic436c+JX/P3K8AG6Xz8DDJo/MS8JoiOiEK1HM
         OUyOXVFLFn9y0w4fvaucpHBBTW5k2QfdMQoHQ/O/Emr2hmDYf31X1tPaLqWOI104uODB
         sncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1tEaOH8TfLIgaeV/O022tVjrLfJIYGVF5x0t7TSDekc=;
        b=HdDXsBJ+ljh+bAZh66qfM5mSrtQXi+WrP/Ev3URP7uxdoVO69z/2skpAHIG6FuAKaf
         1v1sbemB2a/C4UwST2uHqgW+saBYsdKAzKHE+qGKCsD+ZK/yTU3UUO4Qr7Tt2fxyOWUG
         qGIWH0zFxTvCAayZQGYoWSJ0SoXDrTHzwYnwuRh8OijC1P3/x36nigSkAjvoZIMDkHYN
         EUMFwiaCAcwZ6a0FAHS9gRRsU4amVJH/Xl2Ual7/Ztr1sENyqItRMCptNNf6G20HGE67
         QNJKcUBLE96pyIpYFyShCc25CTSYsRdqM+xYaoX/7bAUycb3w7FHwXrxJj77eAX0ziq6
         bxiQ==
X-Gm-Message-State: ALoCoQkBIOWg9f6r39PdZSo2+OP7POhsDyu06Snjoo85eqSc974NjUmojB1sMrKczS7eAW4YxtRQ
X-Received: by 10.66.189.163 with SMTP id gj3mr6484234pac.32.1400195746040;
        Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si317568yhl.7.2014.05.15.16.15.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id D6CD431C1CD;
	Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B09F2E0475; Thu, 15 May 2014 16:15:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249253>

Change delete_ref to use a ref transaction for the deletion. At the same time
since we no longer have any callers of repack_without_ref we can now delete
this function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index f88263e..7efb6bb 100644
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
2.0.0.rc3.477.gffe78a2
