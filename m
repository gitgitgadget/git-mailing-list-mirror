From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/5] do not override receive-pack errors
Date: Mon, 13 Feb 2012 21:17:12 +0100
Message-ID: <1329164235-29955-3-git-send-email-drizzd@aon.at>
References: <7vhazobto3.fsf@alter.siamese.dyndns.org>
 <1329164235-29955-1-git-send-email-drizzd@aon.at>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 21:26:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx2Tj-0002oB-8s
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 21:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757967Ab2BMU0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 15:26:10 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:6890 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757994Ab2BMUZo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 15:25:44 -0500
Received: from localhost (p5B22E0DA.dip.t-dialin.net [91.34.224.218])
	by bsmtp.bon.at (Postfix) with ESMTP id 8D53510011;
	Mon, 13 Feb 2012 21:23:01 +0100 (CET)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1329164235-29955-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190663>

Receive runs rev-list --verify-objects in order to detect missing
objects. However, such errors are ignored and overridden later.
Instead, consequently ignore all update commands for which an error has
already been detected.

Some tests in t5504 are obsoleted by this change, because invalid
objects are detected even if fsck is not enabled. Instead, they now test
for different error messages depending on whether or not fsck is turned
on. A better fix would be to force a corruption that will be detected by
fsck but not by rev-list.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 builtin/receive-pack.c          |   24 +++++++++++++++++-------
 t/t5504-fetch-receive-strict.sh |   22 ++++++++++++++++++----
 2 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index fa7448b..0afb8b2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -642,8 +642,10 @@ static void check_aliased_updates(struct command *commands)
 	}
 	sort_string_list(&ref_list);
 
-	for (cmd = commands; cmd; cmd = cmd->next)
-		check_aliased_update(cmd, &ref_list);
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		if (!cmd->error_string)
+			check_aliased_update(cmd, &ref_list);
+	}
 
 	string_list_clear(&ref_list, 0);
 }
@@ -707,8 +709,10 @@ static void execute_commands(struct command *commands, const char *unpacker_erro
 		set_connectivity_errors(commands);
 
 	if (run_receive_hook(commands, pre_receive_hook, 0)) {
-		for (cmd = commands; cmd; cmd = cmd->next)
-			cmd->error_string = "pre-receive hook declined";
+		for (cmd = commands; cmd; cmd = cmd->next) {
+			if (!cmd->error_string)
+				cmd->error_string = "pre-receive hook declined";
+		}
 		return;
 	}
 
@@ -717,9 +721,15 @@ static void execute_commands(struct command *commands, const char *unpacker_erro
 	free(head_name_to_free);
 	head_name = head_name_to_free = resolve_refdup("HEAD", sha1, 0, NULL);
 
-	for (cmd = commands; cmd; cmd = cmd->next)
-		if (!cmd->skip_update)
-			cmd->error_string = update(cmd);
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		if (cmd->error_string)
+			continue;
+
+		if (cmd->skip_update)
+			continue;
+
+		cmd->error_string = update(cmd);
+	}
 }
 
 static struct command *read_head_info(void)
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 8341fc4..35ec294 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -58,6 +58,11 @@ test_expect_success 'fetch with transfer.fsckobjects' '
 	)
 '
 
+cat >exp <<EOF
+To dst
+!	refs/heads/master:refs/heads/test	[remote rejected] (missing necessary objects)
+EOF
+
 test_expect_success 'push without strict' '
 	rm -rf dst &&
 	git init dst &&
@@ -66,7 +71,8 @@ test_expect_success 'push without strict' '
 		git config fetch.fsckobjects false &&
 		git config transfer.fsckobjects false
 	) &&
-	git push dst master:refs/heads/test
+	test_must_fail git push --porcelain dst master:refs/heads/test >act &&
+	test_cmp exp act
 '
 
 test_expect_success 'push with !receive.fsckobjects' '
@@ -77,9 +83,15 @@ test_expect_success 'push with !receive.fsckobjects' '
 		git config receive.fsckobjects false &&
 		git config transfer.fsckobjects true
 	) &&
-	git push dst master:refs/heads/test
+	test_must_fail git push --porcelain dst master:refs/heads/test >act &&
+	test_cmp exp act
 '
 
+cat >exp <<EOF
+To dst
+!	refs/heads/master:refs/heads/test	[remote rejected] (n/a (unpacker error))
+EOF
+
 test_expect_success 'push with receive.fsckobjects' '
 	rm -rf dst &&
 	git init dst &&
@@ -88,7 +100,8 @@ test_expect_success 'push with receive.fsckobjects' '
 		git config receive.fsckobjects true &&
 		git config transfer.fsckobjects false
 	) &&
-	test_must_fail git push dst master:refs/heads/test
+	test_must_fail git push --porcelain dst master:refs/heads/test >act &&
+	test_cmp exp act
 '
 
 test_expect_success 'push with transfer.fsckobjects' '
@@ -98,7 +111,8 @@ test_expect_success 'push with transfer.fsckobjects' '
 		cd dst &&
 		git config transfer.fsckobjects true
 	) &&
-	test_must_fail git push dst master:refs/heads/test
+	test_must_fail git push --porcelain dst master:refs/heads/test >act &&
+	test_cmp exp act
 '
 
 test_done
-- 
1.7.9
