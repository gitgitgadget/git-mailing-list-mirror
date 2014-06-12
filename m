From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 30/48] branch.c: use ref transaction for all ref updates
Date: Thu, 12 Jun 2014 10:21:21 -0700
Message-ID: <1402593699-13983-31-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:23:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8iL-0007rj-Nx
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933535AbaFLRW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:22:59 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:61758 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756275AbaFLRVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:45 -0400
Received: by mail-ve0-f202.google.com with SMTP id oz11so244614veb.5
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cVshRznCgVXHUlnraXOO0ZZ5l00Bd5f7S8X+b3lp8FQ=;
        b=Mhh1hWYg4pBc0dc7z0quS8zLw1q3Zt4nJ723XviNdaWoDelVDaAb0BraAK+LQsipdn
         FiLy9sRZXyNI7HdeKnGdy7GFvA0rwPLTazItgY9OBIKaHjUPBQYZLzTIQaMWE4rShr65
         CrhxXwLTALzfpbVkxOlq8zIYb9ktAI+n9Ntil1Acd7AhWLNY34d6MqAwq3156Hn91hVr
         9xPQTiuT2/f/iMXEyFG9T9sL9g60zzO2h/GaQHsNKubR3RJNvvZ7/NUCo97VA85j3ro5
         jUHhkBJdGdHESprlYnfZ2oM6BDe+VoA8hVl9L/75IB7627pHLYp0r//6+3TlEbNJ+wZt
         cKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cVshRznCgVXHUlnraXOO0ZZ5l00Bd5f7S8X+b3lp8FQ=;
        b=G/ePb8752CvVnbEtZlcXaKmkK005Yd1KjNnrWMKS0kPncHbL572kFeK4duzhR6O2up
         EL+2IzELL/rUgFMcqoB1TA3Tvf4wmrlqBvNLuj01CsZr8TkHhzIYpGN6/142JszOaWgL
         m8PHZZ0RTsMN7lu3CAyiO2An7Cxa6fg0Ye4aUW46s3NHZq1hTxXV/sm5WN3phcYG8rWc
         aztx9JswQ77WdJxq8Fro0U9NkQJQ+V+mTuTi6ye7ba/rSC4RD3hHpbE+lNV+jB4PcQy2
         nRjJuiSudKAthvFYdDYKcpMRJYn//pV00RJEH5MNg9VO9i7tkJtS4DYm1la0Q5+7z7Wy
         VoEA==
X-Gm-Message-State: ALoCoQmNTRE8hreciPTqq7yxAEOQrfl9bUvpcNPkXBbo0O+B5JwWU+LPba3oM/MGIwuaqWSJ5LWf
X-Received: by 10.236.141.11 with SMTP id f11mr4047892yhj.54.1402593704472;
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c22si113423yhe.1.2014.06.12.10.21.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 55CBD5A4743;
	Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 19194E0A7E; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251438>

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
2.0.0.599.g83ced0e
