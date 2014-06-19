From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 29/48] branch.c: use ref transaction for all ref updates
Date: Thu, 19 Jun 2014 08:53:11 -0700
Message-ID: <1403193210-6028-30-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:56:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxehF-0000iO-PH
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933539AbaFSPzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:55:43 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:33968 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758058AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-oa0-f73.google.com with SMTP id eb12so694428oac.2
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1xYpAbGiiTxjevLsZS2oHWwgPDlS4OK29zIIVfMUBmE=;
        b=lGP2KcPszowzt1BJR/8ANErPwein+LFIJ1Hsf3PcMkfpzgGPX3M2nE0NL/MKfFxW0h
         u1jQuthTP1ycKrm7vP0/H80EFH+gQY7GkL6JEwRYXazSmbeRfs5hVN601JEJ8CD2XKHK
         qeMk6MKqPk0S/+Ba8igBC66EMpxPIQ4U+3F6hb45STfEddvTKWTmYbilRZFKUIqyjuIF
         uyQDNbMikIdDm7eZszhSFZGFd2OTwHufUF3vjuoB0QGpE1iWmQc484AlewQb+sT/qzpN
         xcnzcml7IdLU5sh0MZlsbN/tvZ8U4GF4M44bG/jw2YzTDOCmVIQ9pLZQR6b6E77ixsD8
         jDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1xYpAbGiiTxjevLsZS2oHWwgPDlS4OK29zIIVfMUBmE=;
        b=Y5CWmGHJ0PlQjGloJmjVyeJId2L5x9xyshHdz9MRbXqG6VyGA7jbfFwFsMrjStxZmn
         pCNLexxP8UvDIv770Ssqq71Uu5cLK8tXvN1uCpbzlDajbIdp5V3lsxeHfx6uTNSWB+Ii
         fPm/9gjF1VEW+v67RCvzEZzZBq6cnL/Ap1JPbJemHnw4nZRW2bYFLL/AlWbgLHUyVaA5
         DdiVgO/a/CmCctPER7k4fQPuYOF0xrilruuMoS3w914voiD/FylVcf/8H/Gyeo4M36aV
         EBQmSYRLib4tMAUfSPcLWhUSFqTt0sZb852LX727BjZngTy9pa40soJS+QhqQPLl9jIl
         DFQA==
X-Gm-Message-State: ALoCoQlj8rPRn6Od6aWxlfBzLQnc5hp0kuv3cMlm+v5XqoiBwdY4rcvMdCI+ba4LXcQxUO6uipYZ
X-Received: by 10.182.213.135 with SMTP id ns7mr2470491obc.46.1403193213890;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si419902yhb.3.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B972631C3A6;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 97BE3E0AF7; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252151>

Change create_branch to use a ref transaction when creating the new branch.

This also fixes a race condition in the old code where two concurrent
create_branch could race since the lock_any_ref_for_update/write_ref_sha1
did not protect against the ref already existing. I.e. one thread could end up
overwriting a branch even if the forcing flag is false.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 branch.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/branch.c b/branch.c
index 660097b..c1eae00 100644
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
+		transaction = ref_transaction_begin(&err);
+		if (!transaction ||
+		    ref_transaction_update(transaction, ref.buf, sha1,
+					   null_sha1, 0, !forcing, &err) ||
+		    ref_transaction_commit(transaction, msg, &err))
+			die("%s", err.buf);
+		ref_transaction_free(transaction);
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
2.0.0.438.g337c581
