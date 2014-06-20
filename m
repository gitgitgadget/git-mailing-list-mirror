From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 29/48] branch.c: use ref transaction for all ref updates
Date: Fri, 20 Jun 2014 07:43:10 -0700
Message-ID: <1403275409-28173-30-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:45:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy04e-00037i-Ic
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157AbaFTOpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:45:49 -0400
Received: from mail-ig0-f201.google.com ([209.85.213.201]:38221 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299AbaFTOne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:34 -0400
Received: by mail-ig0-f201.google.com with SMTP id h15so38834igd.0
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=87a5BSc4YsheD0dpTv5oFeOIZokGkDdFk+5+n0761EY=;
        b=R3EOT6UkOTr6BwZh8h2iWOm0rr3r+1POF1mGuM1kbKZgHhcAJ8lklRFSF0XF11K9/Q
         zDHxi1Hfj6asXqdbnHg6W9BKnr1peM6YQjEQQV87QCsbhuLGRs68Bx1nZkPyOujNH0i8
         53cO5C6M5Bw4iE4Y7D3+S2/+bBMSHDPQsf+55Qmy8PIhdcKO/aK22FAPSOxqWCahmD9Z
         JcbFJP6MWijJcKCr8CtLOQNCkdlGgxS2xGlyIYqXwixx95EOaOns6B4+YcrLm/3ZH/8k
         eePrgQhiWM4JTyYv4zhXFby97xJa22kjo2DRx6pTJiISm5yWEe0rmexRAa5iWoEfrCRP
         Zm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=87a5BSc4YsheD0dpTv5oFeOIZokGkDdFk+5+n0761EY=;
        b=bTVhntRbMP7LnS8qprO+tZY57R6u043wAscMfAUC6gYmrrOif7/6Two4J55DpGNviM
         K6uWu4xInXY+lKAUK/mBsq3TM5j3IvrJB7UHPAYOqApsGCA1YsZiS/CKc+tbieMgSS1F
         GD2taQhJ7c/SplzGD7q6NnbD9vFgPkQeBhJIPlqjLM0G57xZZxMnv3VOVPoo2SCYUXDu
         SxbCi2Gx6miFZOwEXrsgXUEeH69gHA+kmVPMJ4JAK0i7100kif+V66tOiBASKViDAl+g
         wqoLrQnispLQBNvxQS3/oQc3XFT8VCSE4eOBTLF3SAEI3A1b0MjtHjp1GbXwaiiTLTpS
         CiFw==
X-Gm-Message-State: ALoCoQlvUNPETwjKTp6vbyDcSiAXt1jGDqg6GiqBCoD6i9nG2zWmXhG1YEJ6prMUKXmtCi9TwMVN
X-Received: by 10.42.12.74 with SMTP id x10mr1283590icx.20.1403275413388;
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j43si432423yhh.5.2014.06.20.07.43.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3DEE231C6B1;
	Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1A82CE0ABA; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252248>

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
2.0.0.420.g181e020.dirty
