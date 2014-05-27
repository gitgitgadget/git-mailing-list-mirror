From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 22/41] branch.c: use ref transaction for all ref updates
Date: Tue, 27 May 2014 13:25:41 -0700
Message-ID: <1401222360-21175-23-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:28:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNyn-00054r-FP
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541AbaE0U1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:27:31 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:34406 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-yh0-f73.google.com with SMTP id f73so1646763yha.4
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u1rnnQUJf/cACUeHubTmwMxTJhIUyKQ2f4ExYwenGuw=;
        b=ANH8ojRBhauezXNpQbsuDPKW2pZvzrHIlAQqHOFTrhjLpMU4IDxS8XOOA94g+Zx2lM
         //ogdursOJkou03HonD1Zx65q9/C7Db6w6CFWZYbVzeucWb4fCjAUFEhOrNJHT5uObRU
         d/qwWaKg+Yey/LeqkaOFqMxk6s4Fx/+rTdxbpoprE1IpVHTOY0jvLM2Az4FiYCUgxw0r
         ygPZ3jnoTnoPkh4ndrxXSYeepBspwoBejoqGZjSkEd4VTIAzBvLQe1YT3fjSp0BBcGWp
         tMxrgaUeUnMYohqgRkvZ2EvREnG+vgPryEYivkPhGxPbe8FctRHy409PCdq+2nayrK86
         YDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u1rnnQUJf/cACUeHubTmwMxTJhIUyKQ2f4ExYwenGuw=;
        b=ga2GRduUWVeIgejlkCFbAWh+k4HznvBbYO7WqN+24LL0//fn5vWzj/bJfEUOsHnlIw
         Yx59iIJUf2ZCaiiQW/zRRYqj8PZU8scpiJ53G8oAbH210SXUri5G80yMmizJzy+59Qtp
         QFYMNT+JijvNyMLjqni+A8o+nTatuSQw+PjMAyyJY6WUv1xnihcl6/HA59cmYI3zI0Pe
         JNJXLUssDRHTyMT2TpsoTqo7sFmQ46eCfl21uNEZTzhCO+NTcto6iZFBUZn6hrk0713Y
         BKtXQTCcRhLl7vmwUt3oX3g+AivZOl32QSa0JHip0P7mOMsRdIP2jWCrw9Hwgms6q0CS
         mcxA==
X-Gm-Message-State: ALoCoQlP6q3gY77BMtpnZkIeVpEpmeEVbVMYt6EQ16u3H+/SYNvVFK5IskDqAOPbExMt6LEZbijg
X-Received: by 10.52.170.145 with SMTP id am17mr12465548vdc.2.1401222364781;
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id i65si1283652yhg.2.2014.05.27.13.26.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9E26937053C;
	Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7C4BFE0BB8; Tue, 27 May 2014 13:26:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250232>

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
2.0.0.rc3.474.g0203784
