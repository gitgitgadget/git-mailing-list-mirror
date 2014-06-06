From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 22/40] branch.c: use ref transaction for all ref updates
Date: Fri,  6 Jun 2014 15:29:00 -0700
Message-ID: <1402093758-3162-23-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:30:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2ew-0002x2-Ds
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbaFFWas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:30:48 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:35794 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbaFFW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:23 -0400
Received: by mail-ie0-f202.google.com with SMTP id rd18so740489iec.5
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JIuZ81wXxCPCr6Lv7ByLDuehV9xDAyMrpQuWdD5Ajyc=;
        b=IiT6YeKPR8GuJiB3Ymy8i5UhokSsCuqidFk+OdsdZEj2go1++y1LA66beL4wTRm/is
         ot+LZzQYztoLq9pIjUmJcM67H0lmessEqLjpRPrPNAo7vPQBptK9G4FBBxkK7aBEFehU
         2Io+DUcfpD5FlPBQk8U+bjLO4upPsp+PwjYNZtxFSTTZVaPCmf1B0UbZYOMFBlEu7y+g
         SeW08zEkUBP4nXXMslKst6dxRWox03+rcONVEwDfNQPDxFA9G8cyPEnZ4LcnUHbmji6v
         4sZ0dsX5y/9wR7Rb2EHKsZ5r+9oO1IA+2iQuUU7Uk5c/tgbp/JCcO+sdpc7C5DHU6IRu
         RdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JIuZ81wXxCPCr6Lv7ByLDuehV9xDAyMrpQuWdD5Ajyc=;
        b=WCB9enQt53907j/cXXG5ffW57TJzzErCTEoN96YBu4bn6u3r0IuiBEeMsIjSzIOmsR
         saqs9fyMfACPWcIibNIMS4YCpSw4AD+szeJjboaIltHe5cSOHsJv8HcmKkzCx9uTU1uD
         hSI4Q3E6MqR1Ism99m0EryZZtDZAoyqZz/Je1ASwvdgHK9UHeNvkx6TjAo6EKbD0gtSj
         SF94xgxi9RzVRCSvzrQgJV0MsRlxnqmVANecIK92o+dqibR86NcdUY7/u+ox9IrPEjwN
         64DGFCqYH04jSUz45N6wLJhtC/3fRqU0Ebx/CxE50TMuafDs4EFlZLriKcwWiuAu6tRT
         3upQ==
X-Gm-Message-State: ALoCoQli5y+r0Y5SGWWWWzirzwOgb/ekuI+15X4FeBVZizP1noUZpwM0S+CTz6CGs+2rrQqNMBu+
X-Received: by 10.182.120.129 with SMTP id lc1mr4365457obb.21.1402093762675;
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id pr8si750957vdb.1.2014.06.06.15.29.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6C05E31C62B;
	Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 483CFE09AC; Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250997>

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
2.0.0.582.ge25c160
