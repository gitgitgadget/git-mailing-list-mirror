From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 25/44] receive-pack.c: use a reference transaction for updating the refs
Date: Thu, 15 May 2014 10:29:40 -0700
Message-ID: <1400174999-26786-26-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:30:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzUH-00072S-MP
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755729AbaEORa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:30:26 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:53766 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755674AbaEORaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:09 -0400
Received: by mail-ig0-f202.google.com with SMTP id r10so99796igi.3
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PlmLBDAfdjuXHhgGwlACLta5PKWYi+O6CmsAzHdZkhw=;
        b=APT4ARJ+pSZz9hZJ/33EXQJ0ZcmEy2/IcOQGho0ecA+byVt6E6P2hqr2cqlrnULB55
         MXADwRYiWT3KjypVD8QjDgYB+4Xpqd9pbVmSj3rYDkEWhfwQPRRxeIfwLxWuHA9f2g8E
         NP73wfPOxocPTuJjrSCzT/3PfVNaI6wnGeOpsU+yn16XPvA2CKK6I983QbPj0h0zk5f+
         mgJW4ON+eo+nQO0fdqS5G85SBO0T2FrGTbPuVszi8v0UdHd8sFUtGV7m7nquzGymQLfq
         Fp2SJK4XUY4kiFFEciqRpKyypqemI1Yg8LEu5Yk8KqG97zYabfFY/T2fZPdhKzQuXhI9
         7Krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PlmLBDAfdjuXHhgGwlACLta5PKWYi+O6CmsAzHdZkhw=;
        b=cmlBRHwoEuRxS135V447I+gFpVnHQ6Z5W0vICTDhj2/drqZ8rCUcie6NkKNY0I2qjc
         dOUKXxi62VpCRlVypdALFHAwVFZ3MfG+kbdp4vKtI4LH2o+8xyohVoTWEKE2XpYivdhB
         /fe7Cbrit15juw2RkbeH25YNhHPdi+2Nex2OeeV4v6s2X4n8SmKklnHgGWwuDKjG0LCg
         dJzcgOBviZ1qUZ+kSMuB0M6h5w3+q2jXq5kyPLSpRso12PSvy/wwhNMAbFnyEvAU+xul
         K3+OC01Ec21zWzBk4emHRwWVGQfaa4KHIefh3KZHM3ubB2EzP4jblbbMcl5TBVrWO4t+
         rhTw==
X-Gm-Message-State: ALoCoQmXoR81+DGZlkKrqJ4OW5arv12ZAy9K1wQRNNRXV0K0jjfLJLZJEkswTLk2FH7SW92up+UT
X-Received: by 10.50.130.102 with SMTP id od6mr1412616igb.0.1400175006951;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k43si273451yhq.3.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id C67935A427D;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A034BE16A3; Thu, 15 May 2014 10:30:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249125>

Wrap all the ref updates inside a transaction to make the update atomic.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/receive-pack.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c323081..d580176 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -46,6 +46,8 @@ static void *head_name_to_free;
 static int sent_capabilities;
 static int shallow_update;
 static const char *alt_shallow_file;
+struct strbuf err = STRBUF_INIT;
+struct ref_transaction *transaction;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -475,7 +477,6 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	const char *namespaced_name;
 	unsigned char *old_sha1 = cmd->old_sha1;
 	unsigned char *new_sha1 = cmd->new_sha1;
-	struct ref_lock *lock;
 
 	/* only refs/... are allowed */
 	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
@@ -580,15 +581,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		    update_shallow_ref(cmd, si))
 			return "shallow error";
 
-		lock = lock_any_ref_for_update(namespaced_name, old_sha1,
-					       0, NULL);
-		if (!lock) {
-			rp_error("failed to lock %s", name);
-			return "failed to lock";
-		}
-		if (write_ref_sha1(lock, new_sha1, "push")) {
-			return "failed to write"; /* error() already called */
-		}
+		if (ref_transaction_update(transaction, namespaced_name,
+					   new_sha1, old_sha1, 0, 1))
+			return "failed to update";
 		return NULL; /* good */
 	}
 }
@@ -812,6 +807,7 @@ static void execute_commands(struct command *commands,
 	head_name = head_name_to_free = resolve_refdup("HEAD", sha1, 0, NULL);
 
 	checked_connectivity = 1;
+	transaction = ref_transaction_begin();
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string)
 			continue;
@@ -827,6 +823,10 @@ static void execute_commands(struct command *commands,
 			checked_connectivity = 0;
 		}
 	}
+	if (ref_transaction_commit(transaction, "push", &err))
+		error("%s", err.buf);
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
 
 	if (shallow_update && !checked_connectivity)
 		error("BUG: run 'git fsck' for safety.\n"
-- 
2.0.0.rc3.477.g0f8edf7
