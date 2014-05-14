From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 23/31] reflog.c: use the existing transaction to also lock and update the ref
Date: Wed, 14 May 2014 15:13:22 -0700
Message-ID: <1400105610-21194-24-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:15:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhSA-0000IL-27
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632AbaENWOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:14:06 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:54725 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467AbaENWNk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:40 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so51517pab.5
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5iuv9evaM+Q63gpjEHKP+iD62PJz2lJx/4nQd8gOy+g=;
        b=iXmsi9wJC6lhD//FeW5uNe7VEjNxKS/ZEKpaTweeT5rEXSmwqbGn6OnlWZiTGNvp+x
         cQmkTHrZ5wuV7un4JvaG+pcLugl31fVStAIht8bxHY5OI5jHpzkYsQOj8byRcdhOYT3G
         kKSXwWE1Ff8EYoE6fqUxGDxkPcUw9SV6k8KQnbEpZeYiiLgL7pKixSaOoAe0sJkFyPKo
         rLIoS2WoSFt/K2qowYplc/JVyq/+xKuL2UjIwxQd+d91ytyMLySct9CLRAG8IvwPALd8
         Dks7HrogZS9dKK1NtLPAgVNMX5wySX8WGIfzzcjJVIbfwoR0SR0epA+NC9kU/mrkQ+YJ
         oalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5iuv9evaM+Q63gpjEHKP+iD62PJz2lJx/4nQd8gOy+g=;
        b=WMWiKECBjDcrJHi33VBiFZ8CkzcnqEwZtt6vWW9TA1QgnlCnub35pHtNcSE9ufXFUw
         /B9dg91yaDlwquDJiJAMse16zRrZZPxcveYVu1UIYt3eeqUXWqHIHcAg+mdwn43RlLOT
         orVsoRgEh3eGnZHOyJoF0MgDW5UugyQQFm74eM+YjgRgl3SCaq3p0cVyxbpq0w1u73Se
         BuhCD4KrC2LYPDW4W28gjfDPDNjevfsJKtxCogQv1XDrrdvsIJg1wib5ze59xGnYVuSb
         Lk7yohCHzD2AkwlY2z5LZeOJlLIP9kL+ULm3mOM/tvaHiM2aE8jm53MD+QJlEVrBIFUP
         UFeQ==
X-Gm-Message-State: ALoCoQkXLsINZCUiO3KBL7KzSWHaNenUr4FS3RL8xbSQ4GV+iMh1N/drCncdeCC4epSnFaAzlhnv
X-Received: by 10.66.66.163 with SMTP id g3mr3040313pat.3.1400105620354;
        Wed, 14 May 2014 15:13:40 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si150761yhl.7.2014.05.14.15.13.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 2FB635A4208;
	Wed, 14 May 2014 15:13:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E9180E038E; Wed, 14 May 2014 15:13:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249032>

reflog.c has a transaction for updating the reflog. Use this transaction
also for locking the ref itself and updating the ref instead of
locking the file directly and writing to it. This now completely eliminates
the refs and reflog implementation from reflog.c.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/reflog.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 2239249..78fd442 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -351,7 +351,6 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 {
 	struct cmd_reflog_expire_cb *cmd = cb_data;
 	struct expire_reflog_cb cb;
-	struct ref_lock *lock;
 	struct commit *tip_commit;
 	struct commit_list *tips;
 	int status = 0;
@@ -359,23 +358,24 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	memset(&cb, 0, sizeof(cb));
 	cb.refname = ref;
 
+	if (!reflog_exists(ref))
+		goto finish;
+
+	cb.t = transaction_begin();
 	/*
-	 * we take the lock for the ref itself to prevent it from
-	 * getting updated.
+	 * This locks the ref itself, preventing it from getting
+	 * updated.
 	 */
-	lock = lock_any_ref_for_update(ref, sha1, 0, NULL);
-	if (!lock)
+	if (transaction_update_sha1(cb.t, cb.refname,
+				    sha1, sha1, 0, 1, NULL, NULL)) {
+		transaction_rollback(cb.t);
 		return error("cannot lock ref '%s'", ref);
-	if (!reflog_exists(ref))
-		goto finish;
-	if (!cmd->dry_run) {
-		cb.t = transaction_begin();
-		transaction_update_reflog(cb.t, cb.refname,
-					  null_sha1, null_sha1, NULL,
-					  0, 0, NULL,
-					  REFLOG_TRUNCATE,
-					  NULL);
 	}
+	transaction_update_reflog(cb.t, cb.refname,
+				  null_sha1, null_sha1, NULL,
+				  0, 0, NULL,
+				  REFLOG_TRUNCATE,
+				  NULL);
 
 	cb.cmd = cmd;
 
@@ -421,23 +421,19 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 		}
 	}
  finish:
-	if (cb.t) {
+	if (!cmd->dry_run) {
 		if (cmd->updateref &&
-		    (write_in_full(lock->lock_fd,
-				   sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
-		     write_str_in_full(lock->lock_fd, "\n") != 1 ||
-		     close_ref(lock) < 0)) {
+		    transaction_update_sha1(cb.t, cb.refname,
+					    cb.last_kept_sha1, sha1,
+					    0, 1, NULL, NULL)) {
 			status |= error("Couldn't write %s",
-				lock->lk->filename);
+				cb.refname);
 			transaction_rollback(cb.t);
 		} else if (transaction_commit(cb.t, NULL)) {
 			status |= error("cannot commit reflog for %s", ref);
-		} else if (cmd->updateref && commit_ref(lock)) {
-			status |= error("Couldn't set %s", lock->ref_name);
 		}
-		transaction_free(cb.t);
 	}
-	unlock_ref(lock);
+	transaction_free(cb.t);
 	return status;
 }
 
-- 
2.0.0.rc3.506.g3739a35
