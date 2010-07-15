From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/8] Add stream helper library
Date: Thu, 15 Jul 2010 18:23:02 +0200
Message-ID: <1279210984-31604-7-git-send-email-artagnon@gmail.com>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 15 18:22:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZRCM-0006nr-Ou
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 18:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933692Ab0GOQVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 12:21:39 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61019 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933679Ab0GOQVf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 12:21:35 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so286658ewy.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 09:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=EGO8bJl8r+oypqvxkhQ644lNk2Z1TFPqyJK58BroNUI=;
        b=wicK6gDeMMscl0RdpTHFSm0TcM5WCKZndD01BU50LuDfMGUcP1fOVKdtDDjSMwWwcp
         6PE88Awn1WHVXSn6bn9eZ/joxEySU5xkjqVfyAwhFIpGJXeKe/lquwMwtZ6IIo0aEXL0
         kz+NL4s5IG+3lvEU3SILZwz5rvh/1OqakE7S8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=D/5P6BmUC8JCfsrh2SGWE7q9xkMS2/oy5gNZsGfS0NmU/J5KEZpUvcBy40i02C4A6g
         hwfHCaM8/3rkLXVauTRdoYA44FaFemnrWQdDrGQP5ypOA2K+zrHFD43uQVn8vMuK4cAf
         un3/uYkJN55+MvT38jj5nZngBPUTc6oFwDxcc=
Received: by 10.213.22.18 with SMTP id l18mr2831979ebb.58.1279210894730;
        Thu, 15 Jul 2010 09:21:34 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id v8sm9349789eeh.20.2010.07.15.09.21.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 09:21:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151090>

From: David Barr <david.barr@cordelta.com>

This library provides thread-unsafe fgets()- and fread()-like
functions where the caller does not have to supply a buffer.  It
maintains a couple of static buffers and provides an API to use
them.

NEEDSWORK: what should buffer_copy_bytes do on error?

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile              |    5 ++-
 vcs-svn/line_buffer.c |   93 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/line_buffer.h |   14 +++++++
 3 files changed, 110 insertions(+), 2 deletions(-)
 create mode 100644 vcs-svn/line_buffer.c
 create mode 100644 vcs-svn/line_buffer.h

diff --git a/Makefile b/Makefile
index e11e588..8223d9b 100644
--- a/Makefile
+++ b/Makefile
@@ -1740,7 +1740,7 @@ ifndef NO_CURL
 endif
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
-VCSSVN_OBJS = vcs-svn/string_pool.o
+VCSSVN_OBJS = vcs-svn/string_pool.o vcs-svn/line_buffer.o
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
 
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
@@ -1864,7 +1864,8 @@ xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
 
 $(VCSSVN_OBJS): \
-	vcs-svn/obj_pool.h vcs-svn/trp.h vcs-svn/string_pool.h
+	vcs-svn/obj_pool.h vcs-svn/trp.h vcs-svn/string_pool.h \
+	vcs-svn/line_buffer.h
 endif
 
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
new file mode 100644
index 0000000..0f83426
--- /dev/null
+++ b/vcs-svn/line_buffer.c
@@ -0,0 +1,93 @@
+/*
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "git-compat-util.h"
+
+#include "line_buffer.h"
+#include "obj_pool.h"
+
+#define LINE_BUFFER_LEN 10000
+#define COPY_BUFFER_LEN 4096
+
+/* Create memory pool for char sequence of known length */
+obj_pool_gen(blob, char, 4096);
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
+int buffer_deinit()
+{
+	fclose(infile);
+	return 0;
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
+	while (len > 0 && !feof(infile)) {
+		in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
+		in = fread(byte_buffer, 1, in, infile);
+		len -= in;
+		fwrite(byte_buffer, 1, in, stdout);
+		if (ferror(infile) || ferror(stdout))
+			/* NEEDSWORK: handle error. */
+			break;
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
index 0000000..631d1df
--- /dev/null
+++ b/vcs-svn/line_buffer.h
@@ -0,0 +1,14 @@
+#ifndef LINE_BUFFER_H_
+#define LINE_BUFFER_H_
+
+#include "git-compat-util.h"
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
-- 
1.7.1
