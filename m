From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/10] Add stream helper library
Date: Mon, 9 Aug 2010 17:39:43 -0500
Message-ID: <20100809223943.GB4429@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 00:41:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oib1x-0006ej-IV
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 00:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756920Ab0HIWlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 18:41:12 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:46127 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab0HIWlL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 18:41:11 -0400
Received: by qyk7 with SMTP id 7so2679947qyk.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 15:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Bc6LyMdbjykr4ooEk+N3Q3whij9q7maavGgDzjB2FD0=;
        b=PknxHX2qGOmQhiOAPwygeHgmhPoDWQIcjFP/jbgVwq7bxZQdzLd2/9VcCB2n2TjPpM
         3iVTjAfXP6pMR9NDEojp+AOf39s+fhNzeWO38HJCPqrPk2JAin0f3NRJ/q9VPBOZT4s4
         lKTSXc1SW21R7OhUSL/6XUnpJH2swoe70m63A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qN0gWmLYC43sqRS5Sr28opwFNd0CucZqUYpOX/pnWb4abyAAQ4sKXVsPTWRBD//prI
         cPTTTBprFhaE9frUDLtLUV32gfuPGNyxXczPUH9hPnlXpTWgqExZiv567Tlu+xM5a/gu
         iMx8L8eSDVn0pvY8ubTkpatln2a/qTiH2d6EI=
Received: by 10.220.62.136 with SMTP id x8mr9909125vch.150.1281393670605;
        Mon, 09 Aug 2010 15:41:10 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id v11sm2883914vbb.4.2010.08.09.15.41.08
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 15:41:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100809215719.GA4203@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153042>

From: David Barr <david.barr@cordelta.com>

This library provides thread-unsafe fgets()- and fread()-like
functions where the caller does not have to supply a buffer.  It
maintains a couple of static buffers and provides an API to use
them.

[rr: allow input from files other than stdin]
[jn: with tests, documentation, and error handling improvements]

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
New tests and API docs.  The return value from buffer_deinit
can be used to check for errors now (I found this useful when
writing tests).

 .gitignore              |    1 +
 Makefile                |    8 +++-
 t/t0080-vcs-svn.sh      |   54 ++++++++++++++++++++++++++
 test-line-buffer.c      |   46 ++++++++++++++++++++++
 vcs-svn/line_buffer.c   |   97 +++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/line_buffer.h   |   12 ++++++
 vcs-svn/line_buffer.txt |   58 ++++++++++++++++++++++++++++
 7 files changed, 274 insertions(+), 2 deletions(-)
 create mode 100644 test-line-buffer.c
 create mode 100644 vcs-svn/line_buffer.c
 create mode 100644 vcs-svn/line_buffer.h
 create mode 100644 vcs-svn/line_buffer.txt

diff --git a/.gitignore b/.gitignore
index 9f109db..8c0512e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -166,6 +166,7 @@
 /test-dump-cache-tree
 /test-genrandom
 /test-index-version
+/test-line-buffer
 /test-match-trees
 /test-obj-pool
 /test-parse-options
diff --git a/Makefile b/Makefile
index 24103c9..a76cce5 100644
--- a/Makefile
+++ b/Makefile
@@ -408,6 +408,7 @@ TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-genrandom
+TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-match-trees
 TEST_PROGRAMS_NEED_X += test-obj-pool
 TEST_PROGRAMS_NEED_X += test-parse-options
@@ -1743,7 +1744,7 @@ ifndef NO_CURL
 endif
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
-VCSSVN_OBJS = vcs-svn/string_pool.o
+VCSSVN_OBJS = vcs-svn/string_pool.o vcs-svn/line_buffer.o
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
 
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
@@ -1867,7 +1868,8 @@ xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
 
 $(VCSSVN_OBJS): \
-	vcs-svn/obj_pool.h vcs-svn/trp.h vcs-svn/string_pool.h
+	vcs-svn/obj_pool.h vcs-svn/trp.h vcs-svn/string_pool.h \
+	vcs-svn/line_buffer.h
 endif
 
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
@@ -2016,6 +2018,8 @@ test-date$X: date.o ctype.o
 
 test-delta$X: diff-delta.o patch-delta.o
 
+test-line-buffer$X: vcs-svn/lib.a
+
 test-parse-options$X: parse-options.o
 
 test-string-pool$X: vcs-svn/lib.a
diff --git a/t/t0080-vcs-svn.sh b/t/t0080-vcs-svn.sh
index 99a314b..d3225ad 100755
--- a/t/t0080-vcs-svn.sh
+++ b/t/t0080-vcs-svn.sh
@@ -76,6 +76,60 @@ test_expect_success 'obj pool: high-water mark' '
 	test_cmp expected actual
 '
 
+test_expect_success 'line buffer' '
+	echo HELLO >expected1 &&
+	printf "%s\n" "" HELLO >expected2 &&
+	echo >expected3 &&
+	printf "%s\n" "" Q | q_to_nul >expected4 &&
+	printf "%s\n" foo "" >expected5 &&
+	printf "%s\n" "" foo >expected6 &&
+
+	test-line-buffer <<-\EOF >actual1 &&
+	5
+	HELLO
+	EOF
+
+	test-line-buffer <<-\EOF >actual2 &&
+	0
+
+	5
+	HELLO
+	EOF
+
+	q_to_nul <<-\EOF |
+	1
+	Q
+	EOF
+	test-line-buffer >actual3 &&
+
+	q_to_nul <<-\EOF |
+	0
+
+	1
+	Q
+	EOF
+	test-line-buffer >actual4 &&
+
+	test-line-buffer <<-\EOF >actual5 &&
+	5
+	foo
+	EOF
+
+	test-line-buffer <<-\EOF >actual6 &&
+	0
+
+	5
+	foo
+	EOF
+
+	test_cmp expected1 actual1 &&
+	test_cmp expected2 actual2 &&
+	test_cmp expected3 actual3 &&
+	test_cmp expected4 actual4 &&
+	test_cmp expected5 actual5 &&
+	test_cmp expected6 actual6
+'
+
 test_expect_success 'string pool' '
 	echo a does not equal b >expected.differ &&
 	echo a equals a >expected.match &&
diff --git a/test-line-buffer.c b/test-line-buffer.c
new file mode 100644
index 0000000..c11bf7f
--- /dev/null
+++ b/test-line-buffer.c
@@ -0,0 +1,46 @@
+/*
+ * test-line-buffer.c: code to exercise the svn importer's input helper
+ *
+ * Input format:
+ *	number NL
+ *	(number bytes) NL
+ *	number NL
+ *	...
+ */
+
+#include "git-compat-util.h"
+#include "vcs-svn/line_buffer.h"
+
+static uint32_t strtouint32(const char *s)
+{
+	char *end;
+	uintmax_t n = strtoumax(s, &end, 10);
+	if (*s == '\0' || *end != '\0')
+		die("invalid count: %s", s);
+	return (uint32_t) n;
+}
+
+int main(int argc, char *argv[])
+{
+	char *s;
+
+	if (argc != 1)
+		usage("test-line-buffer < input.txt");
+	if (buffer_init(NULL))
+		die_errno("open error");
+	while ((s = buffer_read_line())) {
+		s = buffer_read_string(strtouint32(s));
+		fputs(s, stdout);
+		fputc('\n', stdout);
+		buffer_skip_bytes(1);
+		if (!(s = buffer_read_line()))
+			break;
+		buffer_copy_bytes(strtouint32(s) + 1);
+	}
+	if (buffer_deinit())
+		die("input error");
+	if (ferror(stdout))
+		die("output error");
+	buffer_reset();
+	return 0;
+}
diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
new file mode 100644
index 0000000..1543567
--- /dev/null
+++ b/vcs-svn/line_buffer.c
@@ -0,0 +1,97 @@
+/*
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "git-compat-util.h"
+#include "line_buffer.h"
+#include "obj_pool.h"
+
+#define LINE_BUFFER_LEN 10000
+#define COPY_BUFFER_LEN 4096
+
+/* Create memory pool for char sequence of known length */
+obj_pool_gen(blob, char, 4096)
+
+static char line_buffer[LINE_BUFFER_LEN];
+static char byte_buffer[COPY_BUFFER_LEN];
+static FILE *infile;
+
+int buffer_init(const char *filename)
+{
+	infile = filename ? fopen(filename, "r") : stdin;
+	if (!infile)
+		return -1;
+	return 0;
+}
+
+int buffer_deinit(void)
+{
+	int err;
+	if (infile == stdin)
+		return ferror(infile);
+	err = ferror(infile);
+	err |= fclose(infile);
+	return err;
+}
+
+/* Read a line without trailing newline. */
+char *buffer_read_line(void)
+{
+	char *end;
+	if (!fgets(line_buffer, sizeof(line_buffer), infile))
+		/* Error or data exhausted. */
+		return NULL;
+	end = line_buffer + strlen(line_buffer);
+	if (end[-1] == '\n')
+		end[-1] = '\0';
+	else if (feof(infile))
+		; /* No newline at end of file.  That's fine. */
+	else
+		/*
+		 * Line was too long.
+		 * There is probably a saner way to deal with this,
+		 * but for now let's return an error.
+		 */
+		return NULL;
+	return line_buffer;
+}
+
+char *buffer_read_string(uint32_t len)
+{
+	char *s;
+	blob_free(blob_pool.size);
+	s = blob_pointer(blob_alloc(len + 1));
+	s[fread(s, 1, len, infile)] = '\0';
+	return ferror(infile) ? NULL : s;
+}
+
+void buffer_copy_bytes(uint32_t len)
+{
+	uint32_t in;
+	while (len > 0 && !feof(infile) && !ferror(infile)) {
+		in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
+		in = fread(byte_buffer, 1, in, infile);
+		len -= in;
+		fwrite(byte_buffer, 1, in, stdout);
+		if (ferror(stdout)) {
+			buffer_skip_bytes(len);
+			return;
+		}
+	}
+}
+
+void buffer_skip_bytes(uint32_t len)
+{
+	uint32_t in;
+	while (len > 0 && !feof(infile) && !ferror(infile)) {
+		in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
+		in = fread(byte_buffer, 1, in, infile);
+		len -= in;
+	}
+}
+
+void buffer_reset(void)
+{
+	blob_reset();
+}
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
new file mode 100644
index 0000000..9c78ae1
--- /dev/null
+++ b/vcs-svn/line_buffer.h
@@ -0,0 +1,12 @@
+#ifndef LINE_BUFFER_H_
+#define LINE_BUFFER_H_
+
+int buffer_init(const char *filename);
+int buffer_deinit(void);
+char *buffer_read_line(void);
+char *buffer_read_string(uint32_t len);
+void buffer_copy_bytes(uint32_t len);
+void buffer_skip_bytes(uint32_t len);
+void buffer_reset(void);
+
+#endif
diff --git a/vcs-svn/line_buffer.txt b/vcs-svn/line_buffer.txt
new file mode 100644
index 0000000..8906fb1
--- /dev/null
+++ b/vcs-svn/line_buffer.txt
@@ -0,0 +1,58 @@
+line_buffer API
+===============
+
+The line_buffer library provides a convenient interface for
+mostly-line-oriented input.
+
+Each line is not permitted to exceed 10000 bytes.  The provided
+functions are not thread-safe or async-signal-safe, and like
+`fgets()`, they generally do not function correctly if interrupted
+by a signal without SA_RESTART set.
+
+Calling sequence
+----------------
+
+The calling program:
+
+ - specifies a file to read with `buffer_init`
+ - processes input with `buffer_read_line`, `buffer_read_string`,
+   `buffer_skip_bytes`, and `buffer_copy_bytes`
+ - closes the file with `buffer_deinit`, perhaps to start over and
+   read another file.
+
+Before exiting, the caller can use `buffer_reset` to deallocate
+resources for the benefit of profiling tools.
+
+Functions
+---------
+
+`buffer_init`::
+	Open the named file for input.  If filename is NULL,
+	start reading from stdin.  On failure, returns -1 (with
+	errno indicating the nature of the failure).
+
+`buffer_deinit`::
+	Stop reading from the current file (closing it unless
+	it was stdin).  Returns nonzero if `fclose` fails or
+	the error indicator was set.
+
+`buffer_read_line`::
+	Read a line and strip off the trailing newline.
+	On failure or end of file, returns NULL.
+
+`buffer_read_string`::
+	Read `len` characters of input or up to the end of the
+	file, whichever comes first.  Returns NULL on error.
+	Returns whatever characters were read (possibly "")
+	for end of file.
+
+`buffer_copy_bytes`::
+	Read `len` bytes of input and dump them to the standard output
+	stream.  Returns early for error or end of file.
+
+`buffer_skip_bytes`::
+	Discards `len` bytes from the input stream (stopping early
+	if necessary because of an error or eof).
+
+`buffer_reset`::
+	Deallocates non-static buffers.
-- 
1.7.2.1.544.ga752d.dirty
