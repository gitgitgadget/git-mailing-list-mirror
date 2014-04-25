From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 16/19] branch.c: use ref transaction for all ref updates
Date: Fri, 25 Apr 2014 09:14:51 -0700
Message-ID: <1398442494-23438-17-git-send-email-sahlberg@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 18:21:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdisX-00087k-3T
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbaDYQV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:21:27 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:43642 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbaDYQVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:21:25 -0400
Received: by mail-qa0-f74.google.com with SMTP id w8so635349qac.1
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 09:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XQ2ctXBM8tounYNh+aPe+qnP68as69rjzwo5jycpSOc=;
        b=GZTtICHZok3Pw0OgykZtvj4Ihx8+P0KSuEN1su/keFZwVCnTGAjr6HhKelm3nyFhlk
         tF8rNmVC/dZ9q+VPF+tjcy2dRbcN0mYLXkBUy8RVkLgm2W2n/+zZfgaNRDiGgUlct+Zs
         D9mO+wT20EY7PYxHRxuSWP3FvYo8lAau01zD8wnra7FwjQmWDly0cvmRLD+tqsHJi34X
         j+BfnaSS/x8hOl5LCquuTlNqkRByaWGRXKRICM7hqnFxnhzw9Oem+Bg0073Cs79Od+96
         cywVbeZndjHx5xRWXlk/rtIQ/HBBqalzCFXo3si1+WZYSwEmOkfhCC0P2rytJnY6ctWh
         S45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XQ2ctXBM8tounYNh+aPe+qnP68as69rjzwo5jycpSOc=;
        b=HU15lr+qmx2ePkZrQhL5tZquDFyJ/vQElionjtvBpU9P1AsUK28vuqTEpcIPGuLQUs
         hSpGK/J6QEXE7NeJQmeY9LY3kDlDXIBT2KstHnxDm94mJG2uI+d2IclfkP/O0/Pyt+5z
         5XtGniKZYpJUd7EYe0C8fNVlPEy3D4rlQffSWIdS9+RF2nHCLzCuzBC+UUU3dxAVeHMC
         IhxQJM02mNXIZ8deN/O6PKGoSr3jss7T6NbxFcV2WKigBNZcquf6jCdLDJVelUhlmwHA
         EBwbCNvquN25TgcuMjtmU6vrPemuGExfR8a9Iy3Ahhxkr63I0VzEtfxJIepVkgjcVs4L
         3WBQ==
X-Gm-Message-State: ALoCoQmn2pydPZnB+wTmiqAL7PlBF1r6NxvaXSwBNSUQbturArssXpe5ODHWT81ccBnkvEYLgAkzsLaoc8g5WNV2unRqG0WjSkxPrvzIwm3weCW+GYEAK045MAoZBzPG6nCPXIL2E/m/XlA5ku5fQXnOqBTB8TYlaqwX6Fi9rXd8/MUP50bz3OITHtDMIx51iuT8Lm7n5dZe
X-Received: by 10.58.199.170 with SMTP id jl10mr5048057vec.1.1398442507745;
        Fri, 25 Apr 2014 09:15:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si1050734yhk.4.2014.04.25.09.15.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Apr 2014 09:15:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9632431C028;
	Fri, 25 Apr 2014 09:15:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3AACFE0855; Fri, 25 Apr 2014 09:15:07 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.521.g5dc89fa
In-Reply-To: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247070>

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
 branch.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/branch.c b/branch.c
index 660097b..23cde1e 100644
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
@@ -301,13 +291,34 @@ void create_branch(const char *head,
 		snprintf(msg, sizeof msg, "branch: Created from %s",
 			 start_name);
 
+	if (reflog)
+		log_all_ref_updates = 1;
+
+	if (!dont_change_ref) {
+		struct ref_transaction *transaction;
+		char *err = NULL;
+
+		transaction = ref_transaction_begin();
+		if (forcing) {
+			if (!transaction ||
+			    ref_transaction_update(transaction, ref.buf, sha1,
+						   NULL, 0, 0) ||
+			    ref_transaction_commit(transaction, msg, &err))
+			  die_errno(_("%s: failed to write ref: %s"),
+				    ref.buf, err);
+		} else {
+			if (!transaction ||
+			    ref_transaction_create(transaction, ref.buf, sha1,
+						   0) ||
+			    ref_transaction_commit(transaction, msg, &err))
+			  die_errno(_("%s: failed to write ref: %s"),
+				    ref.buf, err);
+		}
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
1.9.1.521.g5dc89fa
