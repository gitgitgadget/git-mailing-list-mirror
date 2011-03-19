From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 06/16] vcs-svn: skeleton of an svn delta parser
Date: Sat, 19 Mar 2011 18:20:44 +1100
Message-ID: <1300519254-20201-7-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:21:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qTy-0007ZM-KB
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672Ab1CSHVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:21:45 -0400
Received: from [119.15.97.146] ([119.15.97.146]:60948 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753965Ab1CSHVW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:21:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id BDD7FC046;
	Sat, 19 Mar 2011 18:17:49 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 87xEZHUGyyhy; Sat, 19 Mar 2011 18:17:44 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id C19B7C050;
	Sat, 19 Mar 2011 18:17:42 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169403>

From: Jonathan Nieder <jrnieder@gmail.com>

A delta in the subversion delta (svndiff0) format consists of the
magic bytes SVN\0 followed by a sequence of windows of a certain
well specified format (starting with five integers).

Add an svndiff0_apply function and test-svn-fe -d commandline tool to
parse such a delta in the special case of not including any windows.

Later patches will add features to turn this into a fully functional
delta applier for use by svn-fe in parsing the streams produced by
"svnrdump dump" and "svnadmin dump --deltas".

The content of symlinks starts with the word "link " in Subversion's
worldview, so we will need to prepend that text for the sake of
delta application.  Initialization of the input state of the
delta preimage is left to the calling program, which gives callers
a chance to seed the sliding window with text of their choice.

Improved-by: Ramkumar Ramachandra <artagnon@gmail.com>
Improved-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 Makefile              |    4 +-
 t/t9011-svn-da.sh     |   37 ++++++++++++++++++++++++++++++++++
 test-svn-fe.c         |   42 ++++++++++++++++++++++++++++++++-------
 vcs-svn/line_buffer.c |    6 ++--
 vcs-svn/line_buffer.h |    2 +-
 vcs-svn/svndiff.c     |   52 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/svndiff.h     |   10 +++++++++
 7 files changed, 139 insertions(+), 14 deletions(-)
 create mode 100755 t/t9011-svn-da.sh
 create mode 100644 vcs-svn/svndiff.c
 create mode 100644 vcs-svn/svndiff.h

diff --git a/Makefile b/Makefile
index bac415d..bc6690a 100644
--- a/Makefile
+++ b/Makefile
@@ -1837,7 +1837,7 @@ XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
 VCSSVN_OBJS = vcs-svn/line_buffer.o vcs-svn/repo_tree.o \
 	vcs-svn/fast_export.o vcs-svn/svndump.o \
-	vcs-svn/sliding_window.o
+	vcs-svn/sliding_window.o vcs-svn/svndiff.o
 VCSSVN_TEST_OBJS = test-obj-pool.o test-line-buffer.o test-treap.o
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
 
@@ -1963,7 +1963,7 @@ xdiff-interface.o $(XDIFF_OBJS): \
 
 $(VCSSVN_OBJS) $(VCSSVN_TEST_OBJS): $(LIB_H) \
 	vcs-svn/line_buffer.h vcs-svn/repo_tree.h vcs-svn/fast_export.h \
-	vcs-svn/svndump.h vcs-svn/sliding_window.h
+	vcs-svn/sliding_window.h vcs-svn/svndiff.h vcs-svn/svndump.h
 
 test-svn-fe.o: vcs-svn/svndump.h
 endif
diff --git a/t/t9011-svn-da.sh b/t/t9011-svn-da.sh
new file mode 100755
index 0000000..6d6a406
--- /dev/null
+++ b/t/t9011-svn-da.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='test parsing of svndiff0 files
+
+Using the "test-svn-fe -d" helper, check that svn-fe correctly
+interprets deltas using various facilities (some from the spec,
+some only learned from practice).
+'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	>empty &&
+	printf foo >preimage
+'
+
+test_expect_success 'reject empty delta' '
+	test_must_fail test-svn-fe -d preimage empty 0
+'
+
+test_expect_success 'delta can empty file' '
+	printf "SVNQ" | q_to_nul >clear.delta &&
+	test-svn-fe -d preimage clear.delta 4 >actual &&
+	test_cmp empty actual
+'
+
+test_expect_success 'reject svndiff2' '
+	printf "SVN\002" >bad.filetype &&
+	test_must_fail test-svn-fe -d preimage bad.filetype 4
+'
+
+test_expect_failure 'one-window empty delta' '
+	printf "SVNQ%s" "QQQQQ" | q_to_nul >clear.onewindow &&
+	test-svn-fe -d preimage clear.onewindow 9 >actual &&
+	test_cmp empty actual
+'
+
+test_done
diff --git a/test-svn-fe.c b/test-svn-fe.c
index b42ba78..6558b52 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -4,15 +4,41 @@
 
 #include "git-compat-util.h"
 #include "vcs-svn/svndump.h"
+#include "vcs-svn/svndiff.h"
+#include "vcs-svn/sliding_window.h"
+#include "vcs-svn/line_buffer.h"
 
 int main(int argc, char *argv[])
 {
-	if (argc != 2)
-		usage("test-svn-fe <file>");
-	if (svndump_init(argv[1]))
-		return 1;
-	svndump_read(NULL);
-	svndump_deinit();
-	svndump_reset();
-	return 0;
+	static const char test_svnfe_usage[] =
+		"test-svn-fe (<dumpfile> | [-d] <preimage> <delta> <len>)";
+	if (argc == 2) {
+		if (svndump_init(argv[1]))
+			return 1;
+		svndump_read(NULL);
+		svndump_deinit();
+		svndump_reset();
+		return 0;
+	}
+	if (argc == 5 && !strcmp(argv[1], "-d")) {
+		struct line_buffer preimage = LINE_BUFFER_INIT;
+		struct line_buffer delta = LINE_BUFFER_INIT;
+		struct sliding_view preimage_view = SLIDING_VIEW_INIT(&preimage);
+		if (buffer_init(&preimage, argv[2]))
+			die_errno("cannot open preimage");
+		if (buffer_init(&delta, argv[3]))
+			die_errno("cannot open delta");
+		if (svndiff0_apply(&delta, (off_t) strtoull(argv[4], NULL, 0),
+				   &preimage_view, stdout))
+			return 1;
+		if (buffer_deinit(&preimage))
+			die_errno("cannot close preimage");
+		if (buffer_deinit(&delta))
+			die_errno("cannot close delta");
+		buffer_reset(&preimage);
+		strbuf_release(&preimage_view.buf);
+		buffer_reset(&delta);
+		return 0;
+	}
+	usage(test_svnfe_usage);
 }
diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 08d7cae..2f59670 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -98,10 +98,10 @@ char *buffer_read_string(struct line_buffer *buf, uint32_t len)
 	return ferror(buf->infile) ? NULL : buf->blob_buffer.buf;
 }
 
-void buffer_read_binary(struct line_buffer *buf,
-				struct strbuf *sb, uint32_t size)
+off_t buffer_read_binary(struct line_buffer *buf,
+				struct strbuf *sb, off_t size)
 {
-	strbuf_fread(sb, size, buf->infile);
+	return strbuf_fread(sb, size, buf->infile);
 }
 
 off_t buffer_copy_bytes(struct line_buffer *buf, off_t nbytes)
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index f5c468a..a253070 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -25,7 +25,7 @@ int buffer_ferror(struct line_buffer *buf);
 char *buffer_read_line(struct line_buffer *buf);
 char *buffer_read_string(struct line_buffer *buf, uint32_t len);
 int buffer_read_char(struct line_buffer *buf);
-void buffer_read_binary(struct line_buffer *buf, struct strbuf *sb, uint32_t len);
+off_t buffer_read_binary(struct line_buffer *buf, struct strbuf *sb, off_t len);
 /* Returns number of bytes read (not necessarily written). */
 off_t buffer_copy_bytes(struct line_buffer *buf, off_t len);
 off_t buffer_skip_bytes(struct line_buffer *buf, off_t len);
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
new file mode 100644
index 0000000..5916036
--- /dev/null
+++ b/vcs-svn/svndiff.c
@@ -0,0 +1,52 @@
+/*
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "git-compat-util.h"
+#include "line_buffer.h"
+#include "svndiff.h"
+
+/*
+ * svndiff0 applier
+ *
+ * See http://svn.apache.org/repos/asf/subversion/trunk/notes/svndiff.
+ *
+ * svndiff0 ::= 'SVN\0' window*
+ */
+
+static int error_short_read(struct line_buffer *input)
+{
+	if (buffer_ferror(input))
+		return error("error reading delta: %s", strerror(errno));
+	return error("invalid delta: unexpected end of file");
+}
+
+static int read_magic(struct line_buffer *in, off_t *len)
+{
+	static const char magic[] = {'S', 'V', 'N', '\0'};
+	struct strbuf sb = STRBUF_INIT;
+
+	if (*len < sizeof(magic) ||
+	    buffer_read_binary(in, &sb, sizeof(magic)) != sizeof(magic))
+		return error_short_read(in);
+
+	if (memcmp(sb.buf, magic, sizeof(magic)))
+		return error("invalid delta: unrecognized file type");
+
+	*len -= sizeof(magic);
+	strbuf_release(&sb);
+	return 0;
+}
+
+int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
+			struct sliding_view *preimage, FILE *postimage)
+{
+	assert(delta && preimage && postimage);
+
+	if (read_magic(delta, &delta_len))
+		return -1;
+	if (delta_len)
+		return error("What do you think I am?  A delta applier?");
+	return 0;
+}
diff --git a/vcs-svn/svndiff.h b/vcs-svn/svndiff.h
new file mode 100644
index 0000000..74eb464
--- /dev/null
+++ b/vcs-svn/svndiff.h
@@ -0,0 +1,10 @@
+#ifndef SVNDIFF_H_
+#define SVNDIFF_H_
+
+struct line_buffer;
+struct sliding_view;
+
+extern int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
+		struct sliding_view *preimage, FILE *postimage);
+
+#endif
-- 
1.7.3.2.846.gf4b062
