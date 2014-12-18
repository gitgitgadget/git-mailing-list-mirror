From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 4/6] receive-pack.c: use a single ref_transaction for atomic pushes
Date: Thu, 18 Dec 2014 09:45:06 -0800
Message-ID: <1418924706-9843-1-git-send-email-sbeller@google.com>
References: <xmqqppbg7uxk.fsf@gitster.dls.corp.google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	sunshine@sunshineco.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 18:45:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1f8Z-0005wq-8N
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 18:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbaLRRpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 12:45:12 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:60483 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbaLRRpK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 12:45:10 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so1285629igb.11
        for <git@vger.kernel.org>; Thu, 18 Dec 2014 09:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AZ8pC0BVIDAHQLtgr3x1NSteCIYMJBau2UfX57asGC8=;
        b=gYEjsugqGXUWZYSxQAajKXp7aWNs72B13gWknoK4Xv02PERilc6pyrsQIH9bGWBaRO
         AkCKWygeo9NuGBwAt5sxkr7ZLp5FwLJH/7LYQQ19SFsBs0Cdl35hYBEVh1vhPmi58JQz
         FuSAVnzRzVyigQ6H56Gb+cYP9M/+AwqSJg4ZvXteg5GiU85T+PHn6Ws7fcBzJZFnZ7f1
         wUiRcRss+hlPsNwxP29KLy83TbD3OlyoN9d2VqPlB/6BYGkhf+b2lN5Nb+8EYMKYCf+A
         cNRysBgKzuFPK65blorDLq3EShoqGMUfn14Wn3/1f1oz5K/jc1Pq9H9uYidM7WwWOBVV
         Jbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AZ8pC0BVIDAHQLtgr3x1NSteCIYMJBau2UfX57asGC8=;
        b=LVgm2Qp/Qk9BVtSMpjwxQMZj5UH9jOdUpusXD8zWWAlBHG/KQS78UWDh7wxfaWiEg4
         mQC5RisTfC2RMAFCWZt8kM0F8gRM7r88VR7MECtDOLiv/GTZpUfRfzr3OcHBEjX6LWWq
         lTL+yv3ojG0F+cVUt2NN7m+xXIfTUtVnZKWAGJ1vbfVTkfoNTgbCuSCJ9xZmL3Tre4Fc
         nllvS+Gc/FPvTVXj3Hfv6sAaDxF9nFvdTL0Ju+OabO4iuGb1GBwxNBCM3m1LiS6p7PEZ
         WMa3MU4DJiP2xLvIh2iRD03GSAU3MVrB7YulaFR5j1ubUwvkB/ntG44b/34ne5TA+Hx6
         1ttA==
X-Gm-Message-State: ALoCoQkan1z2lSNTgFA+eoL1ZXsC+YopwzbULZcDU8G7AOFHXntIE55g0UztoVZ/HEPTRNXUPZWn
X-Received: by 10.107.47.157 with SMTP id v29mr3048344iov.59.1418924709465;
        Thu, 18 Dec 2014 09:45:09 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:4df5:1ab4:bb:7bed])
        by mx.google.com with ESMTPSA id f198sm3434740ioe.11.2014.12.18.09.45.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Dec 2014 09:45:08 -0800 (PST)
X-Mailer: git-send-email 2.2.0.31.gad78000.dirty
In-Reply-To: <xmqqppbg7uxk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261532>

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

v4 of the series only resends this patch as the others did not get any 
feedback to improve.
        
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

 builtin/receive-pack.c | 83 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 69 insertions(+), 14 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e76e5d5..4952d91 100644
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
@@ -1087,7 +1101,30 @@ static void execute_commands(struct command *commands,
 		if (cmd->skip_update)
 			continue;
 
+		if (!use_atomic) {
+			transaction = ref_transaction_begin(&err);
+			if (!transaction) {
+				rp_error("%s", err.buf);
+				strbuf_release(&err);
+				cmd->error_string = "failed to start transaction";
+				continue;
+			}
+		}
 		cmd->error_string = update(cmd, si);
+		if (!cmd->error_string) {
+			if (!use_atomic
+			    && ref_transaction_commit(transaction, &err)) {
+				ref_transaction_free(transaction);
+				rp_error("%s", err.buf);
+				strbuf_release(&err);
+				cmd->error_string = "failed to update ref";
+			}
+		} else if (use_atomic) {
+			goto atomic_failure;
+		} else {
+			ref_transaction_free(transaction);
+		}
+
 		if (shallow_update && !cmd->error_string &&
 		    si->shallow_ref[cmd->index]) {
 			error("BUG: connectivity check has not been run on ref %s",
@@ -1096,10 +1133,28 @@ static void execute_commands(struct command *commands,
 		}
 	}
 
+	if (use_atomic) {
+		if (ref_transaction_commit(transaction, &err)) {
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
+
+	return;
+
+atomic_failure:
+	for (cmd = commands; cmd; cmd = cmd->next)
+		if (!cmd->error_string)
+			cmd->error_string = "atomic push failure";
+
+	ref_transaction_free(transaction);
 }
 
 static struct command **queue_command(struct command **tail,
-- 
2.2.0.31.gad78000.dirty
