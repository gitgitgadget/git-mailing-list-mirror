From: Aaron Schrab <aaron@schrab.com>
Subject: [PATCH v2 1/3] hooks: Add function to check if a hook exists
Date: Sun, 13 Jan 2013 00:17:02 -0500
Message-ID: <1358054224-7710-2-git-send-email-aaron@schrab.com>
References: <1358054224-7710-1-git-send-email-aaron@schrab.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 06:18:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuFxf-0003DG-7C
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 06:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045Ab3AMFRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 00:17:55 -0500
Received: from pug.qqx.org ([50.116.43.67]:36677 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956Ab3AMFRz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 00:17:55 -0500
Received: from zim.qqx.org (cpe-107-015-024-243.nc.res.rr.com [107.15.24.243])
	by pug.qqx.org (Postfix) with ESMTPSA id A6F331D2D7
	for <git@vger.kernel.org>; Sun, 13 Jan 2013 00:17:54 -0500 (EST)
Received: from ats (uid 1000)
	(envelope-from aaron@schrab.com)
	id 401f0
	by zim.qqx.org (DragonFly Mail Agent);
	Sun, 13 Jan 2013 00:17:54 -0500
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358054224-7710-1-git-send-email-aaron@schrab.com>
In-Reply-To: <1356735452-21667-1-git-send-email-aaron@schrab.com>
References: <1356735452-21667-1-git-send-email-aaron@schrab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213332>

Create find_hook() function to determine if a given hook exists and is
executable.  If it is, the path to the script will be returned,
otherwise NULL is returned.

This encapsulates the tests that are used to check for the existence of
a hook in one place, making it easier to modify those checks if that is
found to be necessary.  This also makes it simple for places that can
use a hook to check if a hook exists before doing, possibly lengthy,
setup work which would be pointless if no such hook is present.

The returned value is left as a static value from get_pathname() rather
than a duplicate because it is anticipated that the return value will
either be used as a boolean, immediately added to an argv_array list
which would result in it being duplicated at that point, or used to
actually run the command without much intervening work.  Callers which
need to hold onto the returned value for a longer time are expected to
duplicate the return value themselves.

Signed-off-by: Aaron Schrab <aaron@schrab.com>
---
 builtin/commit.c       |  6 ++----
 builtin/receive-pack.c | 25 +++++++++++--------------
 run-command.c          | 15 +++++++++++++--
 run-command.h          |  1 +
 4 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d6dd3df..65d08d2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1327,8 +1327,6 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 	return git_status_config(k, v, s);
 }
 
-static const char post_rewrite_hook[] = "hooks/post-rewrite";
-
 static int run_rewrite_hook(const unsigned char *oldsha1,
 			    const unsigned char *newsha1)
 {
@@ -1339,10 +1337,10 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
 	int code;
 	size_t n;
 
-	if (access(git_path(post_rewrite_hook), X_OK) < 0)
+	argv[0] = find_hook("post-rewrite");
+	if (!argv[0])
 		return 0;
 
-	argv[0] = git_path(post_rewrite_hook);
 	argv[1] = "amend";
 	argv[2] = NULL;
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ff781fe..e8878de 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -182,9 +182,6 @@ struct command {
 	char ref_name[FLEX_ARRAY]; /* more */
 };
 
-static const char pre_receive_hook[] = "hooks/pre-receive";
-static const char post_receive_hook[] = "hooks/post-receive";
-
 static void rp_error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 static void rp_warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
@@ -242,10 +239,10 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed, void *feed_sta
 	const char *argv[2];
 	int code;
 
-	if (access(hook_name, X_OK) < 0)
+	argv[0] = find_hook(hook_name);
+	if (!argv[0])
 		return 0;
 
-	argv[0] = hook_name;
 	argv[1] = NULL;
 
 	memset(&proc, 0, sizeof(proc));
@@ -331,15 +328,14 @@ static int run_receive_hook(struct command *commands, const char *hook_name,
 
 static int run_update_hook(struct command *cmd)
 {
-	static const char update_hook[] = "hooks/update";
 	const char *argv[5];
 	struct child_process proc;
 	int code;
 
-	if (access(update_hook, X_OK) < 0)
+	argv[0] = find_hook("update");
+	if (!argv[0])
 		return 0;
 
-	argv[0] = update_hook;
 	argv[1] = cmd->ref_name;
 	argv[2] = sha1_to_hex(cmd->old_sha1);
 	argv[3] = sha1_to_hex(cmd->new_sha1);
@@ -532,24 +528,25 @@ static const char *update(struct command *cmd)
 	}
 }
 
-static char update_post_hook[] = "hooks/post-update";
-
 static void run_update_post_hook(struct command *commands)
 {
 	struct command *cmd;
 	int argc;
 	const char **argv;
 	struct child_process proc;
+	char *hook;
 
+	hook = find_hook("post-update");
 	for (argc = 0, cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string || cmd->did_not_exist)
 			continue;
 		argc++;
 	}
-	if (!argc || access(update_post_hook, X_OK) < 0)
+	if (!argc || !hook)
 		return;
+
 	argv = xmalloc(sizeof(*argv) * (2 + argc));
-	argv[0] = update_post_hook;
+	argv[0] = hook;
 
 	for (argc = 1, cmd = commands; cmd; cmd = cmd->next) {
 		char *p;
@@ -704,7 +701,7 @@ static void execute_commands(struct command *commands, const char *unpacker_erro
 				       0, &cmd))
 		set_connectivity_errors(commands);
 
-	if (run_receive_hook(commands, pre_receive_hook, 0)) {
+	if (run_receive_hook(commands, "pre-receive", 0)) {
 		for (cmd = commands; cmd; cmd = cmd->next) {
 			if (!cmd->error_string)
 				cmd->error_string = "pre-receive hook declined";
@@ -994,7 +991,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			unlink_or_warn(pack_lockfile);
 		if (report_status)
 			report(commands, unpack_status);
-		run_receive_hook(commands, post_receive_hook, 1);
+		run_receive_hook(commands, "post-receive", 1);
 		run_update_post_hook(commands);
 		if (auto_gc) {
 			const char *argv_gc_auto[] = {
diff --git a/run-command.c b/run-command.c
index 0471219..12d4ddb 100644
--- a/run-command.c
+++ b/run-command.c
@@ -735,6 +735,15 @@ int finish_async(struct async *async)
 #endif
 }
 
+char *find_hook(const char *name)
+{
+	char *path = git_path("hooks/%s", name);
+	if (access(path, X_OK) < 0)
+		path = NULL;
+
+	return path;
+}
+
 int run_hook(const char *index_file, const char *name, ...)
 {
 	struct child_process hook;
@@ -744,11 +753,13 @@ int run_hook(const char *index_file, const char *name, ...)
 	va_list args;
 	int ret;
 
-	if (access(git_path("hooks/%s", name), X_OK) < 0)
+	p = find_hook(name);
+	if (!p)
 		return 0;
 
+	argv_array_push(&argv, p);
+
 	va_start(args, name);
-	argv_array_push(&argv, git_path("hooks/%s", name));
 	while ((p = va_arg(args, const char *)))
 		argv_array_push(&argv, p);
 	va_end(args);
diff --git a/run-command.h b/run-command.h
index 850c638..221ce33 100644
--- a/run-command.h
+++ b/run-command.h
@@ -45,6 +45,7 @@ int start_command(struct child_process *);
 int finish_command(struct child_process *);
 int run_command(struct child_process *);
 
+extern char *find_hook(const char *name);
 extern int run_hook(const char *index_file, const char *name, ...);
 
 #define RUN_COMMAND_NO_STDIN 1
-- 
1.8.1.340.g425b78d
