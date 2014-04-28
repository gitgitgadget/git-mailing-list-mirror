From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 16/27] branch.c: use ref transaction for all ref updates
Date: Mon, 28 Apr 2014 15:54:31 -0700
Message-ID: <1398725682-30782-17-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:55:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuSQ-0006FO-Q2
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbaD1WzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:55:24 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:35883 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740AbaD1Wyx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:53 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so1130283qcz.0
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wk1z6d60cTFl0BS1M2FNlRjaZugiZ2zUFtnjpGSMBl4=;
        b=gKwZnNi6HUmtgQn2L9UR38KMGGSEolnMc4iXpzND/nR0nf+JZSJ1bYH9aZpXEdGv18
         bKdEuYXaHQfB+vezS3f448DsbCUlrvSLvTuayM8pWBMXr4kd8nGFvYH7yPFUvVSDE98j
         XMFYpBybE/7lSFrSPFbCAAiXmy0YPxAHfO8k2qlPpzn6dklA4HLCxxonniK9XbGzCW2X
         JielpewkNgMngPXbc9QVQPm0CqtccugzIXyaQ9X/fJSk9WVvPfmlv73QloYxxMGUDz3p
         dh4F1084KPVrK58mivetDbMtO3a1r1OusaRPSjfJdh7GPjH4fn1jjlkD/IBupGc8bzbR
         9tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wk1z6d60cTFl0BS1M2FNlRjaZugiZ2zUFtnjpGSMBl4=;
        b=T4wgyP3r+LE1jt63GWdJ5m8NSS/r7Ko2fXzDUHNpVVehg4JqbFKDwEERNLdbzNgt9g
         HMTNVJQy9CSX8rUV6ASwSKgkVXX4EmGeMD9VlEO3II+vblbXfJbo+sooPZ/9du9F5vxx
         mg6T/LhDBseK59JcDwGQ7HnXzr3Dgs9s4i82lq2BH9V7jMz2lfUKMGb8tAQiqybqclet
         Iqbe3YWR6Zmut699VVj7c7+hOj1UThCSMh5lYuHeFujeGYIfy5dALw4xFvBse6BL0SzK
         fC6ctKqGBm9s88AcNl+d8IU2+5cxxxwA2xvm5Qh1gXzEn8S3PXnw4I4AYEUDhyYdliXX
         kKnw==
X-Gm-Message-State: ALoCoQmZMruw6HuO5+wL9pd/HVIHVUaLNnbnYdXmtOhN2DLKNbyQt6u6EEQUonMsLTDNE+Y+vmEb6GBVEmtGnAr/0xUKLX5A7JdNF1iCeYp3Q6hND5dgS1LPhPsNGS4dz4Dxc0ga0ARBBwQc6wlB4bpdiwhugRpK5+LtaagcMK06ri9xlXFTCUg9IXMKg9AgoPiOXJvTfi4m
X-Received: by 10.236.118.38 with SMTP id k26mr13051436yhh.35.1398725692712;
        Mon, 28 Apr 2014 15:54:52 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id l7si939405yho.1.2014.04.28.15.54.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:52 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 856795A41EE;
	Mon, 28 Apr 2014 15:54:52 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 29E2CE080D; Mon, 28 Apr 2014 15:54:51 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247472>

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
1.9.1.528.g98b8868.dirty
