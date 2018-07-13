Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD1011F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbeGMRMN (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:13 -0400
Received: from siwi.pair.com ([209.68.5.199]:31926 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387881AbeGMRMM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:12 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 400E33F4817;
        Fri, 13 Jul 2018 12:56:45 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CC61A3F47EE;
        Fri, 13 Jul 2018 12:56:44 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 25/25] structured-logging: add config data facility
Date:   Fri, 13 Jul 2018 16:56:21 +0000
Message-Id: <20180713165621.52017-26-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add "config" section to "cmd_exit" event to record important
configuration settings in the log.

Add the value of "slog.detail", "slog.timers", and "slog.aux" config
settings to the log.  These values control the filtering of the log.
Knowing the filter settings can help post-processors reason about
the contents of the log.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 structured-logging.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++
 structured-logging.h |  13 +++++
 2 files changed, 145 insertions(+)

diff --git a/structured-logging.c b/structured-logging.c
index 2571e79..0e3f79e 100644
--- a/structured-logging.c
+++ b/structured-logging.c
@@ -83,6 +83,20 @@ struct child_data_array {
 static struct child_data_array my__child_data;
 static void free_children(void);
 
+struct config_data {
+	char *group;
+	struct json_writer jw;
+};
+
+struct config_data_array {
+	struct config_data **array;
+	size_t nr, alloc;
+};
+
+static struct config_data_array my__config_data;
+static void format_config_data(struct json_writer *jw);
+static void free_config_data(void);
+
 static uint64_t my__start_time;
 static uint64_t my__exit_time;
 static int my__is_config_loaded;
@@ -132,6 +146,15 @@ static int want_category(const struct category_filter *cf, const char *category)
 	return !!strstr(cf->categories, category);
 }
 
+static void set_config_data_from_category(const struct category_filter *cf,
+					  const char *key)
+{
+	if (cf->want == 0 || cf->want == 1)
+		slog_set_config_data_intmax(key, cf->want);
+	else
+		slog_set_config_data_string(key, cf->categories);
+}
+
 /*
  * Compute a new session id for the current process.  Build string
  * with the start time and PID of the current process and append
@@ -249,6 +272,18 @@ static void emit_exit_event(void)
 	struct json_writer jw = JSON_WRITER_INIT;
 	uint64_t atexit_time = getnanotime() / 1000;
 
+	/*
+	 * Copy important (and non-obvious) config settings into the
+	 * "config" section of the "cmd_exit" event.  The values of
+	 * "slog.detail", "slog.timers", and "slog.aux" are used in
+	 * category want filtering, so post-processors should know the
+	 * filter settings so that they can tell if an event is missing
+	 * because of filtering or an error.
+	 */
+	set_config_data_from_category(&my__detail_categories, "slog.detail");
+	set_config_data_from_category(&my__timer_categories, "slog.timers");
+	set_config_data_from_category(&my__aux_categories, "slog.aux");
+
 	/* close unterminated forms */
 	if (my__errors.json.len)
 		jw_end(&my__errors);
@@ -299,6 +334,12 @@ static void emit_exit_event(void)
 		}
 		jw_end(&jw);
 
+		if (my__config_data.nr) {
+			jw_object_inline_begin_object(&jw, "config");
+			format_config_data(&jw);
+			jw_end(&jw);
+		}
+
 		if (my__timers.nr) {
 			jw_object_inline_begin_object(&jw, "timers");
 			format_timers(&jw);
@@ -479,6 +520,7 @@ static void do_final_steps(int in_signal)
 	free_child_summary_data();
 	free_timers();
 	free_children();
+	free_config_data();
 }
 
 static void slog_atexit(void)
@@ -1084,4 +1126,94 @@ static void free_children(void)
 	my__child_data.alloc = 0;
 }
 
+/*
+ * Split <key> into <group>.<sub_key> (for example "slog.path" into "slog" and "path")
+ * Find or insert <group> in config_data_array[].
+ *
+ * Return config_data_arary[<group>].
+ */
+static struct config_data *find_config_data(const char *key, const char **sub_key)
+{
+	struct config_data *cd;
+	char *dot;
+	size_t group_len;
+	int k;
+
+	dot = strchr(key, '.');
+	if (!dot)
+		return NULL;
+
+	*sub_key = dot + 1;
+
+	group_len = dot - key;
+
+	for (k = 0; k < my__config_data.nr; k++) {
+		cd = my__config_data.array[k];
+		if (!strncmp(key, cd->group, group_len))
+			return cd;
+	}
+
+	cd = xcalloc(1, sizeof(struct config_data));
+	cd->group = xstrndup(key, group_len);
+
+	jw_object_begin(&cd->jw, my__is_pretty);
+	/* leave per-group object unterminated for now */
+
+	ALLOC_GROW(my__config_data.array, my__config_data.nr + 1,
+		   my__config_data.alloc);
+	my__config_data.array[my__config_data.nr++] = cd;
+
+	return cd;
+}
+
+void slog_set_config_data_string(const char *key, const char *value)
+{
+	const char *sub_key;
+	struct config_data *cd = find_config_data(key, &sub_key);
+
+	if (cd)
+		jw_object_string(&cd->jw, sub_key, value);
+}
+
+void slog_set_config_data_intmax(const char *key, intmax_t value)
+{
+	const char *sub_key;
+	struct config_data *cd = find_config_data(key, &sub_key);
+
+	if (cd)
+		jw_object_intmax(&cd->jw, sub_key, value);
+}
+
+static void format_config_data(struct json_writer *jw)
+{
+	int k;
+
+	for (k = 0; k < my__config_data.nr; k++) {
+		struct config_data *cd = my__config_data.array[k];
+
+		/* termminate per-group form */
+		jw_end(&cd->jw);
+
+		/* insert per-category form into containing "config" form */
+		jw_object_sub_jw(jw, cd->group, &cd->jw);
+	}
+}
+
+static void free_config_data(void)
+{
+	int k;
+
+	for (k = 0; k < my__config_data.nr; k++) {
+		struct config_data *cd = my__config_data.array[k];
+
+		jw_release(&cd->jw);
+		free(cd->group);
+		free(cd);
+	}
+
+	FREE_AND_NULL(my__config_data.array);
+	my__config_data.nr = 0;
+	my__config_data.alloc = 0;
+}
+
 #endif
diff --git a/structured-logging.h b/structured-logging.h
index 7c98d33..2c90267 100644
--- a/structured-logging.h
+++ b/structured-logging.h
@@ -34,6 +34,8 @@ static inline void slog_stop_timer(int tid) { };
 #define slog_aux_jw(c, k, v) do { } while (0)
 #define slog_child_starting(cmd) (SLOG_UNDEFINED_CHILD_ID)
 #define slog_child_ended(i, p, ec) do { } while (0)
+#define slog_set_config_data_string(k, v) do { } while (0)
+#define slog_set_config_data_intmax(k, v) do { } while (0)
 
 #else
 
@@ -162,5 +164,16 @@ void slog_aux_jw(const char *category, const char *key,
 int slog_child_starting(const struct child_process *cmd);
 void slog_child_ended(int child_id, int child_pid, int child_exit_code);
 
+/*
+ * Add an important config key/value pair to the "cmd_event".  Keys
+ * are assumed to be of the form <group>.<name>, such as "slog.path".
+ * The pair will appear under the "config" object in the resulting JSON
+ * as "config.<group>.<name>:<value>".
+ *
+ * This should only be used for important config settings.
+ */
+void slog_set_config_data_string(const char *key, const char *value);
+void slog_set_config_data_intmax(const char *key, intmax_t value);
+
 #endif /* STRUCTURED_LOGGING */
 #endif /* STRUCTURED_LOGGING_H */
-- 
2.9.3

