Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1CF81F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbeGMRJv (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:09:51 -0400
Received: from siwi.pair.com ([209.68.5.199]:31626 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729765AbeGMRJv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:09:51 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id AD7103F410A;
        Fri, 13 Jul 2018 12:54:21 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 11A173F40F1;
        Fri, 13 Jul 2018 12:54:21 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v11] json_writer: new routines to create JSON data
Date:   Fri, 13 Jul 2018 16:54:08 +0000
Message-Id: <20180713165408.35860-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165408.35860-1-git@jeffhostetler.com>
References: <20180713165408.35860-1-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add "struct json_writer" and a series of jw_ routines to compose JSON
data into a string buffer.  The resulting string may then be printed by
commands wanting to support a JSON-like output format.

The json_writer is limited to correctly formatting structured data for
output.  It does not attempt to build an object model of the JSON data.

We say "JSON-like" because we do not enforce the Unicode (usually UTF-8)
requirement on string fields.  Internally, Git does not necessarily have
Unicode/UTF-8 data for most fields, so it is currently unclear the best
way to enforce that requirement.  For example, on Linux pathnames can
contain arbitrary 8-bit character data, so a command like "status" would
not know how to encode the reported pathnames.  We may want to revisit
this (or double encode such strings) in the future.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: René Scharfe <l.s.r@web.de>
Helped-by: Wink Saville <wink@saville.com>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                    |   2 +
 json-writer.c               | 414 ++++++++++++++++++++++++++++++++
 json-writer.h               | 105 ++++++++
 t/helper/test-json-writer.c | 565 ++++++++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c        |   1 +
 t/helper/test-tool.h        |   1 +
 t/t0019-json-writer.sh      | 331 ++++++++++++++++++++++++++
 t/t0019/parse_json.perl     |  52 ++++
 8 files changed, 1471 insertions(+)
 create mode 100644 json-writer.c
 create mode 100644 json-writer.h
 create mode 100644 t/helper/test-json-writer.c
 create mode 100755 t/t0019-json-writer.sh
 create mode 100644 t/t0019/parse_json.perl

diff --git a/Makefile b/Makefile
index e4b503d..39ca66b 100644
--- a/Makefile
+++ b/Makefile
@@ -709,6 +709,7 @@ TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-hashmap.o
 TEST_BUILTINS_OBJS += test-index-version.o
+TEST_BUILTINS_OBJS += test-json-writer.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-match-trees.o
 TEST_BUILTINS_OBJS += test-mergesort.o
@@ -871,6 +872,7 @@ LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
 LIB_OBJS += ident.o
+LIB_OBJS += json-writer.o
 LIB_OBJS += kwset.o
 LIB_OBJS += levenshtein.o
 LIB_OBJS += line-log.o
diff --git a/json-writer.c b/json-writer.c
new file mode 100644
index 0000000..aadb9db
--- /dev/null
+++ b/json-writer.c
@@ -0,0 +1,414 @@
+#include "cache.h"
+#include "json-writer.h"
+
+void jw_init(struct json_writer *jw)
+{
+	strbuf_init(&jw->json, 0);
+	strbuf_init(&jw->open_stack, 0);
+	jw->need_comma = 0;
+	jw->pretty = 0;
+}
+
+void jw_release(struct json_writer *jw)
+{
+	strbuf_release(&jw->json);
+	strbuf_release(&jw->open_stack);
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
+static void indent_pretty(struct json_writer *jw)
+{
+	int k;
+
+	for (k = 0; k < jw->open_stack.len; k++)
+		strbuf_addstr(&jw->json, "  ");
+}
+
+/*
+ * Begin an object or array (either top-level or nested within the currently
+ * open object or array).
+ */
+static void begin(struct json_writer *jw, char ch_open, int pretty)
+{
+	jw->pretty = pretty;
+
+	strbuf_addch(&jw->json, ch_open);
+
+	strbuf_addch(&jw->open_stack, ch_open);
+	jw->need_comma = 0;
+}
+
+/*
+ * Assert that the top of the open-stack is an object.
+ */
+static void assert_in_object(const struct json_writer *jw, const char *key)
+{
+	if (!jw->open_stack.len)
+		BUG("json-writer: object: missing jw_object_begin(): '%s'", key);
+	if (jw->open_stack.buf[jw->open_stack.len - 1] != '{')
+		BUG("json-writer: object: not in object: '%s'", key);
+}
+
+/*
+ * Assert that the top of the open-stack is an array.
+ */
+static void assert_in_array(const struct json_writer *jw)
+{
+	if (!jw->open_stack.len)
+		BUG("json-writer: array: missing jw_array_begin()");
+	if (jw->open_stack.buf[jw->open_stack.len - 1] != '[')
+		BUG("json-writer: array: not in array");
+}
+
+/*
+ * Add comma if we have already seen a member at this level.
+ */
+static void maybe_add_comma(struct json_writer *jw)
+{
+	if (jw->need_comma)
+		strbuf_addch(&jw->json, ',');
+	else
+		jw->need_comma = 1;
+}
+
+static void fmt_double(struct json_writer *jw, int precision,
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
+static void object_common(struct json_writer *jw, const char *key)
+{
+	assert_in_object(jw, key);
+	maybe_add_comma(jw);
+
+	if (jw->pretty) {
+		strbuf_addch(&jw->json, '\n');
+		indent_pretty(jw);
+	}
+
+	append_quoted_string(&jw->json, key);
+	strbuf_addch(&jw->json, ':');
+	if (jw->pretty)
+		strbuf_addch(&jw->json, ' ');
+}
+
+static void array_common(struct json_writer *jw)
+{
+	assert_in_array(jw);
+	maybe_add_comma(jw);
+
+	if (jw->pretty) {
+		strbuf_addch(&jw->json, '\n');
+		indent_pretty(jw);
+	}
+}
+
+/*
+ * Assert that the given JSON object or JSON array has been properly
+ * terminated.  (Has closing bracket.)
+ */
+static void assert_is_terminated(const struct json_writer *jw)
+{
+	if (jw->open_stack.len)
+		BUG("json-writer: object: missing jw_end(): '%s'",
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
+void jw_object_intmax(struct json_writer *jw, const char *key, intmax_t value)
+{
+	object_common(jw, key);
+	strbuf_addf(&jw->json, "%"PRIdMAX, value);
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
+void jw_object_bool(struct json_writer *jw, const char *key, int value)
+{
+	if (value)
+		jw_object_true(jw, key);
+	else
+		jw_object_false(jw, key);
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
+static void append_sub_jw(struct json_writer *jw,
+			  const struct json_writer *value)
+{
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
+	append_sub_jw(jw, value);
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
+void jw_array_intmax(struct json_writer *jw, intmax_t value)
+{
+	array_common(jw);
+	strbuf_addf(&jw->json, "%"PRIdMAX, value);
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
+void jw_array_bool(struct json_writer *jw, int value)
+{
+	if (value)
+		jw_array_true(jw);
+	else
+		jw_array_false(jw);
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
+	append_sub_jw(jw, value);
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
+		BUG("json-writer: too many jw_end(): '%s'", jw->json.buf);
+
+	len = jw->open_stack.len - 1;
+	ch_open = jw->open_stack.buf[len];
+
+	strbuf_setlen(&jw->open_stack, len);
+	jw->need_comma = 1;
+
+	if (jw->pretty) {
+		strbuf_addch(&jw->json, '\n');
+		indent_pretty(jw);
+	}
+
+	if (ch_open == '{')
+		strbuf_addch(&jw->json, '}');
+	else
+		strbuf_addch(&jw->json, ']');
+}
diff --git a/json-writer.h b/json-writer.h
new file mode 100644
index 0000000..fc18acc
--- /dev/null
+++ b/json-writer.h
@@ -0,0 +1,105 @@
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
+	/*
+	 * Buffer of the in-progress JSON currently being composed.
+	 */
+	struct strbuf json;
+
+	/*
+	 * Simple stack of the currently open array and object forms.
+	 * This is a string of '{' and '[' characters indicating the
+	 * currently unterminated forms.  This is used to ensure the
+	 * properly closing character is used when popping a level and
+	 * to know when the JSON is completely closed.
+	 */
+	struct strbuf open_stack;
+
+	unsigned int need_comma:1;
+	unsigned int pretty:1;
+};
+
+#define JSON_WRITER_INIT { STRBUF_INIT, STRBUF_INIT, 0, 0 }
+
+void jw_init(struct json_writer *jw);
+void jw_release(struct json_writer *jw);
+
+void jw_object_begin(struct json_writer *jw, int pretty);
+void jw_array_begin(struct json_writer *jw, int pretty);
+
+void jw_object_string(struct json_writer *jw, const char *key,
+		      const char *value);
+void jw_object_intmax(struct json_writer *jw, const char *key, intmax_t value);
+void jw_object_double(struct json_writer *jw, const char *key, int precision,
+		      double value);
+void jw_object_true(struct json_writer *jw, const char *key);
+void jw_object_false(struct json_writer *jw, const char *key);
+void jw_object_bool(struct json_writer *jw, const char *key, int value);
+void jw_object_null(struct json_writer *jw, const char *key);
+void jw_object_sub_jw(struct json_writer *jw, const char *key,
+		      const struct json_writer *value);
+
+void jw_object_inline_begin_object(struct json_writer *jw, const char *key);
+void jw_object_inline_begin_array(struct json_writer *jw, const char *key);
+
+void jw_array_string(struct json_writer *jw, const char *value);
+void jw_array_intmax(struct json_writer *jw, intmax_t value);
+void jw_array_double(struct json_writer *jw, int precision, double value);
+void jw_array_true(struct json_writer *jw);
+void jw_array_false(struct json_writer *jw);
+void jw_array_bool(struct json_writer *jw, int value);
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
index 0000000..37c4525
--- /dev/null
+++ b/t/helper/test-json-writer.c
@@ -0,0 +1,565 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "json-writer.h"
+
+static const char *expect_obj1 = "{\"a\":\"abc\",\"b\":42,\"c\":true}";
+static const char *expect_obj2 = "{\"a\":-1,\"b\":2147483647,\"c\":0}";
+static const char *expect_obj3 = "{\"a\":0,\"b\":4294967295,\"c\":9223372036854775807}";
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
+				  "  \"c\": 9223372036854775807\n"
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
+		jw_object_intmax(&obj1, "b", 42);
+		jw_object_true(&obj1, "c");
+	}
+	jw_end(&obj1);
+}
+
+static void make_obj2(int pretty)
+{
+	jw_object_begin(&obj2, pretty);
+	{
+		jw_object_intmax(&obj2, "a", -1);
+		jw_object_intmax(&obj2, "b", 0x7fffffff);
+		jw_object_intmax(&obj2, "c", 0);
+	}
+	jw_end(&obj2);
+}
+
+static void make_obj3(int pretty)
+{
+	jw_object_begin(&obj3, pretty);
+	{
+		jw_object_intmax(&obj3, "a", 0);
+		jw_object_intmax(&obj3, "b", 0xffffffff);
+		jw_object_intmax(&obj3, "c", 0x7fffffffffffffffULL);
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
+static const char *expect_arr3 = "[0,4294967295,9223372036854775807]";
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
+				  "  9223372036854775807\n"
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
+		jw_array_intmax(&arr1, 42);
+		jw_array_true(&arr1);
+	}
+	jw_end(&arr1);
+}
+
+static void make_arr2(int pretty)
+{
+	jw_array_begin(&arr2, pretty);
+	{
+		jw_array_intmax(&arr2, -1);
+		jw_array_intmax(&arr2, 0x7fffffff);
+		jw_array_intmax(&arr2, 0);
+	}
+	jw_end(&arr2);
+}
+
+static void make_arr3(int pretty)
+{
+	jw_array_begin(&arr3, pretty);
+	{
+		jw_array_intmax(&arr3, 0);
+		jw_array_intmax(&arr3, 0xffffffff);
+		jw_array_intmax(&arr3, 0x7fffffffffffffffULL);
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
+			jw_object_intmax(&inline1, "b", 42);
+			jw_object_true(&inline1, "c");
+		}
+		jw_end(&inline1);
+		jw_object_inline_begin_array(&inline1, "arr1");
+		{
+			jw_array_string(&inline1, "abc");
+			jw_array_intmax(&inline1, 42);
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
+			jw_array_intmax(&inline2, 1);
+			jw_array_intmax(&inline2, 2);
+		}
+		jw_end(&inline2);
+		jw_array_inline_begin_array(&inline2);
+		{
+			jw_array_intmax(&inline2, 3);
+			jw_array_intmax(&inline2, 4);
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
+static void get_s(int line_nr, char **s_in)
+{
+	*s_in = strtok(NULL, " ");
+	if (!*s_in)
+		die("line[%d]: expected: <s>", line_nr);
+}
+
+static void get_i(int line_nr, intmax_t *s_in)
+{
+	char *s;
+	char *endptr;
+
+	get_s(line_nr, &s);
+
+	*s_in = strtol(s, &endptr, 10);
+	if (*endptr || errno == ERANGE)
+		die("line[%d]: invalid integer value", line_nr);
+}
+
+static void get_d(int line_nr, double *s_in)
+{
+	char *s;
+	char *endptr;
+
+	get_s(line_nr, &s);
+
+	*s_in = strtod(s, &endptr);
+	if (*endptr || errno == ERANGE)
+		die("line[%d]: invalid float value", line_nr);
+}
+
+static int pretty;
+
+#define MAX_LINE_LENGTH (64 * 1024)
+
+static char *get_trimmed_line(char *buf, int buf_size)
+{
+	int len;
+
+	if (!fgets(buf, buf_size, stdin))
+		return NULL;
+
+	len = strlen(buf);
+	while (len > 0) {
+		char c = buf[len - 1];
+		if (c == '\n' || c == '\r' || c == ' ' || c == '\t')
+			buf[--len] = 0;
+		else
+			break;
+	}
+
+	while (*buf == ' ' || *buf == '\t')
+		buf++;
+
+	return buf;
+}
+
+static int scripted(void)
+{
+	struct json_writer jw = JSON_WRITER_INIT;
+	char buf[MAX_LINE_LENGTH];
+	char *line;
+	int line_nr = 0;
+
+	line = get_trimmed_line(buf, MAX_LINE_LENGTH);
+	if (!line)
+		return 0;
+
+	if (!strcmp(line, "object"))
+		jw_object_begin(&jw, pretty);
+	else if (!strcmp(line, "array"))
+		jw_array_begin(&jw, pretty);
+	else
+		die("expected first line to be 'object' or 'array'");
+
+	while ((line = get_trimmed_line(buf, MAX_LINE_LENGTH)) != NULL) {
+		char *verb;
+		char *key;
+		char *s_value;
+		intmax_t i_value;
+		double d_value;
+
+		line_nr++;
+
+		verb = strtok(line, " ");
+
+		if (!strcmp(verb, "end")) {
+			jw_end(&jw);
+		}
+		else if (!strcmp(verb, "object-string")) {
+			get_s(line_nr, &key);
+			get_s(line_nr, &s_value);
+			jw_object_string(&jw, key, s_value);
+		}
+		else if (!strcmp(verb, "object-int")) {
+			get_s(line_nr, &key);
+			get_i(line_nr, &i_value);
+			jw_object_intmax(&jw, key, i_value);
+		}
+		else if (!strcmp(verb, "object-double")) {
+			get_s(line_nr, &key);
+			get_i(line_nr, &i_value);
+			get_d(line_nr, &d_value);
+			jw_object_double(&jw, key, i_value, d_value);
+		}
+		else if (!strcmp(verb, "object-true")) {
+			get_s(line_nr, &key);
+			jw_object_true(&jw, key);
+		}
+		else if (!strcmp(verb, "object-false")) {
+			get_s(line_nr, &key);
+			jw_object_false(&jw, key);
+		}
+		else if (!strcmp(verb, "object-null")) {
+			get_s(line_nr, &key);
+			jw_object_null(&jw, key);
+		}
+		else if (!strcmp(verb, "object-object")) {
+			get_s(line_nr, &key);
+			jw_object_inline_begin_object(&jw, key);
+		}
+		else if (!strcmp(verb, "object-array")) {
+			get_s(line_nr, &key);
+			jw_object_inline_begin_array(&jw, key);
+		}
+		else if (!strcmp(verb, "array-string")) {
+			get_s(line_nr, &s_value);
+			jw_array_string(&jw, s_value);
+		}
+		else if (!strcmp(verb, "array-int")) {
+			get_i(line_nr, &i_value);
+			jw_array_intmax(&jw, i_value);
+		}
+		else if (!strcmp(verb, "array-double")) {
+			get_i(line_nr, &i_value);
+			get_d(line_nr, &d_value);
+			jw_array_double(&jw, i_value, d_value);
+		}
+		else if (!strcmp(verb, "array-true"))
+			jw_array_true(&jw);
+		else if (!strcmp(verb, "array-false"))
+			jw_array_false(&jw);
+		else if (!strcmp(verb, "array-null"))
+			jw_array_null(&jw);
+		else if (!strcmp(verb, "array-object"))
+			jw_array_inline_begin_object(&jw);
+		else if (!strcmp(verb, "array-array"))
+			jw_array_inline_begin_array(&jw);
+		else
+			die("unrecognized token: '%s'", verb);
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
+int cmd__json_writer(int argc, const char **argv)
+{
+	argc--; /* skip over "json-writer" arg */
+	argv++;
+
+	if (argc > 0 && argv[0][0] == '-') {
+		if (!strcmp(argv[0], "-u") || !strcmp(argv[0], "--unit"))
+			return unit_tests();
+
+		if (!strcmp(argv[0], "-p") || !strcmp(argv[0], "--pretty"))
+			pretty = 1;
+	}
+
+	return scripted();
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 805a45d..707499e 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -19,6 +19,7 @@ static struct test_cmd cmds[] = {
 	{ "genrandom", cmd__genrandom },
 	{ "hashmap", cmd__hashmap },
 	{ "index-version", cmd__index_version },
+	{ "json-writer", cmd__json_writer },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
 	{ "match-trees", cmd__match_trees },
 	{ "mergesort", cmd__mergesort },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 7116ddf..a058c31 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -13,6 +13,7 @@ int cmd__example_decorate(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__hashmap(int argc, const char **argv);
 int cmd__index_version(int argc, const char **argv);
+int cmd__json_writer(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__match_trees(int argc, const char **argv);
 int cmd__mergesort(int argc, const char **argv);
diff --git a/t/t0019-json-writer.sh b/t/t0019-json-writer.sh
new file mode 100755
index 0000000..3b0c336
--- /dev/null
+++ b/t/t0019-json-writer.sh
@@ -0,0 +1,331 @@
+#!/bin/sh
+
+test_description='test json-writer JSON generation'
+. ./test-lib.sh
+
+test_expect_success 'unit test of json-writer routines' '
+	test-tool json-writer -u
+'
+
+test_expect_success 'trivial object' '
+	cat >expect <<-\EOF &&
+	{}
+	EOF
+	cat >input <<-\EOF &&
+	object
+	end
+	EOF
+	test-tool json-writer <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'trivial array' '
+	cat >expect <<-\EOF &&
+	[]
+	EOF
+	cat >input <<-\EOF &&
+	array
+	end
+	EOF
+	test-tool json-writer <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'simple object' '
+	cat >expect <<-\EOF &&
+	{"a":"abc","b":42,"c":3.14,"d":true,"e":false,"f":null}
+	EOF
+	cat >input <<-\EOF &&
+	object
+		object-string a abc
+		object-int b 42
+		object-double c 2 3.140
+		object-true d
+		object-false e
+		object-null f
+	end
+	EOF
+	test-tool json-writer <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'simple array' '
+	cat >expect <<-\EOF &&
+	["abc",42,3.14,true,false,null]
+	EOF
+	cat >input <<-\EOF &&
+	array
+		array-string abc
+		array-int 42
+		array-double 2 3.140
+		array-true
+		array-false
+		array-null
+	end
+	EOF
+	test-tool json-writer <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'escape quoting string' '
+	cat >expect <<-\EOF &&
+	{"a":"abc\\def"}
+	EOF
+	cat >input <<-\EOF &&
+	object
+		object-string a abc\def
+	end
+	EOF
+	test-tool json-writer <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'escape quoting string 2' '
+	cat >expect <<-\EOF &&
+	{"a":"abc\"def"}
+	EOF
+	cat >input <<-\EOF &&
+	object
+		object-string a abc"def
+	end
+	EOF
+	test-tool json-writer <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'nested inline object' '
+	cat >expect <<-\EOF &&
+	{"a":"abc","b":42,"sub1":{"c":3.14,"d":true,"sub2":{"e":false,"f":null}}}
+	EOF
+	cat >input <<-\EOF &&
+	object
+		object-string a abc
+		object-int b 42
+		object-object sub1
+			object-double c 2 3.140
+			object-true d
+			object-object sub2
+				object-false e
+				object-null f
+			end
+		end
+	end
+	EOF
+	test-tool json-writer <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'nested inline array' '
+	cat >expect <<-\EOF &&
+	["abc",42,[3.14,true,[false,null]]]
+	EOF
+	cat >input <<-\EOF &&
+	array
+		array-string abc
+		array-int 42
+		array-array
+			array-double 2 3.140
+			array-true
+			array-array
+				array-false
+				array-null
+			end
+		end
+	end
+	EOF
+	test-tool json-writer <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'nested inline object and array' '
+	cat >expect <<-\EOF &&
+	{"a":"abc","b":42,"sub1":{"c":3.14,"d":true,"sub2":[false,null]}}
+	EOF
+	cat >input <<-\EOF &&
+	object
+		object-string a abc
+		object-int b 42
+		object-object sub1
+			object-double c 2 3.140
+			object-true d
+			object-array sub2
+				array-false
+				array-null
+			end
+		end
+	end
+	EOF
+	test-tool json-writer <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'nested inline object and array 2' '
+	cat >expect <<-\EOF &&
+	{"a":"abc","b":42,"sub1":{"c":3.14,"d":true,"sub2":[false,{"g":0,"h":1},null]}}
+	EOF
+	cat >input <<-\EOF &&
+	object
+		object-string a abc
+		object-int b 42
+		object-object sub1
+			object-double c 2 3.140
+			object-true d
+			object-array sub2
+				array-false
+				array-object
+					object-int g 0
+					object-int h 1
+				end
+				array-null
+			end
+		end
+	end
+	EOF
+	test-tool json-writer <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pretty nested inline object and array 2' '
+	sed -e "s/^|//" >expect <<-\EOF &&
+	|{
+	|  "a": "abc",
+	|  "b": 42,
+	|  "sub1": {
+	|    "c": 3.14,
+	|    "d": true,
+	|    "sub2": [
+	|      false,
+	|      {
+	|        "g": 0,
+	|        "h": 1
+	|      },
+	|      null
+	|    ]
+	|  }
+	|}
+	EOF
+	cat >input <<-\EOF &&
+	object
+		object-string a abc
+		object-int b 42
+		object-object sub1
+			object-double c 2 3.140
+			object-true d
+			object-array sub2
+				array-false
+				array-object
+					object-int g 0
+					object-int h 1
+				end
+				array-null
+			end
+		end
+	end
+	EOF
+	test-tool json-writer -p <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'inline object with no members' '
+	cat >expect <<-\EOF &&
+	{"a":"abc","empty":{},"b":42}
+	EOF
+	cat >input <<-\EOF &&
+	object
+		object-string a abc
+		object-object empty
+		end
+		object-int b 42
+	end
+	EOF
+	test-tool json-writer <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'inline array with no members' '
+	cat >expect <<-\EOF &&
+	{"a":"abc","empty":[],"b":42}
+	EOF
+	cat >input <<-\EOF &&
+	object
+		object-string a abc
+		object-array empty
+		end
+		object-int b 42
+	end
+	EOF
+	test-tool json-writer <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'larger empty example' '
+	cat >expect <<-\EOF &&
+	{"a":"abc","empty":[{},{},{},[],{}],"b":42}
+	EOF
+	cat >input <<-\EOF &&
+	object
+		object-string a abc
+		object-array empty
+			array-object
+			end
+			array-object
+			end
+			array-object
+			end
+			array-array
+			end
+			array-object
+			end
+		end
+		object-int b 42
+	end
+	EOF
+	test-tool json-writer <input >actual &&
+	test_cmp expect actual
+'
+
+test_lazy_prereq PERLJSON '
+	perl -MJSON -e "exit 0"
+'
+
+# As a sanity check, ask Perl to parse our generated JSON and recursively
+# dump the resulting data in sorted order.  Confirm that that matches our
+# expectations.
+test_expect_success PERLJSON 'parse JSON using Perl' '
+	cat >expect <<-\EOF &&
+	row[0].a abc
+	row[0].b 42
+	row[0].sub1 hash
+	row[0].sub1.c 3.14
+	row[0].sub1.d 1
+	row[0].sub1.sub2 array
+	row[0].sub1.sub2[0] 0
+	row[0].sub1.sub2[1] hash
+	row[0].sub1.sub2[1].g 0
+	row[0].sub1.sub2[1].h 1
+	row[0].sub1.sub2[2] null
+	EOF
+	cat >input <<-\EOF &&
+	object
+		object-string a abc
+		object-int b 42
+		object-object sub1
+			object-double c 2 3.140
+			object-true d
+			object-array sub2
+				array-false
+				array-object
+					object-int g 0
+					object-int h 1
+				end
+				array-null
+			end
+		end
+	end
+	EOF
+	test-tool json-writer <input >output.json &&
+	perl "$TEST_DIRECTORY"/t0019/parse_json.perl <output.json >actual &&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/t/t0019/parse_json.perl b/t/t0019/parse_json.perl
new file mode 100644
index 0000000..ca4e5bf
--- /dev/null
+++ b/t/t0019/parse_json.perl
@@ -0,0 +1,52 @@
+#!/usr/bin/perl
+use strict;
+use warnings;
+use JSON;
+
+sub dump_array {
+    my ($label_in, $ary_ref) = @_;
+    my @ary = @$ary_ref;
+
+    for ( my $i = 0; $i <= $#{ $ary_ref }; $i++ )
+    {
+	my $label = "$label_in\[$i\]";
+	dump_item($label, $ary[$i]);
+    }
+}
+
+sub dump_hash {
+    my ($label_in, $obj_ref) = @_;
+    my %obj = %$obj_ref;
+
+    foreach my $k (sort keys %obj) {
+	my $label = (length($label_in) > 0) ? "$label_in.$k" : "$k";
+	my $value = $obj{$k};
+
+	dump_item($label, $value);
+    }
+}
+
+sub dump_item {
+    my ($label_in, $value) = @_;
+    if (ref($value) eq 'ARRAY') {
+	print "$label_in array\n";
+	dump_array($label_in, $value);
+    } elsif (ref($value) eq 'HASH') {
+	print "$label_in hash\n";
+	dump_hash($label_in, $value);
+    } elsif (defined $value) {
+	print "$label_in $value\n";
+    } else {
+	print "$label_in null\n";
+    }
+}
+
+my $row = 0;
+while (<>) {
+    my $data = decode_json( $_ );
+    my $label = "row[$row]";
+
+    dump_hash($label, $data);
+    $row++;
+}
+
-- 
2.9.3

