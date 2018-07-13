Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99C791F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387892AbeGMRMM (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:12 -0400
Received: from siwi.pair.com ([209.68.5.199]:31833 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387810AbeGMRMK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:10 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id F122E3F481F;
        Fri, 13 Jul 2018 12:56:42 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 896E43F4823;
        Fri, 13 Jul 2018 12:56:42 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 21/25] structured-logging: add detail-events for child processes
Date:   Fri, 13 Jul 2018 16:56:17 +0000
Message-Id: <20180713165621.52017-22-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach git to emit "detail" events with category "child" before a child
process is started and after it finishes.  These events can be used to
infer time spent by git waiting for child processes to complete.

These events are controlled by the slog.detail config setting.  Set to
true or add the token "child" to it.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 run-command.c        |  14 ++++-
 run-command.h        |   1 +
 structured-logging.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 structured-logging.h |  15 +++++
 4 files changed, 181 insertions(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index 84b883c..30fb4c5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -710,6 +710,8 @@ int start_command(struct child_process *cmd)
 
 	fflush(NULL);
 
+	cmd->slog_child_id = slog_child_starting(cmd);
+
 #ifndef GIT_WINDOWS_NATIVE
 {
 	int notify_pipe[2];
@@ -923,6 +925,9 @@ int start_command(struct child_process *cmd)
 			close_pair(fderr);
 		else if (cmd->err)
 			close(cmd->err);
+
+		slog_child_ended(cmd->slog_child_id, cmd->pid, failed_errno);
+
 		child_process_clear(cmd);
 		errno = failed_errno;
 		return -1;
@@ -949,13 +954,20 @@ int start_command(struct child_process *cmd)
 int finish_command(struct child_process *cmd)
 {
 	int ret = wait_or_whine(cmd->pid, cmd->argv[0], 0);
+
+	slog_child_ended(cmd->slog_child_id, cmd->pid, ret);
+
 	child_process_clear(cmd);
 	return ret;
 }
 
 int finish_command_in_signal(struct child_process *cmd)
 {
-	return wait_or_whine(cmd->pid, cmd->argv[0], 1);
+	int ret = wait_or_whine(cmd->pid, cmd->argv[0], 1);
+
+	slog_child_ended(cmd->slog_child_id, cmd->pid, ret);
+
+	return ret;
 }
 
 
diff --git a/run-command.h b/run-command.h
index 3932420..89c89cf 100644
--- a/run-command.h
+++ b/run-command.h
@@ -12,6 +12,7 @@ struct child_process {
 	struct argv_array args;
 	struct argv_array env_array;
 	pid_t pid;
+	int slog_child_id;
 	/*
 	 * Using .in, .out, .err:
 	 * - Specify 0 for no redirections (child inherits stdin, stdout,
diff --git a/structured-logging.c b/structured-logging.c
index 584f70a..dbe60b7 100644
--- a/structured-logging.c
+++ b/structured-logging.c
@@ -4,6 +4,7 @@
 #include "json-writer.h"
 #include "sigchain.h"
 #include "argv-array.h"
+#include "run-command.h"
 
 #if !defined(STRUCTURED_LOGGING)
 /*
@@ -48,6 +49,23 @@ struct aux_data_array {
 static struct aux_data_array my__aux_data;
 static void format_and_free_aux_data(struct json_writer *jw);
 
+struct child_data {
+	uint64_t start_ns;
+	uint64_t end_ns;
+	struct json_writer jw_argv;
+	unsigned int is_running:1;
+	unsigned int is_git_cmd:1;
+	unsigned int use_shell:1;
+};
+
+struct child_data_array {
+	struct child_data **array;
+	size_t nr, alloc;
+};
+
+static struct child_data_array my__child_data;
+static void free_children(void);
+
 static uint64_t my__start_time;
 static uint64_t my__exit_time;
 static int my__is_config_loaded;
@@ -283,10 +301,11 @@ static void emit_exit_event(void)
 }
 
 static void emit_detail_event(const char *category, const char *label,
+			      uint64_t clock_ns,
 			      const struct json_writer *data)
 {
 	struct json_writer jw = JSON_WRITER_INIT;
-	uint64_t clock_us = getnanotime() / 1000;
+	uint64_t clock_us = clock_ns / 1000;
 
 	/* build "detail" event */
 	jw_object_begin(&jw, my__is_pretty);
@@ -435,6 +454,7 @@ static void do_final_steps(int in_signal)
 	jw_release(&my__errors);
 	strbuf_release(&my__session_id);
 	free_timers();
+	free_children();
 }
 
 static void slog_atexit(void)
@@ -580,7 +600,7 @@ void slog_emit_detail_event(const char *category, const char *label,
 		BUG("unterminated slog.detail data: '%s' '%s' '%s'",
 		    category, label, data->json.buf);
 
-	emit_detail_event(category, label, data);
+	emit_detail_event(category, label, getnanotime(), data);
 }
 
 int slog_start_timer(const char *category, const char *name)
@@ -815,4 +835,134 @@ static void format_and_free_aux_data(struct json_writer *jw)
 	my__aux_data.alloc = 0;
 }
 
+static struct child_data *alloc_child_data(const struct child_process *cmd)
+{
+	struct child_data *cd = xcalloc(1, sizeof(struct child_data));
+
+	cd->start_ns = getnanotime();
+	cd->is_running = 1;
+	cd->is_git_cmd = cmd->git_cmd;
+	cd->use_shell = cmd->use_shell;
+
+	jw_init(&cd->jw_argv);
+
+	jw_array_begin(&cd->jw_argv, my__is_pretty);
+	{
+		jw_array_argv(&cd->jw_argv, cmd->argv);
+	}
+	jw_end(&cd->jw_argv);
+
+	return cd;
+}
+
+static int insert_child_data(struct child_data *cd)
+{
+	int child_id = my__child_data.nr;
+
+	ALLOC_GROW(my__child_data.array, my__child_data.nr + 1,
+		   my__child_data.alloc);
+	my__child_data.array[my__child_data.nr++] = cd;
+
+	return child_id;
+}
+
+int slog_child_starting(const struct child_process *cmd)
+{
+	struct child_data *cd;
+	int child_id;
+
+	if (!slog_is_enabled())
+		return SLOG_UNDEFINED_CHILD_ID;
+
+	/*
+	 * If we have not yet written a cmd_start event (and even if
+	 * we do not emit this child_start event), force the cmd_start
+	 * event now so that it appears in the log before any events
+	 * that the child process itself emits.
+	 */
+	if (!my__wrote_start_event)
+		emit_start_event();
+
+	cd = alloc_child_data(cmd);
+	child_id = insert_child_data(cd);
+
+	/* build data portion for a "detail" event */
+	if (slog_want_detail_event("child")) {
+		struct json_writer jw_data = JSON_WRITER_INIT;
+
+		jw_object_begin(&jw_data, my__is_pretty);
+		{
+			jw_object_intmax(&jw_data, "child_id", child_id);
+			jw_object_bool(&jw_data, "git_cmd", cd->is_git_cmd);
+			jw_object_bool(&jw_data, "use_shell", cd->use_shell);
+			jw_object_sub_jw(&jw_data, "child_argv", &cd->jw_argv);
+		}
+		jw_end(&jw_data);
+
+		emit_detail_event("child", "child_starting", cd->start_ns,
+				  &jw_data);
+		jw_release(&jw_data);
+	}
+
+	return child_id;
+}
+
+void slog_child_ended(int child_id, int child_pid, int child_exit_code)
+{
+	struct child_data *cd;
+
+	if (!slog_is_enabled())
+		return;
+	if (child_id == SLOG_UNDEFINED_CHILD_ID)
+		return;
+	if (child_id >= my__child_data.nr || child_id < 0)
+		BUG("Invalid slog.child id '%d'", child_id);
+
+	cd = my__child_data.array[child_id];
+	if (!cd->is_running)
+		BUG("slog.child '%d' already stopped", child_id);
+
+	cd->end_ns = getnanotime();
+	cd->is_running = 0;
+
+	/* build data portion for a "detail" event */
+	if (slog_want_detail_event("child")) {
+		struct json_writer jw_data = JSON_WRITER_INIT;
+
+		jw_object_begin(&jw_data, my__is_pretty);
+		{
+			jw_object_intmax(&jw_data, "child_id", child_id);
+			jw_object_bool(&jw_data, "git_cmd", cd->is_git_cmd);
+			jw_object_bool(&jw_data, "use_shell", cd->use_shell);
+			jw_object_sub_jw(&jw_data, "child_argv", &cd->jw_argv);
+
+			jw_object_intmax(&jw_data, "child_pid", child_pid);
+			jw_object_intmax(&jw_data, "child_exit_code",
+					 child_exit_code);
+			jw_object_intmax(&jw_data, "child_elapsed_us",
+					 (cd->end_ns - cd->start_ns) / 1000);
+		}
+		jw_end(&jw_data);
+
+		emit_detail_event("child", "child_ended", cd->end_ns, &jw_data);
+		jw_release(&jw_data);
+	}
+}
+
+static void free_children(void)
+{
+	int k;
+
+	for (k = 0; k < my__child_data.nr; k++) {
+		struct child_data *cd = my__child_data.array[k];
+
+		jw_release(&cd->jw_argv);
+		free(cd);
+	}
+
+	FREE_AND_NULL(my__child_data.array);
+	my__child_data.nr = 0;
+	my__child_data.alloc = 0;
+}
+
 #endif
diff --git a/structured-logging.h b/structured-logging.h
index 2272598..7c98d33 100644
--- a/structured-logging.h
+++ b/structured-logging.h
@@ -2,10 +2,12 @@
 #define STRUCTURED_LOGGING_H
 
 struct json_writer;
+struct child_process;
 
 typedef int (*slog_fn_main_t)(int, const char **);
 
 #define SLOG_UNDEFINED_TIMER_ID (-1)
+#define SLOG_UNDEFINED_CHILD_ID (-1)
 
 #if !defined(STRUCTURED_LOGGING)
 /*
@@ -30,6 +32,8 @@ static inline void slog_stop_timer(int tid) { };
 #define slog_aux_intmax(c, k, v) do { } while (0)
 #define slog_aux_bool(c, k, v) do { } while (0)
 #define slog_aux_jw(c, k, v) do { } while (0)
+#define slog_child_starting(cmd) (SLOG_UNDEFINED_CHILD_ID)
+#define slog_child_ended(i, p, ec) do { } while (0)
 
 #else
 
@@ -147,5 +151,16 @@ void slog_aux_bool(const char *category, const char *key, int value);
 void slog_aux_jw(const char *category, const char *key,
 		 const struct json_writer *value);
 
+/*
+ * Emit a detail event of category "child" and label "child_starting"
+ * or "child_ending" with information about the child process.  Note
+ * that this is in addition to any events that the child process itself
+ * generates.
+ *
+ * Set "slog.detail" to true or contain "child" to get these events.
+ */
+int slog_child_starting(const struct child_process *cmd);
+void slog_child_ended(int child_id, int child_pid, int child_exit_code);
+
 #endif /* STRUCTURED_LOGGING */
 #endif /* STRUCTURED_LOGGING_H */
-- 
2.9.3

