From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 3/5] receive-pack.c: use a single transaction when atomic-push is negotiated
Date: Tue, 19 Aug 2014 09:24:49 -0700
Message-ID: <1408465491-25488-4-git-send-email-sahlberg@google.com>
References: <1408465491-25488-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:25:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmDm-0007UR-G2
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbaHSQZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:25:06 -0400
Received: from mail-qg0-f73.google.com ([209.85.192.73]:43193 "EHLO
	mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbaHSQY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:24:56 -0400
Received: by mail-qg0-f73.google.com with SMTP id i50so334574qgf.0
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sOfCyY6ZNdvZ2YBbQv6Brc4Nbkza6CgNS2fCJciYVpk=;
        b=KKYXXeITIVqH2NhnO7KdNMy2p2ISbmeLmb9c2VeV1lFfN4Msuniug6MQFHxUfdIG8W
         gnVpij83jKyoWa8+xH7tbG00i6QgC9njLaIS2HlFVaZon1veam+Oxh2P+6fenp7xHw3s
         CpRbW7o/AMGj7q0NoMMDNj4aig1czOj9wd61YjDh+5HiuvyIGIQsxlykgDru18S4Z5F5
         BptTIjw7j+NePSW3GqWLD2OinPm7wYmo0RmhH6QtvxQJk6f/W3T93VFnJcuVoEmzXihf
         5Y8IdQzWCSUlPGXGAB+dbKGdZ4FzFmNpkOSKJ6vspoD+J2sko+lGUbu++95n0ZxwMcRx
         S1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sOfCyY6ZNdvZ2YBbQv6Brc4Nbkza6CgNS2fCJciYVpk=;
        b=joMRrYFEXLXetOd8z0F149mDq7wOLXt7pcr1bJHWKneZTphFkckpl4OQWUzLzyK9WA
         KdadNndA9jUVuwREE5QIytGDNrIe3cXGdczgo1I/go70xbc77t44RQW9LKFJisHvGlqg
         1ZxhPROuYPT0ynhEdErvNvbeQoGR0bS/OsPK0sbZuReCgRVkYa2byYi5xwjHJ26QKsHb
         M9VMMjb/OlQ98rsbjByyH0e8wlVtIT3xP500iFLEpnCOHNCmQFBx4ypfD9E+9Y43zhzq
         Z1GQ956UcyYWa0zA7gIJozHmbnw8mv9GJvc5ik8rlD7awxUqNBSnOGIgUSUdK6c1j8a3
         Kwbg==
X-Gm-Message-State: ALoCoQnJCk8HshH5B/CU5nH4AtwqqoYC/7RFgOY0CMn4TafTw4lXsRMOuxk64oN/9FrkQduet7OQ
X-Received: by 10.236.65.131 with SMTP id f3mr18729612yhd.8.1408465495280;
        Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id l23si331489yhg.1.2014.08.19.09.24.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 175275A443C;
	Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A3D1CE11B0; Tue, 19 Aug 2014 09:24:54 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.ge8f7cba.dirty
In-Reply-To: <1408465491-25488-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255472>

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
old behaviour we can change git to default to use atomic pushes and instead
offer an opt-out argument for people that do not want atomic pushes.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 Documentation/technical/protocol-capabilities.txt |  7 +++
 builtin/receive-pack.c                            | 55 ++++++++++++++++++-----
 2 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index e174343..93d99c5 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -250,3 +250,10 @@ allow-tip-sha1-in-want
 If the upload-pack server advertises this capability, fetch-pack may
 send "want" lines with SHA-1s that exist at the server but are not
 advertised by upload-pack.
+
+atomic-push
+-----------
+
+If the receive-pack server advertises the 'atomic-push' capability, it means
+that it is capable of accepting atomic pushes. An atomic push is a push
+where the ref updates are done as a single atomic transaction.
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
2.0.1.556.ge8f7cba.dirty
