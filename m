From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 5/9] receive-pack.c: move transaction handling in a central place
Date: Mon, 29 Dec 2014 13:35:11 -0800
Message-ID: <1419888915-31760-6-git-send-email-sbeller@google.com>
References: <1419888915-31760-1-git-send-email-sbeller@google.com>
Cc: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 22:35:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5hyY-0001f8-6q
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 22:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576AbaL2Vfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 16:35:38 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:49426 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbaL2Vf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 16:35:28 -0500
Received: by mail-ig0-f182.google.com with SMTP id hn15so11876059igb.9
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 13:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0tJC71UcYZUFJhKAO//ReMEx6endZQtZE36zg3UkdUc=;
        b=ZpRGZZVLEzaoIzaf9VQzMBSc6fnboj8UWs28NpKitkBaZWVTI+ZTm+NAA3bqG4hsUT
         TIA0Exv0d8wrwvWu1cxEE4N9QC/x5pATjayRb3MjfTCUOCBbANZdN/SyEYyeEgpuyv5A
         298tDMZCgFJPARyNCGV8RrEBGwOBncOPYgf/hfyhoLnzWk9J8HDzXQCSiSUsDaqodvlX
         FESiVg+gJTH5wgForh76YpSagDK+1EdBZFvQ8KOrXokVmPZ0k2JtUDD/k2rHvzmOcWRm
         TDrOWT7uPy37/GMmkfHsY0yiTKu7bYHal2yuItcBWmJM3o0K6kQBmId+Noqy1WsyKuIW
         Vs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0tJC71UcYZUFJhKAO//ReMEx6endZQtZE36zg3UkdUc=;
        b=MvfVbJY6DePDp+LE2TL6nxXgZei/V8iYepGs/FG/QMpIQaQ6T5LbpLHp4ooNjnWAtK
         gC87I4iSpkqBgkRibcE7+V2gftlNZHBtdUU05lV6EWnNRYyFH1JlQzTznTwKYVx234YY
         1boqlHNONyCOVudK9ymIObZ9V0n46kKuWWqR5w6J12wmC2vkpvdClZ7ZLvZ2Q6i7EL16
         lQo/gH++uvZoXCPpC96JJXZFlq4hzb2bIa/vDLsLMMjljfxgOWeXBYIMsd9aueJUOJun
         fpe14fNjQfcnAgElY6nzrZTonR3BwRIzJJIvac9s1jwbQsBjLeHC2Fzw8SJzJHDplFlw
         NR9w==
X-Gm-Message-State: ALoCoQnLVlyoy+8fWtS8IGO/ZlwneCoaZjaU7kQX46qAIzCsSQFc8fkbDoY44fb1l6xAt7teUjLf
X-Received: by 10.107.169.170 with SMTP id f42mr51757182ioj.24.1419888928048;
        Mon, 29 Dec 2014 13:35:28 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5860:dcf1:88a4:141b])
        by mx.google.com with ESMTPSA id e63sm18194659ioe.15.2014.12.29.13.35.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Dec 2014 13:35:27 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419888915-31760-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261886>

No functional changes intended.
This moves all code related to transactions into the execute_commands_loop
function which was factored out of execute_commands. This includes
beginning and committing the transaction as well as dealing with the
errors which may occur during the begin and commit phase of a transaction.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v7:
     new in v7, this is part of the previous "[PATCH 4/7]
     receive-pack.c: receive-pack.c: use a single ref_transaction for atomic pushes"
    
    This covers the suggestion of patch 2 and 3 by Eric
    > patch 2: Factor out the main 'for' loop of execute_commands() into a
    > new function. This new function will eventually become
    > execute_commands_non_atomic(). At this point, execute_commands() is
    > pretty much in its final form with the exception of the upcoming 'if
    > (use_atomic)' conditional.
    > patch 3: Morph the function extracted in patch 2 into
    > execute_commands_non_atomic() by adding transaction handling inside
    > the 'for' loop (and applying the changes from the early part of the
    > patch which go along with that).

 builtin/receive-pack.c | 62 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 06eb287..915ad3c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -67,6 +67,7 @@ static const char *NONCE_SLOP = "SLOP";
 static const char *nonce_status;
 static long nonce_stamp_slop;
 static unsigned long nonce_stamp_slop_limit;
+static struct ref_transaction *transaction;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -822,6 +823,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	}
 
 	if (is_null_sha1(new_sha1)) {
+		struct strbuf err = STRBUF_INIT;
 		if (!parse_object(old_sha1)) {
 			old_sha1 = NULL;
 			if (ref_exists(name)) {
@@ -831,35 +833,36 @@ static const char *update(struct command *cmd, struct shallow_info *si)
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
@@ -1107,13 +1110,42 @@ static void execute_commands(struct command *commands,
 	free(head_name_to_free);
 	head_name = head_name_to_free = resolve_refdup("HEAD", 0, sha1, NULL);
 
+	execute_commands_loop(commands, si);
+
+	check_shallow_bugs(commands, si);
+}
+
+static void execute_commands_loop(struct command *commands,
+				  struct shallow_info *si)
+{
+	struct command *cmd;
+	struct strbuf err = STRBUF_INIT;
+
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (!should_process_cmd(cmd))
 			continue;
 
+		transaction = ref_transaction_begin(&err);
+		if (!transaction) {
+			rp_error("%s", err.buf);
+			strbuf_reset(&err);
+			cmd->error_string = "transaction failed to start";
+			continue;
+		}
+
 		cmd->error_string = update(cmd, si);
+
+		if (!cmd->error_string
+		    || ref_transaction_commit(transaction, &err)) {
+			rp_error("%s", err.buf);
+			strbuf_reset(&err);
+			cmd->error_string = "failed to update ref";
+		}
+		ref_transaction_free(transaction);
 	}
-	check_shallow_bugs(commands, si);
+
+	}
+	strbuf_release(&err);
 }
 
 static struct command **queue_command(struct command **tail,
-- 
2.2.1.62.g3f15098
