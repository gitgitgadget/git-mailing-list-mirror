From: Marcus Griep <marcus@griep.us>
Subject: [PATCH v2 2/3] strbuf: Add method to convert byte-size to human readable form
Date: Thu, 14 Aug 2008 18:18:27 -0400
Message-ID: <1218752308-3173-3-git-send-email-marcus@griep.us>
References: <1218752308-3173-1-git-send-email-marcus@griep.us>
 <1218752308-3173-2-git-send-email-marcus@griep.us>
Cc: Junio C Hamano <gitster@pobox.com>, Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 00:19:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTlAO-00017M-C1
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbYHNWSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 18:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751989AbYHNWSf
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:18:35 -0400
Received: from boohaunt.net ([209.40.206.144]:40228 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900AbYHNWS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:18:29 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id 8BEBE1878CE7; Thu, 14 Aug 2008 18:18:28 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc2.6.g8eda3
In-Reply-To: <1218752308-3173-2-git-send-email-marcus@griep.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92419>

Takes a strbuf as its first argument and appends the human-readable
form of 'value', the second argument, to that buffer.

Argument 3, 'maxlen', specifies the longest string that should
be returned. That will make it easier for any pretty-ish formatting
like `ls` and `du` use. A value of 0 is unlimited length.

'scale' specifies a boundary, above which 'value' should be
reduced, and below which it should be reported. Commonly this is
1000.  If 0, then it will find a scale that best fits into 'maxlen'.
If both 'maxlen' and 'scale' are 0, then scale will default to 1000.

'suffix' is appended onto every formatted string.  This is often
"", "B", "bps", "objects" etc.

'flags' provides the ability to switch between a binary (1024)
and an si (1000) period (HR_USE_SI).  Also, adding a space between
number and unit (HR_SPACE).

On success, returns 0.  If maxlen is specified and there is not
enough space given the scale or an inordinately large value, returns
-n, where n is the amount of additional length necessary.

e.g. strbuf_append_human_readable(sb, 1012, 0, 0, "bps", HR_SPACE)
produces "0.9 Kbps".

Also, add in test cases to ensure it produces the expected output
and to demonstrate what different arguments do.

Signed-off-by: Marcus Griep <marcus@griep.us>
---
 .gitignore                |    1 +
 Makefile                  |    2 +-
 strbuf.c                  |   88 +++++++++++++++++++++++++++++++++++++++++++++
 strbuf.h                  |    9 +++++
 t/t0031-human-readable.sh |    9 +++++
 test-human-read.c         |   64 ++++++++++++++++++++++++++++++++
 6 files changed, 172 insertions(+), 1 deletions(-)
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
index 720737d..78de035 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -308,3 +308,91 @@ int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 
 	return len;
 }
+
+int strbuf_append_human_readable(struct strbuf *sb,
+				double val,
+				int maxlen, int scale,
+				const char *suffix,
+				int flags)
+{
+	const int maxscale = 7;
+
+        char *hr_prefixes[] = {
+		"", "K", "M", "G", "T", "P", "E", "Z", "Y", NULL
+	};
+        char **prefix = &hr_prefixes[0];
+	int period = 1024;
+	int sign = val < 0 ? -1 : 1;
+	/* Baselen is (sign, if needed) (digit) (space, if needed)
+			(prefix) (suffix) */
+	int baselen = (val < 0 ? 1 : 0) + 1 + (flags & HR_SPACE ? 1 : 0)
+			+ 1 + strlen(suffix);
+
+	val *= sign;
+
+	if (flags & HR_USE_SI) {
+		period = 1000;
+		hr_prefixes[1] = "k";
+	}
+
+	if (scale == 0) {
+		if (maxlen == 0) {
+			scale = 1000;
+			maxlen = baselen + 3;
+		}
+		else {
+			int space = maxlen - baselen;
+			scale = 10;
+			while (--space > 0) {
+				scale *= 10;
+			}
+		}
+	}
+	else {
+		int space = 1;
+		int check = 10;
+		while (check < scale) {
+			check *= 10;
+			++space;
+		}
+		if (!maxlen)
+			maxlen = baselen + space;
+		if (maxlen - baselen - space< 0)
+			return maxlen - baselen - space;
+	}
+
+        while (val >= scale && *prefix++)
+		val /= period;
+
+        if (val >= scale) {
+		int needed = 0;
+		while (val >= scale) {
+			val /= period;
+			--needed;
+		}
+		return needed;
+	}
+
+	strbuf_addf(sb, "%f", sign * val);
+
+	if (maxlen) {
+		int signlen = sign == -1 ? 1 : 0;
+		int len = maxlen - baselen
+				- (sb->buf[maxlen-baselen-1+signlen] == '.'
+					? 1
+					: 0);
+		if (len <= 0) {
+			strbuf_setlen(sb, 0);
+			return len - 1;
+		}
+		strbuf_setlen(sb, len + signlen);
+	}
+
+	strbuf_addf(sb, "%s%s%s",
+		flags & HR_SPACE ? " " : "",
+		*prefix,
+		suffix
+		);
+
+	return 0;
+}
diff --git a/strbuf.h b/strbuf.h
index eba7ba4..14ccdf9 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -122,6 +122,15 @@ extern int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
 
 extern int strbuf_getline(struct strbuf *, FILE *, int);
 
+#define HR_USE_SI 0x01
+#define HR_SPACE  0x02
+
+extern int strbuf_append_human_readable(struct strbuf *,
+					double val,
+					int maxlen, int scale,
+					const char *suffix,
+					int flags);
+
 extern void stripspace(struct strbuf *buf, int skip_comments);
 extern int launch_editor(const char *path, struct strbuf *buffer, const char *const *env);
 
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
index 0000000..994b20b
--- /dev/null
+++ b/test-human-read.c
@@ -0,0 +1,64 @@
+#include "builtin.h"
+#include "strbuf.h"
+
+struct test {
+	double val;
+	int len;
+	int scale;
+	char *suffix;
+	int flags;
+
+	char *out;
+	int retval;
+};
+
+int main(int argc, char **argv) {
+	int failures = 0, i, retval;
+	struct test tests[] = {
+		{ 1012, 0, 0, "", HR_SPACE, "0.9 K", 0 },
+		{ 1012, 0, 0, "iB", HR_SPACE, "0.9 KiB", 0 },
+		{ 1012, 0, 0, "B", HR_SPACE | HR_USE_SI, "1.0 kB", 0 },
+		{ -1012, 0, 0, "B", HR_SPACE | HR_USE_SI, "-1.0 kB", 0 },
+		{ 1012, 6, 0, "", 0, "1012", 0 },
+		{ 1012, 6, 0, "B", 0, "0.9KB", 0 },
+		{ 1012, 5, 0, "", 0, "0.9K", 0 },
+		{ 1012, 4, 0, "", 0, "0K", 0 },
+		{ 1012, 3, 0, "", 0, "0K", 0 },
+		{ 1012, 2, 0, "", 0, "", -1 },
+		{ -1012, 6, 0, "", 0, "-0.9K", 0 },
+		{ -1012, 5, 0, "", 0, "-0K", 0 },
+		{ -1012, 4, 0, "", 0, "-0K", 0 },
+		{ -1012, 3, 0, "", 0, "", -1 },
+		{ 1012, 0, 1000, "", 0, "0.9K", 0 },
+		{ 506.0 * 1024 * 1024, 0, 1000000, "", 0, "518144K", 0 },
+		{ 506.0 * 1024 * 1024, 0, 1000000, "iB", 0, "518144KiB", 0 },
+		{ 506.0 * 1024 * 1024, 9, 1000000, "", 0, "518144K", 0 },
+		{ 506.0 * 1024 * 1024, 8, 1000000, "", 0, "518144K", 0 },
+		{ 506.0 * 1024 * 1024, 7, 1000000, "", 0, "", -1 },
+		{ 506.0 * 1024 * 1024, 6, 1000000, "", 0, "", -2 },
+		{ 506.0 * 1024 * 1024 * 1024, 0, 1000000, "", 0, "518144M", 0 },
+		{ 506.0 * 1024 * 1024 * 1024, 0, 1000000, "", HR_USE_SI, "543313M", 0 }
+	};
+	struct strbuf sb;
+	strbuf_init(&sb, 0);
+
+	for (i = 0; i < 23; ++i) {
+		printf("Test %d: val: %g maxlen: %d scale: %d suffix: '%s' flags: %d\n", 
+			i+1, tests[i].val, tests[i].len, tests[i].scale,
+			tests[i].suffix, tests[i].flags);
+		strbuf_setlen(&sb, 0);
+		retval = strbuf_append_human_readable(&sb, tests[i].val, tests[i].len,
+				tests[i].scale, tests[i].suffix, tests[i].flags);
+		if(strcmp(sb.buf, tests[i].out)) {
+			printf("\tFailure: Expected '%s', actual '%s'\n",
+				tests[i].out, sb.buf);
+			++failures;
+		} else if (retval != tests[i].retval) {
+			printf("\tFailure: Expected retval '%d', actual retval '%d'\n",
+				tests[i].retval, retval);
+			++failures;
+		}
+	}
+
+	return failures;
+}
-- 
1.6.0.rc2.6.g8eda3
