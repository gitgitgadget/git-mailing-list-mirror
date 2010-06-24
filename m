From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/9] Add stream helper library
Date: Thu, 24 Jun 2010 06:01:12 -0500
Message-ID: <20100624110112.GF12376@burratino>
References: <20100624105004.GA12336@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 13:01:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORkBU-0005vH-Ev
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 13:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847Ab0FXLBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 07:01:23 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33992 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780Ab0FXLBW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 07:01:22 -0400
Received: by iwn41 with SMTP id 41so737230iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 04:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=EGO8bJl8r+oypqvxkhQ644lNk2Z1TFPqyJK58BroNUI=;
        b=RyAfTgP6ageR7EgVvf/qVsIizSAXDUHXozFXkQa6/D5LryK7QBf13oBLszKtALhWCR
         je4igN6Zk0E3Q9OAUOBcXtMfwpJqUb1sv7g7SG4RRQTCvjGatRJwytbv45ARFoEQN9Bf
         kmaTsqykzyz6QA06vX1mYtxh54LJf/xW1Ofww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CcNv6vOeSu7280xOKgpxFLYj3MbS5kPnYGVFNR/J/Qgx79A5l7NWj8PatvcC+ewXdM
         UfOHTyiEdSHNVOdKi1fbvd/5UE7XFGgf/RYvatBviMwIYyQpw2yCkBCtBcTcuIgqpEj+
         pfbJ1O1x2B9SvL2VHHvuW3pOGqCnBhMif8dSk=
Received: by 10.231.150.15 with SMTP id w15mr10571406ibv.115.1277377281625;
        Thu, 24 Jun 2010 04:01:21 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r12sm17458362ibi.2.2010.06.24.04.01.20
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 04:01:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100624105004.GA12336@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149577>

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
