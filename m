From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 4/9] vcs-svn: implement perfect hash for top-level keys
Date: Sat, 19 Mar 2011 18:03:46 +1100
Message-ID: <1300518231-20008-5-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:12:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qLG-0004uk-7S
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251Ab1CSHMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:12:39 -0400
Received: from [119.15.97.146] ([119.15.97.146]:60437 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753891Ab1CSHMN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:12:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 05893C050;
	Sat, 19 Mar 2011 18:00:37 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hNu78HRZFcAv; Sat, 19 Mar 2011 18:00:32 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 603D5C04F;
	Sat, 19 Mar 2011 18:00:28 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169391>

This eliminates one more dependency on string_pool.

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 vcs-svn/svndump.c |  110 +++++++++++++++++++++++++++++------------------------
 1 files changed, 60 insertions(+), 50 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 49fb6db..03f916d 100644
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
 static void handle_property(const char *key, const char *val, uint32_t len,
 				uint32_t *type_set)
 {
@@ -314,7 +288,6 @@ void svndump_read(const char *url)
 	char *t;
 	uint32_t active_ctx = DUMP_CTX;
 	uint32_t len;
-	uint32_t key;
 
 	reset_dump_ctx(pool_intern(url));
 	while ((t = buffer_read_line(&input))) {
@@ -323,16 +296,25 @@ void svndump_read(const char *url)
 			continue;
 		*val++ = '\0';
 		*val++ = '\0';
-		key = pool_intern(t);
 
-		if (key == keys.svn_fs_dump_format_version) {
+		/* strlen(key) */
+		switch (val - t - 2) { 
+		case 26:
+			if (memcmp(t, "SVN-fs-dump-format-version", 26))
+				continue;
 			dump_ctx.version = atoi(val);
 			if (dump_ctx.version > 3)
 				die("expected svn dump format version <= 3, found %"PRIu32,
 				    dump_ctx.version);
-		} else if (key == keys.uuid) {
+			break;
+		case 4:
+			if (memcmp(t, "UUID", 4))
+				continue;
 			dump_ctx.uuid = pool_intern(val);
-		} else if (key == keys.revision_number) {
+			break;
+		case 15:
+			if (memcmp(t, "Revision-number", 15))
+				continue;
 			if (active_ctx == NODE_CTX)
 				handle_node();
 			if (active_ctx == REV_CTX)
@@ -341,21 +323,31 @@ void svndump_read(const char *url)
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
+		case 9:
+			if (prefixcmp(t, "Node-"))
+				continue;
+			if (!memcmp(t + strlen("Node-"), "path", 4)) {
+				if (active_ctx == NODE_CTX)
+					handle_node();
+				if (active_ctx == REV_CTX)
+					begin_revision();
+				active_ctx = NODE_CTX;
+				reset_node_ctx(val);
+				break;
+			}
+			if (memcmp(t + strlen("Node-"), "kind", 4))
+				continue;
 			if (!strcmp(val, "dir"))
 				node_ctx.type = REPO_MODE_DIR;
 			else if (!strcmp(val, "file"))
 				node_ctx.type = REPO_MODE_BLB;
 			else
 				fprintf(stderr, "Unknown node-kind: %s\n", val);
-		} else if (key == keys.node_action) {
+			break;
+		case 11:
+			if (memcmp(t, "Node-action", 11))
+				continue;
 			if (!strcmp(val, "delete")) {
 				node_ctx.action = NODEACT_DELETE;
 			} else if (!strcmp(val, "add")) {
@@ -368,20 +360,39 @@ void svndump_read(const char *url)
 				fprintf(stderr, "Unknown node-action: %s\n", val);
 				node_ctx.action = NODEACT_UNKNOWN;
 			}
-		} else if (key == keys.node_copyfrom_path) {
+			break;
+		case 18:
+			if (memcmp(t, "Node-copyfrom-path", 18))
+				continue;
 			strbuf_reset(&node_ctx.src);
 			strbuf_addstr(&node_ctx.src, val);
-		} else if (key == keys.node_copyfrom_rev) {
+			break;
+		case 17:
+			if (memcmp(t, "Node-copyfrom-rev", 17))
+				continue;
 			node_ctx.srcRev = atoi(val);
-		} else if (key == keys.text_content_length) {
-			node_ctx.textLength = atoi(val);
-		} else if (key == keys.prop_content_length) {
+			break;
+		case 19:
+			if (!memcmp(t, "Text-content-length", 19)) {
+				node_ctx.textLength = atoi(val);
+				break;
+			}
+			if (memcmp(t, "Prop-content-length", 19))
+				continue;
 			node_ctx.propLength = atoi(val);
-		} else if (key == keys.text_delta) {
-			node_ctx.text_delta = !strcmp(val, "true");
-		} else if (key == keys.prop_delta) {
+			break;
+		case 10:
+			if (!memcmp(t, "Text-delta", 10)) {
+				node_ctx.text_delta = !strcmp(val, "true");
+				break;
+			}
+			if (memcmp(t, "Prop-delta", 10))
+				continue;
 			node_ctx.prop_delta = !strcmp(val, "true");
-		} else if (key == keys.content_length) {
+			break;
+		case 14:
+			if (memcmp(t, "Content-length", 14))
+				continue;
 			len = atoi(val);
 			buffer_read_line(&input);
 			if (active_ctx == REV_CTX) {
@@ -414,7 +425,6 @@ int svndump_init(const char *filename)
 	reset_dump_ctx(~0);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
-	init_keys();
 	return 0;
 }
 
-- 
1.7.3.2.846.gf4b062
