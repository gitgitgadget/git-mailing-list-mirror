From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [EXPERIMENTAL PATCH] S-expression structured output backend
Date: Tue, 13 Apr 2010 13:23:25 +0300
Message-ID: <1271154205-5919-1-git-send-email-ilari.liusvaara@elisanet.fi>
Cc: Julian Phillips <julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 13 12:24:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1dI7-0007th-TY
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 12:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab0DMKYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 06:24:17 -0400
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:36758 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab0DMKYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 06:24:16 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 36B128BCFC;
	Tue, 13 Apr 2010 13:24:15 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A05C1F33EE9; Tue, 13 Apr 2010 13:24:15 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id D1E4D158A62;
	Tue, 13 Apr 2010 13:24:12 +0300 (EEST)
X-Mailer: git-send-email 1.7.0.2.282.g5b1c2
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144807>

Add structured output mode 'sexp' that prints out canonical form
S-expressions.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 Makefile      |    1 +
 output-sexp.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 output.c      |    9 ++++++-
 output.h      |    3 +-
 4 files changed, 87 insertions(+), 2 deletions(-)
 create mode 100644 output-sexp.c

diff --git a/Makefile b/Makefile
index d32a334..8b0fc21 100644
--- a/Makefile
+++ b/Makefile
@@ -582,6 +582,7 @@ LIB_OBJS += notes-cache.o
 LIB_OBJS += object.o
 LIB_OBJS += output.o
 LIB_OBJS += output-json.o
+LIB_OBJS += output-sexp.o
 LIB_OBJS += output-normal.o
 LIB_OBJS += output-xml.o
 LIB_OBJS += output-zero.o
diff --git a/output-sexp.c b/output-sexp.c
new file mode 100644
index 0000000..df8d56b
--- /dev/null
+++ b/output-sexp.c
@@ -0,0 +1,76 @@
+#include "git-compat-util.h"
+#include "output.h"
+
+static void sexp_str(FILE *file, const char *value)
+{
+	fprintf(file, "%llu:%s", (uint64_t)strlen(value), value);
+}
+
+static void sexp_container_start(FILE *file, const char *name)
+{
+	fprintf(file, "(");
+}
+
+static void sexp_container_end(FILE *file, const char *name)
+{
+	fprintf(file, ")");
+}
+
+static void sexp_objitem_end(FILE *file, const char *name, int first)
+{
+	fprintf(file, ")");
+}
+
+static void sexp_obj_item_start(FILE *file, const char *name, int first)
+{
+	fprintf(file, "(");
+	sexp_str(file,name);
+}
+
+static void sexp_bool(FILE *file, int value)
+{
+	if (value)
+		sexp_str(file, "true");
+	else
+		sexp_str(file, "false");
+}
+
+static void sexp_int_(FILE *file, int64_t value)
+{
+	char buffer[256];
+	sprintf(buffer, "%lli", value);
+	sexp_str(file, buffer);
+}
+
+static void sexp_uint(FILE *file, uint64_t value)
+{
+	char buffer[256];
+	sprintf(buffer, "%llu", value);
+	sexp_str(file, buffer);
+}
+
+static void sexp_double_(FILE *file, double value, int precision)
+{
+	char buffer[256];
+	sprintf(buffer, "%.*f", precision, value);
+	sexp_str(file, buffer);
+}
+
+
+struct output_ops output_sexp_ops = {
+	sexp_container_start,
+	sexp_container_end,
+	sexp_obj_item_start,
+	sexp_objitem_end,
+
+	sexp_container_start,
+	sexp_container_end,
+	NULL,
+	NULL,
+
+	sexp_bool,
+	sexp_str,
+	sexp_int_,
+	sexp_uint,
+	sexp_double_,
+};
diff --git a/output.c b/output.c
index 3be1560..9d04cc4 100644
--- a/output.c
+++ b/output.c
@@ -8,12 +8,14 @@ extern struct output_ops output_normal_ops;
 extern struct output_ops output_zero_ops;
 extern struct output_ops output_json_ops;
 extern struct output_ops output_xml_ops;
+extern struct output_ops output_sexp_ops;
 
 struct output_ops *output_ops[] = {
 	&output_normal_ops,
 	&output_zero_ops,
 	&output_json_ops,
 	&output_xml_ops,
+	&output_sexp_ops,
 };
 
 enum output_style handle_output_arg(char *s)
@@ -28,6 +30,8 @@ enum output_style handle_output_arg(char *s)
 		return OUTPUT_JSON;
 	else if (!strcmp(s, "xml"))
 		return OUTPUT_XML;
+	else if (!strcmp(s, "sexp"))
+		return OUTPUT_SEXP;
 	else
 		die("Invalid output style '%s'", s);
 }
@@ -54,8 +58,11 @@ void output_end(struct output_context *context)
 	 * OUTPUT_NORMAL and OUTPUT_ZERO are special cases - the output format
 	 * is _already_ defined so we have to stick to the rules, we can't add
 	 * _anything_
+	 *
+	 * As for S-Expression output, no, canonical mode does not allow trailing
+	 * newline, so suppress it.
 	 */
-	if (context->style > OUTPUT_ZERO)
+	if (context->style > OUTPUT_ZERO && context->style != OUTPUT_SEXP)
 		fprintf(context->file, "\n");
 
 	free(context);
diff --git a/output.h b/output.h
index cc0b921..7ee2cd7 100644
--- a/output.h
+++ b/output.h
@@ -6,6 +6,7 @@ enum output_style {
 	OUTPUT_ZERO,
 	OUTPUT_JSON,
 	OUTPUT_XML,
+	OUTPUT_SEXP,
 };
 
 struct output_ops {
@@ -59,7 +60,7 @@ extern struct option OUTPUT_OPTION;
 
 #define OPT_OUTPUT(s, l, v) { OPTION_STRING, (s), (l), (v), "style",     \
 			      "Use a structured output style, options: " \
-			      "no, zero, json, xml (Default: zero)",     \
+			      "no, zero, json, xml, sexp (Default: zero)",     \
 			      PARSE_OPT_OPTARG, NULL, (intptr_t)"zero" }
 
 enum output_style handle_output_arg(char *s);
-- 
1.7.0.2.282.g5b1c2
