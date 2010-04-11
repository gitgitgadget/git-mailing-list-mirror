From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [RFC/PATCH 2/3] add a library of code for producing structured output
Date: Sun, 11 Apr 2010 12:37:31 +0100
Message-ID: <20100411113733.80010.3767.julian@quantumfyre.co.uk>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk>
Cc: Eric Raymond <esr@thyrsus.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 11 13:39:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0vVA-0003bK-PB
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 13:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784Ab0DKLif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 07:38:35 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:41431 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751067Ab0DKLi2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 07:38:28 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id C473B819C4CA;
	Sun, 11 Apr 2010 12:38:20 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 747C820CF47;
	Sun, 11 Apr 2010 12:38:26 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DRRdKeg4+k9g; Sun, 11 Apr 2010 12:38:25 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 77F7820CF49;
	Sun, 11 Apr 2010 12:38:25 +0100 (BST)
X-git-sha1: 1a91efc8a4f6d1875b22509e8bdf2930c726a177 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <20100411112928.80010.1786.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144643>

Add a library that allows commands to produce structured output in any
of a range of formats using a single API.

The API includes an OPT_OUTPUT and handle_output_arg so that the
option handling for different commands will be as similar as possible.

At the moment JSON and XML output options are available - though the
XML output is _very_ rudimentary.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 Makefile      |    3 +
 output-json.c |  128 ++++++++++++++++++++++++++++++++++
 output-xml.c  |   68 ++++++++++++++++++
 output.c      |  212 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 output.h      |   71 +++++++++++++++++++
 5 files changed, 482 insertions(+), 0 deletions(-)
 create mode 100644 output-json.c
 create mode 100644 output-xml.c
 create mode 100644 output.c
 create mode 100644 output.h

diff --git a/Makefile b/Makefile
index 910f471..4ba2a4f 100644
--- a/Makefile
+++ b/Makefile
@@ -576,6 +576,9 @@ LIB_OBJS += merge-recursive.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += notes.o
 LIB_OBJS += object.o
+LIB_OBJS += output.o
+LIB_OBJS += output-json.o
+LIB_OBJS += output-xml.o
 LIB_OBJS += pack-check.o
 LIB_OBJS += pack-refs.o
 LIB_OBJS += pack-revindex.o
diff --git a/output-json.c b/output-json.c
new file mode 100644
index 0000000..0eb66b2
--- /dev/null
+++ b/output-json.c
@@ -0,0 +1,128 @@
+#include "git-compat-util.h"
+#include "output.h"
+#include "strbuf.h"
+
+static char *json_quote(char *s)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	while (*s) {
+		switch (*s) {
+		case '"':
+			strbuf_addstr(&buf, "\\\"");
+			break;
+		case '\\':
+			strbuf_addstr(&buf, "\\\\");
+			break;
+		case '\b':
+			strbuf_addstr(&buf, "\\b");
+			break;
+		case '\f':
+			strbuf_addstr(&buf, "\\f");
+			break;
+		case '\n':
+			strbuf_addstr(&buf, "\\n");
+			break;
+		case '\r':
+			strbuf_addstr(&buf, "\\r");
+			break;
+		case '\t':
+			strbuf_addstr(&buf, "\\t");
+			break;
+		default:
+			/* All control characters must be encode, even if they
+			 * don't have a specific escape character of their own */
+			if (*s < 0x20)
+				strbuf_addf(&buf, "\\u%04x", *s);
+			else
+				strbuf_addch(&buf, *s);
+			break;
+		}
+		s++;
+	}
+
+	return strbuf_detach(&buf, NULL);
+}
+
+static void json_obj_start(FILE *file, char *name)
+{
+	fprintf(file, "{\n");
+}
+
+static void json_obj_end(FILE *file, char *name)
+{
+	fprintf(file, "\n}");
+}
+
+static void json_obj_item_start(FILE *file, char *name, int first)
+{
+	char *quoted = json_quote(name);
+	if (!first)
+		fprintf(file, ",\n");
+	fprintf(file, "\"%s\" : ", quoted);
+	free(quoted);
+}
+
+static void json_array_start(FILE *file, char *name)
+{
+	fprintf(file, "[\n");
+}
+
+static void json_array_end(FILE *file, char *name)
+{
+	fprintf(file, "\n]");
+}
+
+static void json_array_item_start(FILE *file, char *name, int first)
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
+static void json_str(FILE *file, char *value)
+{
+	char *quoted = json_quote(value);
+	fprintf(file, "\"%s\"", quoted);
+	free(quoted);
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
diff --git a/output-xml.c b/output-xml.c
new file mode 100644
index 0000000..50dd7d6
--- /dev/null
+++ b/output-xml.c
@@ -0,0 +1,68 @@
+#include "git-compat-util.h"
+#include "output.h"
+
+static void xml_obj_start(FILE *file, char *name)
+{
+	fprintf(file, "<object name=\"%s\">\n", name);
+}
+
+static void xml_obj_end(FILE *file, char *name)
+{
+	fprintf(file, "</object>\n");
+}
+
+static void xml_obj_item_start(FILE *file, char *name, int first)
+{
+	fprintf(file, "<%s>", name);
+}
+
+static void xml_obj_item_end(FILE *file, char *name, int first)
+{
+	fprintf(file, "</%s>\n", name);
+}
+
+static void xml_bool(FILE *file, int value)
+{
+	if (value)
+		fprintf(file, "true");
+	else
+		fprintf(file, "false");
+}
+
+static void xml_str(FILE *file, char *value)
+{
+	fprintf(file, "\"%s\"", value);
+}
+
+static void xml_int(FILE *file, int64_t value)
+{
+	fprintf(file, "%lld", value);
+}
+
+static void xml_uint(FILE *file, uint64_t value)
+{
+	fprintf(file, "%llu", value);
+}
+
+static void xml_double(FILE *file, double value, int precision)
+{
+	fprintf(file, "%.*f", precision, value);
+}
+
+struct output_ops output_xml_ops = {
+	xml_obj_start,
+	xml_obj_end,
+	xml_obj_item_start,
+	xml_obj_item_end,
+
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+
+	xml_bool,
+	xml_str,
+	xml_int,
+	xml_uint,
+	xml_double,
+};
diff --git a/output.c b/output.c
new file mode 100644
index 0000000..305428c
--- /dev/null
+++ b/output.c
@@ -0,0 +1,212 @@
+#include "git-compat-util.h"
+#include "output.h"
+#include "strbuf.h"
+
+#define DEFAULT_OUTPUT_FORMAT OUTPUT_JSON
+
+extern struct output_ops output_json_ops;
+extern struct output_ops output_xml_ops;
+
+struct output_ops *output_ops[] = {
+	NULL, /* OUTPUT_NORMAL */
+	&output_json_ops,
+	&output_xml_ops,
+};
+
+enum output_style handle_output_arg(char *s)
+{
+	if (!s)
+		return OUTPUT_NORMAL;
+	else if (!strcmp(s, "no"))
+		return OUTPUT_NORMAL;
+	else if (!strcmp(s, "json"))
+		return OUTPUT_JSON;
+	else if (!strcmp(s, "xml"))
+		return OUTPUT_XML;
+	else
+		die("Invalid output style '%s'", s);
+}
+
+char *output_supported_styles()
+{
+	return "";
+}
+
+struct output_context *output_start(enum output_style style)
+{
+	struct output_context *context = xmallocz(sizeof(*context));
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
+	fprintf(context->file, "\n");
+
+	free(context);
+}
+
+
+static void item_start(struct output_context *context, char *name)
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
+static void item_end(struct output_context *context, char *name)
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
+void output_new_current(struct output_context *context, char *name,
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
+void output_start_object(struct output_context *context, char *name)
+{
+	item_start(context, name);
+
+	output_new_current(context, name, OUTPUT_ITEM_OBJECT);
+
+	if (context->ops->obj_start)
+		context->ops->obj_start(context->file, name);
+}
+
+void output_start_array(struct output_context *context, char *name)
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
+void output_bool(struct output_context *context, char *name, int value)
+{
+	item_start(context, name);
+	if (context->ops->bool)
+		context->ops->bool(context->file, value);
+	item_end(context, name);
+}
+
+void output_str(struct output_context *context, char *name, char *value)
+{
+	item_start(context, name);
+	if (context->ops->str)
+		context->ops->str(context->file, value);
+	item_end(context, name);
+}
+
+void output_strf(struct output_context *context, char *name, char *fmt, ...)
+{
+	struct strbuf buf = STRBUF_INIT;
+	va_list ap;
+
+	va_start(ap, fmt);
+	strbuf_vaddf(&buf, fmt, ap);
+	va_end(ap);
+
+	output_str(context, name, buf.buf);
+
+	strbuf_release(&buf);
+}
+
+void output_int(struct output_context *context, char *name, int64_t value)
+{
+	item_start(context, name);
+	if (context->ops->int_)
+		context->ops->int_(context->file, value);
+	item_end(context, name);
+}
+
+void output_uint(struct output_context *context, char *name, uint64_t value)
+{
+	item_start(context, name);
+	if (context->ops->uint)
+		context->ops->uint(context->file, value);
+	item_end(context, name);
+}
+
+void output_double(struct output_context *context, char *name, double value,
+		   int precision)
+{
+	item_start(context, name);
+	if (context->ops->double_)
+		context->ops->double_(context->file, value, precision);
+	item_end(context, name);
+}
+
diff --git a/output.h b/output.h
new file mode 100644
index 0000000..9472ae4
--- /dev/null
+++ b/output.h
@@ -0,0 +1,71 @@
+#ifndef OUTPUT_H
+#define OUTPUT_H
+
+enum output_style {
+	OUTPUT_NORMAL,
+	OUTPUT_JSON,
+	OUTPUT_XML,
+};
+
+struct output_ops {
+	void (*obj_start)(FILE *file, char *name);
+	void (*obj_end)(FILE *file, char *name);
+	void (*obj_item_start)(FILE *file, char *name, int first);
+	void (*obj_item_end)(FILE *file, char *name, int first);
+
+	void (*array_start)(FILE *file, char *name);
+	void (*array_end)(FILE *file, char *name);
+	void (*array_item_start)(FILE *file, char *name, int first);
+	void (*array_item_end)(FILE *file, char *name, int first);
+
+	void (*bool)(FILE *file, int value);
+	void (*str)(FILE *file, char *value);
+	void (*int_)(FILE *file, int64_t value);
+	void (*uint)(FILE *file, uint64_t value);
+	void (*double_)(FILE *file, double value, int precision);
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
+			      "no, json, xml (Default: no)",             \
+			      PARSE_OPT_OPTARG, NULL, (intptr_t)"no" }
+
+enum output_style handle_output_arg(char *s);
+
+struct output_context *output_start(enum output_style style);
+void output_end(struct output_context *context);
+
+void output_start_object(struct output_context *context, char *name);
+void output_start_array(struct output_context *context, char *name);
+void output_end_current(struct output_context *context);
+
+void output_bool(struct output_context *context, char *name, int value);
+void output_str(struct output_context *context, char *name, char *value);
+void output_strf(struct output_context *context, char *name, char *fmt, ...);
+void output_int(struct output_context *context, char *name, int64_t value);
+void output_uint(struct output_context *context, char *name, uint64_t value);
+void output_double(struct output_context *context, char *name, double value,
+		   int precision);
+
+#endif /* OUTPUT_H */
-- 
1.7.0.4
