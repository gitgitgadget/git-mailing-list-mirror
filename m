From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 3/9] vcs-svn: implement perfect hash for node-prop keys
Date: Sat, 19 Mar 2011 18:03:45 +1100
Message-ID: <1300518231-20008-4-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:12:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qKs-0004lS-32
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754500Ab1CSHM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:12:27 -0400
Received: from [119.15.97.146] ([119.15.97.146]:55415 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753609Ab1CSHMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:12:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id CD405C058;
	Sat, 19 Mar 2011 18:00:31 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0vQkd0goUqzO; Sat, 19 Mar 2011 18:00:28 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 2D6F7C04D;
	Sat, 19 Mar 2011 18:00:28 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169387>

This eliminates one more dependency on string_pool.

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 vcs-svn/svndump.c |   50 ++++++++++++++++++++++++++++++++------------------
 1 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 15b173e..49fb6db 100644
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
@@ -113,22 +107,38 @@ static void init_keys(void)
 	keys.prop_delta = pool_intern("Prop-delta");
 }
 
-static void handle_property(uint32_t key, const char *val, uint32_t len,
+static void handle_property(const char *key, const char *val, uint32_t len,
 				uint32_t *type_set)
 {
-	if (key == keys.svn_log) {
+	const int key_len = strlen(key);
+	switch (key_len) {
+	case 7:
+		if (memcmp(key, "svn:log", 7))
+			break;
 		if (!val)
 			die("invalid dump: unsets svn:log");
 		/* Value length excludes terminating nul. */
 		strbuf_add(&rev_ctx.log, val, len + 1);
-	} else if (key == keys.svn_author) {
+		break;
+	case 10:
+		if (memcmp(key, "svn:author", 10))
+			break;
 		rev_ctx.author = pool_intern(val);
-	} else if (key == keys.svn_date) {
+		break;
+	case 8:
+		if (memcmp(key, "svn:date", 8))
+			break;
 		if (!val)
 			die("invalid dump: unsets svn:date");
 		if (parse_date_basic(val, &rev_ctx.timestamp, NULL))
 			warning("invalid timestamp: %s", val);
-	} else if (key == keys.svn_executable || key == keys.svn_special) {
+		break;
+	case 14:
+		if (memcmp(key, "svn:executable", 14))
+			break;
+	case 11:
+		if (key_len == 11 && memcmp(key, "svn:special", 11))
+			break;
 		if (*type_set) {
 			if (!val)
 				return;
@@ -139,7 +149,7 @@ static void handle_property(uint32_t key, const char *val, uint32_t len,
 			return;
 		}
 		*type_set = 1;
-		node_ctx.type = key == keys.svn_executable ?
+		node_ctx.type = key_len == strlen("svn:executable") ?
 				REPO_MODE_EXE :
 				REPO_MODE_LNK;
 	}
@@ -147,7 +157,7 @@ static void handle_property(uint32_t key, const char *val, uint32_t len,
 
 static void read_props(void)
 {
-	uint32_t key = ~0;
+	char key[16] = {0};
 	const char *t;
 	/*
 	 * NEEDSWORK: to support simple mode changes like
@@ -175,16 +185,20 @@ static void read_props(void)
 
 		switch (type) {
 		case 'K':
-			key = pool_intern(val);
-			continue;
 		case 'D':
-			key = pool_intern(val);
+			if (len < sizeof(key))
+				memcpy(key, val, len + 1);
+			else	/* nonstandard key. */
+				*key = '\0';
+			if (type == 'K')
+				continue;
+			assert(type == 'D');
 			val = NULL;
 			len = 0;
 			/* fall through */
 		case 'V':
 			handle_property(key, val, len, &type_set);
-			key = ~0;
+			*key = '\0';
 			continue;
 		default:
 			die("invalid property line: %s\n", t);
-- 
1.7.3.2.846.gf4b062
