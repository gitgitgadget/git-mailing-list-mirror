From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 5/9] vcs-svn: factor out usage of string_pool
Date: Sat, 19 Mar 2011 18:03:47 +1100
Message-ID: <1300518231-20008-6-git-send-email-david.barr@cordelta.com>
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
	id 1Q0qLF-0004uk-MN
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755080Ab1CSHMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:12:35 -0400
Received: from [119.15.97.146] ([119.15.97.146]:59170 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753965Ab1CSHMN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:12:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 63677C046;
	Sat, 19 Mar 2011 18:00:35 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B14WRaW5MxG9; Sat, 19 Mar 2011 18:00:32 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 73CFCC050;
	Sat, 19 Mar 2011 18:00:28 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169393>

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 vcs-svn/fast_export.c |   17 +++++++----------
 vcs-svn/fast_export.h |    5 +++--
 vcs-svn/svndump.c     |   44 ++++++++++++++++++++++++++------------------
 3 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index bb5e9aa..1d50512 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -9,7 +9,6 @@
 #include "fast_export.h"
 #include "line_buffer.h"
 #include "repo_tree.h"
-#include "string_pool.h"
 #include "strbuf.h"
 
 #define MAX_GITSVN_LINE_LEN 4096
@@ -61,25 +60,23 @@ void fast_export_modify(const char *path, uint32_t mode, const char *dataref)
 }
 
 static char gitsvnline[MAX_GITSVN_LINE_LEN];
-void fast_export_begin_commit(uint32_t revision, uint32_t author, char *log,
-			uint32_t uuid, uint32_t url,
+void fast_export_begin_commit(uint32_t revision, const char *author,
+			const char *log, const char *uuid, const char *url,
 			unsigned long timestamp)
 {
-	if (!log)
-		log = "";
-	if (~uuid && ~url) {
+	if (*uuid && *url) {
 		snprintf(gitsvnline, MAX_GITSVN_LINE_LEN,
 				"\n\ngit-svn-id: %s@%"PRIu32" %s\n",
-				 pool_fetch(url), revision, pool_fetch(uuid));
+				 url, revision, uuid);
 	} else {
 		*gitsvnline = '\0';
 	}
 	printf("commit refs/heads/master\n");
 	printf("mark :%"PRIu32"\n", revision);
 	printf("committer %s <%s@%s> %ld +0000\n",
-		   ~author ? pool_fetch(author) : "nobody",
-		   ~author ? pool_fetch(author) : "nobody",
-		   ~uuid ? pool_fetch(uuid) : "local", timestamp);
+		   *author ? author : "nobody",
+		   *author ? author : "nobody",
+		   *uuid ? uuid : "local", timestamp);
 	printf("data %"PRIu32"\n%s%s\n",
 		   (uint32_t) (strlen(log) + strlen(gitsvnline)),
 		   log, gitsvnline);
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index a47c609..bc5bddf 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -10,8 +10,9 @@ void fast_export_reset(void);
 
 void fast_export_delete(const char *path);
 void fast_export_modify(const char *path, uint32_t mode, const char *dataref);
-void fast_export_begin_commit(uint32_t revision, uint32_t author, char *log,
-			uint32_t uuid, uint32_t url, unsigned long timestamp);
+void fast_export_begin_commit(uint32_t revision, const char *author,
+			const char *log, const char *uuid, const char *url,
+			unsigned long timestamp);
 void fast_export_end_commit(uint32_t revision);
 void fast_export_data(uint32_t mode, uint32_t len, struct line_buffer *input);
 
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 03f916d..fd67db8 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -11,7 +11,6 @@
 #include "repo_tree.h"
 #include "fast_export.h"
 #include "line_buffer.h"
-#include "string_pool.h"
 #include "strbuf.h"
 
 #define REPORT_FILENO 3
@@ -42,13 +41,14 @@ static struct {
 } node_ctx;
 
 static struct {
-	uint32_t revision, author;
+	uint32_t revision;
 	unsigned long timestamp;
-	struct strbuf log;
+	struct strbuf log, author;
 } rev_ctx;
 
 static struct {
-	uint32_t version, uuid, url;
+	uint32_t version;
+	struct strbuf uuid, url;
 } dump_ctx;
 
 static void reset_node_ctx(char *fname)
@@ -71,14 +71,16 @@ static void reset_rev_ctx(uint32_t revision)
 	rev_ctx.revision = revision;
 	rev_ctx.timestamp = 0;
 	strbuf_reset(&rev_ctx.log);
-	rev_ctx.author = ~0;
+	strbuf_reset(&rev_ctx.author);
 }
 
-static void reset_dump_ctx(uint32_t url)
+static void reset_dump_ctx(const char *url)
 {
-	dump_ctx.url = url;
+	strbuf_reset(&dump_ctx.url);
+	if (url)
+		strbuf_addstr(&dump_ctx.url, url);
 	dump_ctx.version = 1;
-	dump_ctx.uuid = ~0;
+	strbuf_reset(&dump_ctx.uuid);
 }
 
 static void handle_property(const char *key, const char *val, uint32_t len,
@@ -91,13 +93,15 @@ static void handle_property(const char *key, const char *val, uint32_t len,
 			break;
 		if (!val)
 			die("invalid dump: unsets svn:log");
-		/* Value length excludes terminating nul. */
-		strbuf_add(&rev_ctx.log, val, len + 1);
+		strbuf_reset(&rev_ctx.log);
+		strbuf_add(&rev_ctx.log, val, len);
 		break;
 	case 10:
 		if (memcmp(key, "svn:author", 10))
 			break;
-		rev_ctx.author = pool_intern(val);
+		strbuf_reset(&rev_ctx.author);
+		if (val)
+			strbuf_add(&rev_ctx.author, val, len);
 		break;
 	case 8:
 		if (memcmp(key, "svn:date", 8))
@@ -272,8 +276,9 @@ static void begin_revision(void)
 {
 	if (!rev_ctx.revision)	/* revision 0 gets no git commit. */
 		return;
-	fast_export_begin_commit(rev_ctx.revision, rev_ctx.author, rev_ctx.log.buf,
-		dump_ctx.uuid, dump_ctx.url, rev_ctx.timestamp);
+	fast_export_begin_commit(rev_ctx.revision, rev_ctx.author.buf,
+		rev_ctx.log.buf, dump_ctx.uuid.buf, dump_ctx.url.buf,
+		rev_ctx.timestamp);
 }
 
 static void end_revision(void)
@@ -289,7 +294,7 @@ void svndump_read(const char *url)
 	uint32_t active_ctx = DUMP_CTX;
 	uint32_t len;
 
-	reset_dump_ctx(pool_intern(url));
+	reset_dump_ctx(url);
 	while ((t = buffer_read_line(&input))) {
 		val = strstr(t, ": ");
 		if (!val)
@@ -310,7 +315,8 @@ void svndump_read(const char *url)
 		case 4:
 			if (memcmp(t, "UUID", 4))
 				continue;
-			dump_ctx.uuid = pool_intern(val);
+			strbuf_reset(&dump_ctx.uuid);
+			strbuf_addstr(&dump_ctx.uuid, val);
 			break;
 		case 15:
 			if (memcmp(t, "Revision-number", 15))
@@ -419,10 +425,13 @@ int svndump_init(const char *filename)
 	if (buffer_init(&input, filename))
 		return error("cannot open %s: %s", filename, strerror(errno));
 	fast_export_init(REPORT_FILENO);
+	strbuf_init(&dump_ctx.uuid, 4096);
+	strbuf_init(&dump_ctx.url, 4096);
 	strbuf_init(&rev_ctx.log, 4096);
+	strbuf_init(&rev_ctx.author, 4096);
 	strbuf_init(&node_ctx.src, 4096);
 	strbuf_init(&node_ctx.dst, 4096);
-	reset_dump_ctx(~0);
+	reset_dump_ctx(NULL);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	return 0;
@@ -431,7 +440,7 @@ int svndump_init(const char *filename)
 void svndump_deinit(void)
 {
 	fast_export_deinit();
-	reset_dump_ctx(~0);
+	reset_dump_ctx(NULL);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	strbuf_release(&rev_ctx.log);
@@ -447,5 +456,4 @@ void svndump_reset(void)
 {
 	fast_export_reset();
 	buffer_reset(&input);
-	pool_reset();
 }
-- 
1.7.3.2.846.gf4b062
