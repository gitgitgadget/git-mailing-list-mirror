From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 4/6] receive-pack.c: use a single ref_transaction for atomic pushes
Date: Thu, 18 Dec 2014 16:22:01 -0800
Message-ID: <1418948521-30787-1-git-send-email-sbeller@google.com>
References: <CAPig+cS9hJBga7BU-YC3bNG23Tb30kQsXydwGyRYb1T_0fiVqw@mail.gmail.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: sunshine@sunshineco.com, ronniesahlberg@gmail.com,
	mhagger@alum.mit.edu, jrnieder@gmail.com, git@vger.kernel.org,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Dec 19 01:22:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1lKk-0003aE-15
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 01:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbaLSAWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 19:22:12 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:42234 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbaLSAWL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 19:22:11 -0500
Received: by mail-ob0-f173.google.com with SMTP id uy5so8186711obc.4
        for <git@vger.kernel.org>; Thu, 18 Dec 2014 16:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wr2WBooff0wSjItM+ULkSz45YPo0tr+KOwpCXzZlTzg=;
        b=BJQ84ir67zEkNrOidIRgFppSpNxOEMq3/OdWPY6GMbObL1iqo5T58tQWevanIBhYpa
         AvVly+V+HY+aU0hAZwBEdfceydonqcv1CacSkLXsucLIk4QaZyG3sZVjV++uR+LOs5cs
         gXMDzhzyU0vlSnNRLbp5YhMXPMsNjpEaiNe04+OF0zfUTdpxI0NMhgrHJH5Yc5toyia3
         L5nnKMbLvWP/OIyKQXcHEwHt0O0rJKZIDjhkJY2PIvwgKMFpACqQ6Zb65/ps9wOgn+51
         CaWAG3hMFN0713PpqNUFUyEiooPPekDJ52Fmzsf+BzlSFD+apvZWynJGYz2ZUqdkab/Q
         z03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wr2WBooff0wSjItM+ULkSz45YPo0tr+KOwpCXzZlTzg=;
        b=MDXKEzUDkem3VfT5OnFecEUaNM+rvdFjDEtKHgtpaliSdHkGr9oFDahszttAaWjUV9
         zkbEaZa+5dTaL/T5ul5011x9E4cvxHQS+IXMOuZrK45Bb7El38itrFhmknfI+HHlSSHW
         FXIWvPUqTBRbz9fM2JXyDKfuNsDppAYbNiMn2v2A3+5MyALmvPYblMhY4EW/TQoaU+qc
         TbGjLwai8qVgzMrNSKUVuvxZDBfO+SkOaVEJK+oIYQk5S13yVO9Z6dIhVse696VROj2y
         j40qxWXy54PfgnSIs/fy33OgIl7zIGP/E+ipWMxGe6ABICRuEkxbdS4wUjrfDktmFQSI
         lmxw==
X-Gm-Message-State: ALoCoQmNaUERLBDf8R//IwoJ9vlm2G9G8VqfXv0WisbzbQ6nns9M8JiEmVKu0HTPEU1aFy1TMEcp
X-Received: by 10.50.138.76 with SMTP id qo12mr425408igb.49.1418948530588;
        Thu, 18 Dec 2014 16:22:10 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:4df5:1ab4:bb:7bed])
        by mx.google.com with ESMTPSA id 37sm1679708iog.39.2014.12.18.16.22.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Dec 2014 16:22:10 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <CAPig+cS9hJBga7BU-YC3bNG23Tb30kQsXydwGyRYb1T_0fiVqw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261543>

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

 builtin/receive-pack.c | 81 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 67 insertions(+), 14 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e76e5d5..ebce2fa 100644
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
@@ -1080,6 +1084,17 @@ static void execute_commands(struct command *commands,
 	head_name = head_name_to_free = resolve_refdup("HEAD", 0, sha1, NULL);
 
 	checked_connectivity = 1;
+
+	if (use_atomic) {
+		transaction = ref_transaction_begin(&err);
+		if (!transaction) {
+			rp_error("%s", err.buf);
+			strbuf_release(&err);
+			for (cmd = commands; cmd; cmd = cmd->next)
+				cmd->error_string = "transaction failed to start";
+			return;
+		}
+	}
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string)
 			continue;
@@ -1087,7 +1102,36 @@ static void execute_commands(struct command *commands,
 		if (cmd->skip_update)
 			continue;
 
+		if (!use_atomic) {
+			transaction = ref_transaction_begin(&err);
+			if (!transaction) {
+				rp_error("%s", err.buf);
+				strbuf_release(&err);
+				cmd->error_string = "transaction failed to start";
+				continue;
+			}
+		}
 		cmd->error_string = update(cmd, si);
+		if (!cmd->error_string) {
+			if (!use_atomic) {
+				if (ref_transaction_commit(transaction, &err)) {
+					rp_error("%s", err.buf);
+					strbuf_release(&err);
+					cmd->error_string = "failed to update ref";
+				}
+				ref_transaction_free(transaction);
+			}
+		} else {
+			ref_transaction_free(transaction);
+			if (use_atomic) {
+				for (cmd = commands; cmd; cmd = cmd->next)
+					if (!cmd->error_string)
+						cmd->error_string = "atomic push failure";
+				strbuf_release(&err);
+				return;
+			}
+		}
+
 		if (shallow_update && !cmd->error_string &&
 		    si->shallow_ref[cmd->index]) {
 			error("BUG: connectivity check has not been run on ref %s",
@@ -1096,10 +1140,19 @@ static void execute_commands(struct command *commands,
 		}
 	}
 
+	if (use_atomic) {
+		if (ref_transaction_commit(transaction, &err)) {
+			rp_error("%s", err.buf);
+			for (cmd = commands; cmd; cmd = cmd->next)
+				cmd->error_string = "atomic transaction failed";
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
2.2.1.62.g3f15098
