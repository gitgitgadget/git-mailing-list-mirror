From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 4/6] receive-pack.c: use a single ref_transaction for atomic pushes
Date: Tue, 16 Dec 2014 10:49:05 -0800
Message-ID: <1418755747-22506-4-git-send-email-sbeller@google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
 <1418755747-22506-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org, mhagger@alum.mit.edu,
	jrnieder@gmail.com, ronniesahlberg@gmail.com
X-From: git-owner@vger.kernel.org Tue Dec 16 19:49:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0xBc-0005n1-Q5
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 19:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbaLPSt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 13:49:29 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:42365 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbaLPStS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 13:49:18 -0500
Received: by mail-ie0-f182.google.com with SMTP id x19so13391253ier.41
        for <git@vger.kernel.org>; Tue, 16 Dec 2014 10:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PbcG7Par3K5/9rP7hWgyiZvOZNGhM8w7DRgzyJ1JBnU=;
        b=jIq95Iwo0iROCrecin7gbtKHEdw4R+IRVJsGQoT2USTetRu5ElScYBzrjaJ8xAScSS
         VHlagPIs+ER3ep/1jy5P8dBxAPBOJ9lywLwoH5IIS35bDPv0JQBlFjHp85LTq/cFZows
         o+0OBFdtI0+l4QykSfqxaBloDhY5DILnt4o+Dpg81To1n/F5FmJwj+0IDy6oXdTLXTLm
         PKLqFE1JwLWZzcnmn9dgX3hNjU9KNkQInDaLIyWk3v3+BfJ98TaZw3ECC5yty4mSrXk6
         ff+q60zQjkq9gJbBP02sbehcG33gzv5FiGI3tQIDlyqWa3w5YEwM/E5QXOYxg3vActUB
         RvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PbcG7Par3K5/9rP7hWgyiZvOZNGhM8w7DRgzyJ1JBnU=;
        b=fXYtaRIOANjzOtKgLQiRzg49Wr+UHS7Uhot125k1/3vlT2woRt2eFJJ73kNA+WBxbC
         hrKFwrH9dvwGeQaFWfnkrLVLOs6w4i4Gg0GbNvTp04ugMXx6vT6IHJyZ0y9uUAgboHEG
         jDxjIjZM3GQjbIQHQDFUrSevbVmL5qUqgY/bkAYOH6p5WpVtzG130JuRZCd9MdShfxlT
         F1K5/dj+S/TE0ZjqQq//3GelhJFT+pq739jmPsd34Hp3x/WlRRIMTYF1orptGK+60lk3
         /GSKLkY/dT1EHkIxO5bflR1K3nWp8r7WCNRUcpdHLkuZWvWeUw/yUqWkudmY9bfs9mgY
         GVZQ==
X-Gm-Message-State: ALoCoQn8vklc2bIdWt+zPxmfT50EQz3dFYw+gDwC9NFgPYqsnLM66RhLg7qOyZd4ZVoxFyxic/IC
X-Received: by 10.42.22.144 with SMTP id o16mr28469409icb.0.1418755757480;
        Tue, 16 Dec 2014 10:49:17 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:4db1:657a:aafa:5d88])
        by mx.google.com with ESMTPSA id j82sm634632iod.12.2014.12.16.10.49.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Dec 2014 10:49:16 -0800 (PST)
X-Mailer: git-send-email 2.2.0.31.gad78000.dirty
In-Reply-To: <1418755747-22506-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261447>

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

 builtin/receive-pack.c | 64 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e76e5d5..0803fd2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -67,6 +67,8 @@ static const char *NONCE_SLOP = "SLOP";
 static const char *nonce_status;
 static long nonce_stamp_slop;
 static unsigned long nonce_stamp_slop_limit;
+struct strbuf err = STRBUF_INIT;
+struct ref_transaction *transaction;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -832,34 +834,32 @@ static const char *update(struct command *cmd, struct shallow_info *si)
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
 		return NULL; /* good */
 	}
 	else {
-		struct strbuf err = STRBUF_INIT;
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
 			return "failed to update ref";
 		}
 
-		ref_transaction_free(transaction);
 		strbuf_release(&err);
 		return NULL; /* good */
 	}
@@ -1059,6 +1059,16 @@ static void execute_commands(struct command *commands,
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
@@ -1086,8 +1096,23 @@ static void execute_commands(struct command *commands,
 
 		if (cmd->skip_update)
 			continue;
-
+		if (!use_atomic) {
+			transaction = ref_transaction_begin(&err);
+			if (!transaction) {
+				rp_error("%s", err.buf);
+				strbuf_release(&err);
+				cmd->error_string = "failed to start transaction";
+			}
+		}
 		cmd->error_string = update(cmd, si);
+		if (!use_atomic)
+			if (ref_transaction_commit(transaction, &err)) {
+				ref_transaction_free(transaction);
+				rp_error("%s", err.buf);
+				strbuf_release(&err);
+				cmd->error_string = "failed to update ref";
+			}
+
 		if (shallow_update && !cmd->error_string &&
 		    si->shallow_ref[cmd->index]) {
 			error("BUG: connectivity check has not been run on ref %s",
@@ -1096,6 +1121,14 @@ static void execute_commands(struct command *commands,
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
@@ -1543,5 +1576,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	sha1_array_clear(&shallow);
 	sha1_array_clear(&ref);
 	free((void *)push_cert_nonce);
+	strbuf_release(&err);
 	return 0;
 }
-- 
2.2.0.31.gad78000.dirty
