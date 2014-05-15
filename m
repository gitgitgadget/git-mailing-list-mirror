From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 27/44] walker.c: use ref transaction for ref updates
Date: Thu, 15 May 2014 16:15:24 -0700
Message-ID: <1400195741-22996-28-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:16:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4tB-0005dx-Nb
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755717AbaEOXQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:16:29 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:63568 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756046AbaEOXPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:46 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so720948vcb.0
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ilcKQ+TS+N1TCsDQr8JZz9vW84glCvicXGH1nn+icKg=;
        b=O73BidJUA141TWXB/hK2s+0F1zhxq/Y3VE7le0RL9O8ujkUI/L4stAe7v9nsYFeBgU
         GCK4+bVf81gsafqyyWtcSRMXNhIrqrOxEOU/c5c0SV8FWEbg8zD1LJRGzDfBy2EGxj5z
         j0x2jY7vRwK18OcM1SDV4s6bRBiplJEGF1HPKEt8KwrSvCwOtCC6G9A+OgNqafayHktQ
         VP/mQT4UJCr7s45T2xEZ/w/6GEJCbeymhKwJl5rpWxzV/u+FTcRHj0CGp4Nx7Rqds4Cl
         BCXfULHsvy6oNTXrLxy32VY0c7FdISqDYm2N7z21/Ao5Q2bq+BxpuZ0RcBLJhkVs8L5d
         BELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ilcKQ+TS+N1TCsDQr8JZz9vW84glCvicXGH1nn+icKg=;
        b=LvlXOoHuXF+coJIwoVt2SQCYx1mMeKV9iyood7uZqRufUo3iazwK0pTG56u+vkrwSV
         StoKLLyn/Qy5Sb4GZNcyU6dC3IF+XL270sfuQ6AteGctu0RHoK/2Yyg8lO8+9VyNNl/U
         dMPyKAsSYO+C1qhjPWCqc0NOaqa+/pvtL9YRBphpdprXqFMkLdF/s8VTa67paWA2ZRgI
         DGqY8apEk5nma0CNp2UtBBZvB0d+8pb0eB2bJDZt2Pv9vk2INsGgo3y9Wf9STS9BSu8C
         1AhWufb1P5OC4ArMn/2j0lmhwTRqJj9RBw1cXxdInaGkvjlAsMtPJQQAE2RrqYO60QUU
         82nQ==
X-Gm-Message-State: ALoCoQnwL0MxIIl7LCZFs8/tlAcV/bIwyvbz/sKQVZS76k+RWZQ6nThv1RzfYRDw+A+v51s4i/cH
X-Received: by 10.236.112.130 with SMTP id y2mr5688812yhg.6.1400195745783;
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si318071yhb.6.2014.05.15.16.15.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8A1D331C259;
	Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 65DE7E0F39; Thu, 15 May 2014 16:15:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249235>

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
index 1dd86b8..cbe5686 100644
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
+					   0, 0, &err))
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
2.0.0.rc3.477.gffe78a2
