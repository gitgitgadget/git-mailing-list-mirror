From: Jeff King <peff@peff.net>
Subject: [PATCH v3 07/22] convert manual allocations to argv_array
Date: Mon, 22 Feb 2016 17:44:21 -0500
Message-ID: <20160222224421.GG10075@sigill.intra.peff.net>
References: <20160222224059.GA3857@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 23:44:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXzDQ-0004vd-19
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756074AbcBVWoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:44:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:47070 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756015AbcBVWoX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:44:23 -0500
Received: (qmail 21659 invoked by uid 102); 22 Feb 2016 22:44:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:44:23 -0500
Received: (qmail 23027 invoked by uid 107); 22 Feb 2016 22:44:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:44:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 17:44:21 -0500
Content-Disposition: inline
In-Reply-To: <20160222224059.GA3857@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286977>

There are many manual argv allocations that predate the
argv_array API. Switching to that API brings a few
advantages:

  1. We no longer have to manually compute the correct final
     array size (so it's one less thing we can screw up).

  2. In many cases we had to make a separate pass to count,
     then allocate, then fill in the array. Now we can do it
     in one pass, making the code shorter and easier to
     follow.

  3. argv_array handles memory ownership for us, making it
     more obvious when things should be free()d and and when
     not.

Most of these cases are pretty straightforward. In some, we
switch from "run_command_v" to "run_command" which lets us
directly use the argv_array embedded in "struct
child_process".

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/grep.c         | 10 +++++-----
 builtin/receive-pack.c | 12 +++---------
 builtin/remote-ext.c   | 26 +++++---------------------
 daemon.c               | 12 +++++-------
 git.c                  | 14 +++++---------
 line-log.c             | 22 +++++++++-------------
 remote-curl.c          | 23 +++++++++++------------
 7 files changed, 43 insertions(+), 76 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 8c516a9..aa7435f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -365,17 +365,17 @@ static void append_path(struct grep_opt *opt, const void *data, size_t len)
 static void run_pager(struct grep_opt *opt, const char *prefix)
 {
 	struct string_list *path_list = opt->output_priv;
-	const char **argv = xmalloc(sizeof(const char *) * (path_list->nr + 1));
+	struct child_process child = CHILD_PROCESS_INIT;
 	int i, status;
 
 	for (i = 0; i < path_list->nr; i++)
-		argv[i] = path_list->items[i].string;
-	argv[path_list->nr] = NULL;
+		argv_array_push(&child.args, path_list->items[i].string);
+	child.dir = prefix;
+	child.use_shell = 1;
 
-	status = run_command_v_opt_cd_env(argv, RUN_USING_SHELL, prefix, NULL);
+	status = run_command(&child);
 	if (status)
 		exit(status);
-	free(argv);
 }
 
 static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int cached)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index f2d6761..932afab 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1031,7 +1031,6 @@ static void run_update_post_hook(struct command *commands)
 {
 	struct command *cmd;
 	int argc;
-	const char **argv;
 	struct child_process proc = CHILD_PROCESS_INIT;
 	const char *hook;
 
@@ -1044,21 +1043,16 @@ static void run_update_post_hook(struct command *commands)
 	if (!argc || !hook)
 		return;
 
-	argv = xmalloc(sizeof(*argv) * (2 + argc));
-	argv[0] = hook;
-
-	for (argc = 1, cmd = commands; cmd; cmd = cmd->next) {
+	argv_array_push(&proc.args, hook);
+	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string || cmd->did_not_exist)
 			continue;
-		argv[argc] = xstrdup(cmd->ref_name);
-		argc++;
+		argv_array_push(&proc.args, cmd->ref_name);
 	}
-	argv[argc] = NULL;
 
 	proc.no_stdin = 1;
 	proc.stdout_to_stderr = 1;
 	proc.err = use_sideband ? -1 : 0;
-	proc.argv = argv;
 
 	if (!start_command(&proc)) {
 		if (use_sideband)
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index e3cd25d..7457c74 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -114,30 +114,14 @@ static char *strip_escapes(const char *str, const char *service,
 	}
 }
 
-/* Should be enough... */
-#define MAXARGUMENTS 256
-
-static const char **parse_argv(const char *arg, const char *service)
+static void parse_argv(struct argv_array *out, const char *arg, const char *service)
 {
-	int arguments = 0;
-	int i;
-	const char **ret;
-	char *temparray[MAXARGUMENTS + 1];
-
 	while (*arg) {
-		char *expanded;
-		if (arguments == MAXARGUMENTS)
-			die("remote-ext command has too many arguments");
-		expanded = strip_escapes(arg, service, &arg);
+		char *expanded = strip_escapes(arg, service, &arg);
 		if (expanded)
-			temparray[arguments++] = expanded;
+			argv_array_push(out, expanded);
+		free(expanded);
 	}
-
-	ret = xmalloc((arguments + 1) * sizeof(char *));
-	for (i = 0; i < arguments; i++)
-		ret[i] = temparray[i];
-	ret[arguments] = NULL;
-	return ret;
 }
 
 static void send_git_request(int stdin_fd, const char *serv, const char *repo,
@@ -158,7 +142,7 @@ static int run_child(const char *arg, const char *service)
 	child.in = -1;
 	child.out = -1;
 	child.err = 0;
-	child.argv = parse_argv(arg, service);
+	parse_argv(&child.args, arg, service);
 
 	if (start_command(&child) < 0)
 		die("Can't run specified command");
diff --git a/daemon.c b/daemon.c
index 46b411c..8d45c33 100644
--- a/daemon.c
+++ b/daemon.c
@@ -808,7 +808,7 @@ static void check_dead_children(void)
 			cradle = &blanket->next;
 }
 
-static char **cld_argv;
+static struct argv_array cld_argv = ARGV_ARRAY_INIT;
 static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 {
 	struct child_process cld = CHILD_PROCESS_INIT;
@@ -842,7 +842,7 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 #endif
 	}
 
-	cld.argv = (const char **)cld_argv;
+	cld.argv = cld_argv.argv;
 	cld.in = incoming;
 	cld.out = dup(incoming);
 
@@ -1374,12 +1374,10 @@ int main(int argc, char **argv)
 		write_file(pid_file, "%"PRIuMAX, (uintmax_t) getpid());
 
 	/* prepare argv for serving-processes */
-	cld_argv = xmalloc(sizeof (char *) * (argc + 2));
-	cld_argv[0] = argv[0];	/* git-daemon */
-	cld_argv[1] = "--serve";
+	argv_array_push(&cld_argv, argv[0]); /* git-daemon */
+	argv_array_push(&cld_argv, "--serve");
 	for (i = 1; i < argc; ++i)
-		cld_argv[i+1] = argv[i];
-	cld_argv[argc+1] = NULL;
+		argv_array_push(&cld_argv, argv[i]);
 
 	return serve(&listen_addr, listen_port, cred);
 }
diff --git a/git.c b/git.c
index 6c64c94..087ad31 100644
--- a/git.c
+++ b/git.c
@@ -247,20 +247,16 @@ static int handle_alias(int *argcp, const char ***argv)
 	alias_string = alias_lookup(alias_command);
 	if (alias_string) {
 		if (alias_string[0] == '!') {
-			const char **alias_argv;
-			int argc = *argcp, i;
+			struct child_process child = CHILD_PROCESS_INIT;
 
 			commit_pager_choice();
 			restore_env(1);
 
-			/* build alias_argv */
-			alias_argv = xmalloc(sizeof(*alias_argv) * (argc + 1));
-			alias_argv[0] = alias_string + 1;
-			for (i = 1; i < argc; ++i)
-				alias_argv[i] = (*argv)[i];
-			alias_argv[argc] = NULL;
+			child.use_shell = 1;
+			argv_array_push(&child.args, alias_string + 1);
+			argv_array_pushv(&child.args, (*argv) + 1);
 
-			ret = run_command_v_opt(alias_argv, RUN_USING_SHELL);
+			ret = run_command(&child);
 			if (ret >= 0)   /* normal exit */
 				exit(ret);
 
diff --git a/line-log.c b/line-log.c
index af6e2f7..5877986 100644
--- a/line-log.c
+++ b/line-log.c
@@ -14,6 +14,7 @@
 #include "graph.h"
 #include "userdiff.h"
 #include "line-log.h"
+#include "argv-array.h"
 
 static void range_set_grow(struct range_set *rs, size_t extra)
 {
@@ -746,22 +747,17 @@ void line_log_init(struct rev_info *rev, const char *prefix, struct string_list
 	add_line_range(rev, commit, range);
 
 	if (!rev->diffopt.detect_rename) {
-		int i, count = 0;
-		struct line_log_data *r = range;
+		struct line_log_data *r;
+		struct argv_array array = ARGV_ARRAY_INIT;
 		const char **paths;
-		while (r) {
-			count++;
-			r = r->next;
-		}
-		paths = xmalloc((count+1)*sizeof(char *));
-		r = range;
-		for (i = 0; i < count; i++) {
-			paths[i] = xstrdup(r->path);
-			r = r->next;
-		}
-		paths[count] = NULL;
+
+		for (r = range; r; r = r->next)
+			argv_array_push(&array, r->path);
+		paths = argv_array_detach(&array);
+
 		parse_pathspec(&rev->diffopt.pathspec, 0,
 			       PATHSPEC_PREFER_FULL, "", paths);
+		/* strings are now owned by pathspec */
 		free(paths);
 	}
 }
diff --git a/remote-curl.c b/remote-curl.c
index c704857..42deeec 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -845,23 +845,22 @@ static void parse_fetch(struct strbuf *buf)
 
 static int push_dav(int nr_spec, char **specs)
 {
-	const char **argv = xmalloc((10 + nr_spec) * sizeof(char*));
-	int argc = 0, i;
+	struct child_process child = CHILD_PROCESS_INIT;
+	size_t i;
 
-	argv[argc++] = "http-push";
-	argv[argc++] = "--helper-status";
+	child.git_cmd = 1;
+	argv_array_push(&child.args, "http-push");
+	argv_array_push(&child.args, "--helper-status");
 	if (options.dry_run)
-		argv[argc++] = "--dry-run";
+		argv_array_push(&child.args, "--dry-run");
 	if (options.verbosity > 1)
-		argv[argc++] = "--verbose";
-	argv[argc++] = url.buf;
+		argv_array_push(&child.args, "--verbose");
+	argv_array_push(&child.args, url.buf);
 	for (i = 0; i < nr_spec; i++)
-		argv[argc++] = specs[i];
-	argv[argc++] = NULL;
+		argv_array_push(&child.args, specs[i]);
 
-	if (run_command_v_opt(argv, RUN_GIT_CMD))
-		die("git-%s failed", argv[0]);
-	free(argv);
+	if (run_command(&child))
+		die("git-http-push failed");
 	return 0;
 }
 
-- 
2.7.2.645.g4e1306c
