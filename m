From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 04/11] vcs-svn: implement perfect hash for node-prop keys
Date: Tue, 22 Mar 2011 10:49:53 +1100
Message-ID: <1300751400-7427-5-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300751400-7427-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 22 00:50:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1ory-0006bP-C8
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 00:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755935Ab1CUXue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 19:50:34 -0400
Received: from mailhost.cordelta.com ([119.15.97.146]:60716 "EHLO
	mailhost.cordelta" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755196Ab1CUXuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 19:50:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 89454C051;
	Tue, 22 Mar 2011 10:46:47 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sHI6HG3crN3c; Tue, 22 Mar 2011 10:46:38 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 56113C056;
	Tue, 22 Mar 2011 10:46:38 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300751400-7427-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169686>

This eliminates one more dependency on string_pool.

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 vcs-svn/svndump.c |   57 +++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 15b173e..46ae5fa 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -52,8 +52,7 @@ static struct {
 } dump_ctx;
 
 static struct {
-	uint32_t svn_log, svn_author, svn_date, svn_executable, svn_special, uuid,
-		revision_number, node_path, node_kind, node_action,
+	uint32_t uuid, revision_number, node_path, node_kind, node_action,
 		node_copyfrom_path, node_copyfrom_rev, text_content_length,
 		prop_content_length, content_length, svn_fs_dump_format_version,
 		/* version 3 format */
@@ -92,11 +91,6 @@ static void reset_dump_ctx(uint32_t url)
 
 static void init_keys(void)
 {
-	keys.svn_log = pool_intern("svn:log");
-	keys.svn_author = pool_intern("svn:author");
-	keys.svn_date = pool_intern("svn:date");
-	keys.svn_executable = pool_intern("svn:executable");
-	keys.svn_special = pool_intern("svn:special");
 	keys.uuid = pool_intern("UUID");
 	keys.revision_number = pool_intern("Revision-number");
 	keys.node_path = pool_intern("Node-path");
@@ -113,22 +107,44 @@ static void init_keys(void)
 	keys.prop_delta = pool_intern("Prop-delta");
 }
 
-static void handle_property(uint32_t key, const char *val, uint32_t len,
+/* Compare string to literal of equal length; must be guarded by length test. */
+#define constcmp(s, ref) memcmp((s), (ref), sizeof(ref) - 1)
+
+static void handle_property(struct strbuf *key_buf, const char *val, uint32_t len,
 				uint32_t *type_set)
 {
-	if (key == keys.svn_log) {
+	const int sizeof_key = key_buf->len + 1;
+	const char *key = key_buf->buf;
+	switch (sizeof_key) {
+	case sizeof("svn:log"):
+		if (constcmp(key, "svn:log"))
+			break;
 		if (!val)
 			die("invalid dump: unsets svn:log");
 		/* Value length excludes terminating nul. */
 		strbuf_add(&rev_ctx.log, val, len + 1);
-	} else if (key == keys.svn_author) {
+		break;
+	case sizeof("svn:author"):
+		if (constcmp(key, "svn:author"))
+			break;
 		rev_ctx.author = pool_intern(val);
-	} else if (key == keys.svn_date) {
+		break;
+	case sizeof("svn:date"):
+		if (constcmp(key, "svn:date"))
+			break;
 		if (!val)
 			die("invalid dump: unsets svn:date");
 		if (parse_date_basic(val, &rev_ctx.timestamp, NULL))
 			warning("invalid timestamp: %s", val);
-	} else if (key == keys.svn_executable || key == keys.svn_special) {
+		break;
+	case sizeof("svn:executable"):
+	case sizeof("svn:special"):
+		if (sizeof_key == sizeof("svn:executable") &&
+		    constcmp(key, "svn:executable"))
+			break;
+		if (sizeof_key == sizeof("svn:special") &&
+		    constcmp(key, "svn:special"))
+			break;
 		if (*type_set) {
 			if (!val)
 				return;
@@ -139,7 +155,7 @@ static void handle_property(uint32_t key, const char *val, uint32_t len,
 			return;
 		}
 		*type_set = 1;
-		node_ctx.type = key == keys.svn_executable ?
+		node_ctx.type = sizeof_key == sizeof("svn:executable") ?
 				REPO_MODE_EXE :
 				REPO_MODE_LNK;
 	}
@@ -147,7 +163,7 @@ static void handle_property(uint32_t key, const char *val, uint32_t len,
 
 static void read_props(void)
 {
-	uint32_t key = ~0;
+	static struct strbuf key = STRBUF_INIT;
 	const char *t;
 	/*
 	 * NEEDSWORK: to support simple mode changes like
@@ -175,16 +191,19 @@ static void read_props(void)
 
 		switch (type) {
 		case 'K':
-			key = pool_intern(val);
-			continue;
 		case 'D':
-			key = pool_intern(val);
+			strbuf_reset(&key);
+			if (val)
+				strbuf_add(&key, val, len);
+			if (type == 'K')
+				continue;
+			assert(type == 'D');
 			val = NULL;
 			len = 0;
 			/* fall through */
 		case 'V':
-			handle_property(key, val, len, &type_set);
-			key = ~0;
+			handle_property(&key, val, len, &type_set);
+			strbuf_reset(&key);
 			continue;
 		default:
 			die("invalid property line: %s\n", t);
-- 
1.7.3.2.846.gf4b062
