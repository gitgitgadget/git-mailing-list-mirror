From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 3/5] vcs-svn: Implement prop-delta handling.
Date: Fri, 15 Oct 2010 23:54:14 +1100
Message-ID: <1287147256-9457-4-git-send-email-david.barr@cordelta.com>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 15 14:55:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6jog-0007tx-OY
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 14:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559Ab0JOMyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 08:54:47 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:37298 "EHLO
	mail08.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755759Ab0JOMyg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 08:54:36 -0400
Received: from localhost.localdomain (d110-33-95-167.mit3.act.optusnet.com.au [110.33.95.167])
	by mail08.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id o9FCsPsn006314;
	Fri, 15 Oct 2010 23:54:30 +1100
X-Mailer: git-send-email 1.7.3.32.g634ef
In-Reply-To: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159115>

By testing against the Apache Software Foundation
repository, some simple rules for decoding prop
deltas were derived.

'Node-action: replace' implies the empty prop set
as the base for the delta.
Otherwise, if a copyfrom source is given that node
forms the basis for the delta.
Lastly, if the destination path exists in the active
revision it forms the basis.

The same rules ought to apply to text deltas as well.

Apply these rules to prop handling.
Add a placeholder srcMark parameter to fast_export_blob().

Signed-off-by: David Barr <david.barr@cordelta.com>
---
 vcs-svn/fast_export.c |    4 +++-
 vcs-svn/fast_export.h |    3 ++-
 vcs-svn/repo_tree.c   |   23 +++++++++++++++++++++++
 vcs-svn/repo_tree.h   |    2 ++
 vcs-svn/svndump.c     |   35 +++++++++++++++++++++++++++++++----
 5 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 260cf50..d984aaa 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -63,7 +63,9 @@ void fast_export_commit(uint32_t revision, uint32_t author, char *log,
 	printf("progress Imported commit %"PRIu32".\n\n", revision);
 }
 
-void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len, struct line_buffer *input)
+void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len,
+			uint32_t delta, uint32_t srcMark, uint32_t srcMode,
+			struct line_buffer *input)
 {
 	if (mode == REPO_MODE_LNK) {
 		/* svn symlink blobs start with "link " */
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index 054e7d5..634d9c6 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -9,6 +9,7 @@ void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mode,
 void fast_export_commit(uint32_t revision, uint32_t author, char *log,
 			uint32_t uuid, uint32_t url, unsigned long timestamp);
 void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len,
-		      struct line_buffer *input);
+			uint32_t delta, uint32_t srcMark, uint32_t srcMode,
+			struct line_buffer *input);
 
 #endif
diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index e94d91d..b616bda 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -157,6 +157,29 @@ static void repo_write_dirent(uint32_t *path, uint32_t mode,
 		dent_remove(&dir_pointer(parent_dir_o)->entries, dent);
 }
 
+uint32_t repo_read_mark(uint32_t revision, uint32_t *path)
+{
+	uint32_t mode = 0, content_offset = 0;
+	struct repo_dirent *src_dent;
+	src_dent = repo_read_dirent(revision, path);
+	if (src_dent != NULL) {
+		mode = src_dent->mode;
+		content_offset = src_dent->content_offset;
+	}
+	return mode && mode != REPO_MODE_DIR ? content_offset : 0;
+}
+
+uint32_t repo_read_mode(uint32_t revision, uint32_t *path)
+{
+	uint32_t mode = 0;
+	struct repo_dirent *src_dent;
+	src_dent = repo_read_dirent(revision, path);
+	if (src_dent != NULL) {
+		mode = src_dent->mode;
+	}
+	return mode;
+}
+
 uint32_t repo_copy(uint32_t revision, uint32_t *src, uint32_t *dst)
 {
 	uint32_t mode = 0, content_offset = 0;
diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
index 5476175..bd6a3f7 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -12,6 +12,8 @@
 #define REPO_MAX_PATH_DEPTH 1000
 
 uint32_t next_blob_mark(void);
+uint32_t repo_read_mark(uint32_t revision, uint32_t *path);
+uint32_t repo_read_mode(uint32_t revision, uint32_t *path);
 uint32_t repo_copy(uint32_t revision, uint32_t *src, uint32_t *dst);
 void repo_add(uint32_t *path, uint32_t mode, uint32_t blob_mark);
 uint32_t repo_replace(uint32_t *path, uint32_t blob_mark);
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 458053e..3431c22 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -45,7 +45,7 @@ static char* log_copy(uint32_t length, char *log)
 }
 
 static struct {
-	uint32_t action, propLength, textLength, srcRev, srcMode, mark, type;
+	uint32_t action, propLength, textLength, srcRev, srcMode, srcMark, mark, type;
 	uint32_t src[REPO_MAX_PATH_DEPTH], dst[REPO_MAX_PATH_DEPTH];
 	uint32_t text_delta, prop_delta;
 	char text_delta_base_md5[MD5_HEX_LENGTH + 1];
@@ -86,6 +86,7 @@ static void reset_node_ctx(char *fname)
 	node_ctx.src[0] = ~0;
 	node_ctx.srcRev = 0;
 	node_ctx.srcMode = 0;
+	node_ctx.srcMark = 0;
 	pool_tok_seq(REPO_MAX_PATH_DEPTH, node_ctx.dst, "/", fname);
 	node_ctx.mark = 0;
 	node_ctx.text_delta = 0;
@@ -168,17 +169,42 @@ static void read_props(void)
 			}
 			key = ~0;
 			buffer_read_line(&input);
+		} else if (!strncmp(t, "D ", 2)) {
+			len = atoi(&t[2]);
+			key = pool_intern(buffer_read_string(&input, len));
+			buffer_read_line(&input);
+			if (key == keys.svn_executable) {
+				if (node_ctx.type == REPO_MODE_EXE)
+					node_ctx.type = REPO_MODE_BLB;
+			} else if (key == keys.svn_special) {
+				if (node_ctx.type == REPO_MODE_LNK)
+					node_ctx.type = REPO_MODE_BLB;
+			}
+			key = ~0;
 		}
 	}
 }
 
 static void handle_node(void)
 {
+	if (node_ctx.prop_delta) {
+		if (node_ctx.srcRev)
+			node_ctx.srcMode = repo_read_mode(node_ctx.srcRev, node_ctx.src);
+		else
+			node_ctx.srcMode = repo_read_mode(rev_ctx.revision, node_ctx.dst);
+		if (node_ctx.srcMode && node_ctx.action != NODEACT_REPLACE)
+			node_ctx.type = node_ctx.srcMode;
+	}
+
 	if (node_ctx.propLength != LENGTH_UNKNOWN && node_ctx.propLength)
 		read_props();
 
-	if (node_ctx.srcRev)
+	if (node_ctx.srcRev) {
+		node_ctx.srcMark = repo_read_mark(node_ctx.srcRev, node_ctx.src);
 		node_ctx.srcMode = repo_copy(node_ctx.srcRev, node_ctx.src, node_ctx.dst);
+	} else {
+		node_ctx.srcMark = repo_read_mark(rev_ctx.revision, node_ctx.dst);
+	}
 
 	if (node_ctx.textLength != LENGTH_UNKNOWN &&
 	    node_ctx.type != REPO_MODE_DIR)
@@ -209,8 +235,9 @@ static void handle_node(void)
 		node_ctx.type = node_ctx.srcMode;
 
 	if (node_ctx.mark)
-		fast_export_blob(node_ctx.type,
-				 node_ctx.mark, node_ctx.textLength, &input);
+		fast_export_blob(node_ctx.type, node_ctx.mark, node_ctx.textLength,
+				node_ctx.text_delta, node_ctx.srcMark, node_ctx.srcMode,
+				&input);
 	else if (node_ctx.textLength != LENGTH_UNKNOWN)
 		buffer_skip_bytes(&input, node_ctx.textLength);
 }
-- 
1.7.3.32.g634ef
