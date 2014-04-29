From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 16/30] branch.c: use ref transaction for all ref updates
Date: Tue, 29 Apr 2014 15:19:01 -0700
Message-ID: <1398809955-32008-17-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:20:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGNc-00029w-J6
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965299AbaD2WTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:19:32 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:41714 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965278AbaD2WTY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:24 -0400
Received: by mail-ob0-f202.google.com with SMTP id gq1so205135obb.3
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B0hSSHPq9oq11r8GQfWTIEKtD46ekvoade2eUTTK9X0=;
        b=cRJx8vtDj6kF7EnNlGSoQ3K636h9xs7UlBjKI3pScUHDNxneZPdRyM9OUPIjpj0ElS
         rnvH/XduicA8CunnuvpexrzB4/OnjwZFLkYNrbLVt4hO3HvhMOXE5G0HmBZzVOUtp17o
         S6r7me6VbcNNPua6XAtOXu54lMvccw+fNQZQRXi58LyBBufWeyY26qAGlKivR2HS7L0B
         BGUAiHuZ0+DrpoW0euVNGlTJsWiwL9Ft2fhiHUXPtz0Tk4zWpWBsC/1Jh+vBLfhwxFKE
         AeZfUqBSz3Ha2XDUxU7QtxDaXUb40l2h/jKICiKQS6WpUoWREFubbGWQoWQxt70KSLGP
         VztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B0hSSHPq9oq11r8GQfWTIEKtD46ekvoade2eUTTK9X0=;
        b=PjS6ARqVeeidBYqAYybMgdkEv7LjeS+oCJvww/qKhyyXZeQYSzxAoBisTVb3QTHiMg
         gjpo5305/8KSGmR4Eem9VJI+JRL6CMaYcJrLC1NHT6BzVYzVsHbDYmMXHmXegjxcIApN
         +CMOaePBstJ1+ZOj+vLVA2aEK+YIrl/Ee18BiZs3aPuNLmidcAP/YxPmXOjkEgXu0t8Y
         tjUbmq1KCzxnUTLa2bzNQNWYOyoM8GJwF62KeeL9GReeyCXSDMONibqoiBZuuRi2W4rE
         ng93dfg+2TMXUjEhZ15xPLEjgjYZJjdvjqN+O2U/XD+Ly6nwpOFFmKi7Y8Donc5tR0sr
         oikg==
X-Gm-Message-State: ALoCoQk10vD6A/KY1OnXGXWhp48gQKal/PeQmaJr5vPjhk3H5p8KC8YXPXvWdUmxIHA/H95S5G6Sm0oF/PwLtt5sdIlkUm8+DLPygOq3pddFiptEcFr2Kwh6GB2e8HqBlLbQ4b67KpQ2YlYoNFjTNANqCydkK92ryrMBpFu2CRvgz83IydZhvOHl13QrY9E2y9SjuTfroKfo
X-Received: by 10.182.70.106 with SMTP id l10mr304816obu.7.1398809964277;
        Tue, 29 Apr 2014 15:19:24 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si2306131yhj.2.2014.04.29.15.19.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:24 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1C81231C1D2;
	Tue, 29 Apr 2014 15:19:24 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D52CFE0A5B; Tue, 29 Apr 2014 15:19:23 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247634>

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
1.9.1.532.gf8485a6
