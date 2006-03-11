From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 3/6] http-push: refactor remote file/directory processing
Date: Fri, 10 Mar 2006 20:18:08 -0800
Message-ID: <20060311041808.GE3997@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Mar 11 05:18:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHvYf-0004ul-FC
	for gcvg-git@gmane.org; Sat, 11 Mar 2006 05:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWCKESK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 23:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWCKESK
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 23:18:10 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:60110 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932408AbWCKESI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 23:18:08 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k2B4I8eP007652
	for <git@vger.kernel.org>; Fri, 10 Mar 2006 20:18:08 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k2B4I8Pt007650
	for git@vger.kernel.org; Fri, 10 Mar 2006 20:18:08 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17490>

Replace single-use functions with one that can get a list of remote
collections and pass file/directory information to user-defined functions
for processing.

---

 http-push.c |  245 ++++++++++++++++++++++++++---------------------------------
 1 files changed, 107 insertions(+), 138 deletions(-)

05c0fc457388309cf12f3647a48071845acc2c70
diff --git a/http-push.c b/http-push.c
index 1b0b3a8..755bcb8 100644
--- a/http-push.c
+++ b/http-push.c
@@ -140,11 +140,23 @@ struct remote_lock
 	struct remote_lock *next;
 };
 
-struct remote_dentry
+/* Flags that control remote_ls processing */
+#define PROCESS_FILES (1u << 0)
+#define PROCESS_DIRS  (1u << 1)
+#define RECURSIVE     (1u << 2)
+
+/* Flags that remote_ls passes to callback functions */
+#define IS_DIR (1u << 0)
+
+struct remote_ls_ctx
 {
-	char *base;
-	char *name;
-	int is_dir;
+	char *path;
+	void (*userFunc)(struct remote_ls_ctx *ls);
+	void *userData;
+	int flags;
+	char *dentry_name;
+	int dentry_flags;
+	struct remote_ls_ctx *parent;
 };
 
 static void finish_request(struct transfer_request *request);
@@ -812,55 +824,6 @@ static void handle_new_lock_ctx(struct x
 }
 
 static void one_remote_ref(char *refname);
-static void crawl_remote_refs(char *path);
-
-static void handle_crawl_ref_ctx(struct xml_ctx *ctx, int tag_closed)
-{
-	struct remote_dentry *dentry = (struct remote_dentry *)ctx->userData;
-
-
-	if (tag_closed) {
-		if (!strcmp(ctx->name, DAV_PROPFIND_RESP) && dentry->name) {
-			if (dentry->is_dir) {
-				if (strcmp(dentry->name, dentry->base)) {
-					crawl_remote_refs(dentry->name);
-				}
-			} else {
-				one_remote_ref(dentry->name);
-			}
-		} else if (!strcmp(ctx->name, DAV_PROPFIND_NAME) && ctx->cdata) {
-			dentry->name = xmalloc(strlen(ctx->cdata) -
-					       remote->path_len + 1);
-			strcpy(dentry->name,
-			       ctx->cdata + remote->path_len);
-		} else if (!strcmp(ctx->name, DAV_PROPFIND_COLLECTION)) {
-			dentry->is_dir = 1;
-		}
-	} else if (!strcmp(ctx->name, DAV_PROPFIND_RESP)) {
-		dentry->name = NULL;
-		dentry->is_dir = 0;
-	}
-}
-
-static void handle_remote_object_list_ctx(struct xml_ctx *ctx, int tag_closed)
-{
-	char *path;
-	char *obj_hex;
-
-	if (tag_closed) {
-		if (!strcmp(ctx->name, DAV_PROPFIND_NAME) && ctx->cdata) {
-			path = ctx->cdata + remote->path_len;
-			if (strlen(path) != 50)
-				return;
-			path += 9;
-			obj_hex = xmalloc(strlen(path));
-			strncpy(obj_hex, path, 2);
-			strcpy(obj_hex + 2, path + 3);
-			one_remote_object(obj_hex);
-			free(obj_hex);
-		}
-	}
-}
 
 static void
 xml_start_tag(void *userData, const char *name, const char **atts)
@@ -1101,91 +1064,83 @@ static int unlock_remote(struct remote_l
 	return rc;
 }
 
-static void crawl_remote_refs(char *path)
-{
-	char *url;
-	struct active_request_slot *slot;
-	struct slot_results results;
-	struct buffer in_buffer;
-	struct buffer out_buffer;
-	char *in_data;
-	char *out_data;
-	XML_Parser parser = XML_ParserCreate(NULL);
-	enum XML_Status result;
-	struct curl_slist *dav_headers = NULL;
-	struct xml_ctx ctx;
-	struct remote_dentry dentry;
-
-	fprintf(stderr, "  %s\n", path);
+static void remote_ls(const char *path, int flags,
+		      void (*userFunc)(struct remote_ls_ctx *ls),
+		      void *userData);
 
-	dentry.base = path;
-	dentry.name = NULL;
-	dentry.is_dir = 0;
-
-	url = xmalloc(strlen(remote->url) + strlen(path) + 1);
-	sprintf(url, "%s%s", remote->url, path);
+static void process_ls_object(struct remote_ls_ctx *ls)
+{
+	unsigned int *parent = (unsigned int *)ls->userData;
+	char *path = ls->dentry_name;
+	char *obj_hex;
 
-	out_buffer.size = strlen(PROPFIND_ALL_REQUEST);
-	out_data = xmalloc(out_buffer.size + 1);
-	snprintf(out_data, out_buffer.size + 1, PROPFIND_ALL_REQUEST);
-	out_buffer.posn = 0;
-	out_buffer.buffer = out_data;
+	if (!strcmp(ls->path, ls->dentry_name) && (ls->flags & IS_DIR)) {
+		remote_dir_exists[*parent] = 1;
+		return;
+	}
 
-	in_buffer.size = 4096;
-	in_data = xmalloc(in_buffer.size);
-	in_buffer.posn = 0;
-	in_buffer.buffer = in_data;
+	if (strlen(path) != 49)
+		return;
+	path += 8;
+	obj_hex = xmalloc(strlen(path));
+	strncpy(obj_hex, path, 2);
+	strcpy(obj_hex + 2, path + 3);
+	one_remote_object(obj_hex);
+	free(obj_hex);
+}
 
-	dav_headers = curl_slist_append(dav_headers, "Depth: 1");
-	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
+static void process_ls_ref(struct remote_ls_ctx *ls)
+{
+	if (!strcmp(ls->path, ls->dentry_name) && (ls->dentry_flags & IS_DIR)) {
+		fprintf(stderr, "  %s\n", ls->dentry_name);
+		return;
+	}
 
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.size);
-	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PROPFIND);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
+	if (!(ls->dentry_flags & IS_DIR))
+		one_remote_ref(ls->dentry_name);
+}
 
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result == CURLE_OK) {
-			ctx.name = xcalloc(10, 1);
-			ctx.len = 0;
-			ctx.cdata = NULL;
-			ctx.userFunc = handle_crawl_ref_ctx;
-			ctx.userData = &dentry;
-			XML_SetUserData(parser, &ctx);
-			XML_SetElementHandler(parser, xml_start_tag,
-					      xml_end_tag);
-			XML_SetCharacterDataHandler(parser, xml_cdata);
-			result = XML_Parse(parser, in_buffer.buffer,
-					   in_buffer.posn, 1);
-			free(ctx.name);
+static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
+{
+	struct remote_ls_ctx *ls = (struct remote_ls_ctx *)ctx->userData;
 
-			if (result != XML_STATUS_OK) {
-				fprintf(stderr, "XML error: %s\n",
-					XML_ErrorString(
-						XML_GetErrorCode(parser)));
+	if (tag_closed) {
+		if (!strcmp(ctx->name, DAV_PROPFIND_RESP) && ls->dentry_name) {
+			if (ls->dentry_flags & IS_DIR) {
+				if (ls->flags & PROCESS_DIRS) {
+					ls->userFunc(ls);
+				}
+				if (strcmp(ls->dentry_name, ls->path) &&
+				    ls->flags & RECURSIVE) {
+					remote_ls(ls->dentry_name,
+						  ls->flags,
+						  ls->userFunc,
+						  ls->userData);
+				}
+			} else if (ls->flags & PROCESS_FILES) {
+				ls->userFunc(ls);
 			}
+		} else if (!strcmp(ctx->name, DAV_PROPFIND_NAME) && ctx->cdata) {
+			ls->dentry_name = xmalloc(strlen(ctx->cdata) -
+						  remote->path_len + 1);
+			strcpy(ls->dentry_name, ctx->cdata + remote->path_len);
+		} else if (!strcmp(ctx->name, DAV_PROPFIND_COLLECTION)) {
+			ls->dentry_flags |= IS_DIR;
 		}
-	} else {
-		fprintf(stderr, "Unable to start request\n");
+	} else if (!strcmp(ctx->name, DAV_PROPFIND_RESP)) {
+		if (ls->dentry_name) {
+			free(ls->dentry_name);
+		}
+		ls->dentry_name = NULL;
+		ls->dentry_flags = 0;
 	}
-
-	free(url);
-	free(out_data);
-	free(in_buffer.buffer);
-	curl_slist_free_all(dav_headers);
 }
 
-static void get_remote_object_list(unsigned char parent)
+static void remote_ls(const char *path, int flags,
+		      void (*userFunc)(struct remote_ls_ctx *ls),
+		      void *userData)
 {
-	char *url;
+	char *url = xmalloc(strlen(remote->url) + strlen(path) + 1);
 	struct active_request_slot *slot;
 	struct slot_results results;
 	struct buffer in_buffer;
@@ -1196,13 +1151,15 @@ static void get_remote_object_list(unsig
 	enum XML_Status result;
 	struct curl_slist *dav_headers = NULL;
 	struct xml_ctx ctx;
-	char path[] = "/objects/XX/";
-	static const char hex[] = "0123456789abcdef";
-	unsigned int val = parent;
+	struct remote_ls_ctx ls;
+
+	ls.flags = flags;
+	ls.path = strdup(path);
+	ls.dentry_name = NULL;
+	ls.dentry_flags = 0;
+	ls.userData = userData;
+	ls.userFunc = userFunc;
 
-	path[9] = hex[val >> 4];
-	path[10] = hex[val & 0xf];
-	url = xmalloc(strlen(remote->url) + strlen(path) + 1);
 	sprintf(url, "%s%s", remote->url, path);
 
 	out_buffer.size = strlen(PROPFIND_ALL_REQUEST);
@@ -1218,7 +1175,7 @@ static void get_remote_object_list(unsig
 
 	dav_headers = curl_slist_append(dav_headers, "Depth: 1");
 	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
-
+	
 	slot = get_active_slot();
 	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
@@ -1234,11 +1191,11 @@ static void get_remote_object_list(unsig
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result == CURLE_OK) {
-			remote_dir_exists[parent] = 1;
 			ctx.name = xcalloc(10, 1);
 			ctx.len = 0;
 			ctx.cdata = NULL;
-			ctx.userFunc = handle_remote_object_list_ctx;
+			ctx.userFunc = handle_remote_ls_ctx;
+			ctx.userData = &ls;
 			XML_SetUserData(parser, &ctx);
 			XML_SetElementHandler(parser, xml_start_tag,
 					      xml_end_tag);
@@ -1252,19 +1209,31 @@ static void get_remote_object_list(unsig
 					XML_ErrorString(
 						XML_GetErrorCode(parser)));
 			}
-		} else {
-			remote_dir_exists[parent] = 0;
 		}
 	} else {
-		fprintf(stderr, "Unable to start request\n");
+		fprintf(stderr, "Unable to start PROPFIND request\n");
 	}
 
+	free(ls.path);
 	free(url);
 	free(out_data);
 	free(in_buffer.buffer);
 	curl_slist_free_all(dav_headers);
 }
 
+static void get_remote_object_list(unsigned char parent)
+{
+	char path[] = "objects/XX/";
+	static const char hex[] = "0123456789abcdef";
+	unsigned int val = parent;
+
+	path[8] = hex[val >> 4];
+	path[9] = hex[val & 0xf];
+	remote_dir_exists[val] = 0;
+	remote_ls(path, (PROCESS_FILES | PROCESS_DIRS),
+		  process_ls_object, &val);
+}
+
 static int locking_available(void)
 {
 	struct active_request_slot *slot;
@@ -1534,7 +1503,7 @@ static void get_local_heads(void)
 static void get_dav_remote_heads(void)
 {
 	remote_tail = &remote_refs;
-	crawl_remote_refs("refs/");
+	remote_ls("refs/", (PROCESS_FILES | PROCESS_DIRS | RECURSIVE), process_ls_ref, NULL);
 }
 
 static int is_zero_sha1(const unsigned char *sha1)
-- 
1.2.4.g8e81-dirty
