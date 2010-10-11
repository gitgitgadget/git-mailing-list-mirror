From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/16] vcs-svn: Add code to maintain a sliding view of a file
Date: Sun, 10 Oct 2010 21:53:41 -0500
Message-ID: <20101011025341.GK1553@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100810125317.GB3921@kytes>
 <20101011023435.GA706@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 04:57:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P58ZR-0005uN-VC
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 04:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869Ab0JKC45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 22:56:57 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56734 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029Ab0JKC44 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 22:56:56 -0400
Received: by yxm8 with SMTP id 8so51542yxm.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 19:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Di/BjbJbUS2EPzgkwjhuOomF7jm5zxkOaN7fyJOJuHo=;
        b=DJH4gecIIdQa5aB2v6iXlUn6M21qRDsKmIUSoUjM/D5yztX6UfBG6O07UzGWcnlh/H
         Q9yrmkT5U7h+BTuge/g3Y0jRkTpAaTu6d8961p7scQcowrIScKNuVo6Jfp/O7AoKFfpN
         xQk8AXVicCgRLBRT8DESAHMudqdtFhTXheGBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eOsNt/ONeDWnZwRcso9yKI6Nn0YsNvFNVdmIv9jvLtcOubBLM2Mb+U4aXAiqpqMX2C
         /XUaoRL8PEpsSn8IgRDzmQlhV8JmOk3h6ZUkjLlbpH6i2APv+CJPD8VMtIPmUK2+nVN9
         F09ZKMLJIz96i4hEHA9kcsvs3SXwT/M3OxmEE=
Received: by 10.236.108.44 with SMTP id p32mr10675522yhg.12.1286765815488;
        Sun, 10 Oct 2010 19:56:55 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id x53sm4695468yhc.10.2010.10.10.19.56.54
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 19:56:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011023435.GA706@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158741>

Subversion's delta format has the convenient property that applying
each section of the delta only requires examining (and keeping in
memory) a small portion of the preimage.  At any moment, this portion
begins at a well-defined file offset and has a well-defined length,
and as the delta is applied, it moves from the beginning to the end
of the file.  Add a move_window() function to keep track of such a
window into a file.

You can use it like this:

	struct line_buffer preimage = LINE_BUFFER_INIT;
	buffer_init(&preimage, NULL);
	struct view window = {&preimage, 0, STRBUF_INIT};
	move_window(&window, 3, 7);	/* (1) */
	move_window(&window, 5, 5);	/* (2) */
	move_window(&window, 12, 2);	/* (3) */
	strbuf_release(&window.buf);
	buffer_deinit(&preimage);

In this example: (1) reads 10 bytes and discards the first 3;
(2) discards the first 2, which are not needed any more; and (3)
skips 2 bytes and reads 2 new bytes to work with.

Whenever move_window() returns, the file position indicator is at
position window->off + window->buf.len and the data from positions
window->off to the current file position are stored in window->buf.

This function does only sequential access and never seeks, so it
can be safely used on pipes and sockets.

On end-of-file, move_window() just silently reads less than the
caller requested.  On other errors, it prints a message to stderr
and returns -1.

Helped-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile                 |    5 ++-
 vcs-svn/sliding_window.c |   65 ++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/sliding_window.h |   14 ++++++++++
 vcs-svn/LICENSE          |    2 +
 4 files changed, 84 insertions(+), 2 deletions(-)
 create mode 100644 vcs-svn/sliding_window.c
 create mode 100644 vcs-svn/sliding_window.h

diff --git a/Makefile b/Makefile
index 1f1ce04..d99da33 100644
--- a/Makefile
+++ b/Makefile
@@ -1765,7 +1765,8 @@ endif
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
 VCSSVN_OBJS = vcs-svn/string_pool.o vcs-svn/line_buffer.o \
-	vcs-svn/repo_tree.o vcs-svn/fast_export.o vcs-svn/svndump.o
+	vcs-svn/repo_tree.o vcs-svn/fast_export.o vcs-svn/svndump.o \
+	vcs-svn/sliding_window.o
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
 
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
@@ -1892,7 +1893,7 @@ xdiff-interface.o $(XDIFF_OBJS): \
 $(VCSSVN_OBJS): \
 	vcs-svn/obj_pool.h vcs-svn/trp.h vcs-svn/string_pool.h \
 	vcs-svn/line_buffer.h vcs-svn/repo_tree.h vcs-svn/fast_export.h \
-	vcs-svn/svndump.h
+	vcs-svn/svndump.h vcs-svn/sliding_window.h
 endif
 
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
diff --git a/vcs-svn/sliding_window.c b/vcs-svn/sliding_window.c
new file mode 100644
index 0000000..8273970
--- /dev/null
+++ b/vcs-svn/sliding_window.c
@@ -0,0 +1,65 @@
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
+static void strbuf_remove_from_left(struct strbuf *sb, size_t nbytes)
+{
+	assert(nbytes <= sb->len);
+	memmove(sb->buf, sb->buf + nbytes, sb->len - nbytes);
+	strbuf_setlen(sb, sb->len - nbytes);
+}
+
+static int check_overflow(off_t a, size_t b)
+{
+	if ((off_t) b < 0)
+		return error("Unrepresentable length: "
+				"%"PRIu64" > OFF_MAX", (uint64_t) b);
+	if (signed_add_overflows(a, (off_t) b))
+		return error("Unrepresentable offset: "
+				"%"PRIu64" + %"PRIu64" > OFF_MAX",
+				(uint64_t) a, (uint64_t) b);
+	return 0;
+}
+
+int move_window(struct view *view, off_t off, size_t len)
+{
+	off_t file_offset;
+	assert(view && view->file);
+	assert(!check_overflow(view->off, view->buf.len));
+
+	if (check_overflow(off, len))
+		return -1;
+	if (off < view->off || off + len < view->off + view->buf.len)
+		return error("Invalid delta: window slides left");
+
+	file_offset = view->off + view->buf.len;
+	if (off < file_offset)
+		/* Move the overlapping region into place. */
+		strbuf_remove_from_left(&view->buf, off - view->off);
+	else
+		strbuf_setlen(&view->buf, 0);
+	if (off > file_offset) {
+		/* Seek ahead to skip the gap. */
+		const off_t gap = off - file_offset;
+		const off_t nread = buffer_skip_bytes(view->file, gap);
+		if (nread != gap) {
+			if (!buffer_ferror(view->file))	/* View ends early. */
+				goto done;
+			return error("Cannot seek forward in input: %s",
+				     strerror(errno));
+		}
+		file_offset += gap;
+	}
+	buffer_read_binary(&view->buf, len - view->buf.len, view->file);
+	if (buffer_ferror(view->file))
+		return error("Cannot read preimage: %s", strerror(errno));
+ done:
+	view->off = off;
+	return 0;
+}
diff --git a/vcs-svn/sliding_window.h b/vcs-svn/sliding_window.h
new file mode 100644
index 0000000..b9f0552
--- /dev/null
+++ b/vcs-svn/sliding_window.h
@@ -0,0 +1,14 @@
+#ifndef SLIDING_WINDOW_H_
+#define SLIDING_WINDOW_H_
+
+#include "strbuf.h"
+
+struct view {
+	struct line_buffer *file;
+	off_t off;
+	struct strbuf buf;
+};
+
+extern int move_window(struct view *view, off_t off, size_t len);
+
+#endif
diff --git a/vcs-svn/LICENSE b/vcs-svn/LICENSE
index 0a5e3c4..805882c 100644
--- a/vcs-svn/LICENSE
+++ b/vcs-svn/LICENSE
@@ -1,6 +1,8 @@
 Copyright (C) 2010 David Barr <david.barr@cordelta.com>.
 All rights reserved.
 
+Copyright (C) 2010 Jonathan Nieder <jrnieder@gmail.com>.
+
 Copyright (C) 2008 Jason Evans <jasone@canonware.com>.
 All rights reserved.
 
-- 
1.7.2.3
