From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/5] submodule: helper to run foreach in parallel
Date: Wed, 26 Aug 2015 17:52:44 -0700
Message-ID: <1440636766-12738-4-git-send-email-sbeller@google.com>
References: <1440636766-12738-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 02:53:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUlRD-0000PV-Sl
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 02:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbbH0Aw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 20:52:58 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34304 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbbH0Aw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 20:52:56 -0400
Received: by pabzx8 with SMTP id zx8so5161630pab.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 17:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cXSSt254HJZQKyeZAfD1JgrZXCk7K2uE7OdU+vIYOKQ=;
        b=Qk4O7+fHod9eoFrrTEpz5FDl1PTfrlUwvbXwA6gP4Cr9Ca14SOIDUZc6fo/eUH+aFn
         EmftXR4/NEeoczRGI38Yk/Q6TPBa7SurGq8lKfc6NUCQ7xzsFVOEKkhLqtZg03gWZIyt
         LiE+I1ZdjTD95arIV7I9dDj7diqzzNRE26ih+qr3MRepTGNrZN86OAAoayD/oeNH2GrK
         azP+RfkEfvRRPaoqj5gtduxP19rUb1v4pJtXApm+9+YIWUkuKtpltZlkCG90vVcd4Ljd
         a4koy+c3xLKmSAEfsZiWjLMva0WEEW4ETmrY9EOu/ITrdqsI+vlShZk049pU0zqhFmxM
         utGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cXSSt254HJZQKyeZAfD1JgrZXCk7K2uE7OdU+vIYOKQ=;
        b=lvdp9Vr9dA6Q5Ou7f9HZOVhaU9kjWlN6ETO8BiVLuHRoyunFp1yKt4LRc/z9KjC3NM
         AOPUgFDTswFrE2R+uZknPvlfWo/gIRRxpKl8PDCImrbPoK0sdtLuflDXSqGaheLUFlqI
         3L3TQpltCCkz4t+ZFkbazIgh7e/xFpdRE79CWJrs87Ifgn1I8Dx2KyvEveWGuLI7AC9C
         SvC4ZoRefBykwETsl8r/D8NT9Azd03TQpFeg8BG7X8tDJWbKKocToWZfxiVBVoUop012
         //KC42wktgF3T/ZxeVcGJNLS67YvGF7Z0bGyMUYP22zme4rtyIqsStFgCh188cMlXmNW
         bJig==
X-Gm-Message-State: ALoCoQnVN89G9RHg3BKNN+9/1BUE0/CU/6JOT+cCs5WdNSHHUJcM13gXOzvY8baQapAG1seNqvkM
X-Received: by 10.68.236.194 with SMTP id uw2mr2354402pbc.84.1440636776022;
        Wed, 26 Aug 2015 17:52:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:806a:7c76:ca55:3bf1])
        by smtp.gmail.com with ESMTPSA id eu6sm275273pdb.86.2015.08.26.17.52.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Aug 2015 17:52:55 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g784836d
In-Reply-To: <1440636766-12738-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276654>

Similar to `git submodule foreach` the new command
`git submodule foreach_parallel` will run a command
on each submodule.

The commands are run in parallel up to the number of
cores by default, or you can specify '-j 4' tun just
run with 4 threads for example.

One major difference to `git submodule foreach` is the
handling of input and output to the commands. Because
of the parallel nature of the execution it is not trivial
how to schedule the std{in,out,err} channel for submodule
the command is run in. So in this patch there is no
support for stdin.

The goal of the output for std{out, err} is to look like
the single threaded version as much as possible, so
stdout and stderr from one submodule operation are
buffered together in one single channel and output
together when the output is allowed.

To do that, we'll have a mutex for the output, which
each thread will try to acquire and directly pipe their
output to the standard output if they are lucky to
get the mutex.

If they do not have the mutex each thread will buffer
their output.

Example:
Let's assume we have 5 submodules A,B,C,D,E and the
operation on each submodule takes a different amount
of time (say `git fetch`), then the output of
`git submodule foreach` might look like this:

 time -->
 output: |---A---|   |-B-|   |----C-----------|   |-D-|   |-E-|

When we schedule these threads into two threads, a schedule
and sample output over time may look like this:

thread 1: |---A---|   |-D-|   |-E-|
thread 2: |-B-|   |----C-----------|

output:   |---A---| B |----C-------| E D

So A will be perceived as it would run normally in
the single threaded version of foreach. As B has finished
by the time the mutex becomes available, the whole buffer
will just be dumped into the standard output. This will be
perceived by the user as just a 'very fast' operation of B.
Once that is done, C takes the mutex, and flushes the piled
up buffer to standard output. In case the subcommand is a
git command, we have a progress display, which will just
look like the first half of C happend really quickly.

Notice how E and D are put out in a different order than the
original as the new parallel foreach doesn't care about the
order.

So this way of output is really good for human consumption
and not for machine consumption as you always see the progress,
but it is not easy to tell which output comes from which
command as there is no indication other than displaying
"Entering <submodule path>" for each beginning section of
output.

Maybe we want to integrate the unthreaded foreach eventually
into the new code base in C and have special cases for that,
such as accepting stdin again.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 160 +++++++++++++++++++++++++++++++++++++++++++-
 git-submodule.sh            |  11 ++-
 2 files changed, 168 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f11fb9c..2c06f28 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -8,8 +8,11 @@
 #include "submodule.h"
 #include "submodule-config.h"
 #include "string-list.h"
+#include "thread-utils.h"
 #include "run-command.h"
-
+#ifndef NO_PTHREADS
+#include <semaphore.h>
+#endif
 static const struct cache_entry **ce_entries;
 static int ce_alloc, ce_used;
 static const char *alternative_path;
@@ -279,6 +282,155 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct submodule_args {
+	const char *name;
+	const char *path;
+	const char *sha1;
+	const char *toplevel;
+	const char *prefix;
+	const char **cmd;
+	pthread_mutex_t *mutex;
+};
+
+int run_cmd_submodule(struct task_queue *aq, void *task)
+{
+	int i, lock_acquired = 0;
+	struct submodule_args *args = task;
+	struct strbuf out = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	struct child_process *cp = xmalloc(sizeof(*cp));
+	char buf[1024];
+
+	strbuf_addf(&out, N_("Entering %s\n"), relative_path(args->path, args->prefix, &sb));
+
+	child_process_init(cp);
+	argv_array_pushv(&cp->args, args->cmd);
+
+	argv_array_pushf(&cp->env_array, "name=%s", args->name);
+	argv_array_pushf(&cp->env_array, "path=%s", args->path);
+	argv_array_pushf(&cp->env_array, "sha1=%s", args->sha1);
+	argv_array_pushf(&cp->env_array, "toplevel=%s", args->toplevel);
+
+	for (i = 0; local_repo_env[i]; i++)
+		argv_array_push(&cp->env_array, local_repo_env[i]);
+
+	cp->no_stdin = 1;
+	cp->out = 0;
+	cp->err = -1;
+	cp->dir = args->path;
+	cp->stdout_to_stderr = 1;
+	cp->use_shell = 1;
+
+	if (start_command(cp)) {
+		die("Could not start command");
+		for (i = 0; cp->args.argv; i++)
+			fprintf(stderr, "%s\n", cp->args.argv[i]);
+	}
+
+	while (1) {
+		ssize_t len = xread(cp->err, buf, sizeof(buf));
+		if (len < 0)
+			die("Read from child failed");
+		else if (len == 0)
+			break;
+		else {
+			strbuf_add(&out, buf, len);
+		}
+		if (!pthread_mutex_trylock(args->mutex))
+			lock_acquired = 1;
+		if (lock_acquired) {
+			fputs(out.buf, stderr);
+			strbuf_reset(&out);
+		}
+	}
+	if (finish_command(cp))
+		die("command died with error");
+
+	if (!lock_acquired)
+		pthread_mutex_lock(args->mutex);
+
+	fputs(out.buf, stderr);
+	pthread_mutex_unlock(args->mutex);
+
+	return 0;
+}
+
+int module_foreach_parallel(int argc, const char **argv, const char *prefix)
+{
+	int i, recursive = 0, number_threads = 0, quiet = 0;
+	static struct pathspec pathspec;
+	struct strbuf sb = STRBUF_INIT;
+	struct task_queue *aq;
+	char **cmd;
+	const char **nullargv = {NULL};
+	pthread_mutex_t mutex;
+
+	struct option module_update_options[] = {
+		OPT_STRING(0, "prefix", &alternative_path,
+			   N_("path"),
+			   N_("alternative anchor for relative paths")),
+		OPT_STRING(0, "cmd", &cmd,
+			   N_("string"),
+			   N_("command to run")),
+		OPT_BOOL('r', "--recursive", &recursive,
+			 N_("Recurse into nexted submodules")),
+		OPT_INTEGER('j', "jobs", &number_threads,
+			    N_("Recurse into nexted submodules")),
+		OPT__QUIET(&quiet, N_("Suppress output")),
+		OPT_END()
+	};
+
+	static const char * const git_submodule_helper_usage[] = {
+		N_("git submodule--helper foreach [--prefix=<path>] [<path>...]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_update_options,
+			     git_submodule_helper_usage, 0);
+
+	if (module_list_compute(0, nullargv, NULL, &pathspec) < 0)
+		return 1;
+
+	gitmodules_config();
+
+	pthread_mutex_init(&mutex, NULL);
+	aq = create_task_queue(number_threads);
+
+	for (i = 0; i < ce_used; i++) {
+		const struct submodule *sub;
+		const struct cache_entry *ce = ce_entries[i];
+		struct submodule_args *args = malloc(sizeof(*args));
+
+		if (ce_stage(ce))
+			args->sha1 = xstrdup(sha1_to_hex(null_sha1));
+		else
+			args->sha1 = xstrdup(sha1_to_hex(ce->sha1));
+
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "%s/.git", ce->name);
+		if (!file_exists(sb.buf)) {
+			free(args);
+			continue;
+		}
+
+		args->path = ce->name;
+		sub = submodule_from_path(null_sha1, args->path);
+		if (!sub)
+			die("No submodule mapping found in .gitmodules for path '%s'", args->path);
+
+		args->name = sub->name;
+		args->toplevel = xgetcwd();
+		args->cmd = argv;
+		args->mutex = &mutex;
+		args->prefix = alternative_path;
+		add_task(aq, run_cmd_submodule, args);
+	}
+
+	finish_task_queue(aq, NULL);
+	pthread_mutex_destroy(&mutex);
+	return 0;
+}
+
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 {
 	if (argc < 2)
@@ -293,6 +445,10 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 	if (!strcmp(argv[1], "module_clone"))
 		return module_clone(argc - 1, argv + 1, prefix);
 
+	if (!strcmp(argv[1], "foreach_parallel"))
+		return module_foreach_parallel(argc - 1, argv + 1, prefix);
+
 usage:
-	usage("git submodule--helper [module_list module_name module_clone]\n");
+	fprintf(stderr, "%s", argv[1]);
+	usage("git submodule--helper [module_list module_name module_clone foreach_parallel]\n");
 }
diff --git a/git-submodule.sh b/git-submodule.sh
index fb5155e..f06488a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -431,6 +431,15 @@ cmd_foreach()
 }
 
 #
+# Execute an arbitrary command sequence in each checked out
+# submodule in parallel.
+#
+cmd_foreach_parallel()
+{
+	git submodule--helper foreach_parallel --prefix "$wt_prefix" $@
+}
+
+#
 # Register submodules in .git/config
 #
 # $@ = requested paths (default to all)
@@ -1225,7 +1234,7 @@ cmd_sync()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | deinit | update | status | summary | sync)
+	add | foreach | foreach_parallel | init | deinit | update | status | summary | sync)
 		command=$1
 		;;
 	-q|--quiet)
-- 
2.5.0.264.g784836d
