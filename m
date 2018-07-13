Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E69E71F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387886AbeGMRMM (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:12 -0400
Received: from siwi.pair.com ([209.68.5.199]:31847 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387769AbeGMRML (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:11 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 896713F400D;
        Fri, 13 Jul 2018 12:56:43 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 210E63F4829;
        Fri, 13 Jul 2018 12:56:43 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 22/25] structured-logging: add child process classification
Date:   Fri, 13 Jul 2018 16:56:18 +0000
Message-Id: <20180713165621.52017-23-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach git to classify child processes as "editor", "pager", "subprocess",
"alias", "shell", or "other".

Add the child process classification to the child detail events.

Mark child processes of class "editor" or "pager" as interactive in the
child detail event.

Add child summary to cmd_exit event grouping child process by class.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 editor.c             |   1 +
 git.c                |   2 +
 pager.c              |   1 +
 run-command.h        |   1 +
 structured-logging.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++
 sub-process.c        |   1 +
 6 files changed, 125 insertions(+)

diff --git a/editor.c b/editor.c
index 9a9b4e1..6f5ccf3 100644
--- a/editor.c
+++ b/editor.c
@@ -66,6 +66,7 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		p.argv = args;
 		p.env = env;
 		p.use_shell = 1;
+		p.slog_child_class = "editor";
 		if (start_command(&p) < 0)
 			return error("unable to start editor '%s'", editor);
 
diff --git a/git.c b/git.c
index 024a40d..f1cb29e 100644
--- a/git.c
+++ b/git.c
@@ -328,6 +328,7 @@ static int handle_alias(int *argcp, const char ***argv)
 			commit_pager_choice();
 
 			child.use_shell = 1;
+			child.slog_child_class = "alias";
 			argv_array_push(&child.args, alias_string + 1);
 			argv_array_pushv(&child.args, (*argv) + 1);
 
@@ -651,6 +652,7 @@ static void execv_dashed_external(const char **argv)
 	cmd.clean_on_exit = 1;
 	cmd.wait_after_clean = 1;
 	cmd.silent_exec_failure = 1;
+	cmd.slog_child_class = "alias";
 
 	trace_argv_printf(cmd.args.argv, "trace: exec:");
 
diff --git a/pager.c b/pager.c
index a768797..5939077 100644
--- a/pager.c
+++ b/pager.c
@@ -100,6 +100,7 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
 	argv_array_push(&pager_process->args, pager);
 	pager_process->use_shell = 1;
 	setup_pager_env(&pager_process->env_array);
+	pager_process->slog_child_class = "pager";
 }
 
 void setup_pager(void)
diff --git a/run-command.h b/run-command.h
index 89c89cf..8c99bd1 100644
--- a/run-command.h
+++ b/run-command.h
@@ -13,6 +13,7 @@ struct child_process {
 	struct argv_array env_array;
 	pid_t pid;
 	int slog_child_id;
+	const char *slog_child_class;
 	/*
 	 * Using .in, .out, .err:
 	 * - Specify 0 for no redirections (child inherits stdin, stdout,
diff --git a/structured-logging.c b/structured-logging.c
index dbe60b7..2571e79 100644
--- a/structured-logging.c
+++ b/structured-logging.c
@@ -49,13 +49,30 @@ struct aux_data_array {
 static struct aux_data_array my__aux_data;
 static void format_and_free_aux_data(struct json_writer *jw);
 
+struct child_summary_data {
+	char *child_class;
+	uint64_t total_ns;
+	int count;
+};
+
+struct child_summary_data_array {
+	struct child_summary_data **array;
+	size_t nr, alloc;
+};
+
+static struct child_summary_data_array my__child_summary_data;
+static void format_child_summary_data(struct json_writer *jw);
+static void free_child_summary_data(void);
+
 struct child_data {
 	uint64_t start_ns;
 	uint64_t end_ns;
 	struct json_writer jw_argv;
+	char *child_class;
 	unsigned int is_running:1;
 	unsigned int is_git_cmd:1;
 	unsigned int use_shell:1;
+	unsigned int is_interactive:1;
 };
 
 struct child_data_array {
@@ -293,6 +310,12 @@ static void emit_exit_event(void)
 			format_and_free_aux_data(&jw);
 			jw_end(&jw);
 		}
+
+		if (my__child_summary_data.nr) {
+			jw_object_inline_begin_object(&jw, "child_summary");
+			format_child_summary_data(&jw);
+			jw_end(&jw);
+		}
 	}
 	jw_end(&jw);
 
@@ -453,6 +476,7 @@ static void do_final_steps(int in_signal)
 	argv_array_clear(&my__argv);
 	jw_release(&my__errors);
 	strbuf_release(&my__session_id);
+	free_child_summary_data();
 	free_timers();
 	free_children();
 }
@@ -835,6 +859,85 @@ static void format_and_free_aux_data(struct json_writer *jw)
 	my__aux_data.alloc = 0;
 }
 
+static struct child_summary_data *find_child_summary_data(
+	const struct child_data *cd)
+{
+	struct child_summary_data *csd;
+	char *child_class;
+	int k;
+
+	child_class = cd->child_class;
+	if (!child_class || !*child_class) {
+		if (cd->use_shell)
+			child_class = "shell";
+		child_class = "other";
+	}
+
+	for (k = 0; k < my__child_summary_data.nr; k++) {
+		csd = my__child_summary_data.array[k];
+		if (!strcmp(child_class, csd->child_class))
+			return csd;
+	}
+
+	csd = xcalloc(1, sizeof(struct child_summary_data));
+	csd->child_class = xstrdup(child_class);
+
+	ALLOC_GROW(my__child_summary_data.array, my__child_summary_data.nr + 1,
+		   my__child_summary_data.alloc);
+	my__child_summary_data.array[my__child_summary_data.nr++] = csd;
+
+	return csd;
+}
+
+static void add_child_to_summary_data(const struct child_data *cd)
+{
+	struct child_summary_data *csd = find_child_summary_data(cd);
+
+	csd->total_ns += cd->end_ns - cd->start_ns;
+	csd->count++;
+}
+
+static void format_child_summary_data(struct json_writer *jw)
+{
+	int k;
+
+	for (k = 0; k < my__child_summary_data.nr; k++) {
+		struct child_summary_data *csd = my__child_summary_data.array[k];
+
+		jw_object_inline_begin_object(jw, csd->child_class);
+		{
+			jw_object_intmax(jw, "total_us", csd->total_ns / 1000);
+			jw_object_intmax(jw, "count", csd->count);
+		}
+		jw_end(jw);
+	}
+}
+
+static void free_child_summary_data(void)
+{
+	int k;
+
+	for (k = 0; k < my__child_summary_data.nr; k++) {
+		struct child_summary_data *csd = my__child_summary_data.array[k];
+
+		free(csd->child_class);
+		free(csd);
+	}
+
+	free(my__child_summary_data.array);
+}
+
+static unsigned int is_interactive(const char *child_class)
+{
+	if (child_class && *child_class) {
+		if (!strcmp(child_class, "editor"))
+			return 1;
+		if (!strcmp(child_class, "pager"))
+			return 1;
+	}
+	return 0;
+}
+
 static struct child_data *alloc_child_data(const struct child_process *cmd)
 {
 	struct child_data *cd = xcalloc(1, sizeof(struct child_data));
@@ -843,6 +946,9 @@ static struct child_data *alloc_child_data(const struct child_process *cmd)
 	cd->is_running = 1;
 	cd->is_git_cmd = cmd->git_cmd;
 	cd->use_shell = cmd->use_shell;
+	cd->is_interactive = is_interactive(cmd->slog_child_class);
+	if (cmd->slog_child_class && *cmd->slog_child_class)
+		cd->child_class = xstrdup(cmd->slog_child_class);
 
 	jw_init(&cd->jw_argv);
 
@@ -895,6 +1001,11 @@ int slog_child_starting(const struct child_process *cmd)
 			jw_object_intmax(&jw_data, "child_id", child_id);
 			jw_object_bool(&jw_data, "git_cmd", cd->is_git_cmd);
 			jw_object_bool(&jw_data, "use_shell", cd->use_shell);
+			jw_object_bool(&jw_data, "is_interactive",
+				       cd->is_interactive);
+			if (cd->child_class)
+				jw_object_string(&jw_data, "child_class",
+						 cd->child_class);
 			jw_object_sub_jw(&jw_data, "child_argv", &cd->jw_argv);
 		}
 		jw_end(&jw_data);
@@ -925,6 +1036,8 @@ void slog_child_ended(int child_id, int child_pid, int child_exit_code)
 	cd->end_ns = getnanotime();
 	cd->is_running = 0;
 
+	add_child_to_summary_data(cd);
+
 	/* build data portion for a "detail" event */
 	if (slog_want_detail_event("child")) {
 		struct json_writer jw_data = JSON_WRITER_INIT;
@@ -934,6 +1047,11 @@ void slog_child_ended(int child_id, int child_pid, int child_exit_code)
 			jw_object_intmax(&jw_data, "child_id", child_id);
 			jw_object_bool(&jw_data, "git_cmd", cd->is_git_cmd);
 			jw_object_bool(&jw_data, "use_shell", cd->use_shell);
+			jw_object_bool(&jw_data, "is_interactive",
+				       cd->is_interactive);
+			if (cd->child_class)
+				jw_object_string(&jw_data, "child_class",
+						 cd->child_class);
 			jw_object_sub_jw(&jw_data, "child_argv", &cd->jw_argv);
 
 			jw_object_intmax(&jw_data, "child_pid", child_pid);
@@ -957,6 +1075,7 @@ static void free_children(void)
 		struct child_data *cd = my__child_data.array[k];
 
 		jw_release(&cd->jw_argv);
+		free(cd->child_class);
 		free(cd);
 	}
 
diff --git a/sub-process.c b/sub-process.c
index 8d2a170..93f7a52 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -88,6 +88,7 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
 	process->out = -1;
 	process->clean_on_exit = 1;
 	process->clean_on_exit_handler = subprocess_exit_handler;
+	process->slog_child_class = "subprocess";
 
 	err = start_command(process);
 	if (err) {
-- 
2.9.3

