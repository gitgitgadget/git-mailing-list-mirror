Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DF871F404
	for <e@80x24.org>; Wed, 21 Mar 2018 19:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753076AbeCUT2t (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 15:28:49 -0400
Received: from siwi.pair.com ([209.68.5.199]:56643 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753253AbeCUT2i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 15:28:38 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1D7823F4021;
        Wed, 21 Mar 2018 15:28:38 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 743E23F401B;
        Wed, 21 Mar 2018 15:28:37 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2] json_writer: new routines to create data in JSON format
Date:   Wed, 21 Mar 2018 19:28:27 +0000
Message-Id: <20180321192827.44330-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180321192827.44330-1-git@jeffhostetler.com>
References: <20180321192827.44330-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add basic routines to generate data in JSON format.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                    |   2 +
 json-writer.c               | 321 +++++++++++++++++++++++++++++++++
 json-writer.h               |  86 +++++++++
 t/helper/test-json-writer.c | 420 ++++++++++++++++++++++++++++++++++++++++++++
 t/t0019-json-writer.sh      | 102 +++++++++++
 5 files changed, 931 insertions(+)
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
index 0000000..89a6abb
--- /dev/null
+++ b/json-writer.c
@@ -0,0 +1,321 @@
+#include "cache.h"
+#include "json-writer.h"
+
+static char g_ch_open[2]  = { '{', '[' };
+static char g_ch_close[2] = { '}', ']' };
+
+/*
+ * Append JSON-quoted version of the given string to 'out'.
+ */
+static void append_quoted_string(struct strbuf *out, const char *in)
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
+
+static inline void begin(struct json_writer *jw, int is_array)
+{
+	ALLOC_GROW(jw->levels, jw->nr + 1, jw->alloc);
+
+	jw->levels[jw->nr].level_is_array = !!is_array;
+	jw->levels[jw->nr].level_is_empty = 1;
+
+	strbuf_addch(&jw->json, g_ch_open[!!is_array]);
+
+	jw->nr++;
+}
+
+/*
+ * Assert that we have an open object at this level.
+ */
+static void inline assert_in_object(const struct json_writer *jw, const char *key)
+{
+	if (!jw->nr)
+		BUG("object: missing jw_object_begin(): '%s'", key);
+	if (jw->levels[jw->nr - 1].level_is_array)
+		BUG("object: not in object: '%s'", key);
+}
+
+/*
+ * Assert that we have an open array at this level.
+ */
+static void inline assert_in_array(const struct json_writer *jw)
+{
+	if (!jw->nr)
+		BUG("array: missing jw_begin()");
+	if (!jw->levels[jw->nr - 1].level_is_array)
+		BUG("array: not in array");
+}
+
+/*
+ * Add comma if we have already seen a member at this level.
+ */
+static void inline maybe_add_comma(struct json_writer *jw)
+{
+	if (jw->levels[jw->nr - 1].level_is_empty)
+		jw->levels[jw->nr - 1].level_is_empty = 0;
+	else
+		strbuf_addch(&jw->json, ',');
+}
+
+/*
+ * Assert that the given JSON object or JSON array has been properly
+ * terminated.  (Has closing bracket.)
+ */
+static void inline assert_is_terminated(const struct json_writer *jw)
+{
+	if (jw->nr)
+		BUG("object: missing jw_end(): '%s'", jw->json.buf);
+}
+
+void jw_object_begin(struct json_writer *jw)
+{
+	begin(jw, 0);
+}
+
+void jw_object_string(struct json_writer *jw, const char *key, const char *value)
+{
+	assert_in_object(jw, key);
+	maybe_add_comma(jw);
+
+	append_quoted_string(&jw->json, key);
+	strbuf_addch(&jw->json, ':');
+	append_quoted_string(&jw->json, value);
+}
+
+void jw_object_int(struct json_writer *jw, const char *key, int value)
+{
+	assert_in_object(jw, key);
+	maybe_add_comma(jw);
+
+	append_quoted_string(&jw->json, key);
+	strbuf_addf(&jw->json, ":%d", value);
+}
+
+void jw_object_uint64(struct json_writer *jw, const char *key, uint64_t value)
+{
+	assert_in_object(jw, key);
+	maybe_add_comma(jw);
+
+	append_quoted_string(&jw->json, key);
+	strbuf_addf(&jw->json, ":%"PRIuMAX, value);
+}
+
+void jw_object_double(struct json_writer *jw, const char *fmt,
+		      const char *key, double value)
+{
+	assert_in_object(jw, key);
+	maybe_add_comma(jw);
+
+	if (!fmt || !*fmt)
+		fmt = "%f";
+
+	append_quoted_string(&jw->json, key);
+	strbuf_addch(&jw->json, ':');
+	strbuf_addf(&jw->json, fmt, value);
+}
+
+void jw_object_true(struct json_writer *jw, const char *key)
+{
+	assert_in_object(jw, key);
+	maybe_add_comma(jw);
+
+	append_quoted_string(&jw->json, key);
+	strbuf_addstr(&jw->json, ":true");
+}
+
+void jw_object_false(struct json_writer *jw, const char *key)
+{
+	assert_in_object(jw, key);
+	maybe_add_comma(jw);
+
+	append_quoted_string(&jw->json, key);
+	strbuf_addstr(&jw->json, ":false");
+}
+
+void jw_object_null(struct json_writer *jw, const char *key)
+{
+	assert_in_object(jw, key);
+	maybe_add_comma(jw);
+
+	append_quoted_string(&jw->json, key);
+	strbuf_addstr(&jw->json, ":null");
+}
+
+void jw_object_sub(struct json_writer *jw, const char *key,
+		   const struct json_writer *value)
+{
+	assert_is_terminated(value);
+
+	assert_in_object(jw, key);
+	maybe_add_comma(jw);
+
+	append_quoted_string(&jw->json, key);
+	strbuf_addch(&jw->json, ':');
+	strbuf_addstr(&jw->json, value->json.buf);
+}
+
+void jw_object_inline_begin_object(struct json_writer *jw, const char *key)
+{
+	assert_in_object(jw, key);
+	maybe_add_comma(jw);
+
+	append_quoted_string(&jw->json, key);
+	strbuf_addch(&jw->json, ':');
+
+	jw_object_begin(jw);
+}
+
+void jw_object_inline_begin_array(struct json_writer *jw, const char *key)
+{
+	assert_in_object(jw, key);
+	maybe_add_comma(jw);
+
+	append_quoted_string(&jw->json, key);
+	strbuf_addch(&jw->json, ':');
+
+	jw_array_begin(jw);
+}
+
+void jw_array_begin(struct json_writer *jw)
+{
+	begin(jw, 1);
+}
+
+void jw_array_string(struct json_writer *jw, const char *value)
+{
+	assert_in_array(jw);
+	maybe_add_comma(jw);
+
+	append_quoted_string(&jw->json, value);
+}
+
+void jw_array_int(struct json_writer *jw,int value)
+{
+	assert_in_array(jw);
+	maybe_add_comma(jw);
+
+	strbuf_addf(&jw->json, "%d", value);
+}
+
+void jw_array_uint64(struct json_writer *jw, uint64_t value)
+{
+	assert_in_array(jw);
+	maybe_add_comma(jw);
+
+	strbuf_addf(&jw->json, "%"PRIuMAX, value);
+}
+
+void jw_array_double(struct json_writer *jw, const char *fmt, double value)
+{
+	assert_in_array(jw);
+	maybe_add_comma(jw);
+
+	if (!fmt || !*fmt)
+		fmt = "%f";
+
+	strbuf_addf(&jw->json, fmt, value);
+}
+
+void jw_array_true(struct json_writer *jw)
+{
+	assert_in_array(jw);
+	maybe_add_comma(jw);
+
+	strbuf_addstr(&jw->json, "true");
+}
+
+void jw_array_false(struct json_writer *jw)
+{
+	assert_in_array(jw);
+	maybe_add_comma(jw);
+
+	strbuf_addstr(&jw->json, "false");
+}
+
+void jw_array_null(struct json_writer *jw)
+{
+	assert_in_array(jw);
+	maybe_add_comma(jw);
+
+	strbuf_addstr(&jw->json, "null");
+}
+
+void jw_array_sub(struct json_writer *jw, const struct json_writer *value)
+{
+	assert_is_terminated(value);
+
+	assert_in_array(jw);
+	maybe_add_comma(jw);
+
+	strbuf_addstr(&jw->json, value->json.buf);
+}
+
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
+	assert_in_array(jw);
+	maybe_add_comma(jw);
+
+	jw_object_begin(jw);
+}
+
+void jw_array_inline_begin_array(struct json_writer *jw)
+{
+	assert_in_array(jw);
+	maybe_add_comma(jw);
+
+	jw_array_begin(jw);
+}
+
+int jw_is_terminated(const struct json_writer *jw)
+{
+	return !jw->nr;
+}
+
+void jw_end(struct json_writer *jw)
+{
+	if (!jw->nr)
+		BUG("too many jw_end(): '%s'", jw->json.buf);
+
+	jw->nr--;
+
+	strbuf_addch(&jw->json,
+		     g_ch_close[jw->levels[jw->nr].level_is_array]);
+}
diff --git a/json-writer.h b/json-writer.h
new file mode 100644
index 0000000..ad38c95
--- /dev/null
+++ b/json-writer.h
@@ -0,0 +1,86 @@
+#ifndef JSON_WRITER_H
+#define JSON_WRITER_H
+
+/*
+ * JSON data structures are defined at:
+ *      http://json.org/
+ *      http://www.ietf.org/rfc/rfc7159.txt
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
+ */
+
+struct json_writer_level
+{
+	unsigned level_is_array : 1;
+	unsigned level_is_empty : 1;
+};
+
+struct json_writer
+{
+	struct json_writer_level *levels;
+	int nr, alloc;
+	struct strbuf json;
+};
+
+#define JSON_WRITER_INIT { NULL, 0, 0, STRBUF_INIT }
+
+void jw_object_begin(struct json_writer *jw);
+void jw_array_begin(struct json_writer *jw);
+
+void jw_object_string(struct json_writer *jw, const char *key,
+		      const char *value);
+void jw_object_int(struct json_writer *jw, const char *key, int value);
+void jw_object_uint64(struct json_writer *jw, const char *key, uint64_t value);
+void jw_object_double(struct json_writer *jw, const char *fmt,
+		      const char *key, double value);
+void jw_object_true(struct json_writer *jw, const char *key);
+void jw_object_false(struct json_writer *jw, const char *key);
+void jw_object_null(struct json_writer *jw, const char *key);
+void jw_object_sub(struct json_writer *jw, const char *key,
+		   const struct json_writer *value);
+
+void jw_object_inline_begin_object(struct json_writer *jw, const char *key);
+void jw_object_inline_begin_array(struct json_writer *jw, const char *key);
+
+
+
+void jw_array_string(struct json_writer *jw, const char *value);
+void jw_array_int(struct json_writer *jw,int value);
+void jw_array_uint64(struct json_writer *jw, uint64_t value);
+void jw_array_double(struct json_writer *jw, const char *fmt, double value);
+void jw_array_true(struct json_writer *jw);
+void jw_array_false(struct json_writer *jw);
+void jw_array_null(struct json_writer *jw);
+void jw_array_sub(struct json_writer *jw, const struct json_writer *value);
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
index 0000000..4bf815c
--- /dev/null
+++ b/t/helper/test-json-writer.c
@@ -0,0 +1,420 @@
+#include "cache.h"
+#include "json-writer.h"
+
+const char *expect_obj1 = "{\"a\":\"abc\",\"b\":42,\"c\":true}";
+const char *expect_obj2 = "{\"a\":-1,\"b\":2147483647,\"c\":0}";
+const char *expect_obj3 = "{\"a\":0,\"b\":4294967295,\"c\":18446744073709551615}";
+const char *expect_obj4 = "{\"t\":true,\"f\":false,\"n\":null}";
+const char *expect_obj5 = "{\"abc\\tdef\":\"abc\\\\def\"}";
+
+struct json_writer obj1 = JSON_WRITER_INIT;
+struct json_writer obj2 = JSON_WRITER_INIT;
+struct json_writer obj3 = JSON_WRITER_INIT;
+struct json_writer obj4 = JSON_WRITER_INIT;
+struct json_writer obj5 = JSON_WRITER_INIT;
+
+
+void make_obj1(void)
+{
+	jw_object_begin(&obj1);
+	{
+		jw_object_string(&obj1, "a", "abc");
+		jw_object_int(&obj1, "b", 42);
+		jw_object_true(&obj1, "c");
+	}
+	jw_end(&obj1);
+}
+
+void make_obj2(void)
+{
+	jw_object_begin(&obj2);
+	{
+		jw_object_int(&obj2, "a", -1);
+		jw_object_int(&obj2, "b", 0x7fffffff);
+		jw_object_int(&obj2, "c", 0);
+	}
+	jw_end(&obj2);
+}
+
+void make_obj3(void)
+{
+	jw_object_begin(&obj3);
+	{
+		jw_object_uint64(&obj3, "a", 0);
+		jw_object_uint64(&obj3, "b", 0xffffffff);
+		jw_object_uint64(&obj3, "c", 0xffffffffffffffff);
+	}
+	jw_end(&obj3);
+}
+
+void make_obj4(void)
+{
+	jw_object_begin(&obj4);
+	{
+		jw_object_true(&obj4, "t");
+		jw_object_false(&obj4, "f");
+		jw_object_null(&obj4, "n");
+	}
+	jw_end(&obj4);
+}
+
+void make_obj5(void)
+{
+	jw_object_begin(&obj5);
+	{
+		jw_object_string(&obj5, "abc" "\x09" "def", "abc" "\\" "def");
+	}
+	jw_end(&obj5);
+}
+
+const char *expect_arr1 = "[\"abc\",42,true]";
+const char *expect_arr2 = "[-1,2147483647,0]";
+const char *expect_arr3 = "[0,4294967295,18446744073709551615]";
+const char *expect_arr4 = "[true,false,null]";
+
+struct json_writer arr1 = JSON_WRITER_INIT;
+struct json_writer arr2 = JSON_WRITER_INIT;
+struct json_writer arr3 = JSON_WRITER_INIT;
+struct json_writer arr4 = JSON_WRITER_INIT;
+
+void make_arr1(void)
+{
+	jw_array_begin(&arr1);
+	{
+		jw_array_string(&arr1, "abc");
+		jw_array_int(&arr1, 42);
+		jw_array_true(&arr1);
+	}
+	jw_end(&arr1);
+}
+
+void make_arr2(void)
+{
+	jw_array_begin(&arr2);
+	{
+		jw_array_int(&arr2, -1);
+		jw_array_int(&arr2, 0x7fffffff);
+		jw_array_int(&arr2, 0);
+	}
+	jw_end(&arr2);
+}
+
+void make_arr3(void)
+{
+	jw_array_begin(&arr3);
+	{
+		jw_array_uint64(&arr3, 0);
+		jw_array_uint64(&arr3, 0xffffffff);
+		jw_array_uint64(&arr3, 0xffffffffffffffff);
+	}
+	jw_end(&arr3);
+}
+
+void make_arr4(void)
+{
+	jw_array_begin(&arr4);
+	{
+		jw_array_true(&arr4);
+		jw_array_false(&arr4);
+		jw_array_null(&arr4);
+	}
+	jw_end(&arr4);
+}
+
+char *expect_nest1 =
+	"{\"obj1\":{\"a\":\"abc\",\"b\":42,\"c\":true},\"arr1\":[\"abc\",42,true]}";
+
+struct json_writer nest1 = JSON_WRITER_INIT;
+
+void make_nest1(void)
+{
+	jw_object_begin(&nest1);
+	{
+		jw_object_sub(&nest1, "obj1", &obj1);
+		jw_object_sub(&nest1, "arr1", &arr1);
+	}
+	jw_end(&nest1);
+}
+
+char *expect_inline1 =
+	"{\"obj1\":{\"a\":\"abc\",\"b\":42,\"c\":true},\"arr1\":[\"abc\",42,true]}";
+struct json_writer inline1 = JSON_WRITER_INIT;
+
+
+void make_inline1(void)
+{
+	jw_object_begin(&inline1);
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
+char *expect_inline2 =
+	"[[1,2],[3,4],{\"a\":\"abc\"}]";
+struct json_writer inline2 = JSON_WRITER_INIT;
+
+void make_inline2(void)
+{
+	jw_array_begin(&inline2);
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
+
+void cmp(const char *test, const struct json_writer *jw, const char *exp)
+{
+	if (!strcmp(jw->json.buf, exp))
+		return;
+
+	printf("error[%s]: observed '%s' expected '%s'\n",
+	       test, jw->json.buf, exp);
+	exit(1);
+}
+
+#define t(v) do { make_##v(); cmp(#v, &v, expect_##v); } while (0)
+
+/*
+ * Run some basic regression tests with some known patterns.
+ * These tests also demonstrate how to use the jw_ API.
+ */
+int unit_tests(void)
+{
+	t(obj1);
+	t(obj2);
+	t(obj3);
+	t(obj4);
+	t(obj5);
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
+#define FMT() \
+	STMT( fmt = argv[++k]; \
+	      PARAM(a_k, "fmt", fmt); )
+
+#define KEY() \
+	STMT( key = argv[++k]; \
+	      PARAM(a_k, "key", key); )
+
+#define VAL() \
+	STMT( val = argv[++k]; \
+	      PARAM(a_k, "val", val); )
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
+static inline int scripted(int argc, const char **argv)
+{
+	struct json_writer jw = JSON_WRITER_INIT;
+	int k;
+
+	if (!strcmp(argv[0], "@object"))
+		jw_object_begin(&jw);
+	else if (!strcmp(argv[0], "@array"))
+		jw_array_begin(&jw);
+	else
+		die("first script term must be '@object' or '@array': '%s'", argv[0]);
+
+	for (k = 1; k < argc; k++) {
+		const char *a_k = argv[k];
+		const char *key;
+		const char *val;
+		const char *fmt;
+		char *endptr;
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
+			FMT();
+			KEY();
+			VAL_DOUBLE();
+			jw_object_double(&jw, fmt, key, v_double);
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
+			FMT();
+			VAL_DOUBLE();
+			jw_array_double(&jw, fmt, v_double);
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
+	die("usage: '-u' | '@object ... @end' | '@array ... @end'");
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	if (argc == 1)
+		return my_usage();
+
+	if (argv[1][0] == '-') {
+		if (!strcmp(argv[1], "-u"))
+			return unit_tests();
+
+		return my_usage();
+	}
+
+	return scripted(argc - 1, argv + 1);
+}
diff --git a/t/t0019-json-writer.sh b/t/t0019-json-writer.sh
new file mode 100755
index 0000000..a1a8f2a
--- /dev/null
+++ b/t/t0019-json-writer.sh
@@ -0,0 +1,102 @@
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
+			@object-double %.2f c 3.140 \
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
+			@array-double %.2f 3.140 \
+			@array-true \
+			@array-false \
+			@array-null \
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
+				@object-double %.2f c 3.140 \
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
+				@array-double %.2f 3.140 \
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
+test_done
-- 
2.9.3

