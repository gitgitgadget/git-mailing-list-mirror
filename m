From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC] Add "write-index" hook
Date: Thu, 22 Dec 2005 00:56:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512220055050.13515@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Dec 22 00:56:20 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpDoh-0002c0-EJ
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 00:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbVLUX4R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 18:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbVLUX4R
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 18:56:17 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:10166 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965002AbVLUX4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 18:56:16 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 4E0B313FC80
	for <git@vger.kernel.org>; Thu, 22 Dec 2005 00:56:15 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 32AEA9E2B4
	for <git@vger.kernel.org>; Thu, 22 Dec 2005 00:56:15 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id ECB299C324
	for <git@vger.kernel.org>; Thu, 22 Dec 2005 00:56:14 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id D9D3913FC80
	for <git@vger.kernel.org>; Thu, 22 Dec 2005 00:56:14 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13921>


This is a less hacky way to prevent index access than what I suggested
earlier. It has the additional benefit that you can control access to
the index writing now.

Oh, and the code to run hooks (which die() on errors) has been refactored.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	While the use of this hook is questionable, I actually like the
	refactoring of the hooks, since it makes it so much easier
	to add new ones.

 index.c        |    7 ++++++
 receive-pack.c |   61 ++------------------------------------------------------
 run-command.c  |   49 +++++++++++++++++++++++++++++++++++++++++++++
 run-command.h  |    2 ++
 4 files changed, 60 insertions(+), 59 deletions(-)

d567efd0ccfb60ae03a81f02f819283767d69011
diff --git a/index.c b/index.c
index ad0eafe..3f6ca1e 100644
--- a/index.c
+++ b/index.c
@@ -3,6 +3,7 @@
  */
 #include <signal.h>
 #include "cache.h"
+#include "run-command.h"
 
 static struct cache_file *cache_file_list;
 
@@ -20,9 +21,15 @@ static void remove_lock_file_on_signal(i
 	remove_lock_file();
 }
 
+static char write_index_hook[] = "hooks/write-index";
+
 int hold_index_file_for_update(struct cache_file *cf, const char *path)
 {
 	int fd;
+
+	if (run_hook(write_index_hook))
+		return error("hook declined to write index\n");
+
 	sprintf(cf->lockfile, "%s.lock", path);
 	fd = open(cf->lockfile, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (fd >=0 && !cf->next) {
diff --git a/receive-pack.c b/receive-pack.c
index cbe37e7..d52d793 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -59,36 +59,6 @@ static int verify_old_ref(const char *na
 
 static char update_hook[] = "hooks/update";
 
-static int run_update_hook(const char *refname,
-			   char *old_hex, char *new_hex)
-{
-	int code;
-
-	if (access(update_hook, X_OK) < 0)
-		return 0;
-	code = run_command(update_hook, refname, old_hex, new_hex, NULL);
-	switch (code) {
-	case 0:
-		return 0;
-	case -ERR_RUN_COMMAND_FORK:
-		die("hook fork failed");
-	case -ERR_RUN_COMMAND_EXEC:
-		die("hook execute failed");
-	case -ERR_RUN_COMMAND_WAITPID:
-		die("waitpid failed");
-	case -ERR_RUN_COMMAND_WAITPID_WRONG_PID:
-		die("waitpid is confused");
-	case -ERR_RUN_COMMAND_WAITPID_SIGNAL:
-		fprintf(stderr, "%s died of signal", update_hook);
-		return -1;
-	case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
-		die("%s died strangely", update_hook);
-	default:
-		error("%s exited with error code %d", update_hook, -code);
-		return -code;
-	}
-}
-
 static int update(const char *name,
 		  unsigned char *old_sha1, unsigned char *new_sha1)
 {
@@ -133,7 +103,7 @@ static int update(const char *name,
 		unlink(lock_name);
 		return error("%s changed during push", name);
 	}
-	if (run_update_hook(name, old_hex, new_hex)) {
+	if (run_hook(update_hook, name, old_hex, new_hex)) {
 		unlink(lock_name);
 		return error("hook declined to update %s\n", name);
 	}
@@ -149,33 +119,6 @@ static int update(const char *name,
 
 static char update_post_hook[] = "hooks/post-update";
 
-static void run_update_post_hook(struct command *cmd)
-{
-	struct command *cmd_p;
-	int argc;
-	char **argv;
-
-	if (access(update_post_hook, X_OK) < 0)
-		return;
-	for (argc = 1, cmd_p = cmd; cmd_p; cmd_p = cmd_p->next) {
-		if (!cmd_p->updated)
-			continue;
-		argc++;
-	}
-	argv = xmalloc(sizeof(*argv) * (1 + argc));
-	argv[0] = update_post_hook;
-
-	for (argc = 1, cmd_p = cmd; cmd_p; cmd_p = cmd_p->next) {
-		if (!cmd_p->updated)
-			continue;
-		argv[argc] = xmalloc(strlen(cmd_p->ref_name) + 1);
-		strcpy(argv[argc], cmd_p->ref_name);
-		argc++;
-	}
-	argv[argc] = NULL;
-	run_command_v_opt(argc, argv, RUN_COMMAND_NO_STDIO);
-}
-
 /*
  * This gets called after(if) we've successfully
  * unpacked the data payload.
@@ -189,7 +132,7 @@ static void execute_commands(void)
 				       cmd->old_sha1, cmd->new_sha1);
 		cmd = cmd->next;
 	}
-	run_update_post_hook(commands);
+	run_hook(update_post_hook, commands);
 }
 
 static void read_head_info(void)
diff --git a/run-command.c b/run-command.c
index 8bf5922..95455ef 100644
--- a/run-command.c
+++ b/run-command.c
@@ -67,3 +67,52 @@ int run_command(const char *cmd, ...)
 		return error("too many args to run %s", cmd);
 	return run_command_v_opt(argc, argv, 0);
 }
+
+int run_hook(const char* hook, ...)
+{
+	int argc;
+	char *argv[MAX_RUN_COMMAND_ARGS];
+	const char *arg;
+	va_list param;
+	int code;
+
+	if (access(hook, X_OK) < 0)
+		return 0;
+
+	va_start(param, hook);
+	argv[0] = (char*) hook;
+	argc = 1;
+	while (argc < MAX_RUN_COMMAND_ARGS) {
+		arg = argv[argc++] = va_arg(param, char *);
+		if (!arg)
+			break;
+	}
+	va_end(param);
+	if (MAX_RUN_COMMAND_ARGS <= argc)
+		return error("too many args to run %s", hook);
+
+	code = run_command_v_opt(argc, argv, 0);
+
+	switch (code) {
+	case 0:
+		return 0;
+	case -ERR_RUN_COMMAND_FORK:
+		die("hook fork failed");
+	case -ERR_RUN_COMMAND_EXEC:
+		die("hook execute failed");
+	case -ERR_RUN_COMMAND_WAITPID:
+		die("waitpid failed");
+	case -ERR_RUN_COMMAND_WAITPID_WRONG_PID:
+		die("waitpid is confused");
+	case -ERR_RUN_COMMAND_WAITPID_SIGNAL:
+		fprintf(stderr, "%s died of signal", hook);
+		return -1;
+	case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
+		die("%s died strangely", hook);
+	default:
+		error("%s exited with error code %d", hook, -code);
+		return -code;
+	}
+}
+
+
diff --git a/run-command.h b/run-command.h
index 2469eea..604176f 100644
--- a/run-command.h
+++ b/run-command.h
@@ -16,5 +16,7 @@ enum {
 int run_command_v_opt(int argc, char **argv, int opt);
 int run_command_v(int argc, char **argv);
 int run_command(const char *cmd, ...);
+/* unlike run_command(), run_hook die()s on errors */
+int run_hook(const char *hook, ...);
 
 #endif
-- 
1.0.0
