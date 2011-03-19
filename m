From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 1/9] vcs-svn: pass paths through to fast-import
Date: Sat, 19 Mar 2011 18:03:43 +1100
Message-ID: <1300518231-20008-2-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:12:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qLH-0004uk-Qp
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480Ab1CSHMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:12:47 -0400
Received: from [119.15.97.146] ([119.15.97.146]:57031 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753948Ab1CSHMN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:12:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 4A7ACC04D;
	Sat, 19 Mar 2011 18:00:33 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id odJeqhTjd38J; Sat, 19 Mar 2011 18:00:28 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id E7B31C04B;
	Sat, 19 Mar 2011 18:00:27 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169395>

Now that there is no internal representation of the repo,
it is not necessary to tokenise paths.

Use strbuf instead and bypass string_pool.

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 vcs-svn/fast_export.c |   47 ++++++++++++++++++------------------
 vcs-svn/fast_export.h |    9 +++----
 vcs-svn/repo_tree.c   |   20 +++++++-------
 vcs-svn/repo_tree.h   |   13 ++++------
 vcs-svn/svndump.c     |   63 +++++++++++++++++++++----------------------------
 5 files changed, 70 insertions(+), 82 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index f19db9a..bb5e9aa 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -4,6 +4,8 @@
  */
 
 #include "git-compat-util.h"
+#include "strbuf.h"
+#include "quote.h"
 #include "fast_export.h"
 #include "line_buffer.h"
 #include "repo_tree.h"
@@ -32,30 +34,30 @@ void fast_export_reset(void)
 	buffer_reset(&report_buffer);
 }
 
-void fast_export_delete(uint32_t depth, const uint32_t *path)
+void fast_export_delete(const char *path)
 {
-	printf("D \"");
-	pool_print_seq_q(depth, path, '/', stdout);
-	printf("\"\n");
+	putchar('D');
+	putchar(' ');
+	quote_c_style(path, NULL, stdout, 0);
+	putchar('\n');
 }
 
-static void fast_export_truncate(uint32_t depth, const uint32_t *path, uint32_t mode)
+static void fast_export_truncate(const char *path, uint32_t mode)
 {
-	fast_export_modify(depth, path, mode, "inline");
+	fast_export_modify(path, mode, "inline");
 	printf("data 0\n\n");
 }
 
-void fast_export_modify(uint32_t depth, const uint32_t *path, uint32_t mode,
-			const char *dataref)
+void fast_export_modify(const char *path, uint32_t mode, const char *dataref)
 {
 	/* Mode must be 100644, 100755, 120000, or 160000. */
 	if (!dataref) {
-		fast_export_truncate(depth, path, mode);
+		fast_export_truncate(path, mode);
 		return;
 	}
-	printf("M %06"PRIo32" %s \"", mode, dataref);
-	pool_print_seq_q(depth, path, '/', stdout);
-	printf("\"\n");
+	printf("M %06"PRIo32" %s ", mode, dataref);
+	quote_c_style(path, NULL, stdout, 0);
+	putchar('\n');
 }
 
 static char gitsvnline[MAX_GITSVN_LINE_LEN];
@@ -93,20 +95,20 @@ void fast_export_end_commit(uint32_t revision)
 	printf("progress Imported commit %"PRIu32".\n\n", revision);
 }
 
-static void ls_from_rev(uint32_t rev, uint32_t depth, const uint32_t *path)
+static void ls_from_rev(uint32_t rev, const char *path)
 {
 	/* ls :5 path/to/old/file */
-	printf("ls :%"PRIu32" \"", rev);
-	pool_print_seq_q(depth, path, '/', stdout);
-	printf("\"\n");
+	printf("ls :%"PRIu32" ", rev);
+	quote_c_style(path, NULL, stdout, 0);
+	putchar('\n');
 	fflush(stdout);
 }
 
-static void ls_from_active_commit(uint32_t depth, const uint32_t *path)
+static void ls_from_active_commit(const char *path)
 {
 	/* ls "path/to/file" */
 	printf("ls \"");
-	pool_print_seq_q(depth, path, '/', stdout);
+	quote_c_style(path, NULL, stdout, 1);
 	printf("\"\n");
 	fflush(stdout);
 }
@@ -174,16 +176,15 @@ static int parse_ls_response(const char *response, uint32_t *mode,
 	return 0;
 }
 
-int fast_export_ls_rev(uint32_t rev, uint32_t depth, const uint32_t *path,
+int fast_export_ls_rev(uint32_t rev, const char *path,
 				uint32_t *mode, struct strbuf *dataref)
 {
-	ls_from_rev(rev, depth, path);
+	ls_from_rev(rev, path);
 	return parse_ls_response(get_response_line(), mode, dataref);
 }
 
-int fast_export_ls(uint32_t depth, const uint32_t *path,
-				uint32_t *mode, struct strbuf *dataref)
+int fast_export_ls(const char *path, uint32_t *mode, struct strbuf *dataref)
 {
-	ls_from_active_commit(depth, path);
+	ls_from_active_commit(path);
 	return parse_ls_response(get_response_line(), mode, dataref);
 }
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index 633d219..a47c609 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -8,18 +8,17 @@ void fast_export_init(int fd);
 void fast_export_deinit(void);
 void fast_export_reset(void);
 
-void fast_export_delete(uint32_t depth, const uint32_t *path);
-void fast_export_modify(uint32_t depth, const uint32_t *path,
-			uint32_t mode, const char *dataref);
+void fast_export_delete(const char *path);
+void fast_export_modify(const char *path, uint32_t mode, const char *dataref);
 void fast_export_begin_commit(uint32_t revision, uint32_t author, char *log,
 			uint32_t uuid, uint32_t url, unsigned long timestamp);
 void fast_export_end_commit(uint32_t revision);
 void fast_export_data(uint32_t mode, uint32_t len, struct line_buffer *input);
 
 /* If there is no such file at that rev, returns -1, errno == ENOENT. */
-int fast_export_ls_rev(uint32_t rev, uint32_t depth, const uint32_t *path,
+int fast_export_ls_rev(uint32_t rev, const char *path,
 			uint32_t *mode_out, struct strbuf *dataref_out);
-int fast_export_ls(uint32_t depth, const uint32_t *path,
+int fast_export_ls(const char *path,
 			uint32_t *mode_out, struct strbuf *dataref_out);
 
 #endif
diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index e75f580..f2466bc 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -8,14 +8,14 @@
 #include "repo_tree.h"
 #include "fast_export.h"
 
-const char *repo_read_path(const uint32_t *path)
+const char *repo_read_path(const char *path)
 {
 	int err;
 	uint32_t dummy;
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	err = fast_export_ls(REPO_MAX_PATH_DEPTH, path, &dummy, &buf);
+	err = fast_export_ls(path, &dummy, &buf);
 	if (err) {
 		if (errno != ENOENT)
 			die_errno("BUG: unexpected fast_export_ls error");
@@ -24,14 +24,14 @@ const char *repo_read_path(const uint32_t *path)
 	return buf.buf;
 }
 
-uint32_t repo_read_mode(const uint32_t *path)
+uint32_t repo_read_mode(const char *path)
 {
 	int err;
 	uint32_t result;
 	static struct strbuf dummy = STRBUF_INIT;
 
 	strbuf_reset(&dummy);
-	err = fast_export_ls(REPO_MAX_PATH_DEPTH, path, &result, &dummy);
+	err = fast_export_ls(path, &result, &dummy);
 	if (err) {
 		if (errno != ENOENT)
 			die_errno("BUG: unexpected fast_export_ls error");
@@ -41,24 +41,24 @@ uint32_t repo_read_mode(const uint32_t *path)
 	return result;
 }
 
-void repo_copy(uint32_t revision, const uint32_t *src, const uint32_t *dst)
+void repo_copy(uint32_t revision, const char *src, const char *dst)
 {
 	int err;
 	uint32_t mode;
 	static struct strbuf data = STRBUF_INIT;
 
 	strbuf_reset(&data);
-	err = fast_export_ls_rev(revision, REPO_MAX_PATH_DEPTH, src, &mode, &data);
+	err = fast_export_ls_rev(revision, src, &mode, &data);
 	if (err) {
 		if (errno != ENOENT)
 			die_errno("BUG: unexpected fast_export_ls_rev error");
-		fast_export_delete(REPO_MAX_PATH_DEPTH, dst);
+		fast_export_delete(dst);
 		return;
 	}
-	fast_export_modify(REPO_MAX_PATH_DEPTH, dst, mode, data.buf);
+	fast_export_modify(dst, mode, data.buf);
 }
 
-void repo_delete(uint32_t *path)
+void repo_delete(const char *path)
 {
-	fast_export_delete(REPO_MAX_PATH_DEPTH, path);
+	fast_export_delete(path);
 }
diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
index d690784..af2415c 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -8,15 +8,12 @@
 #define REPO_MODE_EXE 0100755
 #define REPO_MODE_LNK 0120000
 
-#define REPO_MAX_PATH_LEN 4096
-#define REPO_MAX_PATH_DEPTH 1000
-
 uint32_t next_blob_mark(void);
-void repo_copy(uint32_t revision, const uint32_t *src, const uint32_t *dst);
-void repo_add(uint32_t *path, uint32_t mode, uint32_t blob_mark);
-const char *repo_read_path(const uint32_t *path);
-uint32_t repo_read_mode(const uint32_t *path);
-void repo_delete(uint32_t *path);
+void repo_copy(uint32_t revision, const char *src, const char *dst);
+void repo_add(const char *path, uint32_t mode, uint32_t blob_mark);
+const char *repo_read_path(const char *path);
+uint32_t repo_read_mode(const char *path);
+void repo_delete(const char *path);
 void repo_commit(uint32_t revision, uint32_t author, char *log, uint32_t uuid,
 		 uint32_t url, long unsigned timestamp);
 void repo_diff(uint32_t r1, uint32_t r2);
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 7ecb227..afdfc63 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -11,8 +11,8 @@
 #include "repo_tree.h"
 #include "fast_export.h"
 #include "line_buffer.h"
-#include "obj_pool.h"
 #include "string_pool.h"
+#include "strbuf.h"
 
 #define REPORT_FILENO 3
 
@@ -31,32 +31,20 @@
 #define LENGTH_UNKNOWN (~0)
 #define DATE_RFC2822_LEN 31
 
-/* Create memory pool for log messages */
-obj_pool_gen(log, char, 4096)
-
 static struct line_buffer input = LINE_BUFFER_INIT;
 
 #define REPORT_FILENO 3
 
-static char *log_copy(uint32_t length, const char *log)
-{
-	char *buffer;
-	log_free(log_pool.size);
-	buffer = log_pointer(log_alloc(length));
-	strncpy(buffer, log, length);
-	return buffer;
-}
-
 static struct {
 	uint32_t action, propLength, textLength, srcRev, type;
-	uint32_t src[REPO_MAX_PATH_DEPTH], dst[REPO_MAX_PATH_DEPTH];
+	struct strbuf src, dst;
 	uint32_t text_delta, prop_delta;
 } node_ctx;
 
 static struct {
 	uint32_t revision, author;
 	unsigned long timestamp;
-	char *log;
+	struct strbuf log;
 } rev_ctx;
 
 static struct {
@@ -78,9 +66,11 @@ static void reset_node_ctx(char *fname)
 	node_ctx.action = NODEACT_UNKNOWN;
 	node_ctx.propLength = LENGTH_UNKNOWN;
 	node_ctx.textLength = LENGTH_UNKNOWN;
-	node_ctx.src[0] = ~0;
+	strbuf_reset(&node_ctx.src);
 	node_ctx.srcRev = 0;
-	pool_tok_seq(REPO_MAX_PATH_DEPTH, node_ctx.dst, "/", fname);
+	strbuf_reset(&node_ctx.dst);
+	if (fname)
+		strbuf_addstr(&node_ctx.dst, fname);
 	node_ctx.text_delta = 0;
 	node_ctx.prop_delta = 0;
 }
@@ -89,7 +79,7 @@ static void reset_rev_ctx(uint32_t revision)
 {
 	rev_ctx.revision = revision;
 	rev_ctx.timestamp = 0;
-	rev_ctx.log = NULL;
+	strbuf_reset(&rev_ctx.log);
 	rev_ctx.author = ~0;
 }
 
@@ -130,7 +120,7 @@ static void handle_property(uint32_t key, const char *val, uint32_t len,
 		if (!val)
 			die("invalid dump: unsets svn:log");
 		/* Value length excludes terminating nul. */
-		rev_ctx.log = log_copy(len + 1, val);
+		strbuf_add(&rev_ctx.log, val, len + 1);
 	} else if (key == keys.svn_author) {
 		rev_ctx.author = pool_intern(val);
 	} else if (key == keys.svn_date) {
@@ -223,14 +213,14 @@ static void handle_node(void)
 		if (have_text || have_props || node_ctx.srcRev)
 			die("invalid dump: deletion node has "
 				"copyfrom info, text, or properties");
-		return repo_delete(node_ctx.dst);
+		return repo_delete(node_ctx.dst.buf);
 	}
 	if (node_ctx.action == NODEACT_REPLACE) {
-		repo_delete(node_ctx.dst);
+		repo_delete(node_ctx.dst.buf);
 		node_ctx.action = NODEACT_ADD;
 	}
 	if (node_ctx.srcRev) {
-		repo_copy(node_ctx.srcRev, node_ctx.src, node_ctx.dst);
+		repo_copy(node_ctx.srcRev, node_ctx.src.buf, node_ctx.dst.buf);
 		if (node_ctx.action == NODEACT_ADD)
 			node_ctx.action = NODEACT_CHANGE;
 	}
@@ -240,14 +230,14 @@ static void handle_node(void)
 	/*
 	 * Find old content (old_data) and decide on the new mode.
 	 */
-	if (node_ctx.action == NODEACT_CHANGE && !~*node_ctx.dst) {
+	if (node_ctx.action == NODEACT_CHANGE && !*node_ctx.dst.buf) {
 		if (type != REPO_MODE_DIR)
 			die("invalid dump: root of tree is not a regular file");
 		old_data = NULL;
 	} else if (node_ctx.action == NODEACT_CHANGE) {
 		uint32_t mode;
-		old_data = repo_read_path(node_ctx.dst);
-		mode = repo_read_mode(node_ctx.dst);
+		old_data = repo_read_path(node_ctx.dst.buf);
+		mode = repo_read_mode(node_ctx.dst.buf);
 		if (mode == REPO_MODE_DIR && type != REPO_MODE_DIR)
 			die("invalid dump: cannot modify a directory into a file");
 		if (mode != REPO_MODE_DIR && type == REPO_MODE_DIR)
@@ -284,12 +274,10 @@ static void handle_node(void)
 		/* For the fast_export_* functions, NULL means empty. */
 		old_data = NULL;
 	if (!have_text) {
-		fast_export_modify(REPO_MAX_PATH_DEPTH, node_ctx.dst,
-					node_ctx.type, old_data);
+		fast_export_modify(node_ctx.dst.buf, node_ctx.type, old_data);
 		return;
 	}
-	fast_export_modify(REPO_MAX_PATH_DEPTH, node_ctx.dst,
-				node_ctx.type, "inline");
+	fast_export_modify(node_ctx.dst.buf, node_ctx.type, "inline");
 	fast_export_data(node_ctx.type, node_ctx.textLength, &input);
 }
 
@@ -297,7 +285,7 @@ static void begin_revision(void)
 {
 	if (!rev_ctx.revision)	/* revision 0 gets no git commit. */
 		return;
-	fast_export_begin_commit(rev_ctx.revision, rev_ctx.author, rev_ctx.log,
+	fast_export_begin_commit(rev_ctx.revision, rev_ctx.author, rev_ctx.log.buf,
 		dump_ctx.uuid, dump_ctx.url, rev_ctx.timestamp);
 }
 
@@ -368,7 +356,8 @@ void svndump_read(const char *url)
 				node_ctx.action = NODEACT_UNKNOWN;
 			}
 		} else if (key == keys.node_copyfrom_path) {
-			pool_tok_seq(REPO_MAX_PATH_DEPTH, node_ctx.src, "/", val);
+			strbuf_reset(&node_ctx.src);
+			strbuf_addstr(&node_ctx.src, val);
 		} else if (key == keys.node_copyfrom_rev) {
 			node_ctx.srcRev = atoi(val);
 		} else if (key == keys.text_content_length) {
@@ -406,6 +395,9 @@ int svndump_init(const char *filename)
 	if (buffer_init(&input, filename))
 		return error("cannot open %s: %s", filename, strerror(errno));
 	fast_export_init(REPORT_FILENO);
+	strbuf_init(&rev_ctx.log, 4096);
+	strbuf_init(&node_ctx.src, 4096);
+	strbuf_init(&node_ctx.dst, 4096);
 	reset_dump_ctx(~0);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
@@ -415,11 +407,13 @@ int svndump_init(const char *filename)
 
 void svndump_deinit(void)
 {
-	log_reset();
 	fast_export_deinit();
 	reset_dump_ctx(~0);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
+	strbuf_release(&rev_ctx.log);
+	strbuf_release(&node_ctx.src);
+	strbuf_release(&node_ctx.dst);
 	if (buffer_deinit(&input))
 		fprintf(stderr, "Input error\n");
 	if (ferror(stdout))
@@ -428,10 +422,7 @@ void svndump_deinit(void)
 
 void svndump_reset(void)
 {
-	log_reset();
 	fast_export_reset();
 	buffer_reset(&input);
-	reset_dump_ctx(~0);
-	reset_rev_ctx(0);
-	reset_node_ctx(NULL);
+	pool_reset();
 }
-- 
1.7.3.2.846.gf4b062
