From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 3/5] receive-pack.c: use a single transaction when atomic-push is negotiated
Date: Thu, 31 Jul 2014 14:39:09 -0700
Message-ID: <1406842751-6657-4-git-send-email-sahlberg@google.com>
References: <1406842751-6657-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 23:39:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCy4U-0005Ge-Eu
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 23:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbaGaVjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 17:39:22 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:39556 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbaGaVjP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 17:39:15 -0400
Received: by mail-vc0-f201.google.com with SMTP id le20so447086vcb.0
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=whhSQH+Y2q4pPyQ2mhubE29Il8Q84snWeH3XPwhyF6o=;
        b=ED5H6OJnhEVLjdZEAvvYq8kggkXDWn2y+6Fy22AYlJuqR2pth2VJBpy4gzY6gocST2
         uPSAfse0uTGR9GNHJ1NVO9pbEQ63wjCPv5ECEfhnWs3XY6JCQ1dmbPuPayrZKmgNiozb
         tIA8We84Ds33Djir8ywvVNjWBGlajXqRurDS+FB5RlkbaoO4H8JcluEY70mBbhoiMavh
         Tlh8hRVNJ2FdqARHhz8Gher98X1jvuXSRGtXdqZTZ42jcBQWw7UU+xXSCQEIQZNHofqG
         /dXR5+0MNf/5CmiBf5VdO7/ed4LhnEorbStbnqaD/POX71gFW29n58J7rRPZFNQsYDxi
         ze0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=whhSQH+Y2q4pPyQ2mhubE29Il8Q84snWeH3XPwhyF6o=;
        b=nDpTwgrbuLFyR2i44hiTp9+/Ch7whVFAr1ouaCqD8nyPvYKrx3HkGk8ISebGZWt1mE
         KthqTxx6Vz3Oqa55isy6+07aRccnuorGt2kfCGKEnsUZIpOmrNCoHjX8w4EQ1VIeRPTN
         ReM7lXj4xsQ7x8ACx3L/hX90A5lAQKYMR7FPiF55zvbHS3bJHcZAiw04/H+/xrCPoM82
         +yEGt7n1c8V3zrYfMgHESxWV2sEH0sK8EcJ+j1Ye7j5yuE4+ojHxikIIkwOVoYbrjkvD
         1t3HINJuR3s6IhYNbM3SQpXVqNsvxfKd3ZvFvN5SL+2Md0dUWm7PqBQEN+keqVoovVyb
         zVjA==
X-Gm-Message-State: ALoCoQmwSQDuLW3CkcWtATqtcaoVq4giCUsITE5Xy6alxPTFmjfNBmxxVGpexrOILQisLeM2Bcuz
X-Received: by 10.236.171.234 with SMTP id r70mr385065yhl.45.1406842754508;
        Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si423231yhb.3.2014.07.31.14.39.14
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3CCD131C611;
	Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DECD3E0528; Thu, 31 Jul 2014 14:39:13 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.528.gd0e7a84
In-Reply-To: <1406842751-6657-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254611>

Update receive-pack to use an atomic transaction IFF the client negotiated
that it wanted atomic-push.
This leaves the default behaviour to be the old non-atomic one ref at a
time update. This is to cause as little disruption as possible to existing
clients. It is unknown if there are client scripts that depend on the old
non-atomic behaviour so we make it opt-in for now.

Later patch in this series also adds a configuration variable where you can
override the atomic push behaviour on the receiving repo and force it
to use atomic updates always.

If it turns out over time that there are no client scripts that depend on the
old behaviour we can change git to default to use atomic pushes by default
and instead offer an opt-out argument for people that do not want atomic
updates at all.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/receive-pack.c | 55 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index f6b20cb..47f778d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -47,6 +47,8 @@ static void *head_name_to_free;
 static int sent_capabilities;
 static int shallow_update;
 static const char *alt_shallow_file;
+struct strbuf err = STRBUF_INIT;
+struct ref_transaction *transaction;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -577,26 +579,38 @@ static char *update(struct command *cmd, struct shallow_info *si)
 		return NULL; /* good */
 	}
 	else {
-		struct strbuf err = STRBUF_INIT;
-		struct ref_transaction *transaction;
-
 		if (shallow_update && si->shallow_ref[cmd->index] &&
 		    update_shallow_ref(cmd, si))
 			return xstrdup("shallow error");
-
-		transaction = transaction_begin(&err);
-		if (!transaction ||
-		    transaction_update_sha1(transaction, namespaced_name,
+		if (!use_atomic_push) {
+			transaction = transaction_begin(&err);
+			if (!transaction) {
+				char *str = xstrdup(err.buf);
+
+				strbuf_release(&err);
+				transaction_free(transaction);
+				rp_error("%s", str);
+				return str;
+			}
+		}
+		if (transaction_update_sha1(transaction, namespaced_name,
 					    new_sha1, old_sha1, 0, 1, "push",
-					    &err) ||
-		    transaction_commit(transaction, &err)) {
-			char *str = strbuf_detach(&err, NULL);
-			transaction_free(transaction);
+					    &err)) {
+			char *str = xstrdup(err.buf);
 
+			strbuf_release(&err);
+			transaction_free(transaction);
 			rp_error("%s", str);
 			return str;
 		}
+		if (!use_atomic_push && transaction_commit(transaction, &err)) {
+			char *str = xstrdup(err.buf);
 
+			strbuf_release(&err);
+			transaction_free(transaction);
+			rp_error("%s", str);
+			return str;
+		}
 		transaction_free(transaction);
 		strbuf_release(&err);
 		return NULL; /* good */
@@ -810,6 +824,16 @@ static void execute_commands(struct command *commands,
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
@@ -848,6 +872,14 @@ static void execute_commands(struct command *commands,
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
@@ -1250,5 +1282,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	sha1_array_clear(&shallow);
 	sha1_array_clear(&ref);
 	free_commands(commands);
+	strbuf_release(&err);
 	return 0;
 }
-- 
2.0.1.528.gd0e7a84
