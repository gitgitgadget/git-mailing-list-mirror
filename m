From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 29/48] fast-import.c: change update_branch to use ref transactions
Date: Tue, 10 Jun 2014 15:29:17 -0700
Message-ID: <1402439376-25839-30-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:38:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUaS-0006iS-O7
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbaFJWbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:31:35 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:57367 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so206662iec.4
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zv1sPHU/LyDoolCvZ/3J3LIWYVY+LuI0zCxklmeBRN4=;
        b=Z8ffR8QFlSL9uSwRDKqexykifXDwWLvbTni/uAp0Ki+x0oHmjgbya8UicCO6krnU2Q
         1rc1xMfANXXq/5M8AbofEcgloVIHCHFXDki7iTlt2qL5i7k1nyYpvYqH5YQ+9alE3hUL
         3f7/0I1TXqmBe2Rw/kHcDj95by4ubjfGwZ/Km/s1WgtZMzgBSK38QC0EXQ+4zPrpkbQs
         UnWqODhi/OfYLLZ37VGr5R46+vYfrRuy3dKh5pGowmUwaypGFLlzR3TZKb+O1JTiZ/mN
         +fZB6MhWw/kHJhOhk2khIhY1e9o7LRC7uHvWygfDaOD4XZo45mICw96Qo/nRfZti9QHp
         LptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zv1sPHU/LyDoolCvZ/3J3LIWYVY+LuI0zCxklmeBRN4=;
        b=XcnVwOnQvF59++OGcBwCs72q7cfD9MSW0GqUraN/8bNHNH1ec6p4lx3mdcZn8kzA+7
         gHIhwRoXFea5UPZoXAVgbifOTPsXs27rrCLINS8UgQsKts76aDL/hH7DSIrf34MeeNEl
         0HZwCrp/Wl83jkPxw7IV1ztBmilEHOy62EmcVvEuLRLgMWFl9qxb/NeI436LMVtssxhe
         pcfeKxC9DEwNzU4kRIvGX+W6MO2lCjd28Rw7kMrcTNEwkNnz+1Q6T/zlWSIO02WCbArU
         5xgQ22+P9mrxdnlsmWPQudDtbPw7VrkzAZWv5o6YEApD9ZMJo2DfVhoRxbBChsU0tjmr
         fbHw==
X-Gm-Message-State: ALoCoQlvWiIanUDV8iF3g7NHT/3Hyx5FVxjZLpDKHaqbp/SzS8yb34uGYAf6FwUA0YCyiYonHzLI
X-Received: by 10.50.32.4 with SMTP id e4mr548528igi.7.1402439381443;
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c22si1396564yhe.1.2014.06.10.15.29.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 453EB5A46F1;
	Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2051FE06A0; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251289>

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
2.0.0.574.g30c2c5e
