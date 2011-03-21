From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 2/3] vcs-svn: implement perfect hash for top-level keys
Date: Mon, 21 Mar 2011 12:26:16 +1100
Message-ID: <1300670777-17197-2-git-send-email-david.barr@cordelta.com>
References: <20110319085138.GB6706@elie>
 <1300670777-17197-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 21 02:27:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Ttb-0002pY-PQ
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 02:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439Ab1CUB0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 21:26:46 -0400
Received: from mailhost.cordelta.com ([119.15.97.146]:60389 "EHLO
	mailhost.cordelta" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752384Ab1CUB0p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 21:26:45 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 4AA9CC053;
	Mon, 21 Mar 2011 12:23:11 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7f02rLPtjA7t; Mon, 21 Mar 2011 12:23:07 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 5AE1FC052;
	Mon, 21 Mar 2011 12:23:07 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300670777-17197-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169546>

This eliminates one more dependency on string_pool.

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 vcs-svn/svndump.c |  110 +++++++++++++++++++++++++++++------------------------
 1 files changed, 60 insertions(+), 50 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 48848ff..f03e8cf 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -51,14 +51,6 @@ static struct {
 	uint32_t version, uuid, url;
 } dump_ctx;
 
-static struct {
-	uint32_t uuid, revision_number, node_path, node_kind, node_action,
-		node_copyfrom_path, node_copyfrom_rev, text_content_length,
-		prop_content_length, content_length, svn_fs_dump_format_version,
-		/* version 3 format */
-		text_delta, prop_delta;
-} keys;
-
 static void reset_node_ctx(char *fname)
 {
 	node_ctx.type = 0;
@@ -89,24 +81,6 @@ static void reset_dump_ctx(uint32_t url)
 	dump_ctx.uuid = ~0;
 }
 
-static void init_keys(void)
-{
-	keys.uuid = pool_intern("UUID");
-	keys.revision_number = pool_intern("Revision-number");
-	keys.node_path = pool_intern("Node-path");
-	keys.node_kind = pool_intern("Node-kind");
-	keys.node_action = pool_intern("Node-action");
-	keys.node_copyfrom_path = pool_intern("Node-copyfrom-path");
-	keys.node_copyfrom_rev = pool_intern("Node-copyfrom-rev");
-	keys.text_content_length = pool_intern("Text-content-length");
-	keys.prop_content_length = pool_intern("Prop-content-length");
-	keys.content_length = pool_intern("Content-length");
-	keys.svn_fs_dump_format_version = pool_intern("SVN-fs-dump-format-version");
-	/* version 3 format (Subversion 1.1.0) */
-	keys.text_delta = pool_intern("Text-delta");
-	keys.prop_delta = pool_intern("Prop-delta");
-}
-
 /* Compare string to literal of equal length; must be guarded by length test. */
 #define constcmp(s, ref) memcmp((s), (ref), sizeof(ref) - 1)
 
@@ -326,7 +300,6 @@ void svndump_read(const char *url)
 	char *t;
 	uint32_t active_ctx = DUMP_CTX;
 	uint32_t len;
-	uint32_t key;
 
 	reset_dump_ctx(pool_intern(url));
 	while ((t = buffer_read_line(&input))) {
@@ -335,16 +308,25 @@ void svndump_read(const char *url)
 			continue;
 		*val++ = '\0';
 		*val++ = '\0';
-		key = pool_intern(t);
 
-		if (key == keys.svn_fs_dump_format_version) {
+		/* strlen(key) + 1 */
+		switch (val - t - 1) {
+		case sizeof("SVN-fs-dump-format-version"):
+			if (constcmp(t, "SVN-fs-dump-format-version"))
+				continue;
 			dump_ctx.version = atoi(val);
 			if (dump_ctx.version > 3)
 				die("expected svn dump format version <= 3, found %"PRIu32,
 				    dump_ctx.version);
-		} else if (key == keys.uuid) {
+			break;
+		case sizeof("UUID"):
+			if (constcmp(t, "UUID"))
+				continue;
 			dump_ctx.uuid = pool_intern(val);
-		} else if (key == keys.revision_number) {
+			break;
+		case sizeof("Revision-number"):
+			if (constcmp(t, "Revision-number"))
+				continue;
 			if (active_ctx == NODE_CTX)
 				handle_node();
 			if (active_ctx == REV_CTX)
@@ -353,21 +335,31 @@ void svndump_read(const char *url)
 				end_revision();
 			active_ctx = REV_CTX;
 			reset_rev_ctx(atoi(val));
-		} else if (key == keys.node_path) {
-			if (active_ctx == NODE_CTX)
-				handle_node();
-			if (active_ctx == REV_CTX)
-				begin_revision();
-			active_ctx = NODE_CTX;
-			reset_node_ctx(val);
-		} else if (key == keys.node_kind) {
+			break;
+		case sizeof("Node-path"):
+			if (prefixcmp(t, "Node-"))
+				continue;
+			if (!constcmp(t + strlen("Node-"), "path")) {
+				if (active_ctx == NODE_CTX)
+					handle_node();
+				if (active_ctx == REV_CTX)
+					begin_revision();
+				active_ctx = NODE_CTX;
+				reset_node_ctx(val);
+				break;
+			}
+			if (constcmp(t + strlen("Node-"), "kind"))
+				continue;
 			if (!strcmp(val, "dir"))
 				node_ctx.type = REPO_MODE_DIR;
 			else if (!strcmp(val, "file"))
 				node_ctx.type = REPO_MODE_BLB;
 			else
 				fprintf(stderr, "Unknown node-kind: %s\n", val);
-		} else if (key == keys.node_action) {
+			break;
+		case sizeof("Node-action"):
+			if (constcmp(t, "Node-action"))
+				continue;
 			if (!strcmp(val, "delete")) {
 				node_ctx.action = NODEACT_DELETE;
 			} else if (!strcmp(val, "add")) {
@@ -380,20 +372,39 @@ void svndump_read(const char *url)
 				fprintf(stderr, "Unknown node-action: %s\n", val);
 				node_ctx.action = NODEACT_UNKNOWN;
 			}
-		} else if (key == keys.node_copyfrom_path) {
+			break;
+		case sizeof("Node-copyfrom-path"):
+			if (constcmp(t, "Node-copyfrom-path"))
+				continue;
 			strbuf_reset(&node_ctx.src);
 			strbuf_addstr(&node_ctx.src, val);
-		} else if (key == keys.node_copyfrom_rev) {
+			break;
+		case sizeof("Node-copyfrom-rev"):
+			if (constcmp(t, "Node-copyfrom-rev"))
+				continue;
 			node_ctx.srcRev = atoi(val);
-		} else if (key == keys.text_content_length) {
-			node_ctx.textLength = atoi(val);
-		} else if (key == keys.prop_content_length) {
+			break;
+		case sizeof("Text-content-length"):
+			if (!constcmp(t, "Text-content-length")) {
+				node_ctx.textLength = atoi(val);
+				break;
+			}
+			if (constcmp(t, "Prop-content-length"))
+				continue;
 			node_ctx.propLength = atoi(val);
-		} else if (key == keys.text_delta) {
-			node_ctx.text_delta = !strcmp(val, "true");
-		} else if (key == keys.prop_delta) {
+			break;
+		case sizeof("Text-delta"):
+			if (!constcmp(t, "Text-delta")) {
+				node_ctx.text_delta = !strcmp(val, "true");
+				break;
+			}
+			if (constcmp(t, "Prop-delta"))
+				continue;
 			node_ctx.prop_delta = !strcmp(val, "true");
-		} else if (key == keys.content_length) {
+			break;
+		case sizeof("Content-length"):
+			if (constcmp(t, "Content-length"))
+				continue;
 			len = atoi(val);
 			buffer_read_line(&input);
 			if (active_ctx == REV_CTX) {
@@ -426,7 +437,6 @@ int svndump_init(const char *filename)
 	reset_dump_ctx(~0);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
-	init_keys();
 	return 0;
 }
 
-- 
1.7.3.2.846.gf4b062
