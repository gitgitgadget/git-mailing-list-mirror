From: Joey Hess <joey@kitenet.net>
Subject: [PATCH 1/3] expanded hook api with stdio support
Date: Thu, 29 Dec 2011 21:07:18 -0400
Message-ID: <1325207240-22622-2-git-send-email-joey@kitenet.net>
References: <1325207240-22622-1-git-send-email-joey@kitenet.net>
Cc: Joey Hess <joey@kitenet.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 30 03:30:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgSF1-00089c-Sl
	for gcvg-git-2@lo.gmane.org; Fri, 30 Dec 2011 03:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918Ab1L3CaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Dec 2011 21:30:11 -0500
Received: from wren.kitenet.net ([80.68.85.49]:54720 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918Ab1L3CaI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Dec 2011 21:30:08 -0500
Received: from gnu.kitenet.net (dialup-4.153.83.252.Dial1.Atlanta1.Level3.net [4.153.83.252])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 343A6119271;
	Thu, 29 Dec 2011 21:30:04 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 33F2F46965; Thu, 29 Dec 2011 20:08:09 -0500 (EST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1325207240-22622-1-git-send-email-joey@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187792>

Adds run_hook_complex() and the struct hook, and implements
run_hook() using it.

This new API for hooks will allow for a later refactoring of the existing
ad-hoc hook code for hooks that are fed input on stdin, such as pre-receive,
post-receive, and post-rewrite.

It also adds support for a new class of hooks whose stdout is processed by
git, as well as hooks that both receive stdin and have their stdout
processed. This is controlled by setting "generator" and "reader" members
of the struct hook.

The API provides control over whether a hook must consume all its stdin,
or is free to ignore some of it; this can be specified by using either
feed_hook_in_full() or feed_hook_incomplete() as the "feeder" member of
the struct hook. The stdin feeder runs asynchronously, to avoid blocking
when the hook's stdin is also being read. So the API design limits the
code that needs to run asynchronously, to make it easy to implement
thread-safe feeders.

Finally, the API is designed to be extended in the future, to support
running multiple programs for a single hook action (such as the contents
of a .git/hooks/hook.d/ , or a system-wide hook). This design goal led
to the "generator" and "reader" members of the struct hook, which are
specified such that they can be called repeatedly, with data flowing
between them (via the "data" member), like this:
    generator | hook_prog_1 | reader | generator | hook_prog_2 | reader

Signed-off-by: Joey Hess <joey@kitenet.net>
---
 Documentation/technical/api-run-command.txt |   53 +++++++++++
 run-command.c                               |  132 ++++++++++++++++++++++++---
 run-command.h                               |   58 +++++++++++-
 3 files changed, 226 insertions(+), 17 deletions(-)

diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
index f18b4f4..ff50d2f 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -87,6 +87,17 @@ The functions above do the following:
 	On execution, .stdout_to_stderr and .no_stdin will be set.
 	(See below.)
 
+`run_hook_complex`::
+
+	Run a hook, with the caller providing its stdin and/or parsing its
+	stdout.
+	Takes a pointer to a `struct hook` that specifies the details,
+	including the name of the hook, any parameters to pass to it,
+	and how to handle the stdin and stdout. (See below.)
+	If the hook does not exist or is not executable, the return value
+	will be zero.
+	If it is executable, the hook will be executed and the exit
+	status of the hook is returned.
 
 Data structures
 ---------------
@@ -241,3 +252,45 @@ a forked process otherwise:
 
 . It must not change the program's state that the caller of the
   facility also uses.
+
+* `struct hook`
+
+This describes a hook to run.
+
+The caller:
+
+1. allocates and clears (memset(&hook, 0, sizeof(hook));) a
+   struct hook variable;
+2. initializes the members;
+3. calls hook();
+4. if necessary, accesses data read from the hook in .data
+5. frees the struct hook.
+
+The `struct hook` has three function pointers that may be set to
+control the stdin that is sent to the hook, and to collect its stdout.
+
+The `generator` generates the stdin for the hook, returning it in a strbuf.
+It is passed a pointer to the `struct hook`.
+
+The `feeder` is run asynchronously to feed the generated stdin into the hook.
+It is passed the handle to write to, the strbuf containing the stdin, and 
+a pointer to the `struct hook`, and should return non-zero on failure.
+Typically it is set to either `feed_hook_in_full`, or `feed_hook_incomplete`.
+
+The `reader` reads and processes the hook's stdout. It is passed 
+a handle to read from and a pointer to the `struct hook`, and should return
+non-zero on failure.
+
+If the generator or feeder are NULL, the hook is not fed anything
+on stdin; if the `reader` is NULL, the hook's stdout is sent to
+stderr instead.
+
+Note that in the future, the generator, feeder, and reader might be run
+more than once, if multiple programs are run as part of a single hook.
+Therefore, all three should avoid taking any actions except for generating
+the stdin, writing it to the hook, reading/parsing the hook's stdout,
+and printing any necessary warning messages.
+
+The `struct hook` also contains a `data` pointer, which can be used
+to communicate between the generator, feeder, reader, and the
+caller of the hook.
diff --git a/run-command.c b/run-command.c
index 1c51043..42a9b06 100644
--- a/run-command.c
+++ b/run-command.c
@@ -605,34 +605,136 @@ int finish_async(struct async *async)
 
 int run_hook(const char *index_file, const char *name, ...)
 {
-	struct child_process hook;
+	struct hook hook;
 	struct argv_array argv = ARGV_ARRAY_INIT;
-	const char *p, *env[2];
-	char index[PATH_MAX];
+	const char *p;
 	va_list args;
 	int ret;
 
-	if (access(git_path("hooks/%s", name), X_OK) < 0)
-		return 0;
-
 	va_start(args, name);
-	argv_array_push(&argv, git_path("hooks/%s", name));
 	while ((p = va_arg(args, const char *)))
 		argv_array_push(&argv, p);
 	va_end(args);
 
 	memset(&hook, 0, sizeof(hook));
-	hook.argv = argv.argv;
-	hook.no_stdin = 1;
-	hook.stdout_to_stderr = 1;
-	if (index_file) {
-		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
+	hook.name = name;
+	hook.index_file = index_file;
+	hook.argv_array = &argv;
+	ret = run_hook_complex(&hook);
+
+	argv_array_clear(&argv);
+	return ret;
+}
+
+struct feed_hook_with {
+	struct strbuf *buf;
+	struct hook *hook;
+};
+
+/*
+ * An async process is used to feed the hook its stdin.
+ * This allows the hook to read and write at its own pace without blocking.
+ */
+static int feed_hook_async(int in, int out, void *data)
+{
+	struct feed_hook_with *feedwith = data;
+	int ret = feedwith->hook->feeder(out, feedwith->buf, feedwith->hook);
+	close(out);
+	return ret;
+}
+
+/*
+ * Runs a hook, if it exists. Returns non-zero if the hook fails to run
+ * correctly.
+ */
+int run_hook_complex(struct hook *hook)
+{
+	char *command;
+	struct child_process child;
+	struct async async;
+	struct feed_hook_with feedwith = { 0, hook };
+	struct argv_array argv = ARGV_ARRAY_INIT;
+	const char *env[2];
+	char index[PATH_MAX];
+	int res = 0;
+	int i;
+
+	command = git_path("hooks/%s", hook->name);
+	if (access(command, X_OK) < 0)
+		return 0;
+
+	memset(&child, 0, sizeof(child));
+	argv_array_push(&argv, command);
+	if (hook->argv_array)
+		for (i = 0; i < hook->argv_array->argc; i++)
+			argv_array_push(&argv, hook->argv_array->argv[i]);
+	child.argv = argv.argv;
+	if (hook->generator && hook->feeder)
+		child.in = -1;
+	else
+		child.no_stdin = 1;
+	if (hook->reader)
+		child.out = -1;
+	else
+		child.stdout_to_stderr = 1;
+	if (hook->index_file) {
+		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s",
+				hook->index_file);
 		env[0] = index;
 		env[1] = NULL;
-		hook.env = env;
+		child.env = env;
+	}
+	res |= start_command(&child);
+	if (res) goto hook_out;
+
+	if (hook->generator && hook->feeder) {
+		feedwith.buf = hook->generator(hook);
+		if (! feedwith.buf) {
+			res = 1;
+			goto hook_out;
+		}
+
+		memset(&async, 0, sizeof(async));
+		async.proc = feed_hook_async;
+		async.data = &feedwith;
+		async.out = child.in;
+		res |= start_async(&async);
+		if (res) {
+			close(child.in);
+			close(child.out);
+			finish_command(&child);
+			goto hook_out;
+		}
 	}
 
-	ret = run_command(&hook);
+	if (hook->reader)
+		res |= hook->reader(child.out, hook);
+	if (hook->generator && hook->feeder)
+	       res |= finish_async(&async);
+	res |= finish_command(&child);
+
+ hook_out:
+	if (feedwith.buf)
+		strbuf_release(feedwith.buf);
 	argv_array_clear(&argv);
-	return ret;
+
+	return res;
+}
+
+/* A feeder that ensures the hook consumes all its stdin. */
+int feed_hook_in_full(int handle, struct strbuf *buf, struct hook *hook)
+{
+	if (write_in_full(handle, buf->buf, buf->len) != buf->len) {
+		warning("%s hook failed to consume all its input", hook->name);
+		return 1;
+	}
+	else
+		return 0;
+}
+
+/* A feeder that does not require the hook consume all its stdin. */
+int feed_hook_incomplete(int handle, struct strbuf *buf, struct hook *hook)
+{
+	write_in_full(handle, buf->buf, buf->len);
+	return 0;
 }
diff --git a/run-command.h b/run-command.h
index 56491b9..54c9b83 100644
--- a/run-command.h
+++ b/run-command.h
@@ -45,8 +45,6 @@ int start_command(struct child_process *);
 int finish_command(struct child_process *);
 int run_command(struct child_process *);
 
-extern int run_hook(const char *index_file, const char *name, ...);
-
 #define RUN_COMMAND_NO_STDIN 1
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
 #define RUN_COMMAND_STDOUT_TO_STDERR 4
@@ -90,4 +88,60 @@ struct async {
 int start_async(struct async *async);
 int finish_async(struct async *async);
 
+/*
+ * This data structure controls how a hook is run.
+ */
+struct hook {
+	/* The name of the hook being run. */
+	const char *name;
+	/*
+	 * Parameters to pass to the hook program, not including the name
+	 * of the hook. May be NULL.
+	 */
+	struct argv_array *argv_array;
+	/*
+	 * Pathname to an index file to use, or NULL if the hook
+	 * uses the default index file or no index is needed.
+	 */
+	const char *index_file;
+	/*
+	 * An arbitrary data structure, can be used to communicate between
+	 * the generator, feeder, reader, and the caller of the hook.
+	 */
+	void *data;
+	/*
+	 * Populates a strbuf with the content to send to the
+	 * hook on its standard input.
+	 *
+	 * May be NULL, if the hook does not consume standard input.
+	 */
+	struct strbuf *(*generator)(struct hook *hook);
+	/*
+	 * Feeds generated content to the hook on its standard input
+	 * via the handle. Returns non-zero on failure.
+	 *
+	 * May be NULL, if the hook does not consume standard input.
+	 *
+	 * Note that the feeder is run as an async process, and so should
+	 * avoid modifying any global state, and only use thread-safe
+	 * operations. It may be run more than once.
+	 */
+	int (*feeder)(int handle, struct strbuf *data, struct hook *hook);
+	/*
+	 * Processes the hook's standard output from the handle,
+	 * returning non-zero on failure.
+	 *
+	 * May be NULL, if the hook's stdin is not processed. (It will
+	 * instead be redirected to stderr.)
+	 */
+	int (*reader)(int handle, struct hook *hook);
+};
+
+extern int run_hook(const char *index_file, const char *name, ...);
+
+extern int run_hook_complex(struct hook *hook);
+
+extern int feed_hook_in_full(int handle, struct strbuf *buf, struct hook *hook);
+extern int feed_hook_incomplete(int handle, struct strbuf *buf, struct hook *hook);
+
 #endif
-- 
1.7.7.3
