From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 10/13] fast-import.c: change update_branch to use ref transactions
Date: Mon, 21 Apr 2014 15:53:28 -0700
Message-ID: <1398120811-20284-11-git-send-email-sahlberg@google.com>
References: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 00:54:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcN6l-0008Rj-So
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 00:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755094AbaDUWyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 18:54:37 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:56233 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823AbaDUWxp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 18:53:45 -0400
Received: by mail-yh0-f74.google.com with SMTP id f10so824161yha.5
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 15:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t7ih7/mYmiYyr4ILcen7invhIHJ7AYtkdt1FG+bwqf8=;
        b=oZeSevtz9M8yXWHWlsMcWPcYEu87AAX8EqUPnCOK/7CjDx8EssBRg8RFAPrOV9IMHp
         xYq9pDqjr9yIgt0aqHMdgemXxJPAEotoneqUg/Bv5BL8K7mOw5cUHq9vUf4S2WbFFtC7
         ODPx503kWcLYtTpBye4P9vIyOUvoa0zmvwDSEAFTxYLzCGCf8cnRXmvD7rt+IhHzumKk
         zwrzFuFLtcECgTB3N0ZyuOY4zOPG85tWmfXG+oitWKgu2gGqMPhJzFFIjs1C5aHaOUkH
         NUzWzmi67zMFAma78WVD66y76/ySEJj9ZhfDgslmTrURGkQx/9+mcDwLcLgJhUuHyjXA
         6LSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t7ih7/mYmiYyr4ILcen7invhIHJ7AYtkdt1FG+bwqf8=;
        b=ITO7no9hhiXeekvIr1XeSLFtpBJPN5ppA6QV9WtMpyh2O3UfWM1v3mtM3MSimfU5OQ
         K3qpR5tm4EPtznLGeyA/p3d9HxCzV/f1cswi/ZsbAwIV7Njc7/u+Seh3IvXC5Yx9s8UY
         QSVxO+gfyrP9x52FZdVw+ooI5YtnLw6rynCXVcNgp9zeLEMAqY/5MyeqWcDJAT642z/3
         +0gLQQJ1PfBROHOLblS4GuiQCG5jYwOR9hp6aTiG9kUMN+cjSexOqP4Gy0joLJvTfbZu
         UHpyqTSgNeMYAo+ydvDJGSx61lLnTZ2HxTKmuCcHSDyIWBO63q7V/uZk3+jqnPSKnoo7
         zVLg==
X-Gm-Message-State: ALoCoQmSIPMDxtUYu/rWQYz63DvGNAufTZ9J7wOb9FcQFZgWJOBCEsEz+aO9GBt5i1pl/0Blv0SeRxMPCSXwyf8xvZBoux0ybbfJdvR7pX176zvQTfUY/7dDFLsn/T0txTm1hhXt/NIOe9PywnvJoaZS8N62uBSBH7IOxvH+ayCikD6xVSHO/6uXTWe3MuEyKEX8NX3IdQVh
X-Received: by 10.236.130.101 with SMTP id j65mr10744241yhi.29.1398120824396;
        Mon, 21 Apr 2014 15:53:44 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id g21si5368300yhe.3.2014.04.21.15.53.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Apr 2014 15:53:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 3ADBC5A4207;
	Mon, 21 Apr 2014 15:53:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id F401AE06AA; Mon, 21 Apr 2014 15:53:43 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.515.g3b87021
In-Reply-To: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246672>

Change update_branch() to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index fb4738d..466dfe3 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1678,36 +1678,43 @@ found_entry:
 static int update_branch(struct branch *b)
 {
 	static const char *msg = "fast-import";
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
 	unsigned char old_sha1[20];
 
 	if (is_null_sha1(b->sha1))
 		return 0;
 	if (read_ref(b->name, old_sha1))
 		hashclr(old_sha1);
-	lock = lock_any_ref_for_update(b->name, old_sha1, 0, NULL);
-	if (!lock)
-		return error("Unable to lock %s", b->name);
+	transaction = ref_transaction_begin();
+	if (!transaction)
+		return error("Unable to begin transaction for %s", b->name);
 	if (!force_update && !is_null_sha1(old_sha1)) {
 		struct commit *old_cmit, *new_cmit;
 
 		old_cmit = lookup_commit_reference_gently(old_sha1, 0);
 		new_cmit = lookup_commit_reference_gently(b->sha1, 0);
 		if (!old_cmit || !new_cmit) {
-			unlock_ref(lock);
+			ref_transaction_rollback(transaction);
 			return error("Branch %s is missing commits.", b->name);
 		}
 
 		if (!in_merge_bases(old_cmit, new_cmit)) {
-			unlock_ref(lock);
+			ref_transaction_rollback(transaction);
 			warning("Not updating %s"
 				" (new tip %s does not contain %s)",
 				b->name, sha1_to_hex(b->sha1), sha1_to_hex(old_sha1));
 			return -1;
 		}
 	}
-	if (write_ref_sha1(lock, b->sha1, msg) < 0)
-		return error("Unable to update %s", b->name);
+	if (ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
+				   0, 1)) {
+		ref_transaction_rollback(transaction);
+		return error("Unable to update transaction for %s", b->name);
+	}
+	if (ref_transaction_commit(transaction, msg,
+				   UPDATE_REFS_QUIET_ON_ERR))
+		return error("Unable to commit transaction for %s", b->name);
+
 	return 0;
 }
 
-- 
1.9.1.515.g3b87021
