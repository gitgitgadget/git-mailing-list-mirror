From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/7] receive-pack.c: receive-pack.c: use a single ref_transaction for atomic pushes
Date: Fri, 19 Dec 2014 11:38:58 -0800
Message-ID: <1419017941-7090-5-git-send-email-sbeller@google.com>
References: <1419017941-7090-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Fri Dec 19 20:39:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y23Oa-0005fi-PC
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 20:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbaLSTjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 14:39:20 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:63635 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbaLSTjR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 14:39:17 -0500
Received: by mail-ig0-f177.google.com with SMTP id z20so1201240igj.10
        for <git@vger.kernel.org>; Fri, 19 Dec 2014 11:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uQ0ecjZnJXSuD0/EsK1QsXOa4xHvXbKuSClzMOFsokE=;
        b=Jg6iO7BD4sFSZZJdAc9ygX8+lfjcKkRuvAAAaTNJIzZPhz8oahp7gZEvIPUzt5hc5K
         BoDfYBdbfcgcPvEJyFMPSv+SM4dBYybAFC+Mk6quqfjocLk7ytTYn6EhURSPLrvR+qUC
         wMPH6cTnTKvPEXNMhiofZSLZpKXml3cJ+4/Y9au6nf95b6pP+KFVRbGVtYk7i/nxtU4x
         xiGb9dwM5OjpMO1/aTog70lm6iTiQnuEpkdoOH6dKa7ukvZsDne1n5U7DJ9eJLJ9KWsG
         TB4qCXNwW3RejuXPiHMGRMi0cn7ZMFsWkqY8myR20K6xyg6p32cuyk7ts6fgkignKuLw
         FrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uQ0ecjZnJXSuD0/EsK1QsXOa4xHvXbKuSClzMOFsokE=;
        b=WF7sZk00dhVgLQ6CsbtRfC4leO6cE+BS1HwPsqcblWMe8LR73j5xLf4ZYWoCw5XafF
         IbHe2tafr0x5ng30ahv6opvEU69Y6IiEZdSjuZdt4EwvCMolmahmxN6jlAI5UpwcSfy3
         P+zJwOLFjd8g97O5FFv1yiaTmGoiVndVDAGvFUjb90/tfLRI9TcMvYmesdlqsH5HeT9v
         t7HNx2GaCIKfrh3BCJ63RpYrqAhMAG64o5zpzXKhQvEhVdNOV5JYDAKmTaOnZPLkDsra
         iuNT0tvv05CPkUXD1ENHoWIrVFbNvqZ7xiIJHqeXL6oLnLHU8slIWSvgTbJPNQMvYKIO
         8nfQ==
X-Gm-Message-State: ALoCoQlvHfjkLAvXoa6W66iR0knkgYf9DETHMUiVx+4lbbMOsGtOJAyrJ5HV8H1yjr/4nkq3M0W6
X-Received: by 10.42.175.3 with SMTP id ay3mr8134586icb.58.1419017957068;
        Fri, 19 Dec 2014 11:39:17 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5827:d4a2:8bd5:ac5d])
        by mx.google.com with ESMTPSA id m2sm4942231ioi.10.2014.12.19.11.39.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Dec 2014 11:39:16 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419017941-7090-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261590>

Update receive-pack to use an atomic transaction iff the client negotiated
that it wanted atomic-push. This leaves the default behavior to be the old
non-atomic one ref at a time update. This is to cause as little disruption
as possible to existing clients. It is unknown if there are client scripts
that depend on the old non-atomic behavior so we make it opt-in for now.

If it turns out over time that there are no client scripts that depend on the
old behavior we can change git to default to use atomic pushes and instead
offer an opt-out argument for people that do not want atomic pushes.

Inspired-by: Ronnie Sahlberg <sahlberg@google.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    Changes in v6:
    	This is a complete rewrite of the patch essentially.
    	Eric suggested to split up the flow into functions, so
    	it is easier to read. It's more lines of code, but indeed
    	it's easier to follow. Thanks Eric!
    
    	Note there is another patch following this one
    	moving the helper functions above execute_commands.
    	I just choose the order of the functions in this patch
    	to have a better diff (just inserting the call to the function
    	execute_commands_non_atomic and that function directly follows.)
    	The next patch of the series will move that up.
    
    	Because of the rewrite and the fixes of the previous five
    	versions there is not much left of Ronnies original patch,
    	so I'll claim authorship of this one.
    
    Changes v1 -> v2:
    	* update(...) assumes to be always in a transaction
    	* Caring about when to begin/commit transactions is put
    	  into execute_commands
    v2->v3:
    	* meditated about the error flow. Now we always construct a local
    	  strbuf err if required. Then the flow is easier to follow and
    	  destruction of it is performed nearby.
    	* early return in execute_commands if transaction_begin fails.
    
    v3->v4:
    	* revamp logic again. This should keep the non atomic behavior
    	  as is (in case of error say so, in non error case just free the
    	  transaction). In the atomic case we either do nothing (when no error),
    	  or abort with the goto.
    
    		if (!cmd->error_string) {
    			if (!use_atomic
    			    && ref_transaction_commit(transaction, &err)) {
    				ref_transaction_free(transaction);
    				rp_error("%s", err.buf);
    				strbuf_release(&err);
    				cmd->error_string = "failed to update ref";
    			}
    		} else if (use_atomic) {
    			goto atomic_failure;
    		} else {
    			ref_transaction_free(transaction);
    		}
    
    	 * Having the goto directly there when checking for cmd->error_string,
    	   we don't need to do it again, so the paragraph explaining the error
    	   checking is gone as well. (Previous patch had the following, this is
    	   put at the end of the function, where the goto jumps to and the comment
    	   has been dropped.
    +		/*
    +		 * update(...) may abort early (i.e. because the hook refused to
    +		 * update that ref) which then doesn't even record a transaction
    +		 * regarding that ref. Make sure all commands are without error
    +		 * and then commit atomically.
    +		 */
    +		for (cmd = commands; cmd; cmd = cmd->next)
    +			if (cmd->error_string)
    +				break;
    
    v4->v5:
    Eric wrote:
    > Repeating from my earlier review[1]: If the 'pre-receive' hook
    > "declines", then this transaction is left dangling (and its resources
    > leaked).
    
    You're right. The initialization of the transaction is now
    near the actual loop after the pre receive hook.
    
    > The !use_atomic case (below), calls this error "failed to start
    > transaction", not merely "transaction error".
    
    ok, now both are "transaction failed to start".
    In all cases where these generic errors are reported,
    we do have a rp_error(...) with details.
    
    > Furthermore, in the use_atomic case (also below), when a commit fails,
    > you assign err.buf to cmd->error_string rather than a generic
    > "transaction error" message. What differs between these cases which
    > makes the generic message preferable here over the more specific
    > err.buf message?
    
    They are the same now.
    
    > Repeating from my earlier review[1]: This is leaking 'transaction' for
    > each successful commit (and only freeing it upon commit error).
    
    Right. I thought I had it covered with the else clause. Of course not.
    
    > At the end of this function, strbuf_release(&err) is invoked, which
    > leaves all these cmd->error_strings dangling.
    
    I removed all assignments of err.buf now.
    
    > goto's can help simplify error-handling when multiple conditional
    > branches need to perform common cleanup, however, this label
    > corresponds to only a single goto statement.
    
    moved up again.

 builtin/receive-pack.c | 137 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 115 insertions(+), 22 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e76e5d5..710cd7f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -67,6 +67,7 @@ static const char *NONCE_SLOP = "SLOP";
 static const char *nonce_status;
 static long nonce_stamp_slop;
 static unsigned long nonce_stamp_slop_limit;
+static struct ref_transaction *transaction;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -823,6 +824,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	}
 
 	if (is_null_sha1(new_sha1)) {
+		struct strbuf err = STRBUF_INIT;
 		if (!parse_object(old_sha1)) {
 			old_sha1 = NULL;
 			if (ref_exists(name)) {
@@ -832,35 +834,36 @@ static const char *update(struct command *cmd, struct shallow_info *si)
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
@@ -1044,11 +1047,72 @@ static void reject_updates_to_hidden(struct command *commands)
 	}
 }
 
+static void execute_commands_non_atomic(struct command *commands,
+				    struct shallow_info *si);
+
+
+static void execute_commands_atomic(struct command *commands,
+				    struct shallow_info *si)
+{
+	struct command *cmd;
+	struct strbuf err = STRBUF_INIT;
+	const char *reported_error = "atomic push failure";
+	int checked_connectivity = 1;
+	transaction = ref_transaction_begin(&err);
+	if (!transaction) {
+		rp_error("%s", err.buf);
+		reported_error = "transaction failed to start";
+		goto failure;
+	}
+
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		if (cmd->error_string)
+			goto failure;
+
+		if (cmd->skip_update)
+			goto failure;
+
+		cmd->error_string = update(cmd, si);
+
+		if (cmd->error_string)
+			goto failure;
+
+		if (shallow_update && si->shallow_ref[cmd->index]) {
+			error("BUG: connectivity check has not been run on ref %s",
+			      cmd->ref_name);
+			checked_connectivity = 0;
+			reported_error = "transaction failed due to internal bug";
+			goto failure;
+		}
+	}
+
+	if (ref_transaction_commit(transaction, &err)) {
+		rp_error("%s", err.buf);
+		reported_error = "atomic transaction failed";
+		goto failure;
+	}
+
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
+	return;
+
+failure:
+	for (cmd = commands; cmd; cmd = cmd->next)
+		if (!cmd->error_string)
+			cmd->error_string = reported_error;
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
+
+	if (shallow_update && !checked_connectivity)
+		error("BUG: run 'git fsck' for safety.\n"
+		      "If there are errors, try to remove "
+		      "the reported refs above");
+}
+
 static void execute_commands(struct command *commands,
 			     const char *unpacker_error,
 			     struct shallow_info *si)
 {
-	int checked_connectivity;
 	struct command *cmd;
 	unsigned char sha1[20];
 	struct iterate_data data;
@@ -1079,7 +1143,20 @@ static void execute_commands(struct command *commands,
 	free(head_name_to_free);
 	head_name = head_name_to_free = resolve_refdup("HEAD", 0, sha1, NULL);
 
-	checked_connectivity = 1;
+	if (use_atomic) {
+		execute_commands_atomic(commands, si);
+	} else {
+		execute_commands_non_atomic(commands, si);
+	}
+}
+
+static void execute_commands_non_atomic(struct command *commands,
+					struct shallow_info *si)
+{
+	struct command *cmd;
+	struct strbuf err = STRBUF_INIT;
+	int checked_connectivity = 1;
+
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string)
 			continue;
@@ -1087,19 +1164,35 @@ static void execute_commands(struct command *commands,
 		if (cmd->skip_update)
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
-		if (shallow_update && !cmd->error_string &&
-		    si->shallow_ref[cmd->index]) {
-			error("BUG: connectivity check has not been run on ref %s",
-			      cmd->ref_name);
-			checked_connectivity = 0;
+
+		if (!cmd->error_string) {
+			if (ref_transaction_commit(transaction, &err)) {
+				rp_error("%s", err.buf);
+				strbuf_reset(&err);
+				cmd->error_string = "failed to update ref";
+			}
+			if (shallow_update && si->shallow_ref[cmd->index]) {
+				error("BUG: connectivity check has not been run on ref %s",
+				      cmd->ref_name);
+				checked_connectivity = 0;
+			}
 		}
+		ref_transaction_free(transaction);
 	}
-
 	if (shallow_update && !checked_connectivity)
 		error("BUG: run 'git fsck' for safety.\n"
 		      "If there are errors, try to remove "
 		      "the reported refs above");
+	strbuf_release(&err);
 }
 
 static struct command **queue_command(struct command **tail,
-- 
2.2.1.62.g3f15098
