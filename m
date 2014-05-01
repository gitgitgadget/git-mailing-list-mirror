From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 33/42] refs.c: make delete_ref use a transaction
Date: Thu,  1 May 2014 13:37:33 -0700
Message-ID: <1398976662-6962-34-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:39:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfxlE-00028v-BC
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbaEAUiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:46 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:36813 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbaEAUh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:59 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so674289pab.1
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HEZSG7VWgEpxCI1vP9fG2PS94+DrZrbmki1NyOEREAU=;
        b=Eb+3e4DM3uVaeFTua2MSnp64ZVGk/37J7LpndDAFLNusppRu29wV4q1/j7Foy3c9Rs
         mT2dQVibnmlGGkdfBbG31P+2gJegoJc7ogb+xkvvlrJBf7yIPPMFR2O0fxghK5WkXLy6
         HxYkx4syym9QeU/MatF6eBIFoHSgCxRCWu+xQ9A6kCWGgDzJRp6ru55KfWbweH74D2nj
         VmIr13k2UOfrHpF4P2xTIFeonzIyK01/O+COMGy2u2VQr8kSmU5SKqVOMIbvrr+A+aQW
         pUGhGQzflvRONBqKGvdA5c3w0UgZCsTgpUwXLTEPrUJkQtdeWz92PLaEEY0yM3ia7Cgh
         EKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HEZSG7VWgEpxCI1vP9fG2PS94+DrZrbmki1NyOEREAU=;
        b=bMGviZ3xl6eOT1qyRcClSf8s47ktP+6CBgb7dnJ1KH2w0275fYZwzsaEIdNKEKykk4
         3zOxccnBbqE0DykRZYU4oMXtcRGiwd+srFLMIQDh8xZiWgIpIFnK72279kbaxoaZ1Z6h
         pq8JSu4dLs0vInjvATQskmRgVnYT0G4L4eFR3JRtnSJhqPJD+2zd6DPDWuk8YZIfvucH
         Wj1HxXRwfOcYRPL4rQB1hHMjWrcCuCaWDQhdC6zFWNcqhPhSV5+/kW7D5ZhOZFxAsl9Q
         y09Kd0Z1t7b8uMUz5vbRyR36Mrg2m2DA6fwbEq9gein/fA//+o4x4wD3BUak6JqUKlC9
         9dGQ==
X-Gm-Message-State: ALoCoQnrNCre5jwefMeq9ThQ15uE9F5q65MqjeWUkbXRePynjJ0zZsEmWIR7jV7g1NladGo8mM1U
X-Received: by 10.66.189.163 with SMTP id gj3mr6822884pac.32.1398976678400;
        Thu, 01 May 2014 13:37:58 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si2611477yhl.7.2014.05.01.13.37.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:58 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 32E0F31C1CC;
	Thu,  1 May 2014 13:37:58 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EBBF5E0A5B; Thu,  1 May 2014 13:37:57 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247859>

Change delete_ref to use a ref transaction for the deletion. At the same time
since we no longer have any callers of repack_without_ref we can now delete
this function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 2b82dce..96b03e5 100644
--- a/refs.c
+++ b/refs.c
@@ -2481,11 +2481,6 @@ static int repack_without_refs(const char **refnames, int n)
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
@@ -2503,24 +2498,18 @@ static int delete_ref_loose(struct ref_lock *lock, int flag)
 
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
2.0.0.rc1.351.g4d2c8e4
