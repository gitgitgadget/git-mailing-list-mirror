From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 4/6] receive-pack.c: use a single ref_transaction for atomic pushes
Date: Wed, 17 Dec 2014 10:32:55 -0800
Message-ID: <1418841177-12152-5-git-send-email-sbeller@google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
 <1418841177-12152-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Wed Dec 17 19:33:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1JPT-0000RE-Nz
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 19:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbaLQSdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 13:33:12 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:47209 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbaLQSdI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 13:33:08 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so9453772igb.17
        for <git@vger.kernel.org>; Wed, 17 Dec 2014 10:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pv2aROljcy+O7q/d9XiNrk5vLjl56NDLosNKSNdFEgU=;
        b=lK2WfHHtEr9TduzDUPzkQAe3aG2pMxuUc2M1ffJ8Gm2966Za/l76BVdh0/8qZXjJ6z
         7NgpX8eEZVtG4oxbidRqYEXdaeWrx5CjjGircvMBRlo7CRy0CACHoUKgrtrI+NXNo+Dv
         K1DCHHAf+OtiTCd5dW1rvuoFas1CkvPMYHDJH1D7M4h0Nwh4Rp0rosvRKXXChkPz2UWx
         /DkHK8upQAgwXdLDBGAKjuP385PioUHJ3rtVMhn/3n1z0uQ6WAElJI2ZTKLFQ0e9zpJf
         sfCziA1qFM/+7xUwFQp3Qg4uyPMCczWaLReCp6JHMCXubL3SXNAAGmwjxEnLXF+pnRio
         978g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pv2aROljcy+O7q/d9XiNrk5vLjl56NDLosNKSNdFEgU=;
        b=DFokZek2ywqP25CrMuVsJvrDm9wwjG6TfTanUXqyiNo3SuZq2FD7UDUsIjMMkaYbHl
         o/+qm8DC6/xRz9NVU9k1W2jkBj36LT637Qb6NK6sM58geO+0IbTl6DVsO/Tcf+95vzMf
         hn1BYjtVsdzfC5/gfDE3UGZb6hkUwH4nrc8EdXyf7laLFLZuLQmPjVg+PKrHhxHca+Dd
         aZIpm/JpbyrMIYH184rPy15+174ZL1C4oF23uRmuNkVnI87L9r73DKQagXELcIZQ3TaU
         xg10xgHpbexBBm3MBQa695nUJfrrklXT0VhxRGFjjcjJMmHb+0zfY8lrWPLaadGFszRY
         OzQw==
X-Gm-Message-State: ALoCoQmdIIhJu4s82eH2NaY62rG8dIaXqHOPq60WbfVvnSeyZNaWEG8nRluAy3m8QRHJH5KJlVsN
X-Received: by 10.43.1.70 with SMTP id np6mr37622166icb.39.1418841187623;
        Wed, 17 Dec 2014 10:33:07 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:9f5:d31a:4ba2:b65d])
        by mx.google.com with ESMTPSA id e63sm2121298ioe.15.2014.12.17.10.33.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Dec 2014 10:33:07 -0800 (PST)
X-Mailer: git-send-email 2.2.0.31.gad78000.dirty
In-Reply-To: <1418841177-12152-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261489>

From: Ronnie Sahlberg <sahlberg@google.com>

Update receive-pack to use an atomic transaction iff the client negotiated
that it wanted atomic-push. This leaves the default behavior to be the old
non-atomic one ref at a time update. This is to cause as little disruption
as possible to existing clients. It is unknown if there are client scripts
that depend on the old non-atomic behavior so we make it opt-in for now.

If it turns out over time that there are no client scripts that depend on the
old behavior we can change git to default to use atomic pushes and instead
offer an opt-out argument for people that do not want atomic pushes.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    Changes v1 -> v2:
    	* update(...) assumes to be always in a transaction
    	* Caring about when to begin/commit transactions is put
    	  into execute_commands
    v2->v3:
    	* meditated about the error flow. Now we always construct a local
    	  strbuf err if required. Then the flow is easier to follow and
    	  destruction of it is performed nearby.
    	* early return in execute_commands if transaction_begin fails.

 builtin/receive-pack.c | 83 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 68 insertions(+), 15 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e76e5d5..c942a3b 100644
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
@@ -1052,6 +1055,7 @@ static void execute_commands(struct command *commands,
 	struct command *cmd;
 	unsigned char sha1[20];
 	struct iterate_data data;
+	struct strbuf err = STRBUF_INIT;
 
 	if (unpacker_error) {
 		for (cmd = commands; cmd; cmd = cmd->next)
@@ -1059,6 +1063,16 @@ static void execute_commands(struct command *commands,
 		return;
 	}
 
+	if (use_atomic) {
+		transaction = ref_transaction_begin(&err);
+		if (!transaction) {
+			error("%s", err.buf);
+			strbuf_release(&err);
+			for (cmd = commands; cmd; cmd = cmd->next)
+				cmd->error_string = "transaction error";
+			return;
+		}
+	}
 	data.cmds = commands;
 	data.si = si;
 	if (check_everything_connected(iterate_receive_command_list, 0, &data))
@@ -1086,8 +1100,25 @@ static void execute_commands(struct command *commands,
 
 		if (cmd->skip_update)
 			continue;
-
+		if (!use_atomic) {
+			transaction = ref_transaction_begin(&err);
+			if (!transaction) {
+				rp_error("%s", err.buf);
+				strbuf_release(&err);
+				cmd->error_string = "failed to start transaction";
+				return;
+			}
+		}
 		cmd->error_string = update(cmd, si);
+		if (!use_atomic)
+			if (ref_transaction_commit(transaction, &err)) {
+				ref_transaction_free(transaction);
+				rp_error("%s", err.buf);
+				strbuf_release(&err);
+				cmd->error_string = "failed to update ref";
+				return;
+			}
+
 		if (shallow_update && !cmd->error_string &&
 		    si->shallow_ref[cmd->index]) {
 			error("BUG: connectivity check has not been run on ref %s",
@@ -1096,10 +1127,32 @@ static void execute_commands(struct command *commands,
 		}
 	}
 
+	if (use_atomic) {
+		/*
+		 * update(...) may abort early (i.e. because the hook refused to
+		 * update that ref) which then doesn't even record a transaction
+		 * regarding that ref. Make sure all commands are without error
+		 * and then commit atomically.
+		 */
+		for (cmd = commands; cmd; cmd = cmd->next)
+			if (cmd->error_string)
+				break;
+		if (cmd) {
+			for (cmd = commands; cmd; cmd = cmd->next)
+				if (!cmd->error_string)
+					cmd->error_string = "atomic push failure";
+		} else if (ref_transaction_commit(transaction, &err)) {
+			rp_error("%s", err.buf);
+			for (cmd = commands; cmd; cmd = cmd->next)
+				cmd->error_string = err.buf;
+		}
+		ref_transaction_free(transaction);
+	}
 	if (shallow_update && !checked_connectivity)
 		error("BUG: run 'git fsck' for safety.\n"
 		      "If there are errors, try to remove "
 		      "the reported refs above");
+	strbuf_release(&err);
 }
 
 static struct command **queue_command(struct command **tail,
-- 
2.2.0.31.gad78000.dirty
