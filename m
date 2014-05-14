From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 23/42] receive-pack.c: use a reference transaction for updating the refs
Date: Wed, 14 May 2014 14:16:57 -0700
Message-ID: <1400102236-30082-24-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:20:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkgb1-0007HV-HL
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639AbaENVTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:19:53 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:57229 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbaENVR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:29 -0400
Received: by mail-vc0-f202.google.com with SMTP id hr9so428421vcb.3
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zKoadzszFXlCTSWpzRr0xPg6H4VbywbFKg5yg6MaP1U=;
        b=aTYWwaDPyC9quwaPkM6h23PP6kjv3O86tO7q4YD6/YYSUuOFu4aRgttxJJi+wjar2Q
         kY91VLrn/W2zWyoBMx32jnOojQf8tz/wI1VwKx2jL7PzMRnbK0RfEY9QTh0ZQgU+hMFL
         3YRdMMWCmvvlD4hLabQYydyCkLPmvcVi0uaKQJf7YDdgXONdR9o1rxnaRjsYa9SUfTaI
         Hao3xssEEwqb7r19sq/dMj0U7VBECA7h+T6t6BDU6wma3/Xzn//8lG+rso1qdYmRXKYw
         S3CaDBfWbYrsq7npntuw0TPEAUKQLYZh6G4lwcioDRldJIf3UlM5Ioao8ynTYpGne6sK
         ZJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zKoadzszFXlCTSWpzRr0xPg6H4VbywbFKg5yg6MaP1U=;
        b=A9iR7Fn8Mn5ptaT4j0fGEvuTvxbE2OgHh0gCFAfgWvPH7+fnFNatClvsl4q9P2FwsQ
         44bipCqlgILUKwnsTBOa7X10sZWzQzk5JRSpoCTnhl0ChOfJAxrEXKgkykq/X5TjafEV
         5a6tZbpHkYip5NM1xbAp45fVPPQC4APfLIxeuDQgCux/Tr4XrHi5SuW8esi7i6FfKpdZ
         tIQ+PJhVHCrTpe3rQ2X4u3tnfrZsK1uVK7XxFM32r7XTTyPRmJpZisnv8YAG4XJaDu7+
         Lw6xsuxQ64wKgGxWpXzY4jNt1akEkdw6bxMr/Qc+MJreMW9DRivmRDLOOyuKG4KTFkxv
         t5IA==
X-Gm-Message-State: ALoCoQlxQ4R52y5e542nTXzazc+DWvK2I7SDRRp2/mA+G07qV6lLZAAfNOSvhsX75TGVwNLNa1tm
X-Received: by 10.236.77.194 with SMTP id d42mr2529763yhe.21.1400102247760;
        Wed, 14 May 2014 14:17:27 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l7si146189yho.1.2014.05.14.14.17.27
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:27 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9C66131C1F8;
	Wed, 14 May 2014 14:17:27 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6101AE0CB6; Wed, 14 May 2014 14:17:27 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248978>

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
2.0.0.rc3.471.g2055d11.dirty
