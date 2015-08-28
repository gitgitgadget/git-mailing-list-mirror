From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/9] submodule: helper to run foreach in parallel
Date: Thu, 27 Aug 2015 18:14:52 -0700
Message-ID: <1440724495-708-7-git-send-email-sbeller@google.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 03:15:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZV8Ga-0000wZ-U9
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 03:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbbH1BPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 21:15:13 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33412 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbbH1BPH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 21:15:07 -0400
Received: by padfo6 with SMTP id fo6so4641306pad.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 18:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l/El1Olp8OAx2s5ORLNWpvxM8ffwFxh86bTQT3jO8tA=;
        b=EiaqfydVXkB2WnZxI2o4sa1WijXZh6RBL4oOwBqjTzGCn9UklRxr6d5hhzKcUYv0rP
         hM9xKRzU5q59s0ZKh3pGIYu3kXalXLlSO0fkhqNawA4nDU9POn8DkUI7Cn+XbeP2bwPh
         gDmJ8ptKC5djQspIeAg2wrOj2eeA7n++/IaFkH3bb5C4jdw3XlEOK7t6ziJWPfeRaMwl
         KENASJU2h93ZqkfdFmtb+69CVLv8ZKg7QTuK8elmc1x5NRilPpFutQEdaTwBr14aWJOE
         SzJMxVWV3Il3gjIohu9tgWA3ohyMmag5WA9OjU1rmxd0Es5ZcIXNKFu9rJ0g5JS/hHBZ
         Gv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l/El1Olp8OAx2s5ORLNWpvxM8ffwFxh86bTQT3jO8tA=;
        b=M9hWHZS767tB7DuuuOwHojoDFfJFIIBpgXoHLRnhlaH/E5TNxH/ALhCufJtYkAGbix
         FMWKhnSD96YPdB3AD4+gJoJX8EjlOTf0fdBrg4j91je+jXleLAwZnpb3sAvFthWiEtIu
         DMBHthS1lsCgjOLWVlXJP7ijXp355ehfodQhqhPwQC/jBn0/5aLfuWh08bc2FmG5tpNo
         7OnVdF/MQYw4Zr4aEOsIiIVI5wH6cUzHWnJTuLaq4LVi2qb5Xbzd4vOX9QL+00AnJ0O6
         vkqnr5hwELWaDQSFrZY53qM7b0AJ7CFFlSKDQJuzkoFzCNYLbd1c+oKpFR6ER5gdBT/e
         vYEw==
X-Gm-Message-State: ALoCoQnvmwbtf3tiH0LZq8VpL5gnB4w4xgHkIJkFDFJzx6iXawtivc/LY/fat3xFCTtgp7Qbm4Ra
X-Received: by 10.68.243.103 with SMTP id wx7mr10877319pbc.60.1440724506919;
        Thu, 27 Aug 2015 18:15:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bce4:8b21:c71b:de7e])
        by smtp.gmail.com with ESMTPSA id hy5sm3756702pac.22.2015.08.27.18.15.06
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 27 Aug 2015 18:15:06 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g5e52b0d
In-Reply-To: <1440724495-708-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276693>

Similar to `git submodule foreach` the new command `git submodule
foreach_parallel` will run a command on each submodule.

The commands are run in parallel up to the number of cores by default,
or you can specify '-j 4' tun just run with 4 threads for example.

One major difference to `git submodule foreach` is the handling of input
and output to the commands. Because of the parallel nature of the execution
it is not trivial how to schedule the std{in,out,err} channel for submodule
the command is run in. So in this patch there is no support for stdin.
stdout will be piped to stderr. stderr will make use of the synchronized
output feature of run_command.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c  | 133 ++++++++++++++++++++++++++++++++++++++++++-
 git-submodule.sh             |  11 +++-
 t/t7407-submodule-foreach.sh |  11 ++++
 3 files changed, 153 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d29499c..18b67f0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -8,6 +8,7 @@
 #include "submodule.h"
 #include "submodule-config.h"
 #include "string-list.h"
+#include "thread-utils.h"
 #include "run-command.h"
 
 static const struct cache_entry **ce_entries;
@@ -266,6 +267,127 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+#ifndef NO_PTHREADS
+struct submodule_args {
+	const char *name;
+	const char *path;
+	const char *sha1;
+	const char *toplevel;
+	const char *prefix;
+	const char **cmd;
+	pthread_mutex_t *sync;
+};
+
+int run_cmd_submodule(struct task_queue *aq, void *task)
+{
+	int i;
+	struct submodule_args *args = task;
+	struct strbuf out = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	struct child_process *cp = xmalloc(sizeof(*cp));
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
+	cp->sync_mutex = args->sync;
+	cp->sync_buf = &out;
+
+	return run_command(cp);
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
+		args->sync = &mutex;
+		args->prefix = alternative_path;
+		add_task(aq, run_cmd_submodule, args);
+	}
+
+	finish_task_queue(aq, NULL);
+	pthread_mutex_destroy(&mutex);
+	return 0;
+}
+#endif /* NO_PTHREADS */
+
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 {
 	if (argc < 2)
@@ -280,7 +402,16 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 	if (!strcmp(argv[1], "module_clone"))
 		return module_clone(argc - 1, argv + 1, prefix);
 
+#ifndef NO_PTHREADS
+	if (!strcmp(argv[1], "foreach_parallel"))
+		return module_foreach_parallel(argc - 1, argv + 1, prefix);
+#endif
+
 usage:
 	usage("git submodule--helper [module_list | module_name | "
-	      "module_clone]\n");
+	      "module_clone"
+#ifndef NO_PTHREADS
+	      " | foreach_parallel"
+#endif
+	      "]\n");
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
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 7ca10b8..16f6138 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -195,6 +195,17 @@ test_expect_success 'test "foreach --quiet --recursive"' '
 	test_cmp expect actual
 '
 
+test_expect_success 'test "foreach_parallel --quiet"' '
+	(
+		cd clone2 &&
+		git submodule foreach_parallel -q -- "echo \$name-\$path" > ../actual
+	) &&
+	grep nested1-nested1 actual &&
+	grep foo1-sub1 actual &&
+	grep foo2-sub2 actual &&
+	grep foo3-sub3 actual
+'
+
 test_expect_success 'use "update --recursive" to checkout all submodules' '
 	git clone super clone3 &&
 	(
-- 
2.5.0.264.g5e52b0d
