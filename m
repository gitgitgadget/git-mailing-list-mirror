From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 18/44] branch.c: use ref transaction for all ref updates
Date: Fri, 16 May 2014 10:37:06 -0700
Message-ID: <1400261852-31303-19-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:38:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM57-0006xE-2O
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758108AbaEPRhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:37:48 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:35516 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757865AbaEPRhj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:39 -0400
Received: by mail-qc0-f202.google.com with SMTP id x3so490616qcv.3
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QZbzzujnodn0K/rVRiKOuH0ilJvqnJ6buBf0rjh/8h0=;
        b=brRWwBML+OyKWH4FSwXcVDa1Tk24V8SB+Cedq39+K3vvvmjUzo2aYJ0kykAswDU5M/
         nsnOLwuthdS6qW354Wpm15B43Z03oW2bxn625k+IQczbIOftuJsH2WVpmZsKVYE/+cKR
         9BsJa4pUUA484c/ox4rzkjViM7+EbFNPZmACLu0tuOLBEi2j1mqFQ+zItm6gGSdXgwAd
         YFaLliHM6HpFSt3sixi3tX2i6Zr0IuCdVI0SbQ1i/to1Sxtx/viKfbYUoDYsrvsTZGMV
         scjyImucXzdtjQkTY867DuhF9KNh7RUFY+ljxIhL+NafJQRH5wNi7CPG4LtkMAKInE+1
         eXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QZbzzujnodn0K/rVRiKOuH0ilJvqnJ6buBf0rjh/8h0=;
        b=IL7iLuSO/2HDhmpkbS28OEwaA9apdWPPPJF0yF9j8ydg7kJ/UeR+bHA6o3l3jqJeEF
         gELE8JJKfHZsQhI366a/hBNi/ynSc4q6sAIXXtt4qv+HsSyqtmQoUHp3076kkbIrxxTe
         r64cjkKs8yGElRF8ftPgpL48DqS8sPNxznsmn6WJH3NAfevonI5FwQo836fDHfN/U42G
         Gdg8rm5j+1oKwsfN3FYn4/NjphYBJWKSEyOXt5sfKHdnH9lIv2nCBaym3DOWZeL4tohB
         rhQDL5bbXfWZB6fe4IIwmLT6mza83Q4lfcDl5IiJ2FvYTKMtPqujfVhFReCYA9RtXWH7
         tr6g==
X-Gm-Message-State: ALoCoQk5S6jGYsuhotxXAsarrLOL8eQXJMkW0zxNE598mF22oTpxs9tWh4vQVoQCDL+6MHYIDJUi
X-Received: by 10.236.128.112 with SMTP id e76mr7706505yhi.38.1400261857389;
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id h18si443260yhj.0.2014.05.16.10.37.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 41FA731C2A4;
	Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1DCE5E115F; Fri, 16 May 2014 10:37:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249362>

Change create_branch to use a ref transaction when creating the new branch.
ref_transaction_create will check that the ref does not already exist and fail
otherwise meaning that we no longer need to keep a lock on the ref during the
setup_tracking. This simplifies the code since we can now do the transaction
in one single step.

If the forcing flag is false then use ref_transaction_create since this will
fail if the ref already exist. Otherwise use ref_transaction_update.

This also fixes a race condition in the old code where two concurrent
create_branch could race since the lock_any_ref_for_update/write_ref_sha1
did not protect against the ref already existing. I.e. one thread could end up
overwriting a branch even if the forcing flag is false.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 branch.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/branch.c b/branch.c
index 660097b..8bf7588 100644
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
@@ -301,13 +291,24 @@ void create_branch(const char *head,
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
+		    ref_transaction_update(transaction, ref.buf, sha1,
+					   null_sha1, 0, !forcing, &err) ||
+		    ref_transaction_commit(transaction, msg, &err))
+			die("%s", err.buf);
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
2.0.0.rc3.510.g20c254b
