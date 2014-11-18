From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 3/7] receive-pack.c: use a single transaction when atomic-push is negotiated
Date: Mon, 17 Nov 2014 18:00:36 -0800
Message-ID: <1416276040-5303-4-git-send-email-sbeller@google.com>
References: <1416276040-5303-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 03:01:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqY6L-0000v6-GJ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 03:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbaKRCAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 21:00:50 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:41688 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660AbaKRCAs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 21:00:48 -0500
Received: by mail-ie0-f170.google.com with SMTP id tr6so4206622ieb.15
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 18:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sDVGqSamEzPn7UJkYqRifZoVfGk89F7DRK5y44Suo6c=;
        b=Ulx/1UoGPakvJH3TKzdJKm/WbGrwU2iJLR5kfhog9v2tvLL+O4F4ZcqTKD4omIuhre
         TB7dqjot7zVq5YDV5kzGX/lNedv0AU/yHIf6mKibZAHqkmL9VTAP9M9S/780XuiE8Eim
         6+/rls01RuQnsY5z5K7ID9jlCu1LCuCFQBsq9j+gemSkt60I3yoZ0Io2Dd2zw9zHqxpD
         KgNxSDXU689G9NvYgVNWCi01dK7DW7XO694jaXZu4tYqFpOizsdGtUw8QRUEIk60DzEd
         ZkFCrLCG9Gq0s0NawOhDAyguEwB0D0ZetO0ArQ8EYt1YsV3RzhqEMKuzv7Ht38x+rPXg
         FGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sDVGqSamEzPn7UJkYqRifZoVfGk89F7DRK5y44Suo6c=;
        b=BQc/lbgancBW5P6qSebO/Q0Gowzh8HoUIDzLvoKj6QXjfKWy2hHR5EmWCnyDzN0gO0
         20vR1iwsKQ+uylFxjQO7VTC03hZipIV7gMN4EEqpRrn4hPYVknFmOpZFvRC0gRrvwdgo
         ZJA5yB3tgdlbH6d584QqDLHVNQ+Ub+LuVHmL46W/h50/XqjffC+E20Jt4YOByrwb9gjO
         3J88FFWaGpQU3u29xK2vNYFwyaizSAfFjg29+jjRnaBuNqnXRKtyEwBHCTLmHfRsrrcC
         OrMkeF3MpQaLzOEay6YSti3lj2VsytdDc4a+dInI3Y9K5H3GEvM7XaMN0KS9tUGDVsrQ
         ZwxQ==
X-Gm-Message-State: ALoCoQkRqmj7bFA7rhOfzs9KymX1K0Z1s8ufEj1x3yReDEqZG71Zf4fGHh+DomnqLFxcBzrJGcde
X-Received: by 10.42.128.81 with SMTP id l17mr31490961ics.8.1416276047246;
        Mon, 17 Nov 2014 18:00:47 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id 3sm7792657ion.37.2014.11.17.18.00.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 18:00:46 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416276040-5303-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

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
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/receive-pack.c | 73 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 63acebf..aa43a5e 100644
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
2.2.0.rc2.5.gf7b9fb2
