From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 01/11] vcs-svn: use strbuf for revision log
Date: Tue, 22 Mar 2011 10:49:50 +1100
Message-ID: <1300751400-7427-2-git-send-email-david.barr@cordelta.com>
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
	id 1Q1orx-0006bP-6N
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 00:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932Ab1CUXub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 19:50:31 -0400
Received: from mailhost.cordelta.com ([119.15.97.146]:55674 "EHLO
	mailhost.cordelta" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755669Ab1CUXuR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 19:50:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 66824C062;
	Tue, 22 Mar 2011 10:46:45 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M0dAIz6J-C1R; Tue, 22 Mar 2011 10:46:38 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id D429EC053;
	Tue, 22 Mar 2011 10:46:37 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300751400-7427-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169685>

This is a small step towards removing dependence on obj_pool.h

Signed-off-by: David Barr <david.barr@cordelta.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/svndump.c |   26 +++++++-------------------
 1 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 7ecb227..da154ad 100644
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
 
@@ -31,22 +31,10 @@
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
 	uint32_t src[REPO_MAX_PATH_DEPTH], dst[REPO_MAX_PATH_DEPTH];
@@ -56,7 +44,7 @@ static struct {
 static struct {
 	uint32_t revision, author;
 	unsigned long timestamp;
-	char *log;
+	struct strbuf log;
 } rev_ctx;
 
 static struct {
@@ -89,7 +77,7 @@ static void reset_rev_ctx(uint32_t revision)
 {
 	rev_ctx.revision = revision;
 	rev_ctx.timestamp = 0;
-	rev_ctx.log = NULL;
+	strbuf_reset(&rev_ctx.log);
 	rev_ctx.author = ~0;
 }
 
@@ -130,7 +118,7 @@ static void handle_property(uint32_t key, const char *val, uint32_t len,
 		if (!val)
 			die("invalid dump: unsets svn:log");
 		/* Value length excludes terminating nul. */
-		rev_ctx.log = log_copy(len + 1, val);
+		strbuf_add(&rev_ctx.log, val, len + 1);
 	} else if (key == keys.svn_author) {
 		rev_ctx.author = pool_intern(val);
 	} else if (key == keys.svn_date) {
@@ -297,7 +285,7 @@ static void begin_revision(void)
 {
 	if (!rev_ctx.revision)	/* revision 0 gets no git commit. */
 		return;
-	fast_export_begin_commit(rev_ctx.revision, rev_ctx.author, rev_ctx.log,
+	fast_export_begin_commit(rev_ctx.revision, rev_ctx.author, rev_ctx.log.buf,
 		dump_ctx.uuid, dump_ctx.url, rev_ctx.timestamp);
 }
 
@@ -406,6 +394,7 @@ int svndump_init(const char *filename)
 	if (buffer_init(&input, filename))
 		return error("cannot open %s: %s", filename, strerror(errno));
 	fast_export_init(REPORT_FILENO);
+	strbuf_init(&rev_ctx.log, 4096);
 	reset_dump_ctx(~0);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
@@ -415,11 +404,11 @@ int svndump_init(const char *filename)
 
 void svndump_deinit(void)
 {
-	log_reset();
 	fast_export_deinit();
 	reset_dump_ctx(~0);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
+	strbuf_release(&rev_ctx.log);
 	if (buffer_deinit(&input))
 		fprintf(stderr, "Input error\n");
 	if (ferror(stdout))
@@ -428,7 +417,6 @@ void svndump_deinit(void)
 
 void svndump_reset(void)
 {
-	log_reset();
 	fast_export_reset();
 	buffer_reset(&input);
 	reset_dump_ctx(~0);
-- 
1.7.3.2.846.gf4b062
