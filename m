From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 31/48] receive-pack.c: use a reference transaction for updating the refs
Date: Thu, 19 Jun 2014 08:53:13 -0700
Message-ID: <1403193210-6028-32-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:55:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxegU-0008C6-9Q
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933377AbaFSPy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:54:56 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:36413 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758053AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-yh0-f74.google.com with SMTP id b6so330552yha.3
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a6QeebRFNgHbiisq8uMjttkr6AspZ3Yc537dD8LItGc=;
        b=csw9aff+fjPoF0IWmgSIiJt/S6UQ4Pct59tHOxLeL01TNA77aVLS2fJPSbLIgkwldq
         DefjKorE4GkO9+7lbJ6gN8ojeJs2l1o2FNSDLVZSBOowVuXQZu9hRN9i1sWhV1Ds3lMG
         oeHv+0hMqvtay/OKZqOSlSZjOOXp1s5ghoAfyGcw28Pl/LPLq4Q4iKe5UXmgZ30l8bRA
         OpOyVQ5fJJPrmzJk9GsLMddhA3XJDeDQDqNXG08Rwf0CXxRiyNUvMGsxP3RpRbHs5vRZ
         8wvDSj3dRV/h/EMSLstj6fsp9lQPe/gbYC5GtRA+okiQhVoTMuaNYegmshjbzqYp7mZv
         okSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a6QeebRFNgHbiisq8uMjttkr6AspZ3Yc537dD8LItGc=;
        b=Lyu14GG/c/ylasKJa3RCZuVvkJDZsrxA4F40aY0JEwr+7pwa861w/Zoc4hs2+51iV3
         nOJxOfOhdLvBoD5w/90AybIiao1wSb8v82Q3lX6e2WqQk97eRA8ItbOdD4sSwNlhG65e
         mzhoDNOiJlS9vNgQzQ/IO+DSRJDAnlNHUSB/gNZTq17VUyBwmzVqFpmhJ8uUcQqmr17G
         xiTM+LCEM8D6vnM/IxVfmdCneR8ubQG3n92ta3J5AK7psBQcLsfN/UXpjMOibGsacIc4
         YX5UBi59gEdi/+M3rzelK64tL2RSFIGcgnkaU/2UykioWHzkF+J2wNfUJ6M15DVyIo9T
         gFpg==
X-Gm-Message-State: ALoCoQkfumoj4ZXbxOfGA26lB6CzSBwR5qIcTX98ZwxrQV30+SINZFsU9UkC8ewffUSTpwTzg7tA
X-Received: by 10.236.184.72 with SMTP id r48mr2308264yhm.13.1403193213892;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id t4si421021yhm.0.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id AEC505A4552;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8D61CE115F; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252140>

Wrap all the ref updates inside a transaction.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/receive-pack.c | 96 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 33 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c323081..b51f8ae 100644
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
@@ -468,19 +468,18 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
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
 		rp_error("refusing to create funny ref '%s' remotely", name);
-		return "funny refname";
+		return xstrdup("funny refname");
 	}
 
 	strbuf_addf(&namespaced_name_buf, "%s%s", get_git_namespace(), name);
@@ -498,20 +497,20 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 			rp_error("refusing to update checked out branch: %s", name);
 			if (deny_current_branch == DENY_UNCONFIGURED)
 				refuse_unconfigured_deny();
-			return "branch is currently checked out";
+			return xstrdup("branch is currently checked out");
 		}
 	}
 
 	if (!is_null_sha1(new_sha1) && !has_sha1_file(new_sha1)) {
 		error("unpack should have generated %s, "
 		      "but I can't find it!", sha1_to_hex(new_sha1));
-		return "bad pack";
+		return xstrdup("bad pack");
 	}
 
 	if (!is_null_sha1(old_sha1) && is_null_sha1(new_sha1)) {
 		if (deny_deletes && starts_with(name, "refs/heads/")) {
 			rp_error("denying ref deletion for %s", name);
-			return "deletion prohibited";
+			return xstrdup("deletion prohibited");
 		}
 
 		if (!strcmp(namespaced_name, head_name)) {
@@ -526,7 +525,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 				if (deny_delete_current == DENY_UNCONFIGURED)
 					refuse_unconfigured_deny_delete_current();
 				rp_error("refusing to delete the current branch: %s", name);
-				return "deletion of the current branch prohibited";
+				return xstrdup("deletion of the current branch prohibited");
 			}
 		}
 	}
@@ -544,19 +543,19 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		    old_object->type != OBJ_COMMIT ||
 		    new_object->type != OBJ_COMMIT) {
 			error("bad sha1 objects for %s", name);
-			return "bad ref";
+			return xstrdup("bad ref");
 		}
 		old_commit = (struct commit *)old_object;
 		new_commit = (struct commit *)new_object;
 		if (!in_merge_bases(old_commit, new_commit)) {
 			rp_error("denying non-fast-forward %s"
 				 " (you should pull first)", name);
-			return "non-fast-forward";
+			return xstrdup("non-fast-forward");
 		}
 	}
 	if (run_update_hook(cmd)) {
 		rp_error("hook declined to update %s", name);
-		return "hook declined";
+		return xstrdup("hook declined");
 	}
 
 	if (is_null_sha1(new_sha1)) {
@@ -571,24 +570,32 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		}
 		if (delete_ref(namespaced_name, old_sha1, 0)) {
 			rp_error("failed to delete %s", name);
-			return "failed to delete";
+			return xstrdup("failed to delete");
 		}
 		return NULL; /* good */
 	}
 	else {
+		struct strbuf err = STRBUF_INIT;
+		struct ref_transaction *transaction;
+
 		if (shallow_update && si->shallow_ref[cmd->index] &&
 		    update_shallow_ref(cmd, si))
-			return "shallow error";
-
-		lock = lock_any_ref_for_update(namespaced_name, old_sha1,
-					       0, NULL);
-		if (!lock) {
-			rp_error("failed to lock %s", name);
-			return "failed to lock";
-		}
-		if (write_ref_sha1(lock, new_sha1, "push")) {
-			return "failed to write"; /* error() already called */
+			return xstrdup("shallow error");
+
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
@@ -1215,5 +1244,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		packet_flush(1);
 	sha1_array_clear(&shallow);
 	sha1_array_clear(&ref);
+	free_commands(commands);
 	return 0;
 }
-- 
2.0.0.438.g337c581
