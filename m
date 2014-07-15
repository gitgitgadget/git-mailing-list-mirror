From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 14/20] walker.c: use ref transaction for ref updates
Date: Tue, 15 Jul 2014 16:34:12 -0700
Message-ID: <1405467258-24102-15-git-send-email-sahlberg@google.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:35:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CFQ-0003Pj-A6
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934326AbaGOXe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:34:56 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:63174 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934319AbaGOXe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:34:26 -0400
Received: by mail-vc0-f201.google.com with SMTP id hu12so21035vcb.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SQJGU+zntLLTITL5KHylXBxXzx9ueEJl3O3TIIXu12g=;
        b=g0/t7TtTxHOfuyfddZ6B8o/T6lT+WxAfaK1pqqfPbJPmCJN6yRi3W++cAXSnJZoTiP
         4B+6CuRZapvbA6eyXdmef7m84dq2jCVBjCRQeW+p7z8e/mtsIpZwgfSYkitQma2CRWJr
         VlJVeefh1MQRMzkEv+MAFzq8nheinEG0SWZtSlVAcGcUhb1j8suMMyB9xEOq329GkicA
         1MeZHe6svu3Te/csEHz4uQHXLlykIc9tSrDRiA2bX6xBbN80T/V3t5zR4HjMv5DTXLP7
         35FbMsYDd0uAg9C6GH9iMBThDJM7WeWXj4XOBVrRA/77Q+ktjQ3e6/dFgo7ThryY4pTl
         hKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SQJGU+zntLLTITL5KHylXBxXzx9ueEJl3O3TIIXu12g=;
        b=JuoKUjy5HOp++A3I0GWempdP3y1rggmQriF6NTgZA5ScUNmXYBK4msXt4kGu+oNGVa
         RLqRkPenmac98v4RwetV+QsVX5mNy2CeNsa28FukJ8JOhYEE7oJoIRC5HVrb3B534F3k
         EkdmA4ytF8+ubGaz48vHmnrPvHuzNitQ7AYUK8MCvMSvXitYzJEUBR0oOiLkxBbmhtIj
         +pveOy8AlwewwCe4PI9//kn9ig9jmtbjP6m26FRnkm4IN4Aw7uPMagRWyeUnMTgybQYX
         eoXWP9mb3LduDlE9EI8hnliUynwqEGBy3Aw5wm12yNUltsMf37EeN8Lal78impiSJJVx
         5q4Q==
X-Gm-Message-State: ALoCoQlkKKSyPjtdfpbVaJUADpTyOQDLf8TAe3kDWG7XLJNDFBOu+zSK2BcNmerB19Q4IutN+LPO
X-Received: by 10.236.63.197 with SMTP id a45mr12327789yhd.9.1405467264825;
        Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si1060590yhb.3.2014.07.15.16.34.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 89D005A428F;
	Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4A271E0B6B; Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.481.gb244468
In-Reply-To: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253632>

Switch to using ref transactions in walker_fetch(). As part of the refactoring
to use ref transactions we also fix a potential memory leak where in the
original code if write_ref_sha1() would fail we would end up returning from
the function without free()ing the msg string.

Note that this function is only called when fetching from a remote HTTP
repository onto the local (most of the time single-user) repository which
likely means that the type of collisions that the previous locking would
protect against and cause the fetch to fail for are even more rare.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
2.0.1.442.g7fe6834.dirty
