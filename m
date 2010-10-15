From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 2/5] vcs-svn: Extend svndump to parse version 3 format
Date: Fri, 15 Oct 2010 23:54:13 +1100
Message-ID: <1287147256-9457-3-git-send-email-david.barr@cordelta.com>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 15 14:55:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6jof-0007tx-Nr
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 14:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798Ab0JOMyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 08:54:39 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:37305 "EHLO
	mail08.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755792Ab0JOMyi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 08:54:38 -0400
Received: from localhost.localdomain (d110-33-95-167.mit3.act.optusnet.com.au [110.33.95.167])
	by mail08.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id o9FCsPsm006314;
	Fri, 15 Oct 2010 23:54:29 +1100
X-Mailer: git-send-email 1.7.3.32.g634ef
In-Reply-To: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159114>

Add 1 new dump header, SVN-fs-dump-format-version.
Add 6 new node headers:
* Text-delta: true|false
* Prop-delta: true|false
* Text-delta-base-md5: <32 hex digits>
* Text-delta-base-sha1: <40 hex digits>
* Text-copy-source-sha1: <40 hex digits>
* Text-content-sha1: <40 hex digits>

This change simply populates the context.
Further changes will be needed to handle text and prop deltas.

Signed-off-by: David Barr <david.barr@cordelta.com>
---
 vcs-svn/svndump.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 3bba0fe..458053e 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -27,6 +27,9 @@
 #define LENGTH_UNKNOWN (~0)
 #define DATE_RFC2822_LEN 31
 
+#define MD5_HEX_LENGTH 32
+#define SHA1_HEX_LENGTH 40
+
 /* Create memory pool for log messages */
 obj_pool_gen(log, char, 4096)
 
@@ -44,6 +47,11 @@ static char* log_copy(uint32_t length, char *log)
 static struct {
 	uint32_t action, propLength, textLength, srcRev, srcMode, mark, type;
 	uint32_t src[REPO_MAX_PATH_DEPTH], dst[REPO_MAX_PATH_DEPTH];
+	uint32_t text_delta, prop_delta;
+	char text_delta_base_md5[MD5_HEX_LENGTH + 1];
+	char text_content_sha1[SHA1_HEX_LENGTH + 1];
+	char text_delta_base_sha1[SHA1_HEX_LENGTH + 1];
+	char text_copy_source_sha1[SHA1_HEX_LENGTH + 1];
 } node_ctx;
 
 static struct {
@@ -53,14 +61,20 @@ static struct {
 } rev_ctx;
 
 static struct {
-	uint32_t uuid, url;
+	uint32_t version, uuid, url;
 } dump_ctx;
 
 static struct {
-	uint32_t svn_log, svn_author, svn_date, svn_executable, svn_special, uuid,
+	uint32_t svn_log, svn_author, svn_date, svn_executable, svn_special,
 		revision_number, node_path, node_kind, node_action,
 		node_copyfrom_path, node_copyfrom_rev, text_content_length,
-		prop_content_length, content_length;
+		prop_content_length, content_length,
+		/* SVN dump version 2 */
+		uuid, svn_fs_dump_format_version,
+		/* SVN dump version 3 */
+		text_delta, prop_delta, text_content_sha1,
+		text_delta_base_md5, text_delta_base_sha1,
+		text_copy_source_sha1;
 } keys;
 
 static void reset_node_ctx(char *fname)
@@ -74,6 +88,12 @@ static void reset_node_ctx(char *fname)
 	node_ctx.srcMode = 0;
 	pool_tok_seq(REPO_MAX_PATH_DEPTH, node_ctx.dst, "/", fname);
 	node_ctx.mark = 0;
+	node_ctx.text_delta = 0;
+	node_ctx.prop_delta = 0;
+	*node_ctx.text_delta_base_md5 = '\0';
+	*node_ctx.text_content_sha1 = '\0';
+	*node_ctx.text_delta_base_sha1 = '\0';
+	*node_ctx.text_copy_source_sha1 = '\0';
 }
 
 static void reset_rev_ctx(uint32_t revision)
@@ -87,6 +107,7 @@ static void reset_rev_ctx(uint32_t revision)
 static void reset_dump_ctx(uint32_t url)
 {
 	dump_ctx.url = url;
+	dump_ctx.version = 1;
 	dump_ctx.uuid = ~0;
 }
 
@@ -97,7 +118,6 @@ static void init_keys(void)
 	keys.svn_date = pool_intern("svn:date");
 	keys.svn_executable = pool_intern("svn:executable");
 	keys.svn_special = pool_intern("svn:special");
-	keys.uuid = pool_intern("UUID");
 	keys.revision_number = pool_intern("Revision-number");
 	keys.node_path = pool_intern("Node-path");
 	keys.node_kind = pool_intern("Node-kind");
@@ -107,6 +127,16 @@ static void init_keys(void)
 	keys.text_content_length = pool_intern("Text-content-length");
 	keys.prop_content_length = pool_intern("Prop-content-length");
 	keys.content_length = pool_intern("Content-length");
+	/* SVN dump version 2 */
+	keys.svn_fs_dump_format_version = pool_intern("SVN-fs-dump-format-version");
+	keys.uuid = pool_intern("UUID");
+	/* SVN dump version 3 */
+	keys.text_delta = pool_intern("Text-delta");
+	keys.prop_delta = pool_intern("Prop-delta");
+	keys.text_delta_base_md5 = pool_intern("Text-delta-base-md5");
+	keys.text_delta_base_sha1 = pool_intern("Text-delta-base-sha1");
+	keys.text_copy_source_sha1 = pool_intern("Text-copy-source-sha1");
+	keys.text_content_sha1 = pool_intern("Text-content-sha1");
 }
 
 static void read_props(void)
@@ -209,7 +239,9 @@ void svndump_read(const char *url)
 		*val++ = '\0';
 		key = pool_intern(t);
 
-		if (key == keys.uuid) {
+		if (key == keys.svn_fs_dump_format_version) {
+			dump_ctx.version = atoi(val);
+		} else if (key == keys.uuid) {
 			dump_ctx.uuid = pool_intern(val);
 		} else if (key == keys.revision_number) {
 			if (active_ctx == NODE_CTX)
@@ -251,6 +283,22 @@ void svndump_read(const char *url)
 			node_ctx.textLength = atoi(val);
 		} else if (key == keys.prop_content_length) {
 			node_ctx.propLength = atoi(val);
+		} else if (key == keys.text_delta) {
+			node_ctx.text_delta = !strcmp(val, "true");
+		} else if (key == keys.prop_delta) {
+			node_ctx.prop_delta = !strcmp(val, "true");
+		} else if (key == keys.text_delta_base_md5) {
+			strncpy(node_ctx.text_delta_base_md5, val,
+				MD5_HEX_LENGTH + 1);
+		} else if (key == keys.text_delta_base_sha1) {
+			strncpy(node_ctx.text_delta_base_sha1, val,
+				SHA1_HEX_LENGTH + 1);
+		} else if (key == keys.text_copy_source_sha1) {
+			strncpy(node_ctx.text_copy_source_sha1, val,
+				SHA1_HEX_LENGTH + 1);
+		} else if (key == keys.text_content_sha1) {
+			strncpy(node_ctx.text_content_sha1, val,
+				SHA1_HEX_LENGTH + 1);
 		} else if (key == keys.content_length) {
 			len = atoi(val);
 			buffer_read_line(&input);
-- 
1.7.3.32.g634ef
