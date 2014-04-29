From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 25/30] walker.c: use ref transaction for ref updates
Date: Tue, 29 Apr 2014 15:19:10 -0700
Message-ID: <1398809955-32008-26-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:20:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGNv-0002Us-DN
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965328AbaD2WUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:20:07 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:42612 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965288AbaD2WT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:28 -0400
Received: by mail-yh0-f74.google.com with SMTP id i57so114264yha.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WyMx+XxlRDadFQX4zeALBFFja0qWAWU5UttSZPEvEzM=;
        b=ZJNSEfgy3cA1ynLFOMN736BDkAPJIcYiAT/J2cECv9Nx/ghzMO4GuJr72O6/cUU/6r
         BknEIv6kMeX15VIJmwNU4U5lWFbfYIhhhLjR3MG9ygUPqJU8MvaT8doYjTxj3HL0UrVk
         hBXVa0Ix/F66MZWsm/QtQMwfh9xqsts1I/6Zv97YE9iUF2KppyWKfOh90dU6yRHy9Q8M
         EZNKTPls9QxFdPX5Ask8miiAEf2Bx0v4/1Q2F/pH5ZZpWRwP4zAUfPDJ88S14+nMY8or
         D8LgJfN+pZB7ICCOeI5fD8udBJds91vi60cISStTib71DttUa4xQZfbylRFB371Ognha
         csKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WyMx+XxlRDadFQX4zeALBFFja0qWAWU5UttSZPEvEzM=;
        b=ONXwK6CZEPyznSZSvJDUuAyDOt8a0njQOGuVDairp6139+lRHKJ3ch3vgwMkycFRVR
         NdpowvCe+/6tnkHyjJvfBkmgc0iFl8czarlHSKE6ZhcS1xRBsCLwvsIUzUoZYP+QiZ/A
         6vujVC+gnocw/I3hhcj86u4GBFJ4bolb8vC9wsYi7WwNUCOO1hZ0kcxb0oEvViOaD5fl
         kA3RWjedbtvyNZQ4D15Y4u0xRYSHYRyL2e6GQNBqMwbISQPf069BtwVltQqgPX0yuCr9
         dvyrbR26IwU+DbsdrjK4iMJ9pYKkxhbe5jVfSzrNXy8DdJxYDJHs4rYDKOceGejx7eut
         l/Lw==
X-Gm-Message-State: ALoCoQnlP3MyYVBLRYrIFjcuUJBkNsA9kObITb+Qp4yMyE6aDsEWKvSICfZ+mzLi72oKbykxE0BbRCayFK0YBFMpXcp3OL2555NlMvgARnpZm75ggmMQclEwQc82g8SWzh134rqFoMQIR9zBqcsPAo8X6Fi5Fl6lvevKoEColzCzcWgDRtPCU9ggT038gRzsMrjQoeBIoVyD
X-Received: by 10.236.118.38 with SMTP id k26mr253363yhh.35.1398809967853;
        Tue, 29 Apr 2014 15:19:27 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si2739710yhe.3.2014.04.29.15.19.27
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:27 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9627231C1D2;
	Tue, 29 Apr 2014 15:19:27 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5B4A5E0A5B; Tue, 29 Apr 2014 15:19:27 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247637>

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
1.9.1.532.gf8485a6
