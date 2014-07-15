From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 09/20] fast-import.c: change update_branch to use ref transactions
Date: Tue, 15 Jul 2014 16:34:07 -0700
Message-ID: <1405467258-24102-10-git-send-email-sahlberg@google.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:35:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CG5-0003hz-Qh
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965228AbaGOXfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:35:31 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:62684 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934260AbaGOXeY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:34:24 -0400
Received: by mail-qa0-f73.google.com with SMTP id s7so21260qap.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NSAcWw382y7+nF79Z+/YJnSQrLb9esa1+elm61JN85A=;
        b=mDIzCo+U3apUxUeOzPEOM3kqWsbj9m3ROB+Kdc+17FuZ7JqWRC0JRGOYYVcz21VxbF
         3G93HZRUuqRFF02JT30m8EA218KyKpffruBvZQ2RSWqbBXGMDDjla58bbBuH4AabJ9ps
         IAHn0cB563vSst6gpz0y8CMRPu7PJB4LTt2Nx9fjmYaqLw2lPyn6bPo+l/QMDkhAbcEy
         etjdkB7L4o8f7v81mRUFC4ZS6WLjK7k0hajoheQWTrffYzJmryNE0tYtFlidqY2MGw3P
         8nFKxUeVB58iklWgt9EuBHm+dGwl9azOjPyXLJ6Zn8sK+Cz86UXzgrNSCj7gFcd+6I0H
         UWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NSAcWw382y7+nF79Z+/YJnSQrLb9esa1+elm61JN85A=;
        b=cMYzIePjAsbhbI0DvScV+S2wiTSRDGvSV3l0s2+l/uzNvoZ63EFPnUCTEGcv7Vr1gF
         Zs0yRV9qLSRW9BA3lRiBUsMk728ySo8WeFp3Ucq3kM2zEIbbJYRMdoULv5T4v1jkdhiU
         Za7Ij0oDLKKf6+wzTYnKbqmnkuvywVEa4NyRfYgUzUaCuxH64QGdoXn5dXMcVGvLWugv
         CfoyN0FdlgFzvL7IHKfLXnSImjiUB6bf8eC68SJFXNG1a+CuX05inMGCnxZ1Bb1Hkt40
         ePRUlBtC+fd2fBUxWp+MEPL7Faw43Rd8EpskzgtM0CbElNyP2QGn61Dhv8yjlD8VCr+t
         gAXg==
X-Gm-Message-State: ALoCoQktqzceO8IIAdNJVXtqQ5yPAIuiPhDIu21aF4zUMLCYYqso4HXFOasG1m8xMxpo8tj9nsnF
X-Received: by 10.224.134.195 with SMTP id k3mr11217416qat.4.1405467263613;
        Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si1058681yhl.7.2014.07.15.16.34.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7184231C2D7;
	Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 456B4E0B6B; Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.481.gb244468
In-Reply-To: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253644>

Change update_branch() to use ref transactions for updates.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6707a66..d5206ee 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1679,8 +1679,9 @@ found_entry:
 static int update_branch(struct branch *b)
 {
 	static const char *msg = "fast-import";
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
 	unsigned char old_sha1[20];
+	struct strbuf err = STRBUF_INIT;
 
 	if (read_ref(b->name, old_sha1))
 		hashclr(old_sha1);
@@ -1689,29 +1690,32 @@ static int update_branch(struct branch *b)
 			delete_ref(b->name, old_sha1, 0);
 		return 0;
 	}
-	lock = lock_any_ref_for_update(b->name, old_sha1, 0, NULL);
-	if (!lock)
-		return error("Unable to lock %s", b->name);
 	if (!force_update && !is_null_sha1(old_sha1)) {
 		struct commit *old_cmit, *new_cmit;
 
 		old_cmit = lookup_commit_reference_gently(old_sha1, 0);
 		new_cmit = lookup_commit_reference_gently(b->sha1, 0);
-		if (!old_cmit || !new_cmit) {
-			unlock_ref(lock);
+		if (!old_cmit || !new_cmit)
 			return error("Branch %s is missing commits.", b->name);
-		}
 
 		if (!in_merge_bases(old_cmit, new_cmit)) {
-			unlock_ref(lock);
 			warning("Not updating %s"
 				" (new tip %s does not contain %s)",
 				b->name, sha1_to_hex(b->sha1), sha1_to_hex(old_sha1));
 			return -1;
 		}
 	}
-	if (write_ref_sha1(lock, b->sha1, msg) < 0)
-		return error("Unable to update %s", b->name);
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
+				   0, 1, &err) ||
+	    ref_transaction_commit(transaction, msg, &err)) {
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.0.1.442.g7fe6834.dirty
