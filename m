From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 1/3] vcs-svn: implement perfect hash for node-prop keys
Date: Mon, 21 Mar 2011 12:26:15 +1100
Message-ID: <1300670777-17197-1-git-send-email-david.barr@cordelta.com>
References: <20110319085138.GB6706@elie>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 21 02:27:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Ttd-0002pY-1H
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 02:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539Ab1CUB0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 21:26:51 -0400
Received: from mailhost.cordelta.com ([119.15.97.146]:58228 "EHLO
	mailhost.cordelta" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752429Ab1CUB0s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 21:26:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 0ED3FC055;
	Mon, 21 Mar 2011 12:23:10 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TDRpH2Kz-yie; Mon, 21 Mar 2011 12:23:07 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 2C13AC050;
	Mon, 21 Mar 2011 12:23:07 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <20110319085138.GB6706@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169548>

This eliminates one more dependency on string_pool.

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 vcs-svn/svndump.c |   64 +++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 15b173e..48848ff 100644
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
@@ -113,22 +107,43 @@ static void init_keys(void)
 	keys.prop_delta = pool_intern("Prop-delta");
 }
 
-static void handle_property(uint32_t key, const char *val, uint32_t len,
+/* Compare string to literal of equal length; must be guarded by length test. */
+#define constcmp(s, ref) memcmp((s), (ref), sizeof(ref) - 1)
+
+static void handle_property(const char *key, const int sizeof_key,
+				const char *val, uint32_t len,
 				uint32_t *type_set)
 {
-	if (key == keys.svn_log) {
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
@@ -139,7 +154,7 @@ static void handle_property(uint32_t key, const char *val, uint32_t len,
 			return;
 		}
 		*type_set = 1;
-		node_ctx.type = key == keys.svn_executable ?
+		node_ctx.type = sizeof_key == sizeof("svn:executable") ?
 				REPO_MODE_EXE :
 				REPO_MODE_LNK;
 	}
@@ -147,7 +162,9 @@ static void handle_property(uint32_t key, const char *val, uint32_t len,
 
 static void read_props(void)
 {
-	uint32_t key = ~0;
+	/* Reserve enough space for the longest standard key. */
+	char key[sizeof("svn:executable")] = {0};
+	int sizeof_key = 1;
 	const char *t;
 	/*
 	 * NEEDSWORK: to support simple mode changes like
@@ -175,16 +192,25 @@ static void read_props(void)
 
 		switch (type) {
 		case 'K':
-			key = pool_intern(val);
-			continue;
 		case 'D':
-			key = pool_intern(val);
+			if (len < sizeof(key) && val) {
+				memcpy(key, val, len + 1);
+				sizeof_key = len + 1;
+			} else {
+				/* nonstandard key. */
+				*key = '\0';
+				sizeof_key = 1;
+			}
+			if (type == 'K')
+				continue;
+			assert(type == 'D');
 			val = NULL;
 			len = 0;
 			/* fall through */
 		case 'V':
-			handle_property(key, val, len, &type_set);
-			key = ~0;
+			handle_property(key, sizeof_key, val, len, &type_set);
+			*key = '\0';
+			sizeof_key = 1;
 			continue;
 		default:
 			die("invalid property line: %s\n", t);
-- 
1.7.3.2.846.gf4b062
