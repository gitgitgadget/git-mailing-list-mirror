From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 30/48] branch.c: use ref transaction for all ref updates
Date: Mon, 16 Jun 2014 11:04:01 -0700
Message-ID: <1402941859-29354-31-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:06:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbJ1-0005sy-GI
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbaFPSGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:06:50 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:56900 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932651AbaFPSEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:25 -0400
Received: by mail-yh0-f73.google.com with SMTP id f10so854536yha.0
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6GjtFS2/94bEFhlb4WxtN6zTKEjbof+vUX1cPV4N2KI=;
        b=fwl/xsmxFdD1OXsDMlxY/79TqxO0f5qLYikzQOJsC13meQ3r8Z3EVDhoiMd5QuvD1I
         OEHP861amavnb5KLTTiTBMERx/iE+x9bJWJuG+GCI5L4OldqR2hFbyUSG2jMS+I+HoDc
         eIhL0MApUE0kFbjZeRqjvQ6UBXYYv8ddBCPD7OpM3RCckek5rKc6XNeTYIm/pjvfEYGi
         2YCwPBbZsVTnASn5VfGrWuKbi3yfKqDzIBO+oQ2DzDXk1K834013ZZ2QFv/9Dz1CpOtd
         dp8jVTjYRDcdAEf9sahWw3mdq/MwZQ/zbhJzZej+R9HMjX2bQgN36BMFTmYmlJ/toed6
         FKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6GjtFS2/94bEFhlb4WxtN6zTKEjbof+vUX1cPV4N2KI=;
        b=KBWjOqjWtKHQPp2O396l8gR2mUZDyUY6c/nQYd9Bm/me20DuF6Xj2UyFul6t7KioNU
         1cmVzbp5ntTmmd0tY/o4Cs9njBFRaaI3tVCUkWNZqz3gpehgNBlAF8VdT1Z4k+XiGJVP
         M2RzwvMW1Mhk3Y4s+99MWNZvTF0bTA6hf+sx2BSObJ8ZiAFTiFDzzZI3CDQoEsd6KgXq
         ZldtD9s7Azdmnvq2JcXZM73z9B6Qs8jA2Zv5S0ipUuHjUmXiGW2ZfYqWLy1noEWxx5B3
         5OA57hyqJEXk3N5V0ecsI/rcZm3RW/uj7y31wQ0g3OthMhi02WNZSQmdyU2UxPrUqQgH
         za3A==
X-Gm-Message-State: ALoCoQk190hIHmaAgfuMmbnYF0JUqPvGvrrvr3uAPHqJZBxiwWHATeaFd8v4uYDEiPDFsnYwSvif
X-Received: by 10.236.55.69 with SMTP id j45mr6802781yhc.49.1402941863485;
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si996132yhl.7.2014.06.16.11.04.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5664C31C8AC;
	Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 330EFE0961; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251762>

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
2.0.0.282.g3799eda.dirty
