From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 25/44] receive-pack.c: use a reference transaction for updating the refs
Date: Thu, 15 May 2014 16:15:22 -0700
Message-ID: <1400195741-22996-26-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:17:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4ty-0007YW-Ib
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756269AbaEOXRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:17:00 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:55834 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756040AbaEOXPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:46 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so348129pab.5
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rAjyJ2cjP8Nwza0UDqbhb1CurftLrGitdXYgorAWBJ0=;
        b=UEdauLp8rcFKvbVjGp3ri4qCpXAhWXXA7edYPErOM8JfhrDOklVortK5H9ENRfva5G
         Tm5ay7bmcRHsvb2sBmhz58Z9SOwMfFwNw0p+2JFun89xHtnP40kkiPv3Zaj4iGcU5otM
         ta/6XG6IsiSFz1DCpGTsgURYRC9bC4kKQlfyler/NW/YvEXoocU1dm5wrd/oxFKbf0/1
         Kr6uTgfhzdyM1VpwccuRFtcd583peOg2Me2kN34zYcapMZb/nXPU6XTAU5uU8Fq2kApI
         Rtt07vL2mfns4ZiplP+PbxE51Pbsb3ZwHuAPRIOfv7QhFuyrVuQYXNCHA1Ag4QbtRq59
         pgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rAjyJ2cjP8Nwza0UDqbhb1CurftLrGitdXYgorAWBJ0=;
        b=cmfBpEIYJGVKZcT6c4G7p1PxxCquMSCnbjodBm5XrN7R8lKcvlScN2bWyx8twsw9SL
         5z3RLlPkaVUkN3NCGJA6e21R1H+zHnzPayWxCAPFYcV1LaVK+boi/Ey59y8o+ObUAgBD
         guhn5mMYSOTZItlxJf35BLOujgdIth4XE3+UciMg5asqfonUcbRMQ4Up+Ptc6ngQUcZe
         XMlji/XwSUcdjZ9xWdsZCJiGno8dHWgx/T4Vk9zuchreyfhzUZKeKMItmueebpf/gHZX
         O/Hhn/wn0+936QFE01gS8invBFLcutyTitG1C3IIm4orKuMQq2xjR8p2e2DTvn0G16YY
         SmdA==
X-Gm-Message-State: ALoCoQmZNTjGZzOSwqaFkldnAnK9dXvv4UHQGI1j0bxrKhPReomJkBOUWeCLf2ciVHSaD2cNxnGd
X-Received: by 10.66.169.231 with SMTP id ah7mr6987464pac.40.1400195745772;
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id h18si319600yhj.0.2014.05.15.16.15.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9637931C1CD;
	Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 72988E0764; Thu, 15 May 2014 16:15:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249251>

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
2.0.0.rc3.477.gffe78a2
