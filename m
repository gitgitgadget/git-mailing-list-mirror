From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 18/44] branch.c: use ref transaction for all ref updates
Date: Thu, 15 May 2014 10:29:33 -0700
Message-ID: <1400174999-26786-19-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:32:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzW1-0002bm-WA
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804AbaEORcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:32:13 -0400
Received: from mail-ig0-f201.google.com ([209.85.213.201]:61833 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400AbaEORaI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:08 -0400
Received: by mail-ig0-f201.google.com with SMTP id uq10so99635igb.4
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ajmh3PVUdzfRhQgk6hGW4BjKrFc5hFVYFEhOD20BCG8=;
        b=JTa/9wpO9JTpPMEJ8Yi4P6CQ5k/B4wICzHhxuUmIRlxPevMiQKSmXxrCvAbTUfJr1F
         of4lyU7M0d18E7mMa8YluSYyzbo9d46lquDGxpTTqpowrtYO77JUR970VouelW18A7rq
         V/Oan2TDjMVWOU6ByQqHRV5t2oXi0+8jBtCq7xw6xC+Cq7H4SDYZNakI7UqrEUssuWZZ
         hF8YoBPyjdaxPWOeUmQmpvqyLNt81xpSAPKEKEcTwg3tykVFW+5oTLuRw3JYAtSm0ig5
         OVxGic8cv+Da9V2oPgrT58FJjuRxXVtnOgEPrD9GBaAPTP+FxbBV6+6FObUgf29sMCVs
         Vzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ajmh3PVUdzfRhQgk6hGW4BjKrFc5hFVYFEhOD20BCG8=;
        b=jl0Dk+SclyQk7O1bQBGbgYMt0rP9zb8zs8FQa1EFfXMbRrTqwgVl4Xf/eM4TkzZQbl
         vIQu0LunwY/XGnX8+TBRuw0H5baH1eupXekXafae04Pzrj9kFen6Ug2sg9HH0YR+TeGK
         4O6wMqZQex4jJeYoP+mpFa/nO0qaya3YKEGIFwyKh4FkNdQdN1u7Enx045OxcpnpglAV
         BtbhrJLlMeJuc++lApYDK+LINGA4nlshwjYCb+qgzaU14j26T/E0HMvP4k/3/J+kMEUx
         1jAEbcz2zG/lz6wBKoNs8HlxCJ2Zh9b+VvKso6kJ1ZM61IBp59WTHzwmUQmT02gvLaxo
         Z5qA==
X-Gm-Message-State: ALoCoQnkoq+Bi449bdoOb+yZ2JwI7KTo1zCuay7ffmbNt5WxDzhOMAgtB2RPvztwzR48yr6iHXEQ
X-Received: by 10.42.229.194 with SMTP id jj2mr5027311icb.18.1400175006413;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id h18si274175yhj.0.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 434EB5A427D;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1F671E16A3; Thu, 15 May 2014 10:30:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249157>

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
2.0.0.rc3.477.g0f8edf7
