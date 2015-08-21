From: Stefan Beller <sbeller@google.com>
Subject: [WIP/PATCH 3/3] submodule: helper to run foreach in parallel
Date: Thu, 20 Aug 2015 18:40:37 -0700
Message-ID: <1440121237-24576-3-git-send-email-sbeller@google.com>
References: <1440121237-24576-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, jrnieder@gmail.com, hvoigt@hvoigt.net,
	jens.lehmann@web.de, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 03:40:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSbKE-0000px-8Y
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 03:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095AbbHUBkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 21:40:51 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35375 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989AbbHUBkq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 21:40:46 -0400
Received: by pacdd16 with SMTP id dd16so31992970pac.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 18:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JkX5Mw8uvlTiWW4SpdpNI9YjIFzTv2NUENz5eB+Ufow=;
        b=HtZn67mfKa4UV7kOBOHeZHHHNu+guE7qh6ctBUGwBEPoAAsrcIn0BPhGJDUiTPN/bX
         l18wkYal2xsl9PZ1E2AwLSfFyts0NJ1jDjvY6d6xEVks+Aj6TFpjXKzKfPEERuC1vTIt
         7fyhyeVN1ir4uTLO4VIMnoO6ce84NQ/bLdSgCgQN4jx8tDQY/f6VWbL5OfxEMJnUqXxS
         T0R5Tog4wBgjgJgPKR4BZ+6XDvhsJz7SbqzWNoHO/CHgoWjFyR7O2cxclGdA5DT6j6/C
         RoHEox22oVMsy0/myIjy5qYCveZ6skoQykaT/JC+YAYsmldYoz9Fo1+g4edaesXjow9Y
         trcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JkX5Mw8uvlTiWW4SpdpNI9YjIFzTv2NUENz5eB+Ufow=;
        b=QiGIBKEDGYJ6x4/i63S6gcRoQAte96a1MIue005rBKB3ZyHjukp+BjSuLIsFsLHobl
         xuGh70+TQ6R8JO0fjroJ7QukF4j2Dh+DZp9Z6tfszkNQSmWGeVrD7CioMuMW8hM2iPNk
         f1mWZ4RSUhVgWIUxpcWTYNnpqV0/Ik6P82Cjzk6f8ZBX4vbnURl6PWb+r6hdaCPf5ZfL
         sFwsx3XZ+eqywdVGjIE0XzoDN4cNLxGzlU1rVSa8MnSfusCvZ9+XmeFuXcJpFmXJ32yG
         /PpULyi/YepLDBT9xFqxMpXTKp/EWkUeQD2HvU73Tbd8xZnhV0Lg7FK/NoRczmgOsU+S
         Iisg==
X-Gm-Message-State: ALoCoQnTJg+8LnXZwe5nkAZyEgMw+UYP3gd7RbO5nduV8p5R4OO0/svf1iBdne3VufvWLilXUJBN
X-Received: by 10.66.245.142 with SMTP id xo14mr11812843pac.151.1440121245926;
        Thu, 20 Aug 2015 18:40:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:fdaa:d3b8:45bc:ac82])
        by smtp.gmail.com with ESMTPSA id gu2sm5731132pbc.1.2015.08.20.18.40.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Aug 2015 18:40:45 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g01b5c38.dirty
In-Reply-To: <1440121237-24576-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276275>

This runs a command on each submodule in parallel and should eventually
replace `git submodule foreach`.

There is a new option -j/--jobs (inspired by make) to specify the number
of parallel threads.

The jobs=1 case needs to be special cases to exactly replicate the current
default behavior of `git submodule foreach` such as working stdin input.
For more than one job there is no input possible and the output of both
stdout/stderr of the command are put into the stderr in an ordered fashion,
i.e. the tasks to not intermingle their output in races.

what currently works:
 git submodule--helper foreach "echo \$toplevel-\$name-\$path-\$sha1"
which I took for testing during development from t7407.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This is still WIP, but comments are welcome.

 builtin/submodule--helper.c | 147 +++++++++++++++++++++++++++++++++++++++++++-
 git-submodule.sh            |   9 +++
 2 files changed, 154 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ae74b80..9823302 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -9,7 +9,9 @@
 #include "submodule-config.h"
 #include "string-list.h"
 #include "run-command.h"
-
+#ifndef NO_PTHREADS
+#include <semaphore.h>
+#endif
 static const struct cache_entry **ce_entries;
 static int ce_alloc, ce_used;
 static const char *alternative_path;
@@ -275,6 +277,144 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct submodule_args {
+	const char *name;
+	const char *path;
+	const char *sha1;
+	const char *toplevel;
+	const char *prefix;
+	const char **cmd;
+	struct submodule_output *out;
+	sem_t *mutex;
+};
+
+int run_cmd_submodule(struct task_queue *aq, void *task)
+{
+	int i;
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
+	}
+	if (finish_command(cp))
+		die("command died with error");
+
+	sem_wait(args->mutex);
+	fputs(out.buf, stderr);
+	sem_post(args->mutex);
+
+	return 0;
+}
+
+int module_foreach_parallel(int argc, const char **argv, const char *prefix)
+{
+	int i, recursive = 0, number_threads = 1, quiet = 0;
+	static struct pathspec pathspec;
+	struct strbuf sb = STRBUF_INIT;
+	struct task_queue *aq;
+	char **cmd;
+	const char **nullargv = {NULL};
+	sem_t *mutex = xmalloc(sizeof(*mutex));
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
+		if (!file_exists(sb.buf))
+			continue;
+
+		args->path = ce->name;
+		sub = submodule_from_path(null_sha1, args->path);
+		if (!sub)
+			die("No submodule mapping found in .gitmodules for path '%s'", args->path);
+
+		args->name = sub->name;
+		args->toplevel = xstrdup(xgetcwd());
+		args->cmd = argv;
+		args->mutex = mutex;
+		args->prefix = alternative_path;
+		add_task(aq, run_cmd_submodule, args);
+	}
+
+	finish_task_queue(aq);
+	return 0;
+}
+
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 {
 	if (argc < 2)
@@ -289,6 +429,9 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 	if (!strcmp(argv[1], "module_clone"))
 		return module_clone(argc - 1, argv + 1, prefix);
 
+	if (!strcmp(argv[1], "foreach"))
+		return module_foreach_parallel(argc - 1, argv + 1, prefix);
+
 usage:
-	usage("git submodule--helper [module_list module_name module_clone]\n");
+	usage("git submodule--helper [module_list module_name module_clone foreach]\n");
 }
diff --git a/git-submodule.sh b/git-submodule.sh
index fb5155e..fa18434 100755
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
+	git submodule--helper module_foreach_parallel --prefix "$wt_prefix" $@
+}
+
+#
 # Register submodules in .git/config
 #
 # $@ = requested paths (default to all)
-- 
2.5.0.264.g01b5c38.dirty
