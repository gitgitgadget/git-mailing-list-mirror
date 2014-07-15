From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 13/20] fast-import.c: use a ref transaction when dumping tags
Date: Tue, 15 Jul 2014 16:34:11 -0700
Message-ID: <1405467258-24102-14-git-send-email-sahlberg@google.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:35:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CFn-0003aH-I1
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbaGOXfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:35:09 -0400
Received: from mail-yk0-f202.google.com ([209.85.160.202]:65378 "EHLO
	mail-yk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934316AbaGOXeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:34:25 -0400
Received: by mail-yk0-f202.google.com with SMTP id q9so6959ykb.3
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UAEANy9joWonRhUxbrUsR3UuSzwkYRFcoI+ifaoSQlU=;
        b=DXGn4Rizk+StAqSAeILJa6EU9eAjsMso1ziD194RDJskppu88ZGVGiNI6I4NgRCY3W
         JD0PShNNsi17dnIxjJ/JwM6sPzEnxsJoukVuw6HwmfbFJUmldF03zvMzwtbPSUK2fivS
         peA29bkow4MOlcRSiBvq6f4l719musYTokxwvNmtMuBeFRneygBnh6Bzw2GzyVylLNaf
         LhswMRvoPYro+Z384kwxtk0u415Gw0VyGgQk1zAMkfB5/yzZ91NXypaQPlcZAyyWJPuy
         RIYk3KpDPyY/nHI/TxlgHk8HT0nuCJKLrT0ROeJTPwJRtJsGhHwdKY2XqAEDdMtYx72E
         AeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UAEANy9joWonRhUxbrUsR3UuSzwkYRFcoI+ifaoSQlU=;
        b=Z6t/Jh6AINqq3raGYeH0P0pWaj6vvS4j1r4++nPI9PZJOvxhBfJ286JqNggxUDGcOv
         r9PtMHUScZA+LS8M4AD54mGE29+f72KCxqHFi6vLt2zz+Rab7NKqxUaKSsQt2J+GWG4d
         419UlnVjw9Cv++Hl8YetowbNBz7BP+Y0VY5MaIeP4PObY+HSmzL/3+e0z/WWf1uYrJWW
         HcMgcAVL6FkZjZxUPHUKwD6BDzh9KOTXuW+f8zJBa4RzvDHBMo046VEbGJI5SEMJtkd3
         7NOA7BzFCLjlWM7psfCBuKLu6V2czFogiITU+s4WA2U4MAYtyS3jmd+WFq1vNd8Ad/ap
         5W4A==
X-Gm-Message-State: ALoCoQnX8sgKgl5jYL6e++u/jMfZShinB/myVD3dU5YWxxpDFpV0dxsDRdJs4L3DYSOEwObOqt3X
X-Received: by 10.236.92.69 with SMTP id i45mr11290543yhf.20.1405467264520;
        Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si1060123yhk.4.2014.07.15.16.34.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 61B0831C2EA;
	Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 20A8AE0A98; Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.481.gb244468
In-Reply-To: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253637>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index d5206ee..a95e1be 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1734,15 +1734,32 @@ static void dump_tags(void)
 {
 	static const char *msg = "fast-import";
 	struct tag *t;
-	struct ref_lock *lock;
-	char ref_name[PATH_MAX];
+	struct strbuf ref_name = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction;
 
+	transaction = ref_transaction_begin(&err);
+	if (!transaction) {
+		failure |= error("%s", err.buf);
+		goto cleanup;
+	}
 	for (t = first_tag; t; t = t->next_tag) {
-		sprintf(ref_name, "tags/%s", t->name);
-		lock = lock_ref_sha1(ref_name, NULL);
-		if (!lock || write_ref_sha1(lock, t->sha1, msg) < 0)
-			failure |= error("Unable to update %s", ref_name);
+		strbuf_reset(&ref_name);
+		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
+
+		if (ref_transaction_update(transaction, ref_name.buf, t->sha1,
+					   NULL, 0, 0, &err)) {
+			failure |= error("%s", err.buf);
+			goto cleanup;
+		}
 	}
+	if (ref_transaction_commit(transaction, msg, &err))
+		failure |= error("%s", err.buf);
+
+ cleanup:
+	ref_transaction_free(transaction);
+	strbuf_release(&ref_name);
+	strbuf_release(&err);
 }
 
 static void dump_marks_helper(FILE *f,
-- 
2.0.1.442.g7fe6834.dirty
