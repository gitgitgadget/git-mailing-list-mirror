From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/5] vcs-svn: Add dir_cache for svnload
Date: Wed, 19 Jan 2011 11:14:59 +0530
Message-ID: <1295415899-1192-6-git-send-email-artagnon@gmail.com>
References: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 19 06:44:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfQqY-0001OM-S4
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 06:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444Ab1ASFoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 00:44:34 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52990 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab1ASFod (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 00:44:33 -0500
Received: by mail-gw0-f46.google.com with SMTP id 20so126197gwj.19
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 21:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=1fVKFE4Ke+ROANurnJjlMcyRmw+1pQ+/9jY9LghwWSA=;
        b=XUpOGHP/YmBepW5OQOrvVgz30aUIW7jd//rZtCRrwEDxZii1sb0gLV/feEGD8okkuC
         7MyiasAshbxfALCMUmR+D+5rr+nLWM8p0O+n/u4TtWGDEKM+hN6RNbh90kNrdIfRAMIf
         106qAB8LtIjxmhsrx3CqU7UEBAxqCIHFbtnKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KWLAM89KqWcPSC+sNZVdRFomFSN20CsDazhXN+yWlLnFyaZw3I/IBMwMa8KD1lP2HR
         ly9P5nrpdl+hRmcYz3SuGR6Nf3gm3qdDgqSMRRTnQY/y3SVobECz88M6ZjF2zNUbnHJQ
         8afKWnanjtuBGPFhpnXiY4q7zw/9uleRRhnAQ=
Received: by 10.90.33.11 with SMTP id g11mr390461agg.183.1295415872871;
        Tue, 18 Jan 2011 21:44:32 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d15sm7968646ana.35.2011.01.18.21.44.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Jan 2011 21:44:32 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165241>

The logic for creating directories recursively is now
implemented. Unfortunately, dir_cache is currently implemented
inefficiently using string_list- should probably use a treap or trie
in future.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile              |    2 +-
 vcs-svn/dir_cache.c   |   40 +++++++++++++++
 vcs-svn/dir_cache.h   |   12 +++++
 vcs-svn/dump_export.c |  104 ++++++++++++++++++++++++++++++++-------
 vcs-svn/dump_export.h |   33 ++++++++++++
 vcs-svn/svnload.c     |  130 +++++++++++++++++++++++--------------------------
 vcs-svn/svnload.h     |   10 ++++
 7 files changed, 243 insertions(+), 88 deletions(-)
 create mode 100644 vcs-svn/dir_cache.c
 create mode 100644 vcs-svn/dir_cache.h
 create mode 100644 vcs-svn/dump_export.h
 create mode 100644 vcs-svn/svnload.h

diff --git a/Makefile b/Makefile
index 40f6691..d9c2442 100644
--- a/Makefile
+++ b/Makefile
@@ -1836,7 +1836,7 @@ XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
 VCSSVN_OBJS = vcs-svn/line_buffer.o vcs-svn/svnload.o vcs-svn/dump_export.o \
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
index 04ede06..6f2a9d7 100644
--- a/vcs-svn/dump_export.c
+++ b/vcs-svn/dump_export.c
@@ -7,6 +7,9 @@
 #include "strbuf.h"
 #include "line_buffer.h"
 #include "dump_export.h"
+#include "dir_cache.h"
+
+static struct strbuf props;
 
 void dump_export_begin_rev(int revision, const char *revprops,
 			int prop_len) {
@@ -19,39 +22,47 @@ void dump_export_begin_rev(int revision, const char *revprops,
 void dump_export_node(const char *path, enum node_kind kind,
 		enum node_action action, unsigned long text_len,
 		unsigned long copyfrom_rev, const char *copyfrom_path) {
+	int dump_props = 1; /* Boolean */
+	strbuf_reset(&props);
 	printf("Node-path: %s\n", path);
-	printf("Node-kind: ");
-	switch (action) {
+	switch (kind) {
 	case NODE_KIND_NORMAL:
-		printf("file\n");
+		printf("Node-kind: file\n");
 		break;
 	case NODE_KIND_EXECUTABLE:
-		printf("file\n");
+		printf("Node-kind: file\n");
+		strbuf_addf(&props, "K\nsvn:executable\nV\n1\n");
 		break;
 	case NODE_KIND_SYMLINK:
-		printf("file\n");
+		printf("Node-kind: file\n");
+		strbuf_addf(&props, "K\nsvn:special\nV\n1\n");
 		break;
 	case NODE_KIND_GITLINK:
-		printf("file\n");
+		printf("Node-kind: file\n");
+		break;
+	case NODE_KIND_DIR:
+		printf("Node-kind: dir\n");
 		break;
 	case NODE_KIND_SUBDIR:
 		die("Unsupported: subdirectory");
 	default:
-		break;
+		break; /* When a node is being removed, nothing is printed */
 	}
-	printf("Node-action: ");
+	strbuf_add(&props, "PROPS-END\n", 10);
+
 	switch (action) {
 	case NODE_ACTION_CHANGE:
-		printf("change\n");
+		printf("Node-action: change\n");
 		break;
 	case NODE_ACTION_ADD:
-		printf("add\n");
+		printf("Node-action: add\n");
 		break;
 	case NODE_ACTION_REPLACE:
-		printf("replace\n");
+		printf("Node-action: replace\n");
 		break;
 	case NODE_ACTION_DELETE:
-		printf("delete\n");
+		printf("Node-action: delete\n");
+		dump_props = 0;
 		break;
 	default:
 		break;
@@ -60,14 +71,71 @@ void dump_export_node(const char *path, enum node_kind kind,
 		printf("Node-copyfrom-rev: %lu\n", copyfrom_rev);
 		printf("Node-copyfrom-path: %s\n", copyfrom_path);
 	}
-	printf("Prop-delta: false\n");
-	printf("Prop-content-length: 10\n"); /* Constant 10 for "PROPS-END" */
-	printf("Text-delta: false\n");
-	printf("Text-content-length: %lu\n", text_len);
-	printf("Content-length: %lu\n\n", text_len + 10);
-	printf("PROPS-END\n\n");
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
+			unsigned long copyfrom_rev, const char *copyfrom_path) {
+	char *start, *t;
+	start = (char *) path;
+
+	while((t = strchr(start, '/'))) {
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
 }
 
 void dump_export_text(struct line_buffer *data, off_t len) {
 	buffer_copy_bytes(data, len);
 }
+
+void dump_export_init() {
+	strbuf_init(&props, MAX_GITSVN_LINE_LEN);
+}
+
+void dump_export_deinit() {
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
index 7043ae7..19c4689 100644
--- a/vcs-svn/svnload.c
+++ b/vcs-svn/svnload.c
@@ -11,17 +11,16 @@
 #include "git-compat-util.h"
 #include "line_buffer.h"
 #include "dump_export.h"
-#include "strbuf.h"
+#include "dir_cache.h"
 
 #define SVN_DATE_FORMAT "%Y-%m-%dT%H:%M:%S.000000Z"
 #define SVN_DATE_LEN 28
 #define LENGTH_UNKNOWN (~0)
 
 static struct line_buffer input = LINE_BUFFER_INIT;
-static struct strbuf blobs[100];
-	
+
 static struct {
-	unsigned long prop_len, text_len, copyfrom_rev, mark;
+	unsigned long prop_len, text_len, copyfrom_rev;
 	int text_delta, prop_delta; /* Boolean */
 	enum node_action action;
 	enum node_kind kind;
@@ -60,15 +59,14 @@ static void reset_node_ctx(void)
 {
 	node_ctx.prop_len = LENGTH_UNKNOWN;
 	node_ctx.text_len = LENGTH_UNKNOWN;
-	node_ctx.mark = 0;
-	node_ctx.copyfrom_rev = 0;
+	node_ctx.copyfrom_rev = SVN_INVALID_REV;
 	node_ctx.text_delta = -1;
 	node_ctx.prop_delta = -1;
 	strbuf_reset(&node_ctx.copyfrom_path);
 	strbuf_reset(&node_ctx.path);
 }
 
-static void populate_props(struct strbuf *props, const char *author,
+static void populate_revprops(struct strbuf *props, const char *author,
 			const char *log, const char *date) {
 	strbuf_reset(props);	
 	strbuf_addf(props, "K\nsvn:author\nV\n%s\n", author);
@@ -83,7 +81,7 @@ static void parse_author_line(char *val, struct strbuf *name,
 	char time_buf[SVN_DATE_LEN];
 	const struct tm *tm_time;
 
-	/* Simon Hausmann <shausman@trolltech.com> 1170199019 +0100 */
+	/* Author Name <author@email.com> 1170199019 +0530 */
 	strbuf_reset(name);
 	strbuf_reset(email);
 	strbuf_reset(date);
@@ -104,46 +102,42 @@ static void parse_author_line(char *val, struct strbuf *name,
 
 void svnload_read(void) {
 	char *t, *val;
-	int mode_incr;
-	struct strbuf *to_dump;
+	int len, mode_incr;
 
 	while ((t = buffer_read_line(&input))) {
 		val = strchr(t, ' ');
-		if (!val) {
-			if (!memcmp(t, "blob", 4))
-				active_ctx = BLOB_CTX;
-			else if (!memcmp(t, "deleteall", 9))
-				;
-			continue;
+		if (!val)
+			len = strlen(t);
+		else {
+			*val++ = '\0';
+			len = val - t - 1;
 		}
-		*val++ = '\0';
 
-		/* strlen(key) */
-		switch (val - t - 1) {
+		switch (len) {
 		case 1:
 			if (!memcmp(t, "D", 1)) {
 				node_ctx.action = NODE_ACTION_DELETE;
-			}
-			else if (!memcmp(t, "C", 1)) {
+			} else if (!memcmp(t, "C", 1)) {
 				node_ctx.action = NODE_ACTION_ADD;
-			}
-			else if (!memcmp(t, "R", 1)) {
+			} else if (!memcmp(t, "R", 1)) {
 				node_ctx.action = NODE_ACTION_REPLACE;
-			}
-			else if (!memcmp(t, "M", 1)) {
+			} else if (!memcmp(t, "M", 1)) {
 				node_ctx.action = NODE_ACTION_CHANGE;
-				mode_incr = 7;
-				if (!memcmp(val, "100644", 6))
-					node_ctx.kind = NODE_KIND_NORMAL;
-				else if (!memcmp(val, "100755", 6))
-					node_ctx.kind = NODE_KIND_EXECUTABLE;
-				else if (!memcmp(val, "120000", 6))
-					node_ctx.kind = NODE_KIND_SYMLINK;
-				else if (!memcmp(val, "160000", 6))
-					node_ctx.kind = NODE_KIND_GITLINK;
-				else if (!memcmp(val, "040000", 6))
-					node_ctx.kind = NODE_KIND_SUBDIR;
-				else {
+				if (strlen(val) >= 6) {
+					if (!memcmp(val, "100644", 6))
+						node_ctx.kind = NODE_KIND_NORMAL;
+					else if (!memcmp(val, "100755", 6))
+						node_ctx.kind = NODE_KIND_EXECUTABLE;
+					else if (!memcmp(val, "120000", 6))
+						node_ctx.kind = NODE_KIND_SYMLINK;
+					else if (!memcmp(val, "160000", 6))
+						node_ctx.kind = NODE_KIND_GITLINK;
+					else if (!memcmp(val, "040000", 6))
+						node_ctx.kind = NODE_KIND_SUBDIR;
+					else
+						die("Unrecognized mode: %s", val);
+					mode_incr = 7;
+				} else if (strlen(val) >= 3) {
 					if (!memcmp(val, "755", 3))
 						node_ctx.kind = NODE_KIND_EXECUTABLE;
 					else if(!memcmp(val, "644", 3))
@@ -151,40 +145,35 @@ void svnload_read(void) {
 					else
 						die("Unrecognized mode: %s", val);
 					mode_incr = 4;
-				}
+				} else
+					die ("Malformed filemodify: Missing mode");
 				val += mode_incr;
 				t = strchr(val, ' ');
+				if (!t)
+					die("Malformed filemodify: Missing dataref");
 				*t++ = '\0';
 				strbuf_reset(&node_ctx.path);
 				strbuf_add(&node_ctx.path, t, strlen(t));
-				if (!memcmp(val + 1, "inline", 6))
-					die("Unsupported dataref: inline");
+				if (!strncmp(val, "inline", 6))
+					active_ctx = BLOB_CTX;
 				else if (*val == ':')
-					to_dump = &blobs[strtoul(val + 1, NULL, 10)];
+					die("Unsupported dataref: marks");
 				else
 					die("Unsupported dataref: sha1");
-				dump_export_node(node_ctx.path.buf, node_ctx.kind,
-						node_ctx.action, to_dump->len,
-						0, NULL);
-				printf("%s", to_dump->buf);
 			}
 			break;
+		case 2:
+			if (!memcmp(t, "ls", 2))
+				die("ls not supported");
 		case 3:
 			if (!memcmp(t, "tag", 3))
 				continue;
 			break;
 		case 4:
-			if (!memcmp(t, "mark", 4))
-				switch(active_ctx) {
-				case COMMIT_CTX:
-					/* What do we do with commit marks? */
-					continue;
-				case BLOB_CTX:
-					node_ctx.mark = strtoul(val + 1, NULL, 10);
-					break;
-				default:
-					break;
-				}
+			if (!memcmp(t, "blob", 4))
+				die("Please inline blobs in the fast-import stream");
+			else if (!memcmp(t, "mark", 4))
+				continue;
 			else if (!memcmp(t, "from", 4))
 				continue;
 			else if (!memcmp(t, "data", 4)) {
@@ -194,7 +183,7 @@ void svnload_read(void) {
 					buffer_read_binary(&input,
 							&rev_ctx.log,
 							strtoul(val, NULL, 10));
-					populate_props(&rev_ctx.props,
+					populate_revprops(&rev_ctx.props,
 						rev_ctx.svn_author.buf,
 						rev_ctx.log.buf,
 						rev_ctx.author_date.buf);
@@ -204,9 +193,10 @@ void svnload_read(void) {
 					break;
 				case BLOB_CTX:
 					node_ctx.text_len = strtoul(val, NULL, 10);
-					buffer_read_binary(&input,
-							&blobs[node_ctx.mark],
-							node_ctx.text_len);
+					dump_export_node_r(node_ctx.path.buf, node_ctx.kind,
+							node_ctx.action, node_ctx.text_len,
+							SVN_INVALID_REV, NULL);
+					buffer_copy_bytes(&input, node_ctx.text_len);
 					break;
 				default:
 					break;
@@ -231,14 +221,18 @@ void svnload_read(void) {
 					rev_ctx.author_email.buf,
 					t - rev_ctx.author_email.buf);
 
-			}
-			else if (!memcmp(t, "commit", 6)) {
+			} else if (!memcmp(t, "commit", 6)) {
 				rev_ctx.rev ++;
 				active_ctx = COMMIT_CTX;
 			}
 			break;
+		case 8:
+			if (!memcmp(t, "cat-blob", 8))
+				die("cat-blob unsupported");
 		case 9:
-			if (!memcmp(t, "committer", 9))
+			if (!memcmp(t, "deleteall", 9))
+				continue;
+			else if (!memcmp(t, "committer", 9))
 				parse_author_line(val, &rev_ctx.committer,
 						&rev_ctx.committer_email,
 						&rev_ctx.committer_date);
@@ -251,7 +245,6 @@ void svnload_read(void) {
 
 int svnload_init(const char *filename)
 {
-	int i;
 	if (buffer_init(&input, filename))
 		return error("cannot open %s: %s", filename, strerror(errno));
 	active_ctx = UNKNOWN_CTX;
@@ -265,14 +258,13 @@ int svnload_init(const char *filename)
 	strbuf_init(&rev_ctx.committer_email, MAX_GITSVN_LINE_LEN);
 	strbuf_init(&node_ctx.path, MAX_GITSVN_LINE_LEN);
 	strbuf_init(&node_ctx.copyfrom_path, MAX_GITSVN_LINE_LEN);
-	for (i = 0; i < 100; i ++)
-		strbuf_init(&blobs[i], 10000);
+	dump_export_init();
+	dir_cache_init();
 	return 0;
 }
 
 void svnload_deinit(void)
 {
-	int i;
 	reset_rev_ctx(0);
 	reset_node_ctx();
 	strbuf_release(&rev_ctx.props);
@@ -285,8 +277,8 @@ void svnload_deinit(void)
 	strbuf_release(&rev_ctx.committer_email);
 	strbuf_release(&node_ctx.path);
 	strbuf_release(&node_ctx.copyfrom_path);
-	for (i = 0; i < 100; i ++)
-		strbuf_release(&blobs[i]);
+	dump_export_deinit();
+	dir_cache_deinit();
 	if (buffer_deinit(&input))
 		fprintf(stderr, "Input error\n");
 	if (ferror(stdout))
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
