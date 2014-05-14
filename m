From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 33/42] refs.c: make delete_ref use a transaction
Date: Wed, 14 May 2014 14:17:07 -0700
Message-ID: <1400102236-30082-34-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:19:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgZy-0004gU-IX
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbaENVS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:18:28 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:42132 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbaENVRb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:31 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so36880pab.5
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WHfv3SSiqgygfWLCHymXb3pD+1lEsRPWu0m3YqthaSg=;
        b=YeZCK7n9GDJ9BIUkeYJ+SQV/uXBc+SF1YIrzF1CekbfxGV+Enq6ZKbfX0hcRjs5XBk
         u1Kb4aECHxf/Zd8R9u+bmNkmTq2QyOELNJz1IVoQIvBztcF8jhT7IKJmEFl+Lgu1yEEs
         mFnabiytQWZxQZjBc/Fe9srifZ40Nll9nOCF6rWZkViayvMcuZkU1oACypfDSh2nLdOS
         fL8CzFhUVjHgaqxoQ/Hw4vvU2zjRbKlOylS6WkAeJ0be8gSOEylPxDcM1YwUAFStUCl0
         M6MGz1NaHeykyqXoHTItNrzdgjfGTGv4gjGW1H86G4w2I3ETPRaQf9nM+iM/rLyEDlDD
         z1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WHfv3SSiqgygfWLCHymXb3pD+1lEsRPWu0m3YqthaSg=;
        b=hoXOsCtBfOhUfri+YJx5ZiFiAZvZRSficwOk9u+lYpJG7VL5joi/atRF9BV367oBMl
         YOuc8eGUcA1XDX2l66bC8HEFWJ8LTJ1GxGgyMHySHmbpSSQNATFoVvTTwkLDukS6zNu3
         /C7jtCyPXUFTP0MqOM2Q/kEEdRvkEDkG2LwnsV9kxXT1J6W53a+vOYBGZkJUpqf1ukh/
         8hUEdAmEJ2loznlrnKIdvlCsJNQQdomWGJNyL+Oflvsm+JGizUZeGHjLUcrOccYkTk8b
         Y6aSKf3H7HK5OYPWxKlgPfxFtRYsPy0LTRhWOFNBEJzt0FERYDbPxmR3OEHYr+inz3R0
         +HyQ==
X-Gm-Message-State: ALoCoQnTaRmLdpVitpszUwuRD9GDEcDW/6E/U6LujcoIKl2VRlV67ZCQ6GMtnnqMqDoV2JUbQIn9
X-Received: by 10.66.169.231 with SMTP id ah7mr3165223pac.40.1400102251163;
        Wed, 14 May 2014 14:17:31 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a44si144579yhb.6.2014.05.14.14.17.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:31 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id F1F9C5A42DA;
	Wed, 14 May 2014 14:17:30 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B8E02E0973; Wed, 14 May 2014 14:17:30 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248967>

Change delete_ref to use a ref transaction for the deletion. At the same time
since we no longer have any callers of repack_without_ref we can now delete
this function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index fa5befe..681ac92 100644
--- a/refs.c
+++ b/refs.c
@@ -2482,11 +2482,6 @@ static int repack_without_refs(const char **refnames, int n)
 	return commit_packed_refs();
 }
 
-static int repack_without_ref(const char *refname)
-{
-	return repack_without_refs(&refname, 1);
-}
-
 static int delete_ref_loose(struct ref_lock *lock, int flag)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
@@ -2504,24 +2499,18 @@ static int delete_ref_loose(struct ref_lock *lock, int flag)
 
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
2.0.0.rc3.471.g2055d11.dirty
