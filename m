From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 3/7] receive-pack.c: use a single transaction when atomic-push is negotiated
Date: Mon,  3 Nov 2014 11:12:28 -0800
Message-ID: <1415041952-19637-4-git-send-email-sahlberg@google.com>
References: <1415041952-19637-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:12:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlN3a-0006P7-Vc
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbaKCTMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:12:46 -0500
Received: from mail-pd0-f201.google.com ([209.85.192.201]:49643 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbaKCTMg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:12:36 -0500
Received: by mail-pd0-f201.google.com with SMTP id r10so1997264pdi.0
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8+ftS1SyBzyfop/ZPV8HmtRM52dFhfmMIJuZsB82Ug4=;
        b=VyJWd9RX60hrCPl+z5J0dMxsXjW6mM5yWsoznwn5cy8B1SnyVFoOa5GOl3+m9vbswC
         NDqd/lgl4ai6XDjgll7pu9kVc9CvdpKRLeX9do0VCAWqF0yZ/vAuf2vrz5IkXs6kVzww
         Y7DWnxZXw/Dr8esnAyH8WBOfKoI7k8+zOBqOCOPWWWENGuHrsc6Q2mNw8ApC4cDm8woz
         2AlSVf/5Y7Tm+6s4IuL7qY+Vwt63Ozp6JVh5gXLdF7G0ADRAmtYdjeanvgcris4gj6Ii
         Tli1J2dhjSoXC3hwmpKNr+1VTQd7w5xmYRWe3Op4aeBadu+/ZqZznRxWV1oKbOIfFYAO
         z5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8+ftS1SyBzyfop/ZPV8HmtRM52dFhfmMIJuZsB82Ug4=;
        b=VovwVOJss7A4gSrR+IKHj32yVegUaKJxV3Ico85EppM+dsbZ4LhFSrUpPZhyXpgXAV
         nunAC0fCIFcoyPTW0fnxb69UuwuF84C+rHUec1aQpS8KJhgS6+UlefSGf7ltUJaUeu6K
         4oK1PWyn1DAGMBQmyHfhx9biLKX3tRggYnLenL0XzKOcZBsB+F4HMhrHk1INGtf0jF2r
         2Ceudj1xNQ8mx/SB39c1oNYGUzE8xhVx8qtZ78bHOeJ4SzXifb8fv8rmusLOSm34xjko
         6D7ZUQ18gZIuSD77kbaNFNAsSP0jiDWmtSDQvSOmYJt/w6FhxBLNGuK+Ym8Y4cqikiLx
         DcOA==
X-Gm-Message-State: ALoCoQnUtiy5TnMLaAFfBpHh1wb6QePMqnVsLB3yk2p4wJswJqKkkXY8W5L0k+pBoEgDJGLJJ4+E
X-Received: by 10.68.57.163 with SMTP id j3mr15699658pbq.1.1415041955805;
        Mon, 03 Nov 2014 11:12:35 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id k66si974323yho.7.2014.11.03.11.12.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:12:35 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id Uk0ACOag.1; Mon, 03 Nov 2014 11:12:35 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 480EAE0F5D; Mon,  3 Nov 2014 11:12:34 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415041952-19637-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update receive-pack to use an atomic transaction iff the client negotiated
that it wanted atomic-push.
This leaves the default behavior to be the old non-atomic one ref at a
time update. This is to cause as little disruption as possible to existing
clients. It is unknown if there are client scripts that depend on the old
non-atomic behavior so we make it opt-in for now.

Later patch in this series also adds a configuration variable where you can
override the atomic push behavior on the receiving repo and force it
to use atomic updates always.

If it turns out over time that there are no client scripts that depend on the
old behavior we can change git to default to use atomic pushes and instead
offer an opt-out argument for people that do not want atomic pushes.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/receive-pack.c | 73 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 65d9a7e..27b49dd 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -67,6 +67,8 @@ static const char *NONCE_SLOP = "SLOP";
 static const char *nonce_status;
 static long nonce_stamp_slop;
 static unsigned long nonce_stamp_slop_limit;
+struct strbuf err = STRBUF_INIT;
+struct transaction *transaction;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -832,33 +834,55 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 				cmd->did_not_exist = 1;
 			}
 		}
-		if (delete_ref(namespaced_name, old_sha1, 0)) {
-			rp_error("failed to delete %s", name);
-			return "failed to delete";
+		if (!use_atomic_push) {
+			if (delete_ref(namespaced_name, old_sha1, 0)) {
+				rp_error("failed to delete %s", name);
+				return "failed to delete";
+			}
+		} else {
+			if (transaction_delete_ref(transaction,
+						   namespaced_name,
+						   old_sha1,
+						   0, old_sha1 != NULL,
+						   "push", &err)) {
+				rp_error("%s", err.buf);
+				strbuf_release(&err);
+				return "failed to delete";
+			}
 		}
 		return NULL; /* good */
 	}
 	else {
-		struct strbuf err = STRBUF_INIT;
-		struct transaction *transaction;
-
 		if (shallow_update && si->shallow_ref[cmd->index] &&
 		    update_shallow_ref(cmd, si))
 			return "shallow error";
 
-		transaction = transaction_begin(&err);
-		if (!transaction ||
-		    transaction_update_ref(transaction, namespaced_name,
-					   new_sha1, old_sha1, 0, 1, "push",
-					   &err) ||
-		    transaction_commit(transaction, &err)) {
-			transaction_free(transaction);
+		if (!use_atomic_push) {
+			transaction = transaction_begin(&err);
+			if (!transaction) {
+				rp_error("%s", err.buf);
+				strbuf_release(&err);
+				return "failed to start transaction";
+			}
+		}
+		if (transaction_update_ref(transaction,
+					   namespaced_name,
+					   new_sha1, old_sha1,
+					   0, 1, "push",
+					   &err)) {
 			rp_error("%s", err.buf);
 			strbuf_release(&err);
 			return "failed to update ref";
 		}
-
-		transaction_free(transaction);
+		if (!use_atomic_push) {
+			if (transaction_commit(transaction, &err)) {
+				transaction_free(transaction);
+				rp_error("%s", err.buf);
+				strbuf_release(&err);
+				return "failed to update ref";
+			}
+			transaction_free(transaction);
+		}
 		strbuf_release(&err);
 		return NULL; /* good */
 	}
@@ -1058,6 +1082,16 @@ static void execute_commands(struct command *commands,
 		return;
 	}
 
+	if (use_atomic_push) {
+		transaction = transaction_begin(&err);
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
@@ -1095,6 +1129,14 @@ static void execute_commands(struct command *commands,
 		}
 	}
 
+	if (use_atomic_push) {
+		if (transaction_commit(transaction, &err)) {
+			rp_error("%s", err.buf);
+			for (cmd = commands; cmd; cmd = cmd->next)
+				cmd->error_string = err.buf;
+		}
+		transaction_free(transaction);
+	}
 	if (shallow_update && !checked_connectivity)
 		error("BUG: run 'git fsck' for safety.\n"
 		      "If there are errors, try to remove "
@@ -1542,5 +1584,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	sha1_array_clear(&shallow);
 	sha1_array_clear(&ref);
 	free((void *)push_cert_nonce);
+	strbuf_release(&err);
 	return 0;
 }
-- 
2.1.0.rc2.206.gedb03e5
