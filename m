From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 29/48] fast-import.c: change update_branch to use ref transactions
Date: Thu, 12 Jun 2014 10:21:20 -0700
Message-ID: <1402593699-13983-30-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:23:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8ib-00087X-Ti
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933626AbaFLRXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:23:09 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:61621 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756270AbaFLRVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:45 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so308675iec.2
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JdeAxLzrIVRFFUwME4lUZ2GuHqhMKpkSI+rhvWT/K4o=;
        b=P43nX2OuxIYakNdfOW2fsgpToldy8zsL3ciWaAly4Oud8jprSqekGzIdYqAaujZTbk
         NtU1rGtw2yjuBmETlcVLwdyaSFsXbB2mESEg0jwG2W5mxYcE7iQK4xohqG0p53efVmb/
         eAbxDaz8rjsLKghCwTc/aAQQHdBTQXGFAq6yQvBYUYNA6Am3pWVbNN4UMQUG1BzhUxN0
         c9W5nLvo8IBuDf1LRH3sbesJ8Px8WNk1DnmpbolEvjeVaF0sjeisuOXo0Zy9HuXbjJIA
         XGARx4N+bH5N0JY3OfS+43h4XpbYMtb+0yNSPHDx+tw3NQ1T1I4yUV5MexHJpE1jB7/P
         grhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JdeAxLzrIVRFFUwME4lUZ2GuHqhMKpkSI+rhvWT/K4o=;
        b=GJvcUqJnQynsl4drgCzA5VjARmhZtyV7O5s4ujRBViJFsNMK4MX8ABHHqQ5RAi8JIm
         6lslRNKyV+OluOGTMFzWDXOepIRM9cePlBIJ1nuzrtER2/K6DEZ34HBTiT7E/djylp/i
         ONkYmRT+BNL/CFZAzZ/LwLzZCODK8/I5oK54EMjj12JrVxmDwYpJQxNr+O7DxVOw4PlR
         kNFUrUZqCqgrfWoxixaQom8QWdZYEP6UiK3JXph5FE9W3EXutagMtR/+myyhz9TZagoU
         KdcWY1S12lJdNKCwGH+j71VzFlgUfGta006yGMutXYhvgCJZoa44BQpbqxJBH3VuTM9s
         ykng==
X-Gm-Message-State: ALoCoQkuu/n2Ok70NLhBsjjIlTiCCG4fTs/bc42KjQp1oakB0OZuweTu4dogy14v5xHd03lgzlaS
X-Received: by 10.182.109.231 with SMTP id hv7mr14564obb.2.1402593704467;
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si112566yhk.4.2014.06.12.10.21.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 4D35231C66C;
	Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0DF0AE064C; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251443>

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
2.0.0.599.g83ced0e
