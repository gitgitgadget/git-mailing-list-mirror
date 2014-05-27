From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 21/41] fast-import.c: change update_branch to use ref transactions
Date: Tue, 27 May 2014 13:25:40 -0700
Message-ID: <1401222360-21175-22-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:28:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNym-00054r-VN
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbaE0U1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:27:34 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:48788 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-yh0-f73.google.com with SMTP id f73so1644960yha.2
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nye7QaT0s08yIWFOjf8WrCQWUaqZkKML7unR074xOfo=;
        b=cr5y39gdWtWJ0stq7heJu8t68KNcEBo0RclLmC7+JuXnibEAplWUhblH+5lwrwY9tZ
         fDKM3G7GfgqdQSqFG5iCC1OV/peNsBPLHMqYmR3pRAntfGGNji/WEAchaHiJeTgha/L6
         0Ct4vBtPCgwuCuLkVb6w/VO44EasJ3LeO7bkG9YqboEwJyGc4f3CEoFa31nbgQkJgItC
         Nyhvafg4712wKq2Djsk8hQNQxachO3VgiWoZSBy/1Xsplq4uLHC4ZsJG/SHeDpPb0xyr
         ZRCLgiCK7x963CL5EqVhPo0gypjp/qsV2RAuXrA9BDzb8BS+uKdZp9+3ABFyUQq50LNl
         sNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nye7QaT0s08yIWFOjf8WrCQWUaqZkKML7unR074xOfo=;
        b=FwRFPmYsMBP2CipL0mdzqa6RLnOsmnpffeIkje8C0+EkiBiEJ2EPhedE6ryRWChsfH
         PjhF8EXhK+hNH/r5AlQH0Lfk0HGNA22pV9y/hFj+FUWvjBleZgORFQKdKRHdMIkLgd2a
         zm4trIKcitrZtURfDO4QB6cJpyoV2ZKQAod0TiILipcABo2rUJz2q6/gb+pb9/NCBBR2
         kuSSqkF8GcUB/YD8LDQeOr+4DovWveqglvzXD6AmTGW2yqoJT15OTpFcu+WNPgBT9vL9
         9G3RrvvFsOq4Y0rBWW+Y63tzA9SOUtuk5L9YJhoUQaaF3mgt+9h8p9eePpK/+DrIX1hD
         jYVg==
X-Gm-Message-State: ALoCoQnygdFV93D4aCTnKnH5IWZXxRx83QBS7Gn0oU04pgHqHesdcoDCg08EsMojoH2c+W+s/25p
X-Received: by 10.58.43.170 with SMTP id x10mr14240533vel.36.1401222364707;
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si1574646yhj.5.2014.05.27.13.26.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8B4C5370571;
	Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 678DBE1565; Tue, 27 May 2014 13:26:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250233>

Change update_branch() to use ref transactions for updates.

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
2.0.0.rc3.474.g0203784
