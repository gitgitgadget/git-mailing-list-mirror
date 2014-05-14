From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 25/42] walker.c: use ref transaction for ref updates
Date: Wed, 14 May 2014 14:16:59 -0700
Message-ID: <1400102236-30082-26-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:20:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkgb2-0007HV-4E
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbaENVTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:19:54 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:51444 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbaENVR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:29 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so40778obc.2
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NJBxK+FA6w1n8Pqc4UIirSy0ATvWNpAEZl9ZlcAsBLk=;
        b=QRf8VQStpYqbaphJm8+QB4nGpIBUA/hoRPmVPMdMwcWSWbw3bJ9vEH8QY3AX8tZKaQ
         7B5tXXvPhuOPXGuD3GzIZwhV5jv7SGkzVw41gDcbqn1zxosOPozI5LEEt6iUHvi+P8/x
         lioEbN3WbJCK5pMtevWpaDsaaMHPLSTS0UNycpV/mTMTNkdsg+TLhJUerD5yTfULbf2l
         OCHlYYvT7bKEDHBNIZWH9kDU61hyFmegHqkKTG33rTTPOMc/txmSHc3rZajsujBa8b2j
         sH3t1zZBEY9D/wd7lpoCaM4bNVlQOVeVvso23j0f74yan8qs/Y8On/QpzVB619PAg9sq
         ZhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NJBxK+FA6w1n8Pqc4UIirSy0ATvWNpAEZl9ZlcAsBLk=;
        b=KCYZ661tM4OpCKEKHgLedIqi6yd82lJu6XPHrnKSzFICbveluhZ6viRarCLstP05Bp
         h1DRT+Gbc9CaxI6MXeq2S8yE2n6PccIXd4E1Ueo8+K5frDZyAymZSt9FbJPnPJevOkvF
         YeHyJtN9GmzEiRiRM4cytIFkk+RKRTB2pkuCx6tiwkfG845MWd16VxximFJLBhM6gQZn
         YSFFpFCYQZKhcFS6e62P0cF96k3VEKFerMMDzG/7HSpTivMdnNERkwtcmsszb6grRDIM
         cN+4PJEhOIbHrb78F7Kz8o8sUV4Ez3DCih4W9S3koUuVZCv5PyACSXSJgtOpIHPlPdBV
         0RtA==
X-Gm-Message-State: ALoCoQmIqze0Syu/fItk1mYymvXja7IUdswhYaKY//DhJBXxIdLQJNkr23Y+8wye8kQXxDzJsgGw
X-Received: by 10.182.255.225 with SMTP id at1mr3003580obd.29.1400102248595;
        Wed, 14 May 2014 14:17:28 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id l7si146191yho.1.2014.05.14.14.17.28
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:28 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 51DAC5A42DA;
	Wed, 14 May 2014 14:17:28 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 141A0E0CB6; Wed, 14 May 2014 14:17:28 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248979>

Switch to using ref transactions in walker_fetch(). As part of the refactoring
to use ref transactions we also fix a potential memory leak where in the
original code if write_ref_sha1() would fail we would end up returning from
the function without free()ing the msg string.

This changes the locking slightly for walker_fetch. Previously the code would
lock all refs before writing them but now we do not lock the refs until the
commit stage. There is thus a very short window where changes could be done
locally during the fetch which would be overwritten when the fetch completes
and commits its transaction. But this window should be reasonably short.
Even if this race does trigger, since both the old code and the new code
just overwrites the refs to the new values without checking or comparing
them with the previous value, this is not too dissimilar to a similar scenario
where you first do a ref change locally and then later do a fetch that
overwrites the local change. With this in mind I do not see the change in
locking semantics to be critical.

Note that this function is only called when fetching from a remote HTTP
repository onto the local (most of the time single-user) repository which
likely means that the type of collissions that the previous locking would
protect against and cause the fetch to fail for to be even more rare.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 walker.c | 51 ++++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/walker.c b/walker.c
index 1dd86b8..6044ccf 100644
--- a/walker.c
+++ b/walker.c
@@ -251,24 +251,18 @@ void walker_targets_free(int targets, char **target, const char **write_ref)
 int walker_fetch(struct walker *walker, int targets, char **target,
 		 const char **write_ref, const char *write_ref_log_details)
 {
-	struct ref_lock **lock = xcalloc(targets, sizeof(struct ref_lock *));
+	char ref_name[PATH_MAX];
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction;
 	unsigned char *sha1 = xmalloc(targets * 20);
-	char *msg;
-	int ret;
+	char *msg = NULL;
 	int i;
 
 	save_commit_buffer = 0;
 
-	for (i = 0; i < targets; i++) {
-		if (!write_ref || !write_ref[i])
-			continue;
-
-		lock[i] = lock_ref_sha1(write_ref[i], NULL);
-		if (!lock[i]) {
-			error("Can't lock ref %s", write_ref[i]);
-			goto unlock_and_fail;
-		}
-	}
+	transaction = ref_transaction_begin();
+	if (!transaction)
+		return -1;
 
 	if (!walker->get_recover)
 		for_each_ref(mark_complete, NULL);
@@ -276,14 +270,14 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 	for (i = 0; i < targets; i++) {
 		if (interpret_target(walker, target[i], &sha1[20 * i])) {
 			error("Could not interpret response from server '%s' as something to pull", target[i]);
-			goto unlock_and_fail;
+			goto rollback_and_fail;
 		}
 		if (process(walker, lookup_unknown_object(&sha1[20 * i])))
-			goto unlock_and_fail;
+			goto rollback_and_fail;
 	}
 
 	if (loop(walker))
-		goto unlock_and_fail;
+		goto rollback_and_fail;
 
 	if (write_ref_log_details) {
 		msg = xmalloc(strlen(write_ref_log_details) + 12);
@@ -294,19 +288,26 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 	for (i = 0; i < targets; i++) {
 		if (!write_ref || !write_ref[i])
 			continue;
-		ret = write_ref_sha1(lock[i], &sha1[20 * i], msg ? msg : "fetch (unknown)");
-		lock[i] = NULL;
-		if (ret)
-			goto unlock_and_fail;
+		sprintf(ref_name, "refs/%s", write_ref[i]);
+		if (ref_transaction_update(transaction, ref_name,
+					   &sha1[20 * i], NULL,
+					   0, 0))
+			goto rollback_and_fail;
+	}
+
+	if (ref_transaction_commit(transaction, msg ? msg : "fetch (unknown)",
+				   &err)) {
+		error("%s", err.buf);
+		goto rollback_and_fail;
 	}
-	free(msg);
 
+	free(msg);
 	return 0;
 
-unlock_and_fail:
-	for (i = 0; i < targets; i++)
-		if (lock[i])
-			unlock_ref(lock[i]);
+rollback_and_fail:
+	free(msg);
+	strbuf_release(&err);
+	ref_transaction_free(transaction);
 
 	return -1;
 }
-- 
2.0.0.rc3.471.g2055d11.dirty
