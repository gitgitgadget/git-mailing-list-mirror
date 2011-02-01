From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] vcs-svn: Introduce svnload, a dumpfile producer
Date: Tue,  1 Feb 2011 19:56:41 +0530
Message-ID: <1296570403-9082-2-git-send-email-artagnon@gmail.com>
References: <1296570403-9082-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 01 15:26:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkHBe-0007hB-Ml
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 15:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757116Ab1BAO0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 09:26:13 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42421 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757105Ab1BAO0L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 09:26:11 -0500
Received: by yxt3 with SMTP id 3so2471334yxt.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 06:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=cEu6ZxIZtUFUp61VO25Q8YfwRFrIy5zYqVEAEJZkmzI=;
        b=raD9QALqbrQNZgA+lIPvftNPacm7QDJi8hHZuGkVr2z61jrTCfJirEdrjkZOhleWZn
         rMNuevz4yhesGei+cWtCgi5kSV2oZP5phmAnPYdF5OE89raJQ7Q0qf9gXqkT3fBWjnPU
         v2RVoNbo/4M4Mqykc8ZwH+V/s99xjxJmblSFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=R4mBeSLd+yDZ4y1xgSDX2J+Psq9tZ5tVmfNSoiUUOKGazfSpD4I3efvxOzzukMR+Mk
         6voWqCOtShYRSDNPmPo7S9o2J3odugOY6BOYmQaJl3iWAA3tH99+btCqQc2c+WreLKX+
         ygO08jLKA8w2O1MUev4iEwYmutHp4jl7O4p4w=
Received: by 10.151.114.21 with SMTP id r21mr2302452ybm.286.1296570369903;
        Tue, 01 Feb 2011 06:26:09 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id i36sm1494275yhd.27.2011.02.01.06.26.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 06:26:08 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1296570403-9082-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165809>

Design-wise, svnload resembles svndump. Include a Makefile rule to
build it into vcs-svn/lib.a.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile              |    4 +-
 vcs-svn/dir_cache.c   |   40 ++++++
 vcs-svn/dir_cache.h   |   12 ++
 vcs-svn/dump_export.c |  149 +++++++++++++++++++++++
 vcs-svn/dump_export.h |   33 +++++
 vcs-svn/svnload.c     |  322 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/svnload.h     |   10 ++
 7 files changed, 568 insertions(+), 2 deletions(-)
 create mode 100644 vcs-svn/dir_cache.c
 create mode 100644 vcs-svn/dir_cache.h
 create mode 100644 vcs-svn/dump_export.c
 create mode 100644 vcs-svn/dump_export.h
 create mode 100644 vcs-svn/svnload.c
 create mode 100644 vcs-svn/svnload.h

diff --git a/Makefile b/Makefile
index 1345c38..d9c2442 100644
--- a/Makefile
+++ b/Makefile
@@ -1834,9 +1834,9 @@ ifndef NO_CURL
 endif
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
-VCSSVN_OBJS = vcs-svn/line_buffer.o \
+VCSSVN_OBJS = vcs-svn/line_buffer.o vcs-svn/svnload.o vcs-svn/dump_export.o \
 	vcs-svn/repo_tree.o vcs-svn/fast_export.o vcs-svn/sliding_window.o \
-	vcs-svn/svndiff.o vcs-svn/svndump.o
+	vcs-svn/svndiff.o vcs-svn/svndump.o vcs-svn/dir_cache.o
 VCSSVN_TEST_OBJS = test-obj-pool.o \
 	test-line-buffer.o test-treap.o test-svn-fe.o
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
diff --git a/vcs-svn/dir_cache.c b/vcs-svn/dir_cache.c
new file mode 100644
index 0000000..9a608ce
--- /dev/null
+++ b/vcs-svn/dir_cache.c
@@ -0,0 +1,40 @@
+/*
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "git-compat-util.h"
+#include "string-list.h"
+#include "line_buffer.h"
+#include "dump_export.h"
+
+static struct string_list dirents = STRING_LIST_INIT_DUP;
+static struct string_list_item *dir = NULL;
+
+void dir_cache_add(const char *path, enum node_kind kind) {
+	dir = string_list_insert(&dirents, path);
+	dir->util = malloc(sizeof(enum node_kind));
+	*((enum node_kind *)(dir->util)) = kind;
+}
+
+void dir_cache_remove(const char *path) {
+	dir = string_list_lookup(&dirents, path);
+	if (dir)
+		*((enum node_kind *)(dir->util)) = NODE_KIND_UNKNOWN;
+}
+
+enum node_kind dir_cache_lookup(const char *path) {
+	dir = string_list_lookup(&dirents, path);
+	if (dir)
+		return *((enum node_kind *)(dir->util));
+	else
+		return NODE_KIND_UNKNOWN;
+}
+
+void dir_cache_init() {
+	return;
+}
+
+void dir_cache_deinit() {
+	string_list_clear(&dirents, 1);
+}
diff --git a/vcs-svn/dir_cache.h b/vcs-svn/dir_cache.h
new file mode 100644
index 0000000..43c3797
--- /dev/null
+++ b/vcs-svn/dir_cache.h
@@ -0,0 +1,12 @@
+#ifndef DIR_CACHE_H_
+#define DIR_CACHE_H_
+
+#include "dump_export.h"
+
+void dir_cache_add(const char *path, enum node_kind kind);
+void dir_cache_remove(const char *path);
+enum node_kind dir_cache_lookup(const char *path);
+void dir_cache_init();
+void dir_cache_deinit();
+
+#endif
diff --git a/vcs-svn/dump_export.c b/vcs-svn/dump_export.c
new file mode 100644
index 0000000..2b23f77
--- /dev/null
+++ b/vcs-svn/dump_export.c
@@ -0,0 +1,149 @@
+/*
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "git-compat-util.h"
+#include "strbuf.h"
+#include "line_buffer.h"
+#include "dump_export.h"
+#include "dir_cache.h"
+
+static struct strbuf props;
+
+void dump_export_begin_rev(int revision, const char *revprops,
+			int prop_len)
+{
+	printf("Revision-number: %d\n", revision);
+	printf("Prop-content-length: %d\n", prop_len);
+	printf("Content-length: %d\n\n", prop_len);
+	printf("%s\n", revprops);
+}
+
+void dump_export_node(const char *path, enum node_kind kind,
+		enum node_action action, unsigned long text_len,
+		unsigned long copyfrom_rev, const char *copyfrom_path)
+{
+	int dump_props = 1; /* Boolean */
+	strbuf_reset(&props);
+	printf("Node-path: %s\n", path);
+	switch (kind) {
+	case NODE_KIND_NORMAL:
+		printf("Node-kind: file\n");
+		break;
+	case NODE_KIND_EXECUTABLE:
+		printf("Node-kind: file\n");
+		strbuf_addf(&props, "K 14\nsvn:executable\nV 1\n*\n");
+		break;
+	case NODE_KIND_SYMLINK:
+		printf("Node-kind: file\n");
+		strbuf_addf(&props, "K 11\nsvn:special\nV 1\n*\n");
+		break;
+	case NODE_KIND_GITLINK:
+		printf("Node-kind: file\n");
+		break;
+	case NODE_KIND_DIR:
+		printf("Node-kind: dir\n");
+		break;
+	case NODE_KIND_SUBDIR:
+		die("Unsupported: subdirectory");
+	default:
+		break;
+	}
+	strbuf_add(&props, "PROPS-END\n", 10);
+
+	switch (action) {
+	case NODE_ACTION_CHANGE:
+		printf("Node-action: change\n");
+		break;
+	case NODE_ACTION_ADD:
+		printf("Node-action: add\n");
+		break;
+	case NODE_ACTION_REPLACE:
+		printf("Node-action: replace\n");
+		break;
+	case NODE_ACTION_DELETE:
+		printf("Node-action: delete\n");
+		dump_props = 0;
+		break;
+	default:
+		break;
+	}
+	if (copyfrom_rev != SVN_INVALID_REV) {
+		printf("Node-copyfrom-rev: %lu\n", copyfrom_rev);
+		printf("Node-copyfrom-path: %s\n", copyfrom_path);
+	}
+	if (dump_props) {
+		printf("Prop-delta: false\n");
+		printf("Prop-content-length: %lu\n", props.len);
+	}
+	if (text_len) {
+		printf("Text-delta: false\n");		
+		printf("Text-content-length: %lu\n", text_len);
+	}
+	if (text_len || dump_props) {
+		printf("Content-length: %lu\n\n", text_len + props.len);
+		printf("%s", props.buf);
+	}
+	if (!text_len)
+		printf("\n");
+}
+
+void dump_export_node_r(const char *path, enum node_kind kind,
+			enum node_action action, unsigned long text_len,
+			unsigned long copyfrom_rev, const char *copyfrom_path)
+{
+	char *start, *t;
+	start = (char *) path;
+
+	while ((t = strchr(start, '/'))) {
+			*t = '\0';
+			if (dir_cache_lookup(path) == NODE_KIND_UNKNOWN) {
+				dir_cache_add(path, NODE_KIND_NORMAL);
+				dump_export_node(path, NODE_KIND_DIR,
+						NODE_ACTION_ADD, 0,
+						SVN_INVALID_REV, NULL);
+			}
+			*t = '/';   /* Change it back */
+			start = t + 1;
+	}
+	switch (dir_cache_lookup(path)) {
+	case NODE_KIND_UNKNOWN:
+		action = NODE_ACTION_ADD;
+		break;
+	case NODE_KIND_SYMLINK:
+		dir_cache_remove(path);
+		dump_export_node(path, NODE_KIND_UNKNOWN,
+				NODE_ACTION_DELETE,
+				0, SVN_INVALID_REV, NULL);
+		action = NODE_ACTION_ADD;
+		break;
+	case NODE_KIND_DIR:
+		die("File was previously a directory?");
+		break;
+	case NODE_KIND_SUBDIR:
+		die("Subdirectories unsupported");
+		break;
+	default:
+		action = NODE_ACTION_CHANGE;
+		break;
+	}
+	dir_cache_add(path, kind);
+	dump_export_node(path, kind, action, text_len, copyfrom_rev, copyfrom_path);
+}
+
+void dump_export_text(struct line_buffer *data, off_t len)
+{
+	buffer_copy_bytes(data, len);
+}
+
+void dump_export_init()
+{
+	strbuf_init(&props, MAX_GITSVN_LINE_LEN);
+	printf("SVN-fs-dump-format-version: 3\n\n");
+}
+
+void dump_export_deinit()
+{
+	strbuf_release(&props);
+}
diff --git a/vcs-svn/dump_export.h b/vcs-svn/dump_export.h
new file mode 100644
index 0000000..e9f51a3
--- /dev/null
+++ b/vcs-svn/dump_export.h
@@ -0,0 +1,33 @@
+#ifndef DUMP_EXPORT_H_
+#define DUMP_EXPORT_H_
+
+#define MAX_GITSVN_LINE_LEN 4096
+#define SVN_INVALID_REV 0
+
+enum node_action {
+	NODE_ACTION_UNKNOWN,
+	NODE_ACTION_CHANGE,
+	NODE_ACTION_ADD,
+	NODE_ACTION_DELETE,
+	NODE_ACTION_REPLACE
+};
+
+enum node_kind {
+	NODE_KIND_UNKNOWN,       /* Missing node */
+	NODE_KIND_NORMAL,
+	NODE_KIND_EXECUTABLE,
+	NODE_KIND_SYMLINK,
+	NODE_KIND_GITLINK,
+	NODE_KIND_DIR,           /* SVN-specific */
+	NODE_KIND_SUBDIR
+};
+
+void dump_export_begin_rev(int revision, const char *revprops, int prop_len);
+void dump_export_text(struct line_buffer *data, off_t len);
+void dump_export_node_r(const char *path, enum node_kind kind,
+			enum node_action action, unsigned long text_len,
+			unsigned long copyfrom_rev, const char *copyfrom_path);
+void dump_export_init();
+void dump_export_deinit();
+
+#endif
diff --git a/vcs-svn/svnload.c b/vcs-svn/svnload.c
new file mode 100644
index 0000000..40fc1db
--- /dev/null
+++ b/vcs-svn/svnload.c
@@ -0,0 +1,322 @@
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
+#include "dir_cache.h"
+
+#define SVN_DATE_FORMAT "%Y-%m-%dT%H:%M:%S.000000Z"
+#define SVN_DATE_LEN 27
+#define LENGTH_UNKNOWN (~0)
+
+static struct line_buffer input = LINE_BUFFER_INIT;
+
+static struct {
+	unsigned long prop_len, text_len, copyfrom_rev;
+	int text_delta, prop_delta; /* false=0, true=1, unknown=-1 */
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
+static void populate_revprops(struct strbuf *props, size_t author_len,
+			const char *author, size_t log_len, const char *log,
+			size_t date_len, const char *date)
+{
+	strbuf_reset(props);
+	strbuf_addf(props, "K 10\nsvn:author\nV %lu\n%s\n", author_len, author);
+	strbuf_addf(props, "K 7\nsvn:log\nV %lu\n%s\n", log_len, log);
+	if (date_len)
+		/* SVN doesn't like an empty svn:date value */
+		strbuf_addf(props, "K 8\nsvn:date\nV %lu\n%s\n", date_len, date);
+	strbuf_add(props, "PROPS-END\n", 10);
+}
+
+static void parse_author_line(char *val, struct strbuf *name,
+			struct strbuf *email, struct strbuf *date)
+{
+	char *t, *tz_off;
+	char time_buf[SVN_DATE_LEN + 1];
+	int tz_off_buf;
+	const struct tm *tm_time;
+
+	/* Author Name <author@email.com> 1170199019 +0530 */
+	strbuf_reset(name);
+	strbuf_reset(email);
+	strbuf_reset(date);
+	if (!val) die("Malformed author line");
+	if (!(tz_off = strrchr(val, ' '))) goto error;
+	*tz_off++ = '\0';
+	if (!(t = strrchr(val, ' '))) goto error;
+	*(t - 1) = '\0'; /* Ignore '>' from email */
+	t++;
+	tz_off_buf = atoi(tz_off);
+	if (tz_off_buf > 1200 || tz_off_buf  < -1200) goto error;
+	tm_time = time_to_tm(strtoul(t, NULL, 10), tz_off_buf);
+	strftime(time_buf, SVN_DATE_LEN + 1, SVN_DATE_FORMAT, tm_time);
+	strbuf_add(date, time_buf, SVN_DATE_LEN);
+	if (!(t = strchr(val, '<'))) goto error;
+	*(t - 1) = '\0'; /* Ignore ' <' from email */
+	t++;
+	strbuf_add(email, t, strlen(t));
+	strbuf_add(name, val, strlen(val));
+	return;
+error:
+	die("Malformed author line: %s", val);
+}
+
+void build_svn_author(struct strbuf *svn_author)
+{
+	char *t, *email;
+
+	strbuf_reset(svn_author);
+	email = rev_ctx.author_email.buf;
+	if (!(t = strchr(email, '@')))
+		goto error;
+	strbuf_add(svn_author, email, t - email);
+	return;
+error:
+	die("Malformed email: %s", email);
+}
+
+int parse_filemodify_mode(char *val)
+{
+	char *t;
+
+	if (!(t = strchr(val, ' '))) goto error;
+	switch (t - val) {
+	case 6:
+		if (!memcmp(val, "100644", 6))
+			node_ctx.kind = NODE_KIND_NORMAL;
+		else if (!memcmp(val, "100755", 6))
+			node_ctx.kind = NODE_KIND_EXECUTABLE;
+		else if (!memcmp(val, "120000", 6))
+			node_ctx.kind = NODE_KIND_SYMLINK;
+		else if (!memcmp(val, "160000", 6))
+			node_ctx.kind = NODE_KIND_GITLINK;
+		else if (!memcmp(val, "040000", 6))
+			node_ctx.kind = NODE_KIND_SUBDIR;
+		else
+			goto error;
+		break;
+	case 3:
+		if (!memcmp(val, "755", 3))
+			node_ctx.kind = NODE_KIND_EXECUTABLE;
+		else if (!memcmp(val, "644", 3))
+			node_ctx.kind = NODE_KIND_NORMAL;
+		else
+			goto error;
+		break;
+	default:
+		goto error;
+	}
+	return t - val + 1;
+error:
+	die("Unrecognized mode: %s", val);
+}
+
+void svnload_read(void)
+{
+	char *t, *val;
+	int len;
+
+	while ((t = buffer_read_line(&input))) {
+		if ((val = strchr(t, ' ')))
+			*val++ = '\0';
+		len = (val ? val - t - 1 : strlen(t));
+
+		switch (len) {
+		case 1:
+			if (!memcmp(t, "D", 1)) {
+				node_ctx.action = NODE_ACTION_DELETE;
+			} else if (!memcmp(t, "C", 1)) {
+				node_ctx.action = NODE_ACTION_ADD;
+			} else if (!memcmp(t, "R", 1)) {
+				node_ctx.action = NODE_ACTION_REPLACE;
+			} else if (!memcmp(t, "M", 1)) {
+				if (!val) goto error;
+				node_ctx.action = NODE_ACTION_CHANGE;
+				val += parse_filemodify_mode(val);
+				if (!(t = strchr(val, ' '))) goto error;
+				*t++ = '\0';
+				strbuf_reset(&node_ctx.path);
+				strbuf_add(&node_ctx.path, t, strlen(t));
+				if (!strncmp(val, "inline", 6))
+					active_ctx = BLOB_CTX;
+				else if (*val == ':')
+					die("Unsupported dataref: marks");
+				else {
+				error:
+					die("Malformed filemodify line: %s", t);
+				}
+			}
+			break;
+		case 2:
+			if (!memcmp(t, "ls", 2))
+				die("ls not supported");
+		case 3:
+			if (!memcmp(t, "tag", 3))
+				continue;
+			break;
+		case 4:
+			if (!memcmp(t, "blob", 4))
+				continue;
+			else if (!memcmp(t, "mark", 4))
+				continue;
+			else if (!memcmp(t, "from", 4))
+				continue;
+			else if (!memcmp(t, "data", 4)) {
+				switch (active_ctx) {
+				case COMMIT_CTX:
+					strbuf_reset(&rev_ctx.log);
+					buffer_read_binary(&input,
+							&rev_ctx.log,
+							strtoul(val, NULL, 10));
+					populate_revprops(&rev_ctx.props,
+							rev_ctx.svn_author.len,
+							rev_ctx.svn_author.buf,
+							rev_ctx.log.len,
+							rev_ctx.log.buf,
+							rev_ctx.author_date.len,
+							rev_ctx.author_date.buf);
+					dump_export_begin_rev(rev_ctx.rev,
+							rev_ctx.props.buf,
+							rev_ctx.props.len);
+					break;
+				case BLOB_CTX:
+					node_ctx.text_len = strtoul(val, NULL, 10);
+					dump_export_node_r(node_ctx.path.buf, node_ctx.kind,
+							node_ctx.action, node_ctx.text_len,
+							SVN_INVALID_REV, NULL);
+					buffer_copy_bytes(&input, node_ctx.text_len);
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
+				build_svn_author(&rev_ctx.svn_author);
+			} else if (!memcmp(t, "commit", 6)) {
+				rev_ctx.rev++;
+				active_ctx = COMMIT_CTX;
+			}
+			break;
+		case 8:
+			if (!memcmp(t, "cat-blob", 8))
+				die("cat-blob unsupported");
+			break;
+		case 9:
+			if (!memcmp(t, "deleteall", 9))
+				continue;
+			else if (!memcmp(t, "committer", 9))
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
+	node_ctx.copyfrom_rev = SVN_INVALID_REV;
+	node_ctx.text_delta = -1;
+	node_ctx.prop_delta = -1;
+	strbuf_reset(&node_ctx.copyfrom_path);
+	strbuf_reset(&node_ctx.path);
+}
+
+int svnload_init(const char *filename)
+{
+	if (buffer_init(&input, filename))
+		return error("cannot open %s: %s", filename, strerror(errno));
+	active_ctx = UNKNOWN_CTX;
+	strbuf_init(&rev_ctx.props, MAX_GITSVN_LINE_LEN);
+	strbuf_init(&rev_ctx.log, MAX_GITSVN_LINE_LEN);
+	strbuf_init(&rev_ctx.author, MAX_GITSVN_LINE_LEN);
+	strbuf_init(&rev_ctx.committer, MAX_GITSVN_LINE_LEN);
+	strbuf_init(&rev_ctx.svn_author, MAX_GITSVN_LINE_LEN);
+	strbuf_init(&rev_ctx.author_date, MAX_GITSVN_LINE_LEN);
+	strbuf_init(&rev_ctx.committer_date, MAX_GITSVN_LINE_LEN);
+	strbuf_init(&rev_ctx.author_email, MAX_GITSVN_LINE_LEN);
+	strbuf_init(&rev_ctx.committer_email, MAX_GITSVN_LINE_LEN);
+	strbuf_init(&node_ctx.path, MAX_GITSVN_LINE_LEN);
+	strbuf_init(&node_ctx.copyfrom_path, MAX_GITSVN_LINE_LEN);
+	dump_export_init();
+	dir_cache_init();
+	return 0;
+}
+
+void svnload_deinit(void)
+{
+	reset_rev_ctx(0);
+	reset_node_ctx();
+	strbuf_release(&rev_ctx.props);
+	strbuf_release(&rev_ctx.log);
+	strbuf_release(&rev_ctx.author);
+	strbuf_release(&rev_ctx.committer);
+	strbuf_release(&rev_ctx.svn_author);
+	strbuf_release(&rev_ctx.author_date);
+	strbuf_release(&rev_ctx.committer_date);
+	strbuf_release(&rev_ctx.author_email);
+	strbuf_release(&rev_ctx.committer_email);
+	strbuf_release(&node_ctx.path);
+	strbuf_release(&node_ctx.copyfrom_path);
+	dump_export_deinit();
+	dir_cache_deinit();
+	if (buffer_deinit(&input))
+		fprintf(stderr, "Input error\n");
+	if (ferror(stdout))
+		fprintf(stderr, "Output error\n");
+}
diff --git a/vcs-svn/svnload.h b/vcs-svn/svnload.h
new file mode 100644
index 0000000..0c8fe8b
--- /dev/null
+++ b/vcs-svn/svnload.h
@@ -0,0 +1,10 @@
+#ifndef SVNLOAD_H_
+#define SVNLOAD_H_
+
+#define SVN_INVALID_REV -1
+
+int svnload_init(const char *filename);
+void svnload_deinit(void);
+void svnload_read(void);
+
+#endif
-- 
1.7.4.rc1.7.g2cf08.dirty
