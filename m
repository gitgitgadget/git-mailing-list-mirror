From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH/RFC 7/7] receive-pack: remove unnecessary run_status report
Date: Sat,  4 Jul 2009 21:26:43 +0200
Message-ID: <bc993d449ea426dfdbf6feb76779d98944a8b29a.1246734159.git.j6t@kdbg.org>
References: <cover.1246734159.git.j6t@kdbg.org>
 <b73cf4b4cd09f4225098e71182044f64e12380aa.1246734159.git.j6t@kdbg.org>
 <d63e9230d57698a058c8a550709155e5e3222348.1246734159.git.j6t@kdbg.org>
 <4fe5ad61e7500735d1bbc12c98a863dd3499ea31.1246734159.git.j6t@kdbg.org>
 <ea2d8110ea70b8698bb3674ca4482db64053d841.1246734159.git.j6t@kdbg.org>
 <195a33e7de20a4b52df8cb8861998fbbbed0b311.1246734159.git.j6t@kdbg.org>
 <87ce2ffef09004ca19acd491b9374283f06c98c2.1246734159.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 04 21:28:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNAui-0005PF-Ri
	for gcvg-git-2@gmane.org; Sat, 04 Jul 2009 21:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791AbZGDT1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jul 2009 15:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752741AbZGDT1m
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jul 2009 15:27:42 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:17700 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752556AbZGDT1c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jul 2009 15:27:32 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 79B61A7EBB;
	Sat,  4 Jul 2009 21:27:34 +0200 (CEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 2E5228994C;
	Sat,  4 Jul 2009 21:27:34 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.17.g1665f
In-Reply-To: <87ce2ffef09004ca19acd491b9374283f06c98c2.1246734159.git.j6t@kdbg.org>
In-Reply-To: <cover.1246734159.git.j6t@kdbg.org>
References: <cover.1246734159.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122728>

The function run_status was used to report failures after a hook was run.
By now, the only thing that the function itself reported was the exit code
of the hook (if it was non-zero). But this is redundant because it can be
expected that the hook itself will have reported a suitable error.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 builtin-receive-pack.c |   20 ++++----------------
 1 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index c85507b..b771fe9 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -123,13 +123,6 @@ static struct command *commands;
 static const char pre_receive_hook[] = "hooks/pre-receive";
 static const char post_receive_hook[] = "hooks/post-receive";
 
-static int run_status(int code, const char *cmd_name)
-{
-	if (code > 0)
-		error("%s exited with error code %d", cmd_name, code);
-	return code;
-}
-
 static int run_receive_hook(const char *hook_name)
 {
 	static char buf[sizeof(commands->old_sha1) * 2 + PATH_MAX + 4];
@@ -156,7 +149,7 @@ static int run_receive_hook(const char *hook_name)
 
 	code = start_command(&proc);
 	if (code)
-		return run_status(code, hook_name);
+		return code;
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (!cmd->error_string) {
 			size_t n = snprintf(buf, sizeof(buf), "%s %s %s\n",
@@ -168,7 +161,7 @@ static int run_receive_hook(const char *hook_name)
 		}
 	}
 	close(proc.in);
-	return run_status(finish_command(&proc), hook_name);
+	return finish_command(&proc);
 }
 
 static int run_update_hook(struct command *cmd)
@@ -185,9 +178,8 @@ static int run_update_hook(struct command *cmd)
 	argv[3] = sha1_to_hex(cmd->new_sha1);
 	argv[4] = NULL;
 
-	return run_status(run_command_v_opt(argv, RUN_COMMAND_NO_STDIN |
-					RUN_COMMAND_STDOUT_TO_STDERR),
-			update_hook);
+	return run_command_v_opt(argv, RUN_COMMAND_NO_STDIN |
+					RUN_COMMAND_STDOUT_TO_STDERR);
 }
 
 static int is_ref_checked_out(const char *ref)
@@ -401,7 +393,6 @@ static void run_update_post_hook(struct command *cmd)
 	argv[argc] = NULL;
 	status = run_command_v_opt(argv, RUN_COMMAND_NO_STDIN
 			| RUN_COMMAND_STDOUT_TO_STDERR);
-	run_status(status, update_post_hook);
 }
 
 static void execute_commands(const char *unpacker_error)
@@ -519,7 +510,6 @@ static const char *unpack(void)
 		code = run_command_v_opt(unpacker, RUN_GIT_CMD);
 		if (!code)
 			return NULL;
-		run_status(code, unpacker[0]);
 		return "unpack-objects abnormal exit";
 	} else {
 		const char *keeper[7];
@@ -545,7 +535,6 @@ static const char *unpack(void)
 		ip.git_cmd = 1;
 		status = start_command(&ip);
 		if (status) {
-			run_status(status, keeper[0]);
 			return "index-pack fork failed";
 		}
 		pack_lockfile = index_pack_lockfile(ip.out);
@@ -555,7 +544,6 @@ static const char *unpack(void)
 			reprepare_packed_git();
 			return NULL;
 		}
-		run_status(status, keeper[0]);
 		return "index-pack abnormal exit";
 	}
 }
-- 
1.6.3.17.g1665f
