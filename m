Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AD241F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387818AbeGMRMI (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:08 -0400
Received: from siwi.pair.com ([209.68.5.199]:31833 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387769AbeGMRMH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:07 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 25F673F4816;
        Fri, 13 Jul 2018 12:56:40 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B254D3F4801;
        Fri, 13 Jul 2018 12:56:39 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 16/25] structured-logging: add aux-data facility
Date:   Fri, 13 Jul 2018 16:56:12 +0000
Message-Id: <20180713165621.52017-17-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add facility to add extra data to the structured logging data allowing
arbitrary key/value pair data to be added to the "cmd_exit" event.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/config.txt |   6 +++
 structured-logging.c     | 116 +++++++++++++++++++++++++++++++++++++++++++++++
 structured-logging.h     |  21 +++++++++
 3 files changed, 143 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7817966..ca78d4c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3195,6 +3195,12 @@ slog.timers::
 	enabled.  Defaults to off.  Data for enabled timers is added to
 	the `cmd_exit` event.
 
+slog.aux::
+	(EXPERIMENTAL) May be set to a boolean value or a list of
+	comma separated tokens.  Controls which categories of SLOG
+	"aux" data are enabled.  Defaults to off.  "Aux" data is added
+	to the `cmd_exit` event.
+
 splitIndex.maxPercentChange::
 	When the split index feature is used, this specifies the
 	percent of entries the split index can contain compared to the
diff --git a/structured-logging.c b/structured-logging.c
index 215138c..584f70a 100644
--- a/structured-logging.c
+++ b/structured-logging.c
@@ -35,6 +35,19 @@ static struct timer_data_array my__timers;
 static void format_timers(struct json_writer *jw);
 static void free_timers(void);
 
+struct aux_data {
+	char *category;
+	struct json_writer jw;
+};
+
+struct aux_data_array {
+	struct aux_data **array;
+	size_t nr, alloc;
+};
+
+static struct aux_data_array my__aux_data;
+static void format_and_free_aux_data(struct json_writer *jw);
+
 static uint64_t my__start_time;
 static uint64_t my__exit_time;
 static int my__is_config_loaded;
@@ -62,6 +75,7 @@ struct category_filter
 
 static struct category_filter my__detail_categories;
 static struct category_filter my__timer_categories;
+static struct category_filter my__aux_categories;
 
 static void set_want_categories(struct category_filter *cf, const char *value)
 {
@@ -255,6 +269,12 @@ static void emit_exit_event(void)
 			format_timers(&jw);
 			jw_end(&jw);
 		}
+
+		if (my__aux_data.nr) {
+			jw_object_inline_begin_object(&jw, "aux");
+			format_and_free_aux_data(&jw);
+			jw_end(&jw);
+		}
 	}
 	jw_end(&jw);
 
@@ -327,6 +347,12 @@ static int cfg_timers(const char *key, const char *value)
 	return 0;
 }
 
+static int cfg_aux(const char *key, const char *value)
+{
+	set_want_categories(&my__aux_categories, value);
+	return 0;
+}
+
 int slog_default_config(const char *key, const char *value)
 {
 	const char *sub;
@@ -349,6 +375,8 @@ int slog_default_config(const char *key, const char *value)
 			return cfg_detail(key, value);
 		if (!strcmp(sub, "timers"))
 			return cfg_timers(key, value);
+		if (!strcmp(sub, "aux"))
+			return cfg_aux(key, value);
 	}
 
 	return 0;
@@ -699,4 +727,92 @@ static void free_timers(void)
 	my__timers.alloc = 0;
 }
 
+int slog_want_aux(const char *category)
+{
+	return want_category(&my__aux_categories, category);
+}
+
+static struct aux_data *find_aux_data(const char *category)
+{
+	struct aux_data *ad;
+	int k;
+
+	if (!slog_want_aux(category))
+		return NULL;
+
+	for (k = 0; k < my__aux_data.nr; k++) {
+		ad = my__aux_data.array[k];
+		if (!strcmp(category, ad->category))
+			return ad;
+	}
+
+	ad = xcalloc(1, sizeof(struct aux_data));
+	ad->category = xstrdup(category);
+
+	jw_array_begin(&ad->jw, my__is_pretty);
+	/* leave per-category object unterminated for now */
+
+	ALLOC_GROW(my__aux_data.array, my__aux_data.nr + 1, my__aux_data.alloc);
+	my__aux_data.array[my__aux_data.nr++] = ad;
+
+	return ad;
+}
+
+#define add_to_aux(c, k, v, fn)						\
+	do {								\
+		struct aux_data *ad = find_aux_data((c));		\
+		if (ad) {						\
+			jw_array_inline_begin_array(&ad->jw);		\
+			{						\
+				jw_array_string(&ad->jw, (k));		\
+				(fn)(&ad->jw, (v));			\
+			}						\
+			jw_end(&ad->jw);				\
+		}							\
+	} while (0)
+
+void slog_aux_string(const char *category, const char *key, const char *value)
+{
+	add_to_aux(category, key, value, jw_array_string);
+}
+
+void slog_aux_intmax(const char *category, const char *key, intmax_t value)
+{
+	add_to_aux(category, key, value, jw_array_intmax);
+}
+
+void slog_aux_bool(const char *category, const char *key, int value)
+{
+	add_to_aux(category, key, value, jw_array_bool);
+}
+
+void slog_aux_jw(const char *category, const char *key,
+		 const struct json_writer *value)
+{
+	add_to_aux(category, key, value, jw_array_sub_jw);
+}
+
+static void format_and_free_aux_data(struct json_writer *jw)
+{
+	int k;
+
+	for (k = 0; k < my__aux_data.nr; k++) {
+		struct aux_data *ad = my__aux_data.array[k];
+
+		/* terminate per-category form */
+		jw_end(&ad->jw);
+
+		/* insert per-category form into containing "aux" form */
+		jw_object_sub_jw(jw, ad->category, &ad->jw);
+
+		jw_release(&ad->jw);
+		free(ad->category);
+		free(ad);
+	}
+
+	FREE_AND_NULL(my__aux_data.array);
+	my__aux_data.nr = 0;
+	my__aux_data.alloc = 0;
+}
+
 #endif
diff --git a/structured-logging.h b/structured-logging.h
index a29aa6e..2272598 100644
--- a/structured-logging.h
+++ b/structured-logging.h
@@ -25,6 +25,11 @@ typedef int (*slog_fn_main_t)(int, const char **);
 #define slog_emit_detail_event(category, label, data) do { } while (0)
 #define slog_start_timer(category, name) (SLOG_UNDEFINED_TIMER_ID)
 static inline void slog_stop_timer(int tid) { };
+#define slog_want_aux(c) (0)
+#define slog_aux_string(c, k, v) do { } while (0)
+#define slog_aux_intmax(c, k, v) do { } while (0)
+#define slog_aux_bool(c, k, v) do { } while (0)
+#define slog_aux_jw(c, k, v) do { } while (0)
 
 #else
 
@@ -126,5 +131,21 @@ int slog_start_timer(const char *category, const char *name);
  */
 void slog_stop_timer(int tid);
 
+/*
+ * Add arbitrary extra key/value data to the "cmd_exit" event.
+ * These fields will appear under the "aux" object.  This is
+ * intended for "interesting" config values or repo stats, such
+ * as the size of the index.
+ *
+ * These key/value pairs are written as an array-pair rather than
+ * an object/value because the keys may be repeated.
+ */
+int slog_want_aux(const char *category);
+void slog_aux_string(const char *category, const char *key, const char *value);
+void slog_aux_intmax(const char *category, const char *key, intmax_t value);
+void slog_aux_bool(const char *category, const char *key, int value);
+void slog_aux_jw(const char *category, const char *key,
+		 const struct json_writer *value);
+
 #endif /* STRUCTURED_LOGGING */
 #endif /* STRUCTURED_LOGGING_H */
-- 
2.9.3

