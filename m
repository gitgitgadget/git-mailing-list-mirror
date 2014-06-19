From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 28/48] fast-import.c: change update_branch to use ref transactions
Date: Thu, 19 Jun 2014 08:53:10 -0700
Message-ID: <1403193210-6028-29-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:55:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxegm-00005d-69
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933475AbaFSPzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:55:41 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:40950 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758054AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-oa0-f73.google.com with SMTP id eb12so693567oac.0
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vww9TuFDnmJxZ0s51tnwwqULSKdM5gFwIQ7LDGxsvS0=;
        b=mpDrJE+11GQYFzCV4ckEtC+Do2c4FlFS2jm03b+VrlcuneNu4ZZ2KnxvToTzhzOcb+
         5Hj0/UBsygLwBMn07ypUylOVVvG2qvUpGNSJWi8WCzVwHDY/9IUHSzMf/+SwoYSEwVGu
         7YPQPH7KldsqyDVwF5MyVOhkbbZqUR1z2w5LVs8r0scRUYWBxcLzhqbXbPhPV+wTvFoh
         B7ql17Ca2d7x8gj6Zm4xgCSIeYbQWui0DqCWsLq9hoLktcOVCstlxg4ELxoMZykOGXS3
         w3nTc1sEV0ZhTxBHNt5IWzvUScZvaJsPV4xSp86WE0E/8D/v0ZXRsMD747/cQAgUagKp
         OTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vww9TuFDnmJxZ0s51tnwwqULSKdM5gFwIQ7LDGxsvS0=;
        b=ZzktASX4lF1sSea8p4tw3wX/z0Nx2m1j2DNFjXAn/yJZboUt0VZYPd5kLWiSdMnh6P
         /o7/yezDg2ps7Ye/0I78G42ArxAjl38fXSr8lYwyGNlpXnl+brpYi6qablS+41nt/Gmt
         nRI7+kBhFG6GfJl9Eg4c3L2nsqtZHlDFrqVeMnnx+izp9YDRi6sGZPm2KyxVu+oUgncG
         bj2BoKouB9n+P55eMPpLB/6WdqORMYOHZNY2Y5oBEqqditogOYT2cICLszw/Yn9cGh/c
         btFaOMVN/mIbQ7Ae/5aGIR/AeXZ0s8MpLW5lVBUcHjRNXkx+Xe4W/Q2SUcAc2ZIQwQRe
         RorA==
X-Gm-Message-State: ALoCoQn91X7qe/gM+2QTXiV0ad11JwI6T6eWwLlvLpAg4CWGg7sL/DIhMTu/jWBgvBPDOwGLoLK5
X-Received: by 10.182.70.74 with SMTP id k10mr2728764obu.34.1403193213800;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si419490yhk.4.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A46655A4435;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 83008E1106; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252144>

Change update_branch() to use ref transactions for updates.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6707a66..cd929dc 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1679,8 +1679,9 @@ found_entry:
 static int update_branch(struct branch *b)
 {
 	static const char *msg = "fast-import";
-	struct ref_lock *lock;
-	unsigned char old_sha1[20];
+	struct ref_transaction *transaction;
+ 	unsigned char old_sha1[20];
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
2.0.0.438.g337c581
