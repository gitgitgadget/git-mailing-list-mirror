From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/9] Add SVN dump parser
Date: Thu, 24 Jun 2010 06:03:25 -0500
Message-ID: <20100624110325.GH12376@burratino>
References: <20100624105004.GA12336@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 13:03:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORkDe-0006qF-AK
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 13:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754872Ab0FXLDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 07:03:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47860 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780Ab0FXLDf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 07:03:35 -0400
Received: by iwn41 with SMTP id 41so738817iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 04:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7d4NA1LEW4AX0GS1Uwj6eV4HsgpqMxSXhQNdRW7A5Wo=;
        b=ey941cXPX1GjczY/hsLl/h6OtPJxdtC03kh78nkzpq2g07cbH92F0k9ODK6drXpDtR
         UOO0riCbIpPOpFZjLKZXy0gGcHFr4C7FLtGQPgUuCjkLHFq+jqgLn0o9nPtIbD7WzdyY
         RU0sig8qd+NlT2d8/3Nv0qHH/HO3RLw4ZINHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lCXEaTvRom6wxW38tusSNpGnJ83zNFWU8m2I6g5TQ9XTQv+uBI3RH5HGxlkA33j+6+
         FWoK1qscH3ketM8pDUxBPqJ1tTqB8TNazuf9/t5ENMiPA6OqtZ9tp8NkgfI7vXhiPJeO
         3AE7fHgbfU+WLxQ+bdMD5OY3gK8IgS4yyCw2c=
Received: by 10.231.79.67 with SMTP id o3mr7108012ibk.132.1277377414449;
        Thu, 24 Jun 2010 04:03:34 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r12sm17236937ibi.14.2010.06.24.04.03.33
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 04:03:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100624105004.GA12336@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149579>

From: David Barr <david.barr@cordelta.com>

svndump parses data that is in SVN dumpfile format produced by
`svnadmin dump` with the help of line_buffer and uses repo_tree and
fast_export to emit a git fast-import stream.

Based roughly on com.hydrografix.svndump 0.92 from the SvnToCCase
project at <http://svn2cc.sarovar.org/>, by Stefan Hegny and
others.

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile          |    5 +-
 vcs-svn/LICENSE   |    4 +
 vcs-svn/svndump.c |  289 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/svndump.h |    8 ++
 4 files changed, 304 insertions(+), 2 deletions(-)
 create mode 100644 vcs-svn/svndump.c
 create mode 100644 vcs-svn/svndump.h

diff --git a/Makefile b/Makefile
index 7c66dcc..e7b37e0 100644
--- a/Makefile
+++ b/Makefile
@@ -1741,7 +1741,7 @@ endif
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
 VCSSVN_OBJS = vcs-svn/string_pool.o vcs-svn/line_buffer.o \
-	vcs-svn/repo_tree.o vcs-svn/fast_export.o
+	vcs-svn/repo_tree.o vcs-svn/fast_export.o vcs-svn/svndump.o
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
 
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
@@ -1866,7 +1866,8 @@ xdiff-interface.o $(XDIFF_OBJS): \
 
 $(VCSSVN_OBJS): \
 	vcs-svn/obj_pool.h vcs-svn/trp.h vcs-svn/string_pool.h \
-	vcs-svn/line_buffer.h vcs-svn/repo_tree.h vcs-svn/fast_export.h
+	vcs-svn/line_buffer.h vcs-svn/repo_tree.h vcs-svn/fast_export.h \
+	vcs-svn/svndump.h
 endif
 
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
diff --git a/vcs-svn/LICENSE b/vcs-svn/LICENSE
index a3d384c..0a5e3c4 100644
--- a/vcs-svn/LICENSE
+++ b/vcs-svn/LICENSE
@@ -4,6 +4,10 @@ All rights reserved.
 Copyright (C) 2008 Jason Evans <jasone@canonware.com>.
 All rights reserved.
 
+Copyright (C) 2005 Stefan Hegny, hydrografix Consulting GmbH,
+Frankfurt/Main, Germany
+and others, see http://svn2cc.sarovar.org
+
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
new file mode 100644
index 0000000..86714ed
--- /dev/null
+++ b/vcs-svn/svndump.c
@@ -0,0 +1,289 @@
+/*
+ * Parse and rearrange a svnadmin dump.
+ * Create the dump with:
+ * svnadmin dump --incremental -r<startrev>:<endrev> <repository> >outfile
+ *
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "cache.h"
+#include "repo_tree.h"
+#include "fast_export.h"
+#include "line_buffer.h"
+#include "obj_pool.h"
+#include "string_pool.h"
+
+#define NODEACT_REPLACE 4
+#define NODEACT_DELETE 3
+#define NODEACT_ADD 2
+#define NODEACT_CHANGE 1
+#define NODEACT_UNKNOWN 0
+
+#define DUMP_CTX 0
+#define REV_CTX  1
+#define NODE_CTX 2
+
+#define LENGTH_UNKNOWN (~0)
+#define DATE_RFC2822_LEN 31
+
+/* Create memory pool for log messages */
+obj_pool_gen(log, char, 4096);
+
+static char* log_copy(uint32_t length, char *log)
+{
+	char *buffer;
+	log_free(log_pool.size);
+	buffer = log_pointer(log_alloc(length));
+	strncpy(buffer, log, length);
+	return buffer;
+}
+
+static struct {
+	uint32_t action, propLength, textLength, srcRev, srcMode, mark, type;
+	uint32_t src[REPO_MAX_PATH_DEPTH], dst[REPO_MAX_PATH_DEPTH];
+} node_ctx;
+
+static struct {
+	uint32_t revision, author;
+	unsigned long timestamp;
+	char *log;
+} rev_ctx;
+
+static struct {
+	uint32_t uuid, url;
+} dump_ctx;
+
+static struct {
+	uint32_t svn_log, svn_author, svn_date, svn_executable, svn_special, uuid,
+		revision_number, node_path, node_kind, node_action,
+		node_copyfrom_path, node_copyfrom_rev, text_content_length,
+		prop_content_length, content_length;
+} keys;
+
+static void reset_node_ctx(char *fname)
+{
+	node_ctx.type = 0;
+	node_ctx.action = NODEACT_UNKNOWN;
+	node_ctx.propLength = LENGTH_UNKNOWN;
+	node_ctx.textLength = LENGTH_UNKNOWN;
+	node_ctx.src[0] = ~0;
+	node_ctx.srcRev = 0;
+	node_ctx.srcMode = 0;
+	pool_tok_seq(REPO_MAX_PATH_DEPTH, node_ctx.dst, "/", fname);
+	node_ctx.mark = 0;
+}
+
+static void reset_rev_ctx(uint32_t revision)
+{
+	rev_ctx.revision = revision;
+	rev_ctx.timestamp = 0;
+	rev_ctx.log = NULL;
+	rev_ctx.author = ~0;
+}
+
+static void reset_dump_ctx(uint32_t url)
+{
+	dump_ctx.url = url;
+	dump_ctx.uuid = ~0;
+}
+
+static void init_keys(void)
+{
+	keys.svn_log = pool_intern("svn:log");
+	keys.svn_author = pool_intern("svn:author");
+	keys.svn_date = pool_intern("svn:date");
+	keys.svn_executable = pool_intern("svn:executable");
+	keys.svn_special = pool_intern("svn:special");
+	keys.uuid = pool_intern("UUID");
+	keys.revision_number = pool_intern("Revision-number");
+	keys.node_path = pool_intern("Node-path");
+	keys.node_kind = pool_intern("Node-kind");
+	keys.node_action = pool_intern("Node-action");
+	keys.node_copyfrom_path = pool_intern("Node-copyfrom-path");
+	keys.node_copyfrom_rev = pool_intern("Node-copyfrom-rev");
+	keys.text_content_length = pool_intern("Text-content-length");
+	keys.prop_content_length = pool_intern("Prop-content-length");
+	keys.content_length = pool_intern("Content-length");
+}
+
+static void read_props(void)
+{
+	uint32_t len;
+	uint32_t key = ~0;
+	char *val = NULL;
+	char *t;
+	while ((t = buffer_read_line()) && strcmp(t, "PROPS-END")) {
+		if (!strncmp(t, "K ", 2)) {
+			len = atoi(&t[2]);
+			key = pool_intern(buffer_read_string(len));
+			buffer_read_line();
+		} else if (!strncmp(t, "V ", 2)) {
+			len = atoi(&t[2]);
+			val = buffer_read_string(len);
+			if (key == keys.svn_log) {
+				/* Value length excludes terminating nul. */
+				rev_ctx.log = log_copy(len + 1, val);
+			} else if (key == keys.svn_author) {
+				rev_ctx.author = pool_intern(val);
+			} else if (key == keys.svn_date) {
+				if (parse_date_basic(val, &rev_ctx.timestamp, NULL))
+					fprintf(stderr, "Invalid timestamp: %s\n", val);
+			} else if (key == keys.svn_executable) {
+				node_ctx.type = REPO_MODE_EXE;
+			} else if (key == keys.svn_special) {
+				node_ctx.type = REPO_MODE_LNK;
+			}
+			key = ~0;
+			buffer_read_line();
+		}
+	}
+}
+
+static void handle_node(void)
+{
+	if (node_ctx.propLength != LENGTH_UNKNOWN && node_ctx.propLength)
+		read_props();
+
+	if (node_ctx.srcRev)
+		node_ctx.srcMode = repo_copy(node_ctx.srcRev, node_ctx.src, node_ctx.dst);
+
+	if (node_ctx.textLength != LENGTH_UNKNOWN &&
+	    node_ctx.type != REPO_MODE_DIR)
+		node_ctx.mark = next_blob_mark();
+
+	if (node_ctx.action == NODEACT_DELETE) {
+		repo_delete(node_ctx.dst);
+	} else if (node_ctx.action == NODEACT_CHANGE ||
+			   node_ctx.action == NODEACT_REPLACE) {
+		if (node_ctx.action == NODEACT_REPLACE &&
+		    node_ctx.type == REPO_MODE_DIR)
+			repo_replace(node_ctx.dst, node_ctx.mark);
+		else if (node_ctx.propLength != LENGTH_UNKNOWN)
+			repo_modify(node_ctx.dst, node_ctx.type, node_ctx.mark);
+		else if (node_ctx.textLength != LENGTH_UNKNOWN)
+			node_ctx.srcMode = repo_replace(node_ctx.dst, node_ctx.mark);
+	} else if (node_ctx.action == NODEACT_ADD) {
+		if (node_ctx.srcRev && node_ctx.propLength != LENGTH_UNKNOWN)
+			repo_modify(node_ctx.dst, node_ctx.type, node_ctx.mark);
+		else if (node_ctx.srcRev && node_ctx.textLength != LENGTH_UNKNOWN)
+			node_ctx.srcMode = repo_replace(node_ctx.dst, node_ctx.mark);
+		else if ((node_ctx.type == REPO_MODE_DIR && !node_ctx.srcRev) ||
+		         node_ctx.textLength != LENGTH_UNKNOWN)
+			repo_add(node_ctx.dst, node_ctx.type, node_ctx.mark);
+	}
+
+	if (node_ctx.propLength == LENGTH_UNKNOWN && node_ctx.srcMode)
+		node_ctx.type = node_ctx.srcMode;
+
+	if (node_ctx.mark)
+		fast_export_blob(node_ctx.type, node_ctx.mark, node_ctx.textLength);
+	else if (node_ctx.textLength != LENGTH_UNKNOWN)
+		buffer_skip_bytes(node_ctx.textLength);
+}
+
+static void handle_revision(void)
+{
+	if (rev_ctx.revision)
+		repo_commit(rev_ctx.revision, rev_ctx.author, rev_ctx.log,
+			dump_ctx.uuid, dump_ctx.url, rev_ctx.timestamp);
+}
+
+void svndump_read(char *url)
+{
+	char *val;
+	char *t;
+	uint32_t active_ctx = DUMP_CTX;
+	uint32_t len;
+	uint32_t key;
+
+	reset_dump_ctx(pool_intern(url));
+	while ((t = buffer_read_line())) {
+		val = strstr(t, ": ");
+		if (!val)
+			continue;
+		*val++ = '\0';
+		*val++ = '\0';
+		key = pool_intern(t);
+
+		if (key == keys.uuid) {
+			dump_ctx.uuid = pool_intern(val);
+		} else if (key == keys.revision_number) {
+			if (active_ctx == NODE_CTX)
+				handle_node();
+			if (active_ctx != DUMP_CTX)
+				handle_revision();
+			active_ctx = REV_CTX;
+			reset_rev_ctx(atoi(val));
+		} else if (key == keys.node_path) {
+			if (active_ctx == NODE_CTX)
+				handle_node();
+			active_ctx = NODE_CTX;
+			reset_node_ctx(val);
+		} else if (key == keys.node_kind) {
+			if (!strcmp(val, "dir"))
+				node_ctx.type = REPO_MODE_DIR;
+			else if (!strcmp(val, "file"))
+				node_ctx.type = REPO_MODE_BLB;
+			else
+				fprintf(stderr, "Unknown node-kind: %s\n", val);
+		} else if (key == keys.node_action) {
+			if (!strcmp(val, "delete")) {
+				node_ctx.action = NODEACT_DELETE;
+			} else if (!strcmp(val, "add")) {
+				node_ctx.action = NODEACT_ADD;
+			} else if (!strcmp(val, "change")) {
+				node_ctx.action = NODEACT_CHANGE;
+			} else if (!strcmp(val, "replace")) {
+				node_ctx.action = NODEACT_REPLACE;
+			} else {
+				fprintf(stderr, "Unknown node-action: %s\n", val);
+				node_ctx.action = NODEACT_UNKNOWN;
+			}
+		} else if (key == keys.node_copyfrom_path) {
+			pool_tok_seq(REPO_MAX_PATH_DEPTH, node_ctx.src, "/", val);
+		} else if (key == keys.node_copyfrom_rev) {
+			node_ctx.srcRev = atoi(val);
+		} else if (key == keys.text_content_length) {
+			node_ctx.textLength = atoi(val);
+		} else if (key == keys.prop_content_length) {
+			node_ctx.propLength = atoi(val);
+		} else if (key == keys.content_length) {
+			len = atoi(val);
+			buffer_read_line();
+			if (active_ctx == REV_CTX) {
+				read_props();
+			} else if (active_ctx == NODE_CTX) {
+				handle_node();
+				active_ctx = REV_CTX;
+			} else {
+				fprintf(stderr, "Unexpected content length header: %d\n", len);
+				buffer_skip_bytes(len);
+			}
+		}
+	}
+	if (active_ctx == NODE_CTX)
+		handle_node();
+	if (active_ctx != DUMP_CTX)
+		handle_revision();
+}
+
+void svndump_init(const char *filename)
+{
+	buffer_init(filename);
+	repo_init();
+	reset_dump_ctx(~0);
+	reset_rev_ctx(0);
+	reset_node_ctx(NULL);
+	init_keys();
+}
+
+void svndump_reset(void)
+{
+	log_reset();
+	buffer_reset();
+	repo_reset();
+	reset_dump_ctx(~0);
+	reset_rev_ctx(0);
+	reset_node_ctx(NULL);
+}
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
new file mode 100644
index 0000000..38ad544
--- /dev/null
+++ b/vcs-svn/svndump.h
@@ -0,0 +1,8 @@
+#ifndef SVNDUMP_H_
+#define SVNDUMP_H_
+
+void svndump_init(const char *filename);
+void svndump_read(char *url);
+void svndump_reset(void);
+
+#endif
-- 
1.7.1
