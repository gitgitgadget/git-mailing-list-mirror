From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/5] vcs-svn: Start working on the dumpfile producer
Date: Wed, 19 Jan 2011 11:14:56 +0530
Message-ID: <1295415899-1192-3-git-send-email-artagnon@gmail.com>
References: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 19 06:44:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfQqX-0001OM-2D
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 06:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406Ab1ASFoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 00:44:22 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46341 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab1ASFoV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 00:44:21 -0500
Received: by mail-yw0-f46.google.com with SMTP id 5so127820ywl.19
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 21:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=pSR983JZew+9fIbBQigX/WnKA7MDuqBxlkr1v7XGsYI=;
        b=XKyjpMwknjXZJhhHyiAXra5xeMAxaeBILoUBbvkcUlsPaopv/u7Vu6v7Tyt/vUrY/B
         DoNk64XmOo2kY/sSMu1U8yzLRULKw84U+Jn4EkWZ49nKrNPxwVNJR/kmAk4/7V5EPXnN
         QRX6QIhwkjSdwCu7d7gVAWVez7AKdJ5aefKWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oONpCOkrgbQPZVWdya27Jsj4xxHK4a1Lwc6uOjrEOzphZsUU1fRH9u6a/jColKpkuy
         2GlvEHCHiEHyNS/rJt5lefpUOKsJy4Q/m3EzXZJtSKAU8zNuwF75qJViwAUE4SrIAqWE
         MyY68KVHMSVOt4aFIJHo2NlPhoWmeX9KWWu7U=
Received: by 10.91.153.10 with SMTP id f10mr378071ago.172.1295415861081;
        Tue, 18 Jan 2011 21:44:21 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d15sm7968646ana.35.2011.01.18.21.44.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Jan 2011 21:44:20 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165239>

Start off with some broad design sketches. Compile succeeds, but
parser is incorrect. Include a Makefile rule to build it into
vcs-svn/lib.a.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile              |    2 +-
 vcs-svn/dump_export.c |   73 ++++++++++++
 vcs-svn/svnload.c     |  294 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 368 insertions(+), 1 deletions(-)
 create mode 100644 vcs-svn/dump_export.c
 create mode 100644 vcs-svn/svnload.c

diff --git a/Makefile b/Makefile
index 1345c38..40f6691 100644
--- a/Makefile
+++ b/Makefile
@@ -1834,7 +1834,7 @@ ifndef NO_CURL
 endif
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
-VCSSVN_OBJS = vcs-svn/line_buffer.o \
+VCSSVN_OBJS = vcs-svn/line_buffer.o vcs-svn/svnload.o vcs-svn/dump_export.o \
 	vcs-svn/repo_tree.o vcs-svn/fast_export.o vcs-svn/sliding_window.o \
 	vcs-svn/svndiff.o vcs-svn/svndump.o
 VCSSVN_TEST_OBJS = test-obj-pool.o \
diff --git a/vcs-svn/dump_export.c b/vcs-svn/dump_export.c
new file mode 100644
index 0000000..04ede06
--- /dev/null
+++ b/vcs-svn/dump_export.c
@@ -0,0 +1,73 @@
+/*
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "git-compat-util.h"
+#include "strbuf.h"
+#include "line_buffer.h"
+#include "dump_export.h"
+
+void dump_export_begin_rev(int revision, const char *revprops,
+			int prop_len) {
+	printf("Revision-number: %d\n", revision);
+	printf("Prop-content-length: %d\n", prop_len);
+	printf("Content-length: %d\n\n", prop_len);
+	printf("%s\n", revprops);
+}
+
+void dump_export_node(const char *path, enum node_kind kind,
+		enum node_action action, unsigned long text_len,
+		unsigned long copyfrom_rev, const char *copyfrom_path) {
+	printf("Node-path: %s\n", path);
+	printf("Node-kind: ");
+	switch (action) {
+	case NODE_KIND_NORMAL:
+		printf("file\n");
+		break;
+	case NODE_KIND_EXECUTABLE:
+		printf("file\n");
+		break;
+	case NODE_KIND_SYMLINK:
+		printf("file\n");
+		break;
+	case NODE_KIND_GITLINK:
+		printf("file\n");
+		break;
+	case NODE_KIND_SUBDIR:
+		die("Unsupported: subdirectory");
+	default:
+		break;
+	}
+	printf("Node-action: ");
+	switch (action) {
+	case NODE_ACTION_CHANGE:
+		printf("change\n");
+		break;
+	case NODE_ACTION_ADD:
+		printf("add\n");
+		break;
+	case NODE_ACTION_REPLACE:
+		printf("replace\n");
+		break;
+	case NODE_ACTION_DELETE:
+		printf("delete\n");
+		break;
+	default:
+		break;
+	}
+	if (copyfrom_rev != SVN_INVALID_REV) {
+		printf("Node-copyfrom-rev: %lu\n", copyfrom_rev);
+		printf("Node-copyfrom-path: %s\n", copyfrom_path);
+	}
+	printf("Prop-delta: false\n");
+	printf("Prop-content-length: 10\n"); /* Constant 10 for "PROPS-END" */
+	printf("Text-delta: false\n");
+	printf("Text-content-length: %lu\n", text_len);
+	printf("Content-length: %lu\n\n", text_len + 10);
+	printf("PROPS-END\n\n");
+}
+
+void dump_export_text(struct line_buffer *data, off_t len) {
+	buffer_copy_bytes(data, len);
+}
diff --git a/vcs-svn/svnload.c b/vcs-svn/svnload.c
new file mode 100644
index 0000000..7043ae7
--- /dev/null
+++ b/vcs-svn/svnload.c
@@ -0,0 +1,294 @@
+/*
+ * Produce a dumpfile v3 from a fast-import stream.
+ * Load the dump into the SVN repository with:
+ * svnrdump load <URL> <dumpfile
+ *
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "cache.h"
+#include "git-compat-util.h"
+#include "line_buffer.h"
+#include "dump_export.h"
+#include "strbuf.h"
+
+#define SVN_DATE_FORMAT "%Y-%m-%dT%H:%M:%S.000000Z"
+#define SVN_DATE_LEN 28
+#define LENGTH_UNKNOWN (~0)
+
+static struct line_buffer input = LINE_BUFFER_INIT;
+static struct strbuf blobs[100];
+	
+static struct {
+	unsigned long prop_len, text_len, copyfrom_rev, mark;
+	int text_delta, prop_delta; /* Boolean */
+	enum node_action action;
+	enum node_kind kind;
+	struct strbuf copyfrom_path, path;
+} node_ctx;
+
+static struct {
+	int rev, text_len;
+	struct strbuf props, log;
+	struct strbuf svn_author, author, committer;
+	struct strbuf author_date, committer_date;
+	struct strbuf author_email, committer_email;
+} rev_ctx;
+
+static enum {
+	UNKNOWN_CTX,
+	COMMIT_CTX,
+	BLOB_CTX
+} active_ctx;
+
+static void reset_rev_ctx(int revision)
+{
+	rev_ctx.rev = revision;
+	strbuf_reset(&rev_ctx.props);
+	strbuf_reset(&rev_ctx.log);
+	strbuf_reset(&rev_ctx.svn_author);
+	strbuf_reset(&rev_ctx.author);
+	strbuf_reset(&rev_ctx.committer);
+	strbuf_reset(&rev_ctx.author_date);
+	strbuf_reset(&rev_ctx.committer_date);
+	strbuf_reset(&rev_ctx.author_email);
+	strbuf_reset(&rev_ctx.committer_email);
+}
+
+static void reset_node_ctx(void)
+{
+	node_ctx.prop_len = LENGTH_UNKNOWN;
+	node_ctx.text_len = LENGTH_UNKNOWN;
+	node_ctx.mark = 0;
+	node_ctx.copyfrom_rev = 0;
+	node_ctx.text_delta = -1;
+	node_ctx.prop_delta = -1;
+	strbuf_reset(&node_ctx.copyfrom_path);
+	strbuf_reset(&node_ctx.path);
+}
+
+static void populate_props(struct strbuf *props, const char *author,
+			const char *log, const char *date) {
+	strbuf_reset(props);	
+	strbuf_addf(props, "K\nsvn:author\nV\n%s\n", author);
+	strbuf_addf(props, "K\nsvn:log\nV\n%s", log);
+	strbuf_addf(props, "K\nsvn:date\nV\n%s\n", date);
+	strbuf_add(props, "PROPS-END\n", 10);
+}
+
+static void parse_author_line(char *val, struct strbuf *name,
+			struct strbuf *email, struct strbuf *date) {
+	char *t, *tz_off;
+	char time_buf[SVN_DATE_LEN];
+	const struct tm *tm_time;
+
+	/* Simon Hausmann <shausman@trolltech.com> 1170199019 +0100 */
+	strbuf_reset(name);
+	strbuf_reset(email);
+	strbuf_reset(date);
+	tz_off = strrchr(val, ' ');
+	*tz_off++ = '\0';
+	t = strrchr(val, ' ');
+	*(t - 1) = '\0'; /* Ignore '>' from email */
+	t ++;
+	tm_time = time_to_tm(strtoul(t, NULL, 10), atoi(tz_off));
+	strftime(time_buf, SVN_DATE_LEN, SVN_DATE_FORMAT, tm_time);
+	strbuf_add(date, time_buf, SVN_DATE_LEN);
+	t = strchr(val, '<');
+	*(t - 1) = '\0'; /* Ignore ' <' from email */
+	t ++;
+	strbuf_add(email, t, strlen(t));
+	strbuf_add(name, val, strlen(val));
+}
+
+void svnload_read(void) {
+	char *t, *val;
+	int mode_incr;
+	struct strbuf *to_dump;
+
+	while ((t = buffer_read_line(&input))) {
+		val = strchr(t, ' ');
+		if (!val) {
+			if (!memcmp(t, "blob", 4))
+				active_ctx = BLOB_CTX;
+			else if (!memcmp(t, "deleteall", 9))
+				;
+			continue;
+		}
+		*val++ = '\0';
+
+		/* strlen(key) */
+		switch (val - t - 1) {
+		case 1:
+			if (!memcmp(t, "D", 1)) {
+				node_ctx.action = NODE_ACTION_DELETE;
+			}
+			else if (!memcmp(t, "C", 1)) {
+				node_ctx.action = NODE_ACTION_ADD;
+			}
+			else if (!memcmp(t, "R", 1)) {
+				node_ctx.action = NODE_ACTION_REPLACE;
+			}
+			else if (!memcmp(t, "M", 1)) {
+				node_ctx.action = NODE_ACTION_CHANGE;
+				mode_incr = 7;
+				if (!memcmp(val, "100644", 6))
+					node_ctx.kind = NODE_KIND_NORMAL;
+				else if (!memcmp(val, "100755", 6))
+					node_ctx.kind = NODE_KIND_EXECUTABLE;
+				else if (!memcmp(val, "120000", 6))
+					node_ctx.kind = NODE_KIND_SYMLINK;
+				else if (!memcmp(val, "160000", 6))
+					node_ctx.kind = NODE_KIND_GITLINK;
+				else if (!memcmp(val, "040000", 6))
+					node_ctx.kind = NODE_KIND_SUBDIR;
+				else {
+					if (!memcmp(val, "755", 3))
+						node_ctx.kind = NODE_KIND_EXECUTABLE;
+					else if(!memcmp(val, "644", 3))
+						node_ctx.kind = NODE_KIND_NORMAL;
+					else
+						die("Unrecognized mode: %s", val);
+					mode_incr = 4;
+				}
+				val += mode_incr;
+				t = strchr(val, ' ');
+				*t++ = '\0';
+				strbuf_reset(&node_ctx.path);
+				strbuf_add(&node_ctx.path, t, strlen(t));
+				if (!memcmp(val + 1, "inline", 6))
+					die("Unsupported dataref: inline");
+				else if (*val == ':')
+					to_dump = &blobs[strtoul(val + 1, NULL, 10)];
+				else
+					die("Unsupported dataref: sha1");
+				dump_export_node(node_ctx.path.buf, node_ctx.kind,
+						node_ctx.action, to_dump->len,
+						0, NULL);
+				printf("%s", to_dump->buf);
+			}
+			break;
+		case 3:
+			if (!memcmp(t, "tag", 3))
+				continue;
+			break;
+		case 4:
+			if (!memcmp(t, "mark", 4))
+				switch(active_ctx) {
+				case COMMIT_CTX:
+					/* What do we do with commit marks? */
+					continue;
+				case BLOB_CTX:
+					node_ctx.mark = strtoul(val + 1, NULL, 10);
+					break;
+				default:
+					break;
+				}
+			else if (!memcmp(t, "from", 4))
+				continue;
+			else if (!memcmp(t, "data", 4)) {
+				switch (active_ctx) {
+				case COMMIT_CTX:
+					strbuf_reset(&rev_ctx.log);
+					buffer_read_binary(&input,
+							&rev_ctx.log,
+							strtoul(val, NULL, 10));
+					populate_props(&rev_ctx.props,
+						rev_ctx.svn_author.buf,
+						rev_ctx.log.buf,
+						rev_ctx.author_date.buf);
+					dump_export_begin_rev(rev_ctx.rev,
+							rev_ctx.props.buf,
+							rev_ctx.props.len);
+					break;
+				case BLOB_CTX:
+					node_ctx.text_len = strtoul(val, NULL, 10);
+					buffer_read_binary(&input,
+							&blobs[node_ctx.mark],
+							node_ctx.text_len);
+					break;
+				default:
+					break;
+				}
+			}
+			break;
+		case 5:
+			if (!memcmp(t, "reset", 5))
+				continue;
+			if (!memcmp(t, "merge", 5))
+				continue;
+			break;
+		case 6:
+			if (!memcmp(t, "author", 6)) {
+				parse_author_line(val, &rev_ctx.author,
+						&rev_ctx.author_email,
+						&rev_ctx.author_date);
+				/* Build svn_author */
+				t = strchr(rev_ctx.author_email.buf, '@');
+				strbuf_reset(&rev_ctx.svn_author);
+				strbuf_add(&rev_ctx.svn_author,
+					rev_ctx.author_email.buf,
+					t - rev_ctx.author_email.buf);
+
+			}
+			else if (!memcmp(t, "commit", 6)) {
+				rev_ctx.rev ++;
+				active_ctx = COMMIT_CTX;
+			}
+			break;
+		case 9:
+			if (!memcmp(t, "committer", 9))
+				parse_author_line(val, &rev_ctx.committer,
+						&rev_ctx.committer_email,
+						&rev_ctx.committer_date);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+int svnload_init(const char *filename)
+{
+	int i;
+	if (buffer_init(&input, filename))
+		return error("cannot open %s: %s", filename, strerror(errno));
+	active_ctx = UNKNOWN_CTX;
+	strbuf_init(&rev_ctx.props, MAX_GITSVN_LINE_LEN);
+	strbuf_init(&rev_ctx.log, MAX_GITSVN_LINE_LEN);
+	strbuf_init(&rev_ctx.author, MAX_GITSVN_LINE_LEN);
+	strbuf_init(&rev_ctx.committer, MAX_GITSVN_LINE_LEN);
+	strbuf_init(&rev_ctx.author_date, MAX_GITSVN_LINE_LEN);
+	strbuf_init(&rev_ctx.committer_date, MAX_GITSVN_LINE_LEN);
+	strbuf_init(&rev_ctx.author_email, MAX_GITSVN_LINE_LEN);
+	strbuf_init(&rev_ctx.committer_email, MAX_GITSVN_LINE_LEN);
+	strbuf_init(&node_ctx.path, MAX_GITSVN_LINE_LEN);
+	strbuf_init(&node_ctx.copyfrom_path, MAX_GITSVN_LINE_LEN);
+	for (i = 0; i < 100; i ++)
+		strbuf_init(&blobs[i], 10000);
+	return 0;
+}
+
+void svnload_deinit(void)
+{
+	int i;
+	reset_rev_ctx(0);
+	reset_node_ctx();
+	strbuf_release(&rev_ctx.props);
+	strbuf_release(&rev_ctx.log);
+	strbuf_release(&rev_ctx.author);
+	strbuf_release(&rev_ctx.committer);
+	strbuf_release(&rev_ctx.author_date);
+	strbuf_release(&rev_ctx.committer_date);
+	strbuf_release(&rev_ctx.author_email);
+	strbuf_release(&rev_ctx.committer_email);
+	strbuf_release(&node_ctx.path);
+	strbuf_release(&node_ctx.copyfrom_path);
+	for (i = 0; i < 100; i ++)
+		strbuf_release(&blobs[i]);
+	if (buffer_deinit(&input))
+		fprintf(stderr, "Input error\n");
+	if (ferror(stdout))
+		fprintf(stderr, "Output error\n");
+}
-- 
1.7.4.rc1.7.g2cf08.dirty
