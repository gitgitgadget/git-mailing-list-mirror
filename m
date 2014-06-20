From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 28/48] fast-import.c: change update_branch to use ref transactions
Date: Fri, 20 Jun 2014 07:43:09 -0700
Message-ID: <1403275409-28173-29-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:47:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy05n-0004LJ-Q3
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194AbaFTOqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:46:16 -0400
Received: from mail-yk0-f201.google.com ([209.85.160.201]:44937 "EHLO
	mail-yk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239AbaFTOne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:34 -0400
Received: by mail-yk0-f201.google.com with SMTP id 9so168193ykp.4
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pZVO6YS/pUuZwWgHyphR2E6EH+P7p+d9R0apCRuB8U4=;
        b=AztzR4jBcN3e0/vNv828rwCo43AKsJGSNjNMC+dtE3TYmxwI1RRUh4Y92TOk5/xiq5
         1JS7sz4BYazfeLLkN/7vzANxTonYZR9AZGWgBSDQ7x1/ka2nP1sAWdLGvVFMKL5vb1xZ
         gADMJ3fzWdVzbmSVKEK1+nzwUaxvnpa41Xba1NaFyYwz5NNDR/Cj24hg9qih3jy4YuoX
         rGWdn9s1VoWS/6Fb8IUtpI9xgj5fz6MGDYow8zJZ6eFpZQ8/ErmkA18bus+yxGGwSGh1
         eaUoWkDXu7RZvSR5f9Vwx7MjGn4nXddcmBds0x1A9KgqfJB7T748nuCET+d6/iG5eZ04
         xhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pZVO6YS/pUuZwWgHyphR2E6EH+P7p+d9R0apCRuB8U4=;
        b=O+G15BGcLzVdM+sM67bfZt3AERQto3OPmWTRa9vQ9vSkehKnCgSwHPjXa8Ynw/eabC
         XCsTN7xjri46vVINlQmnrXlSjT5w8EvROxOXMO9RTkS8iYRrvn5OtO06nlbEDznpQAPE
         kCsF+VpFr5rs4sG88zTO00fRVDoEN5Ei6ut6AnvTTWvDMIBFZv7q+49I+bJSdkoqQKla
         UMZDWQPmNgg1t6FtkT1dFKuHo495nlzTB84rstfOeKlGDeXqq8Th12zIhPabFQd2sPAU
         VTVG6VXYjsCb/FcxDRdQlEffqULIO6OZne2Nfq2HKv9JY9xqjoGGF0qTA6qlJPB95alU
         tL2Q==
X-Gm-Message-State: ALoCoQl9t+gxdM/vl3BsXMkleq/Gu9+3Oiww6IN9ahn4EOJlpNnRff8ZJUmJAtbmO3CM+a5WFGIH
X-Received: by 10.58.94.197 with SMTP id de5mr1526927veb.19.1403275413078;
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si664705yhb.3.2014.06.20.07.43.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id E93BF5A43E3;
	Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C9D53E0A04; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252271>

Change update_branch() to use ref transactions for updates.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6707a66..d5206ee 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1679,8 +1679,9 @@ found_entry:
 static int update_branch(struct branch *b)
 {
 	static const char *msg = "fast-import";
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
 	unsigned char old_sha1[20];
+	struct strbuf err = STRBUF_INIT;
 
 	if (read_ref(b->name, old_sha1))
 		hashclr(old_sha1);
@@ -1689,29 +1690,32 @@ static int update_branch(struct branch *b)
 			delete_ref(b->name, old_sha1, 0);
 		return 0;
 	}
-	lock = lock_any_ref_for_update(b->name, old_sha1, 0, NULL);
-	if (!lock)
-		return error("Unable to lock %s", b->name);
 	if (!force_update && !is_null_sha1(old_sha1)) {
 		struct commit *old_cmit, *new_cmit;
 
 		old_cmit = lookup_commit_reference_gently(old_sha1, 0);
 		new_cmit = lookup_commit_reference_gently(b->sha1, 0);
-		if (!old_cmit || !new_cmit) {
-			unlock_ref(lock);
+		if (!old_cmit || !new_cmit)
 			return error("Branch %s is missing commits.", b->name);
-		}
 
 		if (!in_merge_bases(old_cmit, new_cmit)) {
-			unlock_ref(lock);
 			warning("Not updating %s"
 				" (new tip %s does not contain %s)",
 				b->name, sha1_to_hex(b->sha1), sha1_to_hex(old_sha1));
 			return -1;
 		}
 	}
-	if (write_ref_sha1(lock, b->sha1, msg) < 0)
-		return error("Unable to update %s", b->name);
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
+				   0, 1, &err) ||
+	    ref_transaction_commit(transaction, msg, &err)) {
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.0.0.420.g181e020.dirty
