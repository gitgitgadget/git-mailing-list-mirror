From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 3/2] attribute "coding": specify blob encoding
Date: Wed, 02 Jan 2008 01:50:21 -0800
Message-ID: <7vsl1gy2si.fsf@gitster.siamese.dyndns.org>
References: <20080102.082014.02281301.tshibata@ab.jp.nec.com>
	<7v1w904x29.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tsugikazu Shibata <tshibata@ab.jp.nec.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 10:52:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA0GV-0004cm-KO
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 10:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756849AbYABJud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 04:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756858AbYABJud
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 04:50:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757453AbYABJub (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 04:50:31 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 00717B26F;
	Wed,  2 Jan 2008 04:50:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E930CB26E;
	Wed,  2 Jan 2008 04:50:25 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69468>

This teaches "diff hunk header" function about custom character
encoding per path via gitattributes(5) so that it can sensibly
chomp a line without truncating a character in the middle.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is not intended for serious inclusion, but was done more
   as a demonstration of the concept, hence [3/2].

 Makefile   |    5 ++-
 coding.c   |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 coding.h   |   10 +++++++++
 diff.c     |   48 ++++++++++++++++++++++++++++++++++++++++-----
 diffcore.h |    1 +
 5 files changed, 118 insertions(+), 8 deletions(-)
 create mode 100644 coding.c
 create mode 100644 coding.h

diff --git a/Makefile b/Makefile
index 21c80e6..de205e6 100644
--- a/Makefile
+++ b/Makefile
@@ -293,7 +293,8 @@ LIB_H = \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
 	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
-	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h
+	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h \
+	coding.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -316,7 +317,7 @@ LIB_OBJS = \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
 	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o \
-	transport.o bundle.o walker.o parse-options.o ws.o
+	transport.o bundle.o walker.o parse-options.o ws.o coding.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/coding.c b/coding.c
new file mode 100644
index 0000000..63c5dc7
--- /dev/null
+++ b/coding.c
@@ -0,0 +1,62 @@
+#include "coding.h"
+
+unsigned long truncate_euc_jp(char *line, unsigned long len)
+{
+	/*
+	 * line contains len bytes but the end of the string could
+	 * be incomplete (chomped in the middle of a character).
+	 * grab complete lines and count the display width, and
+	 * return the number of bytes to chomp at (which could
+	 * be smaller than 'len' given, to discard the corrupt
+	 * characters at the end
+	 */
+	char *ep = line + len;
+	unsigned long sofar = 0;
+
+	while (line < ep) {
+		int ch = (*line++ & 0xFF);
+		int width;
+
+		if (ch < 0x80) {
+			/* JIS X 0201 lower half */
+			sofar++;
+			width = 1;
+		} else if (0xA1 <= ch && ch <= 0xFE) {
+			/* JIS X 0208 */
+			if (ep <= line)
+				goto invalid;
+			ch = (*line++ & 0xFF);
+			if (ch < 0xA1 || 0xFE < ch)
+				goto invalid;
+			width = 2;
+			sofar += 2;
+		} else if (ch == 0x8E) {
+			/* JIS X 0201 upper half */
+			if (ep <= line)
+				goto invalid;
+			ch = (*line++ & 0xFF);
+			if (ch <= 0xA1 || 0xDF < ch)
+				goto invalid;
+			width = 1;
+			sofar += 2;
+		} else if (ch == 0x8F) {
+			/* JIS X 0212 */
+			if (ep <= line)
+				goto invalid;
+			ch = (*line++ & 0xFF);
+			if (ch < 0xA1 || 0xFE < ch)
+				goto invalid;
+			if (ep <= line)
+				goto invalid;
+			ch = (*line++ & 0xFF);
+			if (ch < 0xA1 || 0xFE < ch)
+				goto invalid;
+			width = 2;
+			sofar += 3;
+		} else {
+		invalid:
+			return sofar;
+		}
+	}
+	return sofar;
+}
diff --git a/coding.h b/coding.h
new file mode 100644
index 0000000..0e02701
--- /dev/null
+++ b/coding.h
@@ -0,0 +1,10 @@
+#ifndef CODING_H
+#define CODING_H
+
+#include "cache.h"
+
+typedef unsigned long (*sane_truncate_fn)(char *line, unsigned long len);
+
+unsigned long truncate_euc_jp(char *, unsigned long);
+
+#endif
diff --git a/diff.c b/diff.c
index b9159bc..40c8d2b 100644
--- a/diff.c
+++ b/diff.c
@@ -11,6 +11,7 @@
 #include "attr.h"
 #include "run-command.h"
 #include "utf8.h"
+#include "coding.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -466,8 +467,6 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	}
 }
 
-typedef unsigned long (*sane_truncate_fn)(char *line, unsigned long len);
-
 struct emit_callback {
 	struct xdiff_emit_state xm;
 	int nparents, color_diff;
@@ -1125,30 +1124,34 @@ static void emit_binary_diff(mmfile_t *one, mmfile_t *two)
 static void setup_diff_attr_check(struct git_attr_check *check)
 {
 	static struct git_attr *attr_diff;
+	static struct git_attr *attr_coding;
 
 	if (!attr_diff) {
 		attr_diff = git_attr("diff", 4);
+		attr_coding = git_attr("coding", 6);
 	}
 	check[0].attr = attr_diff;
+	check[1].attr = attr_coding;
 }
 
 static void diff_filespec_check_attr(struct diff_filespec *one)
 {
-	struct git_attr_check attr_diff_check;
+	struct git_attr_check attr_diff_check[2];
 	int check_from_data = 0;
 
 	if (one->checked_attr)
 		return;
 
-	setup_diff_attr_check(&attr_diff_check);
+	setup_diff_attr_check(attr_diff_check);
 	one->is_binary = 0;
 	one->funcname_pattern_ident = NULL;
+	one->coding = NULL;
 
-	if (!git_checkattr(one->path, 1, &attr_diff_check)) {
+	if (!git_checkattr(one->path, 2, attr_diff_check)) {
 		const char *value;
 
 		/* binaryness */
-		value = attr_diff_check.value;
+		value = attr_diff_check[0].value;
 		if (ATTR_TRUE(value))
 			;
 		else if (ATTR_FALSE(value))
@@ -1161,6 +1164,15 @@ static void diff_filespec_check_attr(struct diff_filespec *one)
 			;
 		else
 			one->funcname_pattern_ident = value;
+
+		/* coding */
+		value = attr_diff_check[1].value;
+		if (ATTR_TRUE(value) ||
+		    ATTR_FALSE(value) ||
+		    ATTR_UNSET(value))
+			;
+		else
+			one->coding = value;
 	}
 
 	if (check_from_data) {
@@ -1233,6 +1245,27 @@ static const char *diff_funcname_pattern(struct diff_filespec *one)
 	return NULL;
 }
 
+static struct {
+	const char *coding;
+	sane_truncate_fn fn;
+} builtin_truncate_fn[] = {
+	{ "euc-jp", truncate_euc_jp },
+	{ "utf-8", NULL },
+};
+
+static sane_truncate_fn diff_truncate_line_fn(struct diff_filespec *one)
+{
+	int i;
+
+	diff_filespec_check_attr(one);
+	if (!one->coding)
+		return NULL;
+	for (i = 0; i < ARRAY_SIZE(builtin_truncate_fn); i++)
+		if (!strcmp(one->coding, builtin_truncate_fn[i].coding))
+			return builtin_truncate_fn[i].fn;
+	return NULL;
+}
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
@@ -1318,6 +1351,9 @@ static void builtin_diff(const char *name_a,
 		ecbdata.color_diff = DIFF_OPT_TST(o, COLOR_DIFF);
 		ecbdata.found_changesp = &o->found_changes;
 		ecbdata.ws_rule = whitespace_rule(name_b ? name_b : name_a);
+		ecbdata.truncate = diff_truncate_line_fn(one);
+		if (!ecbdata.truncate)
+			ecbdata.truncate = diff_truncate_line_fn(two);
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xecfg.ctxlen = o->context;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
diff --git a/diffcore.h b/diffcore.h
index cc96c20..711a4df 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -28,6 +28,7 @@ struct diff_filespec {
 	void *data;
 	void *cnt_data;
 	const char *funcname_pattern_ident;
+	const char *coding;      /* blob text coding */
 	unsigned long size;
 	int count;               /* Reference count */
 	int xfrm_flags;		 /* for use by the xfrm */
-- 
1.5.4.rc2.13.g690bd
