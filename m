From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/3] Simplify some instances of run_command() by using run_command_v_opt().
Date: Mon,  8 Jun 2009 22:34:29 +0200
Message-ID: <e4b190906055eb86077ca3e7257c983befcfb511.1244492659.git.j6t@kdbg.org>
References: <cover.1244492658.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 22:35:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDlYu-0005lb-Bu
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 22:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbZFHUfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 16:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753290AbZFHUfJ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 16:35:09 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:63105 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752884AbZFHUfI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 16:35:08 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B9BD4CDF89;
	Mon,  8 Jun 2009 22:35:08 +0200 (CEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 84A131D0C2;
	Mon,  8 Jun 2009 22:35:08 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.17.g1665f
In-Reply-To: <cover.1244492658.git.j6t@kdbg.org>
In-Reply-To: <cover.1244492658.git.j6t@kdbg.org>
References: <cover.1244492658.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121102>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 builtin-receive-pack.c |   10 +++-------
 ll-merge.c             |   11 ++---------
 merge-index.c          |   42 +++++++++++++-----------------------------
 3 files changed, 18 insertions(+), 45 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 0b08da9..33d345d 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -192,7 +192,6 @@ static int run_receive_hook(const char *hook_name)
 static int run_update_hook(struct command *cmd)
 {
 	static const char update_hook[] = "hooks/update";
-	struct child_process proc;
 	const char *argv[5];
 
 	if (access(update_hook, X_OK) < 0)
@@ -204,12 +203,9 @@ static int run_update_hook(struct command *cmd)
 	argv[3] = sha1_to_hex(cmd->new_sha1);
 	argv[4] = NULL;
 
-	memset(&proc, 0, sizeof(proc));
-	proc.argv = argv;
-	proc.no_stdin = 1;
-	proc.stdout_to_stderr = 1;
-
-	return hook_status(run_command(&proc), update_hook);
+	return hook_status(run_command_v_opt(argv, RUN_COMMAND_NO_STDIN |
+					RUN_COMMAND_STDOUT_TO_STDERR),
+			update_hook);
 }
 
 static int is_ref_checked_out(const char *ref)
diff --git a/ll-merge.c b/ll-merge.c
index 81c02ad..31d6f0a 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -175,8 +175,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 		{ "B", temp[2] },
 		{ NULL }
 	};
-	struct child_process child;
-	const char *args[20];
+	const char *args[] = { "sh", "-c", NULL, NULL };
 	int status, fd, i;
 	struct stat st;
 
@@ -191,14 +190,8 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 
 	strbuf_expand(&cmd, fn->cmdline, strbuf_expand_dict_cb, &dict);
 
-	memset(&child, 0, sizeof(child));
-	child.argv = args;
-	args[0] = "sh";
-	args[1] = "-c";
 	args[2] = cmd.buf;
-	args[3] = NULL;
-
-	status = run_command(&child);
+	status = run_command_v_opt(args, 0);
 	if (status < -ERR_RUN_COMMAND_FORK)
 		; /* failure in run-command */
 	else
diff --git a/merge-index.c b/merge-index.c
index aa9cf23..19ddd03 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -3,45 +3,20 @@
 #include "exec_cmd.h"
 
 static const char *pgm;
-static const char *arguments[9];
 static int one_shot, quiet;
 static int err;
 
-static void run_program(void)
-{
-	struct child_process child;
-	memset(&child, 0, sizeof(child));
-	child.argv = arguments;
-	if (run_command(&child)) {
-		if (one_shot) {
-			err++;
-		} else {
-			if (!quiet)
-				die("merge program failed");
-			exit(1);
-		}
-	}
-}
-
 static int merge_entry(int pos, const char *path)
 {
 	int found;
+	const char *arguments[] = { pgm, "", "", "", path, "", "", "", NULL };
+	char hexbuf[4][60];
+	char ownbuf[4][60];
 
 	if (pos >= active_nr)
 		die("git merge-index: %s not in the cache", path);
-	arguments[0] = pgm;
-	arguments[1] = "";
-	arguments[2] = "";
-	arguments[3] = "";
-	arguments[4] = path;
-	arguments[5] = "";
-	arguments[6] = "";
-	arguments[7] = "";
-	arguments[8] = NULL;
 	found = 0;
 	do {
-		static char hexbuf[4][60];
-		static char ownbuf[4][60];
 		struct cache_entry *ce = active_cache[pos];
 		int stage = ce_stage(ce);
 
@@ -55,7 +30,16 @@ static int merge_entry(int pos, const char *path)
 	} while (++pos < active_nr);
 	if (!found)
 		die("git merge-index: %s not in the cache", path);
-	run_program();
+
+	if (run_command_v_opt(arguments, 0)) {
+		if (one_shot)
+			err++;
+		else {
+			if (!quiet)
+				die("merge program failed");
+			exit(1);
+		}
+	}
 	return found;
 }
 
-- 
1.6.3.17.g1665f
