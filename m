From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] [RFC] Make git-update-ref invoke the update and post-update hooks
Date: Sun, 08 Oct 2006 02:08:08 +0200
Message-ID: <20061008000808.1128.36962.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 08 02:08:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWMDH-0005os-9n
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 02:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWJHAIM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 20:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbWJHAIM
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 20:08:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37004 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750737AbWJHAIK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 20:08:10 -0400
Received: (qmail 1138 invoked from network); 8 Oct 2006 02:08:08 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 8 Oct 2006 02:08:08 +0200
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28517>

Someone raised a concern that the update and post-update hooks are not
invoked at fetch time in the similar way as they are invoked at push
time, and the idea sort of makes sense. But this patch goes further - it
makes Git invoke those hooks each time a ref is updated in a repository
using the git-update-ref command, which I believe makes a lot of sense as
well - the behaviour is consistent with the current pushing behaviour
and you suddenly finally get a hook where you can properly notify even
about fast-forwards etc.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-update-ref.txt |    3 ++
 Documentation/hooks.txt          |   12 ++++--
 Makefile                         |    2 +
 builtin-update-ref.c             |   12 ++++++
 hooks.c                          |   68 ++++++++++++++++++++++++++++++++++++
 hooks.h                          |   15 ++++++++
 receive-pack.c                   |   71 +-------------------------------------
 7 files changed, 106 insertions(+), 77 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 71bcb79..bd20d05 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -51,6 +51,9 @@ for reading but not for writing (so we'l
 ref symlink to some other tree, if you have copied a whole
 archive by creating a symlink tree).
 
+Just before updating the reference, the update hook is invoked.
+After updating the reference, the post-update hook is invoked.
+
 With `-d` flag, it deletes the named <ref> after verifying it
 still contains <oldvalue>.
 
diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index 517f49b..53fa270 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -99,8 +99,9 @@ update
 This hook is invoked by `git-receive-pack` on the remote repository,
 which happens when a `git push` is done on a local repository.
 Just before updating the ref on the remote repository, the update hook
-is invoked.  Its exit status determines the success or failure of
-the ref update.
+is invoked.  It is also invoked on the local repository anytime a ref
+value is updated (that includes mainly fetches, merges, commits).
+Its exit status determines the success or failure of the ref update.
 
 The hook executes once for each ref to be updated, and takes
 three parameters:
@@ -135,9 +136,10 @@ post-update
 -----------
 
 This hook is invoked by `git-receive-pack` on the remote repository,
-which happens when a `git push` is done on a local repository.
-It executes on the remote repository once after all the refs have
-been updated.
+which happens when a `git push` is done on a local repository
+It is also invoked on the local repository anytime a ref value is
+updated (that includes mainly fetches, merges, commits).  It executes
+on the repository once after all the refs have been updated.
 
 It takes a variable number of parameters, each of which is the
 name of ref that was actually updated.
diff --git a/Makefile b/Makefile
index 2962c2e..8e58585 100644
--- a/Makefile
+++ b/Makefile
@@ -263,7 +263,7 @@ LIB_OBJS = \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
 	write_or_die.o trace.o list-objects.o grep.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
-	color.o wt-status.o archive-zip.o archive-tar.o
+	color.o wt-status.o archive-zip.o archive-tar.o hooks.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index b34e598..546cbb1 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "refs.h"
 #include "builtin.h"
+#include "hooks.h"
 
 static const char git_update_ref_usage[] =
 "git-update-ref [-m <reason>] (-d <refname> <value> | <refname> <value> [<oldval>])";
@@ -11,6 +12,7 @@ int cmd_update_ref(int argc, const char 
 	struct ref_lock *lock;
 	unsigned char sha1[20], oldsha1[20];
 	int i, delete;
+	struct command *cmd;
 
 	delete = 0;
 	setup_ident();
@@ -63,9 +65,17 @@ int cmd_update_ref(int argc, const char 
 	lock = lock_any_ref_for_update(refname, oldval ? oldsha1 : NULL);
 	if (!lock)
 		return 1;
+	if (run_update_hook(refname, oldval, value)) {
+		unlock_ref(lock);
+		return 1;
+	}
 	if (write_ref_sha1(lock, sha1, msg) < 0)
 		return 1;
-
 	/* write_ref_sha1 always unlocks the ref, no need to do it explicitly */
+
+	cmd = xmalloc(sizeof(struct command) + strlen(refname) + 1);
+	strcpy(cmd->ref_name, refname);
+	run_update_post_hook(cmd);
+
 	return 0;
 }
diff --git a/hooks.c b/hooks.c
new file mode 100644
index 0000000..efade2b
--- /dev/null
+++ b/hooks.c
@@ -0,0 +1,68 @@
+#include "cache.h"
+#include "run-command.h"
+#include "hooks.h"
+
+
+static char update_hook[] = "hooks/update";
+
+int run_update_hook(const char *refname, const char *old_hex, const char *new_hex)
+{
+	char *update_hook_p = git_path("%s", update_hook);
+	int code;
+
+	if (access(update_hook_p, X_OK) < 0)
+		return 0;
+	code = run_command(update_hook_p, refname, old_hex, new_hex, NULL);
+	switch (code) {
+	case 0:
+		return 0;
+	case -ERR_RUN_COMMAND_FORK:
+		return error("hook fork failed");
+	case -ERR_RUN_COMMAND_EXEC:
+		return error("hook execute failed");
+	case -ERR_RUN_COMMAND_WAITPID:
+		return error("waitpid failed");
+	case -ERR_RUN_COMMAND_WAITPID_WRONG_PID:
+		return error("waitpid is confused");
+	case -ERR_RUN_COMMAND_WAITPID_SIGNAL:
+		return error("%s died of signal", update_hook);
+	case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
+		return error("%s died strangely", update_hook);
+	default:
+		error("%s exited with error code %d", update_hook, -code);
+		return -code;
+	}
+}
+
+
+static char update_post_hook[] = "hooks/post-update";
+
+void run_update_post_hook(struct command *cmd)
+{
+	char *update_post_hook_p = git_path("%s", update_post_hook);
+	struct command *cmd_p;
+	int argc;
+	const char **argv;
+
+	if (access(update_post_hook_p, X_OK) < 0)
+		return;
+	for (argc = 1, cmd_p = cmd; cmd_p; cmd_p = cmd_p->next) {
+		if (cmd_p->error_string)
+			continue;
+		argc++;
+	}
+	argv = xmalloc(sizeof(*argv) * (1 + argc));
+	argv[0] = update_post_hook_p;
+
+	for (argc = 1, cmd_p = cmd; cmd_p; cmd_p = cmd_p->next) {
+		char *p;
+		if (cmd_p->error_string)
+			continue;
+		p = xmalloc(strlen(cmd_p->ref_name) + 1);
+		strcpy(p, cmd_p->ref_name);
+		argv[argc] = p;
+		argc++;
+	}
+	argv[argc] = NULL;
+	run_command_v_opt(argc, argv, RUN_COMMAND_NO_STDIO);
+}
diff --git a/hooks.h b/hooks.h
new file mode 100644
index 0000000..8ddeca3
--- /dev/null
+++ b/hooks.h
@@ -0,0 +1,15 @@
+#ifndef HOOKS_H
+#define HOOKS_H
+
+int run_update_hook(const char *refname, const char *old_hex, const char *new_hex);
+
+struct command {
+	struct command *next;
+	const char *error_string;
+	unsigned char old_sha1[20];
+	unsigned char new_sha1[20];
+	char ref_name[FLEX_ARRAY]; /* more */
+};
+void run_update_post_hook(struct command *cmd);
+
+#endif
diff --git a/receive-pack.c b/receive-pack.c
index 1fcf3a9..9d5ece6 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -4,6 +4,7 @@ #include "pkt-line.h"
 #include "run-command.h"
 #include "commit.h"
 #include "object.h"
+#include "hooks.h"
 
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
@@ -33,47 +34,8 @@ static void write_head_info(void)
 
 }
 
-struct command {
-	struct command *next;
-	const char *error_string;
-	unsigned char old_sha1[20];
-	unsigned char new_sha1[20];
-	char ref_name[FLEX_ARRAY]; /* more */
-};
-
 static struct command *commands;
 
-static char update_hook[] = "hooks/update";
-
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
-		return error("hook fork failed");
-	case -ERR_RUN_COMMAND_EXEC:
-		return error("hook execute failed");
-	case -ERR_RUN_COMMAND_WAITPID:
-		return error("waitpid failed");
-	case -ERR_RUN_COMMAND_WAITPID_WRONG_PID:
-		return error("waitpid is confused");
-	case -ERR_RUN_COMMAND_WAITPID_SIGNAL:
-		return error("%s died of signal", update_hook);
-	case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
-		return error("%s died strangely", update_hook);
-	default:
-		error("%s exited with error code %d", update_hook, -code);
-		return -code;
-	}
-}
-
 static int update(struct command *cmd)
 {
 	const char *name = cmd->ref_name;
@@ -127,37 +89,6 @@ static int update(struct command *cmd)
 	return 0;
 }
 
-static char update_post_hook[] = "hooks/post-update";
-
-static void run_update_post_hook(struct command *cmd)
-{
-	struct command *cmd_p;
-	int argc;
-	const char **argv;
-
-	if (access(update_post_hook, X_OK) < 0)
-		return;
-	for (argc = 1, cmd_p = cmd; cmd_p; cmd_p = cmd_p->next) {
-		if (cmd_p->error_string)
-			continue;
-		argc++;
-	}
-	argv = xmalloc(sizeof(*argv) * (1 + argc));
-	argv[0] = update_post_hook;
-
-	for (argc = 1, cmd_p = cmd; cmd_p; cmd_p = cmd_p->next) {
-		char *p;
-		if (cmd_p->error_string)
-			continue;
-		p = xmalloc(strlen(cmd_p->ref_name) + 1);
-		strcpy(p, cmd_p->ref_name);
-		argv[argc] = p;
-		argc++;
-	}
-	argv[argc] = NULL;
-	run_command_v_opt(argc, argv, RUN_COMMAND_NO_STDIO);
-}
-
 /*
  * This gets called after(if) we've successfully
  * unpacked the data payload.
