From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/6] receive-pack: receive.denyDeleteCurrent
Date: Mon,  9 Feb 2009 01:09:22 -0800
Message-ID: <1234170565-6740-4-git-send-email-gitster@pobox.com>
References: <1234170565-6740-1-git-send-email-gitster@pobox.com>
 <1234170565-6740-2-git-send-email-gitster@pobox.com>
 <1234170565-6740-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 10:11:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWSAt-0004Zb-Q7
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 10:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbZBIJJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 04:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752268AbZBIJJj
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 04:09:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60479 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbZBIJJg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 04:09:36 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6D2C12ABFD
	for <git@vger.kernel.org>; Mon,  9 Feb 2009 04:09:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 981892ABE6 for
 <git@vger.kernel.org>; Mon,  9 Feb 2009 04:09:34 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc0.28.g2593d
In-Reply-To: <1234170565-6740-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5EE9D92E-F689-11DD-BDB0-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109055>

This is a companion patch to the recent 3d95d92 (receive-pack: explain
what to do when push updates the current branch, 2009-01-31).

Deleting the current branch from a remote will result in the next clone
from it not check out anything, among other things.  It also is one of the
cause that makes remotes/origin/HEAD a dangling symbolic ref.  This patch
still allows the traditional behaviour but with a big warning, and promises
that the default will change to 'refuse' in a future release.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-receive-pack.c |   72 ++++++++++++++++++++++++++++++++++++++++-------
 t/t5400-send-pack.sh   |    7 ++++
 2 files changed, 68 insertions(+), 11 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index b2cb4ba..f7e04c4 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -21,11 +21,13 @@ enum deny_action {
 static int deny_deletes;
 static int deny_non_fast_forwards;
 static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
+static enum deny_action deny_delete_current = DENY_UNCONFIGURED;
 static int receive_fsck_objects;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
 static int report_status;
+static const char *head_name;
 
 static char capabilities[] = " report-status delete-refs ";
 static int capabilities_sent;
@@ -77,6 +79,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.denydeletecurrent") == 0) {
+		deny_delete_current = parse_deny_action(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -203,16 +210,12 @@ static int run_update_hook(struct command *cmd)
 
 static int is_ref_checked_out(const char *ref)
 {
-	unsigned char sha1[20];
-	const char *head;
-
 	if (is_bare_repository())
 		return 0;
 
-	head = resolve_ref("HEAD", sha1, 0, NULL);
-	if (!head)
+	if (!head_name)
 		return 0;
-	return !strcmp(head, ref);
+	return !strcmp(head_name, ref);
 }
 
 static char *warn_unconfigured_deny_msg[] = {
@@ -244,6 +247,32 @@ static void warn_unconfigured_deny(void)
 		warning(warn_unconfigured_deny_msg[i]);
 }
 
+static char *warn_unconfigured_deny_delete_current_msg[] = {
+	"Deleting the current branch can cause confusion by making the next",
+	"'git clone' not check out any file.",
+	"",
+	"You can set 'receive.denyDeleteCurrent' configuration variable to",
+	"'refuse' in the remote repository to disallow deleting the current",
+	"branch.",
+	"",
+	"You can set it to 'ignore' to allow such a delete without a warning.",
+	"",
+	"To make this warning message less loud, you can set it to 'warn'.",
+	"",
+	"Note that the default will change in a future version of git",
+	"to refuse deleting the current branch unless you have the",
+	"configuration variable set to either 'ignore' or 'warn'."
+};
+
+static void warn_unconfigured_deny_delete_current(void)
+{
+	int i;
+	for (i = 0;
+	     i < ARRAY_SIZE(warn_unconfigured_deny_delete_current_msg);
+	     i++)
+		warning(warn_unconfigured_deny_delete_current_msg[i]);
+}
+
 static const char *update(struct command *cmd)
 {
 	const char *name = cmd->ref_name;
@@ -278,12 +307,30 @@ static const char *update(struct command *cmd)
 		      "but I can't find it!", sha1_to_hex(new_sha1));
 		return "bad pack";
 	}
-	if (deny_deletes && is_null_sha1(new_sha1) &&
-	    !is_null_sha1(old_sha1) &&
-	    !prefixcmp(name, "refs/heads/")) {
-		error("denying ref deletion for %s", name);
-		return "deletion prohibited";
+
+	if (!is_null_sha1(old_sha1) && is_null_sha1(new_sha1)) {
+		if (deny_deletes && !prefixcmp(name, "refs/heads/")) {
+			error("denying ref deletion for %s", name);
+			return "deletion prohibited";
+		}
+
+		if (!strcmp(name, head_name)) {
+			switch (deny_delete_current) {
+			case DENY_IGNORE:
+				break;
+			case DENY_WARN:
+			case DENY_UNCONFIGURED:
+				if (deny_delete_current == DENY_UNCONFIGURED)
+					warn_unconfigured_deny_delete_current();
+				warning("deleting the current branch");
+				break;
+			case DENY_REFUSE:
+				error("refusing to delete the current branch: %s", name);
+				return "deletion of the current branch prohibited";
+			}
+		}
 	}
+
 	if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
 	    !is_null_sha1(old_sha1) &&
 	    !prefixcmp(name, "refs/heads/")) {
@@ -377,6 +424,7 @@ static void run_update_post_hook(struct command *cmd)
 static void execute_commands(const char *unpacker_error)
 {
 	struct command *cmd = commands;
+	unsigned char sha1[20];
 
 	if (unpacker_error) {
 		while (cmd) {
@@ -394,6 +442,8 @@ static void execute_commands(const char *unpacker_error)
 		return;
 	}
 
+	head_name = resolve_ref("HEAD", sha1, 0, NULL);
+
 	while (cmd) {
 		cmd->error_string = update(cmd);
 		cmd = cmd->next;
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 013aced..7b21f5f 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -193,4 +193,11 @@ test_expect_success 'pushing wildcard refspecs respects forcing' '
     )
 '
 
+test_expect_success 'deny pushing to delete current branch' '
+    (
+	rewound_push_setup &&
+	git send-pack ../parent/.git :refs/heads/master 2>errs
+    )
+'
+
 test_done
-- 
1.6.2.rc0.28.g2593d
