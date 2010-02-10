From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 8/6] receive-pack: Send internal errors over side-band #2
Date: Tue,  9 Feb 2010 18:01:30 -0800
Message-ID: <1265767290-25863-2-git-send-email-spearce@spearce.org>
References: <1265767290-25863-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 03:01:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf1td-0007Ab-8P
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 03:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332Ab0BJCBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 21:01:34 -0500
Received: from george.spearce.org ([209.20.77.23]:56825 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216Ab0BJCBc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 21:01:32 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 192D0381FD
	for <git@vger.kernel.org>; Wed, 10 Feb 2010 02:01:32 +0000 (UTC)
X-Mailer: git-send-email 1.7.0.rc2.170.gbc565
In-Reply-To: <1265767290-25863-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139472>

If the client has requested side-band-64k capability, send any
of the internal error or warning messages in the muxed side-band
stream using the same band as our hook output, band #2.  By putting
everything in one stream we ensure all messages are processed by
the side-band demuxer, avoiding interleaving between our own stderr
and the side-band demuxer's stderr buffers.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-receive-pack.c  |   68 +++++++++++++++++++++++++++++++++++-----------
 t/t5401-update-hooks.sh |    3 +-
 2 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index da1c26b..e98c2f1 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -139,6 +139,40 @@ static struct command *commands;
 static const char pre_receive_hook[] = "hooks/pre-receive";
 static const char post_receive_hook[] = "hooks/post-receive";
 
+static void rp_error(const char *err, ...) __attribute__((format (printf, 1, 2)));
+static void rp_warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
+
+static void report_message(const char *prefix, const char *err, va_list params)
+{
+	int sz = strlen(prefix);
+	char msg[4096];
+
+	strncpy(msg, prefix, sz);
+	sz += vsnprintf(msg + sz, sizeof(msg) - (sz + 1), err, params);
+	msg[sz++] = '\n';
+
+	if (use_sideband)
+		send_sideband(1, 2, msg, sz, use_sideband);
+	else
+		xwrite(2, msg, sz);
+}
+
+static void rp_warning(const char *err, ...)
+{
+	va_list params;
+	va_start(params, err);
+	report_message("warning: ", err, params);
+	va_end(params);
+}
+
+static void rp_error(const char *err, ...)
+{
+	va_list params;
+	va_start(params, err);
+	report_message("error: ", err, params);
+	va_end(params);
+}
+
 static int copy_to_sideband(int in, int out, void *arg)
 {
 	char data[128];
@@ -276,7 +310,7 @@ static void warn_unconfigured_deny(void)
 {
 	int i;
 	for (i = 0; i < ARRAY_SIZE(warn_unconfigured_deny_msg); i++)
-		warning("%s", warn_unconfigured_deny_msg[i]);
+		rp_warning("%s", warn_unconfigured_deny_msg[i]);
 }
 
 static char *warn_unconfigured_deny_delete_current_msg[] = {
@@ -302,7 +336,7 @@ static void warn_unconfigured_deny_delete_current(void)
 	for (i = 0;
 	     i < ARRAY_SIZE(warn_unconfigured_deny_delete_current_msg);
 	     i++)
-		warning("%s", warn_unconfigured_deny_delete_current_msg[i]);
+		rp_warning("%s", warn_unconfigured_deny_delete_current_msg[i]);
 }
 
 static const char *update(struct command *cmd)
@@ -314,7 +348,7 @@ static const char *update(struct command *cmd)
 
 	/* only refs/... are allowed */
 	if (prefixcmp(name, "refs/") || check_ref_format(name + 5)) {
-		error("refusing to create funny ref '%s' remotely", name);
+		rp_error("refusing to create funny ref '%s' remotely", name);
 		return "funny refname";
 	}
 
@@ -324,25 +358,25 @@ static const char *update(struct command *cmd)
 			break;
 		case DENY_UNCONFIGURED:
 		case DENY_WARN:
-			warning("updating the current branch");
+			rp_warning("updating the current branch");
 			if (deny_current_branch == DENY_UNCONFIGURED)
 				warn_unconfigured_deny();
 			break;
 		case DENY_REFUSE:
-			error("refusing to update checked out branch: %s", name);
+			rp_error("refusing to update checked out branch: %s", name);
 			return "branch is currently checked out";
 		}
 	}
 
 	if (!is_null_sha1(new_sha1) && !has_sha1_file(new_sha1)) {
-		error("unpack should have generated %s, "
-		      "but I can't find it!", sha1_to_hex(new_sha1));
+		rp_error("unpack should have generated %s, "
+			 "but I can't find it!", sha1_to_hex(new_sha1));
 		return "bad pack";
 	}
 
 	if (!is_null_sha1(old_sha1) && is_null_sha1(new_sha1)) {
 		if (deny_deletes && !prefixcmp(name, "refs/heads/")) {
-			error("denying ref deletion for %s", name);
+			rp_error("denying ref deletion for %s", name);
 			return "deletion prohibited";
 		}
 
@@ -354,10 +388,10 @@ static const char *update(struct command *cmd)
 			case DENY_UNCONFIGURED:
 				if (deny_delete_current == DENY_UNCONFIGURED)
 					warn_unconfigured_deny_delete_current();
-				warning("deleting the current branch");
+				rp_warning("deleting the current branch");
 				break;
 			case DENY_REFUSE:
-				error("refusing to delete the current branch: %s", name);
+				rp_error("refusing to delete the current branch: %s", name);
 				return "deletion of the current branch prohibited";
 			}
 		}
@@ -376,7 +410,7 @@ static const char *update(struct command *cmd)
 		if (!old_object || !new_object ||
 		    old_object->type != OBJ_COMMIT ||
 		    new_object->type != OBJ_COMMIT) {
-			error("bad sha1 objects for %s", name);
+			rp_error("bad sha1 objects for %s", name);
 			return "bad ref";
 		}
 		old_commit = (struct commit *)old_object;
@@ -387,23 +421,23 @@ static const char *update(struct command *cmd)
 				break;
 		free_commit_list(bases);
 		if (!ent) {
-			error("denying non-fast-forward %s"
-			      " (you should pull first)", name);
+			rp_error("denying non-fast-forward %s"
+				 " (you should pull first)", name);
 			return "non-fast-forward";
 		}
 	}
 	if (run_update_hook(cmd)) {
-		error("hook declined to update %s", name);
+		rp_error("hook declined to update %s", name);
 		return "hook declined";
 	}
 
 	if (is_null_sha1(new_sha1)) {
 		if (!parse_object(old_sha1)) {
-			warning ("Allowing deletion of corrupt ref.");
+			rp_warning("Allowing deletion of corrupt ref.");
 			old_sha1 = NULL;
 		}
 		if (delete_ref(name, old_sha1, 0)) {
-			error("failed to delete %s", name);
+			rp_error("failed to delete %s", name);
 			return "failed to delete";
 		}
 		return NULL; /* good */
@@ -411,7 +445,7 @@ static const char *update(struct command *cmd)
 	else {
 		lock = lock_any_ref_for_update(name, old_sha1, 0);
 		if (!lock) {
-			error("failed to lock %s", name);
+			rp_error("failed to lock %s", name);
 			return "failed to lock";
 		}
 		if (write_ref_sha1(lock, new_sha1, "push")) {
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 7240fab..17bcb0b 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -124,6 +124,7 @@ remote: STDOUT update refs/heads/master
 remote: STDERR update refs/heads/master
 remote: STDOUT update refs/heads/tofail
 remote: STDERR update refs/heads/tofail
+remote: error: hook declined to update refs/heads/tofail
 remote: STDOUT post-receive
 remote: STDERR post-receive
 remote: STDOUT post-update
@@ -131,7 +132,7 @@ remote: STDERR post-update
 EOF
 test_expect_success 'send-pack stderr contains hook messages' '
 	grep ^remote: send.err | sed "s/ *\$//" >actual &&
-	test_cmp - actual <expect
+	test_cmp expect actual
 '
 
 test_done
-- 
1.7.0.rc2.170.gbc565
