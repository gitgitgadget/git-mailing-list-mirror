From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [RFC/PATCH v2 1/4] output: Add a new library for plumbing output
Date: Mon, 12 Apr 2010 00:21:14 +0100
Message-ID: <20100411232118.67460.52907.julian@quantumfyre.co.uk>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk>
Cc: Jakub Narebsk <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Raymond <esr@thyrsus.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 12 01:25:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O16Wg-0000OT-BK
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 01:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220Ab0DKXZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 19:25:10 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:38494 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753129Ab0DKXYq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 19:24:46 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 800EB819C55B;
	Mon, 12 Apr 2010 00:24:38 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 05B1A20CF58;
	Mon, 12 Apr 2010 00:24:44 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id yhwb5PfWIaZ7; Mon, 12 Apr 2010 00:24:42 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id E22C220CF50;
	Mon, 12 Apr 2010 00:24:42 +0100 (BST)
X-git-sha1: d8e978096ce35d6c5167753d8f1dba37ba5b1db0 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <20100411231824.67460.24844.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144696>

Add a library that allows commands to produce output in any of a range of
formats using a single API.  The idea being that by running all plumbing
command output through this library the output can easily be switched to an
alternative output style (e.g. JSON), while still supporting the
current output formats.

The API includes an OPT_OUTPUT and handle_output_arg so that the
option handling for different commands will be as similar as possible.

Documentation for the API is included in
Documentation/technical/api-output.txt.

At the moment the only new output format is JSON.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 Documentation/technical/api-output.txt |  116 ++++++++++++++
 Makefile                               |    4 +
 output-json.c                          |  127 +++++++++++++++
 output-normal.c                        |   95 +++++++++++
 output-zero.c                          |   74 +++++++++
 output.c                               |  266 ++++++++++++++++++++++++++++++++
 output.h                               |   92 +++++++++++
 7 files changed, 774 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/api-output.txt
 create mode 100644 output-json.c
 create mode 100644 output-normal.c
 create mode 100644 output-zero.c
 create mode 100644 output.c
 create mode 100644 output.h

diff --git a/Documentation/technical/api-output.txt b/Documentation/technical/api-output.txt
new file mode 100644
index 0000000..a811cbe
--- /dev/null
+++ b/Documentation/technical/api-output.txt
@@ -0,0 +1,116 @@
+structured output API
+=====================
+
+The structured output API is provided by output.h and consists of a set of
+functions for outputting data in a structured manner in one of a number of
+formats (referred to as output styles).
+
+The output consists of objects, arrays and the actual values, the term item is
+used where any of these may be used, and container when either an object or
+array may be used.  Objects are unordered collections of named items, and arrays
+are ordered collections of unnamed items.  For simplicity a name is always
+supplied when creating an item - though it may not always be used (e.g. if you
+are adding the item to a list).
+
+To start using structured output `output_start` must be called, as this
+allocates a context to track what is happening and records which output style
+has been selected.  Once all the data has been output, then `output_end` must be
+called.
+
+Values are output by calling the `output_<type>` functions, and grouped by
+starting a container with either `output_start_object` or `output_start_array`.
+A container can be closed by calling `output_end_current` after which items will
+be added at the same level as the container just closed.  It is not necessary to
+close all containers before calling `output_end`, as any open containers will be
+automatically closed.
+
+There are also some functions in the API which exist to support unstructured
+output formats - primarily the existing regular and -z output formats.
+
+Functions
+---------
+
+* Option Parsing
+
+`OPT_OUTPUT`::
+
+	This is a convienience macro that allows easy integration of structured
+	output into a command using the option parser.  The caller only has to
+	supply the short and long option names, and the variable to store the
+	option string in.
+
+`handle_output_arg`::
+
+	Convert a string into a `enum output_style` value.  This allows the
+	calling command to pass the job of parsing the command line option value
+	to the output code.
+
+* Top Level
+
+`ouput_start`::
+
+	This function starts the structured output.  It takes an `enum
+	output_style` argument the defines which backend will be used to do the
+	output, and returns a context pointer that must be passed to all other
+	output functions.
+
+`output_end`::
+
+	This function finishes structured output, including closing any open
+	containers and freeing the context structure allocated by output_start.
+
+* Container Management
+
+`output_start_object`::
+
+	This starts a new object as a member of the curent container, all items
+	will then be added to this object until `object_end_current` or
+	`output_end` is called.
+
+`output_start_array`::
+
+	This starts a new array as a member of the current container, all items
+	will then be added to this array until `object_end_curent` or
+	`output_end` is called.
+
+`output_end_current`::
+
+	This closes the current container.  Any items added after this function
+	is called will be added to the parent of the container just closed.
+
+* Value Output Functions
+
+`output_<type>`::
+
+	Output a value of the given type into the current with the given name
+	(which will be ignored if the continer is an array).  Strings are
+	assumed to be UTF-8, so strings known to be in other encodings will need
+	to be converted.  Quoting of spaces etc is done by the backend code, as
+	the quoting rules are goverened by which style is chosen, so strings
+	should be unqouted.
+
+* Unstructured Output Functions
+
+`output_token`::
+
+	Output the given token.  This token is not subject to any quoting rules
+	but is just displayed as given.
+
+`output_nul`::
+
+	This is basically a dedicated version of `output_token` for outputing a
+	NUL character (which can't be passed through `output_token` since it
+	uses NUL terminatation).
+
+`output_newline`::
+
+	Output an approprite marker for the end of a line.  In the normal output
+	this is a newline character - for the -z output it will be a NUL
+	character.
+
+`output_next_directive`::
+
+	This function allows the modification of printf format directives if
+	supported by the backend (only NORMAL and ZERO currently).  The given
+	string is inserted between the "%" and the exisitng directive
+	characters.
diff --git a/Makefile b/Makefile
index 910f471..dc38730 100644
--- a/Makefile
+++ b/Makefile
@@ -576,6 +576,10 @@ LIB_OBJS += merge-recursive.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += notes.o
 LIB_OBJS += object.o
+LIB_OBJS += output.o
+LIB_OBJS += output-json.o
+LIB_OBJS += output-normal.o
+LIB_OBJS += output-zero.o
 LIB_OBJS += pack-check.o
 LIB_OBJS += pack-refs.o
 LIB_OBJS += pack-revindex.o
diff --git a/output-json.c b/output-json.c
new file mode 100644
index 0000000..386f010
--- /dev/null
+++ b/output-json.c
@@ -0,0 +1,127 @@
+#include "git-compat-util.h"
+#include "output.h"
+
+static void json_print_quoted(FILE *file, const char *unquoted)
+{
+	unsigned char *s = (unsigned char *)unquoted;
+
+	while (*s) {
+		switch (*s) {
+		case '"':
+			fprintf(file, "\\\"");
+			break;
+		case '\\':
+			fprintf(file, "\\\\");
+			break;
+		case '\b':
+			fprintf(file, "\\b");
+			break;
+		case '\f':
+			fprintf(file, "\\f");
+			break;
+		case '\n':
+			fprintf(file, "\\n");
+			break;
+		case '\r':
+			fprintf(file, "\\r");
+			break;
+		case '\t':
+			fprintf(file, "\\t");
+			break;
+		default:
+			/*
+			 * All control characters must be encoded, even if they
+			 * don't have a specific escape character of their own
+			 */
+			if (*s < 0x20)
+				fprintf(file, "\\u%04x", *s);
+			else
+				fprintf(file, "%c", *s);
+			break;
+		}
+		s++;
+	}
+}
+
+static void json_obj_start(FILE *file, const char *name)
+{
+	fprintf(file, "{\n");
+}
+
+static void json_obj_end(FILE *file, const char *name)
+{
+	fprintf(file, "\n}");
+}
+
+static void json_obj_item_start(FILE *file, const char *name, int first)
+{
+	if (!first)
+		fprintf(file, ",\n");
+	fprintf(file, "\"");
+	json_print_quoted(file, name);
+	fprintf(file, "\" : ");
+}
+
+static void json_array_start(FILE *file, const char *name)
+{
+	fprintf(file, "[\n");
+}
+
+static void json_array_end(FILE *file, const char *name)
+{
+	fprintf(file, "\n]");
+}
+
+static void json_array_item_start(FILE *file, const char *name, int first)
+{
+	if (!first)
+		fprintf(file, ",\n");
+}
+
+static void json_bool(FILE *file, int value)
+{
+	if (value)
+		fprintf(file, "true");
+	else
+		fprintf(file, "false");
+}
+
+static void json_str(FILE *file, const char *value)
+{
+	fprintf(file, "\"");
+	json_print_quoted(file, value);
+	fprintf(file, "\"");
+}
+
+static void json_int(FILE *file, int64_t value)
+{
+	fprintf(file, "%lld", value);
+}
+
+static void json_uint(FILE *file, uint64_t value)
+{
+	fprintf(file, "%llu", value);
+}
+
+static void json_double(FILE *file, double value, int precision)
+{
+	fprintf(file, "%.*f", precision, value);
+}
+
+struct output_ops output_json_ops = {
+	json_obj_start,
+	json_obj_end,
+	json_obj_item_start,
+	NULL,
+
+	json_array_start,
+	json_array_end,
+	json_array_item_start,
+	NULL,
+
+	json_bool,
+	json_str,
+	json_int,
+	json_uint,
+	json_double,
+};
diff --git a/output-normal.c b/output-normal.c
new file mode 100644
index 0000000..d4c570a
--- /dev/null
+++ b/output-normal.c
@@ -0,0 +1,95 @@
+#include "git-compat-util.h"
+#include "output.h"
+#include "strbuf.h"
+#include "quote.h"
+
+static const char *next_directive = "";
+static char format_string[100];
+
+static char *normal_quote(const char *s)
+{
+	struct strbuf buf = STRBUF_INIT;
+	size_t len = quote_c_style(s, &buf, NULL, 0);
+
+	if (len == 0) {
+		strbuf_release(&buf);
+		return xstrdup(s);
+	} else
+		return strbuf_detach(&buf, NULL);
+}
+
+static void normal_bool(FILE *file, int value)
+{
+	if (value)
+		fprintf(file, "true");
+	else
+		fprintf(file, "false");
+}
+
+static void normal_str(FILE *file, const char *value)
+{
+	char *quoted = normal_quote(value);
+	snprintf(format_string, sizeof(format_string), "%%%ss", next_directive);
+	fprintf(file, format_string, quoted);
+	next_directive = "";
+	free(quoted);
+}
+
+static void normal_int(FILE *file, int64_t value)
+{
+	snprintf(format_string, sizeof(format_string), "%%%slld", next_directive);
+	fprintf(file, format_string, value);
+	next_directive = "";
+}
+
+static void normal_uint(FILE *file, uint64_t value)
+{
+	snprintf(format_string, sizeof(format_string), "%%%sllu", next_directive);
+	fprintf(file, format_string, value);
+	next_directive = "";
+}
+
+static void normal_double(FILE *file, double value, int precision)
+{
+	snprintf(format_string, sizeof(format_string), "%%%s.*f", next_directive);
+	fprintf(file, format_string, value);
+	next_directive = "";
+}
+
+static void normal_token(FILE *file, const char *token)
+{
+	fprintf(file, "%s", token);
+}
+
+static void normal_newline(FILE *file)
+{
+	fprintf(file, "\n");
+}
+
+static void normal_next_directive(const char *directive)
+{
+	next_directive = directive;
+}
+
+struct output_ops output_normal_ops = {
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+
+	normal_bool,
+	normal_str,
+	normal_int,
+	normal_uint,
+	normal_double,
+
+	normal_token,
+	NULL,
+	normal_newline,
+	normal_next_directive,
+};
diff --git a/output-zero.c b/output-zero.c
new file mode 100644
index 0000000..a00a3cb
--- /dev/null
+++ b/output-zero.c
@@ -0,0 +1,74 @@
+#include "git-compat-util.h"
+#include "output.h"
+
+static const char *next_directive = "";
+static char format_string[100];
+
+static void zero_bool(FILE *file, int value)
+{
+	if (value)
+		fprintf(file, "true");
+	else
+		fprintf(file, "false");
+}
+
+static void zero_str(FILE *file, const char *value)
+{
+	snprintf(format_string, sizeof(format_string), "%%%ss", next_directive);
+	fprintf(file, format_string, value);
+	next_directive = "";
+}
+
+static void zero_int(FILE *file, int64_t value)
+{
+	snprintf(format_string, sizeof(format_string), "%%%slld", next_directive);
+	fprintf(file, format_string, value);
+	next_directive = "";
+}
+
+static void zero_uint(FILE *file, uint64_t value)
+{
+	snprintf(format_string, sizeof(format_string), "%%%sllu", next_directive);
+	fprintf(file, format_string, value);
+	next_directive = "";
+}
+
+static void zero_double(FILE *file, double value, int precision)
+{
+	snprintf(format_string, sizeof(format_string), "%%%s.*f", next_directive);
+	fprintf(file, format_string, value);
+	next_directive = "";
+}
+
+static void zero_nul(FILE *file)
+{
+	fprintf(file, "%c", 0);
+}
+
+static void zero_next_directive(const char *directive)
+{
+	next_directive = directive;
+}
+
+struct output_ops output_zero_ops = {
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+
+	zero_bool,
+	zero_str,
+	zero_int,
+	zero_uint,
+	zero_double,
+
+	zero_str,
+	zero_nul,
+	zero_nul,
+        zero_next_directive,
+};
diff --git a/output.c b/output.c
new file mode 100644
index 0000000..ac8feb1
--- /dev/null
+++ b/output.c
@@ -0,0 +1,266 @@
+#include "git-compat-util.h"
+#include "output.h"
+#include "strbuf.h"
+
+#define DEFAULT_OUTPUT_FORMAT OUTPUT_JSON
+
+extern struct output_ops output_normal_ops;
+extern struct output_ops output_zero_ops;
+extern struct output_ops output_json_ops;
+
+struct output_ops *output_ops[] = {
+	&output_normal_ops,
+	&output_zero_ops,
+	&output_json_ops,
+};
+
+enum output_style handle_output_arg(char *s)
+{
+	if (!s)
+		return OUTPUT_NORMAL;
+	else if (!strcmp(s, "no"))
+		return OUTPUT_NORMAL;
+	else if (!strcmp(s, "zero"))
+		return OUTPUT_ZERO;
+	else if (!strcmp(s, "json"))
+		return OUTPUT_JSON;
+	else
+		die("Invalid output style '%s'", s);
+}
+
+struct output_context *output_start(enum output_style style)
+{
+	struct output_context *context = xcalloc(1, sizeof(*context));
+
+	context->style = style;
+	context->file = stdout;
+	context->ops = output_ops[style];
+
+	output_start_object(context, "git");
+
+	return context;
+}
+
+void output_end(struct output_context *context)
+{
+	while(context->current)
+		output_end_current(context);
+
+	/*
+	 * OUTPUT_NORMAL and OUTPUT_ZERO are special cases - the output format
+	 * is _already_ defined so we have to stick to the rules, we can't add
+	 * _anything_
+	 */
+	if (context->style > OUTPUT_ZERO)
+		fprintf(context->file, "\n");
+
+	free(context);
+}
+
+
+static void item_start(struct output_context *context, const char *name)
+{
+	if (!context->current)
+		return;
+
+	switch (context->current->type) {
+	case OUTPUT_ITEM_OBJECT:
+		if (context->ops->obj_item_start)
+			context->ops->obj_item_start(context->file, name,
+						     context->current->first);
+		break;
+	case OUTPUT_ITEM_ARRAY:
+		if (context->ops->array_item_start)
+			context->ops->array_item_start(context->file, name,
+						       context->current->first);
+		break;
+	}
+}
+
+static void item_end(struct output_context *context, const char *name)
+{
+	if (!context->current)
+		return;
+
+	switch (context->current->type) {
+	case OUTPUT_ITEM_OBJECT:
+		if (context->ops->obj_item_end)
+			context->ops->obj_item_end(context->file, name,
+						   context->current->first);
+		break;
+	case OUTPUT_ITEM_ARRAY:
+		if (context->ops->array_item_end)
+			context->ops->array_item_end(context->file, name,
+						     context->current->first);
+		break;
+	}
+
+	context->current->first = 0;
+}
+
+
+void output_new_current(struct output_context *context, const char *name,
+			enum output_item_type type)
+{
+	struct output_item *item = xmallocz(sizeof(*item));
+
+	item->name = xstrdup(name);
+	item->type = type;
+	item->first = 1;
+
+	item->prev = context->current;
+	context->current = item;
+}
+
+void output_start_object(struct output_context *context, const char *name)
+{
+	item_start(context, name);
+
+	output_new_current(context, name, OUTPUT_ITEM_OBJECT);
+
+	if (context->ops->obj_start)
+		context->ops->obj_start(context->file, name);
+}
+
+void output_start_array(struct output_context *context, const char *name)
+{
+	item_start(context, name);
+
+	output_new_current(context, name, OUTPUT_ITEM_ARRAY);
+
+	if (context->ops->array_start)
+		context->ops->array_start(context->file, name);
+}
+
+void output_end_current(struct output_context *context)
+{
+	struct output_item *item = context->current;
+
+	switch (item->type) {
+	case OUTPUT_ITEM_OBJECT:
+		if (context->ops->obj_end)
+			context->ops->obj_end(context->file, item->name);
+		break;
+	case OUTPUT_ITEM_ARRAY:
+		if (context->ops->array_end)
+			context->ops->array_end(context->file, item->name);
+		break;
+	}
+
+	item = context->current;
+	context->current = context->current->prev;
+
+	item_end(context, item->name);
+
+	free(item->name);
+	free(item);
+}
+
+
+void output_bool(struct output_context *context, const char *name, int value)
+{
+	item_start(context, name);
+	if (context->ops->bool)
+		context->ops->bool(context->file, value);
+	item_end(context, name);
+}
+
+void output_str(struct output_context *context, const char *name, const char *value)
+{
+	item_start(context, name);
+	if (context->ops->str)
+		context->ops->str(context->file, value);
+	item_end(context, name);
+}
+
+void output_strf(struct output_context *context, const char *name, const char *fmt, ...)
+{
+	static char buffer[100];
+	int len;
+	char *value = buffer;
+	va_list ap;
+
+	va_start(ap, fmt);
+	len = vsnprintf(buffer, sizeof(buffer), fmt, ap);
+	va_end(ap);
+
+	if (len >= sizeof(buffer)) {
+		value = xmalloc(len + 1);
+		va_start(ap, fmt);
+		vsnprintf(value, len + 1, fmt, ap);
+		va_end(ap);
+	}
+
+	output_str(context, name, value);
+
+	if (value != buffer)
+		free(value);
+}
+
+void output_int(struct output_context *context, const char *name, int64_t value)
+{
+	item_start(context, name);
+	if (context->ops->int_)
+		context->ops->int_(context->file, value);
+	item_end(context, name);
+}
+
+void output_uint(struct output_context *context, const char *name, uint64_t value)
+{
+	item_start(context, name);
+	if (context->ops->uint)
+		context->ops->uint(context->file, value);
+	item_end(context, name);
+}
+
+void output_double(struct output_context *context, const char *name, double value,
+		   int precision)
+{
+	item_start(context, name);
+	if (context->ops->double_)
+		context->ops->double_(context->file, value, precision);
+	item_end(context, name);
+}
+
+void output_token(struct output_context *context, const char *fmt, ...)
+{
+	static char buffer[100];
+	int len;
+	char *token = buffer;
+	va_list ap;
+
+	va_start(ap, fmt);
+	len = vsnprintf(buffer, sizeof(buffer), fmt, ap);
+	va_end(ap);
+
+	if (len >= sizeof(buffer)) {
+		token = xmalloc(len + 1);
+		va_start(ap, fmt);
+		vsnprintf(token, len + 1, fmt, ap);
+		va_end(ap);
+	}
+
+	if (context->ops->token)
+		context->ops->token(context->file, token);
+
+	if (token != buffer)
+		free(token);
+}
+
+void output_nul(struct output_context *context)
+{
+	if (context->ops->nul)
+		context->ops->nul(context->file);
+}
+
+void output_newline(struct output_context *context)
+{
+	if (context->ops->newline)
+		context->ops->newline(context->file);
+}
+
+void output_next_directive(struct output_context *context, const char *directive)
+{
+	if (context->ops->directive)
+		context->ops->directive(directive);
+}
diff --git a/output.h b/output.h
new file mode 100644
index 0000000..c1a09d0
--- /dev/null
+++ b/output.h
@@ -0,0 +1,92 @@
+#ifndef OUTPUT_H
+#define OUTPUT_H
+
+enum output_style {
+	OUTPUT_NORMAL,
+	OUTPUT_ZERO,
+	OUTPUT_JSON,
+};
+
+struct output_ops {
+	void (*obj_start)(FILE *file, const char *name);
+	void (*obj_end)(FILE *file, const char *name);
+	void (*obj_item_start)(FILE *file, const char *name, int first);
+	void (*obj_item_end)(FILE *file, const char *name, int first);
+
+	void (*array_start)(FILE *file, const char *name);
+	void (*array_end)(FILE *file, const char *name);
+	void (*array_item_start)(FILE *file, const char *name, int first);
+	void (*array_item_end)(FILE *file, const char *name, int first);
+
+	void (*bool)(FILE *file, int value);
+	void (*str)(FILE *file, const char *value);
+	void (*int_)(FILE *file, int64_t value);
+	void (*uint)(FILE *file, uint64_t value);
+	void (*double_)(FILE *file, double value, int precision);
+
+	/*
+	 * ops defined after this comment are for backwards compatability with
+	 * existing output formats, and shouldn't be provided by new output
+	 * styles
+	 */
+	void (*token)(FILE *file, const char *token);
+	void (*nul)(FILE *file);
+	void (*newline)(FILE *file);
+	void (*directive)(const char *directive);
+};
+
+enum output_item_type {
+	OUTPUT_ITEM_OBJECT,
+	OUTPUT_ITEM_ARRAY,
+};
+
+struct output_item {
+	struct output_item *prev;
+	char *name;
+	enum output_item_type type;
+	int first;
+};
+
+struct output_context {
+	enum output_style style;
+	FILE *file;
+	struct output_ops *ops;
+	struct output_item *current;
+};
+
+extern struct option OUTPUT_OPTION;
+
+#define OPT_OUTPUT(s, l, v) { OPTION_STRING, (s), (l), (v), "style",     \
+			      "Use a structured output style, options: " \
+			      "no, zero, json (Default: zero)",          \
+			      PARSE_OPT_OPTARG, NULL, (intptr_t)"zero" }
+
+enum output_style handle_output_arg(char *s);
+
+struct output_context *output_start(enum output_style style);
+void output_end(struct output_context *context);
+
+void output_start_object(struct output_context *context, const char *name);
+void output_start_array(struct output_context *context, const char *name);
+void output_end_current(struct output_context *context);
+
+void output_bool(struct output_context *context, const char *name, int value);
+void output_str(struct output_context *context, const char *name, const char *value);
+void output_strf(struct output_context *context, const char *name, const char *fmt, ...);
+void output_int(struct output_context *context, const char *name, int64_t value);
+void output_uint(struct output_context *context, const char *name, uint64_t value);
+void output_double(struct output_context *context, const char *name, double value,
+		   int precision);
+
+/*
+ * These functions are used to output the fixed formatting tokens needed to
+ * output exisitng -z formats.  It should only be needed when reproducing
+ * existing output.
+ */
+
+void output_token(struct output_context *context, const char *fmt, ...);
+void output_nul(struct output_context *context);
+void output_newline(struct output_context *context);
+void output_next_directive(struct output_context *context, const char *directive);
+
+#endif /* OUTPUT_H */
-- 
1.7.0.4
