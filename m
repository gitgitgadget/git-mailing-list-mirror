From: Marcus Griep <marcus@griep.us>
Subject: [RFC Redux] strbuf: Add method to convert byte-size to human readable form
Date: Sat, 13 Sep 2008 00:26:37 -0400
Message-ID: <1221279997-9336-1-git-send-email-marcus@griep.us>
Cc: Junio C Hamano <gitster@pobox.com>, Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 13 06:28:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeMk2-0007tq-Jq
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 06:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbYIME0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 00:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbYIME0j
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 00:26:39 -0400
Received: from boohaunt.net ([209.40.206.144]:49596 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719AbYIME0i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2008 00:26:38 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id 51C361878D46; Sat, 13 Sep 2008 00:26:37 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.451.gc8d31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95791>

Takes a strbuf as its first argument and appends the human-readable
form of 'value', the second argument, to that buffer.

e.g. strbuf_append_human_readable(sb, 1012, 0, 0, HR_SPACE)
produces "0.9 Ki".

Documented in strbuf.h; units can be directly appended to the strbuf
to produce "0.9 KiB/s", "0.9 KiB".

Supports SI magnitude prefixes as well as padding and spacing of
the units portion of the output.

Also, add in test cases to ensure it produces the expected output
and to demonstrate what different arguments do.

Signed-off-by: Marcus Griep <marcus@griep.us>
---

 This is a redux of a prior patch as part of a series on count-objects
 but is now split off and submitted on its own as an RFC for a library
 function to be added to strbuf.  If accepted, I'd like to standardize
 upon this method for user visible byte-sizes, thoroughput, large object
 counts, etc.

 Provides similar functionality similar to the '-h' size output of du
 in the default case.

 Based on master, but also applies cleanly to next.

 .gitignore                |    1 +
 Makefile                  |    2 +-
 strbuf.c                  |   92 +++++++++++++++++++++++++++++++++++++++++++++
 strbuf.h                  |   30 +++++++++++++++
 t/t0031-human-readable.sh |   49 ++++++++++++++++++++++++
 test-human-read.c         |   23 +++++++++++
 6 files changed, 196 insertions(+), 1 deletions(-)
 create mode 100755 t/t0031-human-readable.sh
 create mode 100644 test-human-read.c

diff --git a/.gitignore b/.gitignore
index bbaf9de..251537b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -147,6 +147,7 @@ test-date
 test-delta
 test-dump-cache-tree
 test-genrandom
+test-human-read
 test-match-trees
 test-parse-options
 test-path-utils
diff --git a/Makefile b/Makefile
index 247cd2d..cd97468 100644
--- a/Makefile
+++ b/Makefile
@@ -1322,7 +1322,7 @@ endif
 
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
index 0000000..d4266f2
--- /dev/null
+++ b/t/t0031-human-readable.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+test_description="Test human-readable formatting"
+
+. ./test-lib.sh
+
+HR_NONE=0
+HR_USE_SI=1
+HR_SPACE=2
+HR_PAD_UNIT=4
+
+test_hr () {
+	test_expect_success "'$5' ($6)" "
+		test-human-read $1 $2 $3 $4 $5
+		[[ $? -eq $6 ]]
+	"
+}
+
+test_hr 1012 0 0 $HR_SPACE "0.9 Ki" 0
+test_hr 1012 0 0 $(($HR_SPACE+$HR_USE_SI)) "1.0 k" 0
+test_hr -1012 0 0 $(($HR_SPACE+$HR_USE_SI)) "-1.0 k" 0
+test_hr 1012 5 0 $(($HR_SPACE+$HR_PAD_UNIT)) "1012   " 0
+test_hr 1012 5 0 $HR_SPACE "1012 " 0
+test_hr 1012 5 0 $(($HR_USE_SI+$HR_SPACE+$HR_PAD_UNIT)) "1012  " 0
+test_hr 1012 5 0 $(($HR_USE_SI+$HR_SPACE)) "1012 " 0
+test_hr 1012 4 0 $HR_NONE "1012" 0
+test_hr 1012 3 0 $HR_NONE "0.9Ki" 0
+test_hr 1012 2 0 $HR_NONE "0Ki" 0
+test_hr 1012 1 0 $HR_NONE "0Ki" 0
+test_hr 1012 0 0 $HR_NONE "0.9Ki" 0
+test_hr -1012 3 0 $HR_NONE "-0.9Ki" 0
+test_hr -1012 2 0 $HR_NONE "-0Ki" 0
+test_hr -1012 1 0 $HR_NONE "-0Ki" 0
+test_hr -1012 0 0 $HR_NONE "-0.9Ki" 0
+test_hr 2024 4 0 $HR_NONE "2024" 0
+test_hr 20240 4 0 $HR_NONE "19.7Ki" 0
+test_hr 1012 0 1000 $HR_NONE "0.9Ki" 0
+test_hr $((506*1024*1024)) 0 1000000 $HR_NONE "518144Ki" 0
+test_hr $((506*1024*1024)) 7 1000000 $HR_NONE "518144Ki" 0
+test_hr $((506*1024*1024)) 6 1000000 $HR_NONE "518144Ki" 0
+test_hr $((506*1024*1024)) 5 1000000 $HR_NONE "506.0Mi" 0
+test_hr $((506*1024*1024)) 4 1000000 $HR_NONE "506Mi" 0
+test_hr $((506*1024*1024)) 3 1000000 $HR_NONE "506Mi" 0
+test_hr $((506*1024*1024)) 2 1000000 $HR_NONE "0Gi" 0
+test_hr $((506*1024*1024*1024)) 0 1000000 $HR_NONE "518144Mi" 0
+test_hr $((506*1024*1024*1024)) 0 1000000 $HR_USE_SI "543313Mi" 0
+test_hr 0 0 0 $HR_NONE "0" 0
+
+test_done
diff --git a/test-human-read.c b/test-human-read.c
new file mode 100644
index 0000000..7890922
--- /dev/null
+++ b/test-human-read.c
@@ -0,0 +1,23 @@
+#include "builtin.h"
+#include "strbuf.h"
+
+int main(int argc, char **argv) {
+	if (argc != 6) {
+		exit(-1);
+	}
+
+	struct strbuf sb;
+	strbuf_init(&sb, 0);
+
+	int retval = strbuf_append_human_readable(&sb,
+		atof(argv[1]), atoi(argv[2]), atoi(argv[3]), atoi(argv[4]));
+
+	int failed = strcmp(sb.buf, argv[5]);
+
+	fprintf( stderr, failed ? "Failure" : "Success" );
+	fprintf( stderr, ": Act '%s'; Exp '%s'\n", sb.buf, argv[5] );
+	fprintf( stderr, "Return Value: %d\n", retval );
+
+	if(failed) return -1;
+	return retval;
+}
-- 
1.6.0.1.451.gc8d31
