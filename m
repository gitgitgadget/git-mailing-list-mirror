From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 25/42] walker.c: use ref transaction for ref updates
Date: Thu,  1 May 2014 13:37:25 -0700
Message-ID: <1398976662-6962-26-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:39:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxl6-0001wU-Nk
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbaEAUiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:55 -0400
Received: from mail-qg0-f74.google.com ([209.85.192.74]:48716 "EHLO
	mail-qg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbaEAUh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:56 -0400
Received: by mail-qg0-f74.google.com with SMTP id a108so182270qge.3
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wV+nTR7SasroNYy5IcZxzVcj/dEX67hwMQJ4Qc9kBpc=;
        b=pd1ZEcR29CNfLhnFRkSvE6FkF/SIFXurJ2uPUF9SS6OWeq1+2HbieJlzWFzk3hJFwy
         QIYrZ+QOmYv7wf+tgurMuC9oFljX4bwlCjZ+P0zrodOJLU4Rmk8bJxGTmALSywxAsIZZ
         ZwW1OqCDC4jhOXpTptNVa/+7VbvCgfKTxzrTQaixsUj1E/Jvq4KGncFmtbRAHwOJbwK2
         +2LNYfO66H+KgBojwJleZStW34zMKgV5o+ECFp3dEqHHtXu+GbrQVnxVOfquMrVw/qdK
         5C+Iy1drnvQAl6gMFkH/djHrxHAtnAUxIjhHopxwcacjy9dYyu4UAMla46yCjpY0Me11
         hWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wV+nTR7SasroNYy5IcZxzVcj/dEX67hwMQJ4Qc9kBpc=;
        b=btewAWWMD8g25Vx7qpn6i0Wr+33WI80hXhXHgwQdLQnQfd9OXiVbDNGtHhvQgeewHM
         iojmb0r5ikagfAi+NA0OdcNv6q9ylRMUeRnuaVuwPmEF6XE2YOqdAQuQ7+ZrWGRvAkeL
         ymLFN0MDbcXyHybcF0dz4QS1kowA3vDlF7kj0rU13Z1jLb8gLvFLyUbk6iNu4yjz1tGo
         1BrjHXruQ6uz9uI3vJD4eoL1HDWUcAdaILXi0oZleW8+kAJ4s7ZGL5bDBzN83rM9669i
         HDxVy3C2jse+awkn7AyGvojitPWGknUWwpOrc0y5wvExB0CwgkEhNalAaqdSEoU1l+zk
         QJTw==
X-Gm-Message-State: ALoCoQm212DXrFXXcQa9W5GvxGenSmbEAYmYv3i7N2SZqAUG1SJG/Nxmg/uFPiH1eY11kKDdLWPe
X-Received: by 10.236.4.201 with SMTP id 49mr6085994yhj.47.1398976675384;
        Thu, 01 May 2014 13:37:55 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si3537687yhk.4.2014.05.01.13.37.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:55 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 17D2331C1CC;
	Thu,  1 May 2014 13:37:55 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D162FE097F; Thu,  1 May 2014 13:37:54 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247856>

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
2.0.0.rc1.351.g4d2c8e4
