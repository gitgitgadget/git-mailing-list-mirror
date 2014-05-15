From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 17/44] fast-import.c: change update_branch to use ref transactions
Date: Thu, 15 May 2014 16:15:14 -0700
Message-ID: <1400195741-22996-18-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:16:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4sm-0004YP-Ho
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756200AbaEOXP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:15:59 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:64308 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755859AbaEOXPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:46 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so720490vcb.2
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=36krf0nMlulshVIhp2SYleR+Yps9qm4dRGb/CzKE1dE=;
        b=BQ2VGdnHelHG7eDCoZB3mGWIIGYk7soKhys60PoReXyhO362gFjNFHFjP3pqG1Jy2g
         ftT2ZO3lDWkdcW5sk2OjKbN06dO6OHHoytNfdr9KwCcxvperNo9n8IJh38hcJpHBtUsO
         x2tSo+/5bPCEGRDioPL2GcEnVMQc3ByRTKqpg+oVffaFuQ1U6+gOgRu8etnHjJnThZJE
         uxsdLlNjvcsMkquwYGl9ct8QG5S4Y0jPyh5yifD7/ytoG9rws1iyDVFvhVTiywHu/wVN
         E/9r5JNH+4OGorO5xSvfvuoqPm9MLfsP/MLlcbo6+SxUoh69Q/A0majFyaioTfAxcY9J
         CvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=36krf0nMlulshVIhp2SYleR+Yps9qm4dRGb/CzKE1dE=;
        b=dD2GhnjdD2YJdYz+CFwucvnnff8PW6R6ZrcUEIbm09WrgFNwz/VFP6U1KyzcedHJYw
         C7a3A9t8QL1bq3x6rNy/PDc1pdDXkLwNS3oI1SQt/9NxJIxvfGy4N02XPOyHB10DaQU5
         PCrxpwKBvzVksWqUZKwmqRKLPRGyZHqFXicWqF70vqyeU78g5XcdTK86oSlOCWFAkGOJ
         MLF2c0Qn7qIzm153rbiaUOvqgnmcCR5enJEj4Ah/+7jwqxhavU5JLUe6Kf9420+QmNcn
         bKoV6rOVtE55fHm3lbkN068qaact21kwPGvCAnxUB8q5qtzKvRqTLEx9gxUctz1qF2Mh
         uvTw==
X-Gm-Message-State: ALoCoQlrWWi1lJYf11p1pyytVIhAz++x3KlTf+hNE+wj3ZBMe0YUv+2wi9/aLoIMwytZ1Pg8/Epc
X-Received: by 10.52.170.145 with SMTP id am17mr5664727vdc.2.1400195745229;
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si318068yhb.6.2014.05.15.16.15.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 161A131C259;
	Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E6665E0B9F; Thu, 15 May 2014 16:15:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249225>

Change update_branch() to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6707a66..bac799c 100644
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
+	transaction = ref_transaction_begin();
+	if (!transaction ||
+	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
+				   0, 1, &err) ||
+	    (ref_transaction_commit(transaction, msg, &err) &&
+	     !(transaction = NULL))) {
+		ref_transaction_rollback(transaction);
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
 	return 0;
 }
 
-- 
2.0.0.rc3.477.gffe78a2
