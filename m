From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 30/48] branch.c: use ref transaction for all ref updates
Date: Tue, 10 Jun 2014 15:29:18 -0700
Message-ID: <1402439376-25839-31-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:38:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUYn-0005Ae-Gr
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402AbaFJWaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:30:04 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:43787 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-pd0-f201.google.com with SMTP id v10so138231pde.2
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mYPbEMnOLgM96GwhyEXPGcFqIvYrs0hvM4Bts4q5pJA=;
        b=bz0JICq0moh7WiqA6GVJGDPVrMOSfrGPYcU5PksECtzlM5S8sYxDsU6SxZOjqyhxzG
         h1cyaOjbXYAV5E9TH1+SqZVL45ptBmiuftWzDt4B91wjFwNgu1JDIpsZF7lHXoMNC59G
         Q4WRrno+7k3aj3yygvk0w2z1V+bLzn4uCUhs/6jBuPbQv7dPPHMeHk1qhISEGem4qZUc
         ZywU1jK72Q7Pk1ppF5LR5VA2uXA4XSMkgFDY+tW2ghb6gH3s2kItkf/LAi4oCD5oQN0J
         WkWCW3m3KQ3oh+4+IXAU02QAVwHCTTdQYzLGHjQlsGIIg8YIkObznro9SUr0tr27hHW6
         fx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mYPbEMnOLgM96GwhyEXPGcFqIvYrs0hvM4Bts4q5pJA=;
        b=MfEiClNmLLNeR9DjKAgRM4u2CnFtsU+PtpsmUIjTZ9rFCzYNgKPenW+if6AkUTm7i4
         ME/N7XnTj/NpAFqADnjQFKC6RxxJVnXuas0C/36doxrU9kqT0X0JV/gcAUH1yf6QqcE6
         2lpAAM+YeoFnTOwo58WP0hsU/L3xhQI2h8wJhZ+amzjvbnZcQMxYKKzdWOSy8AANWrnm
         MCl3N8Q9hntmZP6JTt05ByvD2tGDTlCGPfokqfuAgJWBd46YPIc234J9INpY85xv7avO
         Tydt972pn5aUhvY2+rL/3DjB8ziGlL9yKY3y6bHRZ7n3gCgHWhzTuEOhTj240u+eyPv8
         anhw==
X-Gm-Message-State: ALoCoQkqMjkv38iPW0YHBmIKQkdk2rsDzd1TazNWwd2/XYTJeLnJlfP0FvFiy7FfsIrRfBZal5Y1
X-Received: by 10.66.175.173 with SMTP id cb13mr129695pac.10.1402439381392;
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c22si1396563yhe.1.2014.06.10.15.29.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 377C431C741;
	Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 13F78E07FA; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251286>

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
2.0.0.574.g30c2c5e
