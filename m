From: Marcus Griep <marcus@griep.us>
Subject: [PATCH v3 2/3] strbuf: Add method to convert byte-size to human readable form
Date: Fri, 15 Aug 2008 00:20:21 -0400
Message-ID: <1218774022-30198-2-git-send-email-marcus@griep.us>
References: <1218752308-3173-1-git-send-email-marcus@griep.us>
 <1218774022-30198-1-git-send-email-marcus@griep.us>
Cc: Junio C Hamano <gitster@pobox.com>, Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 06:21:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTqok-00080F-9H
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 06:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbYHOEU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 00:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbYHOEUZ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 00:20:25 -0400
Received: from boohaunt.net ([209.40.206.144]:32792 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbYHOEUX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 00:20:23 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id A93281878A72; Fri, 15 Aug 2008 00:20:22 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc2.6.g8eda3
In-Reply-To: <1218774022-30198-1-git-send-email-marcus@griep.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92458>

Takes a strbuf as its first argument and appends the human-readable
form of 'value', the second argument, to that buffer.

e.g. strbuf_append_human_readable(sb, 1012, 0, 0, HR_SPACE)
produces "0.9 Ki".

Documented in strbuf.h; units can be directly appended to the strbuf
to produce "0.9 KiB/s", "0.9 KiB", or other unit.

Supports SI magnitude prefixes as well:
e.g. strbuf_append_human_readable(sb, 2024, 0, 0, HR_USE_SI)
produces "2.0k", to which a unit can be appended, such as " objects"
to produce "2.0k objects".

Also, add in test cases to ensure it produces the expected output
and to demonstrate what different arguments do.

Signed-off-by: Marcus Griep <marcus@griep.us>
---
 .gitignore                |    1 +
 Makefile                  |    2 +-
 strbuf.c                  |   92 +++++++++++++++++++++++++++++++++++++++++++++
 strbuf.h                  |   30 +++++++++++++++
 t/t0031-human-readable.sh |    9 ++++
 test-human-read.c         |   68 +++++++++++++++++++++++++++++++++
 6 files changed, 201 insertions(+), 1 deletions(-)
 create mode 100755 t/t0031-human-readable.sh
 create mode 100644 test-human-read.c

diff --git a/.gitignore b/.gitignore
index a213e8e..d65fa75 100644
--- a/.gitignore
+++ b/.gitignore
@@ -146,6 +146,7 @@ test-date
 test-delta
 test-dump-cache-tree
 test-genrandom
+test-human-read
 test-match-trees
 test-parse-options
 test-path-utils
diff --git a/Makefile b/Makefile
index 90c5a13..f17ab76 100644
--- a/Makefile
+++ b/Makefile
@@ -1297,7 +1297,7 @@ endif
 
 ### Testing rules
 
-TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X test-parse-options$X test-path-utils$X
+TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X test-parse-options$X test-path-utils$X test-human-read$X
 
 all:: $(TEST_PROGRAMS)
 
diff --git a/strbuf.c b/strbuf.c
index 720737d..d9888fb 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -308,3 +308,95 @@ int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 
 	return len;
 }
+
+int strbuf_append_human_readable(struct strbuf *sb,
+				double val,
+				int maxlen, int scale,
+				int flags)
+{
+	const int maxscale = 7;
+
+	char *hr_prefixes[] = {
+		"", "Ki", "Mi", "Gi", "Ti", "Pi", "Ei", "Zi", "Yi", NULL
+	};
+	char *hr_si_prefixes[] = {
+		"", "k", "M", "G", "T", "P", "E", "Z", "Y", NULL
+	};
+	char **prefix = &hr_prefixes[0];
+	int period = 1024;
+	int sign = val < 0 ? -1 : 1;
+	int retval = 0;
+
+	val *= sign;
+
+	if (flags & HR_PAD_UNIT) {
+		hr_prefixes[0] = "  ";
+		hr_si_prefixes[0] = " ";
+	}
+
+	if (flags & HR_USE_SI) {
+		period = 1000;
+		prefix = &hr_si_prefixes[0];
+	}
+
+	if (scale == 0) {
+		if (maxlen == 0) {
+			scale = 1000;
+			maxlen = 3;
+		}
+		else {
+			int space = maxlen;
+			scale = 10;
+			while (--space > 0) {
+				scale *= 10;
+			}
+		}
+	}
+	else {
+		int space = 1;
+		int check = 10;
+		int setscale = scale;
+		while (check < scale) {
+			check *= 10;
+			++space;
+			if (maxlen - space == 0)
+				setscale = check;
+		}
+		if (!maxlen)
+			maxlen = space;
+		scale = setscale;
+	}
+
+	while (val >= scale && *prefix++)
+		val /= period;
+
+	if (val >= scale) {
+		int needed = 0;
+		while (val >= scale) {
+			val /= period;
+			--needed;
+		}
+		if (needed < retval)
+			retval = needed;
+	}
+
+	strbuf_addf(sb, "%f", sign * val);
+
+	if (maxlen) {
+		int signlen = sign == -1 ? 1 : 0;
+		maxlen -= (sb->buf[maxlen-1+signlen] == '.' ? 1 : 0);
+		if (maxlen <= 0) {
+			strbuf_setlen(sb, 0);
+			retval = maxlen - 1;
+		} else {
+			strbuf_setlen(sb, maxlen + signlen);
+		}
+	}
+
+	strbuf_addf(sb, "%s%s",
+		flags & HR_SPACE ? " " : "",
+		*prefix
+		);
+
+	return retval;
+}
diff --git a/strbuf.h b/strbuf.h
index eba7ba4..305ef55 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -125,4 +125,34 @@ extern int strbuf_getline(struct strbuf *, FILE *, int);
 extern void stripspace(struct strbuf *buf, int skip_comments);
 extern int launch_editor(const char *path, struct strbuf *buffer, const char *const *env);
 
+/*
+ * strbuf_append_human_readable
+ *
+ * 'val': value to be metrically-reduced to a human-readable number
+ * 'maxlen': maximum number of characters to be taken up by the reduced 'val'
+ *           not including the sign or magnitude (i.e. 'Ki') characters;
+ *           when 'maxlen' is 0 length is controled by 'scale'
+ * 'scale': when 'val' is greater than 'scale', 'val' is reduced by the
+ *          period (default 1024, see 'flags') until it is less than 'scale';
+ *          when 'scale' is 0, 'val' is reduced until it fits in 'maxlen';
+ *          when 'scale' and 'maxlen' are both zero, 'scale' defaults to 1000
+ * 'flags': HR_USE_SI: uses a period of 1000 and uses SI magnitude prefixes
+ *          HR_SPACE: inserts a space between the reduced 'val' and the units
+ *          HR_PAD_UNIT: instead of an empty string for singles, pads with
+ *                       spaces to the length of the magnitude prefixes
+ *
+ * Returns 0 if 'val' is successfully reduced and fits in 'maxlen', otherwise
+ * returns -n where n is the number of additional characters necessary to
+ * fully fit the reduced value.
+ */
+
+#define HR_USE_SI 0x01
+#define HR_SPACE 0x02
+#define HR_PAD_UNIT 0x04
+
+extern int strbuf_append_human_readable(struct strbuf *,
+					double val,
+					int maxlen, int scale,
+					int flags);
+
 #endif /* STRBUF_H */
diff --git a/t/t0031-human-readable.sh b/t/t0031-human-readable.sh
new file mode 100755
index 0000000..ce2fd77
--- /dev/null
+++ b/t/t0031-human-readable.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+
+test_description="Test human-readable formatting"
+
+. ./test-lib.sh
+
+test_expect_success 'human-readable formatting tests' 'test-human-read'
+
+test_done
diff --git a/test-human-read.c b/test-human-read.c
new file mode 100644
index 0000000..855296c
--- /dev/null
+++ b/test-human-read.c
@@ -0,0 +1,68 @@
+#include "builtin.h"
+#include "strbuf.h"
+
+struct test {
+	double val;
+	int len;
+	int scale;
+	int flags;
+
+	char *out;
+	int retval;
+};
+
+int main(int argc, char **argv) {
+	int failures = 0, i = 0, retval;
+	struct test tests[] = {
+		{ 1012, 0, 0, HR_SPACE, "0.9 Ki", 0 },
+		{ 1012, 0, 0, HR_SPACE, "0.9 Ki", 0 },
+		{ 1012, 0, 0, HR_SPACE | HR_USE_SI, "1.0 k", 0 },
+		{ -1012, 0, 0, HR_SPACE | HR_USE_SI, "-1.0 k", 0 },
+		{ 1012, 5, 0, HR_SPACE | HR_PAD_UNIT, "1012   ", 0 },
+		{ 1012, 5, 0, HR_SPACE, "1012 ", 0 },
+		{ 1012, 5, 0, HR_USE_SI | HR_SPACE | HR_PAD_UNIT, "1012  ", 0 },
+		{ 1012, 5, 0, HR_USE_SI | HR_SPACE, "1012 ", 0 },
+		{ 1012, 4, 0, 0, "1012", 0 },
+		{ 1012, 3, 0, 0, "0.9Ki", 0 },
+		{ 1012, 2, 0, 0, "0Ki", 0 },
+		{ 1012, 1, 0, 0, "0Ki", 0 },
+		{ 1012, 0, 0, 0, "0.9Ki", 0 },
+		{ -1012, 3, 0, 0, "-0.9Ki", 0 },
+		{ -1012, 2, 0, 0, "-0Ki", 0 },
+		{ -1012, 1, 0, 0, "-0Ki", 0 },
+		{ -1012, 0, 0, 0, "-0.9Ki", 0 },
+		{ 2024, 4, 0, 0, "2024", 0 },
+		{ 20240, 4, 0, 0, "19.7Ki", 0 },
+		{ 1012, 0, 1000, 0, "0.9Ki", 0 },
+		{ 506.0 * 1024 * 1024, 0, 1000000, 0, "518144Ki", 0 },
+		{ 506.0 * 1024 * 1024, 0, 1000000, 0, "518144Ki", 0 },
+		{ 506.0 * 1024 * 1024, 7, 1000000, 0, "518144Ki", 0 },
+		{ 506.0 * 1024 * 1024, 6, 1000000, 0, "518144Ki", 0 },
+		{ 506.0 * 1024 * 1024, 5, 1000000, 0, "506.0Mi", 0 },
+		{ 506.0 * 1024 * 1024, 4, 1000000, 0, "506Mi", 0 },
+		{ 506.0 * 1024 * 1024, 3, 1000000, 0, "506Mi", 0 },
+		{ 506.0 * 1024 * 1024, 2, 1000000, 0, "0Gi", 0 },
+		{ 506.0 * 1024 * 1024 * 1024, 0, 1000000, 0, "518144Mi", 0 },
+		{ 506.0 * 1024 * 1024 * 1024, 0, 1000000, HR_USE_SI, "543313M", 0 },
+		{ 0, 0, 0, 0, NULL, 0 }
+	};
+	struct strbuf sb;
+	struct test *current = &tests[0];
+	strbuf_init(&sb, 0);
+
+	while(current->out) {
+		printf("Test %2d - ", ++i);
+		strbuf_setlen(&sb, 0);
+		retval = strbuf_append_human_readable(&sb, current->val, current->len,
+				current->scale, current->flags);
+		if(strcmp(sb.buf, current->out) || retval != current->retval) {
+			printf("Failure: Act '%s' (%d); Exp '%s' (%d)\n",
+				sb.buf, retval, current->out, current->retval);
+			++failures;
+		} else
+			printf("Success: '%s' (%d)\n", sb.buf, retval);
+		++current;
+	}
+
+	return failures;
+}
-- 
1.6.0.rc2.6.g8eda3
