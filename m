From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv17 00/11] Expose submodule parallelism to the user
Date: Wed, 24 Feb 2016 19:06:47 -0800
Message-ID: <1456369618-18127-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 04:07:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYmGz-0000mq-LM
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 04:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759888AbcBYDHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 22:07:10 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32816 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759880AbcBYDHE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 22:07:04 -0500
Received: by mail-pa0-f44.google.com with SMTP id fl4so23863561pad.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 19:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/0aMPUccUolHWQ/XJkQYhTrBQtUUZm+fsmcHElp/5qQ=;
        b=cBMo+O+mgfdry5mkzWTWiHbnWqnTbhzs2IlDB848SRbd3i9vTWhl8h7qsIOKjxJ4hJ
         wM7My2bUpBhwkQla4ESwfd274Wj50gh3lHiNaAcm4yc+duFwWY15RpUk3YYtfWKtJPfl
         JdyJoCZEAquIEmct4pr9IKR14lzCejh+geFfGcAGBZBymmhbFFgGZeEbs7eR/n60eFDq
         5BlMNxIcI2vulPpFiATdYckl5xye85CczTsSnviOkjisY6Hc/yF4GOVcT0c0Oixit9a6
         1zTXb4t3DuA+0NajHSbrNsXmvXhbgonlzT4rnyT/kjhQWDuSAYwKGwOVIcb4wpVOK1PI
         iy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/0aMPUccUolHWQ/XJkQYhTrBQtUUZm+fsmcHElp/5qQ=;
        b=ctFaBY2uxoqJ9kyll9v5Vk3w8l8Fm+rSjiUDFNfF18f8LL+uhHeZLcItO56zmtTc3B
         ogdKSwGU4FRfQ2JowZYBdeN6CmEAYoSNLVOXJjU9Z95Z4j+CT+88tOuiH+pT7KwsS0fK
         TawTTSl+winqA96cFu90SjRQltbGDsf9HKQsBUwyUZ6mZK1Gccac37iVHqgKQJNpFj5H
         pyKf3UgSKtRYMfIeJ9/UOARsGVMlN+ZmJhTFEJtLl+pBOycqgph8Z8g7cFdUfds3K1dT
         MdSzhfsnUR3FP+RUhvyXi7FMoEvs82Weopctqp472jb/RurjDEhLCeGfduA0iiXDsDrn
         n71g==
X-Gm-Message-State: AG10YOTBcgjIfcT3de4vpMvp1U453O7N8tOllvqa5Nrhv8r9fm3M1QgkihnTWeaAcHNg03w1
X-Received: by 10.66.220.66 with SMTP id pu2mr59985122pac.115.1456369623480;
        Wed, 24 Feb 2016 19:07:03 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:74de:af7a:dfba:15a4])
        by smtp.gmail.com with ESMTPSA id tb10sm7971918pab.22.2016.02.24.19.07.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 19:07:02 -0800 (PST)
X-Mailer: git-send-email 2.7.2.373.g1655498.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287319>

This replaces origin/sb/submodule-parallel-update and applies on
origin/sb/submodule-parallel-fetch.

Thanks Jonathan for review!

* fixing all the small nits of v16 found by Jonathan!

Thanks,
Stefan

Interdiff to v15: (current origin/sb/submodule-parallel-update)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 32254cd..9d94406 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -259,32 +259,36 @@ struct submodule_update_clone {
 	/* index into 'list', the list of submodules to look into for cloning */
 	int current;
 	struct module_list list;
-	int warn_if_uninitialized : 1;
-	/* update parameter passed via commandline*/
+	unsigned warn_if_uninitialized : 1;
+
+	/* update parameter passed via commandline */
 	struct submodule_update_strategy update;
+
 	/* configuration parameters which are passed on to the children */
 	int quiet;
 	const char *reference;
 	const char *depth;
 	const char *recursive_prefix;
 	const char *prefix;
-	/* lines to be output */
+
+	/* Machine-readable status lines to be consumed by git-submodule.sh */
 	struct string_list projectlines;
+
 	/* If we want to stop as fast as possible and return an error */
-	int quickstop : 1;
+	unsigned quickstop : 1;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, NULL, NULL, NULL, NULL, \
 	STRING_LIST_INIT_DUP, 0}
 
 /**
- * Inspect if 'ce' needs to be cloned. If so, prepare the 'child' to be running
- * the clone and return non zero.
+ * Determine whether 'ce' needs to be cloned. If so, prepare the 'child' to
+ * run the clone. Returns 1 if 'ce' needs to be cloned, 0 otherwise.
  */
 static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 					   struct child_process *child,
 					   struct submodule_update_clone *suc,
-					   struct strbuf *err)
+					   struct strbuf *out)
 {
 	const struct submodule *sub = NULL;
 	struct strbuf displaypath_sb = STRBUF_INIT;
@@ -295,10 +299,10 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 
 	if (ce_stage(ce)) {
 		if (suc->recursive_prefix) {
-			strbuf_addf(err, "Skipping unmerged submodule %s/%s\n",
+			strbuf_addf(out, "Skipping unmerged submodule %s/%s\n",
 				    suc->recursive_prefix, ce->name);
 		} else {
-			strbuf_addf(err, "Skipping unmerged submodule %s\n",
+			strbuf_addf(out, "Skipping unmerged submodule %s\n",
 				    ce->name);
 		}
 		goto cleanup;
@@ -315,7 +319,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	if (suc->update.type == SM_UPDATE_NONE
 	    || (suc->update.type == SM_UPDATE_UNSPECIFIED
 		&& sub->update_strategy.type == SM_UPDATE_NONE)) {
-		strbuf_addf(err, "Skipping submodule '%s'\n",
+		strbuf_addf(out, "Skipping submodule '%s'\n",
 			    displaypath);
 		goto cleanup;
 	}
@@ -330,11 +334,11 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	git_config_get_string(sb.buf, &url);
 	if (!url) {
 		/*
-		 * Only mention uninitialized submodules when its
+		 * Only mention uninitialized submodules when their
 		 * path have been specified
 		 */
 		if (suc->warn_if_uninitialized)
-			strbuf_addf(err, _("Submodule path '%s' not initialized\n"
+			strbuf_addf(out, _("Submodule path '%s' not initialized\n"
 				    "Maybe you want to use 'update --init'?\n"),
 				    displaypath);
 		goto cleanup;
@@ -435,7 +439,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
 
 	struct option module_update_clone_options[] = {
-		OPT_STRING(0, "prefix", &prefix,
+		OPT_STRING(0, "prefix", &suc.prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
 		OPT_STRING(0, "recursive-prefix", &suc.recursive_prefix,
@@ -460,7 +464,6 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		N_("git submodule--helper update_clone [--prefix=<path>] [<path>...]"),
 		NULL
 	};
-	suc.prefix = prefix;
 
 	argc = parse_options(argc, argv, prefix, module_update_clone_options,
 			     git_submodule_helper_usage, 0);
@@ -475,8 +478,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	if (pathspec.nr)
 		suc.warn_if_uninitialized = 1;
 
-	gitmodules_config();
 	/* Overlay the parsed .gitmodules file with .git/config */
+	gitmodules_config();
 	git_config(submodule_config, NULL);
 
 	if (max_jobs < 0)
diff --git a/run-command.c b/run-command.c
index 8abaae4..6fad42f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -897,29 +897,29 @@ struct parallel_processes {
 	struct pollfd *pfd;
 
 	unsigned shutdown : 1;
-	unsigned ended_with_newline: 1;
 
 	int output_owner;
 	struct strbuf buffered_output; /* of finished children */
 };
 
 int default_start_failure(struct child_process *cp,
-			  struct strbuf *err,
+			  struct strbuf *out,
 			  void *pp_cb,
 			  void *pp_task_cb)
 {
 	int i;
 
-	strbuf_addstr(err, "Starting a child failed:");
+	strbuf_addstr(out, "Starting a child failed:");
 	for (i = 0; cp->argv[i]; i++)
-		strbuf_addf(err, " %s", cp->argv[i]);
+		strbuf_addf(out, " %s", cp->argv[i]);
+	strbuf_addch(out, '\n');
 
 	return 0;
 }
 
 int default_task_finished(int result,
 			  struct child_process *cp,
-			  struct strbuf *err,
+			  struct strbuf *out,
 			  void *pp_cb,
 			  void *pp_task_cb)
 {
@@ -928,9 +928,10 @@ int default_task_finished(int result,
 	if (!result)
 		return 0;
 
-	strbuf_addf(err, "A child failed with return code %d:", result);
+	strbuf_addf(out, "A child failed with return code %d:", result);
 	for (i = 0; cp->argv[i]; i++)
-		strbuf_addf(err, " %s", cp->argv[i]);
+		strbuf_addf(out, " %s", cp->argv[i]);
+	strbuf_addch(out, '\n');
 
 	return 0;
 }
@@ -980,7 +981,6 @@ static void pp_init(struct parallel_processes *pp,
 	pp->nr_processes = 0;
 	pp->output_owner = 0;
 	pp->shutdown = 0;
-	pp->ended_with_newline = 1;
 	pp->children = xcalloc(n, sizeof(*pp->children));
 	pp->pfd = xcalloc(n, sizeof(*pp->pfd));
 	strbuf_init(&pp->buffered_output, 0);
@@ -1013,7 +1013,7 @@ static void pp_cleanup(struct parallel_processes *pp)
 	 * When get_next_task added messages to the buffer in its last
 	 * iteration, the buffered output is non empty.
 	 */
-	fputs(pp->buffered_output.buf, stderr);
+	strbuf_write(&pp->buffered_output, stderr);
 	strbuf_release(&pp->buffered_output);
 
 	sigchain_pop_common();
@@ -1055,7 +1055,6 @@ static int pp_start_one(struct parallel_processes *pp)
 					 pp->data,
 					 &pp->children[i].data);
 		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
-		strbuf_addch(&pp->buffered_output, '\n');
 		strbuf_reset(&pp->children[i].err);
 		if (code)
 			pp->shutdown = 1;
@@ -1098,11 +1097,9 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 static void pp_output(struct parallel_processes *pp)
 {
 	int i = pp->output_owner;
-	size_t len = pp->children[i].err.len;
-	if (pp->children[i].state == GIT_CP_WORKING && len) {
-		fputs(pp->children[i].err.buf, stderr);
-		pp->ended_with_newline =
-			(pp->children[i].err.buf[len - 1] == '\n');
+	if (pp->children[i].state == GIT_CP_WORKING &&
+	    pp->children[i].err.len) {
+		strbuf_write(&pp->children[i].err, stderr);
 		strbuf_reset(&pp->children[i].err);
 	}
 }
@@ -1112,7 +1109,6 @@ static int pp_collect_finished(struct parallel_processes *pp)
 	int i, code;
 	int n = pp->max_processes;
 	int result = 0;
-	ssize_t len;
 
 	while (pp->nr_processes > 0) {
 		for (i = 0; i < pp->max_processes; i++)
@@ -1137,22 +1133,15 @@ static int pp_collect_finished(struct parallel_processes *pp)
 		pp->pfd[i].fd = -1;
 		child_process_init(&pp->children[i].process);
 
-		len = pp->children[i].err.len - 1;
-		if (len >= 0 && pp->children[i].err.buf[len] != '\n')
-			strbuf_addch(&pp->children[i].err, '\n');
-
 		if (i != pp->output_owner) {
 			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
 			strbuf_reset(&pp->children[i].err);
 		} else {
-			if (len == -1 && !pp->ended_with_newline)
-				strbuf_addch(&pp->children[i].err, '\n');
-			fputs(pp->children[i].err.buf, stderr);
+			strbuf_write(&pp->children[i].err, stderr);
 			strbuf_reset(&pp->children[i].err);
-			pp->ended_with_newline = 1;
 
 			/* Output all other finished child processes */
-			fputs(pp->buffered_output.buf, stderr);
+			strbuf_write(&pp->buffered_output, stderr);
 			strbuf_reset(&pp->buffered_output);
 
 			/*
diff --git a/run-command.h b/run-command.h
index a054fa6..2bd8fee 100644
--- a/run-command.h
+++ b/run-command.h
@@ -139,7 +139,7 @@ int in_async(void);
  * return the negative signal number.
  */
 typedef int (*get_next_task_fn)(struct child_process *cp,
-				struct strbuf *err,
+				struct strbuf *out,
 				void *pp_cb,
 				void **pp_task_cb);
 
@@ -148,7 +148,7 @@ typedef int (*get_next_task_fn)(struct child_process *cp,
  * a new process.
  *
  * You must not write to stdout or stderr in this function. Add your
- * message to the strbuf err instead, which will be printed without
+ * message to the strbuf out instead, which will be printed without
  * messing up the output of the other parallel processes.
  *
  * pp_cb is the callback cookie as passed into run_processes_parallel,
@@ -159,7 +159,7 @@ typedef int (*get_next_task_fn)(struct child_process *cp,
  * the negative signal number.
  */
 typedef int (*start_failure_fn)(struct child_process *cp,
-				struct strbuf *err,
+				struct strbuf *out,
 				void *pp_cb,
 				void *pp_task_cb);
 
@@ -168,7 +168,7 @@ typedef int (*start_failure_fn)(struct child_process *cp,
  * exact command which failed.
  */
 int default_start_failure(struct child_process *cp,
-			  struct strbuf *err,
+			  struct strbuf *out,
 			  void *pp_cb,
 			  void *pp_task_cb);
 
@@ -176,7 +176,7 @@ int default_start_failure(struct child_process *cp,
  * This callback is called on every child process that finished processing.
  *
  * You must not write to stdout or stderr in this function. Add your
- * message to the strbuf err instead, which will be printed without
+ * message to the strbuf out instead, which will be printed without
  * messing up the output of the other parallel processes.
  *
  * pp_cb is the callback cookie as passed into run_processes_parallel,
@@ -188,7 +188,7 @@ int default_start_failure(struct child_process *cp,
  */
 typedef int (*task_finished_fn)(int result,
 				struct child_process *cp,
-				struct strbuf *err,
+				struct strbuf *out,
 				void *pp_cb,
 				void *pp_task_cb);
 
@@ -198,7 +198,7 @@ typedef int (*task_finished_fn)(int result,
  */
 int default_task_finished(int result,
 			  struct child_process *cp,
-			  struct strbuf *err,
+			  struct strbuf *out,
 			  void *pp_cb,
 			  void *pp_task_cb);
 
diff --git a/strbuf.c b/strbuf.c
index 38686ff..71345cd 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -395,6 +395,12 @@ ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint)
 	return cnt;
 }
 
+ssize_t strbuf_write(struct strbuf *sb, FILE *f)
+{
+	return fwrite(sb->buf, 1, sb->len, f);
+}
+
+
 #define STRBUF_MAXLINK (2*PATH_MAX)
 
 int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
diff --git a/strbuf.h b/strbuf.h
index 2bf90e7..d4f2aa1 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -387,6 +387,12 @@ extern ssize_t strbuf_read_file(struct strbuf *sb, const char *path, size_t hint
 extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
 
 /**
+ * Write the whole content of the strbuf to the stream not stopping at
+ * NUL bytes.
+ */
+extern ssize_t strbuf_write(struct strbuf *sb, FILE *stream);
+
+/**
  * Read a line from a FILE *, overwriting the existing contents
  * of the strbuf. The second argument specifies the line
  * terminator character, typically `'\n'`.
diff --git a/submodule.c b/submodule.c
index 8fbc847..051f722 100644
--- a/submodule.c
+++ b/submodule.c
@@ -219,7 +219,7 @@ void gitmodules_config(void)
 int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst)
 {
-	free((void *)dst->command);
+	free((void*)dst->command);
 	dst->command = NULL;
 	if (!strcmp(value, "none"))
 		dst->type = SM_UPDATE_NONE;
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 5c6822c..12228b4 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -77,32 +77,6 @@ test_expect_success 'run_command runs in parallel with more tasks than jobs avai
 	test_cmp expect actual
 '
 
-test_expect_success 'run_command ensures each command ends in LF' '
-	test-run-command run-command-parallel 3 sh -c "printf \"%s\n%s\" Hello World" 2>actual &&
-	test_cmp expect actual
-'
-
-cat >expect <<-EOF
-preloaded output of a child
-preloaded output of a child
-preloaded output of a child
-preloaded output of a child
-EOF
-
-test_expect_success 'run_command ensures each command ends in LF when output is only in starting cb' '
-	test-run-command run-command-parallel 3 sh -c true  2>actual &&
-	test_cmp expect actual
-'
-
-cat >expect <<-EOF
-EOF
-
-test_expect_success 'run_command ensures each command ends in LF except when there is no output' '
-	test-run-command run-command-parallel-silent 3 sh -c true  2>actual &&
-	test_cmp expect actual
-'
-
-
 cat >expect <<-EOF
 preloaded output of a child
 asking for a quick stop
diff --git a/test-run-command.c b/test-run-command.c
index ca1ee97..fbe0a27 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -31,20 +31,6 @@ static int parallel_next(struct child_process *cp,
 	return 1;
 }
 
-static int parallel_next_silent(struct child_process *cp,
-			 struct strbuf *err,
-			 void *cb,
-			 void **task_cb)
-{
-	struct child_process *d = cb;
-	if (number_callbacks >= 4)
-		return 0;
-
-	argv_array_pushv(&cp->args, d->argv);
-	number_callbacks++;
-	return 1;
-}
-
 static int no_job(struct child_process *cp,
 		  struct strbuf *err,
 		  void *cb,
@@ -85,10 +71,6 @@ int main(int argc, char **argv)
 	jobs = atoi(argv[2]);
 	proc.argv = (const char **)argv + 3;
 
-	if (!strcmp(argv[1], "run-command-parallel-silent"))
-		exit(run_processes_parallel(jobs, parallel_next_silent,
-					    NULL, NULL, &proc));
-
 	if (!strcmp(argv[1], "run-command-parallel"))
 		exit(run_processes_parallel(jobs, parallel_next,
 					    NULL, NULL, &proc));



Stefan Beller (11):
  submodule-config: keep update strategy around
  submodule-config: drop check against NULL
  fetching submodules: respect `submodule.fetchJobs` config option
  submodule update: direct error message to stderr
  run_processes_parallel: treat output of children as byte array
  run-command: expose default_{start_failure, task_finished}
  run_processes_parallel: rename parameters for the callbacks
  run_processes_parallel: correctly terminate callbacks with an LF
  git submodule update: have a dedicated helper for cloning
  submodule update: expose parallelism to the user
  clone: allow an explicit argument for parallel submodule clones

 Documentation/config.txt        |   6 +
 Documentation/git-clone.txt     |   6 +-
 Documentation/git-submodule.txt |   7 +-
 builtin/clone.c                 |  19 ++-
 builtin/fetch.c                 |   2 +-
 builtin/submodule--helper.c     | 254 ++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh                |  56 ++++-----
 run-command.c                   |  36 +++---
 run-command.h                   |  29 ++++-
 strbuf.c                        |   6 +
 strbuf.h                        |   6 +
 submodule-config.c              |  19 ++-
 submodule-config.h              |   2 +
 submodule.c                     |  37 +++++-
 submodule.h                     |  18 +++
 t/t5526-fetch-submodules.sh     |  14 +++
 t/t7400-submodule-basic.sh      |   4 +-
 t/t7406-submodule-update.sh     |  27 +++++
 18 files changed, 477 insertions(+), 71 deletions(-)

-- 
2.7.2.373.g1655498.dirty
