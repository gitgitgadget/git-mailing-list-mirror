From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 18/44] branch.c: use ref transaction for all ref updates
Date: Thu, 15 May 2014 16:15:15 -0700
Message-ID: <1400195741-22996-19-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:16:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4sa-0003xd-B6
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756146AbaEOXPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:15:52 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:63296 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840AbaEOXPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:45 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so347930pbc.0
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G6dOiErhxbunrYaul5eHGEh1TPFeMY8ufWoCUqWmG0k=;
        b=c/I1FWllEcPj/Jq1I59vU6qeM56ooT7JHz2BuOIWdktBFX2WMACLCtFRMJdWfa7YZh
         J0XZJG170lB+qJCevjDVv43LUHt6zym/uKZH19gq/cP/nYPjHZwVgjFHg/0CYR2u/sEY
         xZTuGyIT/7Wl/z/yllqTwHCj6a1DIQsFOhcAhsVUHw8+Cp69wMMbBGYN0j4BnzGEvAqS
         EtuHm891ll/gEfGau/fNqQ9QOhX6+LK2hFlm9DzAu+jGcTwIXzxZVu36Nyf6xl1f0Yst
         MWWaL4RNW24xFLOJP9OfK45PTDIlYLobLsHbPFoAZobpN0uvet4AV9KZq/Gn/gGsgaOq
         g0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G6dOiErhxbunrYaul5eHGEh1TPFeMY8ufWoCUqWmG0k=;
        b=l3J+WVJmsFfGvmrqnP/ZCxEKGVp87rwHieTZ00mXh6SOFDL2oAnaqTHsdVL5whiNtO
         Pk9jvk6SokqLyi/g+9XkzSJYa2gSnAPQjV2WE8rAu/z/KQwNzjiroEZw8BAvPAsC0D6c
         IZffIjOKVkEEFpewZESb+i5y5OQQmF4qc6S7dcnW/VN0D1NV8oNAzljJ17JbdB+WBUeP
         0Dvzw5mKRi7gBdBbmIUoC+qXut59NiLl+FsTR/YmyiIs1/IzklPt1V6Sbj1oeTqDb6W9
         RPU9P3W3itaD4Sxmc55SxUnBgwgU1QLxOZKY67BpnUbBXLnU8vU3fZ4xKq+ckyHIAsAr
         TOzw==
X-Gm-Message-State: ALoCoQmEkWc3tMcM25iNwM7vItlKXjlypoX75vi1q0pxpT18B9QAl9Vrj2teFbfwvYbNeRIzEDDQ
X-Received: by 10.67.30.197 with SMTP id kg5mr6638054pad.36.1400195745350;
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si318070yhb.6.2014.05.15.16.15.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 2EFAC31C1ED;
	Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0B179E0F39; Thu, 15 May 2014 16:15:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249223>

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
2.0.0.rc3.477.gffe78a2
