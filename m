Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40E241F404
	for <e@80x24.org>; Mon, 26 Mar 2018 14:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbeCZOcA (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 10:32:00 -0400
Received: from siwi.pair.com ([209.68.5.199]:21958 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752129AbeCZOb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 10:31:58 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C49993F4008;
        Mon, 26 Mar 2018 10:31:57 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E85793F4015;
        Mon, 26 Mar 2018 10:31:56 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, l.s.r@web.de, wink@saville.com,
        ramsay@ramsayjones.plus.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4] json_writer: new routines to create data in JSON format
Date:   Mon, 26 Mar 2018 14:31:36 +0000
Message-Id: <20180326143136.47116-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180326143136.47116-1-git@jeffhostetler.com>
References: <20180326143136.47116-1-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add a series of jw_ routines and "struct json_writer" structure to compose
JSON data.  The resulting string data can then be output by commands wanting
to support a JSON output format.

The json-writer routines can be used to generate structured data in a
JSON-like format.  We say "JSON-like" because we do not enforce the Unicode
(usually UTF-8) requirement on string fields.  Internally, Git does not
necessarily have Unicode/UTF-8 data for most fields, so it is currently
unclear the best way to enforce that requirement.  For example, on Linx
pathnames can contain arbitrary 8-bit character data, so a command like
"status" would not know how to encode the reported pathnames.  We may want
to revisit this (or double encode such strings) in the future.

The initial use for the json-writer routines is for generating telemetry
data for executed Git commands.  Later, we may want to use them in other
commands, such as status.

Helped-by: René Scharfe <l.s.r@web.de>
Helped-by: Wink Saville <wink@saville.com>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                    |   2 +
 json-writer.c               | 395 +++++++++++++++++++++++++++++
 json-writer.h               |  92 +++++++
 t/helper/test-json-writer.c | 590 ++++++++++++++++++++++++++++++++++++++++++++
 t/t0019-json-writer.sh      | 253 +++++++++++++++++++
 5 files changed, 1332 insertions(+)
 create mode 100644 json-writer.c
 create mode 100644 json-writer.h
 create mode 100644 t/helper/test-json-writer.c
 create mode 100755 t/t0019-json-writer.sh

diff --git a/Makefile b/Makefile
index 1a9b23b..57f58e6 100644
--- a/Makefile
+++ b/Makefile
@@ -662,6 +662,7 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-genrandom
 TEST_PROGRAMS_NEED_X += test-hashmap
 TEST_PROGRAMS_NEED_X += test-index-version
+TEST_PROGRAMS_NEED_X += test-json-writer
 TEST_PROGRAMS_NEED_X += test-lazy-init-name-hash
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-match-trees
@@ -815,6 +816,7 @@ LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
 LIB_OBJS += ident.o
+LIB_OBJS += json-writer.o
 LIB_OBJS += kwset.o
 LIB_OBJS += levenshtein.o
 LIB_OBJS += line-log.o
diff --git a/json-writer.c b/json-writer.c
new file mode 100644
index 0000000..ddcbd2a
--- /dev/null
+++ b/json-writer.c
@@ -0,0 +1,395 @@
+#include "cache.h"
+#include "json-writer.h"
+
+void jw_init(struct json_writer *jw)
+{
+	strbuf_reset(&jw->json);
+	strbuf_reset(&jw->open_stack);
+	jw->first = 0;
+	jw->pretty = 0;
+}
+
+/*
+ * Append JSON-quoted version of the given string to 'out'.
+ */
+static void append_quoted_string(struct strbuf *out, const char *in)
+{
+	unsigned char c;
+
+	strbuf_addch(out, '"');
+	while ((c = *in++) != '\0') {
+		if (c == '"')
+			strbuf_addstr(out, "\\\"");
+		else if (c == '\\')
+			strbuf_addstr(out, "\\\\");
+		else if (c == '\n')
+			strbuf_addstr(out, "\\n");
+		else if (c == '\r')
+			strbuf_addstr(out, "\\r");
+		else if (c == '\t')
+			strbuf_addstr(out, "\\t");
+		else if (c == '\f')
+			strbuf_addstr(out, "\\f");
+		else if (c == '\b')
+			strbuf_addstr(out, "\\b");
+		else if (c < 0x20)
+			strbuf_addf(out, "\\u%04x", c);
+		else
+			strbuf_addch(out, c);
+	}
+	strbuf_addch(out, '"');
+}
+
+static inline void indent_pretty(struct json_writer *jw)
+{
+	int k;
+
+	if (!jw->pretty)
+		return;
+
+	for (k = 0; k < jw->open_stack.len; k++)
+		strbuf_addstr(&jw->json, "  ");
+}
+
+static inline void begin(struct json_writer *jw, char ch_open, int pretty)
+{
+	jw->pretty = pretty;
+	jw->first = 1;
+
+	strbuf_addch(&jw->json, ch_open);
+
+	strbuf_addch(&jw->open_stack, ch_open);
+}
+
+/*
+ * Assert that the top of the open-stack is an object.
+ */
+static inline void assert_in_object(const struct json_writer *jw, const char *key)
+{
+	if (!jw->open_stack.len)
+		die("json-writer: object: missing jw_object_begin(): '%s'", key);
+	if (jw->open_stack.buf[jw->open_stack.len - 1] != '{')
+		die("json-writer: object: not in object: '%s'", key);
+}
+
+/*
+ * Assert that the top of the open-stack is an array.
+ */
+static inline void assert_in_array(const struct json_writer *jw)
+{
+	if (!jw->open_stack.len)
+		die("json-writer: array: missing jw_array_begin()");
+	if (jw->open_stack.buf[jw->open_stack.len - 1] != '[')
+		die("json-writer: array: not in array");
+}
+
+/*
+ * Add comma if we have already seen a member at this level.
+ */
+static inline void maybe_add_comma(struct json_writer *jw)
+{
+	if (!jw->open_stack.len)
+		return;
+	if (jw->first)
+		jw->first = 0;
+	else
+		strbuf_addch(&jw->json, ',');
+}
+
+static inline void fmt_double(struct json_writer *jw, int precision,
+			      double value)
+{
+	if (precision < 0) {
+		strbuf_addf(&jw->json, "%f", value);
+	} else {
+		struct strbuf fmt = STRBUF_INIT;
+		strbuf_addf(&fmt, "%%.%df", precision);
+		strbuf_addf(&jw->json, fmt.buf, value);
+		strbuf_release(&fmt);
+	}
+}
+
+static inline void object_common(struct json_writer *jw, const char *key)
+{
+	assert_in_object(jw, key);
+	maybe_add_comma(jw);
+
+	if (jw->pretty)
+		strbuf_addch(&jw->json, '\n');
+	indent_pretty(jw);
+
+	append_quoted_string(&jw->json, key);
+	strbuf_addch(&jw->json, ':');
+	if (jw->pretty)
+		strbuf_addch(&jw->json, ' ');
+}
+
+static inline void array_common(struct json_writer *jw)
+{
+	assert_in_array(jw);
+	maybe_add_comma(jw);
+
+	if (jw->pretty)
+		strbuf_addch(&jw->json, '\n');
+	indent_pretty(jw);
+}
+
+/*
+ * Assert that the given JSON object or JSON array has been properly
+ * terminated.  (Has closing bracket.)
+ */
+static inline void assert_is_terminated(const struct json_writer *jw)
+{
+	if (jw->open_stack.len)
+		die("json-writer: object: missing jw_end(): '%s'",
+		    jw->json.buf);
+}
+
+void jw_object_begin(struct json_writer *jw, int pretty)
+{
+	begin(jw, '{', pretty);
+}
+
+void jw_object_string(struct json_writer *jw, const char *key, const char *value)
+{
+	object_common(jw, key);
+	append_quoted_string(&jw->json, value);
+}
+
+void jw_object_int(struct json_writer *jw, const char *key, int value)
+{
+	object_common(jw, key);
+	strbuf_addf(&jw->json, "%d", value);
+}
+
+void jw_object_uint64(struct json_writer *jw, const char *key, uint64_t value)
+{
+	object_common(jw, key);
+	strbuf_addf(&jw->json, "%"PRIuMAX, (uintmax_t)value);
+}
+
+void jw_object_double(struct json_writer *jw, const char *key, int precision,
+		      double value)
+{
+	object_common(jw, key);
+	fmt_double(jw, precision, value);
+}
+
+void jw_object_true(struct json_writer *jw, const char *key)
+{
+	object_common(jw, key);
+	strbuf_addstr(&jw->json, "true");
+}
+
+void jw_object_false(struct json_writer *jw, const char *key)
+{
+	object_common(jw, key);
+	strbuf_addstr(&jw->json, "false");
+}
+
+void jw_object_null(struct json_writer *jw, const char *key)
+{
+	object_common(jw, key);
+	strbuf_addstr(&jw->json, "null");
+}
+
+static void increase_indent(struct strbuf *sb,
+			    const struct json_writer *jw,
+			    int indent)
+{
+	int k;
+
+	strbuf_reset(sb);
+	for (k = 0; k < jw->json.len; k++) {
+		char ch = jw->json.buf[k];
+		strbuf_addch(sb, ch);
+		if (ch == '\n')
+			strbuf_addchars(sb, ' ', indent);
+	}
+}
+
+static void kill_indent(struct strbuf *sb,
+			const struct json_writer *jw)
+{
+	int k;
+	int eat_it = 0;
+
+	strbuf_reset(sb);
+	for (k = 0; k < jw->json.len; k++) {
+		char ch = jw->json.buf[k];
+		if (eat_it && ch == ' ')
+			continue;
+		if (ch == '\n') {
+			eat_it = 1;
+			continue;
+		}
+		eat_it = 0;
+		strbuf_addch(sb, ch);
+	}
+}
+
+/*
+ * Append existing (properly terminated) JSON sub-data (object or array)
+ * as-is onto the given JSON data.
+ */
+void jw_object_sub_jw(struct json_writer *jw, const char *key,
+		      const struct json_writer *value)
+{
+	assert_is_terminated(value);
+
+	object_common(jw, key);
+
+	/*
+	 * If both are pretty, increase the indentation of the sub_jw
+	 * to better fit under the super.
+	 *
+	 * If the super is pretty, but the sub_jw is compact, leave the
+	 * sub_jw compact.  (We don't want to parse and rebuild the sub_jw
+	 * for this debug-ish feature.)
+	 *
+	 * If the super is compact, and the sub_jw is pretty, convert
+	 * the sub_jw to compact.
+	 *
+	 * If both are compact, keep the sub_jw compact.
+	 */
+	if (jw->pretty && jw->open_stack.len && value->pretty) {
+		struct strbuf sb = STRBUF_INIT;
+		increase_indent(&sb, value, jw->open_stack.len * 2);
+		strbuf_addbuf(&jw->json, &sb);
+		strbuf_release(&sb);
+		return;
+	}
+	if (!jw->pretty && value->pretty) {
+		struct strbuf sb = STRBUF_INIT;
+		kill_indent(&sb, value);
+		strbuf_addbuf(&jw->json, &sb);
+		strbuf_release(&sb);
+		return;
+	}
+
+	strbuf_addbuf(&jw->json, &value->json);
+}
+
+void jw_object_inline_begin_object(struct json_writer *jw, const char *key)
+{
+	object_common(jw, key);
+
+	jw_object_begin(jw, jw->pretty);
+}
+
+void jw_object_inline_begin_array(struct json_writer *jw, const char *key)
+{
+	object_common(jw, key);
+
+	jw_array_begin(jw, jw->pretty);
+}
+
+void jw_array_begin(struct json_writer *jw, int pretty)
+{
+	begin(jw, '[', pretty);
+}
+
+void jw_array_string(struct json_writer *jw, const char *value)
+{
+	array_common(jw);
+	append_quoted_string(&jw->json, value);
+}
+
+void jw_array_int(struct json_writer *jw,int value)
+{
+	array_common(jw);
+	strbuf_addf(&jw->json, "%d", value);
+}
+
+void jw_array_uint64(struct json_writer *jw, uint64_t value)
+{
+	array_common(jw);
+	strbuf_addf(&jw->json, "%"PRIuMAX, (uintmax_t)value);
+}
+
+void jw_array_double(struct json_writer *jw, int precision, double value)
+{
+	array_common(jw);
+	fmt_double(jw, precision, value);
+}
+
+void jw_array_true(struct json_writer *jw)
+{
+	array_common(jw);
+	strbuf_addstr(&jw->json, "true");
+}
+
+void jw_array_false(struct json_writer *jw)
+{
+	array_common(jw);
+	strbuf_addstr(&jw->json, "false");
+}
+
+void jw_array_null(struct json_writer *jw)
+{
+	array_common(jw);
+	strbuf_addstr(&jw->json, "null");
+}
+
+void jw_array_sub_jw(struct json_writer *jw, const struct json_writer *value)
+{
+	assert_is_terminated(value);
+
+	array_common(jw);
+	strbuf_addbuf(&jw->json, &value->json);
+}
+
+void jw_array_argc_argv(struct json_writer *jw, int argc, const char **argv)
+{
+	int k;
+
+	for (k = 0; k < argc; k++)
+		jw_array_string(jw, argv[k]);
+}
+
+void jw_array_argv(struct json_writer *jw, const char **argv)
+{
+	while (*argv)
+		jw_array_string(jw, *argv++);
+}
+
+void jw_array_inline_begin_object(struct json_writer *jw)
+{
+	array_common(jw);
+
+	jw_object_begin(jw, jw->pretty);
+}
+
+void jw_array_inline_begin_array(struct json_writer *jw)
+{
+	array_common(jw);
+
+	jw_array_begin(jw, jw->pretty);
+}
+
+int jw_is_terminated(const struct json_writer *jw)
+{
+	return !jw->open_stack.len;
+}
+
+void jw_end(struct json_writer *jw)
+{
+	char ch_open;
+	int len;
+
+	if (!jw->open_stack.len)
+		die("json-writer: too many jw_end(): '%s'", jw->json.buf);
+
+	len = jw->open_stack.len - 1;
+	ch_open = jw->open_stack.buf[len];
+	strbuf_setlen(&jw->open_stack, len);
+
+	if (jw->pretty)
+		strbuf_addch(&jw->json, '\n');
+	indent_pretty(jw);
+
+	if (ch_open == '{')
+		strbuf_addch(&jw->json, '}');
+	else
+		strbuf_addch(&jw->json, ']');
+}
diff --git a/json-writer.h b/json-writer.h
new file mode 100644
index 0000000..16376ee
--- /dev/null
+++ b/json-writer.h
@@ -0,0 +1,92 @@
+#ifndef JSON_WRITER_H
+#define JSON_WRITER_H
+
+/*
+ * JSON data structures are defined at:
+ * [1] http://www.ietf.org/rfc/rfc7159.txt
+ * [2] http://json.org/
+ *
+ * The JSON-writer API allows one to build JSON data structures using a
+ * simple wrapper around a "struct strbuf" buffer.  It is intended as a
+ * simple API to build output strings; it is not intended to be a general
+ * object model for JSON data.  In particular, it does not re-order keys
+ * in an object (dictionary), it does not de-dup keys in an object, and
+ * it does not allow lookup or parsing of JSON data.
+ *
+ * All string values (both keys and string r-values) are properly quoted
+ * and escaped if they contain special characters.
+ *
+ * These routines create compact JSON data (with no unnecessary whitespace,
+ * newlines, or indenting).  If you get an unexpected response, verify
+ * that you're not expecting a pretty JSON string.
+ *
+ * Both "JSON objects" (aka sets of k/v pairs) and "JSON array" can be
+ * constructed using a 'begin append* end' model.
+ *
+ * Nested objects and arrays can either be constructed bottom up (by
+ * creating sub object/arrays first and appending them to the super
+ * object/array) -or- by building them inline in one pass.  This is a
+ * personal style and/or data shape choice.
+ *
+ * See t/helper/test-json-writer.c for various usage examples.
+ *
+ * LIMITATIONS:
+ * ============
+ *
+ * The JSON specification [1,2] defines string values as Unicode data
+ * and probably UTF-8 encoded.  The current json-writer API does not
+ * enforce this and will write any string as received.  However, it will
+ * properly quote and backslash-escape them as necessary.  It is up to
+ * the caller to UTF-8 encode their strings *before* passing them to this
+ * API.  This layer should not have to try to guess the encoding or locale
+ * of the given strings.
+ */
+
+struct json_writer
+{
+	struct strbuf json;
+	struct strbuf open_stack;
+	int first;
+	int pretty;
+};
+
+#define JSON_WRITER_INIT { STRBUF_INIT, STRBUF_INIT, 0, 0 }
+
+void jw_init(struct json_writer *jw);
+
+void jw_object_begin(struct json_writer *jw, int pretty);
+void jw_array_begin(struct json_writer *jw, int pretty);
+
+void jw_object_string(struct json_writer *jw, const char *key,
+		      const char *value);
+void jw_object_int(struct json_writer *jw, const char *key, int value);
+void jw_object_uint64(struct json_writer *jw, const char *key, uint64_t value);
+void jw_object_double(struct json_writer *jw, const char *key, int precision,
+		      double value);
+void jw_object_true(struct json_writer *jw, const char *key);
+void jw_object_false(struct json_writer *jw, const char *key);
+void jw_object_null(struct json_writer *jw, const char *key);
+void jw_object_sub_jw(struct json_writer *jw, const char *key,
+		      const struct json_writer *value);
+
+void jw_object_inline_begin_object(struct json_writer *jw, const char *key);
+void jw_object_inline_begin_array(struct json_writer *jw, const char *key);
+
+void jw_array_string(struct json_writer *jw, const char *value);
+void jw_array_int(struct json_writer *jw,int value);
+void jw_array_uint64(struct json_writer *jw, uint64_t value);
+void jw_array_double(struct json_writer *jw, int precision, double value);
+void jw_array_true(struct json_writer *jw);
+void jw_array_false(struct json_writer *jw);
+void jw_array_null(struct json_writer *jw);
+void jw_array_sub_jw(struct json_writer *jw, const struct json_writer *value);
+void jw_array_argc_argv(struct json_writer *jw, int argc, const char **argv);
+void jw_array_argv(struct json_writer *jw, const char **argv);
+
+void jw_array_inline_begin_object(struct json_writer *jw);
+void jw_array_inline_begin_array(struct json_writer *jw);
+
+int jw_is_terminated(const struct json_writer *jw);
+void jw_end(struct json_writer *jw);
+
+#endif /* JSON_WRITER_H */
diff --git a/t/helper/test-json-writer.c b/t/helper/test-json-writer.c
new file mode 100644
index 0000000..0f50c67
--- /dev/null
+++ b/t/helper/test-json-writer.c
@@ -0,0 +1,590 @@
+#include "cache.h"
+#include "json-writer.h"
+
+static const char *expect_obj1 = "{\"a\":\"abc\",\"b\":42,\"c\":true}";
+static const char *expect_obj2 = "{\"a\":-1,\"b\":2147483647,\"c\":0}";
+static const char *expect_obj3 = "{\"a\":0,\"b\":4294967295,\"c\":18446744073709551615}";
+static const char *expect_obj4 = "{\"t\":true,\"f\":false,\"n\":null}";
+static const char *expect_obj5 = "{\"abc\\tdef\":\"abc\\\\def\"}";
+static const char *expect_obj6 = "{\"a\":3.14}";
+
+static const char *pretty_obj1 = ("{\n"
+				  "  \"a\": \"abc\",\n"
+				  "  \"b\": 42,\n"
+				  "  \"c\": true\n"
+				  "}");
+static const char *pretty_obj2 = ("{\n"
+				  "  \"a\": -1,\n"
+				  "  \"b\": 2147483647,\n"
+				  "  \"c\": 0\n"
+				  "}");
+static const char *pretty_obj3 = ("{\n"
+				  "  \"a\": 0,\n"
+				  "  \"b\": 4294967295,\n"
+				  "  \"c\": 18446744073709551615\n"
+				  "}");
+static const char *pretty_obj4 = ("{\n"
+				  "  \"t\": true,\n"
+				  "  \"f\": false,\n"
+				  "  \"n\": null\n"
+				  "}");
+
+static struct json_writer obj1 = JSON_WRITER_INIT;
+static struct json_writer obj2 = JSON_WRITER_INIT;
+static struct json_writer obj3 = JSON_WRITER_INIT;
+static struct json_writer obj4 = JSON_WRITER_INIT;
+static struct json_writer obj5 = JSON_WRITER_INIT;
+static struct json_writer obj6 = JSON_WRITER_INIT;
+
+static void make_obj1(int pretty)
+{
+	jw_object_begin(&obj1, pretty);
+	{
+		jw_object_string(&obj1, "a", "abc");
+		jw_object_int(&obj1, "b", 42);
+		jw_object_true(&obj1, "c");
+	}
+	jw_end(&obj1);
+}
+
+static void make_obj2(int pretty)
+{
+	jw_object_begin(&obj2, pretty);
+	{
+		jw_object_int(&obj2, "a", -1);
+		jw_object_int(&obj2, "b", 0x7fffffff);
+		jw_object_int(&obj2, "c", 0);
+	}
+	jw_end(&obj2);
+}
+
+static void make_obj3(int pretty)
+{
+	jw_object_begin(&obj3, pretty);
+	{
+		jw_object_uint64(&obj3, "a", 0);
+		jw_object_uint64(&obj3, "b", 0xffffffff);
+		jw_object_uint64(&obj3, "c", 0xffffffffffffffffULL);
+	}
+	jw_end(&obj3);
+}
+
+static void make_obj4(int pretty)
+{
+	jw_object_begin(&obj4, pretty);
+	{
+		jw_object_true(&obj4, "t");
+		jw_object_false(&obj4, "f");
+		jw_object_null(&obj4, "n");
+	}
+	jw_end(&obj4);
+}
+
+static void make_obj5(int pretty)
+{
+	jw_object_begin(&obj5, pretty);
+	{
+		jw_object_string(&obj5, "abc" "\x09" "def", "abc" "\\" "def");
+	}
+	jw_end(&obj5);
+}
+
+static void make_obj6(int pretty)
+{
+	jw_object_begin(&obj6, pretty);
+	{
+		jw_object_double(&obj6, "a", 2, 3.14159);
+	}
+	jw_end(&obj6);
+}
+
+static const char *expect_arr1 = "[\"abc\",42,true]";
+static const char *expect_arr2 = "[-1,2147483647,0]";
+static const char *expect_arr3 = "[0,4294967295,18446744073709551615]";
+static const char *expect_arr4 = "[true,false,null]";
+
+static const char *pretty_arr1 = ("[\n"
+				  "  \"abc\",\n"
+				  "  42,\n"
+				  "  true\n"
+				  "]");
+static const char *pretty_arr2 = ("[\n"
+				  "  -1,\n"
+				  "  2147483647,\n"
+				  "  0\n"
+				  "]");
+static const char *pretty_arr3 = ("[\n"
+				  "  0,\n"
+				  "  4294967295,\n"
+				  "  18446744073709551615\n"
+				  "]");
+static const char *pretty_arr4 = ("[\n"
+				  "  true,\n"
+				  "  false,\n"
+				  "  null\n"
+				  "]");
+
+static struct json_writer arr1 = JSON_WRITER_INIT;
+static struct json_writer arr2 = JSON_WRITER_INIT;
+static struct json_writer arr3 = JSON_WRITER_INIT;
+static struct json_writer arr4 = JSON_WRITER_INIT;
+
+static void make_arr1(int pretty)
+{
+	jw_array_begin(&arr1, pretty);
+	{
+		jw_array_string(&arr1, "abc");
+		jw_array_int(&arr1, 42);
+		jw_array_true(&arr1);
+	}
+	jw_end(&arr1);
+}
+
+static void make_arr2(int pretty)
+{
+	jw_array_begin(&arr2, pretty);
+	{
+		jw_array_int(&arr2, -1);
+		jw_array_int(&arr2, 0x7fffffff);
+		jw_array_int(&arr2, 0);
+	}
+	jw_end(&arr2);
+}
+
+static void make_arr3(int pretty)
+{
+	jw_array_begin(&arr3, pretty);
+	{
+		jw_array_uint64(&arr3, 0);
+		jw_array_uint64(&arr3, 0xffffffff);
+		jw_array_uint64(&arr3, 0xffffffffffffffffULL);
+	}
+	jw_end(&arr3);
+}
+
+static void make_arr4(int pretty)
+{
+	jw_array_begin(&arr4, pretty);
+	{
+		jw_array_true(&arr4);
+		jw_array_false(&arr4);
+		jw_array_null(&arr4);
+	}
+	jw_end(&arr4);
+}
+
+static char *expect_nest1 =
+	"{\"obj1\":{\"a\":\"abc\",\"b\":42,\"c\":true},\"arr1\":[\"abc\",42,true]}";
+
+static struct json_writer nest1 = JSON_WRITER_INIT;
+
+static void make_nest1(int pretty)
+{
+	jw_object_begin(&nest1, pretty);
+	{
+		jw_object_sub_jw(&nest1, "obj1", &obj1);
+		jw_object_sub_jw(&nest1, "arr1", &arr1);
+	}
+	jw_end(&nest1);
+}
+
+static char *expect_inline1 =
+	"{\"obj1\":{\"a\":\"abc\",\"b\":42,\"c\":true},\"arr1\":[\"abc\",42,true]}";
+
+static char *pretty_inline1 =
+	("{\n"
+	 "  \"obj1\": {\n"
+	 "    \"a\": \"abc\",\n"
+	 "    \"b\": 42,\n"
+	 "    \"c\": true\n"
+	 "  },\n"
+	 "  \"arr1\": [\n"
+	 "    \"abc\",\n"
+	 "    42,\n"
+	 "    true\n"
+	 "  ]\n"
+	 "}");
+
+static struct json_writer inline1 = JSON_WRITER_INIT;
+
+static void make_inline1(int pretty)
+{
+	jw_object_begin(&inline1, pretty);
+	{
+		jw_object_inline_begin_object(&inline1, "obj1");
+		{
+			jw_object_string(&inline1, "a", "abc");
+			jw_object_int(&inline1, "b", 42);
+			jw_object_true(&inline1, "c");
+		}
+		jw_end(&inline1);
+		jw_object_inline_begin_array(&inline1, "arr1");
+		{
+			jw_array_string(&inline1, "abc");
+			jw_array_int(&inline1, 42);
+			jw_array_true(&inline1);
+		}
+		jw_end(&inline1);
+	}
+	jw_end(&inline1);
+}
+
+static char *expect_inline2 =
+	"[[1,2],[3,4],{\"a\":\"abc\"}]";
+
+static char *pretty_inline2 =
+	("[\n"
+	 "  [\n"
+	 "    1,\n"
+	 "    2\n"
+	 "  ],\n"
+	 "  [\n"
+	 "    3,\n"
+	 "    4\n"
+	 "  ],\n"
+	 "  {\n"
+	 "    \"a\": \"abc\"\n"
+	 "  }\n"
+	 "]");
+
+static struct json_writer inline2 = JSON_WRITER_INIT;
+
+static void make_inline2(int pretty)
+{
+	jw_array_begin(&inline2, pretty);
+	{
+		jw_array_inline_begin_array(&inline2);
+		{
+			jw_array_int(&inline2, 1);
+			jw_array_int(&inline2, 2);
+		}
+		jw_end(&inline2);
+		jw_array_inline_begin_array(&inline2);
+		{
+			jw_array_int(&inline2, 3);
+			jw_array_int(&inline2, 4);
+		}
+		jw_end(&inline2);
+		jw_array_inline_begin_object(&inline2);
+		{
+			jw_object_string(&inline2, "a", "abc");
+		}
+		jw_end(&inline2);
+	}
+	jw_end(&inline2);
+}
+
+/*
+ * When super is compact, we expect subs to be compacted (even if originally
+ * pretty).
+ */ 
+static const char *expect_mixed1 =
+	("{\"obj1\":{\"a\":\"abc\",\"b\":42,\"c\":true},"
+	 "\"arr1\":[\"abc\",42,true]}");
+
+/*
+ * When super is pretty, a compact sub (obj1) is kept compact and a pretty
+ * sub (arr1) is re-indented.
+ */
+static const char *pretty_mixed1 =
+	("{\n"
+	 "  \"obj1\": {\"a\":\"abc\",\"b\":42,\"c\":true},\n"
+	 "  \"arr1\": [\n"
+	 "    \"abc\",\n"
+	 "    42,\n"
+	 "    true\n"
+	 "  ]\n"
+	 "}");
+
+static struct json_writer mixed1 = JSON_WRITER_INIT;
+
+static void make_mixed1(int pretty)
+{
+	jw_init(&obj1);
+	jw_init(&arr1);
+
+	make_obj1(0); /* obj1 is compact */
+	make_arr1(1); /* arr1 is pretty */
+
+	jw_object_begin(&mixed1, pretty);
+	{
+		jw_object_sub_jw(&mixed1, "obj1", &obj1);
+		jw_object_sub_jw(&mixed1, "arr1", &arr1);
+	}
+	jw_end(&mixed1);
+}
+
+static void cmp(const char *test, const struct json_writer *jw, const char *exp)
+{
+	if (!strcmp(jw->json.buf, exp))
+		return;
+
+	printf("error[%s]: observed '%s' expected '%s'\n",
+	       test, jw->json.buf, exp);
+	exit(1);
+}
+
+#define t(v) do { make_##v(0); cmp(#v, &v, expect_##v); } while (0)
+#define p(v) do { make_##v(1); cmp(#v, &v, pretty_##v); } while (0)
+
+/*
+ * Run some basic regression tests with some known patterns.
+ * These tests also demonstrate how to use the jw_ API.
+ */
+static int unit_tests(void)
+{
+	/* comptact (canonical) forms */
+	t(obj1);
+	t(obj2);
+	t(obj3);
+	t(obj4);
+	t(obj5);
+	t(obj6);
+
+	t(arr1);
+	t(arr2);
+	t(arr3);
+	t(arr4);
+
+	t(nest1);
+
+	t(inline1);
+	t(inline2);
+
+	jw_init(&obj1);
+	jw_init(&obj2);
+	jw_init(&obj3);
+	jw_init(&obj4);
+
+	jw_init(&arr1);
+	jw_init(&arr2);
+	jw_init(&arr3);
+	jw_init(&arr4);
+
+	jw_init(&inline1);
+	jw_init(&inline2);
+
+	/* pretty forms */
+	p(obj1);
+	p(obj2);
+	p(obj3);
+	p(obj4);
+
+	p(arr1);
+	p(arr2);
+	p(arr3);
+	p(arr4);
+
+	p(inline1);
+	p(inline2);
+
+	/* mixed forms */
+	t(mixed1);
+	jw_init(&mixed1);
+	p(mixed1);
+
+	return 0;
+}
+
+#define STMT(s) do { s } while (0)
+
+#define PARAM(tok, lbl, p) \
+	STMT( if (!(p) || (*(p) == '@')) \
+		die("token '%s' requires '%s' parameter, but saw: '%s'", \
+		    tok, lbl, p); )
+
+#define KEY() \
+	STMT( key = argv[++k]; \
+	      PARAM(a_k, "key", key); )
+
+#define VAL() \
+	STMT( val = argv[++k]; \
+	      PARAM(a_k, "val", val); )
+
+#define PRECISION() \
+	STMT( const char *s = argv[++k]; \
+	      PARAM(a_k, "precision", s); \
+	      precision = strtol(s, &endptr, 10); \
+	      if (*endptr || errno == ERANGE) \
+		die("invalid '%s' precision: '%s'", a_k, s); )
+
+#define VAL_INT() \
+	STMT( VAL(); \
+	      v_int = strtol(val, &endptr, 10); \
+	      if (*endptr || errno == ERANGE) \
+		die("invalid '%s' value: '%s'",	a_k, val); )
+
+#define VAL_UINT64() \
+	STMT( VAL(); \
+	      v_uint64 = strtoull(val, &endptr, 10); \
+	      if (*endptr || errno == ERANGE) \
+		die("invalid '%s' value: '%s'",	a_k, val); )
+
+#define VAL_DOUBLE() \
+	STMT( VAL(); \
+	      v_double = strtod(val, &endptr); \
+	      if (*endptr || errno == ERANGE) \
+		die("invalid '%s' value: '%s'",	a_k, val); )
+
+static int pretty;
+
+static inline int scripted(int argc, const char **argv)
+{
+	struct json_writer jw = JSON_WRITER_INIT;
+	int k;
+
+	if (!strcmp(argv[0], "@object"))
+		jw_object_begin(&jw, pretty);
+	else if (!strcmp(argv[0], "@array"))
+		jw_array_begin(&jw, pretty);
+	else
+		die("expected '@object' or '@array': '%s'", argv[0]);
+
+	for (k = 1; k < argc; k++) {
+		const char *a_k = argv[k];
+		const char *key;
+		const char *val;
+		char *endptr;
+		int precision;
+		int v_int;
+		uint64_t v_uint64;
+		double v_double;
+
+		if (!strcmp(a_k, "@end")) {
+			jw_end(&jw);
+			continue;
+		}
+
+		if (!strcmp(a_k, "@object-string")) {
+			KEY();
+			VAL();
+			jw_object_string(&jw, key, val);
+			continue;
+		}
+		if (!strcmp(a_k, "@object-int")) {
+			KEY();
+			VAL_INT();
+			jw_object_int(&jw, key, v_int);
+			continue;
+		}
+		if (!strcmp(a_k, "@object-uint64")) {
+			KEY();
+			VAL_UINT64();
+			jw_object_uint64(&jw, key, v_uint64);
+			continue;
+		}
+		if (!strcmp(a_k, "@object-double")) {
+			KEY();
+			PRECISION();
+			VAL_DOUBLE();
+			jw_object_double(&jw, key, precision, v_double);
+			continue;
+		}
+		if (!strcmp(a_k, "@object-true")) {
+			KEY();
+			jw_object_true(&jw, key);
+			continue;
+		}
+		if (!strcmp(a_k, "@object-false")) {
+			KEY();
+			jw_object_false(&jw, key);
+			continue;
+		}
+		if (!strcmp(a_k, "@object-null")) {
+			KEY();
+			jw_object_null(&jw, key);
+			continue;
+		}
+		if (!strcmp(a_k, "@object-object")) {
+			KEY();
+			jw_object_inline_begin_object(&jw, key);
+			continue;
+		}
+		if (!strcmp(a_k, "@object-array")) {
+			KEY();
+			jw_object_inline_begin_array(&jw, key);
+			continue;
+		}
+
+		if (!strcmp(a_k, "@array-string")) {
+			VAL();
+			jw_array_string(&jw, val);
+			continue;
+		}
+		if (!strcmp(a_k, "@array-int")) {
+			VAL_INT();
+			jw_array_int(&jw, v_int);
+			continue;
+		}
+		if (!strcmp(a_k, "@array-uint64")) {
+			VAL_UINT64();
+			jw_array_uint64(&jw, v_uint64);
+			continue;
+		}
+		if (!strcmp(a_k, "@array-double")) {
+			PRECISION();
+			VAL_DOUBLE();
+			jw_array_double(&jw, precision, v_double);
+			continue;
+		}
+		if (!strcmp(a_k, "@array-true")) {
+			jw_array_true(&jw);
+			continue;
+		}
+		if (!strcmp(a_k, "@array-false")) {
+			jw_array_false(&jw);
+			continue;
+		}
+		if (!strcmp(a_k, "@array-null")) {
+			jw_array_null(&jw);
+			continue;
+		}
+		if (!strcmp(a_k, "@array-object")) {
+			jw_array_inline_begin_object(&jw);
+			continue;
+		}
+		if (!strcmp(a_k, "@array-array")) {
+			jw_array_inline_begin_array(&jw);
+			continue;
+		}
+
+		die("unrecognized token: '%s'", a_k);
+	}
+
+	if (!jw_is_terminated(&jw))
+		die("json not terminated: '%s'", jw.json.buf);
+
+	printf("%s\n", jw.json.buf);
+
+	strbuf_release(&jw.json);
+	return 0;
+}
+
+static inline int my_usage(void)
+{
+	die("usage: '-u' | '[-p] @object ... @end' | '[-p] @array ... @end'");
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	if (argc <= 1)
+		return my_usage();
+
+	argc--;
+	argv++;
+
+	if (argv[0][0] == '-') {
+		if (!strcmp(argv[0], "-u") || !strcmp(argv[0], "--unit"))
+			return unit_tests();
+
+		if (!strcmp(argv[0], "-p") || !strcmp(argv[0], "--pretty")) {
+			pretty = 1;
+			argc--;
+			argv++;
+			if (argc < 1)
+				return my_usage();
+		}
+	}
+
+	return scripted(argc, argv);
+}
diff --git a/t/t0019-json-writer.sh b/t/t0019-json-writer.sh
new file mode 100755
index 0000000..a04c055
--- /dev/null
+++ b/t/t0019-json-writer.sh
@@ -0,0 +1,253 @@
+#!/bin/sh
+
+test_description='test json-writer JSON generation'
+. ./test-lib.sh
+
+test_expect_success 'unit test of json-writer routines' '
+	test-json-writer -u
+'
+
+test_expect_success 'trivial object' '
+	cat >expect <<-\EOF &&
+	{}
+	EOF
+	test-json-writer >actual \
+		@object \
+		@end &&
+	test_cmp expect actual
+'
+
+test_expect_success 'trivial array' '
+	cat >expect <<-\EOF &&
+	[]
+	EOF
+	test-json-writer >actual \
+		@array \
+		@end &&
+	test_cmp expect actual
+'
+
+test_expect_success 'simple object' '
+	cat >expect <<-\EOF &&
+	{"a":"abc","b":42,"c":3.14,"d":true,"e":false,"f":null}
+	EOF
+	test-json-writer >actual \
+		@object \
+			@object-string a abc \
+			@object-int b 42 \
+			@object-double c 2 3.140 \
+			@object-true d \
+			@object-false e \
+			@object-null f \
+		@end &&
+	test_cmp expect actual
+'
+
+test_expect_success 'simple array' '
+	cat >expect <<-\EOF &&
+	["abc",42,3.14,true,false,null]
+	EOF
+	test-json-writer >actual \
+		@array \
+			@array-string abc \
+			@array-int 42 \
+			@array-double 2 3.140 \
+			@array-true \
+			@array-false \
+			@array-null \
+		@end &&
+	test_cmp expect actual
+'
+
+test_expect_success 'escape quoting string' '
+	cat >expect <<-\EOF &&
+	{"a":"abc\\def"}
+	EOF
+	test-json-writer >actual \
+		@object \
+			@object-string a abc\\def \
+		@end &&
+	test_cmp expect actual
+'
+
+test_expect_success 'escape quoting string 2' '
+	cat >expect <<-\EOF &&
+	{"a":"abc\"def"}
+	EOF
+	test-json-writer >actual \
+		@object \
+			@object-string a abc\"def \
+		@end &&
+	test_cmp expect actual
+'
+
+test_expect_success 'nested inline object' '
+	cat >expect <<-\EOF &&
+	{"a":"abc","b":42,"sub1":{"c":3.14,"d":true,"sub2":{"e":false,"f":null}}}
+	EOF
+	test-json-writer >actual \
+		@object \
+			@object-string a abc \
+			@object-int b 42 \
+			@object-object "sub1" \
+				@object-double c 2 3.140 \
+				@object-true d \
+				@object-object "sub2" \
+					@object-false e \
+					@object-null f \
+				@end \
+			@end \
+		@end &&
+	test_cmp expect actual
+'
+
+test_expect_success 'nested inline array' '
+	cat >expect <<-\EOF &&
+	["abc",42,[3.14,true,[false,null]]]
+	EOF
+	test-json-writer >actual \
+		@array \
+			@array-string abc \
+			@array-int 42 \
+			@array-array \
+				@array-double 2 3.140 \
+				@array-true \
+				@array-array \
+					@array-false \
+					@array-null \
+				@end \
+			@end \
+		@end &&
+	test_cmp expect actual
+'
+
+test_expect_success 'nested inline object and array' '
+	cat >expect <<-\EOF &&
+	{"a":"abc","b":42,"sub1":{"c":3.14,"d":true,"sub2":[false,null]}}
+	EOF
+	test-json-writer >actual \
+		@object \
+			@object-string a abc \
+			@object-int b 42 \
+			@object-object "sub1" \
+				@object-double c 2 3.140 \
+				@object-true d \
+				@object-array "sub2" \
+					@array-false \
+					@array-null \
+				@end \
+			@end \
+		@end &&
+	test_cmp expect actual
+'
+
+test_expect_success 'nested inline object and array 2' '
+	cat >expect <<-\EOF &&
+	{"a":"abc","b":42,"sub1":{"c":3.14,"d":true,"sub2":[false,{"g":0,"h":1},null]}}
+	EOF
+	test-json-writer >actual \
+		@object \
+			@object-string a abc \
+			@object-int b 42 \
+			@object-object "sub1" \
+				@object-double c 2 3.140 \
+				@object-true d \
+				@object-array "sub2" \
+					@array-false \
+					@array-object \
+						@object-int g 0 \
+						@object-int h 1 \
+					@end \
+					@array-null \
+				@end \
+			@end \
+		@end &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pretty nested inline object and array 2' '
+	cat >expect <<EOF &&
+{
+  "a": "abc",
+  "b": 42,
+  "sub1": {
+    "c": 3.14,
+    "d": true,
+    "sub2": [
+      false,
+      {
+        "g": 0,
+        "h": 1
+      },
+      null
+    ]
+  }
+}
+EOF
+	test-json-writer >actual \
+		--pretty \
+		@object \
+			@object-string a abc \
+			@object-int b 42 \
+			@object-object "sub1" \
+				@object-double c 2 3.140 \
+				@object-true d \
+				@object-array "sub2" \
+					@array-false \
+					@array-object \
+						@object-int g 0 \
+						@object-int h 1 \
+					@end \
+					@array-null \
+				@end \
+			@end \
+		@end &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bogus: array element in object' '
+	test_must_fail test-json-writer >actual \
+		@object \
+			@array-string abc \
+		@end
+'
+
+test_expect_success 'bogus: object element in array' '
+	test_must_fail test-json-writer >actual \
+		@array \
+			@object-string a abc \
+		@end
+'
+
+test_expect_success 'bogus: unterminated child' '
+	test_must_fail test-json-writer >actual \
+		@object \
+			@object-object "sub1" \
+			@end
+'
+
+test_expect_success 'bogus: unterminted top level' '
+	test_must_fail test-json-writer >actual \
+		@object
+'
+
+test_expect_success 'bogus: first term' '
+	test_must_fail test-json-writer >actual \
+		@object-int a 0
+'
+
+test_expect_success 'bogus: missing val param' '
+	test_must_fail test-json-writer >actual \
+		@object \
+			@object-int a \
+		@end
+'
+
+test_expect_success 'bogus: extra token after val param' '
+	test_must_fail test-json-writer >actual \
+		@object \
+			@object-int a 0 1 \
+		@end
+'
+
+test_done
-- 
2.9.3

