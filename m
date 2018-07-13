Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 731C11F90A
	for <e@80x24.org>; Fri, 13 Jul 2018 16:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbeGMRMA (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:00 -0400
Received: from siwi.pair.com ([209.68.5.199]:31809 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731526AbeGMRMA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:00 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BB5E93F4132;
        Fri, 13 Jul 2018 12:56:32 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 539563F413F;
        Fri, 13 Jul 2018 12:56:32 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 03/25] structured-logging: add structured logging framework
Date:   Fri, 13 Jul 2018 16:55:59 +0000
Message-Id: <20180713165621.52017-4-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach git to optionally generate structured logging data in JSON using
the json-writer API.  "cmd_start" and "cmd_end" events are generated.

Structured logging is only available when git is built with
STRUCTURED_LOGGING=1.

Structured logging is only enabled when the config setting "slog.path"
is set to an absolute pathname.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/config.txt |   8 ++
 compat/mingw.h           |   7 +
 config.c                 |   3 +
 git-compat-util.h        |   9 ++
 git.c                    |   8 +-
 structured-logging.c     | 366 +++++++++++++++++++++++++++++++++++++++++++++++
 structured-logging.h     |  82 +++++++++++
 usage.c                  |   4 +
 8 files changed, 486 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab641bf..c79f2bf 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3168,6 +3168,14 @@ showbranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
 	See linkgit:git-show-branch[1].
 
+slog.path::
+	(EXPERIMENTAL) Enable structured logging to a file.  This must be
+	an absolute path.  (Git must be compiled with STRUCTURED_LOGGING=1.)
+
+slog.pretty::
+	(EXPERIMENTAL) Pretty-print structured log data when true.
+	(Git must be compiled with STRUCTURED_LOGGING=1.)
+
 splitIndex.maxPercentChange::
 	When the split index feature is used, this specifies the
 	percent of entries the split index can contain compared to the
diff --git a/compat/mingw.h b/compat/mingw.h
index 571019d..d8d8cd3 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -144,8 +144,15 @@ static inline int fcntl(int fd, int cmd, ...)
 	errno = EINVAL;
 	return -1;
 }
+
 /* bash cannot reliably detect negative return codes as failure */
+#if defined(STRUCTURED_LOGGING)
+#include "structured-logging.h"
+#define exit(code) exit(strlog_exit_code((code) & 0xff))
+#else
 #define exit(code) exit((code) & 0xff)
+#endif
+
 #define sigemptyset(x) (void)0
 static inline int sigaddset(sigset_t *set, int signum)
 { return 0; }
diff --git a/config.c b/config.c
index fbbf0f8..b27b024 100644
--- a/config.c
+++ b/config.c
@@ -1476,6 +1476,9 @@ int git_default_config(const char *var, const char *value, void *dummy)
 		return 0;
 	}
 
+	if (starts_with(var, "slog."))
+		return slog_default_config(var, value);
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/git-compat-util.h b/git-compat-util.h
index 9a64998..f5352fd 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1239,4 +1239,13 @@ extern void unleak_memory(const void *ptr, size_t len);
 #define UNLEAK(var) do {} while (0)
 #endif
 
+#include "structured-logging.h"
+#if defined(STRUCTURED_LOGGING) && !defined(exit)
+/*
+ * Intercept all calls to exit() so that exit-code can be included
+ * in the "cmd_exit" message written by the at-exit routine.
+ */
+#define exit(code) exit(slog_exit_code(code))
+#endif
+
 #endif
diff --git a/git.c b/git.c
index c2f48d5..024a40d 100644
--- a/git.c
+++ b/git.c
@@ -413,6 +413,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 		setup_work_tree();
 
 	trace_argv_printf(argv, "trace: built-in: git");
+	slog_set_command_name(p->cmd);
 
 	status = p->fn(argc, argv, prefix);
 	if (status)
@@ -700,7 +701,7 @@ static int run_argv(int *argcp, const char ***argv)
 	return done_alias;
 }
 
-int cmd_main(int argc, const char **argv)
+static int real_cmd_main(int argc, const char **argv)
 {
 	const char *cmd;
 	int done_help = 0;
@@ -779,3 +780,8 @@ int cmd_main(int argc, const char **argv)
 
 	return 1;
 }
+
+int cmd_main(int argc, const char **argv)
+{
+	return slog_wrap_main(real_cmd_main, argc, argv);
+}
diff --git a/structured-logging.c b/structured-logging.c
index 702fd84..afa2224 100644
--- a/structured-logging.c
+++ b/structured-logging.c
@@ -1,3 +1,10 @@
+#include "cache.h"
+#include "config.h"
+#include "version.h"
+#include "json-writer.h"
+#include "sigchain.h"
+#include "argv-array.h"
+
 #if !defined(STRUCTURED_LOGGING)
 /*
  * Structured logging is not available.
@@ -6,4 +13,363 @@
 
 #else
 
+#define SLOG_VERSION 0
+
+static uint64_t my__start_time;
+static uint64_t my__exit_time;
+static int my__is_config_loaded;
+static int my__is_enabled;
+static int my__is_pretty;
+static int my__signal;
+static int my__exit_code;
+static int my__pid;
+static int my__wrote_start_event;
+static int my__log_fd = -1;
+
+static char *my__log_path;
+static char *my__command_name;
+static char *my__sub_command_name;
+
+static struct argv_array my__argv = ARGV_ARRAY_INIT;
+static struct json_writer my__errors = JSON_WRITER_INIT;
+
+/*
+ * Write a single event to the structured log file.
+ */
+static void emit_event(struct json_writer *jw, const char *event_name)
+{
+	if (my__log_fd == -1) {
+		my__log_fd = open(my__log_path,
+				  O_WRONLY | O_APPEND | O_CREAT,
+				  0644);
+		if (my__log_fd == -1) {
+			warning("slog: could not open '%s' for logging: %s",
+				my__log_path, strerror(errno));
+			my__is_enabled = 0;
+			return;
+		}
+	}
+
+	/*
+	 * A properly authored JSON string does not have a final NL
+	 * (even when pretty-printing is enabled).  Structured logging
+	 * output should look like a series of terminated forms one
+	 * per line.  Temporarily append a NL to the buffer so that
+	 * the disk write happens atomically.
+	 */
+	strbuf_addch(&jw->json, '\n');
+	if (write(my__log_fd, jw->json.buf, jw->json.len) != jw->json.len)
+		warning("slog: could not write event '%s': %s",
+			event_name, strerror(errno));
+
+	strbuf_setlen(&jw->json, jw->json.len - 1);
+}
+
+static void emit_start_event(void)
+{
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	/* build "cmd_start" event message */
+	jw_object_begin(&jw, my__is_pretty);
+	{
+		jw_object_string(&jw, "event", "cmd_start");
+		jw_object_intmax(&jw, "clock_us", (intmax_t)my__start_time);
+		jw_object_intmax(&jw, "pid", (intmax_t)my__pid);
+
+		if (my__command_name && *my__command_name)
+			jw_object_string(&jw, "command", my__command_name);
+		if (my__sub_command_name && *my__sub_command_name)
+			jw_object_string(&jw, "sub_command", my__sub_command_name);
+
+		jw_object_inline_begin_array(&jw, "argv");
+		{
+			int k;
+			for (k = 0; k < my__argv.argc; k++)
+				jw_array_string(&jw, my__argv.argv[k]);
+		}
+		jw_end(&jw);
+	}
+	jw_end(&jw);
+
+	emit_event(&jw, "cmd_start");
+	jw_release(&jw);
+
+	my__wrote_start_event = 1;
+}
+
+static void emit_exit_event(void)
+{
+	struct json_writer jw = JSON_WRITER_INIT;
+	uint64_t atexit_time = getnanotime() / 1000;
+
+	/* close unterminated forms */
+	if (my__errors.json.len)
+		jw_end(&my__errors);
+
+	/* build "cmd_exit" event message */
+	jw_object_begin(&jw, my__is_pretty);
+	{
+		jw_object_string(&jw, "event", "cmd_exit");
+		jw_object_intmax(&jw, "clock_us", (intmax_t)atexit_time);
+		jw_object_intmax(&jw, "pid", (intmax_t)my__pid);
+
+		if (my__command_name && *my__command_name)
+			jw_object_string(&jw, "command", my__command_name);
+		if (my__sub_command_name && *my__sub_command_name)
+			jw_object_string(&jw, "sub_command", my__sub_command_name);
+
+		jw_object_inline_begin_array(&jw, "argv");
+		{
+			int k;
+			for (k = 0; k < my__argv.argc; k++)
+				jw_array_string(&jw, my__argv.argv[k]);
+		}
+		jw_end(&jw);
+
+		jw_object_inline_begin_object(&jw, "result");
+		{
+			jw_object_intmax(&jw, "exit_code", my__exit_code);
+			if (my__errors.json.len)
+				jw_object_sub_jw(&jw, "errors", &my__errors);
+
+			if (my__signal)
+				jw_object_intmax(&jw, "signal", my__signal);
+
+			if (my__exit_time > 0)
+				jw_object_intmax(&jw, "elapsed_core_us",
+						 my__exit_time - my__start_time);
+
+			jw_object_intmax(&jw, "elapsed_total_us",
+					 atexit_time - my__start_time);
+		}
+		jw_end(&jw);
+
+		jw_object_inline_begin_object(&jw, "version");
+		{
+			jw_object_string(&jw, "git", git_version_string);
+			jw_object_intmax(&jw, "slog", SLOG_VERSION);
+		}
+		jw_end(&jw);
+	}
+	jw_end(&jw);
+
+	emit_event(&jw, "cmd_exit");
+	jw_release(&jw);
+}
+
+static int cfg_path(const char *key, const char *value)
+{
+	if (is_absolute_path(value)) {
+		my__log_path = xstrdup(value);
+		my__is_enabled = 1;
+	} else {
+		warning("'%s' must be an absolute path: '%s'",
+			key, value);
+	}
+
+	return 0;
+}
+
+static int cfg_pretty(const char *key, const char *value)
+{
+	my__is_pretty = git_config_bool(key, value);
+	return 0;
+}
+
+int slog_default_config(const char *key, const char *value)
+{
+	const char *sub;
+
+	/*
+	 * git_default_config() calls slog_default_config() with "slog.*"
+	 * k/v pairs.  git_default_config() MAY or MAY NOT be called when
+	 * cmd_<command>() calls git_config().
+	 *
+	 * Remember if we've ever been called.
+	 */
+	my__is_config_loaded = 1;
+
+	if (skip_prefix(key, "slog.", &sub)) {
+		if (!strcmp(sub, "path"))
+			return cfg_path(key, value);
+		if (!strcmp(sub, "pretty"))
+			return cfg_pretty(key, value);
+	}
+
+	return 0;
+}
+
+static int lazy_load_config_cb(const char *key, const char * value, void *data)
+{
+	return slog_default_config(key, value);
+}
+
+/*
+ * If cmd_<command>() did not cause slog_default_config() to be called
+ * during git_config(), we try to lookup our config settings the first
+ * time we actually need them.
+ *
+ * (We do this rather than using read_early_config() at initialization
+ * because we want any "-c key=value" arguments to be included.)
+ */
+static inline void lazy_load_config(void)
+{
+	if (my__is_config_loaded)
+		return;
+	my__is_config_loaded = 1;
+
+	read_early_config(lazy_load_config_cb, NULL);
+}
+
+int slog_is_enabled(void)
+{
+	lazy_load_config();
+
+	return my__is_enabled;
+}
+
+static void do_final_steps(int in_signal)
+{
+	static int completed = 0;
+
+	if (completed)
+		return;
+	completed = 1;
+
+	if (slog_is_enabled()) {
+		if (!my__wrote_start_event)
+			emit_start_event();
+		emit_exit_event();
+		my__is_enabled = 0;
+	}
+
+	if (my__log_fd != -1)
+		close(my__log_fd);
+	free(my__log_path);
+	free(my__command_name);
+	free(my__sub_command_name);
+	argv_array_clear(&my__argv);
+	jw_release(&my__errors);
+}
+
+static void slog_atexit(void)
+{
+	do_final_steps(0);
+}
+
+static void slog_signal(int signo)
+{
+	my__signal = signo;
+
+	do_final_steps(1);
+
+	sigchain_pop(signo);
+	raise(signo);
+}
+
+static void intern_argv(int argc, const char **argv)
+{
+	int k;
+
+	for (k = 0; k < argc; k++)
+		argv_array_push(&my__argv, argv[k]);
+}
+
+/*
+ * Collect basic startup information before cmd_main() has a chance
+ * to alter the command line and before we have seen the config (to
+ * know if logging is enabled).  And since the config isn't loaded
+ * until cmd_main() dispatches to cmd_<command>(), we have to wait
+ * and lazy-write the "cmd_start" event.
+ *
+ * This also implies that commands such as "help" and "version" that
+ * don't need load the config won't generate any log data.
+ */
+static void initialize(int argc, const char **argv)
+{
+	my__start_time = getnanotime() / 1000;
+	my__pid = getpid();
+
+	intern_argv(argc, argv);
+
+	atexit(slog_atexit);
+
+	/*
+	 * Put up backstop signal handler to ensure we get the "cmd_exit"
+	 * event.  This is primarily for when the pager throws SIGPIPE
+	 * when the user quits.
+	 */
+	sigchain_push(SIGPIPE, slog_signal);
+}
+
+int slog_wrap_main(slog_fn_main_t fn_main, int argc, const char **argv)
+{
+	int result;
+
+	initialize(argc, argv);
+	result = fn_main(argc, argv);
+	slog_exit_code(result);
+
+	return result;
+}
+
+void slog_set_command_name(const char *command_name)
+{
+	/*
+	 * Capture the command name even if logging is not enabled
+	 * because we don't know if the config has been loaded yet by
+	 * the cmd_<command>() and/or it may be too early to force a
+	 * lazy load.
+	 */
+	if (my__command_name)
+		free(my__command_name);
+	my__command_name = xstrdup(command_name);
+}
+
+void slog_set_sub_command_name(const char *sub_command_name)
+{
+	/*
+	 * Capture the sub-command name even if logging is not enabled
+	 * because we don't know if the config has been loaded yet by
+	 * the cmd_<command>() and/or it may be too early to force a
+	 * lazy load.
+	 */
+	if (my__sub_command_name)
+		free(my__sub_command_name);
+	my__sub_command_name = xstrdup(sub_command_name);
+}
+
+int slog_is_pretty(void)
+{
+	return my__is_pretty;
+}
+
+int slog_exit_code(int exit_code)
+{
+	my__exit_time = getnanotime() / 1000;
+	my__exit_code = exit_code;
+
+	return exit_code;
+}
+
+void slog_error_message(const char *prefix, const char *fmt, va_list params)
+{
+	struct strbuf em = STRBUF_INIT;
+	va_list copy_params;
+
+	if (prefix && *prefix)
+		strbuf_addstr(&em, prefix);
+
+	va_copy(copy_params, params);
+	strbuf_vaddf(&em, fmt, copy_params);
+	va_end(copy_params);
+
+	if (!my__errors.json.len)
+		jw_array_begin(&my__errors, my__is_pretty);
+	jw_array_string(&my__errors, em.buf);
+	/* leave my__errors array unterminated for now */
+
+	strbuf_release(&em);
+}
+
 #endif
diff --git a/structured-logging.h b/structured-logging.h
index c9e8c1d..61e98e6 100644
--- a/structured-logging.h
+++ b/structured-logging.h
@@ -1,13 +1,95 @@
 #ifndef STRUCTURED_LOGGING_H
 #define STRUCTURED_LOGGING_H
 
+typedef int (*slog_fn_main_t)(int, const char **);
+
 #if !defined(STRUCTURED_LOGGING)
 /*
  * Structured logging is not available.
  * Stub out all API routines.
  */
+#define slog_is_available() (0)
+#define slog_default_config(k, v) (0)
+#define slog_wrap_main(real_cmd_main, argc, argv) ((real_cmd_main)((argc), (argv)))
+#define slog_set_command_name(n) do { } while (0)
+#define slog_set_sub_command_name(n) do { } while (0)
+#define slog_is_enabled() (0)
+#define slog_is_pretty() (0)
+#define slog_exit_code(exit_code) (exit_code)
+#define slog_error_message(prefix, fmt, params) do { } while (0)
 
 #else
 
+/*
+ * Is structured logging available (compiled-in)?
+ */
+#define slog_is_available() (1)
+
+/*
+ * Process "slog.*" config settings.
+ */
+int slog_default_config(const char *key, const char *value);
+
+/*
+ * Wrapper for the "real" cmd_main().  Initialize structured logging if
+ * enabled, run the given real_cmd_main(), and capture the return value.
+ *
+ * Note:  common-main.c is shared by many top-level commands.
+ * common-main.c:main() does common process setup before calling
+ * the version of cmd_main() found in the executable.  Some commands
+ * SHOULD NOT do logging (such as t/helper/test-tool).  Ones that do
+ * need some common initialization/teardown.
+ *
+ * Use this function for any top-level command that should do logging.
+ *
+ * Usage:
+ *
+ * static int real_cmd_main(int argc, const char **argv)
+ * {
+ *     ....the actual code for the command....
+ * }
+ *
+ * int cmd_main(int argc, const char **argv)
+ * {
+ *     return slog_wrap_main(real_cmd_main, argc, argv);
+ * }
+ * 
+ *
+ * See git.c for an example.
+ */ 
+int slog_wrap_main(slog_fn_main_t real_cmd_main, int argc, const char **argv);
+
+/*
+ * Record a canonical command name and optional sub-command name for the
+ * current process.  For example, "checkout" and "switch-branch".
+ */
+void slog_set_command_name(const char *name);
+void slog_set_sub_command_name(const char *name);
+
+/*
+ * Is structured logging enabled?
+ */
+int slog_is_enabled(void);
+
+/*
+ * Is JSON pretty-printing enabled?
+ */
+int slog_is_pretty(void);
+
+/*
+ * Register the process exit code with the structured logging layer
+ * and return it.  This value will appear in the final "cmd_exit" event.
+ *
+ * Use this to wrap all calls to exit().
+ * Use this before returning in main().
+ */
+int slog_exit_code(int exit_code);
+
+/*
+ * Append formatted error message to the structured log result.
+ * Messages from this will appear in the final "cmd_exit" event.
+ */
+void slog_error_message(const char *prefix, const char *fmt, va_list params);
+
 #endif /* STRUCTURED_LOGGING */
 #endif /* STRUCTURED_LOGGING_H */
diff --git a/usage.c b/usage.c
index cc80333..5d48f6b 100644
--- a/usage.c
+++ b/usage.c
@@ -27,12 +27,16 @@ static NORETURN void usage_builtin(const char *err, va_list params)
 
 static NORETURN void die_builtin(const char *err, va_list params)
 {
+	slog_error_message("fatal: ", err, params);
+
 	vreportf("fatal: ", err, params);
 	exit(128);
 }
 
 static void error_builtin(const char *err, va_list params)
 {
+	slog_error_message("error: ", err, params);
+
 	vreportf("error: ", err, params);
 }
 
-- 
2.9.3

