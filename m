From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv12 04/10] receive-pack.c: move transaction handling in a central place
Date: Wed,  7 Jan 2015 19:23:18 -0800
Message-ID: <1420687404-13997-5-git-send-email-sbeller@google.com>
References: <1420687404-13997-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
	mhagger@alum.mit.edu, ronniesahlberg@gmail.com, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 08 04:24:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y93hT-00062p-CC
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 04:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755772AbbAHDXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 22:23:51 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:61084 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbbAHDXt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 22:23:49 -0500
Received: by mail-ig0-f180.google.com with SMTP id h15so901217igd.1
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 19:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wCpwozuaY5UEg5qBYtG3MZnp3GglCER4YMsM9k0YirA=;
        b=ozQ63GMDYHPvSrm6e9bN/C5EkRIvrAIxLGmvz3htX8bfoORgJMSEifgRVn4cD72Egs
         tlN/YIsHI+ndxkDPuybVeEOG61YGSJQiwtjR9lTJqdGhczVN5KShZfFaHGJTAPCYeiQ0
         c8hbFwlja3Ug08dvx6rhhDDlmJmw/DWqQmeJbHE6klv1rLCWSui6UZsADuCN/4iJzRpS
         6hzDRBcOLEIy5uqa4m9GoBChEQqTIOn/bOTadsZ6ImzlFWCA9m8ihBnAZ6ajuUitvEdP
         lsGFgWHBdFlb888hnpd3O9b2YQm/EsCvzsbsYZFsAYOgSV6b5Ani03fJoFX6rc0c+IxG
         D/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wCpwozuaY5UEg5qBYtG3MZnp3GglCER4YMsM9k0YirA=;
        b=YvPOnUjzNM24l0uS+5GPObwRNf+sLwdeFxqYxAqP5qITtQX8/0V/annlbt6wIP5CTn
         7MjSZsjiVrXksCTXKwQCjYdrgFAu+kzuHxRZlfThwjviXgCL8Vg6xJF1g3oSeeSIILOf
         bsdacipwwGY77QaOx1B7WkbqeMQiaLyDjx1u6AnKGaT69eN7AtItJKSpvxW24/vdNAl9
         QNJlXRcWnSeR25UMCkxaqsB8tuvHt81LzkAHDIzgRqowHK3GbCHzzrMG7AufpSeolnO3
         suMLRUXq583wtkOmcYXFZ3NgufD+/pq+gvNWK8H/RLgo8YTkPOGCA+YycI2kYak88Hk+
         2A1g==
X-Gm-Message-State: ALoCoQl4vIXBxEmoCXhbmbR8Y29LKFQy9QfUGaKi+u5uaNQ8+qbU5FeeOosjqy5B0isl62LnUb6D
X-Received: by 10.50.143.65 with SMTP id sc1mr12733639igb.12.1420687428675;
        Wed, 07 Jan 2015 19:23:48 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:948f:12c6:eb26:9b9c])
        by mx.google.com with ESMTPSA id p137sm1740104ioe.29.2015.01.07.19.23.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Jan 2015 19:23:48 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1420687404-13997-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262173>

This moves all code related to transactions into the
execute_commands_non_atomic function. This includes
beginning and committing the transaction as well as
dealing with the errors which may occur during the
begin and commit phase of a transaction.

No functional changes intended.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v10, v11, v12:
     no changes
    
    v9:
     This was split up into the patch before and this one.
     This patch only deals with the transactions now.
    
    v8:
     move execute_commands_loop before execute_commands, so it compiles/links
     without warnings.
    
    v7:
     new in v7, this is part of the previous "[PATCH 4/7]
     receive-pack.c: receive-pack.c: use a single ref_transaction for atomic pushes"
    
    This covers the suggestion of patch 2 and 3 by Eric
    > patch 2: Factor out the main 'for' loop of execute_commands() into a
    > new function. This new function will eventually become
    > execute_commands_non_atomic(). At this point, execute_commands() is
    > pretty much in its final form with the exception of the upcoming 'if
    > (use_atomic)' conditional.
    > patch 3: Morph the function extracted in patch 2 into
    > execute_commands_non_atomic() by adding transaction handling inside
    > the 'for' loop (and applying the changes from the early part of the
    > patch which go along with that).

 builtin/receive-pack.c | 51 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0ccfb3d..96e56a7 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -66,6 +66,7 @@ static const char *NONCE_SLOP = "SLOP";
 static const char *nonce_status;
 static long nonce_stamp_slop;
 static unsigned long nonce_stamp_slop_limit;
+static struct ref_transaction *transaction;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -821,6 +822,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	}
 
 	if (is_null_sha1(new_sha1)) {
+		struct strbuf err = STRBUF_INIT;
 		if (!parse_object(old_sha1)) {
 			old_sha1 = NULL;
 			if (ref_exists(name)) {
@@ -830,35 +832,36 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 				cmd->did_not_exist = 1;
 			}
 		}
-		if (delete_ref(namespaced_name, old_sha1, 0)) {
-			rp_error("failed to delete %s", name);
+		if (ref_transaction_delete(transaction,
+					   namespaced_name,
+					   old_sha1,
+					   0, old_sha1 != NULL,
+					   "push", &err)) {
+			rp_error("%s", err.buf);
+			strbuf_release(&err);
 			return "failed to delete";
 		}
+		strbuf_release(&err);
 		return NULL; /* good */
 	}
 	else {
 		struct strbuf err = STRBUF_INIT;
-		struct ref_transaction *transaction;
-
 		if (shallow_update && si->shallow_ref[cmd->index] &&
 		    update_shallow_ref(cmd, si))
 			return "shallow error";
 
-		transaction = ref_transaction_begin(&err);
-		if (!transaction ||
-		    ref_transaction_update(transaction, namespaced_name,
-					   new_sha1, old_sha1, 0, 1, "push",
-					   &err) ||
-		    ref_transaction_commit(transaction, &err)) {
-			ref_transaction_free(transaction);
-
+		if (ref_transaction_update(transaction,
+					   namespaced_name,
+					   new_sha1, old_sha1,
+					   0, 1, "push",
+					   &err)) {
 			rp_error("%s", err.buf);
 			strbuf_release(&err);
+
 			return "failed to update ref";
 		}
-
-		ref_transaction_free(transaction);
 		strbuf_release(&err);
+
 		return NULL; /* good */
 	}
 }
@@ -1068,12 +1071,32 @@ static void execute_commands_non_atomic(struct command *commands,
 					struct shallow_info *si)
 {
 	struct command *cmd;
+	struct strbuf err = STRBUF_INIT;
+
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (!should_process_cmd(cmd))
 			continue;
 
+		transaction = ref_transaction_begin(&err);
+		if (!transaction) {
+			rp_error("%s", err.buf);
+			strbuf_reset(&err);
+			cmd->error_string = "transaction failed to start";
+			continue;
+		}
+
 		cmd->error_string = update(cmd, si);
+
+		if (!cmd->error_string
+		    && ref_transaction_commit(transaction, &err)) {
+			rp_error("%s", err.buf);
+			strbuf_reset(&err);
+			cmd->error_string = "failed to update ref";
+		}
+		ref_transaction_free(transaction);
 	}
+
+	strbuf_release(&err);
 }
 
 static void execute_commands(struct command *commands,
-- 
2.2.1.62.g3f15098
