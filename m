From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 30/48] branch.c: use ref transaction for all ref updates
Date: Tue, 17 Jun 2014 08:53:44 -0700
Message-ID: <1403020442-31049-31-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:55:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvj3-0004aq-Rt
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933459AbaFQPy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:54:59 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:60904 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756333AbaFQPyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:07 -0400
Received: by mail-ie0-f202.google.com with SMTP id tr6so1515898ieb.3
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+FzQCtai24celhtHY+nC/a9ap5MHtLtPDOurXYzQTz0=;
        b=PoipwzUjN3ynV/DiGDEhJgpYmebIUeKH+MBzqT4DDIkmEPvRwl0zHtORQwHbA84zTs
         vIfY8w6DHYUQWU3vPL6e+odfxUuGXD2qzdUWcCIR6CQ/0RUi12Zlx/ESxilgOs4UvuBL
         mgvtQNMsVFoMa+TkdTBwIf+GN++WyhCNgKs5oPtQg7NpOsaEqzR8byGPrOn3YBftQ0WK
         bj9y+lx9reaL1l491QVlY5A6Owa1Ulb1Gf7fjyYcmPduYaYOriLDYC/DO9qpyf0ncEli
         1G2fMrN01PmGDBfGsUkhr9QR/AxBDBxlSXgsKSvKfYrVwyxMRHNdIDXCxRjQA9mypKmr
         uPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+FzQCtai24celhtHY+nC/a9ap5MHtLtPDOurXYzQTz0=;
        b=gKpcyWY8xrZ1ixD548zqw+HjIuPJAilPgodhry4DHNRYKqBYh7qaOEYu0vdq0vsuIH
         6NGs1gtSuvwaFlRFBEGy2adQHgKKxTn7tSbCpW/kR0WmLRYS8jntWFq31DWoAwZdkRvK
         d/xj1tOReaZJJGrsWrByau3Ey/8nDS4rDITpyRE0mQv0fIMzna1LaJ52kXfked0P2fk7
         SRFHsVIAXlOatmpUD8mIedok799PcLHWwvgUHInC5uHxSKHS70ayCxKgIztL1XgJzPpo
         6H10rqqkDFZHuD1V+iTL4U3viNNlBQ4WJYugeITcRyajnTxL65gP5HadiEiaGmwHw1V8
         iigA==
X-Gm-Message-State: ALoCoQmyHWauwi1O2s3gfha+sNeqKNfcU84JkriQZXrtbORF9TTUs9woSnPTnb5tAsDLXbZPcfNO
X-Received: by 10.182.47.199 with SMTP id f7mr507977obn.6.1403020445433;
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si1208004yhp.6.2014.06.17.08.54.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 4B1AA5A45BD;
	Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 27543E1158; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251888>

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
2.0.0.438.gec92e5c
