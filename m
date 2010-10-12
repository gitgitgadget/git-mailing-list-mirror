From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 7/7] svn-fe: Use the --report-fd feature
Date: Wed, 13 Oct 2010 00:50:24 +1100
Message-ID: <1286891424-2067-8-git-send-email-david.barr@cordelta.com>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 12 15:51:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5fGD-0004ii-PD
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 15:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467Ab0JLNuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 09:50:44 -0400
Received: from static-198-196.grapevine.transact.net.au ([121.127.198.196]:63919
	"EHLO mailhost.cordelta" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932406Ab0JLNug (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 09:50:36 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 765DCC06C;
	Wed, 13 Oct 2010 00:50:38 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sriHmH0LxGr7; Wed, 13 Oct 2010 00:50:33 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.127])
	by mailhost.cordelta (Postfix) with ESMTP id F1354C06E;
	Wed, 13 Oct 2010 00:50:29 +1100 (EST)
X-Mailer: git-send-email 1.7.3.1
In-Reply-To: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158846>

From: Jonathan Nieder <jrnieder@gmail.com>

On one hand, this makes the interface much uglier.  But on the
other hand, it makes it possible to retrieve blobs by name, a
facility we will be using soon.

Based-on-patch-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: David Barr <david.barr@cordelta.com>
Tested-by: David Barr <david.barr@cordelta.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 contrib/svn-fe/svn-fe.txt |    6 +-
 t/t9010-svn-fe.sh         |    6 +-
 test-svn-fe.c             |    3 +-
 vcs-svn/fast_export.c     |  183 ++++++++++++++++++++++++++++++++++++++++++++-
 vcs-svn/fast_export.h     |   10 ++-
 vcs-svn/repo_tree.c       |   14 +++-
 vcs-svn/repo_tree.h       |    1 +
 vcs-svn/svndiff.c         |   11 +--
 vcs-svn/svndiff.h         |    3 +-
 vcs-svn/svndump.c         |    6 ++
 10 files changed, 225 insertions(+), 18 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index 35f84bd..62c57dd 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -7,7 +7,11 @@ svn-fe - convert an SVN "dumpfile" to a fast-import stream
 
 SYNOPSIS
 --------
-svnadmin dump --incremental REPO | svn-fe [url] | git fast-import
+[verse]
+mkfifo backchannel &&
+svnadmin dump --incremental REPO |
+	svn-fe [url] 3<backchannel |
+	git fast-import --report-fd=3 3>backchannel
 
 DESCRIPTION
 -----------
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index de976ed..c0eb956 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -34,10 +34,10 @@ test_dump () {
 		svnadmin load "$label-svn" < "$TEST_DIRECTORY/$dump" &&
 		svn_cmd export "file://$PWD/$label-svn" "$label-svnco" &&
 		git init "$label-git" &&
-		test-svn-fe "$TEST_DIRECTORY/$dump" >"$label.fe" &&
 		(
-			cd "$label-git" &&
-			git fast-import < ../"$label.fe"
+			cd "$label-git" && mkfifo backflow
+			test-svn-fe "$TEST_DIRECTORY/$dump" 3< backflow | \
+			git fast-import --report-fd=3 3> backflow
 		) &&
 		(
 			cd "$label-svnco" &&
diff --git a/test-svn-fe.c b/test-svn-fe.c
index 658c2a7..9a1338c 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -23,10 +23,11 @@ int main(int argc, char *argv[])
 	if (argc == 5 && !strcmp(argv[1], "-d")) {
 		struct line_buffer preimage = LINE_BUFFER_INIT;
 		struct line_buffer delta = LINE_BUFFER_INIT;
+		struct view preimage_view = {&preimage, 0, STRBUF_INIT};
 		buffer_init(&preimage, argv[2]);
 		buffer_init(&delta, argv[3]);
 		if (svndiff0_apply(&delta, (off_t) strtoull(argv[4], NULL, 0),
-				   &preimage, stdout))
+				   &preimage_view, stdout))
 			return 1;
 		if (buffer_deinit(&preimage))
 			die_errno("cannot close preimage");
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index d984aaa..77ddea9 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -8,8 +8,10 @@
 #include "line_buffer.h"
 #include "repo_tree.h"
 #include "string_pool.h"
+#include "svndiff.h"
 
 #define MAX_GITSVN_LINE_LEN 4096
+#define REPORT_FILENO 3
 
 static uint32_t first_commit_done;
 
@@ -30,10 +32,109 @@ void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mode,
 	putchar('\n');
 }
 
+static void fast_export_read_bytes(size_t len, char buf[len])
+{
+	if (read_in_full(REPORT_FILENO, buf, len) != len)
+		warning("early eof. Expecting %"PRIu64" bytes", (uint64_t) len);
+}
+
+static void fast_export_skip_bytes(unsigned int len)
+{
+	off_t nread = 0;
+	off_t toread;
+	char buf[4096];
+	while (nread != len) {
+		toread = len - nread < 4096 ? len - nread : 4096;
+		if (read_in_full(REPORT_FILENO, buf, toread) != toread) {
+			warning("early eof. Expecting %u bytes", len);
+			break;
+		}
+		nread += toread;
+	}
+}
+
+static void fast_export_copy_bytes(FILE *out, size_t len)
+{
+	while (len > 0) {
+		char buf[4096];
+		ssize_t nread = xread(REPORT_FILENO, buf,
+					len < sizeof(buf) ? len : sizeof(buf));
+		if (nread <= 0) {
+			warning("read failure (early eof?) "
+				" expecting %"PRIu64" bytes", (uint64_t) len);
+			return;
+		}
+		if (fwrite(buf, 1, nread, out) != nread)
+			warning("write failure, "
+				"attempting %"PRIu64" bytes", (uint64_t) nread);
+		len -= nread;
+	}
+}
+
+static void fast_export_expect(const char *string)
+{
+	const char *p;
+	for (p = string; *p; p++) {
+		char buf[1];
+		if (xread(REPORT_FILENO, buf, 1) <= 0) {
+			warning("read failure (early eof?). Expecting %s", string);
+			return;
+		}
+		if (*buf != *p) {
+			warning("char mismatch %c != %c. Expecting %s",
+						*buf, *p, string);
+			return;
+		}
+	}
+}
+
+static size_t fast_export_read_integer_at_eol(void)
+{
+	size_t result = 0;
+	for (;;) {
+		char buf[1];
+		if (xread(REPORT_FILENO, buf, 1) <= 0) {
+			warning("read failure (early eof?). Expecting digit");
+			return result;
+		}
+		if (*buf == '\n')	/* success */
+			return result;
+		if (!isdigit(*buf)) {
+			warning("expecting digit, found nondigit %c", *buf);
+			return result;
+		}
+		if (result >= SIZE_MAX / 10 - 9) {
+			warning("too many digits");
+			return result;
+		}
+		result *= 10;
+		result += *buf - '0';
+	}
+}
+
+void fast_export_parse_commit(char tree_id[SHA1_HEX_LENGTH])
+{
+	size_t len;
+
+	fast_export_skip_bytes(SHA1_HEX_LENGTH);
+	fast_export_expect(" commit ");
+	len = fast_export_read_integer_at_eol();
+
+	fast_export_expect("tree ");
+	len -= strlen("tree ");
+	fast_export_read_bytes(SHA1_HEX_LENGTH, tree_id);
+	len -= SHA1_HEX_LENGTH;
+	fast_export_expect("\n");
+	len--;
+
+	fast_export_skip_bytes(len);
+	fast_export_expect("\n");
+}
+
 static char gitsvnline[MAX_GITSVN_LINE_LEN];
 void fast_export_commit(uint32_t revision, uint32_t author, char *log,
 			uint32_t uuid, uint32_t url,
-			unsigned long timestamp)
+			unsigned long timestamp, char tree_id[SHA1_HEX_LENGTH])
 {
 	if (!log)
 		log = "";
@@ -60,19 +161,95 @@ void fast_export_commit(uint32_t revision, uint32_t author, char *log,
 	repo_diff(revision - 1, revision);
 	fputc('\n', stdout);
 
+	fflush(stdout);
 	printf("progress Imported commit %"PRIu32".\n\n", revision);
+
+	/* Now fast-import returns the commitsha1 */
+	fast_export_read_bytes(SHA1_HEX_LENGTH, tree_id);
+	fast_export_expect("\n");
+	printf("cat %.*s\n", SHA1_HEX_LENGTH, tree_id);
+	fflush(stdout);
+	fast_export_parse_commit(tree_id);
+}
+
+void fast_export_save_blob(FILE *out)
+{
+	size_t len;
+
+	if (!out) {
+		warning("cannot open temporary: %s", strerror(errno));
+		out = fopen("/dev/null", "w");
+	}
+	if (!out) {
+		warning("cannot open /dev/null: %s", strerror(errno));
+		return;
+	}
+	fast_export_skip_bytes(SHA1_HEX_LENGTH);
+	fast_export_expect(" blob ");
+	len = fast_export_read_integer_at_eol();
+
+	fast_export_copy_bytes(out, len);
+	fast_export_expect("\n");
+	if (ferror(out))
+		warning("cannot write temporary: %s", strerror(errno));
 }
 
+FILE *preimage = NULL;
+FILE *postimage = NULL;
+
 void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len,
 			uint32_t delta, uint32_t srcMark, uint32_t srcMode,
 			struct line_buffer *input)
 {
+	struct line_buffer preimage_buf = LINE_BUFFER_INIT;
+	struct line_buffer postimage_buf = LINE_BUFFER_INIT;
+	struct view preimage_view = {&preimage_buf, 0, STRBUF_INIT};
+	long preimage_len = 0;
+
+	if (delta) {
+		if (!preimage)
+			preimage = tmpfile();
+		if (srcMark) {
+			printf("cat :%"PRIu32"\n", srcMark);
+			fflush(stdout);
+			if (srcMode == REPO_MODE_LNK)
+				fwrite("link ", 1, 5, preimage);
+			fast_export_save_blob(preimage);
+		}
+		preimage_len = ftell(preimage);
+		fseek(preimage, 0, SEEK_SET);
+		preimage_buf.infile = preimage;
+		if (!postimage)
+			postimage = tmpfile();
+		svndiff0_apply(input, len, &preimage_view, postimage);
+		strbuf_release(&preimage_view.buf);
+		len = ftell(postimage);
+		fseek(postimage, 0, SEEK_SET);
+		postimage_buf.infile = postimage;
+	}
+
 	if (mode == REPO_MODE_LNK) {
 		/* svn symlink blobs start with "link " */
-		buffer_skip_bytes(input, 5);
+		if (delta)
+			buffer_skip_bytes(&postimage_buf, 5);
+		else
+			buffer_skip_bytes(input, 5);
 		len -= 5;
 	}
 	printf("blob\nmark :%"PRIu32"\ndata %"PRIu32"\n", mark, len);
-	buffer_copy_bytes(input, len);
+	if (!delta)
+		buffer_copy_bytes(input, len);
+	else
+		buffer_copy_bytes(&postimage_buf, len);
 	fputc('\n', stdout);
+
+	if (preimage) {
+		fseek(preimage, 0, SEEK_SET);
+		ftruncate(fileno(preimage), 0);
+	}
+
+	if (postimage) {
+		fseek(postimage, 0, SEEK_SET);
+		ftruncate(fileno(postimage), 0);
+	}
 }
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index 634d9c6..265a271 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -3,13 +3,21 @@
 
 #include "line_buffer.h"
 
+#ifndef SHA1_HEX_LENGTH
+#define SHA1_HEX_LENGTH 40
+#endif
+
 void fast_export_delete(uint32_t depth, uint32_t *path);
 void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mode,
 			uint32_t mark);
 void fast_export_commit(uint32_t revision, uint32_t author, char *log,
-			uint32_t uuid, uint32_t url, unsigned long timestamp);
+			uint32_t uuid, uint32_t url, unsigned long timestamp,
+			char tree_id[SHA1_HEX_LENGTH]);
 void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len,
 			uint32_t delta, uint32_t srcMark, uint32_t srcMode,
 			struct line_buffer *input);
 
+void fast_export_parse_commit(char tree_id[SHA1_HEX_LENGTH]);
+void fast_export_save_blob(FILE* file);
+
 #endif
diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index b616bda..e77abb2 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -12,6 +12,9 @@
 
 #include "trp.h"
 
+/* git hash-object -t tree --stdin </dev/null */
+#define EMPTY_TREE_HASH "4b825dc642cb6eb9a060e54bf8d69288fbee4904"
+
 struct repo_dirent {
 	uint32_t name_offset;
 	struct trp_node children;
@@ -25,6 +28,7 @@ struct repo_dir {
 
 struct repo_commit {
 	uint32_t root_dir_offset;
+	char tree_id[SHA1_HEX_LENGTH];
 };
 
 /* Memory pools for commit, dir and dirent */
@@ -308,7 +312,8 @@ void repo_diff(uint32_t r1, uint32_t r2)
 void repo_commit(uint32_t revision, uint32_t author, char *log, uint32_t uuid,
 		 uint32_t url, unsigned long timestamp)
 {
-	fast_export_commit(revision, author, log, uuid, url, timestamp);
+	fast_export_commit(revision, author, log, uuid, url, timestamp,
+				commit_pointer(active_commit)->tree_id);
 	dent_commit();
 	dir_commit();
 	active_commit = commit_alloc(1);
@@ -316,6 +321,11 @@ void repo_commit(uint32_t revision, uint32_t author, char *log, uint32_t uuid,
 		commit_pointer(active_commit - 1)->root_dir_offset;
 }
 
+char *repo_revision_tree(uint32_t revision)
+{
+	return commit_pointer(revision)->tree_id;
+}
+
 static void mark_init(void)
 {
 	uint32_t i;
@@ -334,6 +344,8 @@ void repo_init(void)
 		/* Create empty tree for commit 0. */
 		commit_alloc(1);
 		commit_pointer(0)->root_dir_offset = dir_alloc(1);
+		memcpy(commit_pointer(0)->tree_id, EMPTY_TREE_HASH,
+						SHA1_HEX_LENGTH);
 		dir_pointer(0)->entries.trp_root = ~0;
 		dir_commit();
 	}
diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
index bd6a3f7..3b3d58c 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -22,6 +22,7 @@ void repo_delete(uint32_t *path);
 void repo_commit(uint32_t revision, uint32_t author, char *log, uint32_t uuid,
 		 uint32_t url, long unsigned timestamp);
 void repo_diff(uint32_t r1, uint32_t r2);
+char *repo_revision_tree(uint32_t revision);
 void repo_init(void);
 void repo_reset(void);
 
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index e23aced..a8aa503 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -313,11 +313,10 @@ static int apply_one_window(struct line_buffer *delta, off_t *delta_len,
 }
 
 int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
-		   struct line_buffer *preimage, FILE *postimage)
+		   struct view *preimage_view, FILE *postimage)
 {
-	struct view preimage_view = {preimage, 0, STRBUF_INIT};
 	off_t out_offset = 0;
-	assert(delta && preimage && postimage);
+	assert(delta && preimage_view && postimage);
 
 	if (read_magic(delta, &delta_len))
 		goto fail;
@@ -326,9 +325,9 @@ int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
 		size_t pre_len;
 		if (read_offset(delta, &pre_off, &delta_len) ||
 		    read_length(delta, &pre_len, &delta_len) ||
-		    move_window(&preimage_view, pre_off, pre_len) ||
+		    move_window(preimage_view, pre_off, pre_len) ||
 		    apply_one_window(delta, &delta_len,
-				     &preimage_view, pre_len,
+				     preimage_view, pre_len,
 				     &out_offset, postimage))
 			goto fail;
 		if (delta_len && buffer_at_eof(delta)) {
@@ -337,9 +336,7 @@ int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
 			goto fail;
 		}
 	}
-	strbuf_release(&preimage_view.buf);
 	return 0;
  fail:
-	strbuf_release(&preimage_view.buf);
 	return -1;
 }
diff --git a/vcs-svn/svndiff.h b/vcs-svn/svndiff.h
index a986099..f75dec3 100644
--- a/vcs-svn/svndiff.h
+++ b/vcs-svn/svndiff.h
@@ -2,8 +2,9 @@
 #define SVNDIFF_H_
 
 #include "line_buffer.h"
+#include "sliding_window.h"
 
 extern int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
-			  struct line_buffer *preimage, FILE *postimage);
+			  struct view *preimage_view, FILE *postimage);
 
 #endif
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 3431c22..f408458 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -30,6 +30,9 @@
 #define MD5_HEX_LENGTH 32
 #define SHA1_HEX_LENGTH 40
 
+/* git hash-object -t tree --stdin </dev/null */
+#define EMPTY_TREE_HASH "4b825dc642cb6eb9a060e54bf8d69288fbee4904"
+
 /* Create memory pool for log messages */
 obj_pool_gen(log, char, 4096)
 
@@ -58,6 +61,7 @@ static struct {
 	uint32_t revision, author;
 	unsigned long timestamp;
 	char *log;
+	char tree_id[SHA1_HEX_LENGTH + 1];
 } rev_ctx;
 
 static struct {
@@ -103,6 +107,8 @@ static void reset_rev_ctx(uint32_t revision)
 	rev_ctx.timestamp = 0;
 	rev_ctx.log = NULL;
 	rev_ctx.author = ~0;
+	if (!revision)
+		memcpy(rev_ctx.tree_id, EMPTY_TREE_HASH, SHA1_HEX_LENGTH + 1);
 }
 
 static void reset_dump_ctx(uint32_t url)
-- 
1.7.3.1
