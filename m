From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 16/42] branch.c: use ref transaction for all ref updates
Date: Wed, 14 May 2014 14:16:50 -0700
Message-ID: <1400102236-30082-17-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:17:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgYW-0002V2-Ev
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbaENVR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:17:29 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:47899 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbaENVR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:26 -0400
Received: by mail-qc0-f201.google.com with SMTP id l6so34056qcy.2
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kGMRox28ZzTzds9F1rqQ4Sn/5NTBXhSj88RT/mC9zxk=;
        b=mCB0O0gZoxqgMu7ECkrpPKcegAy+GIxT5yvdI8WOzf0ThRJE6u1Hpta2Fih3pis3Lz
         uJgLCHtjtxKD2RI2fjNb16yK+uGdozLvkF2QCpIu8FEXzblC4vWXd4rUOzKGkTRrTk2B
         HLaJvqy6ki2IjyLYl9bKBdyzxBGqbAjIZDsj6QjTtvtqATvtgWUPL7ky5AkBzV55CnJU
         noR2WYoTzjX4iXrCwM07k533Ekuu5qBDgHVfB8ihqrUi5dZ14loleipPgEZnhHuefock
         LumxPiWtRe2ThFTqrrO4sRZCLzliY7tGY/56rwPLwMB3v4fPF8z35bO/Lpue1ABPeIyT
         i7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kGMRox28ZzTzds9F1rqQ4Sn/5NTBXhSj88RT/mC9zxk=;
        b=YJNAD43xr0nWhsSE+JRvXQxzKzeaozJBNTdeClDhUfDWY2PVxLBi9DuniUU42wedCD
         XLNUCvzbl1o+NMiobdIMPu6KaXIcESt8okOraU6hgTfJJ4pa4qSz7TDXE30H30qQGJAo
         81boprpMzu7n+T4wSxPQdY7EdsWThonGd1s4SjvJuddQ/ez73bKV3h7iGPQDn56PskIV
         dWQMWaxSFQFPkfJBlYPWgnrqT+sR+jjFtC4/ry0XKhl47X/b/2CryuuEw7SrgIvypqEr
         NHEy6BriPRZoEXBbj5iDodUqT8JJmAO/xSCRjqKEBkh3P8tR39btz19k5F8w67n628NX
         rgoQ==
X-Gm-Message-State: ALoCoQlbsmuFGmmJbFjZ+WcZwPDS+ElX+RunU5+cZV9uvcMZzVQBgs6531jvgK7Ec2JjIYy7OITh
X-Received: by 10.58.141.200 with SMTP id rq8mr2914903veb.31.1400102245399;
        Wed, 14 May 2014 14:17:25 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id k43si145558yhq.3.2014.05.14.14.17.25
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:25 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 41FA231C1F8;
	Wed, 14 May 2014 14:17:25 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 05C25E0973; Wed, 14 May 2014 14:17:24 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248959>

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
2.0.0.rc3.471.g2055d11.dirty
