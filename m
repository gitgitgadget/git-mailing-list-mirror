From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 3/8] receive-pack.c: use a single transaction when atomic-push is negotiated
Date: Tue, 21 Oct 2014 13:46:35 -0700
Message-ID: <1413924400-15418-4-git-send-email-sahlberg@google.com>
References: <1413924400-15418-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:48:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggMN-0005yg-Pg
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933522AbaJUUrC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:47:02 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:59195 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933498AbaJUUqr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:46:47 -0400
Received: by mail-ig0-f202.google.com with SMTP id r2so30270igi.5
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gsszwZnuvcUsiWrbt3vL2TGAcYLuZtBfhkIHjK/3RZY=;
        b=ezQeF9WcuiTeq0R72W23R89NqlYVT2EF1P/WLeVvEp95ozTkN/VojH0VfOikgfuEY6
         FraSYkdl4Ic9BK6vQuMW/wDl1HMRjGatTCq8AyCc0YFKNx7dmYymxeqZvwSk727blLaR
         NfcV9V2EjwNoT852GsJySPKKEs/pfhMj5OnPuETsIURaZN+X++GS59yJydHFbx/jQM4n
         qTsAcpd9YsbrGXjfpyNcw/DxtrHG/ITGbK58FKYVtVRcR2RWEDxrODu1K1qsDWSMPFAM
         EEV58uJ7Hi5w+UkMC8Lhu4iJU9OT/A5l/ENi4ZvSMWxSIJPJ7DsUqfMA/SJwXxz3pajt
         pvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gsszwZnuvcUsiWrbt3vL2TGAcYLuZtBfhkIHjK/3RZY=;
        b=dxwgClcwEFpQ8non0B4FYZllBLT1lWgeqbV5V8ZUFnTMkIIgxv84hF7BHonKD8Sx0G
         zhkeWPsGTiJ8pVH5edwJxOOG99PqCbyrqMD7G10CELDM65i7oysbhuIIqnwO0eU+jOUT
         sOSiwUSB95j8eF7WUV0ve+eegdtGao959cYVL+iy/tFyVmHAmpuBNssEzzCz5iCSOgu2
         LWe40uaHc4zNkwB5eE8e2a7kdXyjCw2rpRYYkzGGXbTs7aUyLU5Zhu5ESNy6ppobaufo
         xTKpVTBArdT0zhlrUXE+umEfYd6fnx1LseL37CGfpJIpwIjGH3BHXGOL44GI8bRwuzjR
         qtsg==
X-Gm-Message-State: ALoCoQkC+oQ4d44ymxozUw4vI+g74I86uLC99wU5By7NJltruQ8HyF0DZJUe3mYz1MKLCR335Q7L
X-Received: by 10.42.203.136 with SMTP id fi8mr516556icb.18.1413924404104;
        Tue, 21 Oct 2014 13:46:44 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id n22si597285yhd.1.2014.10.21.13.46.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:46:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id mLFo6sdn.1; Tue, 21 Oct 2014 13:46:43 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6C340E0A43; Tue, 21 Oct 2014 13:46:43 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
In-Reply-To: <1413924400-15418-1-git-send-email-sahlberg@google.com>
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

Change-Id: Ice9739aa2676f76d2e7fab2d54f37047b2eb277e
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/receive-pack.c | 73 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b8ffd9e..6991d22 100644
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
@@ -827,33 +829,55 @@ static const char *update(struct command *cmd, struct shallow_info *si)
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
@@ -1053,6 +1077,16 @@ static void execute_commands(struct command *commands,
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
@@ -1090,6 +1124,14 @@ static void execute_commands(struct command *commands,
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
@@ -1537,5 +1579,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	sha1_array_clear(&shallow);
 	sha1_array_clear(&ref);
 	free((void *)push_cert_nonce);
+	strbuf_release(&err);
 	return 0;
 }
-- 
2.1.0.rc2.206.gedb03e5
