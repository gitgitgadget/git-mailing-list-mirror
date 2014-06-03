From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 21/41] fast-import.c: change update_branch to use ref transactions
Date: Tue,  3 Jun 2014 14:37:39 -0700
Message-ID: <1401831479-3388-22-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:38:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwPX-0005Tb-CZ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934337AbaFCViT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:38:19 -0400
Received: from mail-ig0-f201.google.com ([209.85.213.201]:52409 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934229AbaFCViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:09 -0400
Received: by mail-ig0-f201.google.com with SMTP id uq10so28805igb.4
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jXaCLIdAzATFvN7a4uJLguKbAIrAd8xAwmOXwcrkzlg=;
        b=FAhetbKCoX4TwtndC0YwFH8fTo/OIKcrP57aXxvh/irMn2KdfLXApvw27g+I4NRqtf
         kJvC/0ep5HaKpRLxNqkc1lz94Bdlp3VFlyCM8bfiagEQ8CQ2quNNoUhyU9cYzkygqALF
         euq+RarNwadStKQeuHy839GEcpjH6OoKVdNpYNaa0TNzEI+Wk/3M9xGMYNTDqzCSbj8U
         MdW4++twJNtgBj43s016M3PnJljDx2LpmlO1dADOmtU5cQPe7pBUfPGa3pEROzct/xsC
         dg9p/k9zF9U6NL65Vsk6opcBcMj5jSDaE9qTtOPypcd+DRlZTNyYTKRA2ESuMtc7/F8C
         XCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jXaCLIdAzATFvN7a4uJLguKbAIrAd8xAwmOXwcrkzlg=;
        b=ijg/3+tVNk7aBF0IqeRR+gNpXRmFDRceJ+lAKp5Gq5WKJEM2MSrKfvLkMHzXWd5Vlt
         00xKLKEhhT/r0ES5+wRZeOlrkxXV7g9X2qkFzlTFQMhoxlA+3HtdpqaWseCcS6ViUNjH
         F2xsQwE3gT1ukb2BoBdB2hAvkbhO3WQ0ziWKKMlu+S28H7da/MmIbEq51tB20cgsuDmC
         rqRXlS/4dbiWNx54iLgYe7m1DUqK8aflNryBWJR69dMyJ/b3Vd1jQE7d7y+cl2FrtuyP
         Q/hZADCONFLHPYihp1c8CZ2Otu8CsiPBpQp3N60NSxvbj+/JqgypCGikKPXTEtNlN/QO
         KMfw==
X-Gm-Message-State: ALoCoQksysMyTLzCh3dHNu9SY/tcE/OOZ6esOV/g1FzzSY12JLohmgWD6xebZM/EZJaUt1U0XEQT
X-Received: by 10.182.128.166 with SMTP id np6mr19515684obb.16.1401831487740;
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si8968yhm.0.2014.06.03.14.38.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 91E5431C4B6;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6DCB0E0AA8; Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250651>

Change update_branch() to use ref transactions for updates.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6707a66..4a7b196 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1679,39 +1679,44 @@ found_entry:
 static int update_branch(struct branch *b)
 {
 	static const char *msg = "fast-import";
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
 	unsigned char old_sha1[20];
+	struct strbuf err = STRBUF_INIT;
 
 	if (read_ref(b->name, old_sha1))
 		hashclr(old_sha1);
+
 	if (is_null_sha1(b->sha1)) {
 		if (b->delete)
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
2.0.0.567.g64a7adf
