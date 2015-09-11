From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] fetch: fetch submodules in parallel
Date: Fri, 11 Sep 2015 16:09:54 -0700
Message-ID: <1442012994-20374-3-git-send-email-sbeller@google.com>
References: <1442012994-20374-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 12 01:10:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaXSP-0002nS-Ml
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 01:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393AbbIKXKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 19:10:07 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35451 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755342AbbIKXKB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 19:10:01 -0400
Received: by pacfv12 with SMTP id fv12so88445167pac.2
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 16:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c3hI374Lb01WcndjBfGefu0nasroJsWdgqSb4II8GVQ=;
        b=FCbncOMDYi8l9nzQAoglkD9snNEJGBI2uUF8UFKObZZKKOKi9mBcarez+FcNaKtAFD
         8YJntlAMbqmO8LpVuUB4LXWMeGERoiPbz6RvLedtHY/7n0noN8NPsz//VmkBIQRFOfCS
         v9gMqUOSBoowdNkV81xWBTSysP7N6Fq3DJQnMkjvpcp2TeKKexkgFDVSZwP+2nF2DtFb
         pGMhnLdvSNyzA62KELglRZFWvpj7JsMl/KIaslwP4ZTaE92Q+zuS0AZFJQPaVu5EDgEj
         wCgNtB/FV+x+hFpA1bHHIb9fliZP82UDDI+oBH1/BdzeDrUj7eZ7wcLEFrF64D/ncWnx
         kxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c3hI374Lb01WcndjBfGefu0nasroJsWdgqSb4II8GVQ=;
        b=EspWhRBxCksBkrLTzbXEiEpbx5JJJajedtOqHwWEyTE6dTRtC1ac31H53wXmzg+LgN
         VK7Dmg7eu2vz1HhbEMJwhbMfIsbCXW2QK47CV0MGhJYWKQlEaXf/6L0AUDrpKZfwGSl2
         wsyedkb9+eTHT/ZKqJe7/55f3CJOaWoOvpit41MlRV9RVDP0ksWgUtSe0c9FHko5tZoE
         BsN9/rIBEXxHb2YabMq6bwKZdmdFszJqMBSyKAFgvVzF/tvd5fpOaHBZwRzdVoFaY6d9
         NqGr8VdXDtfh/bwdx41mkQdBlXtDwLlkekR63e1TK+hE2I+JNVxr0ztXf7QBit4hHI8r
         +gGw==
X-Gm-Message-State: ALoCoQn6qmEfWwdgqglzryrttYjS2s4ySvbKMuEWfN4bJPsObLwFhkRqI84TWSVj6g0fkSP3PO9O
X-Received: by 10.68.99.197 with SMTP id es5mr2794961pbb.112.1442013000359;
        Fri, 11 Sep 2015 16:10:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:44ea:73dc:b756:adf])
        by smtp.gmail.com with ESMTPSA id qe3sm2324493pbc.73.2015.09.11.16.09.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 11 Sep 2015 16:09:59 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc0.131.gf624c3d
In-Reply-To: <1442012994-20374-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277706>

If we run external commands in parallel we cannot pipe the output directly
to the our stdout/err as it would mix up. So each process's output will
flow through a pipe, which we buffer. One subprocess can be directly
piped to out stdout/err for a low latency feedback to the user.

Example:
Let's assume we have 5 submodules A,B,C,D,E and each fetch takes a
different amount of time as the different submodules vary in size, then
the output of fetches in sequential order might look like this:

 time -->
 output: |---A---|   |-B-|   |----C-----------|   |-D-|   |-E-|

When we schedule these submodules into maximal two parallel processes,
a schedule and sample output over time may look like this:

thread 1: |---A---|   |-D-|   |-E-|

thread 2: |-B-|   |----C-----------|

output:   |---A---|B|------C-------|DE

So A will be perceived as it would run normally in the single child
version. As B has finished by the time A is done, we can dump its whole
progress buffer on stderr, such that it looks like it finished in no time.
Once that is done, C is determined to be the visible child and its progress
will be reported in real time.

So this way of output is really good for human consumption,
as it only changes the timing, not the actual output.

For machine consumption the output needs to be prepared in
the tasks, by either having a prefix per line or per block
to indicate whose tasks output is displayed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/fetch-options.txt |   7 ++
 builtin/fetch.c                 |   6 +-
 builtin/pull.c                  |   6 ++
 run-command.c                   | 144 ++++++++++++++++++++++++++++++++++++++++
 run-command.h                   |  29 ++++++++
 strbuf.c                        |  31 +++++++++
 strbuf.h                        |   1 +
 submodule.c                     |  99 +++++++++++++++++----------
 submodule.h                     |   2 +-
 t/t0061-run-command.sh          |  16 +++++
 t/t5526-fetch-submodules.sh     |  19 ++++++
 test-run-command.c              |  23 +++++++
 12 files changed, 347 insertions(+), 36 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 45583d8..e2a59c3 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -100,6 +100,13 @@ ifndef::git-pull[]
 	reference to a commit that isn't already in the local submodule
 	clone.
 
+-j::
+--jobs=<n>::
+	Number of parallel children to be used for fetching submodules.
+	Each will fetch from different submodules, such that fetching many
+	submodules will be faster. By default submodules will be fetched
+	one at a time
+
 --no-recurse-submodules::
 	Disable recursive fetching of submodules (this has the same effect as
 	using the '--recurse-submodules=no' option).
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ee1f1a9..09ff837 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -37,6 +37,7 @@ static int prune = -1; /* unspecified */
 static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
 static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow;
+static int max_children = 1;
 static const char *depth;
 static const char *upload_pack;
 static struct strbuf default_rla = STRBUF_INIT;
@@ -99,6 +100,8 @@ static struct option builtin_fetch_options[] = {
 		    N_("fetch all tags and associated objects"), TAGS_SET),
 	OPT_SET_INT('n', NULL, &tags,
 		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
+	OPT_INTEGER('j', "jobs", &max_children,
+		    N_("number of threads used for fetching")),
 	OPT_BOOL('p', "prune", &prune,
 		 N_("prune remote-tracking branches no longer on remote")),
 	{ OPTION_CALLBACK, 0, "recurse-submodules", NULL, N_("on-demand"),
@@ -1217,7 +1220,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		result = fetch_populated_submodules(&options,
 						    submodule_prefix,
 						    recurse_submodules,
-						    verbosity < 0);
+						    verbosity < 0,
+						    max_children);
 		argv_array_clear(&options);
 	}
 
diff --git a/builtin/pull.c b/builtin/pull.c
index 722a83c..fbbda67 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -94,6 +94,7 @@ static int opt_force;
 static char *opt_tags;
 static char *opt_prune;
 static char *opt_recurse_submodules;
+static char *max_children;
 static int opt_dry_run;
 static char *opt_keep;
 static char *opt_depth;
@@ -177,6 +178,9 @@ static struct option pull_options[] = {
 		N_("on-demand"),
 		N_("control recursive fetching of submodules"),
 		PARSE_OPT_OPTARG),
+	OPT_PASSTHRU('j', "jobs", &max_children, N_("n"),
+		N_("number of threads used for fetching submodules"),
+		PARSE_OPT_OPTARG),
 	OPT_BOOL(0, "dry-run", &opt_dry_run,
 		N_("dry run")),
 	OPT_PASSTHRU('k', "keep", &opt_keep, NULL,
@@ -524,6 +528,8 @@ static int run_fetch(const char *repo, const char **refspecs)
 		argv_array_push(&args, opt_prune);
 	if (opt_recurse_submodules)
 		argv_array_push(&args, opt_recurse_submodules);
+	if (max_children)
+		argv_array_push(&args, max_children);
 	if (opt_dry_run)
 		argv_array_push(&args, "--dry-run");
 	if (opt_keep)
diff --git a/run-command.c b/run-command.c
index 28e1d55..b8ff67b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -852,3 +852,147 @@ int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint)
 	close(cmd->out);
 	return finish_command(cmd);
 }
+
+int run_processes_async(int n, get_next_task fn, void *data)
+{
+	int i, wait_status;
+	pid_t pid;
+
+	/* no more tasks. Also set when aborting early. */
+	int all_tasks_started = 0;
+	int nr_processes = 0;
+	int child_in_foreground = 0;
+	struct timeval timeout;
+	struct child_process *children = xcalloc(n, sizeof(*children));
+	char *slots = xcalloc(n, sizeof(*slots));
+	struct strbuf *err = xcalloc(n, sizeof(*err));
+	fd_set fdset;
+	int maxfd;
+	struct strbuf finished_children = STRBUF_INIT;
+	int flags;
+	for (i = 0; i < n; i++)
+		strbuf_init(&err[i], 0);
+
+	while (!all_tasks_started || nr_processes > 0) {
+		/* Start new processes. */
+		while (!all_tasks_started && nr_processes < n) {
+			for (i = 0; i < n; i++)
+				if (!slots[i])
+					break; /* found an empty slot */
+			if (i == n)
+				die("BUG: bookkeeping is hard");
+
+			if (fn(data, &children[i], &err[i])) {
+				all_tasks_started = 1;
+				break;
+			}
+			if (start_command(&children[i]))
+				die(_("Could not start child process"));
+			flags = fcntl(children[i].err, F_GETFL);
+			fcntl(children[i].err, F_SETFL, flags | O_NONBLOCK);
+			nr_processes++;
+			slots[i] = 1;
+		}
+
+		/* prepare data for select call */
+		FD_ZERO(&fdset);
+		maxfd = 0;
+		for (i = 0; i < n; i++) {
+			if (!slots[i])
+				continue;
+			FD_SET(children[i].err, &fdset);
+			if (children[i].err > maxfd)
+				maxfd = children[i].err;
+		}
+		timeout.tv_sec = 0;
+		timeout.tv_usec = 500000;
+
+		i = select(maxfd + 1, &fdset, NULL, NULL, &timeout);
+		if (i < 0) {
+			if (errno == EINTR)
+				/* A signal was caught; try again */
+				continue;
+			else if (errno == ENOMEM)
+				die_errno("BUG: keeping track of fds is hard");
+			else if (errno == EINVAL)
+				die_errno("BUG: invalid arguments to select");
+			else if (errno == EBADF)
+				die_errno("BUG: keeping track of fds is hard");
+			else
+				die_errno("Unknown error with select");
+		}
+
+		/* Buffer output from all pipes. */
+		for (i = 0; i < n; i++) {
+			if (!slots[i])
+				continue;
+			if (FD_ISSET(children[i].err, &fdset))
+				strbuf_read_noblock(&err[i], children[i].err, 0);
+			if (child_in_foreground == i) {
+				fputs(err[i].buf, stderr);
+				strbuf_reset(&err[i]);
+				fflush(stderr);
+			}
+		}
+
+		/* Collect finished child processes. */
+		while (nr_processes > 0) {
+			pid = waitpid(-1, &wait_status, WNOHANG);
+			if (pid == 0)
+				/* no child finished */
+				break;
+
+			if (pid < 0) {
+				if (errno == EINTR)
+					break; /* just try again  next time */
+				if (errno == EINVAL || errno == ECHILD)
+					die_errno("wait");
+			} else {
+				/* Find the finished child. */
+				for (i = 0; i < n; i++)
+					if (slots[i] && pid == children[i].pid)
+						break;
+				if (i == n)
+					/* waitpid returned another process id which
+					 * we are not waiting on, so ignore it*/
+					break;
+			}
+
+			strbuf_read_noblock(&err[i], children[i].err, 0);
+			argv_array_clear(&children[i].args);
+			argv_array_clear(&children[i].env_array);
+
+			slots[i] = 0;
+			nr_processes--;
+
+			if (i != child_in_foreground) {
+				strbuf_addbuf(&finished_children, &err[i]);
+				strbuf_reset(&err[i]);
+			} else {
+				fputs(err[i].buf, stderr);
+				strbuf_reset(&err[i]);
+
+				/* Output all other finished child processes */
+				fputs(finished_children.buf, stderr);
+				strbuf_reset(&finished_children);
+
+				/*
+				 * Pick next process to output live.
+				 * There can be no active process if n==1
+				 * NEEDSWORK:
+				 * For now we pick it randomly by doing a round
+				 * robin. Later we may want to pick the one with
+				 * the most output or the longest or shortest
+				 * running process time.
+				 */
+				for (i = 0; i < n; i++)
+					if (slots[(child_in_foreground + i) % n])
+						break;
+				child_in_foreground = (child_in_foreground + i) % n;
+				fputs(err[child_in_foreground].buf, stderr);
+				strbuf_reset(&err[child_in_foreground]);
+			}
+		}
+	}
+	return 0;
+}
diff --git a/run-command.h b/run-command.h
index 5b4425a..8f53ad6 100644
--- a/run-command.h
+++ b/run-command.h
@@ -119,4 +119,33 @@ struct async {
 int start_async(struct async *async);
 int finish_async(struct async *async);
 
+/**
+ * Return 0 if the next child is ready to run.
+ * This callback takes care to initialize the child process and preload the
+ * out and error channel. The preloading of these outpout channels is useful
+ * if you want to have a message printed directly before the output of the
+ * child process.
+ *
+ * Return != 0 if there are no more tasks to be processed.
+ */
+typedef int (*get_next_task)(void *data,
+			     struct child_process *cp,
+			     struct strbuf *err);
+
+/**
+ * Runs up to n processes at the same time. Whenever a process can
+ * be started, the callback `get_next_task` is called to obtain the
+ * data fed to the child process.
+ *
+ * The children started via this function run in parallel and their output
+ * to both stdout and stderr is buffered, while one of the children will
+ * directly output to stdout/stderr.
+ *
+ * This leads to a problem with output from processes which put out to
+ * stdout/err alternatingly as the buffering will not be able to replay
+ * the
+ */
+
+int run_processes_async(int n, get_next_task fn, void *data);
+
 #endif
diff --git a/strbuf.c b/strbuf.c
index cce5eed..7f866c3 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -384,6 +384,37 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 	return sb->len - oldlen;
 }
 
+ssize_t strbuf_read_noblock(struct strbuf *sb, int fd, size_t hint)
+{
+	size_t oldlen = sb->len;
+	size_t oldalloc = sb->alloc;
+
+	strbuf_grow(sb, hint ? hint : 8192);
+	for (;;) {
+		ssize_t cnt;
+
+		cnt = read(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
+		if (cnt < 0) {
+			if (errno == EINTR)
+				continue;
+			if (errno == EAGAIN)
+				break;
+			if (oldalloc == 0)
+				strbuf_release(sb);
+			else
+				strbuf_setlen(sb, oldlen);
+			return -1;
+		}
+		if (!cnt)
+			break;
+		sb->len += cnt;
+		strbuf_grow(sb, 8192);
+	}
+
+	sb->buf[sb->len] = '\0';
+	return sb->len - oldlen;
+}
+
 #define STRBUF_MAXLINK (2*PATH_MAX)
 
 int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
diff --git a/strbuf.h b/strbuf.h
index aef2794..7ea462b 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -365,6 +365,7 @@ extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
  * any partial read is undone.
  */
 extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
+extern ssize_t strbuf_read_noblock(struct strbuf *, int fd, size_t hint);
 
 /**
  * Read the contents of a file, specified by its path. The third argument
diff --git a/submodule.c b/submodule.c
index 1d64e57..6d757c6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -12,6 +12,7 @@
 #include "sha1-array.h"
 #include "argv-array.h"
 #include "blob.h"
+#include "thread-utils.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static struct string_list changed_submodule_paths;
@@ -615,37 +616,61 @@ static void calculate_changed_submodule_paths(void)
 	initialized_fetch_ref_tips = 0;
 }
 
+struct submodule_parallel_fetch {
+	int count;
+	struct argv_array args;
+	const char *work_tree;
+	const char *prefix;
+	int command_line_option;
+	int quiet;
+};
+#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL}
+
+int get_next_submodule(void *data, struct child_process *cp,
+		       struct strbuf *err);
+
 int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-			       int quiet)
+			       int quiet, int max_parallel_jobs)
 {
 	int i, result = 0;
-	struct child_process cp = CHILD_PROCESS_INIT;
-	struct argv_array argv = ARGV_ARRAY_INIT;
-	const char *work_tree = get_git_work_tree();
-	if (!work_tree)
+	struct submodule_parallel_fetch spf = SPF_INIT;
+	spf.work_tree = get_git_work_tree();
+	spf.command_line_option = command_line_option;
+	spf.quiet = quiet;
+	spf.prefix = prefix;
+	if (!spf.work_tree)
 		goto out;
 
 	if (read_cache() < 0)
 		die("index file corrupt");
 
-	argv_array_push(&argv, "fetch");
+	argv_array_push(&spf.args, "fetch");
 	for (i = 0; i < options->argc; i++)
-		argv_array_push(&argv, options->argv[i]);
-	argv_array_push(&argv, "--recurse-submodules-default");
+		argv_array_push(&spf.args, options->argv[i]);
+	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
-	cp.env = local_repo_env;
-	cp.git_cmd = 1;
-	cp.no_stdin = 1;
-
 	calculate_changed_submodule_paths();
+	run_processes_async(max_parallel_jobs, get_next_submodule, &spf);
+
+	argv_array_clear(&spf.args);
+out:
+	string_list_clear(&changed_submodule_paths, 1);
+	return result;
+}
+
+int get_next_submodule(void *data, struct child_process *cp,
+		       struct strbuf *err)
+{
+	int ret = 0;
+	struct submodule_parallel_fetch *spf = data;
 
-	for (i = 0; i < active_nr; i++) {
+	for ( ; spf->count < active_nr; spf->count++) {
 		struct strbuf submodule_path = STRBUF_INIT;
 		struct strbuf submodule_git_dir = STRBUF_INIT;
 		struct strbuf submodule_prefix = STRBUF_INIT;
-		const struct cache_entry *ce = active_cache[i];
+		const struct cache_entry *ce = active_cache[spf->count];
 		const char *git_dir, *default_argv;
 		const struct submodule *submodule;
 
@@ -657,7 +682,7 @@ int fetch_populated_submodules(const struct argv_array *options,
 			submodule = submodule_from_name(null_sha1, ce->name);
 
 		default_argv = "yes";
-		if (command_line_option == RECURSE_SUBMODULES_DEFAULT) {
+		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
 			if (submodule &&
 			    submodule->fetch_recurse !=
 						RECURSE_SUBMODULES_NONE) {
@@ -680,40 +705,46 @@ int fetch_populated_submodules(const struct argv_array *options,
 					default_argv = "on-demand";
 				}
 			}
-		} else if (command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
+		} else if (spf->command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
 			if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
 				continue;
 			default_argv = "on-demand";
 		}
 
-		strbuf_addf(&submodule_path, "%s/%s", work_tree, ce->name);
+		strbuf_addf(&submodule_path, "%s/%s", spf->work_tree, ce->name);
 		strbuf_addf(&submodule_git_dir, "%s/.git", submodule_path.buf);
-		strbuf_addf(&submodule_prefix, "%s%s/", prefix, ce->name);
+		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, ce->name);
 		git_dir = read_gitfile(submodule_git_dir.buf);
 		if (!git_dir)
 			git_dir = submodule_git_dir.buf;
 		if (is_directory(git_dir)) {
-			if (!quiet)
-				fprintf(stderr, "Fetching submodule %s%s\n", prefix, ce->name);
-			cp.dir = submodule_path.buf;
-			argv_array_push(&argv, default_argv);
-			argv_array_push(&argv, "--submodule-prefix");
-			argv_array_push(&argv, submodule_prefix.buf);
-			cp.argv = argv.argv;
-			if (run_command(&cp))
-				result = 1;
-			argv_array_pop(&argv);
-			argv_array_pop(&argv);
-			argv_array_pop(&argv);
+			child_process_init(cp);
+			cp->dir = strbuf_detach(&submodule_path, NULL);
+			cp->git_cmd = 1;
+			cp->no_stdout = 1;
+			cp->no_stdin = 1;
+			cp->stdout_to_stderr = 1;
+			cp->err = -1;
+			cp->env = local_repo_env;
+			if (!spf->quiet)
+				strbuf_addf(err, "Fetching submodule %s%s\n",
+					    spf->prefix, ce->name);
+			argv_array_init(&cp->args);
+			argv_array_pushv(&cp->args, spf->args.argv);
+			argv_array_push(&cp->args, default_argv);
+			argv_array_push(&cp->args, "--submodule-prefix");
+			argv_array_push(&cp->args, submodule_prefix.buf);
+			ret = 1;
 		}
 		strbuf_release(&submodule_path);
 		strbuf_release(&submodule_git_dir);
 		strbuf_release(&submodule_prefix);
+		if (ret) {
+			spf->count++;
+			return 0;
+		}
 	}
-	argv_array_clear(&argv);
-out:
-	string_list_clear(&changed_submodule_paths, 1);
-	return result;
+	return 1;
 }
 
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
diff --git a/submodule.h b/submodule.h
index 5507c3d..cbc0003 100644
--- a/submodule.h
+++ b/submodule.h
@@ -31,7 +31,7 @@ void set_config_fetch_recurse_submodules(int value);
 void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-			       int quiet);
+			       int quiet, int max_parallel_jobs);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int submodule_uses_gitfile(const char *path);
 int ok_to_remove_submodule(const char *path);
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 9acf628..0970fb0 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -47,4 +47,20 @@ test_expect_success POSIXPERM,SANITY 'unreadable directory in PATH' '
 	test_cmp expect actual
 '
 
+cat >expect <<-EOF
+Now running instance 0
+Hello World
+Now running instance 1
+Hello World
+Now running instance 2
+Hello World
+Now running instance 3
+Hello World
+EOF
+
+test_expect_success 'run_command runs in parallel' '
+	test-run-command run-command-async sh -c "echo Hello World >&2;" 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 17759b1..1b4ce69 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -71,6 +71,16 @@ test_expect_success "fetch --recurse-submodules recurses into submodules" '
 	test_i18ncmp expect.err actual.err
 '
 
+test_expect_success "fetch --recurse-submodules -j2 has the same output behaviour" '
+	add_upstream_commit &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules -j2 2>../actual.err
+	) &&
+	test_must_be_empty actual.out &&
+	test_i18ncmp expect.err actual.err
+'
+
 test_expect_success "fetch alone only fetches superproject" '
 	add_upstream_commit &&
 	(
@@ -140,6 +150,15 @@ test_expect_success "--quiet propagates to submodules" '
 	! test -s actual.err
 '
 
+test_expect_success "--quiet propagates to parallel submodules" '
+	(
+		cd downstream &&
+		git fetch --recurse-submodules -j 2 --quiet  >../actual.out 2>../actual.err
+	) &&
+	! test -s actual.out &&
+	! test -s actual.err
+'
+
 test_expect_success "--dry-run propagates to submodules" '
 	add_upstream_commit &&
 	(
diff --git a/test-run-command.c b/test-run-command.c
index 89c7de2..4817f6e 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -10,9 +10,29 @@
 
 #include "git-compat-util.h"
 #include "run-command.h"
+#include "argv-array.h"
+#include "strbuf.h"
 #include <string.h>
 #include <errno.h>
 
+static int number_callbacks;
+int run_processes_async_next(void *data,
+			     struct child_process *cp,
+			     struct strbuf *err)
+{
+	struct child_process *d = data;
+	if (number_callbacks >= 4)
+		return 1;
+
+	argv_array_pushv(&cp->args, d->argv);
+	cp->stdout_to_stderr = 1;
+	cp->no_stdin = 1;
+	cp->err = -1;
+	strbuf_addf(err, "Now running instance %d\n", number_callbacks);
+	number_callbacks++;
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
@@ -30,6 +50,9 @@ int main(int argc, char **argv)
 	if (!strcmp(argv[1], "run-command"))
 		exit(run_command(&proc));
 
+	if (!strcmp(argv[1], "run-command-async"))
+		exit(run_processes_async(4, run_processes_async_next, &proc));
+
 	fprintf(stderr, "check usage\n");
 	return 1;
 }
-- 
2.6.0.rc0.131.gf624c3d
