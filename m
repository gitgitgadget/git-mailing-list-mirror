Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E442F1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbeGMRMD (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:03 -0400
Received: from siwi.pair.com ([209.68.5.199]:31839 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731651AbeGMRMC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:02 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 95F833F4151;
        Fri, 13 Jul 2018 12:56:35 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2CFEE3F4149;
        Fri, 13 Jul 2018 12:56:35 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 08/25] structured-logging: add detail-event facility
Date:   Fri, 13 Jul 2018 16:56:04 +0000
Message-Id: <20180713165621.52017-9-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add a generic "detail-event" to structured logging.  This can be used
to emit context-specific events for performance or debugging purposes.
These are conceptually similar to the various GIT_TRACE_<key> messages.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/config.txt | 13 +++++++
 structured-logging.c     | 95 ++++++++++++++++++++++++++++++++++++++++++++++++
 structured-logging.h     | 16 ++++++++
 3 files changed, 124 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c79f2bf..88f93fe 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3176,6 +3176,19 @@ slog.pretty::
 	(EXPERIMENTAL) Pretty-print structured log data when true.
 	(Git must be compiled with STRUCTURED_LOGGING=1.)
 
+slog.detail::
+	(EXPERIMENTAL) May be set to a boolean value or a list of comma
+	separated tokens.  Controls which categories of optional "detail"
+	events are generated.  Default to off.  This is conceptually
+	similar to the different GIT_TRACE_<key> values.
++
+Detail events are generic events with a context-specific payload.  This
+may represent a single function call or a section of performance sensitive
+code.
++
+This is intended to be an extendable facility where new events can easily
+be added (possibly only for debugging or performance testing purposes).
+
 splitIndex.maxPercentChange::
 	When the split index feature is used, this specifies the
 	percent of entries the split index can contain compared to the
diff --git a/structured-logging.c b/structured-logging.c
index 289140f..9cbf3bd 100644
--- a/structured-logging.c
+++ b/structured-logging.c
@@ -34,6 +34,34 @@ static struct argv_array my__argv = ARGV_ARRAY_INIT;
 static struct strbuf my__session_id = STRBUF_INIT;
 static struct json_writer my__errors = JSON_WRITER_INIT;
 
+struct category_filter
+{
+	char *categories;
+	int want;
+};
+
+static struct category_filter my__detail_categories;
+
+static void set_want_categories(struct category_filter *cf, const char *value)
+{
+	FREE_AND_NULL(cf->categories);
+
+	cf->want = git_parse_maybe_bool(value);
+	if (cf->want == -1)
+		cf->categories = xstrdup(value);
+}
+
+static int want_category(const struct category_filter *cf, const char *category)
+{
+	if (cf->want == 0 || cf->want == 1)
+		return cf->want;
+
+	if (!category || !*category)
+		return 0;
+
+	return !!strstr(cf->categories, category);
+}
+
 /*
  * Compute a new session id for the current process.  Build string
  * with the start time and PID of the current process and append
@@ -207,6 +235,40 @@ static void emit_exit_event(void)
 	jw_release(&jw);
 }
 
+static void emit_detail_event(const char *category, const char *label,
+			      const struct json_writer *data)
+{
+	struct json_writer jw = JSON_WRITER_INIT;
+	uint64_t clock_us = getnanotime() / 1000;
+
+	/* build "detail" event */
+	jw_object_begin(&jw, my__is_pretty);
+	{
+		jw_object_string(&jw, "event", "detail");
+		jw_object_intmax(&jw, "clock_us", (intmax_t)clock_us);
+		jw_object_intmax(&jw, "pid", (intmax_t)my__pid);
+		jw_object_string(&jw, "sid", my__session_id.buf);
+
+		if (my__command_name && *my__command_name)
+			jw_object_string(&jw, "command", my__command_name);
+		if (my__sub_command_name && *my__sub_command_name)
+			jw_object_string(&jw, "sub_command", my__sub_command_name);
+
+		jw_object_inline_begin_object(&jw, "detail");
+		{
+			jw_object_string(&jw, "category", category);
+			jw_object_string(&jw, "label", label);
+			if (data)
+				jw_object_sub_jw(&jw, "data", data);
+		}
+		jw_end(&jw);
+	}
+	jw_end(&jw);
+
+	emit_event(&jw, "detail");
+	jw_release(&jw);
+}
+
 static int cfg_path(const char *key, const char *value)
 {
 	if (is_absolute_path(value)) {
@@ -226,6 +288,12 @@ static int cfg_pretty(const char *key, const char *value)
 	return 0;
 }
 
+static int cfg_detail(const char *key, const char *value)
+{
+	set_want_categories(&my__detail_categories, value);
+	return 0;
+}
+
 int slog_default_config(const char *key, const char *value)
 {
 	const char *sub;
@@ -244,6 +312,8 @@ int slog_default_config(const char *key, const char *value)
 			return cfg_path(key, value);
 		if (!strcmp(sub, "pretty"))
 			return cfg_pretty(key, value);
+		if (!strcmp(sub, "detail"))
+			return cfg_detail(key, value);
 	}
 
 	return 0;
@@ -424,4 +494,29 @@ void slog_error_message(const char *prefix, const char *fmt, va_list params)
 	strbuf_release(&em);
 }
 
+int slog_want_detail_event(const char *category)
+{
+	return want_category(&my__detail_categories, category);
+}
+
+void slog_emit_detail_event(const char *category, const char *label,
+			    const struct json_writer *data)
+{
+	if (!my__wrote_start_event)
+		emit_start_event();
+
+	if (!slog_want_detail_event(category))
+		return;
+
+	if (!category || !*category)
+		BUG("no category for slog.detail event");
+	if (!label || !*label)
+		BUG("no label for slog.detail event");
+	if (data && !jw_is_terminated(data))
+		BUG("unterminated slog.detail data: '%s' '%s' '%s'",
+		    category, label, data->json.buf);
+
+	emit_detail_event(category, label, data);
+}
+
 #endif
diff --git a/structured-logging.h b/structured-logging.h
index 61e98e6..01ae55d 100644
--- a/structured-logging.h
+++ b/structured-logging.h
@@ -1,6 +1,8 @@
 #ifndef STRUCTURED_LOGGING_H
 #define STRUCTURED_LOGGING_H
 
+struct json_writer;
+
 typedef int (*slog_fn_main_t)(int, const char **);
 
 #if !defined(STRUCTURED_LOGGING)
@@ -17,6 +19,8 @@ typedef int (*slog_fn_main_t)(int, const char **);
 #define slog_is_pretty() (0)
 #define slog_exit_code(exit_code) (exit_code)
 #define slog_error_message(prefix, fmt, params) do { } while (0)
+#define slog_want_detail_event(category) (0)
+#define slog_emit_detail_event(category, label, data) do { } while (0)
 
 #else
 
@@ -91,5 +95,17 @@ int slog_exit_code(int exit_code);
  */
 void slog_error_message(const char *prefix, const char *fmt, va_list params);
 
+/*
+ * Is detail logging enabled for this category?
+ */
+int slog_want_detail_event(const char *category);
+
+/*
+ * Write a detail event.
+ */
+
+void slog_emit_detail_event(const char *category, const char *label,
+			    const struct json_writer *data);
+
 #endif /* STRUCTURED_LOGGING */
 #endif /* STRUCTURED_LOGGING_H */
-- 
2.9.3

