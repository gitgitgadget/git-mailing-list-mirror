From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/8] vcs-svn: Introduce fd_buffer routines
Date: Sat, 20 Nov 2010 13:26:48 -0600
Message-ID: <20101120192648.GE17823@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
 <20101120192153.GA17823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 20:27:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJt5S-00027U-4B
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 20:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802Ab0KTT05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 14:26:57 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60216 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764Ab0KTT05 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 14:26:57 -0500
Received: by gxk23 with SMTP id 23so3370562gxk.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 11:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9q2W9TB2t1PrRcZEdqvMPvdT3HkBHXdt2o4x75G6VdM=;
        b=gexYYibd5cTcIpxdGmYfb6EO9PbQ9x/lfqxsVjNK4ah+BkR5vJcxBPXo6LmJQaUZRz
         N8zrE5uxz1LS6Bp9SDjnFa/SmOBBbdetkIrfEQC5P0sGU2Rz+4r9NXAAxFPw/qhhmCSL
         HMyyLzHC34n0wEa3sLik1xOGM3EaSn2xIk4uU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hL8bc+7eFnH1ln3tgm4Ynkgz2ir6eK1wXI0xP7WqODWVZo0btYehWuVQ0+cahr+uO6
         /2qFVysezDwVkXMe2+/Z6XqTAJ4wwSOBKPifxrHvruZw8LxoESz1XfkBUR/Nfs/Opt2g
         YKM3ExjEv/pRY9UGUPavdBjYYzhOp9vlgtI4A=
Received: by 10.151.111.19 with SMTP id o19mr6036347ybm.277.1290281216356;
        Sat, 20 Nov 2010 11:26:56 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id v9sm727541ybe.21.2010.11.20.11.26.54
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Nov 2010 11:26:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120192153.GA17823@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161834>

The fd_buffer library is perhaps poorly named, because it does not
manage its own buffer.  These functions provide the relevant
functionality from line_buffer for low-level, unbuffered (file
descriptor) I/O.

The purpose is to preserve convenience while avoiding deadlock that
could occur from too greedily reading ahead in the cat-blob-fd pipe.
(An alternative approach to achieve the same effect would be to
set the O_NONBLOCK flag on the pipe fd.)

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile              |    5 ++-
 vcs-svn/fast_export.c |   45 ++++++++++------------------------
 vcs-svn/fd_buffer.c   |   65 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/fd_buffer.h   |   19 ++++++++++++++
 4 files changed, 100 insertions(+), 34 deletions(-)
 create mode 100644 vcs-svn/fd_buffer.c
 create mode 100644 vcs-svn/fd_buffer.h

diff --git a/Makefile b/Makefile
index aa10288..844e3b4 100644
--- a/Makefile
+++ b/Makefile
@@ -1760,7 +1760,7 @@ ifndef NO_CURL
 endif
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
-VCSSVN_OBJS = vcs-svn/string_pool.o vcs-svn/line_buffer.o \
+VCSSVN_OBJS = vcs-svn/string_pool.o vcs-svn/line_buffer.o vcs-svn/fd_buffer.o \
 	vcs-svn/repo_tree.o vcs-svn/fast_export.o vcs-svn/svndump.o \
 	vcs-svn/sliding_window.o vcs-svn/svndiff.o
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
@@ -1889,7 +1889,8 @@ xdiff-interface.o $(XDIFF_OBJS): \
 $(VCSSVN_OBJS): \
 	vcs-svn/obj_pool.h vcs-svn/trp.h vcs-svn/string_pool.h \
 	vcs-svn/line_buffer.h vcs-svn/repo_tree.h vcs-svn/fast_export.h \
-	vcs-svn/sliding_window.h vcs-svn/svndump.h vcs-svn/svndiff.h
+	vcs-svn/sliding_window.h vcs-svn/svndump.h vcs-svn/svndiff.h \
+	vcs-svn/fd_buffer.h
 endif
 
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 0de498b..ebaab72 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -6,6 +6,7 @@
 #include "git-compat-util.h"
 #include "fast_export.h"
 #include "line_buffer.h"
+#include "fd_buffer.h"
 #include "repo_tree.h"
 #include "string_pool.h"
 #include "strbuf.h"
@@ -73,7 +74,7 @@ static int ends_with(const char *s, size_t len, const char *suffix)
 	return !memcmp(s + len - suffixlen, suffix, suffixlen);
 }
 
-static int parse_cat_response_line(const char *header, size_t *len)
+static int parse_cat_response_line(const char *header, off_t *len)
 {
 	size_t headerlen = strlen(header);
 	const char *type;
@@ -95,45 +96,25 @@ static int parse_cat_response_line(const char *header, size_t *len)
 static struct strbuf response_line = STRBUF_INIT;
 static const char *get_response_line(void)
 {
-	/*
-	 * NEEDSWORK: Does not actually need to read one byte at a time.
-	 * Some platforms have O_NONBLOCK.  On others we could read 8 chars
-	 * at a time until a potential appearance of " blob ".
-	 */
 	strbuf_reset(&response_line);
-	for (;;) {
-		char buf[1];
-		if (xread(REPORT_FILENO, buf, 1) < 0) {
-			error("cannot read cat-blob result: %s", strerror(errno));
-			return NULL;
-		}
-		if (*buf == '\n')
-			return response_line.buf;
-		strbuf_addch(&response_line, *buf);
-	}
+	if (fd_read_line(&response_line, REPORT_FILENO))
+		return NULL;
+	return response_line.buf;
 }
 
-static int copy_bytes(FILE *out, size_t len)
+static int copy_bytes(FILE *out, off_t len)
 {
-	char buf[4096];
-	ssize_t nread;
-	for (; len; len -= nread) {
-		nread = xread(REPORT_FILENO, buf,
-					len < sizeof(buf) ? len : sizeof(buf));
-		if (nread < 0)
-			return error("cannot copy cat-blob result: %s",
-					strerror(errno));
-		if (!nread)
-			return error("0-length read...");
-		if (fwrite(buf, 1, nread, out) != nread)
-			return error("cannot write cat-blob results: %s",
-					strerror(errno));
-	}
+	off_t ret = fd_copy_bytes(out, REPORT_FILENO, len);
+	if (!ret)
+		return error("read error: file ends early");
+	if (ret <= 0)
+		return error("cannot copy cat-blob result");
+	return 0;
 }
 
 static int fast_export_save_blob(FILE *out)
 {
-	size_t len = len;
+	off_t len = len;
 	const char *header, *tail;
 
 	header = get_response_line();
diff --git a/vcs-svn/fd_buffer.c b/vcs-svn/fd_buffer.c
new file mode 100644
index 0000000..3d2c1a1
--- /dev/null
+++ b/vcs-svn/fd_buffer.c
@@ -0,0 +1,65 @@
+/*
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "git-compat-util.h"
+#include "fd_buffer.h"
+#include "strbuf.h"
+
+/* Read a line without trailing newline. */
+int fd_read_line(struct strbuf *line, int fd)
+{
+	/*
+	 * NEEDSWORK: Does not actually need to read one byte at a time.
+	 * Some platforms have O_NONBLOCK.  On others we could read
+	 * several chars at a time until an appearance of a string known
+	 * to belong in the line (e.g., " blob ").
+	 */
+	for (;;) {
+		char buf[1];
+		if (xread(fd, buf, 1) < 0)
+			return error("cannot read line: %s", strerror(errno));
+		if (*buf == '\n')
+			return 0;
+		strbuf_addch(line, *buf);
+	}
+}
+
+int fd_read_binary(struct strbuf *buf, size_t len, int fd)
+{
+	char *p, *end;
+	strbuf_grow(buf, len);
+	p = buf->buf + buf->len;
+	end = p + len;
+
+	while (p != end) {
+		ssize_t nread = xread(fd, p, end - p);
+		if (nread < 0)
+			return error("read error: %s", strerror(errno));
+		if (!nread)	/* end of file */
+			break;
+		p += nread;
+	}
+	strbuf_setlen(buf, p - buf->buf);
+	return 0;
+}
+
+off_t fd_copy_bytes(FILE *out, int fd, off_t len)
+{
+	off_t total = 0;
+	while (len) {
+		char buf[4096];
+		ssize_t nread = xread(fd, buf,
+					len < sizeof(buf) ? len : sizeof(buf));
+		if (nread < 0)
+			return error("read error: %s", strerror(errno));
+		if (!nread)
+			return 0;
+		if (out && fwrite(buf, 1, nread, out) != nread)
+			return error("write error: %s", strerror(errno));
+		total += nread;
+		len -= nread;
+	}
+	return total;
+}
diff --git a/vcs-svn/fd_buffer.h b/vcs-svn/fd_buffer.h
new file mode 100644
index 0000000..9434ac3
--- /dev/null
+++ b/vcs-svn/fd_buffer.h
@@ -0,0 +1,19 @@
+#ifndef FD_BUFFER_H
+#define FD_BUFFER_H
+
+#include "strbuf.h"
+
+/* Low-level input helpers.  Usually line_buffer is a better choice. */
+
+extern int fd_read_line(struct strbuf *line, int fd);
+extern int fd_read_binary(struct strbuf *buf, size_t len, int fd);
+
+/* returns 0 for end of file */
+extern off_t fd_copy_bytes(FILE *out, int fd, off_t len);
+
+static inline off_t fd_skip_bytes(int fd, off_t len)
+{
+	return fd_copy_bytes(NULL, fd, len);
+}
+
+#endif
-- 
1.7.2.3
