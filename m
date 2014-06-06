From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 26/40] walker.c: use ref transaction for ref updates
Date: Fri,  6 Jun 2014 15:29:04 -0700
Message-ID: <1402093758-3162-27-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:30:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2ev-0002x2-6R
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbaFFWal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:30:41 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:53742 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbaFFW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:23 -0400
Received: by mail-ie0-f202.google.com with SMTP id rd18so741002iec.3
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K03M5T4VvYSlR4+BFnNfW1n8GIepwUu6MqXKrkmlH20=;
        b=SjKir2mdvTMCpmZ5H5jVUEVGgSRb5pqbyoAMYimKvujgKNlUysfvqRRebNO838FUrX
         tcQhkKqALkYNVPmbi3WmAj8C7kAhA4w4+54JDoHvR5xNvkyJQTUmb7S/T30oTOWBmzt8
         BUf28D4j5h0Xh9e4oJX9wZ3HKs97zausrFKxWclT4I07a8ylrnivFLMOlE5arJGX04nY
         H+u2wJm4G59tro9dgY7ALXBzzbZyWej9oUr3KUOkY8kJOENgxFyRBx4VmMGPeFK3fIcH
         7ztPkwtN0/0vbl2u5nZO/kaCk8qm9ta4WDjVmSINZ3y356H2G132fw98b+cF7PWAHuvh
         +CFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K03M5T4VvYSlR4+BFnNfW1n8GIepwUu6MqXKrkmlH20=;
        b=LNrLAKvBxxXNdWaSPa3Kwx8hu1Im1VJNvoeX/yHJ/D2aHUco3meTDLhp1PUVLPUV6f
         1J3eUazdpm9+7GNjv63h+2hQ1cEWeSWuxLJBv8B9FdkfNV3/e7fAGiE7licSGjykL0jx
         wFeJJtGMFLl46rkWCjizxH3idXW2hrF4W0Wvq15sGl6M/wJAvFWVrB73gb4nIFU5zi2s
         839wWV0eOJApB5aFZdPSgTTXi8UhhCDx3uc02LKeUBqr+QHSdKCZrWbMEQ6ggyFo4cBx
         ZUqlpOSGt6wJAYPWXgqlf3Wo7Rkac8Z6tIKW3oUfECnIbA9RCinL1jAevMFx8Guo+PGn
         1MAQ==
X-Gm-Message-State: ALoCoQlIZFteXFA5q0JOvAUI7+JJNKMhW4fMnNIDlbAHFFJKzBle5NgGJocj9QpuAzrUNg9KrG1r
X-Received: by 10.43.67.67 with SMTP id xt3mr4690305icb.23.1402093762931;
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id l7si751219vda.3.2014.06.06.15.29.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 853905A44F9;
	Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 610B0E10DE; Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250996>

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
2.0.0.582.ge25c160
