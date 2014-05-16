From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 25/44] receive-pack.c: use a reference transaction for updating the refs
Date: Fri, 16 May 2014 10:37:13 -0700
Message-ID: <1400261852-31303-26-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:39:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM6c-0002KJ-9G
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758130AbaEPRjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:39:19 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:40499 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757941AbaEPRhj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:39 -0400
Received: by mail-oa0-f74.google.com with SMTP id m1so585655oag.5
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q1aaoJegQ0CF0Z3KCzvnDr8d6g+zWgeSoJpD5jG5jOw=;
        b=RkgY8d+ttcBPSTLmGm9bCrD8Cm2V/BA1z4vNlZTbaYpaq0t3jlw2gZvZyMfixztii9
         KG5dvftNBye8Fvd0+W6X02babzaSt1OE2lw7cmwXCKo/sc2xOtly81XT9sxwihIrRBWP
         PY0Da0NmzlGYFlneFH2NEBvd0izSPo46ivn4nlO42zOM+19dVEg9MObwUoJ1gFPT8Tq4
         MfNBSVvx0uIkz60GzSaJJO/YcxcGabD8910zb3cUx5Rs8XGEMGFN3DKQi2RmY7gcUuf5
         mmrKRwEYerRbds3OqLXUDhQf3w6TKcl+kvmeyseKoCIXYeHHU9USpeCcC+0NxZuFypFZ
         Uy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q1aaoJegQ0CF0Z3KCzvnDr8d6g+zWgeSoJpD5jG5jOw=;
        b=iguYjJYZ5FP4sCX0WIdH5+jq7Otl9jd/UBYSY93wvz7gjijIicThyVullPWqpM4E5k
         G2llSGWPfDGFaG1dWqcljC84SFYQcSYHkjQ3X6cRKniCxP354C7o5W8e1ocXnP+gaRud
         FUReyH2Hprhc81rxiHqKwElSLAP4TO398mdkR27HTi7u6k2d8+vKj42h41zBVjXCvpJq
         oK9TzA8sqvfgsjq88ok8WSl5JcMpW/o0swpAHFtzIdGpRbZvPLfFpsf/eIdIsjxG7mge
         MAWKs//9gzanjBUYhifrdCfN0j6Y826ukFE8tdaYJVRLHL1DOjKOakylDA3HavYHj0ga
         ZIow==
X-Gm-Message-State: ALoCoQnmld6mXFJbQAjW0R2VgNRgPUZn+meft9NtHN/SEwEmhJRo76IvY+dfUNJzcP4v7jBpuYxm
X-Received: by 10.43.94.71 with SMTP id bx7mr7709787icc.2.1400261857827;
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si368512yhj.5.2014.05.16.10.37.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A76D831C211;
	Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 856EBE0C3A; Fri, 16 May 2014 10:37:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249386>

Wrap all the ref updates inside a transaction to make the update atomic.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/receive-pack.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c323081..5534138 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -46,6 +46,8 @@ static void *head_name_to_free;
 static int sent_capabilities;
 static int shallow_update;
 static const char *alt_shallow_file;
+static struct strbuf err = STRBUF_INIT;
+static struct ref_transaction *transaction;
 
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
+					   new_sha1, old_sha1, 0, 1, &err))
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
2.0.0.rc3.510.g20c254b
