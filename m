From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 32/48] receive-pack.c: use a reference transaction for updating the refs
Date: Thu, 12 Jun 2014 10:21:23 -0700
Message-ID: <1402593699-13983-33-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:23:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8ia-00087X-Bu
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933585AbaFLRXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:23:01 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:44773 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756263AbaFLRVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:45 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so245434qcz.2
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nkkR+lEKh+zQoie/udN503DgSAAt7AMpkDVZg6+JBmg=;
        b=FKKH8EwRiGrQquOkXtJMTQbSrqtEQZJhNJfEn0lRWoF3ifRQvhISVy/tOP7XdSTWF2
         8bzUfQkykR3rPCxbIn0iUbwhXojZfR61caU6RngPUoBzUfb9a0Oiqo7P79sRsExCR6jC
         /Wdt5c/5sD5JA7EzT+wCVdouFRzvlr2T+TIkGUz9xbUyJpQJ2TY3H7mXnolx0k/My3I1
         9dAXcvUJdA1hhGYQVO8NNoltUgbpzRjPU2q/agWsraK7ELoERvNgPGyHTmfMpisI+C5H
         pCQQDY4Oa+D6xXTmiGTetfxRlpyR9YOdX6WS+5NQMTRGIQmew5y88wV7m55ugds0nO1T
         2oFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nkkR+lEKh+zQoie/udN503DgSAAt7AMpkDVZg6+JBmg=;
        b=VyqPjBOxsjfHL1pYcard33dc5w73Ml/Q/j+tvXwUwDB+qRXu3sbASpRyoK2W3BAfsq
         201Spw1YHthTGxTaUGwXRPBlbpdEZpo+lPSkYogU6lxRssbJIei0yeWu5eDRZaDvcWVg
         AgyQ8XYrFZGpGc/a/Opq6Zhq5VRWzJFB6cYPYbZURp8Agjz1y6TlluVNfdxnF7CBarBE
         DfQZz2ES6DSNn80lEV9yNnpwnmfouBfPgGyFHxKEdq10A+Z/kHqgHj4TsMXdWpkQLLKh
         8QtNl91JxkIHxDFq/+gMw7fJnOGdVWUD21eNr5f7U9R1KPEHPabg7s2QnShymgrRUdPc
         qwUQ==
X-Gm-Message-State: ALoCoQnjeLt1WnhItYNlAoyz0aYCs6jSCT2dlb9Ac0MAhUEyagl3Kcun94IQ0Ztcye5QgMBQKSCm
X-Received: by 10.58.69.49 with SMTP id b17mr14205010veu.26.1402593704409;
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si113017yhb.3.2014.06.12.10.21.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 4283731C65C;
	Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D1198E0961; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251442>

Wrap all the ref updates inside a transaction.
Free commands when we are finished with them instead of leaking.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/receive-pack.c | 74 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 22 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c323081..2724a86 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -194,7 +194,7 @@ static void write_head_info(void)
 
 struct command {
 	struct command *next;
-	const char *error_string;
+	char *error_string;
 	unsigned int skip_update:1,
 		     did_not_exist:1;
 	int index;
@@ -468,14 +468,13 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	return 0;
 }
 
-static const char *update(struct command *cmd, struct shallow_info *si)
+static char *update(struct command *cmd, struct shallow_info *si)
 {
 	const char *name = cmd->ref_name;
 	struct strbuf namespaced_name_buf = STRBUF_INIT;
 	const char *namespaced_name;
 	unsigned char *old_sha1 = cmd->old_sha1;
 	unsigned char *new_sha1 = cmd->new_sha1;
-	struct ref_lock *lock;
 
 	/* only refs/... are allowed */
 	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
@@ -576,19 +575,27 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		return NULL; /* good */
 	}
 	else {
+		struct strbuf err = STRBUF_INIT;
+		struct ref_transaction *transaction;
+
 		if (shallow_update && si->shallow_ref[cmd->index] &&
 		    update_shallow_ref(cmd, si))
 			return "shallow error";
 
-		lock = lock_any_ref_for_update(namespaced_name, old_sha1,
-					       0, NULL);
-		if (!lock) {
-			rp_error("failed to lock %s", name);
-			return "failed to lock";
-		}
-		if (write_ref_sha1(lock, new_sha1, "push")) {
-			return "failed to write"; /* error() already called */
+		transaction = ref_transaction_begin(&err);
+		if (!transaction ||
+		    ref_transaction_update(transaction, namespaced_name,
+					   new_sha1, old_sha1, 0, 1, &err) ||
+		    ref_transaction_commit(transaction, "push", &err)) {
+			char *str = strbuf_detach(&err, NULL);
+			ref_transaction_free(transaction);
+
+			rp_error("%s", str);
+			return str;
 		}
+
+		ref_transaction_free(transaction);
+		strbuf_release(&err);
 		return NULL; /* good */
 	}
 }
@@ -647,6 +654,9 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 	char cmd_oldh[41], cmd_newh[41], dst_oldh[41], dst_newh[41];
 	int flag;
 
+	if (cmd->error_string)
+		die("BUG: check_alised_update called with failed cmd");
+
 	strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
 	dst_name = resolve_ref_unsafe(buf.buf, sha1, 0, &flag);
 	strbuf_release(&buf);
@@ -658,7 +668,7 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 	if (!dst_name) {
 		rp_error("refusing update to broken symref '%s'", cmd->ref_name);
 		cmd->skip_update = 1;
-		cmd->error_string = "broken symref";
+		cmd->error_string = xstrdup("broken symref");
 		return;
 	}
 
@@ -684,8 +694,9 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 		 cmd->ref_name, cmd_oldh, cmd_newh,
 		 dst_cmd->ref_name, dst_oldh, dst_newh);
 
-	cmd->error_string = dst_cmd->error_string =
-		"inconsistent aliased update";
+	cmd->error_string = xstrdup("inconsistent aliased update");
+	free(dst_cmd->error_string);
+	dst_cmd->error_string = xstrdup("inconsistent aliased update");
 }
 
 static void check_aliased_updates(struct command *commands)
@@ -733,7 +744,9 @@ static void set_connectivity_errors(struct command *commands,
 		if (!check_everything_connected(command_singleton_iterator,
 						0, &singleton))
 			continue;
-		cmd->error_string = "missing necessary objects";
+		if (cmd->error_string)  /* can't happen */
+			continue;
+		cmd->error_string = xstrdup("missing necessary objects");
 	}
 }
 
@@ -770,9 +783,9 @@ static void reject_updates_to_hidden(struct command *commands)
 		if (cmd->error_string || !ref_is_hidden(cmd->ref_name))
 			continue;
 		if (is_null_sha1(cmd->new_sha1))
-			cmd->error_string = "deny deleting a hidden ref";
+			cmd->error_string = xstrdup("deny deleting a hidden ref");
 		else
-			cmd->error_string = "deny updating a hidden ref";
+			cmd->error_string = xstrdup("deny updating a hidden ref");
 	}
 }
 
@@ -786,8 +799,11 @@ static void execute_commands(struct command *commands,
 	struct iterate_data data;
 
 	if (unpacker_error) {
-		for (cmd = commands; cmd; cmd = cmd->next)
-			cmd->error_string = "unpacker error";
+		for (cmd = commands; cmd; cmd = cmd->next) {
+			if (cmd->error_string)  /* can't happen */
+				continue;
+			cmd->error_string = xstrdup("unpacker error");
+		}
 		return;
 	}
 
@@ -800,8 +816,9 @@ static void execute_commands(struct command *commands,
 
 	if (run_receive_hook(commands, "pre-receive", 0)) {
 		for (cmd = commands; cmd; cmd = cmd->next) {
-			if (!cmd->error_string)
-				cmd->error_string = "pre-receive hook declined";
+			if (cmd->error_string)
+				continue;
+			cmd->error_string = xstrdup("pre-receive hook declined");
 		}
 		return;
 	}
@@ -1079,7 +1096,8 @@ static void update_shallow_info(struct command *commands,
 		if (is_null_sha1(cmd->new_sha1))
 			continue;
 		if (ref_status[cmd->index]) {
-			cmd->error_string = "shallow update not allowed";
+			free(cmd->error_string);
+			cmd->error_string = xstrdup("shallow update not allowed");
 			cmd->skip_update = 1;
 		}
 	}
@@ -1120,6 +1138,17 @@ static int delete_only(struct command *commands)
 	return 1;
 }
 
+static void free_commands(struct command *commands)
+{
+	while (commands) {
+		struct command *next = commands->next;
+
+		free(commands->error_string);
+		free(commands);
+		commands = next;
+	}
+}
+
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
 	int advertise_refs = 0;
@@ -1210,6 +1239,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		if (auto_update_server_info)
 			update_server_info(0);
 		clear_shallow_info(&si);
+		free_commands(commands);
 	}
 	if (use_sideband)
 		packet_flush(1);
-- 
2.0.0.599.g83ced0e
