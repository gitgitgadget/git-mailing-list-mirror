Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C6FF1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387754AbeGMRMF (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:05 -0400
Received: from siwi.pair.com ([209.68.5.199]:31839 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731651AbeGMRME (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:04 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B72F83F4149;
        Fri, 13 Jul 2018 12:56:36 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4F6853F415F;
        Fri, 13 Jul 2018 12:56:36 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 10/25] structured-logging: add timer facility
Date:   Fri, 13 Jul 2018 16:56:06 +0000
Message-Id: <20180713165621.52017-11-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add timer facility to structured logging.  This allows stopwatch-like
operations over the life of the git process.  Timer data is summarized
in the "cmd_exit" event.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/config.txt |   6 ++
 structured-logging.c     | 180 +++++++++++++++++++++++++++++++++++++++++++++++
 structured-logging.h     |  19 +++++
 3 files changed, 205 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 88f93fe..7817966 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3189,6 +3189,12 @@ code.
 This is intended to be an extendable facility where new events can easily
 be added (possibly only for debugging or performance testing purposes).
 
+slog.timers::
+	(EXPERIMENTAL) May be set to a boolean value or a list of comma
+	separated tokens.  Controls which categories of SLOG timers are
+	enabled.  Defaults to off.  Data for enabled timers is added to
+	the `cmd_exit` event.
+
 splitIndex.maxPercentChange::
 	When the split index feature is used, this specifies the
 	percent of entries the split index can contain compared to the
diff --git a/structured-logging.c b/structured-logging.c
index 9cbf3bd..215138c 100644
--- a/structured-logging.c
+++ b/structured-logging.c
@@ -15,6 +15,26 @@
 
 #define SLOG_VERSION 0
 
+struct timer_data {
+	char *category;
+	char *name;
+	uint64_t total_ns;
+	uint64_t min_ns;
+	uint64_t max_ns;
+	uint64_t start_ns;
+	int count;
+	int started;
+};
+
+struct timer_data_array {
+	struct timer_data **array;
+	size_t nr, alloc;
+};
+
+static struct timer_data_array my__timers;
+static void format_timers(struct json_writer *jw);
+static void free_timers(void);
+
 static uint64_t my__start_time;
 static uint64_t my__exit_time;
 static int my__is_config_loaded;
@@ -41,6 +61,7 @@ struct category_filter
 };
 
 static struct category_filter my__detail_categories;
+static struct category_filter my__timer_categories;
 
 static void set_want_categories(struct category_filter *cf, const char *value)
 {
@@ -228,6 +249,12 @@ static void emit_exit_event(void)
 			jw_object_intmax(&jw, "slog", SLOG_VERSION);
 		}
 		jw_end(&jw);
+
+		if (my__timers.nr) {
+			jw_object_inline_begin_object(&jw, "timers");
+			format_timers(&jw);
+			jw_end(&jw);
+		}
 	}
 	jw_end(&jw);
 
@@ -294,6 +321,12 @@ static int cfg_detail(const char *key, const char *value)
 	return 0;
 }
 
+static int cfg_timers(const char *key, const char *value)
+{
+	set_want_categories(&my__timer_categories, value);
+	return 0;
+}
+
 int slog_default_config(const char *key, const char *value)
 {
 	const char *sub;
@@ -314,6 +347,8 @@ int slog_default_config(const char *key, const char *value)
 			return cfg_pretty(key, value);
 		if (!strcmp(sub, "detail"))
 			return cfg_detail(key, value);
+		if (!strcmp(sub, "timers"))
+			return cfg_timers(key, value);
 	}
 
 	return 0;
@@ -371,6 +406,7 @@ static void do_final_steps(int in_signal)
 	argv_array_clear(&my__argv);
 	jw_release(&my__errors);
 	strbuf_release(&my__session_id);
+	free_timers();
 }
 
 static void slog_atexit(void)
@@ -519,4 +555,148 @@ void slog_emit_detail_event(const char *category, const char *label,
 	emit_detail_event(category, label, data);
 }
 
+int slog_start_timer(const char *category, const char *name)
+{
+	int k;
+	struct timer_data *td;
+
+	if (!want_category(&my__timer_categories, category))
+		return SLOG_UNDEFINED_TIMER_ID;
+	if (!name || !*name)
+		return SLOG_UNDEFINED_TIMER_ID;
+
+	for (k = 0; k < my__timers.nr; k++) {
+		td = my__timers.array[k];
+		if (!strcmp(category, td->category) && !strcmp(name, td->name))
+			goto start_timer;
+	}
+
+	td = xcalloc(1, sizeof(struct timer_data));
+	td->category = xstrdup(category);
+	td->name = xstrdup(name);
+	td->min_ns = UINT64_MAX;
+
+	ALLOC_GROW(my__timers.array, my__timers.nr + 1, my__timers.alloc);
+	my__timers.array[my__timers.nr++] = td;
+
+start_timer:
+	if (td->started)
+		BUG("slog.timer '%s:%s' already started",
+		    td->category, td->name);
+
+	td->start_ns = getnanotime();
+	td->started = 1;
+
+	return k;
+}
+
+static void stop_timer(struct timer_data *td)
+{
+	uint64_t delta_ns = getnanotime() - td->start_ns;
+
+	td->count++;
+	td->total_ns += delta_ns;
+	if (delta_ns < td->min_ns)
+		td->min_ns = delta_ns;
+	if (delta_ns > td->max_ns)
+		td->max_ns = delta_ns;
+	td->started = 0;
+}
+
+void slog_stop_timer(int tid)
+{
+	struct timer_data *td;
+
+	if (tid == SLOG_UNDEFINED_TIMER_ID)
+		return;
+	if (tid >= my__timers.nr || tid < 0)
+		BUG("Invalid slog.timer id '%d'", tid);
+
+	td = my__timers.array[tid];
+	if (!td->started)
+		BUG("slog.timer '%s:%s' not started", td->category, td->name);
+
+	stop_timer(td);
+}
+
+static int sort_timers_cb(const void *a, const void *b)
+{
+	struct timer_data *td_a = *(struct timer_data **)a;
+	struct timer_data *td_b = *(struct timer_data **)b;
+	int r;
+
+	r = strcmp(td_a->category, td_b->category);
+	if (r)
+		return r;
+	return strcmp(td_a->name, td_b->name);
+}
+
+static void format_a_timer(struct json_writer *jw, struct timer_data *td,
+			   int force_stop)
+{
+	jw_object_inline_begin_object(jw, td->name);
+	{
+		jw_object_intmax(jw, "count", td->count);
+		jw_object_intmax(jw, "total_us", td->total_ns / 1000);
+		if (td->count > 1) {
+			uint64_t avg_ns = td->total_ns / td->count;
+
+			jw_object_intmax(jw, "min_us", td->min_ns / 1000);
+			jw_object_intmax(jw, "max_us", td->max_ns / 1000);
+			jw_object_intmax(jw, "avg_us", avg_ns / 1000);
+		}
+		if (force_stop)
+			jw_object_true(jw, "force_stop");
+	}
+	jw_end(jw);
+}
+
+static void format_timers(struct json_writer *jw)
+{
+	const char *open_category = NULL;
+	int k;
+
+	QSORT(my__timers.array, my__timers.nr, sort_timers_cb);
+
+	for (k = 0; k < my__timers.nr; k++) {
+		struct timer_data *td = my__timers.array[k];
+		int force_stop = td->started;
+
+		if (force_stop)
+			stop_timer(td);
+
+		if (!open_category) {
+			jw_object_inline_begin_object(jw, td->category);
+			open_category = td->category;
+		}
+		else if (strcmp(open_category, td->category)) {
+			jw_end(jw);
+			jw_object_inline_begin_object(jw, td->category);
+			open_category = td->category;
+		}
+
+		format_a_timer(jw, td, force_stop);
+	}
+
+	if (open_category)
+		jw_end(jw);
+}
+
+static void free_timers(void)
+{
+	int k;
+
+	for (k = 0; k < my__timers.nr; k++) {
+		struct timer_data *td = my__timers.array[k];
+
+		free(td->category);
+		free(td->name);
+		free(td);
+	}
+
+	FREE_AND_NULL(my__timers.array);
+	my__timers.nr = 0;
+	my__timers.alloc = 0;
+}
+
 #endif
diff --git a/structured-logging.h b/structured-logging.h
index 01ae55d..a29aa6e 100644
--- a/structured-logging.h
+++ b/structured-logging.h
@@ -5,6 +5,8 @@ struct json_writer;
 
 typedef int (*slog_fn_main_t)(int, const char **);
 
+#define SLOG_UNDEFINED_TIMER_ID (-1)
+
 #if !defined(STRUCTURED_LOGGING)
 /*
  * Structured logging is not available.
@@ -21,6 +23,8 @@ typedef int (*slog_fn_main_t)(int, const char **);
 #define slog_error_message(prefix, fmt, params) do { } while (0)
 #define slog_want_detail_event(category) (0)
 #define slog_emit_detail_event(category, label, data) do { } while (0)
+#define slog_start_timer(category, name) (SLOG_UNDEFINED_TIMER_ID)
+static inline void slog_stop_timer(int tid) { };
 
 #else
 
@@ -107,5 +111,20 @@ int slog_want_detail_event(const char *category);
 void slog_emit_detail_event(const char *category, const char *label,
 			    const struct json_writer *data);
 
+/*
+ * Define and start or restart a structured logging timer.  Stats for the
+ * timer will be added to the "cmd_exit" event. Use a timer when you are
+ * interested in the net time of an operation (such as part of a computation
+ * in a loop) but don't want a detail event for each iteration.
+ *
+ * Returns a timer id.
+ */
+int slog_start_timer(const char *category, const char *name);
+
+/*
+ * Stop the timer.
+ */
+void slog_stop_timer(int tid);
+
 #endif /* STRUCTURED_LOGGING */
 #endif /* STRUCTURED_LOGGING_H */
-- 
2.9.3

