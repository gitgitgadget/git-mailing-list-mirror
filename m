From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/5] receive-pack.c: use a single ref_transaction for atomic pushes
Date: Mon, 15 Dec 2014 11:56:06 -0800
Message-ID: <1418673368-20785-4-git-send-email-sbeller@google.com>
References: <1418673368-20785-1-git-send-email-sbeller@google.com>
Cc: mhagger@alum.mit.edu, jrnieder@gmail.com, gitster@pobox.com,
	ronniesahlberg@gmail.com, Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 20:56:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0bkv-00021J-1m
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 20:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbaLOT4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 14:56:24 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:61673 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbaLOT4X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 14:56:23 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so11513400iec.30
        for <git@vger.kernel.org>; Mon, 15 Dec 2014 11:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MCupYEsFzlXvLIDAHA+7gHscNZVrSrBC7LjRngVBe/A=;
        b=PV5smWmPANWNw0n88q1zYhkBFY6SRTCGTEYrhq0Moypen/ub9EYranqrZTYkF7D4Df
         fLGiOQsLB6s00G/SYfZZc95vyScdzra1IB7fmWYybsIkrPJip5jNY5e11D8UZK1TLD3W
         NsL3ttGGNiUL+4mBeQ3FmCw21bTtacoofNfBKaeAnWaAU7e/daglIziM6E1MjemOgVlP
         keaRis7o0scp4HWdPGYU7UEG5lB1BiWPgdiseS6ulScpxjwv+dNwh4oYzAYnwdmFRqai
         6peiiQFpAL1e7XFjhMOsDFt5oBiJHsVDWrEFDDVmeu4a8UrCjB8In7mGRoHQ0AgKUPlP
         Jg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MCupYEsFzlXvLIDAHA+7gHscNZVrSrBC7LjRngVBe/A=;
        b=iogiMDJkVSPBK/X1kb3sxt/XPV9oBuqpnCMDNhPO+ALsD385LtVNIryAjywURLuk0J
         Ecj15IkU0wYAUrlVDcllPeUbENxgTGdSlZcaKaepufvamciJumUfzTTcm/tBiqmABAXn
         0N578lmba7KTUgxZZzIs4/57r6IJyiTcKtZcVvlqou6Glk8Fpi1c9R0S81ifs/t6ApiM
         711x4CFv1RWIleMGHll7s/Y7iZ4VJuwhxb66ARx08swz1uf7xAoo1m1gVsiPfftx/n+S
         eSHxA3+1eh52qRU6Rua/LqhQPqz8WtyHKXB9tFn+GweRJVGtF3qE60dfcl8t8/MxT56I
         oP7w==
X-Gm-Message-State: ALoCoQlWYUvusCe2X6CrLXH1h1Nyauw89fphjat0LgC+wW4c6p8J1L+vSDn7KPbxIgpSdpyblqxL
X-Received: by 10.107.17.169 with SMTP id 41mr29560092ior.90.1418673382382;
        Mon, 15 Dec 2014 11:56:22 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:ccd:69a0:9bbf:bab9])
        by mx.google.com with ESMTPSA id ao5sm5342508igc.3.2014.12.15.11.56.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Dec 2014 11:56:21 -0800 (PST)
X-Mailer: git-send-email 2.2.0.33.gc2219e3.dirty
In-Reply-To: <1418673368-20785-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261415>

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
 builtin/receive-pack.c | 73 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0c642ab..e6cf174 100644
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
@@ -832,34 +834,56 @@ static const char *update(struct command *cmd, struct shallow_info *si)
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
+			if (ref_transaction_delete(transaction,
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
+		if (!use_atomic_push) {
+			transaction = ref_transaction_begin(&err);
+			if (!transaction) {
+				rp_error("%s", err.buf);
+				strbuf_release(&err);
+				return "failed to start transaction";
+			}
+		}
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
+		if (!use_atomic_push) {
+			if (ref_transaction_commit(transaction, &err)) {
+				ref_transaction_free(transaction);
+				rp_error("%s", err.buf);
+				strbuf_release(&err);
+				return "failed to update ref";
+			}
+			ref_transaction_free(transaction);
+		}
 		strbuf_release(&err);
 		return NULL; /* good */
 	}
@@ -1059,6 +1083,16 @@ static void execute_commands(struct command *commands,
 		return;
 	}
 
+	if (use_atomic_push) {
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
@@ -1096,6 +1130,14 @@ static void execute_commands(struct command *commands,
 		}
 	}
 
+	if (use_atomic_push) {
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
@@ -1543,5 +1585,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	sha1_array_clear(&shallow);
 	sha1_array_clear(&ref);
 	free((void *)push_cert_nonce);
+	strbuf_release(&err);
 	return 0;
 }
-- 
2.2.0.33.gc2219e3.dirty
