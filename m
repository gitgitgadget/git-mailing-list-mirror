From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv9 3/9] receive-pack.c: move transaction handling in a central place
Date: Tue, 30 Dec 2014 15:41:32 -0800
Message-ID: <1419982898-23108-4-git-send-email-sbeller@google.com>
References: <1419982898-23108-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, mhagger@alum.mit.edu,
	jrnieder@gmail.com, ronniesahlberg@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 31 00:42:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y66QL-0007uT-T2
	for gcvg-git-2@plane.gmane.org; Wed, 31 Dec 2014 00:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbaL3Xlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 18:41:52 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:36478 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbaL3Xlt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 18:41:49 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so14291350iec.10
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 15:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7sCp5SDKcERf/WNXwYRuggN4FZCOUU57RDVnPXEufEI=;
        b=jh5JAxOsjwReG2eJpk1nbAhOyJQ3tPvwUhFKr1PJNZI3HSy8q3sVJPR2gkZGziaWJH
         eYydCkOZS0y5OI8maIXEGje8yLviolzw0BBJTwZjNhOl4veoe0s6EcMHr70odDMF0jFV
         U5PT4capc6m6Zd/9Lxy73ycBDIkoOpSpHlB4zqFSu16UgR6s/9ISGaTCKD4E0M/53L+D
         i+iXqYONzJnjircbOnW3qlzirr9yqEhN7hxF6jlO+bTaUYmxojk1hyo8Hq774JeEf65+
         TOveCyfe+M4o/54zCCG7/1L/DC4itU9TmLIX1zDzguvssHhjEfWwsRBJ2kfD/IVpvfvm
         EuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7sCp5SDKcERf/WNXwYRuggN4FZCOUU57RDVnPXEufEI=;
        b=NrKfhJPvBfwABcQzNfWvwivP0dW6mVQXQkG9fGbMAKGW7KLqRE3+HisDJFI5mthXCd
         KNLifAHZg3rda5+/jq6JAwpdBnC1oJVvW0S7rJdryLodnL78OzefIt1BZy7nCgCfcxrc
         fSxeXkx29vpmAFlHh59PF1+efMlM5QBDoYnphLKa2C4KsMkeA+rR/5mUIo2T/aTey0Cl
         4XWZHUm1n3qyVsi/c2ov7tQDicInSjaAm0GmPgnSJ54L4v9GcLBUTdlMg04vQ0zdvDao
         mvIlITggWqfbccoACYsbGnRBKHRl5bm4PZbeGEu1CPKnecfB8AHFtalpR5+TSVwfAMkI
         C5fw==
X-Gm-Message-State: ALoCoQnNYLleVSK47rh6MWXV3602GOoCoHcFRPx6vjwCsPMR8pyx5i1YPrgmCqrG9Q+foO3rIa20
X-Received: by 10.42.86.136 with SMTP id u8mr48066884icl.91.1419982908746;
        Tue, 30 Dec 2014 15:41:48 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e545:220a:6cf6:2fed])
        by mx.google.com with ESMTPSA id bd5sm16266282igb.14.2014.12.30.15.41.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Dec 2014 15:41:47 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419982898-23108-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261956>

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
index 941aae5..36e8795 100644
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
@@ -1069,12 +1072,32 @@ static void execute_commands_non_atomic(struct command *commands,
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
