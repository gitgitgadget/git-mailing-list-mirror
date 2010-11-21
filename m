From: Gabriel Corona <gabriel.corona@enst-bretagne.fr>
Subject: [PATCH] Make WebDAV XML parser namespace aware
Date: Sun, 21 Nov 2010 22:54:36 +0100
Message-ID: <1290376476-24435-1-git-send-email-gabriel.corona@enst-bretagne.fr>
Cc: Nick Hengeveld <nickh@reactrix.com>, Mike Hommey <mh@glandium.org>,
	Dennis Stosberg <dennis@stosberg.net>,
	Gabriel Corona <gabriel.corona@enst-bretagne.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 21 23:06:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKI2z-0005Mm-Vn
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 23:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325Ab0KUWGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Nov 2010 17:06:00 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:41482 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752110Ab0KUWF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Nov 2010 17:05:59 -0500
Received: from localhost.localdomain (unknown [88.180.106.44])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 2D9CFA6257;
	Sun, 21 Nov 2010 23:05:51 +0100 (CET)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161872>

Previous implementation ignored the XML namespaces, considering only
the local name.

Signed-off-by: Gabriel Corona <gabriel.corona@enst-bretagne.fr>
---
 http-push.c |   45 ++++++++++++++++-----------------------------
 1 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/http-push.c b/http-push.c
index c9bcd11..4ec3304 100644
--- a/http-push.c
+++ b/http-push.c
@@ -42,15 +42,15 @@ enum XML_Status {
 #define DAV_LOCK_OK (1u << 2)
 
 /* DAV XML properties */
-#define DAV_CTX_LOCKENTRY ".multistatus.response.propstat.prop.supportedlock.lockentry"
-#define DAV_CTX_LOCKTYPE_WRITE ".multistatus.response.propstat.prop.supportedlock.lockentry.locktype.write"
-#define DAV_CTX_LOCKTYPE_EXCLUSIVE ".multistatus.response.propstat.prop.supportedlock.lockentry.lockscope.exclusive"
-#define DAV_ACTIVELOCK_OWNER ".prop.lockdiscovery.activelock.owner.href"
-#define DAV_ACTIVELOCK_TIMEOUT ".prop.lockdiscovery.activelock.timeout"
-#define DAV_ACTIVELOCK_TOKEN ".prop.lockdiscovery.activelock.locktoken.href"
-#define DAV_PROPFIND_RESP ".multistatus.response"
-#define DAV_PROPFIND_NAME ".multistatus.response.href"
-#define DAV_PROPFIND_COLLECTION ".multistatus.response.propstat.prop.resourcetype.collection"
+#define DAV_CTX_LOCKENTRY "\tDAV: multistatus\tDAV: response\tDAV: propstat\tDAV: prop\tDAV: supportedlock\tDAV: lockentry"
+#define DAV_CTX_LOCKTYPE_WRITE "\tDAV: multistatus\tDAV: response\tDAV: propstat\tDAV: prop\tDAV: supportedlock\tDAV: lockentry\tDAV: locktype\tDAV: write"
+#define DAV_CTX_LOCKTYPE_EXCLUSIVE "\tDAV: multistatus\tDAV: response\tDAV: propstat\tDAV: prop\tDAV: supportedlock\tDAV: lockentry\tDAV: lockscope\tDAV: exclusive"
+#define DAV_ACTIVELOCK_OWNER "\tDAV: prop\tDAV: lockdiscovery\tDAV: activelock\tDAV: owner\tDAV: href"
+#define DAV_ACTIVELOCK_TIMEOUT "\tDAV: prop\tDAV: lockdiscovery\tDAV: activelock\tDAV: timeout"
+#define DAV_ACTIVELOCK_TOKEN "\tDAV: prop\tDAV: lockdiscovery\tDAV: activelock\tDAV: locktoken\tDAV: href"
+#define DAV_PROPFIND_RESP "\tDAV: multistatus\tDAV: response"
+#define DAV_PROPFIND_NAME "\tDAV: multistatus\tDAV: response\tDAV: href"
+#define DAV_PROPFIND_COLLECTION "\tDAV: multistatus\tDAV: response\tDAV: propstat\tDAV: prop\tDAV: resourcetype\tDAV: collection"
 
 /* DAV request body templates */
 #define PROPFIND_SUPPORTEDLOCK_REQUEST "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<D:propfind xmlns:D=\"DAV:\">\n<D:prop xmlns:R=\"%s\">\n<D:supportedlock/>\n</D:prop>\n</D:propfind>"
@@ -808,22 +808,16 @@ static void
 xml_start_tag(void *userData, const char *name, const char **atts)
 {
 	struct xml_ctx *ctx = (struct xml_ctx *)userData;
-	const char *c = strchr(name, ':');
 	int new_len;
 
-	if (c == NULL)
-		c = name;
-	else
-		c++;
-
-	new_len = strlen(ctx->name) + strlen(c) + 2;
+	new_len = strlen(ctx->name) + strlen(name) + 2;
 
 	if (new_len > ctx->len) {
 		ctx->name = xrealloc(ctx->name, new_len);
 		ctx->len = new_len;
 	}
-	strcat(ctx->name, ".");
-	strcat(ctx->name, c);
+	strcat(ctx->name, "\t");
+	strcat(ctx->name, name);
 
 	free(ctx->cdata);
 	ctx->cdata = NULL;
@@ -835,17 +829,10 @@ static void
 xml_end_tag(void *userData, const char *name)
 {
 	struct xml_ctx *ctx = (struct xml_ctx *)userData;
-	const char *c = strchr(name, ':');
 	char *ep;
 
 	ctx->userFunc(ctx, 1);
-
-	if (c == NULL)
-		c = name;
-	else
-		c++;
-
-	ep = ctx->name + strlen(ctx->name) - strlen(c) - 1;
+	ep = ctx->name + strlen(ctx->name) - strlen(name) - 1;
 	*ep = 0;
 }
 
@@ -934,7 +921,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result == CURLE_OK) {
-			XML_Parser parser = XML_ParserCreate(NULL);
+			XML_Parser parser = XML_ParserCreateNS(NULL, ' ');
 			enum XML_Status result;
 			ctx.name = xcalloc(10, 1);
 			ctx.len = 0;
@@ -1177,7 +1164,7 @@ static void remote_ls(const char *path, int flags,
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result == CURLE_OK) {
-			XML_Parser parser = XML_ParserCreate(NULL);
+			XML_Parser parser = XML_ParserCreateNS(NULL, ' ');
 			enum XML_Status result;
 			ctx.name = xcalloc(10, 1);
 			ctx.len = 0;
@@ -1260,7 +1247,7 @@ static int locking_available(void)
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result == CURLE_OK) {
-			XML_Parser parser = XML_ParserCreate(NULL);
+			XML_Parser parser = XML_ParserCreateNS(NULL, ' ');
 			enum XML_Status result;
 			ctx.name = xcalloc(10, 1);
 			ctx.len = 0;
-- 
1.7.2.3
