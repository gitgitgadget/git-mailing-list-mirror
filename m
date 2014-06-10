From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 34/48] walker.c: use ref transaction for ref updates
Date: Tue, 10 Jun 2014 15:29:22 -0700
Message-ID: <1402439376-25839-35-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:38:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUZq-00068o-2h
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741AbaFJWaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:30:52 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:51815 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-ve0-f201.google.com with SMTP id jz11so638550veb.4
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pzHnJeHhXM6HzAWRNXObY7BOxFwlPJcxq0aFvEYh01M=;
        b=d5qDsoW5exrP4P4OAv/MHcdzXFrEtkKzcET1eO6doc+BXfxzbMomWmnJmrUI5YiUsV
         p2bjQHQJGMsz6pVIqgOvQdejxKv1wxLM38EB1crJ08Gs3v1rJDZBVAWWbW2BG9jmRUeY
         iG/XshU4fcguWxOG5GEJy7Y77d44S10vgaAtruNBREE6XCCuMfCoFt+gDTSzU7pT1hZR
         UqsHFPRJwxg8ENtVqzBge4qfeo9dfwAbA1zkTWjys9op2wkJQLcORGq2hYBzShEg7xmD
         PxrwfftE9KIDLTQhK8M0IdrBCkcZzwMAXv5fjBVnL/1qkGTxjv0BCgBTq66SIMYkWYFa
         +cZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pzHnJeHhXM6HzAWRNXObY7BOxFwlPJcxq0aFvEYh01M=;
        b=Aqf3e5Xcgahyqt+ErIGryFvN23oa6P9jgOawywNXlMOSKlaCQHq06HQE36NjDHznSw
         PvDKz1UFOK1bddmKLMoLGFZV1sdVAGvfcPbkzfpsqc41tFdtvfnNIPPj1Ofv+YX48kcj
         DS2OhB2pPz4wwo5K94BvdtxU71+T19rr2KiPIAgFhGUe27EqUOt5zbVHIRTUyEZbnSnT
         QYi66ysabj62GFinDF+fsIJHW5IHT1H8L9IHWO0DfgHmxL3+gHrLfBoja1FuKy5eWIDh
         r6Ik5SHFZRadK5t/1l+vR2iAjlGHaNj0xKQBK/K3N/3wMx8U0j8ml5Ygl40VmmLLAYbZ
         zZFw==
X-Gm-Message-State: ALoCoQlzKtt9nKnHuq1F5nJJvWCyPIKTzYOTFwBMFhBuyEBVFP8+k7pRu61Uhqjf9CCRL86Oe+OS
X-Received: by 10.58.151.238 with SMTP id ut14mr17822479veb.11.1402439381698;
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c22si1396568yhe.1.2014.06.10.15.29.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 74FB231C741;
	Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5204BE0CCA; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251290>

Switch to using ref transactions in walker_fetch(). As part of the refactoring
to use ref transactions we also fix a potential memory leak where in the
original code if write_ref_sha1() would fail we would end up returning from
the function without free()ing the msg string.

Note that this function is only called when fetching from a remote HTTP
repository onto the local (most of the time single-user) repository which
likely means that the type of collissions that the previous locking would
protect against and cause the fetch to fail for to be even more rare.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 walker.c | 59 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/walker.c b/walker.c
index 1dd86b8..60d9f9e 100644
--- a/walker.c
+++ b/walker.c
@@ -251,39 +251,36 @@ void walker_targets_free(int targets, char **target, const char **write_ref)
 int walker_fetch(struct walker *walker, int targets, char **target,
 		 const char **write_ref, const char *write_ref_log_details)
 {
-	struct ref_lock **lock = xcalloc(targets, sizeof(struct ref_lock *));
+	struct strbuf ref_name = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction = NULL;
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
+	if (write_ref) {
+		transaction = ref_transaction_begin(&err);
+		if (!transaction) {
+			error("%s", err.buf);
+			goto rollback_and_fail;
 		}
 	}
-
 	if (!walker->get_recover)
 		for_each_ref(mark_complete, NULL);
 
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
@@ -294,19 +291,33 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 	for (i = 0; i < targets; i++) {
 		if (!write_ref || !write_ref[i])
 			continue;
-		ret = write_ref_sha1(lock[i], &sha1[20 * i], msg ? msg : "fetch (unknown)");
-		lock[i] = NULL;
-		if (ret)
-			goto unlock_and_fail;
+		strbuf_reset(&ref_name);
+		strbuf_addf(&ref_name, "refs/%s", write_ref[i]);
+		if (ref_transaction_update(transaction, ref_name.buf,
+					   &sha1[20 * i], NULL, 0, 0,
+					   &err)) {
+			error("%s", err.buf);
+			goto rollback_and_fail;
+		}
+	}
+	if (write_ref) {
+		if (ref_transaction_commit(transaction,
+					   msg ? msg : "fetch (unknown)",
+					   &err)) {
+			error("%s", err.buf);
+			goto rollback_and_fail;
+		}
+		ref_transaction_free(transaction);
 	}
-	free(msg);
 
+	free(msg);
 	return 0;
 
-unlock_and_fail:
-	for (i = 0; i < targets; i++)
-		if (lock[i])
-			unlock_ref(lock[i]);
+rollback_and_fail:
+	ref_transaction_free(transaction);
+	free(msg);
+	strbuf_release(&err);
+	strbuf_release(&ref_name);
 
 	return -1;
 }
-- 
2.0.0.574.g30c2c5e
