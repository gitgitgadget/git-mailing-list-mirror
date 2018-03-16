Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A97A1FAE2
	for <e@80x24.org>; Fri, 16 Mar 2018 20:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeCPUAj (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:00:39 -0400
Received: from siwi.pair.com ([209.68.5.199]:10319 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752205AbeCPUAg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:00:36 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id CB6213F408A;
        Fri, 16 Mar 2018 15:41:15 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 42F5E3F4088;
        Fri, 16 Mar 2018 15:41:15 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, lars.schneider@autodesk.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 1/2] json_writer: new routines to create data in JSON format
Date:   Fri, 16 Mar 2018 19:40:56 +0000
Message-Id: <20180316194057.77513-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180316194057.77513-1-git@jeffhostetler.com>
References: <20180316194057.77513-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add basic routines to generate data in JSON format.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile      |   1 +
 json-writer.c | 224 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 json-writer.h | 120 +++++++++++++++++++++++++++++++
 3 files changed, 345 insertions(+)
 create mode 100644 json-writer.c
 create mode 100644 json-writer.h

diff --git a/Makefile b/Makefile
index 1a9b23b..9000369 100644
--- a/Makefile
+++ b/Makefile
@@ -815,6 +815,7 @@ LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
 LIB_OBJS += ident.o
+LIB_OBJS += json-writer.o
 LIB_OBJS += kwset.o
 LIB_OBJS += levenshtein.o
 LIB_OBJS += line-log.o
diff --git a/json-writer.c b/json-writer.c
new file mode 100644
index 0000000..755ff80
--- /dev/null
+++ b/json-writer.c
@@ -0,0 +1,224 @@
+#include "cache.h"
+#include "json-writer.h"
+
+/*
+ * Append JSON-quoted version of the given string to 'out'.
+ */
+static void jw_append_quoted_string(struct strbuf *out, const char *in)
+{
+	strbuf_addch(out, '"');
+	for (/**/; *in; in++) {
+		unsigned char c = (unsigned char)*in;
+		if (c == '"')
+			strbuf_add(out, "\\\"", 2);
+		else if (c == '\\')
+			strbuf_add(out, "\\\\", 2);
+		else if (c == '\n')
+			strbuf_add(out, "\\n", 2);
+		else if (c == '\r')
+			strbuf_add(out, "\\r", 2);
+		else if (c == '\t')
+			strbuf_add(out, "\\t", 2);
+		else if (c == '\f')
+			strbuf_add(out, "\\f", 2);
+		else if (c == '\b')
+			strbuf_add(out, "\\b", 2);
+		else if (c < 0x20)
+			strbuf_addf(out, "\\u%04x", c);
+		else
+			strbuf_addch(out, c);
+	}
+	strbuf_addch(out, '"');
+}
+
+void jw_object_begin(struct strbuf *out)
+{
+	strbuf_reset(out);
+	strbuf_addch(out, '{');
+}
+
+void jw_object_append_string(struct strbuf *out, const char *key,
+			     const char *value)
+{
+	if (out->len > 1)
+		strbuf_addch(out, ',');
+
+	jw_append_quoted_string(out, key);
+	strbuf_addch(out, ':');
+	jw_append_quoted_string(out, value);
+}
+
+void jw_object_append_int(struct strbuf *out, const char *key, int value)
+{
+	if (out->len > 1)
+		strbuf_addch(out, ',');
+
+	jw_append_quoted_string(out, key);
+	strbuf_addf(out, ":%d", value);
+}
+
+void jw_object_append_uint64(struct strbuf *out, const char *key, uint64_t value)
+{
+	if (out->len > 1)
+		strbuf_addch(out, ',');
+
+	jw_append_quoted_string(out, key);
+	strbuf_addf(out, ":%"PRIuMAX, value);
+}
+
+void jw_object_append_double(struct strbuf *out, const char *key, double value)
+{
+	if (out->len > 1)
+		strbuf_addch(out, ',');
+
+	jw_append_quoted_string(out, key);
+	strbuf_addf(out, ":%f", value);
+}
+
+void jw_object_append_true(struct strbuf *out, const char *key)
+{
+	if (out->len > 1)
+		strbuf_addch(out, ',');
+
+	jw_append_quoted_string(out, key);
+	strbuf_addstr(out, ":true");
+}
+
+void jw_object_append_false(struct strbuf *out, const char *key)
+{
+	if (out->len > 1)
+		strbuf_addch(out, ',');
+
+	jw_append_quoted_string(out, key);
+	strbuf_addstr(out, ":false");
+}
+
+void jw_object_append_null(struct strbuf *out, const char *key)
+{
+	if (out->len > 1)
+		strbuf_addch(out, ',');
+
+	jw_append_quoted_string(out, key);
+	strbuf_addstr(out, ":null");
+}
+
+void jw_object_append_object(struct strbuf *out, const char *key,
+			     const char *value)
+{
+	if (out->len > 1)
+		strbuf_addch(out, ',');
+
+	jw_append_quoted_string(out, key);
+	strbuf_addch(out, ':');
+	strbuf_addstr(out, value);
+}
+
+void jw_object_append_array(struct strbuf *out, const char *key,
+			    const char *value)
+{
+	if (out->len > 1)
+		strbuf_addch(out, ',');
+
+	jw_append_quoted_string(out, key);
+	strbuf_addch(out, ':');
+	strbuf_addstr(out, value);
+}
+
+void jw_object_end(struct strbuf *out)
+{
+	strbuf_addch(out, '}');
+}
+
+void jw_array_begin(struct strbuf *out)
+{
+	strbuf_reset(out);
+	strbuf_addch(out, '[');
+}
+
+void jw_array_append_string(struct strbuf *out, const char *elem)
+{
+	struct strbuf qe = STRBUF_INIT;
+
+	jw_append_quoted_string(&qe, elem);
+
+	if (out->len > 1)
+		strbuf_addch(out, ',');
+	strbuf_addstr(out, qe.buf);
+
+	strbuf_release(&qe);
+}
+
+void jw_array_append_int(struct strbuf *out, int elem)
+{
+	if (out->len > 1)
+		strbuf_addch(out, ',');
+	strbuf_addf(out, "%d", elem);
+}
+
+void jw_array_append_uint64(struct strbuf *out, uint64_t elem)
+{
+	if (out->len > 1)
+		strbuf_addch(out, ',');
+	strbuf_addf(out, "%"PRIuMAX, elem);
+}
+
+void jw_array_append_double(struct strbuf *out, double elem)
+{
+	if (out->len > 1)
+		strbuf_addch(out, ',');
+	strbuf_addf(out, "%f", elem);
+}
+
+void jw_array_append_true(struct strbuf *out)
+{
+	if (out->len > 1)
+		strbuf_addch(out, ',');
+	strbuf_addstr(out, "true");
+}
+
+void jw_array_append_false(struct strbuf *out)
+{
+	if (out->len > 1)
+		strbuf_addch(out, ',');
+	strbuf_addstr(out, "false");
+}
+
+void jw_array_append_null(struct strbuf *out)
+{
+	if (out->len > 1)
+		strbuf_addch(out, ',');
+	strbuf_addstr(out, "null");
+}
+
+void jw_array_append_object(struct strbuf *out, const char *obj)
+{
+	if (out->len > 1)
+		strbuf_addch(out, ',');
+	strbuf_addstr(out, obj);
+}
+
+void jw_array_append_array(struct strbuf *out, const char *array)
+{
+	if (out->len > 1)
+		strbuf_addch(out, ',');
+	strbuf_addstr(out, array);
+}
+
+void jw_array_append_argc_argv(struct strbuf *out, int argc, const char **argv)
+{
+	int k;
+
+	for (k = 0; k < argc; k++)
+		jw_array_append_string(out, argv[k]);
+}
+
+void jw_array_append_argv(struct strbuf *out, const char **argv)
+{
+	while (*argv)
+		jw_array_append_string(out, *argv++);
+}
+
+void jw_array_end(struct strbuf *out)
+{
+	strbuf_addch(out, ']');
+}
diff --git a/json-writer.h b/json-writer.h
new file mode 100644
index 0000000..0a60ab3
--- /dev/null
+++ b/json-writer.h
@@ -0,0 +1,120 @@
+#ifndef JSON_WRITER_H
+#define JSON_WRITER_H
+
+/*
+ * JSON data structures are defined at:
+ *      http://json.org/
+ *      http://www.ietf.org/rfc/rfc7159.txt
+ *
+ * The JSON-writer API allows one to build JSON data structures using a
+ * "struct strbuf" buffer.  This is intended as a simple API to build
+ * output strings; it is not intended to be a general object model for
+ * JSON data.
+ *
+ * All string values (both keys and string r-values) are properly quoted
+ * and escaped if they contain special characters.
+ *
+ * These routines create compact JSON data (with no unnecessary whitespace,
+ * newlines, or indenting).
+ *
+ * Both "JSON objects" (aka sets of k/v pairs) and "JSON array" can be
+ * constructed using a 'begin append* end' model.
+ *
+ * Example JSON Object Usage:
+ *
+ *      struct strbuf obj1 = STRBUF_INIT;
+ *
+ *      jw_object_begin(&obj1);
+ *          jw_object_append_string(&obj1, "a", "abc");
+ *          jw_object_append_int(&obj1, "b", 42);
+ *          jw_object_append_true(&obj1, "c");
+ *      jw_object_end(&obj1);
+ *
+ *      printf("%s\n", obj1.buf);
+ *
+ * Should yield:   
+ *
+ *      {"a":"abc","b":42,"c":true}
+ *
+ * Example JSON Array Usage:
+ *
+ *      struct strbuf arr1 = STRBUF_INIT;
+ *
+ *      jw_array_begin(&arr1);
+ *          jw_array_append_string(&arr1, "abc");
+ *          jw_array_append_int(&arr1, 42);
+ *          jw_array_append_true(&arr1);
+ *      jw_array_end(&arr1);
+ *
+ *      printf("%s\n", arr1.buf);
+ *
+ * Should yield:
+ *
+ *      ["abc",42,true]
+ *
+ * Nested JSON structures are also supported.  These should be composed bottom
+ * up using multiple strbuf variables.
+ *
+ * Example Nested Usage (using the above "obj1" and "arr1" variables):
+ *
+ *       struct strbuf obj2 = STRBUF_INIT;
+ *
+ *       jw_object_begin(&obj2);
+ *           jw_object_append_object(&obj2, "obj1", obj1.buf);
+ *           jw_object_append_array(&obj2, "arr1", arr1.buf);
+ *       jw_object_end(&obj2);
+ *
+ *       printf("%s\n", obj2.buf);
+ *
+ * Should yield:
+ *
+ *       {"obj1":{"a":"abc","b":42,"c":true},"arr1":["abc",42,true]}
+ *
+ * And:
+ *
+ *       struct strbuf arr2 = STRBUF_INIT;
+ *
+ *       jw_array_begin(&arr2);
+ *           jw_array_append_object(&arr2, obj1.buf);
+ *           jw_array_append_array(&arr2, arr1.buf);
+ *       jw_array_end(&arr2);
+ *
+ *       printf("%s\n", arr2.buf);
+ *
+ * Should yield:
+ *
+ *       [{"a":"abc","b":42,"c":true},["abc",42,true]]
+ *
+ */
+
+void jw_object_begin(struct strbuf *out);
+void jw_object_append_string(struct strbuf *out, const char *key,
+			     const char *value);
+void jw_object_append_int(struct strbuf *out, const char *key, int value);
+void jw_object_append_uint64(struct strbuf *out, const char *key,
+			     uint64_t value);
+void jw_object_append_double(struct strbuf *out, const char *key, double value);
+void jw_object_append_true(struct strbuf *out, const char *key);
+void jw_object_append_false(struct strbuf *out, const char *key);
+void jw_object_append_null(struct strbuf *out, const char *key);
+void jw_object_append_object(struct strbuf *out, const char *key,
+			     const char *value);
+void jw_object_append_array(struct strbuf *out, const char *key,
+			    const char *value);
+void jw_object_end(struct strbuf *out);
+
+void jw_array_begin(struct strbuf *out);
+void jw_array_append_string(struct strbuf *out, const char *elem);
+void jw_array_append_int(struct strbuf *out, int elem);
+void jw_array_append_uint64(struct strbuf *out, uint64_t elem);
+void jw_array_append_double(struct strbuf *out, double elem);
+void jw_array_append_true(struct strbuf *out);
+void jw_array_append_false(struct strbuf *out);
+void jw_array_append_null(struct strbuf *out);
+void jw_array_append_object(struct strbuf *out, const char *obj);
+void jw_array_append_array(struct strbuf *out, const char *array);
+void jw_array_append_argc_argv(struct strbuf *out, int argc, const char **argv);
+void jw_array_append_argv(struct strbuf *out, const char **argv);
+void jw_array_end(struct strbuf *out);
+
+#endif /* JSON_WRITER_H */
-- 
2.9.3

