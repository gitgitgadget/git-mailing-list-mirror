From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 16/42] branch.c: use ref transaction for all ref updates
Date: Thu,  1 May 2014 13:37:16 -0700
Message-ID: <1398976662-6962-17-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:39:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxlt-0002wG-SJ
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbaEAUjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:39:45 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:61053 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298AbaEAUhw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:52 -0400
Received: by mail-ve0-f202.google.com with SMTP id sa20so429369veb.5
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CAfZBAOeQ3Z+KSFEvosqMnPeeQ1PQRow5HMkYsmcoDw=;
        b=Gd/IMV+cHW/YIA99s9+GRsxy+WE9KjEpXLv2gvNVoUVNS4f8qMJkM/NgbG+eO0iA9f
         YiIqSxwaOXr8t3/8mHqi9umaU+V2xdPcAopC4+gdkvAas4I6CTvqL2rjOb+dahR7IVLV
         +kYNrl83zdBQMPBDGAvP9chLN+i5cqaQ8gQOU0MxJUOs36Er/ZAl1Wo0KDsSNUd2axOH
         Md+3shGlEHhwMSuayUR3L464oBZulOElqE1EDjWFdzmvlTqUEFBCDjfXGhOVCnNQWivi
         /IDonuNzx7V5xDnzWuZdrRqytldR25CNn8P9jFjQyTR3BJnPX0xeGSL9pBRD6us777ci
         9fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CAfZBAOeQ3Z+KSFEvosqMnPeeQ1PQRow5HMkYsmcoDw=;
        b=Uo4aTdhO6FWgumv9HBwkLO28YiuOCvI7C1MSknXccrXj/OkXo1cO/ojcLhuLY6rGSm
         UlwFhRyrwin8t/SDhy9eE2i0VNOYI0zNi9oSro4Yvupxqonfqvn5Cvhz6dOGjTdlQm/X
         8knvyeytq3mb9gLEpWTjVuAsNkWJdpq+lMESfBTD1BUZSBD/B5jKgTUWCCuNyxs58R0H
         ytVW5BWbVrMv2WZLDCHJjkCiHts86a4PCOatafUsHbs9+3nXn+JfBQUZIi/qBdSoX16e
         oZ8yj1TxMdCbxD6shO+nUP3x1O3BdEQ8/MJb7Vk0YuZZ1xrRDFdKrlTuSf8tVbAu32Ag
         NWHA==
X-Gm-Message-State: ALoCoQnEtbBne/xV1JaVL28Lg8Ndcs1boE9+YT2p62g3yxISONF05KhgXfRvigVQpeehYe5ZBYGN
X-Received: by 10.58.41.39 with SMTP id c7mr7021673vel.25.1398976671672;
        Thu, 01 May 2014 13:37:51 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si3537666yhk.4.2014.05.01.13.37.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:51 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 83CBD31C1CC;
	Thu,  1 May 2014 13:37:51 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 46E6BE097F; Thu,  1 May 2014 13:37:51 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247865>

Change create_branch to use a ref transaction when creating the new branch.
ref_transaction_create will check that the ref does not already exist and fail
otherwise meaning that we no longer need to keep a lock on the ref during the
setup_tracking. This simplifies the code since we can now do the transaction
in one single step.

If the forcing flag is false then use ref_transaction_create since this will
fail if the ref already exist. Otherwise use ref_transaction_update.

This also fixes a race condition in the old code where two concurrent
create_branch could race since the lock_any_ref_for_update/write_ref_sha1
did not protect against the ref already existsing. I.e. one thread could end up
overwriting a branch even if the forcing flag is false.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 branch.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/branch.c b/branch.c
index 660097b..2aa5c82 100644
--- a/branch.c
+++ b/branch.c
@@ -226,7 +226,6 @@ void create_branch(const char *head,
 		   int force, int reflog, int clobber_head,
 		   int quiet, enum branch_track track)
 {
-	struct ref_lock *lock = NULL;
 	struct commit *commit;
 	unsigned char sha1[20];
 	char *real_ref, msg[PATH_MAX + 20];
@@ -285,15 +284,6 @@ void create_branch(const char *head,
 		die(_("Not a valid branch point: '%s'."), start_name);
 	hashcpy(sha1, commit->object.sha1);
 
-	if (!dont_change_ref) {
-		lock = lock_any_ref_for_update(ref.buf, NULL, 0, NULL);
-		if (!lock)
-			die_errno(_("Failed to lock ref for update"));
-	}
-
-	if (reflog)
-		log_all_ref_updates = 1;
-
 	if (forcing)
 		snprintf(msg, sizeof msg, "branch: Reset to %s",
 			 start_name);
@@ -301,13 +291,25 @@ void create_branch(const char *head,
 		snprintf(msg, sizeof msg, "branch: Created from %s",
 			 start_name);
 
+	if (reflog)
+		log_all_ref_updates = 1;
+
+	if (!dont_change_ref) {
+		struct ref_transaction *transaction;
+		struct strbuf err = STRBUF_INIT;
+
+		transaction = ref_transaction_begin();
+		if (!transaction ||
+			ref_transaction_update(transaction, ref.buf, sha1,
+					       null_sha1, 0, !forcing) ||
+			ref_transaction_commit(transaction, msg, &err))
+				die_errno(_("%s: failed to write ref: %s"),
+					  ref.buf, err.buf);
+	}
+
 	if (real_ref && track)
 		setup_tracking(ref.buf + 11, real_ref, track, quiet);
 
-	if (!dont_change_ref)
-		if (write_ref_sha1(lock, sha1, msg) < 0)
-			die_errno(_("Failed to write ref"));
-
 	strbuf_release(&ref);
 	free(real_ref);
 }
-- 
2.0.0.rc1.351.g4d2c8e4
