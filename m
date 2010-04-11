From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [RFC/PATCH v2 4/4] output: WIP: Add XML backend
Date: Mon, 12 Apr 2010 00:21:17 +0100
Message-ID: <20100411232118.67460.49557.julian@quantumfyre.co.uk>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk>
Cc: Jakub Narebsk <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Raymond <esr@thyrsus.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 12 01:25:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O16Wf-0000OT-74
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 01:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211Ab0DKXY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 19:24:57 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:38503 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753191Ab0DKXYq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 19:24:46 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 0CF3B819C4D9;
	Mon, 12 Apr 2010 00:24:39 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 5C70A20CF52;
	Mon, 12 Apr 2010 00:24:44 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id hb3t0nn4KO43; Mon, 12 Apr 2010 00:24:44 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 46DC620CF55;
	Mon, 12 Apr 2010 00:24:43 +0100 (BST)
X-git-sha1: 8fc847fb4bd4e3a5e1397e3a8aa27665931df4ef 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <20100411231824.67460.24844.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144694>

This is the very beginnings of an XML style for the output library.
It still needs a lot of work.  There is no quoting, and the layout
still needs designing.  At this point the main purpose of this code is
to exercise the frontend/backend API in a different way from JSON.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 Makefile     |    1 +
 output-xml.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 output.c     |    4 +++
 output.h     |    3 +-
 4 files changed, 75 insertions(+), 1 deletions(-)
 create mode 100644 output-xml.c

diff --git a/Makefile b/Makefile
index dc38730..c84d7de 100644
--- a/Makefile
+++ b/Makefile
@@ -579,6 +579,7 @@ LIB_OBJS += object.o
 LIB_OBJS += output.o
 LIB_OBJS += output-json.o
 LIB_OBJS += output-normal.o
+LIB_OBJS += output-xml.o
 LIB_OBJS += output-zero.o
 LIB_OBJS += pack-check.o
 LIB_OBJS += pack-refs.o
diff --git a/output-xml.c b/output-xml.c
new file mode 100644
index 0000000..9c98ac9
--- /dev/null
+++ b/output-xml.c
@@ -0,0 +1,68 @@
+#include "git-compat-util.h"
+#include "output.h"
+
+static void xml_obj_start(FILE *file, const char *name)
+{
+	fprintf(file, "<object name=\"%s\">\n", name);
+}
+
+static void xml_obj_end(FILE *file, const char *name)
+{
+	fprintf(file, "</object>\n");
+}
+
+static void xml_obj_item_start(FILE *file, const char *name, int first)
+{
+	fprintf(file, "<%s>", name);
+}
+
+static void xml_obj_item_end(FILE *file, const char *name, int first)
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
+static void xml_str(FILE *file, const char *value)
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
index ac8feb1..3be1560 100644
--- a/output.c
+++ b/output.c
@@ -7,11 +7,13 @@
 extern struct output_ops output_normal_ops;
 extern struct output_ops output_zero_ops;
 extern struct output_ops output_json_ops;
+extern struct output_ops output_xml_ops;
 
 struct output_ops *output_ops[] = {
 	&output_normal_ops,
 	&output_zero_ops,
 	&output_json_ops,
+	&output_xml_ops,
 };
 
 enum output_style handle_output_arg(char *s)
@@ -24,6 +26,8 @@ enum output_style handle_output_arg(char *s)
 		return OUTPUT_ZERO;
 	else if (!strcmp(s, "json"))
 		return OUTPUT_JSON;
+	else if (!strcmp(s, "xml"))
+		return OUTPUT_XML;
 	else
 		die("Invalid output style '%s'", s);
 }
diff --git a/output.h b/output.h
index c1a09d0..cc0b921 100644
--- a/output.h
+++ b/output.h
@@ -5,6 +5,7 @@ enum output_style {
 	OUTPUT_NORMAL,
 	OUTPUT_ZERO,
 	OUTPUT_JSON,
+	OUTPUT_XML,
 };
 
 struct output_ops {
@@ -58,7 +59,7 @@ extern struct option OUTPUT_OPTION;
 
 #define OPT_OUTPUT(s, l, v) { OPTION_STRING, (s), (l), (v), "style",     \
 			      "Use a structured output style, options: " \
-			      "no, zero, json (Default: zero)",          \
+			      "no, zero, json, xml (Default: zero)",     \
 			      PARSE_OPT_OPTARG, NULL, (intptr_t)"zero" }
 
 enum output_style handle_output_arg(char *s);
-- 
1.7.0.4
