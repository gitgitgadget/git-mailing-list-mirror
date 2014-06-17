From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 40/48] refs.c: make delete_ref use a transaction
Date: Tue, 17 Jun 2014 08:53:54 -0700
Message-ID: <1403020442-31049-41-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:55:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvjh-0005Rj-06
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933407AbaFQPy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:54:56 -0400
Received: from mail-ig0-f201.google.com ([209.85.213.201]:45047 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345AbaFQPyI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:08 -0400
Received: by mail-ig0-f201.google.com with SMTP id uq10so361372igb.0
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tKzh0YiKN4LP7/kTW2OfF6jG4C3DapV6fDNZR8INcv0=;
        b=W0jbesNgP1dQOL/UoI5N4U3kSMUwtJjOQ3/QGi5D8LQbqm12KGd0Dho5h3/boxNzLY
         HlWoUOMKjvlvPAiLPdJ3eER2PqLulKltagjASAluy+MMqhWGwD5Bl4qrYh74jzoUHmFf
         YIG+kA3l/UBhfH5iPCXZPIhBGm6uLZh6Fiao8wFBRdeqUQZnjecW4J6fh5aJrGp/BqLZ
         +joCUlxZ8sN7nBWbSqmbccokQkDvfH86JgGgdRbJkPVixsdyiSXqJ1xSdA8H5SwpAZIH
         VFapeujtasGEihH7/fPBiKZjrRTUTTiviVGzrEzH7INcrNgy617WP3FpPG1FXK4WMddX
         Ksiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tKzh0YiKN4LP7/kTW2OfF6jG4C3DapV6fDNZR8INcv0=;
        b=I9e6ZGNaCU1GHdCNfzD2hXB4IDI6ZVbbT+sMuSSiwkbq0upzr9Z3KbzBzdCH5kQAm0
         rvFXi387DWWgAw+CEH6PqpJ2oBeKq0eghUofIAVn/xgUIYdzMFDsiwOdYFId1l2NVKD8
         yvxLw2sJZCPdqAU3A77UNeqUNu+TE2GHP9765c/8P91w+LEk7xCm9/kuWAcKp5kxQE+4
         NS8BqKAwUBKWlQxhWTIQRRfwA9w8j0FMdQDS+SY+/ainhzSA5Y6FTgMe8Jhrn9rWqwh5
         +Og6KprK042EQFuqNvSnoCC8xyI9Mfxh+LbpnPfRD1/BLLkTxAhtD1vJieLecayni2tw
         MkCQ==
X-Gm-Message-State: ALoCoQkZVbaELTjHJPPlSK2q5v5LgEih9OKvdruriHSrUWyuIBp9npulMb5KbeG0Dj37f8XTHAGB
X-Received: by 10.182.22.65 with SMTP id b1mr382328obf.10.1403020445921;
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si1209165yhb.3.2014.06.17.08.54.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id B91A05A45B3;
	Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9562CE10DE; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251892>

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
index e753711..aa5a74d 100644
--- a/refs.c
+++ b/refs.c
@@ -2545,11 +2545,6 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
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
@@ -2589,24 +2584,21 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 
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
2.0.0.438.gec92e5c
