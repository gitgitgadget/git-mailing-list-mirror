From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 2/5] Move run_hook() from builtin-commit.c into run-command.c (libgit)
Date: Fri, 16 Jan 2009 20:09:59 +0100
Message-ID: <1232133002-21725-2-git-send-email-s-beyer@gmx.net>
References: <20090116172521.GD28177@leksak.fem-net>
 <1232133002-21725-1-git-send-email-s-beyer@gmx.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>, gitster@pobox.com,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 20:11:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNu6Y-00051V-5X
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 20:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765268AbZAPTKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 14:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764380AbZAPTKN
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 14:10:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:48967 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763663AbZAPTKI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 14:10:08 -0500
Received: (qmail invoked by alias); 16 Jan 2009 19:10:06 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp009) with SMTP; 16 Jan 2009 20:10:06 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19hVWxcRathqUmYRDJcaXuP0wKaJyceFAI8DRVr39
	QvrU/A8otNbEpg
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LNu4w-0005fJ-M5; Fri, 16 Jan 2009 20:10:02 +0100
X-Mailer: git-send-email 1.6.1.160.gecdb
In-Reply-To: <1232133002-21725-1-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105986>

A function that runs a hook is used in several Git commands.
builtin-commit.c has the one that is most general for cases without
piping. The one in builtin-gc.c prints some useful warnings.
This patch moves a merged version of these variants into libgit and
lets the other builtins use this libified run_hook().

The run_hook() function used in receive-pack.c feeds the standard
input of the pre-receive or post-receive hooks. This function is
renamed to run_receive_hook() because the libified run_hook() cannot
handle this.

Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

	A quick comparison to v1:
	 - builtin-checkout.c/post_checkout_hook() makes use of
	   run_hook() now.
	 - The lost warnings Dscho pointed at are in the libified
	   run_hook() now.

 builtin-checkout.c     |   22 +++++-----------------
 builtin-commit.c       |   34 ----------------------------------
 builtin-gc.c           |   30 +-----------------------------
 builtin-merge.c        |   31 +------------------------------
 builtin-receive-pack.c |    6 +++---
 run-command.c          |   45 +++++++++++++++++++++++++++++++++++++++++++++
 run-command.h          |    2 ++
 7 files changed, 57 insertions(+), 113 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 149343e..275176d 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -38,25 +38,13 @@ struct checkout_opts {
 static int post_checkout_hook(struct commit *old, struct commit *new,
 			      int changed)
 {
-	struct child_process proc;
-	const char *name = git_path("hooks/post-checkout");
-	const char *argv[5];
-
-	if (access(name, X_OK) < 0)
-		return 0;
-
-	memset(&proc, 0, sizeof(proc));
-	argv[0] = name;
-	argv[1] = sha1_to_hex(old ? old->object.sha1 : null_sha1);
-	argv[2] = sha1_to_hex(new ? new->object.sha1 : null_sha1);
+	return run_hook(NULL, "post-checkout",
+			sha1_to_hex(old ? old->object.sha1 : null_sha1),
+			sha1_to_hex(new ? new->object.sha1 : null_sha1),
+			changed ? "1" : "0", NULL);
 	/* "new" can be NULL when checking out from the index before
 	   a commit exists. */
-	argv[3] = changed ? "1" : "0";
-	argv[4] = NULL;
-	proc.argv = argv;
-	proc.no_stdin = 1;
-	proc.stdout_to_stderr = 1;
-	return run_command(&proc);
+
 }
 
 static int update_some(const unsigned char *sha1, const char *base, int baselen,
diff --git a/builtin-commit.c b/builtin-commit.c
index e88b78f..6f8d9fb 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -361,40 +361,6 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	return s.commitable;
 }
 
-static int run_hook(const char *index_file, const char *name, ...)
-{
-	struct child_process hook;
-	const char *argv[10], *env[2];
-	char index[PATH_MAX];
-	va_list args;
-	int i;
-
-	va_start(args, name);
-	argv[0] = git_path("hooks/%s", name);
-	i = 0;
-	do {
-		if (++i >= ARRAY_SIZE(argv))
-			die ("run_hook(): too many arguments");
-		argv[i] = va_arg(args, const char *);
-	} while (argv[i]);
-	va_end(args);
-
-	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
-	env[0] = index;
-	env[1] = NULL;
-
-	if (access(argv[0], X_OK) < 0)
-		return 0;
-
-	memset(&hook, 0, sizeof(hook));
-	hook.argv = argv;
-	hook.no_stdin = 1;
-	hook.stdout_to_stderr = 1;
-	hook.env = env;
-
-	return run_command(&hook);
-}
-
 static int is_a_merge(const unsigned char *sha1)
 {
 	struct commit *commit = lookup_commit(sha1);
diff --git a/builtin-gc.c b/builtin-gc.c
index f8eae4a..a201438 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -144,34 +144,6 @@ static int too_many_packs(void)
 	return gc_auto_pack_limit <= cnt;
 }
 
-static int run_hook(void)
-{
-	const char *argv[2];
-	struct child_process hook;
-	int ret;
-
-	argv[0] = git_path("hooks/pre-auto-gc");
-	argv[1] = NULL;
-
-	if (access(argv[0], X_OK) < 0)
-		return 0;
-
-	memset(&hook, 0, sizeof(hook));
-	hook.argv = argv;
-	hook.no_stdin = 1;
-	hook.stdout_to_stderr = 1;
-
-	ret = start_command(&hook);
-	if (ret) {
-		warning("Could not spawn %s", argv[0]);
-		return ret;
-	}
-	ret = finish_command(&hook);
-	if (ret == -ERR_RUN_COMMAND_WAITPID_SIGNAL)
-		warning("%s exited due to uncaught signal", argv[0]);
-	return ret;
-}
-
 static int need_to_gc(void)
 {
 	/*
@@ -194,7 +166,7 @@ static int need_to_gc(void)
 	else if (!too_many_loose_objects())
 		return 0;
 
-	if (run_hook())
+	if (run_hook(NULL, "pre-auto-gc", NULL))
 		return 0;
 	return 1;
 }
diff --git a/builtin-merge.c b/builtin-merge.c
index cf86975..e4555b0 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -300,35 +300,6 @@ static void squash_message(void)
 	strbuf_release(&out);
 }
 
-static int run_hook(const char *name)
-{
-	struct child_process hook;
-	const char *argv[3], *env[2];
-	char index[PATH_MAX];
-
-	argv[0] = git_path("hooks/%s", name);
-	if (access(argv[0], X_OK) < 0)
-		return 0;
-
-	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", get_index_file());
-	env[0] = index;
-	env[1] = NULL;
-
-	if (squash)
-		argv[1] = "1";
-	else
-		argv[1] = "0";
-	argv[2] = NULL;
-
-	memset(&hook, 0, sizeof(hook));
-	hook.argv = argv;
-	hook.no_stdin = 1;
-	hook.stdout_to_stderr = 1;
-	hook.env = env;
-
-	return run_command(&hook);
-}
-
 static void finish(const unsigned char *new_head, const char *msg)
 {
 	struct strbuf reflog_message = STRBUF_INIT;
@@ -374,7 +345,7 @@ static void finish(const unsigned char *new_head, const char *msg)
 	}
 
 	/* Run a post-merge hook */
-	run_hook("post-merge");
+	run_hook(NULL, "post-merge", squash ? "1" : "0", NULL);
 
 	strbuf_release(&reflog_message);
 }
diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index db67c31..6564a97 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -136,7 +136,7 @@ static int hook_status(int code, const char *hook_name)
 	}
 }
 
-static int run_hook(const char *hook_name)
+static int run_receive_hook(const char *hook_name)
 {
 	static char buf[sizeof(commands->old_sha1) * 2 + PATH_MAX + 4];
 	struct command *cmd;
@@ -358,7 +358,7 @@ static void execute_commands(const char *unpacker_error)
 		return;
 	}
 
-	if (run_hook(pre_receive_hook)) {
+	if (run_receive_hook(pre_receive_hook)) {
 		while (cmd) {
 			cmd->error_string = "pre-receive hook declined";
 			cmd = cmd->next;
@@ -627,7 +627,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			unlink(pack_lockfile);
 		if (report_status)
 			report(unpack_status);
-		run_hook(post_receive_hook);
+		run_receive_hook(post_receive_hook);
 		run_update_post_hook(commands);
 	}
 	return 0;
diff --git a/run-command.c b/run-command.c
index c90cdc5..49810a8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -342,3 +342,48 @@ int finish_async(struct async *async)
 #endif
 	return ret;
 }
+
+int run_hook(const char *index_file, const char *name, ...)
+{
+	struct child_process hook;
+	const char *argv[10], *env[2];
+	char index[PATH_MAX];
+	va_list args;
+	int ret;
+	int i;
+
+	va_start(args, name);
+	argv[0] = git_path("hooks/%s", name);
+	i = 0;
+	do {
+		if (++i >= ARRAY_SIZE(argv))
+			die("run_hook(): too many arguments");
+		argv[i] = va_arg(args, const char *);
+	} while (argv[i]);
+	va_end(args);
+
+	if (access(argv[0], X_OK) < 0)
+		return 0;
+
+	memset(&hook, 0, sizeof(hook));
+	hook.argv = argv;
+	hook.no_stdin = 1;
+	hook.stdout_to_stderr = 1;
+	if (index_file) {
+		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
+		env[0] = index;
+		env[1] = NULL;
+		hook.env = env;
+	}
+
+	ret = start_command(&hook);
+	if (ret) {
+		warning("Could not spawn %s", argv[0]);
+		return ret;
+	}
+	ret = finish_command(&hook);
+	if (ret == -ERR_RUN_COMMAND_WAITPID_SIGNAL)
+		warning("%s exited due to uncaught signal", argv[0]);
+
+	return ret;
+}
diff --git a/run-command.h b/run-command.h
index a8b0c20..0211e1d 100644
--- a/run-command.h
+++ b/run-command.h
@@ -49,6 +49,8 @@ int start_command(struct child_process *);
 int finish_command(struct child_process *);
 int run_command(struct child_process *);
 
+extern int run_hook(const char *index_file, const char *name, ...);
+
 #define RUN_COMMAND_NO_STDIN 1
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
 #define RUN_COMMAND_STDOUT_TO_STDERR 4
-- 
1.6.1.160.gecdb
