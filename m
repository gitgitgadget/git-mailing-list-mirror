From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 25/27] walker.c: use ref transaction for ref updates
Date: Mon, 28 Apr 2014 15:54:40 -0700
Message-ID: <1398725682-30782-26-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 01:02:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuZ6-00064L-M8
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 01:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755069AbaD1XCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 19:02:21 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:56971 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101AbaD1XCU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 19:02:20 -0400
Received: by mail-pb0-f74.google.com with SMTP id md12so744153pbc.5
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 16:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uJsVF2mMcIKQm3IvzIz6dmmV1mSUHTU1fSo4AOJ2vUA=;
        b=TiGCShdOaTTuitvRay1KkND9r9o5DR7JhwBPqYU6BTHJ8+NWTPXs4VqEjAoQ+EyDFj
         VFpP0BX/dJNvT4GoZEecf28IC0r6g61eeMFyaFywGdOXETBbTjZf+GFAfKsRjz5a1JU3
         40KIYgWPwE1GeZVXRWE2/Vy2N+yuI5VH8td90C/BVUXpiMYt692LIiJrGkcUYzTzo2WM
         xRI4m5NdStXUF+BKJwLuHhOAFnjFLDXkSmCnSIvah9w1zu7drw5h6337c34A0QHdFnyx
         QIbCSWyX7oHT5B6nk7ElSt7ljm/Gs5YQDMLty3EBfyHvTEL9LIPtEvh+9XE2yKIQWmLU
         QJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uJsVF2mMcIKQm3IvzIz6dmmV1mSUHTU1fSo4AOJ2vUA=;
        b=VyuVpcrUI8tM+UD9oxXK+ls4GLzeNHsCxF/tqLvHj1S3crjfwiiHaRpUcBQMxMmV/0
         7p8okySzKR33bmZZ8rdREa3Agf5v8EPAMUsY9++d2vDpvUjTdadU5U7XT8BfIS98l4ec
         4/xSyveENOV9TPq9quOtEpUWbPRA6fTUo3B20PvsFNac9e+MAD0yev9ZWnanC8nWTvYB
         Piw3xlBFUMZ/+a/aHrIAb8d+1K+/Of4xmJsdWGNjwPPi7hw/+BEojqXPeVcb13KSWUrX
         NmYZ6I2LgHtXG4x6dEumH7vJL1j2DmnBYuRvgTYLlm1lmGpxBFQ619TsF/9vxPSDufdD
         3/VA==
X-Gm-Message-State: ALoCoQndXIXf79xRhgI3sf+WwOQNzhkh5kIReCqhN8sbWiIf6RrXn6AUJ0r5qQTqtptXGSnDJpIYpgHvVaVcfF0SafJtTyp59Ijep5VOQHiu5QadGi0+4mxCDSK3Rqm2F4SvYwLl34u36ZkSIZWwEegfFPDaNUMGK3afNRfDfC9CUkaKOE6xRuZDCMWxPWd73dRYPMEO8pRP
X-Received: by 10.66.233.65 with SMTP id tu1mr12879319pac.35.1398725696765;
        Mon, 28 Apr 2014 15:54:56 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l7si939433yho.1.2014.04.28.15.54.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:56 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6565331C20B;
	Mon, 28 Apr 2014 15:54:56 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1483CE080D; Mon, 28 Apr 2014 15:54:55 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247489>

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
index 1dd86b8..382a63a 100644
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
+	strbuf_reset(&err);
+	ref_transaction_free(transaction);
 
 	return -1;
 }
-- 
1.9.1.528.g98b8868.dirty
