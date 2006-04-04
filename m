From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] http-fetch: add optional DAV-based pack list
Date: Tue, 4 Apr 2006 05:33:18 -0700
Message-ID: <20060404123318.GC14967@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 04 14:33:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQkiw-0005lO-OR
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 14:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWDDMdY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 08:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWDDMdY
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 08:33:24 -0400
Received: from 241.37.26.69.virtela.com ([69.26.37.241]:42832 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932417AbWDDMdX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Apr 2006 08:33:23 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k34CXIXU016924
	for <git@vger.kernel.org>; Tue, 4 Apr 2006 05:33:19 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k34CXIJt016921
	for git@vger.kernel.org; Tue, 4 Apr 2006 05:33:18 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18390>

If git is not built with NO_EXPAT, this patch changes git-http-fetch to
attempt using DAV to get a list of remote packs and fall back to using
objects/info/packs if the DAV request fails.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 Makefile     |    7 +
 http-fetch.c |  278 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 284 insertions(+), 1 deletions(-)

9aef9577cabbd96de20562902d2958108616a7e4
diff --git a/Makefile b/Makefile
index c79d646..19ce42c 100644
--- a/Makefile
+++ b/Makefile
@@ -510,6 +510,11 @@ git$X git.spec \
 exec_cmd.o: exec_cmd.c
 	$(CC) -o $*.o -c $(ALL_CFLAGS) '-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' $<
 
+ifdef NO_EXPAT
+http-fetch.o: http-fetch.c
+	$(CC) -o $*.o -c $(ALL_CFLAGS) -DNO_EXPAT $<
+endif
+
 git-%$X: %.o $(GITLIBS)
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
@@ -532,7 +537,7 @@ git-imap-send$X: imap-send.o $(LIB_FILE)
 
 git-http-fetch$X: fetch.o http.o http-fetch.o $(LIB_FILE)
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS) $(CURL_LIBCURL)
+		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
 git-http-push$X: revision.o http.o http-push.o $(LIB_FILE)
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
diff --git a/http-fetch.c b/http-fetch.c
index dc67218..71a7daf 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -4,6 +4,35 @@ #include "pack.h"
 #include "fetch.h"
 #include "http.h"
 
+#ifndef NO_EXPAT
+#include <expat.h>
+
+/* Definitions for DAV requests */
+#define DAV_PROPFIND "PROPFIND"
+#define DAV_PROPFIND_RESP ".multistatus.response"
+#define DAV_PROPFIND_NAME ".multistatus.response.href"
+#define DAV_PROPFIND_COLLECTION ".multistatus.response.propstat.prop.resourcetype.collection"
+#define PROPFIND_ALL_REQUEST "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<D:propfind xmlns:D=\"DAV:\">\n<D:allprop/>\n</D:propfind>"
+
+/* Definitions for processing XML DAV responses */
+#ifndef XML_STATUS_OK
+enum XML_Status {
+  XML_STATUS_OK = 1,
+  XML_STATUS_ERROR = 0
+};
+#define XML_STATUS_OK    1
+#define XML_STATUS_ERROR 0
+#endif
+
+/* Flags that control remote_ls processing */
+#define PROCESS_FILES (1u << 0)
+#define PROCESS_DIRS  (1u << 1)
+#define RECURSIVE     (1u << 2)
+
+/* Flags that remote_ls passes to callback functions */
+#define IS_DIR (1u << 0)
+#endif
+
 #define PREV_BUF_SIZE 4096
 #define RANGE_HEADER_SIZE 30
 
@@ -15,6 +44,7 @@ static struct curl_slist *no_pragma_head
 struct alt_base
 {
 	char *base;
+	int path_len;
 	int got_indices;
 	struct packed_git *packs;
 	struct alt_base *next;
@@ -56,8 +86,32 @@ struct alternates_request {
 	struct buffer *buffer;
 	struct active_request_slot *slot;
 	int http_specific;
+};
+
+#ifndef NO_EXPAT
+struct xml_ctx
+{
+	char *name;
+	int len;
+	char *cdata;
+	void (*userFunc)(struct xml_ctx *ctx, int tag_closed);
+	void *userData;
 };
 
+struct remote_ls_ctx
+{
+	struct alt_base *repo;
+	char *path;
+	void (*userFunc)(struct remote_ls_ctx *ls);
+	void *userData;
+	int flags;
+	char *dentry_name;
+	int dentry_flags;
+	int rc;
+	struct remote_ls_ctx *parent;
+};
+#endif
+
 static struct object_request *object_queue_head = NULL;
 
 static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
@@ -500,6 +554,7 @@ static void process_alternates_response(
 			int serverlen = 0;
 			struct alt_base *newalt;
 			char *target = NULL;
+			char *path;
 			if (data[i] == '/') {
 				serverlen = strchr(base + 8, '/') - base;
 				okay = 1;
@@ -540,6 +595,13 @@ static void process_alternates_response(
 				newalt->base = target;
 				newalt->got_indices = 0;
 				newalt->packs = NULL;
+				path = strstr(target, "//");
+				if (path) {
+					path = index(path+2, '/');
+					if (path)
+						newalt->path_len = strlen(path);
+				}
+
 				while (tail->next != NULL)
 					tail = tail->next;
 				tail->next = newalt;
@@ -608,9 +670,212 @@ #endif
 		got_alternates = -1;
 
 	free(data);
+	free(url);
+}
+
+#ifndef NO_EXPAT
+static void
+xml_start_tag(void *userData, const char *name, const char **atts)
+{
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
+	}
+
+	ctx->userFunc(ctx, 0);
+}
+
+static void
+xml_end_tag(void *userData, const char *name)
+{
+	struct xml_ctx *ctx = (struct xml_ctx *)userData;
+	const char *c = index(name, ':');
+	char *ep;
+
+	ctx->userFunc(ctx, 1);
+
+	if (c == NULL)
+		c = name;
+	else
+		c++;
+
+	ep = ctx->name + strlen(ctx->name) - strlen(c) - 1;
+	*ep = 0;
+}
+
+static void
+xml_cdata(void *userData, const XML_Char *s, int len)
+{
+	struct xml_ctx *ctx = (struct xml_ctx *)userData;
+	if (ctx->cdata)
+		free(ctx->cdata);
+	ctx->cdata = xcalloc(len+1, 1);
+	strncpy(ctx->cdata, s, len);
+}
+
+static int remote_ls(struct alt_base *repo, const char *path, int flags,
+		     void (*userFunc)(struct remote_ls_ctx *ls),
+		     void *userData);
+
+static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
+{
+	struct remote_ls_ctx *ls = (struct remote_ls_ctx *)ctx->userData;
+
+	if (tag_closed) {
+		if (!strcmp(ctx->name, DAV_PROPFIND_RESP) && ls->dentry_name) {
+			if (ls->dentry_flags & IS_DIR) {
+				if (ls->flags & PROCESS_DIRS) {
+					ls->userFunc(ls);
+				}
+				if (strcmp(ls->dentry_name, ls->path) &&
+				    ls->flags & RECURSIVE) {
+					ls->rc = remote_ls(ls->repo,
+							   ls->dentry_name,
+							   ls->flags,
+							   ls->userFunc,
+							   ls->userData);
+				}
+			} else if (ls->flags & PROCESS_FILES) {
+				ls->userFunc(ls);
+			}
+		} else if (!strcmp(ctx->name, DAV_PROPFIND_NAME) && ctx->cdata) {
+			ls->dentry_name = xmalloc(strlen(ctx->cdata) -
+						  ls->repo->path_len + 1);
+			strcpy(ls->dentry_name, ctx->cdata + ls->repo->path_len);
+		} else if (!strcmp(ctx->name, DAV_PROPFIND_COLLECTION)) {
+			ls->dentry_flags |= IS_DIR;
+		}
+	} else if (!strcmp(ctx->name, DAV_PROPFIND_RESP)) {
+		if (ls->dentry_name) {
+			free(ls->dentry_name);
+		}
+		ls->dentry_name = NULL;
+		ls->dentry_flags = 0;
+	}
+}
+
+static int remote_ls(struct alt_base *repo, const char *path, int flags,
+		     void (*userFunc)(struct remote_ls_ctx *ls),
+		     void *userData)
+{
+	char *url = xmalloc(strlen(repo->base) + strlen(path) + 1);
+	struct active_request_slot *slot;
+	struct slot_results results;
+	struct buffer in_buffer;
+	struct buffer out_buffer;
+	char *in_data;
+	char *out_data;
+	XML_Parser parser = XML_ParserCreate(NULL);
+	enum XML_Status result;
+	struct curl_slist *dav_headers = NULL;
+	struct xml_ctx ctx;
+	struct remote_ls_ctx ls;
+
+	ls.flags = flags;
+	ls.repo = repo;
+	ls.path = strdup(path);
+	ls.dentry_name = NULL;
+	ls.dentry_flags = 0;
+	ls.userData = userData;
+	ls.userFunc = userFunc;
+	ls.rc = 0;
+
+	sprintf(url, "%s%s", repo->base, path);
+
+	out_buffer.size = strlen(PROPFIND_ALL_REQUEST);
+	out_data = xmalloc(out_buffer.size + 1);
+	snprintf(out_data, out_buffer.size + 1, PROPFIND_ALL_REQUEST);
+	out_buffer.posn = 0;
+	out_buffer.buffer = out_data;
+
+	in_buffer.size = 4096;
+	in_data = xmalloc(in_buffer.size);
+	in_buffer.posn = 0;
+	in_buffer.buffer = in_data;
+
+	dav_headers = curl_slist_append(dav_headers, "Depth: 1");
+	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
+
+	slot = get_active_slot();
+	slot->results = &results;
+	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.size);
+	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PROPFIND);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
+
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.curl_result == CURLE_OK) {
+			ctx.name = xcalloc(10, 1);
+			ctx.len = 0;
+			ctx.cdata = NULL;
+			ctx.userFunc = handle_remote_ls_ctx;
+			ctx.userData = &ls;
+			XML_SetUserData(parser, &ctx);
+			XML_SetElementHandler(parser, xml_start_tag,
+					      xml_end_tag);
+			XML_SetCharacterDataHandler(parser, xml_cdata);
+			result = XML_Parse(parser, in_buffer.buffer,
+					   in_buffer.posn, 1);
+			free(ctx.name);
+
+			if (result != XML_STATUS_OK) {
+				ls.rc = error("XML error: %s",
+					      XML_ErrorString(
+						      XML_GetErrorCode(parser)));
+			}
+		} else {
+			ls.rc = -1;
+		}
+	} else {
+		ls.rc = error("Unable to start PROPFIND request");
+	}
+
+	free(ls.path);
 	free(url);
+	free(out_data);
+	free(in_buffer.buffer);
+	curl_slist_free_all(dav_headers);
+
+	return ls.rc;
 }
 
+static void process_ls_pack(struct remote_ls_ctx *ls)
+{
+	unsigned char sha1[20];
+
+	if (strlen(ls->dentry_name) == 63 &&
+	    !strncmp(ls->dentry_name, "objects/pack/pack-", 18) &&
+	    !strncmp(ls->dentry_name+58, ".pack", 5)) {
+		get_sha1_hex(ls->dentry_name + 18, sha1);
+		setup_index(ls->repo, sha1);
+	}
+}
+#endif
+
 static int fetch_indices(struct alt_base *repo)
 {
 	unsigned char sha1[20];
@@ -632,6 +897,12 @@ static int fetch_indices(struct alt_base
 
 	if (get_verbosely)
 		fprintf(stderr, "Getting pack list for %s\n", repo->base);
+
+#ifndef NO_EXPAT
+	if (remote_ls(repo, "objects/pack/", PROCESS_FILES,
+		      process_ls_pack, NULL) == 0)
+		return 0;
+#endif
 
 	url = xmalloc(strlen(repo->base) + 21);
 	sprintf(url, "%s/objects/info/packs", repo->base);
@@ -947,6 +1218,7 @@ int main(int argc, char **argv)
 {
 	char *commit_id;
 	char *url;
+	char *path;
 	int arg = 1;
 	int rc = 0;
 
@@ -987,6 +1259,12 @@ int main(int argc, char **argv)
 	alt->got_indices = 0;
 	alt->packs = NULL;
 	alt->next = NULL;
+	path = strstr(url, "//");
+	if (path) {
+		path = index(path+2, '/');
+		if (path)
+			alt->path_len = strlen(path);
+	}
 
 	if (pull(commit_id))
 		rc = 1;
-- 
1.3.0.rc1.gd4df-dirty
