From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 27/44] walker.c: use ref transaction for ref updates
Date: Thu, 15 May 2014 10:29:42 -0700
Message-ID: <1400174999-26786-28-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:32:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzVh-000206-DK
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533AbaEORbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:31:49 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:60083 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755678AbaEORaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:09 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so289896obc.4
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TwOKw18N10X6MSXSvlPXh+72SBm+U7sVWFYkWJ7G5PM=;
        b=aiHSTKAP/uQlLMnnDVGuPugY/Knsko954wiucfrjrpBQvYWLDZvNozu6AVdwlez0Ps
         FYzDt9xg3lnOgiuuyV/Ts719ha35ptVTgHcriQHxpnNKOhdjruJlpq82CIn5+TJ7ZnPs
         Oihye+qNpOIB29+zhDPTagMl2/338/3PIaVCXjzaE52Hun/HkY+nZs6coL4wB3RsY0BT
         tse8Xvy7RJRJc3qtp63rl8BfnbQaJ06rL8jMVHVHPaAJ3DXcchMH1fs9b9TpuADvyM45
         EehD491bM5M60fAAUUbFY+akkibGceRV+BMIM2094349l8I4OqEzQWtW4o1w9q3I7dwv
         uR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TwOKw18N10X6MSXSvlPXh+72SBm+U7sVWFYkWJ7G5PM=;
        b=iADh+i11t4faEa5KIe5Tf71sBuaKbUzpagYCnd9d+l5Akag0od0dCZ4Bh8BYRm55H3
         x0ctT4HZ7SCpclmBnyA6u2pbXsf0OSkHpnkuOS5SrDNQMyuilvYwDQFSlYmuXvoLNnY8
         THhMyY7wnJNRDc2Ri+vWyFp2v/FhYrWaxPlgZZBggCuRKiu1VhMFfU5Hiv3rNV96xydx
         0G/ECcb8UsE4xIfhKOHnBOHo7uV3W8OJRiVRikOG40pVRvtuLBarx/xGPUI7/NxAQJcn
         48o9OvNtbAtfDj+xmI2kNuIK5C5DQ8ygwft6pPgzfVO6kTJBjZiEQq3Y4cxOmpeomAww
         iy0A==
X-Gm-Message-State: ALoCoQll8q+A0U35YMh4prXmEsXaaggundyIGINpejiW68fm5xCqplX2qrM7DJngvu7mHNQ0ooOB
X-Received: by 10.50.254.1 with SMTP id ae1mr21135399igd.6.1400175007011;
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si272071yhl.7.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B76B431C1CD;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 93DC9E1084; Thu, 15 May 2014 10:30:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249149>

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
2.0.0.rc3.477.g0f8edf7
