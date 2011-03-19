From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 05/16] vcs-svn: learn to maintain a sliding view of a file
Date: Sat, 19 Mar 2011 18:20:43 +1100
Message-ID: <1300519254-20201-6-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:21:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qTg-0007RX-FR
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754609Ab1CSHVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:21:31 -0400
Received: from [119.15.97.146] ([119.15.97.146]:62099 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753693Ab1CSHVV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:21:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 19CFBC04B;
	Sat, 19 Mar 2011 18:17:48 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rLLuW727xmD7; Sat, 19 Mar 2011 18:17:44 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id A7E33C04F;
	Sat, 19 Mar 2011 18:17:42 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169398>

From: Jonathan Nieder <jrnieder@gmail.com>

Each section of a Subversion-format delta only requires examining (and
keeping in random-access memory) a small portion of the preimage.  At
any moment, this portion is starts at a certain file offset and has a
well-defined length, and as the delta is applied, the portion moves
from the beginning to the end of the preimage.  Add a move_window
function to keep track of this view into the preimage.

You can use it like this:

	buffer_init(f, NULL);
	struct sliding_view window = SLIDING_VIEW_INIT(f);
	move_window(&window, 3, 7);	/* (1) */
	move_window(&window, 5, 5);	/* (2) */
	move_window(&window, 12, 2);	/* (3) */
	strbuf_release(&window.buf);
	buffer_deinit(f);

The data structure is called sliding_view instead of _window to
prevent confusion with svndiff0 Windows.

In this example, (1) reads 10 bytes and discards the first 3;
(2) discards the first 2, which are not needed any more; and (3) skips
2 bytes and reads 2 new bytes to work with.

When move_window returns, the file position indicator is at position
window->off + window->width and the data from positions window->off to
the current file position are stored in window->buf.

This function performs only sequential access from the input file and
never seeks, so it can be safely used on pipes and sockets.

On end-of-file, move_window silently reads less than the caller
requested.  On other errors, it prints a message and returns -1.

Helped-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 Makefile                 |    5 ++-
 vcs-svn/LICENSE          |    2 +
 vcs-svn/sliding_window.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/sliding_window.h |   17 ++++++++++
 4 files changed, 96 insertions(+), 2 deletions(-)
 create mode 100644 vcs-svn/sliding_window.c
 create mode 100644 vcs-svn/sliding_window.h

diff --git a/Makefile b/Makefile
index 6165609..bac415d 100644
--- a/Makefile
+++ b/Makefile
@@ -1836,7 +1836,8 @@ endif
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
 VCSSVN_OBJS = vcs-svn/line_buffer.o vcs-svn/repo_tree.o \
-	vcs-svn/fast_export.o vcs-svn/svndump.o
+	vcs-svn/fast_export.o vcs-svn/svndump.o \
+	vcs-svn/sliding_window.o
 VCSSVN_TEST_OBJS = test-obj-pool.o test-line-buffer.o test-treap.o
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
 
@@ -1962,7 +1963,7 @@ xdiff-interface.o $(XDIFF_OBJS): \
 
 $(VCSSVN_OBJS) $(VCSSVN_TEST_OBJS): $(LIB_H) \
 	vcs-svn/line_buffer.h vcs-svn/repo_tree.h vcs-svn/fast_export.h \
-	vcs-svn/svndump.h
+	vcs-svn/svndump.h vcs-svn/sliding_window.h
 
 test-svn-fe.o: vcs-svn/svndump.h
 endif
diff --git a/vcs-svn/LICENSE b/vcs-svn/LICENSE
index 533f585..eb91858 100644
--- a/vcs-svn/LICENSE
+++ b/vcs-svn/LICENSE
@@ -1,6 +1,8 @@
 Copyright (C) 2010 David Barr <david.barr@cordelta.com>.
 All rights reserved.
 
+Copyright (C) 2010 Jonathan Nieder <jrnieder@gmail.com>.
+
 Copyright (C) 2005 Stefan Hegny, hydrografix Consulting GmbH,
 Frankfurt/Main, Germany
 and others, see http://svn2cc.sarovar.org
diff --git a/vcs-svn/sliding_window.c b/vcs-svn/sliding_window.c
new file mode 100644
index 0000000..9ce399c
--- /dev/null
+++ b/vcs-svn/sliding_window.c
@@ -0,0 +1,74 @@
+/*
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "git-compat-util.h"
+#include "sliding_window.h"
+#include "line_buffer.h"
+#include "strbuf.h"
+
+static int input_error(struct line_buffer *file)
+{
+	if (!buffer_ferror(file))
+		return error("delta preimage ends early");
+	return error("cannot read delta preimage: %s", strerror(errno));
+}
+
+static int skip_or_whine(struct line_buffer *file, off_t gap)
+{
+	const off_t nread = buffer_skip_bytes(file, gap);
+	return nread == gap ? 0 : input_error(file);
+}
+
+static int read_to_fill_or_whine(struct line_buffer *file,
+				struct strbuf *buf, size_t width)
+{
+	buffer_read_binary(file, buf, width - buf->len);
+	return buf->len == width ? 0 : input_error(file);
+}
+
+static int check_overflow(off_t a, size_t b)
+{
+	if (b > maximum_signed_value_of_type(off_t))
+		return error("unrepresentable length in delta: "
+				"%"PRIuMAX" > OFF_MAX", (uintmax_t) b);
+	if (signed_add_overflows(a, (off_t) b))
+		return error("unrepresentable offset in delta: "
+				"%"PRIuMAX" + %"PRIuMAX" > OFF_MAX",
+				(uintmax_t) a, (uintmax_t) b);
+	return 0;
+}
+
+int move_window(struct sliding_view *view, off_t off, size_t width)
+{
+	off_t file_offset;
+	assert(view);
+	assert(view->width <= view->buf.len);
+	assert(!check_overflow(view->off, view->buf.len));
+
+	if (check_overflow(off, width))
+		return -1;
+	if (off < view->off || off + width < view->off + view->width)
+		return error("invalid delta: window slides left");
+
+	file_offset = view->off + view->buf.len;
+	if (off < file_offset) {
+		/* Move the overlapping region into place. */
+		strbuf_remove(&view->buf, 0, off - view->off);
+	} else {
+		/* Seek ahead to skip the gap. */
+		if (skip_or_whine(view->file, off - file_offset))
+			return -1;
+		strbuf_setlen(&view->buf, 0);
+	}
+
+	if (view->buf.len > width)
+		; /* Already read. */
+	else if (read_to_fill_or_whine(view->file, &view->buf, width))
+		return -1;
+
+	view->off = off;
+	view->width = width;
+	return 0;
+}
diff --git a/vcs-svn/sliding_window.h b/vcs-svn/sliding_window.h
new file mode 100644
index 0000000..ed0bfdd
--- /dev/null
+++ b/vcs-svn/sliding_window.h
@@ -0,0 +1,17 @@
+#ifndef SLIDING_WINDOW_H_
+#define SLIDING_WINDOW_H_
+
+#include "strbuf.h"
+
+struct sliding_view {
+	struct line_buffer *file;
+	off_t off;
+	size_t width;
+	struct strbuf buf;
+};
+
+#define SLIDING_VIEW_INIT(input)	{ (input), 0, 0, STRBUF_INIT }
+
+extern int move_window(struct sliding_view *view, off_t off, size_t width);
+
+#endif
-- 
1.7.3.2.846.gf4b062
