From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 08/14] refs.c: add a flag to allow reflog updates to truncate the log
Date: Mon, 16 Jun 2014 09:51:39 -0700
Message-ID: <1402937505-6091-9-git-send-email-sahlberg@google.com>
References: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 18:52:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwa8v-0002pd-H7
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 18:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbaFPQwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 12:52:10 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:43290 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932199AbaFPQvv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 12:51:51 -0400
Received: by mail-yh0-f74.google.com with SMTP id b6so838224yha.3
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PL5BkniAP/WVpTJG3Sa4ZrLKhxVBSlreC1j5DpA9mck=;
        b=blEa703NFZ7078g8X58xnQ05kQ9Gnf982ievqIB8Zq7+J2FBaCVDFKRf5937ZWJm/g
         838TTkWLnVPZfmdd9L04ByGISxrQiMwhFIQj3WoWEQu8mOOzWeI49phqvK33j512dSMB
         qtdwwH7vyjUvR7smzJx2Qe2DzwyREiSAfIBcKvjmBnuT1F1MXgoL/xXKXPBiTV+UdJ/B
         AQH/FpaDHfJRmOEGWugjGWfTxsUYGdc8T9Yf+1ywSKA/3KhLOI6Sku9uEqNMgqu4nDhc
         +FVfohKDZ0x1mDN+CppO2R0YvRoPenyiyPnZzdO1Rekn2X+YXlbuyIj0D4FKmpui0tRo
         u+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PL5BkniAP/WVpTJG3Sa4ZrLKhxVBSlreC1j5DpA9mck=;
        b=MlTqdvcaX7aE8Ln0kGZSRQ7JrEamgvnLKnR0tFRVtzHfy5k46guHy0ORwBmmSMXndl
         TlOCQrapmxUOQUscSfvj+hBQFU1p53KkCiojI1mX1g+3Eu49c0GPTpSenkjYv0ZwEfpV
         E+45BAV2l1JWQAnXVjUTnRZkEBTTMDthGoY54Od4vBYqMFbsCX8WSv//r8PKEjz0qA1m
         PxvRaiok2KPh2iUCNHdjfCEBsnNEDkGOWypA7aKITCa0WnB3NRDjKnEkOE6HTxIbwB6X
         3eS4CbJu1G1T/3ph+s0wGcV+iTK9V37QovGwLQ4sJuEklcSzZ1kc3fePPtZwQxdFfqEp
         bHHg==
X-Gm-Message-State: ALoCoQmCMnYbWhXv5nFEc27/IX8bHWL/QW18ARpbSVEOq7ZLSz8PoNlosqt8dwEhYsH/52TlCyYw
X-Received: by 10.58.72.135 with SMTP id d7mr1203707vev.10.1402937509734;
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si982740yhp.6.2014.06.16.09.51.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 898F25A461A;
	Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 225C1E0F37; Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.770.gd892650.dirty
In-Reply-To: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251723>

Add a flag that allows us to truncate the reflog before we write the
update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 17 +++++++++++++++--
 refs.h | 10 +++++++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 9db5896..379b50e 100644
--- a/refs.c
+++ b/refs.c
@@ -3763,7 +3763,12 @@ int transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
-	/* Update all reflog files */
+	/*
+	 * Update all reflog files
+	 * We have already done all ref updates and deletes.
+	 * There is not much we can do here if there are any reflog
+	 * update errors other than complain.
+	 */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
@@ -3771,7 +3776,15 @@ int transaction_commit(struct ref_transaction *transaction,
 			continue;
 		if (update->reflog_fd == -1)
 			continue;
-
+		if (update->flags & REFLOG_TRUNCATE)
+			if (lseek(update->reflog_fd, 0, SEEK_SET) < 0 ||
+				ftruncate(update->reflog_fd, 0)) {
+				error("Could not truncate reflog: %s. %s",
+				      update->refname, strerror(errno));
+				rollback_lock_file(&update->reflog_lock);
+				update->reflog_fd = -1;
+				continue;
+			}
 		if (log_ref_write_fd(update->reflog_fd, update->old_sha1,
 				     update->new_sha1,
 				     update->committer, update->msg)) {
diff --git a/refs.h b/refs.h
index 5f4deef..7c3a9ca 100644
--- a/refs.h
+++ b/refs.h
@@ -327,7 +327,15 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
 			    struct strbuf *err);
 
 /*
- * Append a reflog entry for refname.
+ * Flags controlling transaction_update_reflog().
+ * REFLOG_TRUNCATE: Truncate the reflog.
+ *
+ * Flags >= 0x100 are reserved for internal use.
+ */
+#define REFLOG_TRUNCATE 0x01
+/*
+ * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
+ * this update will first truncate the reflog before writing the entry.
  */
 int transaction_update_reflog(struct ref_transaction *transaction,
 			      const char *refname,
-- 
2.0.0.770.gd892650.dirty
