From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 3/7] receive-pack.c: use a single transaction when atomic-push is negotiated
Date: Fri,  7 Nov 2014 11:41:57 -0800
Message-ID: <1415389321-10386-4-git-send-email-sahlberg@google.com>
References: <1415389321-10386-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 20:42:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpQO-00074p-JY
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbaKGTmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:42:14 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:39022 "EHLO
	mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255AbaKGTmG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:42:06 -0500
Received: by mail-oi0-f74.google.com with SMTP id u20so544472oif.1
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 11:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8+ftS1SyBzyfop/ZPV8HmtRM52dFhfmMIJuZsB82Ug4=;
        b=amNTZmt0+LX+ByBylztuQ0gIz/B81qlSUFh0tPlY1Cmdibshw0Cr8M/Ha+DYq1Bi4O
         CsnlYEOHeiJROPI3vJETOlJixu6X6g5yQFfFH6MDdZZsQxyqB52I1um3QY2oYsjYH/eh
         I1xVq1v/GtzIygWdEatIMc9bmlQF6j6PvF6NleAL/Ntqt3xfnHT59tW+amIXyzS4du87
         PNimW9/Aw2WHdsi7gdb7+GSFcwa6LHyhgpS2S9zbc05cYd36txZegONKrGUgaa9xDpNk
         27gVLoiUXjUR/aGmJXZWFLTm4jDmoO3Q2b1CDdE16S+vJx9XciqUlkRqicLsmOXThDUs
         TnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8+ftS1SyBzyfop/ZPV8HmtRM52dFhfmMIJuZsB82Ug4=;
        b=j1onw/0XyM/izonRAYaDBXp7R99DXX9rL6ceVrjtL06YQ3rV3fdsP8BI6UJC5kZB7R
         b+W+Anr10yWgSg8upoSvWpC4AbfA17meNEJqwZrE1dkLSqiIx8hsyIX9daX2RlqnBliT
         6JbfkPlZ0OjmooLvb3CbPUubVPI0V+RmXnWTVNc6Jw2NvOeB+m5Cv7rocXHYB8vDcBf4
         iLtwv8htd6ZbOd2B/x5SFZ4SKFfTWSp0a9MVez8OHX9rZxBmuxcdYpZIVUkgCx9l1U2t
         gfQI32VVgl2fqNuhUoQg41fAKAAT8fzmHxfKat8Omaslwl71Qd5hXBla0Op0enp8XBN8
         TbMA==
X-Gm-Message-State: ALoCoQnFaAYG4q1bAZg6zb2ibwPu9BfVRyv6qnDsEuvrrt/4vdu9bcokmgYXSk1SPICxvz8FSPlZ
X-Received: by 10.182.70.69 with SMTP id k5mr10148074obu.2.1415389325184;
        Fri, 07 Nov 2014 11:42:05 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id l45si403931yha.2.2014.11.07.11.42.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 11:42:05 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id FQX6VuLu.1; Fri, 07 Nov 2014 11:42:05 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D84B3E07F8; Fri,  7 Nov 2014 11:42:03 -0800 (PST)
X-Mailer: git-send-email 2.1.2.810.gfbd2bf7.dirty
In-Reply-To: <1415389321-10386-1-git-send-email-sahlberg@google.com>
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
