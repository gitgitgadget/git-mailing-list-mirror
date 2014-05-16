From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 17/44] fast-import.c: change update_branch to use ref transactions
Date: Fri, 16 May 2014 10:37:05 -0700
Message-ID: <1400261852-31303-18-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:38:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM56-0006xE-Fe
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758111AbaEPRhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:37:50 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:44632 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757710AbaEPRhi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:38 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so521088pab.5
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5eiWiaNUaGFcaiqI/8J88aV5LfikDDWvfO8mkGG6OIo=;
        b=A/PIKuLV+JhAU6+bcZ1qFdnG9Yxma5ToPjt3c5AO6JHCbPgHWM8EKt7oVU65LKDjxV
         kvL2KrQ98Y2liaOehmm+RsqKnz5eS1A83vXwdzKOMV4IwHpG1M1V8trex+4kwTec30p1
         xVYSUvBxWvDRrrNBIPuiz+TrcwEMh7vbnW9WgynYWA4Ktq7cOG6B4tCGpNLPuRbDo2d2
         RYHaS2PvhUrHIRzgxSYzVy4iTlQA2dXwNQqcMnKQO3lEL1xBMPXPD8AJpkWzxjGJewRq
         ZF0YnseWyb0T/qUMl5I4A1wPWVsFKutSIvhvgS/MetCs8mIz92vDn4qOV96ujbF1pQrx
         CVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5eiWiaNUaGFcaiqI/8J88aV5LfikDDWvfO8mkGG6OIo=;
        b=GlHqt/UqPUtVCjWynE9xd3MX7PVFND/kIBB5Th9Vd9+1Fr2nhn+LkO6lDb+O6AsBpB
         EDMPvCU7GZrarQplvSGhu172+YFw+AJ65duh2xQG2SyQ0gHjXDlzlTPMeOiWoqjb4BaU
         pPfiTjDVU4goqtjhaUgyR3xVwJNIPhHCheqLGyYl86ZZWn2D+yh8U/pZf2hS1DTQRP8n
         8KNHCx3YvjloD4hU9DVxzVABtO7uEiOxvH3bcNOcA2aT/ezP32Ml3hvAi4hT9fc9m0MT
         v1Os0PJt1Sz+6FJYBT5B5xL5pMgrOCPNVH7TRv/kfn9DZouMCMJwNivy+kB2bqg417lx
         90zw==
X-Gm-Message-State: ALoCoQkkqQK1QmSEsIMKwk7GhJDTYSftvij/hA6qxemhAKOX/+i2GyqEyji2aadFEwjEXCFdRm/f
X-Received: by 10.68.202.99 with SMTP id kh3mr8779258pbc.8.1400261857378;
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si441217yhl.7.2014.05.16.10.37.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 356CF5A427A;
	Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 13795E0A04; Fri, 16 May 2014 10:37:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249361>

Change update_branch() to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6707a66..60d4538 100644
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
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
 	return 0;
 }
 
-- 
2.0.0.rc3.510.g20c254b
