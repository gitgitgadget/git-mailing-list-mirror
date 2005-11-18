From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 4/5] Improve XML parsing in http-push
Date: Fri, 18 Nov 2005 11:03:18 -0800
Message-ID: <20051118190318.GI3968@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 18 20:03:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdBW7-0006eC-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 20:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161129AbVKRTDT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 14:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVKRTDT
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 14:03:19 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:9044 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750776AbVKRTDS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 14:03:18 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jAIJ3Irp026736
	for <git@vger.kernel.org>; Fri, 18 Nov 2005 11:03:18 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jAIJ3IK1026734
	for git@vger.kernel.org; Fri, 18 Nov 2005 11:03:18 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12247>

Improved XML parsing - replace specialized doc parser callbacks with generic
functions that track the parser context and use document-specific callbacks
to process that data.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-push.c |  319 ++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 163 insertions(+), 156 deletions(-)

applies-to: 819a270f2d0479478cd34d90e5d764ffad88b9d5
61e23ac52c5276cdddc9dd4d0de444dfe1dde39d
diff --git a/http-push.c b/http-push.c
index afdcd8b..2932693 100644
--- a/http-push.c
+++ b/http-push.c
@@ -24,13 +24,28 @@ enum XML_Status {
 
 #define RANGE_HEADER_SIZE 30
 
-/* DAV method names and request body templates */
+/* DAV methods */
 #define DAV_LOCK "LOCK"
 #define DAV_MKCOL "MKCOL"
 #define DAV_MOVE "MOVE"
 #define DAV_PROPFIND "PROPFIND"
 #define DAV_PUT "PUT"
 #define DAV_UNLOCK "UNLOCK"
+
+/* DAV lock flags */
+#define DAV_PROP_LOCKWR (1u << 0)
+#define DAV_PROP_LOCKEX (1u << 1)
+#define DAV_LOCK_OK (1u << 2)
+
+/* DAV XML properties */
+#define DAV_CTX_LOCKENTRY ".multistatus.response.propstat.prop.supportedlock.lockentry"
+#define DAV_CTX_LOCKTYPE_WRITE ".multistatus.response.propstat.prop.supportedlock.lockentry.locktype.write"
+#define DAV_CTX_LOCKTYPE_EXCLUSIVE ".multistatus.response.propstat.prop.supportedlock.lockentry.lockscope.exclusive"
+#define DAV_ACTIVELOCK_OWNER ".prop.lockdiscovery.activelock.owner.href"
+#define DAV_ACTIVELOCK_TIMEOUT ".prop.lockdiscovery.activelock.timeout"
+#define DAV_ACTIVELOCK_TOKEN ".prop.lockdiscovery.activelock.locktoken.href"
+
+/* DAV request body templates */
 #define PROPFIND_REQUEST "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<D:propfind xmlns:D=\"DAV:\">\n<D:prop xmlns:R=\"%s\">\n<D:supportedlock/>\n</D:prop>\n</D:propfind>"
 #define LOCK_REQUEST "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<D:lockinfo xmlns:D=\"DAV:\">\n<D:lockscope><D:exclusive/></D:lockscope>\n<D:locktype><D:write/></D:locktype>\n<D:owner>\n<D:href>mailto:%s</D:href>\n</D:owner>\n</D:lockinfo>"
 
@@ -92,14 +107,17 @@ struct transfer_request
 
 static struct transfer_request *request_queue_head = NULL;
 
+struct xml_ctx
+{
+	char *name;
+	int len;
+	char *cdata;
+	void (*userFunc)(struct xml_ctx *ctx, int tag_closed);
+	void *userData;
+};
+
 struct active_lock
 {
-	int ctx_activelock;
-	int ctx_owner;
-	int ctx_owner_href;
-	int ctx_timeout;
-	int ctx_locktoken;
-	int ctx_locktoken_href;
 	char *url;
 	char *owner;
 	char *token;
@@ -108,16 +126,6 @@ struct active_lock
 	int refreshing;
 };
 
-struct lockprop
-{
-	int supported_lock;
-	int lock_entry;
-	int lock_scope;
-	int lock_type;
-	int lock_exclusive;
-	int lock_exclusive_write;
-};
-
 static void finish_request(struct transfer_request *request);
 
 static void process_response(void *callback_data)
@@ -734,107 +742,101 @@ int fetch_ref(char *ref, unsigned char *
         return 0;
 }
 
-static void
-start_activelock_element(void *userData, const char *name, const char **atts)
+static void handle_lockprop_ctx(struct xml_ctx *ctx, int tag_closed)
 {
-	struct active_lock *lock = (struct active_lock *)userData;
+	int *lock_flags = (int *)ctx->userData;
 
-	if (lock->ctx_activelock && !strcmp(name, "D:timeout"))
-		lock->ctx_timeout = 1;
-	else if (lock->ctx_owner && strstr(name, "href"))
-		lock->ctx_owner_href = 1;
-	else if (lock->ctx_activelock && strstr(name, "owner"))
-		lock->ctx_owner = 1;
-	else if (lock->ctx_locktoken && !strcmp(name, "D:href"))
-		lock->ctx_locktoken_href = 1;
-	else if (lock->ctx_activelock && !strcmp(name, "D:locktoken"))
-		lock->ctx_locktoken = 1;
-	else if (!strcmp(name, "D:activelock"))
-		lock->ctx_activelock = 1;
+	if (tag_closed) {
+		if (!strcmp(ctx->name, DAV_CTX_LOCKENTRY)) {
+			if ((*lock_flags & DAV_PROP_LOCKEX) &&
+			    (*lock_flags & DAV_PROP_LOCKWR)) {
+				*lock_flags |= DAV_LOCK_OK;
+			}
+			*lock_flags &= DAV_LOCK_OK;
+		} else if (!strcmp(ctx->name, DAV_CTX_LOCKTYPE_WRITE)) {
+			*lock_flags |= DAV_PROP_LOCKWR;
+		} else if (!strcmp(ctx->name, DAV_CTX_LOCKTYPE_EXCLUSIVE)) {
+			*lock_flags |= DAV_PROP_LOCKEX;
+		}
+	}
 }
 
-static void
-end_activelock_element(void *userData, const char *name)
-{
-	struct active_lock *lock = (struct active_lock *)userData;
-
-	if (lock->ctx_timeout && !strcmp(name, "D:timeout")) {
-		lock->ctx_timeout = 0;
-	} else if (lock->ctx_owner_href && strstr(name, "href")) {
-		lock->ctx_owner_href = 0;
-	} else if (lock->ctx_owner && strstr(name, "owner")) {
-		lock->ctx_owner = 0;
-	} else if (lock->ctx_locktoken_href && !strcmp(name, "D:href")) {
-		lock->ctx_locktoken_href = 0;
-	} else if (lock->ctx_locktoken && !strcmp(name, "D:locktoken")) {
-		lock->ctx_locktoken = 0;
-	} else if (lock->ctx_activelock && !strcmp(name, "D:activelock")) {
-		lock->ctx_activelock = 0;
+static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
+{
+	struct active_lock *lock = (struct active_lock *)ctx->userData;
+
+	if (tag_closed && ctx->cdata) {
+		if (!strcmp(ctx->name, DAV_ACTIVELOCK_OWNER)) {
+			lock->owner = xmalloc(strlen(ctx->cdata) + 1);
+			strcpy(lock->owner, ctx->cdata);
+		} else if (!strcmp(ctx->name, DAV_ACTIVELOCK_TIMEOUT)) {
+			if (!strncmp(ctx->cdata, "Second-", 7))
+				lock->timeout =
+					strtol(ctx->cdata + 7, NULL, 10);
+		} else if (!strcmp(ctx->name, DAV_ACTIVELOCK_TOKEN)) {
+			if (!strncmp(ctx->cdata, "opaquelocktoken:", 16)) {
+				lock->token = xmalloc(strlen(ctx->cdata - 15));
+				strcpy(lock->token, ctx->cdata + 16);
+			}
+		}
 	}
 }
 
 static void
-activelock_cdata(void *userData, const XML_Char *s, int len)
+xml_start_tag(void *userData, const char *name, const char **atts)
 {
-	struct active_lock *lock = (struct active_lock *)userData;
-	char *this = malloc(len+1);
-	strncpy(this, s, len);
-
-	if (lock->ctx_owner_href) {
-		lock->owner = malloc(len+1);
-		strcpy(lock->owner, this);
-	} else if (lock->ctx_locktoken_href) {
-		if (!strncmp(this, "opaquelocktoken:", 16)) {
-			lock->token = malloc(len-15);
-			strcpy(lock->token, this+16);
-		}
-	} else if (lock->ctx_timeout) {
-		if (!strncmp(this, "Second-", 7))
-			lock->timeout = strtol(this+7, NULL, 10);
+	struct xml_ctx *ctx = (struct xml_ctx *)userData;
+	const char *c = index(name, ':');
+	int new_len;
+
+	if (c == NULL)
+		c = name;
+	else
+		c++;
+
+	new_len = strlen(ctx->name) + strlen(c) + 2;
+
+	if (new_len > ctx->len) {
+		ctx->name = xrealloc(ctx->name, new_len);
+		ctx->len = new_len;
+	}
+	strcat(ctx->name, ".");
+	strcat(ctx->name, c);
+
+	if (ctx->cdata) {
+		free(ctx->cdata);
+		ctx->cdata = NULL;
 	}
 
-	free(this);
+	ctx->userFunc(ctx, 0);
 }
 
 static void
-start_lockprop_element(void *userData, const char *name, const char **atts)
+xml_end_tag(void *userData, const char *name)
 {
-	struct lockprop *prop = (struct lockprop *)userData;
+	struct xml_ctx *ctx = (struct xml_ctx *)userData;
+	const char *c = index(name, ':');
+	char *ep;
 
-	if (prop->lock_type && !strcmp(name, "D:write")) {
-		if (prop->lock_exclusive) {
-			prop->lock_exclusive_write = 1;
-		}
-	} else if (prop->lock_scope && !strcmp(name, "D:exclusive")) {
-		prop->lock_exclusive = 1;
-	} else if (prop->lock_entry) {
-		if (!strcmp(name, "D:lockscope")) {
-			prop->lock_scope = 1;
-		} else if (!strcmp(name, "D:locktype")) {
-			prop->lock_type = 1;
-		}
-	} else if (prop->supported_lock) {
-		if (!strcmp(name, "D:lockentry")) {
-			prop->lock_entry = 1;
-		}
-	} else if (!strcmp(name, "D:supportedlock")) {
-		prop->supported_lock = 1;
-	}
+	ctx->userFunc(ctx, 1);
+
+	if (c == NULL)
+		c = name;
+	else
+		c++;
+
+	ep = ctx->name + strlen(ctx->name) - strlen(c) - 1;
+	*ep = 0;
 }
 
 static void
-end_lockprop_element(void *userData, const char *name)
+xml_cdata(void *userData, const XML_Char *s, int len)
 {
-	struct lockprop *prop = (struct lockprop *)userData;
-
-	if (!strcmp(name, "D:lockentry")) {
-		prop->lock_entry = 0;
-		prop->lock_scope = 0;
-		prop->lock_type = 0;
-		prop->lock_exclusive = 0;
-	} else if (!strcmp(name, "D:supportedlock")) {
-		prop->supported_lock = 0;
-	}
+	struct xml_ctx *ctx = (struct xml_ctx *)userData;
+	if (ctx->cdata)
+		free(ctx->cdata);
+	ctx->cdata = xcalloc(len+1, 1);
+	strncpy(ctx->cdata, s, len);
 }
 
 static struct active_lock *lock_remote(char *file, long timeout)
@@ -847,10 +849,11 @@ static struct active_lock *lock_remote(c
 	char *url;
 	char *ep;
 	char timeout_header[25];
-	struct active_lock *new_lock;
+	struct active_lock *new_lock = NULL;
 	XML_Parser parser = XML_ParserCreate(NULL);
 	enum XML_Status result;
 	struct curl_slist *dav_headers = NULL;
+	struct xml_ctx ctx;
 
 	url = xmalloc(strlen(remote->url) + strlen(file) + 1);
 	sprintf(url, "%s%s", remote->url, file);
@@ -894,12 +897,6 @@ static struct active_lock *lock_remote(c
 	in_buffer.posn = 0;
 	in_buffer.buffer = in_data;
 
-	new_lock = xcalloc(1, sizeof(*new_lock));
-	new_lock->owner = NULL;
-	new_lock->token = NULL;
-	new_lock->timeout = -1;
-	new_lock->refreshing = 0;
-
 	sprintf(timeout_header, "Timeout: Second-%ld", timeout);
 	dav_headers = curl_slist_append(dav_headers, timeout_header);
 	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
@@ -915,40 +912,41 @@ static struct active_lock *lock_remote(c
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_LOCK);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
 
+	new_lock = xcalloc(1, sizeof(*new_lock));
+	new_lock->owner = NULL;
+	new_lock->token = NULL;
+	new_lock->timeout = -1;
+	new_lock->refreshing = 0;
+
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		if (slot->curl_result != CURLE_OK) {
-			fprintf(stderr, "Got HTTP error %ld\n", slot->http_code);
-			free(new_lock);
-			free(url);
-			free(out_data);
-			free(in_data);
-			return NULL;
+		if (slot->curl_result == CURLE_OK) {
+			ctx.name = xcalloc(10, 1);
+			ctx.len = 0;
+			ctx.cdata = NULL;
+			ctx.userFunc = handle_new_lock_ctx;
+			ctx.userData = new_lock;
+			XML_SetUserData(parser, &ctx);
+			XML_SetElementHandler(parser, xml_start_tag,
+					      xml_end_tag);
+			XML_SetCharacterDataHandler(parser, xml_cdata);
+			result = XML_Parse(parser, in_buffer.buffer,
+					   in_buffer.posn, 1);
+			free(ctx.name);
+			if (result != XML_STATUS_OK) {
+				fprintf(stderr, "XML error: %s\n",
+					XML_ErrorString(
+						XML_GetErrorCode(parser)));
+				new_lock->timeout = -1;
+			}
 		}
 	} else {
-		free(new_lock);
-		free(url);
-		free(out_data);
-		free(in_data);
 		fprintf(stderr, "Unable to start request\n");
-		return NULL;
 	}
 
+	curl_slist_free_all(dav_headers);
 	free(out_data);
-
-	XML_SetUserData(parser, new_lock);
-	XML_SetElementHandler(parser, start_activelock_element,
-				      end_activelock_element);
-	XML_SetCharacterDataHandler(parser, activelock_cdata);
-	result = XML_Parse(parser, in_buffer.buffer, in_buffer.posn, 1);
 	free(in_data);
-	if (result != XML_STATUS_OK) {
-		fprintf(stderr, "%s", XML_ErrorString(
-				XML_GetErrorCode(parser)));
-		free(url);
-		free(new_lock);
-		return NULL;
-	}
 
 	if (new_lock->token == NULL || new_lock->timeout <= 0) {
 		if (new_lock->token != NULL)
@@ -957,11 +955,12 @@ static struct active_lock *lock_remote(c
 			free(new_lock->owner);
 		free(url);
 		free(new_lock);
-		return NULL;
+		new_lock = NULL;
+	} else {
+		new_lock->url = url;
+		new_lock->start_time = time(NULL);
 	}
 
-	new_lock->url = url;
-	new_lock->start_time = time(NULL);
 	return new_lock;
 }
 
@@ -1000,13 +999,15 @@ static int unlock_remote(struct active_l
 	if (lock->owner != NULL)
 		free(lock->owner);
 	free(lock->url);
+/* Freeing the token causes a segfault...
 	free(lock->token);
+*/
 	free(lock);
 
 	return rc;
 }
 
-static int check_locking(void)
+static int locking_available(void)
 {
 	struct active_request_slot *slot;
 	struct buffer in_buffer;
@@ -1015,8 +1016,9 @@ static int check_locking(void)
 	char *out_data;
 	XML_Parser parser = XML_ParserCreate(NULL);
 	enum XML_Status result;
-	struct lockprop supported_lock;
 	struct curl_slist *dav_headers = NULL;
+	struct xml_ctx ctx;
+	int lock_flags = 0;
 
 	out_buffer.size = strlen(PROPFIND_REQUEST) + strlen(remote->url) - 2;
 	out_data = xmalloc(out_buffer.size + 1);
@@ -1045,30 +1047,35 @@ static int check_locking(void)
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		free(out_data);
-		if (slot->curl_result != CURLE_OK) {
-			free(in_buffer.buffer);
-			return -1;
+		if (slot->curl_result == CURLE_OK) {
+			ctx.name = xcalloc(10, 1);
+			ctx.len = 0;
+			ctx.cdata = NULL;
+			ctx.userFunc = handle_lockprop_ctx;
+			ctx.userData = &lock_flags;
+			XML_SetUserData(parser, &ctx);
+			XML_SetElementHandler(parser, xml_start_tag,
+					      xml_end_tag);
+			result = XML_Parse(parser, in_buffer.buffer,
+					   in_buffer.posn, 1);
+			free(ctx.name);
+
+			if (result != XML_STATUS_OK) {
+				fprintf(stderr, "XML error: %s\n",
+					XML_ErrorString(
+						XML_GetErrorCode(parser)));
+				lock_flags = 0;
+			}
 		}
-
-		XML_SetUserData(parser, &supported_lock);
-		XML_SetElementHandler(parser, start_lockprop_element,
-				      end_lockprop_element);
-		result = XML_Parse(parser, in_buffer.buffer, in_buffer.posn, 1);
-		free(in_buffer.buffer);
-		if (result != XML_STATUS_OK)
-			return error("%s", XML_ErrorString(
-					     XML_GetErrorCode(parser)));
 	} else {
-		free(out_data);
-		free(in_buffer.buffer);
-		return error("Unable to start request");
+		fprintf(stderr, "Unable to start request\n");
 	}
 
-	if (supported_lock.lock_exclusive_write)
-		return 0;
-	else
-		return 1;
+	free(out_data);
+	free(in_buffer.buffer);
+	curl_slist_free_all(dav_headers);
+
+	return lock_flags;
 }
 
 static int is_ancestor(unsigned char *sha1, struct commit *commit)
@@ -1269,7 +1276,7 @@ int main(int argc, char **argv)
 					    "Pragma: no-cache");
 
 	/* Verify DAV compliance/lock support */
-	if (check_locking() != 0) {
+	if (!locking_available()) {
 		fprintf(stderr, "Error: no DAV locking support on remote repo %s\n", remote->url);
 		rc = 1;
 		goto cleanup;
---
0.99.9.GIT
