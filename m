From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 5/9] receive-pack.c: move transaction handling in a central place
Date: Mon, 29 Dec 2014 18:36:43 -0800
Message-ID: <1419907007-19387-6-git-send-email-sbeller@google.com>
References: <1419907007-19387-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Tue Dec 30 03:37:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5mgY-00020N-MM
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 03:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbaL3ChL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 21:37:11 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:62513 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbaL3ChJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 21:37:09 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so12022977igd.14
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 18:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KWNFCS+tq73ypyzdEROn7Bz7MKoTPuEiHjojKwDJQ9g=;
        b=ZoTEKnJWO3kmZiDGoGmU0lr8kDn5yTuya7po+6ABPvQqFiEu7SG2CQR2dTLgDehf7h
         TM8WvpHwzYTvoygS/doq/Zgbp+WiLiPWIccBlF5PPS4D5At+sAxFPuhU5sSvA5RXP7Gp
         z+PwsEjf3r14JX+5MlGQ3pGDWUwPsYXlv7tBjUJIGL5RM8kMl2wSOlNBAyRa2bl0CVrB
         BvHBJ0pPAdRshYQDZWtUVETtJ4rB4eomz09t5A2YxHPyYu1cXday9yfzw1CPXMfQuT1J
         T/4nzIPxRSAQO3xbHPO7Or7F3Dp/IYonWjYfJ0MsKXWEWXWSOYA9gZmqzpZHqXpnbgDe
         1hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KWNFCS+tq73ypyzdEROn7Bz7MKoTPuEiHjojKwDJQ9g=;
        b=PLUUsj5H4pUw3W1Xx5qzG4U65tTXy0YA4Onbwk9eRvUi6ml5Y0VdGXtn/0y+P446/+
         Ci2HnP3f3ln3Hsl8Udi7xajyr/LJvVp48EVGR1j7sXD0W2K1qf7biQF+dxTbbFyfU2ir
         evTedRaFCodgXoFecoQtHswcK3tyKqSZkAcfK///YNO7E5ixPEUxLfqbVA5jFcVpCbTt
         QJmRh+LMG6yw6q8KnrIiX6ifyRlqGYovhODhAIR0Uboz/Dt6TMXGuis38olucQxns5i0
         fvcSXIarEF6ieNJj1ubew3Onglgr1bylF1LOpylDyclb9nSRkfcqfd95jNDqx+qVCS8w
         4w2w==
X-Gm-Message-State: ALoCoQnwx5Ft2pI4/Uz8iaQ47LvjwN8vHKAzNjQeshD4Zg4pBN+UEG7PG/Gjs2ZzTJTChuZiO9G4
X-Received: by 10.42.194.17 with SMTP id dw17mr44449123icb.4.1419907028054;
        Mon, 29 Dec 2014 18:37:08 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5860:dcf1:88a4:141b])
        by mx.google.com with ESMTPSA id e63sm18505735ioe.15.2014.12.29.18.37.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Dec 2014 18:37:07 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419907007-19387-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261903>

No functional changes intended.
This moves all code related to transactions into the execute_commands_loop
function which was factored out of execute_commands. This includes
beginning and committing the transaction as well as dealing with the
errors which may occur during the begin and commit phase of a transaction.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
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

 builtin/receive-pack.c | 69 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 19 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 06eb287..5f44466 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -67,6 +67,7 @@ static const char *NONCE_SLOP = "SLOP";
 static const char *nonce_status;
 static long nonce_stamp_slop;
 static unsigned long nonce_stamp_slop_limit;
+static struct ref_transaction *transaction;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -822,6 +823,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	}
 
 	if (is_null_sha1(new_sha1)) {
+		struct strbuf err = STRBUF_INIT;
 		if (!parse_object(old_sha1)) {
 			old_sha1 = NULL;
 			if (ref_exists(name)) {
@@ -831,35 +833,36 @@ static const char *update(struct command *cmd, struct shallow_info *si)
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
@@ -1073,6 +1076,38 @@ static void check_shallow_bugs(struct command *commands,
 		      "the reported refs above");
 }
 
+static void execute_commands_loop(struct command *commands,
+				  struct shallow_info *si)
+{
+	struct command *cmd;
+	struct strbuf err = STRBUF_INIT;
+
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		if (!should_process_cmd(cmd))
+			continue;
+
+		transaction = ref_transaction_begin(&err);
+		if (!transaction) {
+			rp_error("%s", err.buf);
+			strbuf_reset(&err);
+			cmd->error_string = "transaction failed to start";
+			continue;
+		}
+
+		cmd->error_string = update(cmd, si);
+
+		if (!cmd->error_string
+		    && ref_transaction_commit(transaction, &err)) {
+			rp_error("%s", err.buf);
+			strbuf_reset(&err);
+			cmd->error_string = "failed to update ref";
+		}
+		ref_transaction_free(transaction);
+	}
+
+	strbuf_release(&err);
+}
+
 static void execute_commands(struct command *commands,
 			     const char *unpacker_error,
 			     struct shallow_info *si)
@@ -1107,12 +1142,8 @@ static void execute_commands(struct command *commands,
 	free(head_name_to_free);
 	head_name = head_name_to_free = resolve_refdup("HEAD", 0, sha1, NULL);
 
-	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
-			continue;
+	execute_commands_loop(commands, si);
 
-		cmd->error_string = update(cmd, si);
-	}
 	check_shallow_bugs(commands, si);
 }
 
-- 
2.2.1.62.g3f15098
