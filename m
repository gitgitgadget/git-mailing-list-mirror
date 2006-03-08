From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] Update http-push functionality
Date: Tue, 7 Mar 2006 16:13:20 -0800
Message-ID: <20060308001320.GA3997@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Mar 08 01:13:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGmJ7-0004sB-Gc
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 01:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWCHAN2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 19:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWCHAN2
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 19:13:28 -0500
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:10626 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S964816AbWCHAN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Mar 2006 19:13:26 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k280DLx7020242
	for <git@vger.kernel.org>; Tue, 7 Mar 2006 16:13:21 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k280DLTQ020240
	for git@vger.kernel.org; Tue, 7 Mar 2006 16:13:21 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17356>

This brings http-push functionality more in line with the ssh/git version,
by borrowing bits from send-pack and rev-list to process refspecs and
revision history in more standard ways.  Also, the status of remote objects
is determined using PROPFIND requests for the object directory rather than
HEAD requests for each object - while it may be less efficient for small
numbers of objects, this approach is able to get the status of all remote
loose objects in a maximum of 256 requests.

---

I've tested this by running "git push --all --tags remote" into a newly
initialized repo, and by rewinding one or multiple overlapping heads and
pushing combinations of them.

This also lays a bit of groundwork for updating remote info/refs.

Getting my head around the underlying object/refspec/revision stuff made
it hurt, and I've got to say that you guys rule.

 Makefile    |    2 
 http-push.c | 1060 ++++++++++++++++++++++++++++++++++++++++-------------------
 2 files changed, 727 insertions(+), 335 deletions(-)

9d2903e7bf846eeefd3f108207d7c212139ff97c
diff --git a/Makefile b/Makefile
index b6d8804..1c555da 100644
--- a/Makefile
+++ b/Makefile
@@ -526,7 +526,7 @@ git-http-fetch$X: fetch.o http.o http-fe
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL)
 
-git-http-push$X: http.o http-push.o $(LIB_FILE)
+git-http-push$X: revision.o http.o http-push.o $(LIB_FILE)
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
diff --git a/http-push.c b/http-push.c
index fe92560..970cbfe 100644
--- a/http-push.c
+++ b/http-push.c
@@ -5,6 +5,8 @@
 #include "tag.h"
 #include "blob.h"
 #include "http.h"
+#include "refs.h"
+#include "revision.h"
 
 #include <expat.h>
 
@@ -42,14 +44,24 @@ enum XML_Status {
 #define DAV_ACTIVELOCK_OWNER ".prop.lockdiscovery.activelock.owner.href"
 #define DAV_ACTIVELOCK_TIMEOUT ".prop.lockdiscovery.activelock.timeout"
 #define DAV_ACTIVELOCK_TOKEN ".prop.lockdiscovery.activelock.locktoken.href"
+#define DAV_PROPFIND_RESP ".multistatus.response"
+#define DAV_PROPFIND_NAME ".multistatus.response.href"
+#define DAV_PROPFIND_COLLECTION ".multistatus.response.propstat.prop.resourcetype.collection"
 
 /* DAV request body templates */
-#define PROPFIND_REQUEST "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<D:propfind xmlns:D=\"DAV:\">\n<D:prop xmlns:R=\"%s\">\n<D:supportedlock/>\n</D:prop>\n</D:propfind>"
+#define PROPFIND_SUPPORTEDLOCK_REQUEST "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<D:propfind xmlns:D=\"DAV:\">\n<D:prop xmlns:R=\"%s\">\n<D:supportedlock/>\n</D:prop>\n</D:propfind>"
+#define PROPFIND_ALL_REQUEST "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<D:propfind xmlns:D=\"DAV:\">\n<D:allprop/>\n</D:propfind>"
 #define LOCK_REQUEST "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<D:lockinfo xmlns:D=\"DAV:\">\n<D:lockscope><D:exclusive/></D:lockscope>\n<D:locktype><D:write/></D:locktype>\n<D:owner>\n<D:href>mailto:%s</D:href>\n</D:owner>\n</D:lockinfo>"
 
 #define LOCK_TIME 600
 #define LOCK_REFRESH 30
 
+/* bits #0-4 in revision.h */
+
+#define LOCAL   (1u << 5)
+#define REMOTE  (1u << 6)
+#define PUSHING (1u << 7)
+
 static int pushing = 0;
 static int aborted = 0;
 static char remote_dir_exists[256];
@@ -61,17 +73,19 @@ static int push_verbosely = 0;
 static int push_all = 0;
 static int force_all = 0;
 
+static struct object_list *objects = NULL;
+
 struct repo
 {
 	char *url;
+	int path_len;
 	struct packed_git *packs;
 };
 
 static struct repo *remote = NULL;
+static struct remote_lock *remote_locks = NULL;
 
 enum transfer_state {
-	NEED_CHECK,
-	RUN_HEAD,
 	NEED_PUSH,
 	RUN_MKCOL,
 	RUN_PUT,
@@ -82,10 +96,10 @@ enum transfer_state {
 
 struct transfer_request
 {
-	unsigned char sha1[20];
+	struct object *obj;
 	char *url;
 	char *dest;
-	struct active_lock *lock;
+	struct remote_lock *lock;
 	struct curl_slist *headers;
 	struct buffer buffer;
 	char filename[PATH_MAX];
@@ -114,14 +128,23 @@ struct xml_ctx
 	void *userData;
 };
 
-struct active_lock
+struct remote_lock
 {
 	char *url;
 	char *owner;
 	char *token;
 	time_t start_time;
 	long timeout;
+	int active;
 	int refreshing;
+	struct remote_lock *next;
+};
+
+struct remote_dentry
+{
+	char *base;
+	char *name;
+	int is_dir;
 };
 
 static void finish_request(struct transfer_request *request);
@@ -134,42 +157,9 @@ static void process_response(void *callb
 	finish_request(request);
 }
 
-static void start_check(struct transfer_request *request)
-{
-	char *hex = sha1_to_hex(request->sha1);
-	struct active_request_slot *slot;
-	char *posn;
-
-	request->url = xmalloc(strlen(remote->url) + 55);
-	strcpy(request->url, remote->url);
-	posn = request->url + strlen(remote->url);
-	strcpy(posn, "objects/");
-	posn += 8;
-	memcpy(posn, hex, 2);
-	posn += 2;
-	*(posn++) = '/';
-	strcpy(posn, hex + 2);
-
-	slot = get_active_slot();
-	slot->callback_func = process_response;
-	slot->callback_data = request;
-	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, request->errorstr);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, request->url);
-	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
-
-	if (start_active_slot(slot)) {
-		request->slot = slot;
-		request->state = RUN_HEAD;
-	} else {
-		request->state = ABORTED;
-		free(request->url);
-		request->url = NULL;
-	}
-}
-
 static void start_mkcol(struct transfer_request *request)
 {
-	char *hex = sha1_to_hex(request->sha1);
+	char *hex = sha1_to_hex(request->obj->sha1);
 	struct active_request_slot *slot;
 	char *posn;
 
@@ -203,7 +193,7 @@ static void start_mkcol(struct transfer_
 
 static void start_put(struct transfer_request *request)
 {
-	char *hex = sha1_to_hex(request->sha1);
+	char *hex = sha1_to_hex(request->obj->sha1);
 	struct active_request_slot *slot;
 	char *posn;
 	char type[20];
@@ -214,7 +204,7 @@ static void start_put(struct transfer_re
 	ssize_t size;
 	z_stream stream;
 
-	unpacked = read_sha1_file(request->sha1, type, &len);
+	unpacked = read_sha1_file(request->obj->sha1, type, &len);
 	hdrlen = sprintf(hdr, "%s %lu", type, len) + 1;
 
 	/* Set it up */
@@ -309,64 +299,90 @@ static void start_move(struct transfer_r
 	}
 }
 
-static int refresh_lock(struct active_lock *lock)
+static int refresh_lock(struct remote_lock *check_lock)
 {
 	struct active_request_slot *slot;
 	char *if_header;
 	char timeout_header[25];
 	struct curl_slist *dav_headers = NULL;
-	int rc = 0;
+	struct remote_lock *lock;
+	int time_remaining;
+	time_t current_time;
 
-	lock->refreshing = 1;
+	/* Refresh all active locks if they're close to expiring */
+	for (lock = remote_locks; lock; lock = lock->next) {
+		if (!lock->active)
+			continue;
 
-	if_header = xmalloc(strlen(lock->token) + 25);
-	sprintf(if_header, "If: (<opaquelocktoken:%s>)", lock->token);
-	sprintf(timeout_header, "Timeout: Second-%ld", lock->timeout);
-	dav_headers = curl_slist_append(dav_headers, if_header);
-	dav_headers = curl_slist_append(dav_headers, timeout_header);
+		current_time = time(NULL);
+		time_remaining = lock->start_time + lock->timeout
+			- current_time;
+		if (time_remaining > LOCK_REFRESH)
+			continue;
 
-	slot = get_active_slot();
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, lock->url);
-	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_LOCK);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
+		lock->refreshing = 1;
 
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (slot->curl_result != CURLE_OK) {
-			fprintf(stderr, "Got HTTP error %ld\n", slot->http_code);
-		} else {
-			lock->start_time = time(NULL);
-			rc = 1;
+		if_header = xmalloc(strlen(lock->token) + 25);
+		sprintf(if_header, "If: (<opaquelocktoken:%s>)", lock->token);
+		sprintf(timeout_header, "Timeout: Second-%ld", lock->timeout);
+		dav_headers = curl_slist_append(dav_headers, if_header);
+		dav_headers = curl_slist_append(dav_headers, timeout_header);
+
+		slot = get_active_slot();
+		curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
+		curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
+		curl_easy_setopt(slot->curl, CURLOPT_URL, lock->url);
+		curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_LOCK);
+		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
+
+		if (start_active_slot(slot)) {
+			run_active_slot(slot);
+			if (slot->curl_result != CURLE_OK) {
+				fprintf(stderr, "Got HTTP error %ld\n", slot->http_code);
+				lock->active = 0;
+			} else {
+				lock->active = 1;
+				lock->start_time = time(NULL);
+			}
 		}
+
+		lock->refreshing = 0;
+		curl_slist_free_all(dav_headers);
+		free(if_header);
 	}
 
-	lock->refreshing = 0;
-	curl_slist_free_all(dav_headers);
-	free(if_header);
+	if (check_lock)
+		return check_lock->active;
+	else
+		return 0;
+}
 
-	return rc;
+static void release_request(struct transfer_request *request)
+{
+	struct transfer_request *entry = request_queue_head;
+
+	if (request == request_queue_head) {
+		request_queue_head = request->next;
+	} else {
+		while (entry->next != NULL && entry->next != request)
+			entry = entry->next;
+		if (entry->next == request)
+			entry->next = entry->next->next;
+	}
+
+	if (request->url != NULL)
+		free(request->url);
+	free(request);
 }
 
 static void finish_request(struct transfer_request *request)
 {
-	time_t current_time = time(NULL);
-	int time_remaining;
-
 	request->curl_result =	request->slot->curl_result;
 	request->http_code = request->slot->http_code;
 	request->slot = NULL;
 
-	/* Refresh the lock if it is close to timing out */
-	time_remaining = request->lock->start_time + request->lock->timeout
-		- current_time;
-	if (time_remaining < LOCK_REFRESH && !request->lock->refreshing) {
-		if (!refresh_lock(request->lock)) {
-			fprintf(stderr, "Unable to refresh remote lock\n");
-			aborted = 1;
-		}
-	}
+	/* Keep locks active */
+	refresh_lock(request->lock);
 
 	if (request->headers != NULL)
 		curl_slist_free_all(request->headers);
@@ -377,27 +393,14 @@ static void finish_request(struct transf
 		request->url = NULL;
 	}		
 
-	if (request->state == RUN_HEAD) {
-		if (request->http_code == 404) {
-			request->state = NEED_PUSH;
-		} else if (request->curl_result == CURLE_OK) {
-			remote_dir_exists[request->sha1[0]] = 1;
-			request->state = COMPLETE;
-		} else {
-			fprintf(stderr, "HEAD %s failed, aborting (%d/%ld)\n",
-				sha1_to_hex(request->sha1),
-				request->curl_result, request->http_code);
-			request->state = ABORTED;
-			aborted = 1;
-		}
-	} else if (request->state == RUN_MKCOL) {
+	if (request->state == RUN_MKCOL) {
 		if (request->curl_result == CURLE_OK ||
 		    request->http_code == 405) {
-			remote_dir_exists[request->sha1[0]] = 1;
+			remote_dir_exists[request->obj->sha1[0]] = 1;
 			start_put(request);
 		} else {
 			fprintf(stderr, "MKCOL %s failed, aborting (%d/%ld)\n",
-				sha1_to_hex(request->sha1),
+				sha1_to_hex(request->obj->sha1),
 				request->curl_result, request->http_code);
 			request->state = ABORTED;
 			aborted = 1;
@@ -407,21 +410,21 @@ static void finish_request(struct transf
 			start_move(request);
 		} else {
 			fprintf(stderr,	"PUT %s failed, aborting (%d/%ld)\n",
-				sha1_to_hex(request->sha1),
+				sha1_to_hex(request->obj->sha1),
 				request->curl_result, request->http_code);
 			request->state = ABORTED;
 			aborted = 1;
 		}
 	} else if (request->state == RUN_MOVE) {
 		if (request->curl_result == CURLE_OK) {
-			if (push_verbosely)
-				fprintf(stderr,
-					"sent %s\n",
-					sha1_to_hex(request->sha1));
+			fprintf(stderr, "    sent %s\n",
+				sha1_to_hex(request->obj->sha1));
 			request->state = COMPLETE;
+			request->obj->flags |= REMOTE;
+			release_request(request);
 		} else {
 			fprintf(stderr, "MOVE %s failed, aborting (%d/%ld)\n",
-				sha1_to_hex(request->sha1),
+				sha1_to_hex(request->obj->sha1),
 				request->curl_result, request->http_code);
 			request->state = ABORTED;
 			aborted = 1;
@@ -429,24 +432,6 @@ static void finish_request(struct transf
 	}
 }
 
-static void release_request(struct transfer_request *request)
-{
-	struct transfer_request *entry = request_queue_head;
-
-	if (request == request_queue_head) {
-		request_queue_head = request->next;
-	} else {
-		while (entry->next != NULL && entry->next != request)
-			entry = entry->next;
-		if (entry->next == request)
-			entry->next = entry->next->next;
-	}
-
-	if (request->url != NULL)
-		free(request->url);
-	free(request);
-}
-
 void fill_active_slots(void)
 {
 	struct transfer_request *request = request_queue_head;
@@ -457,14 +442,12 @@ void fill_active_slots(void)
 		return;
 
 	while (active_requests < max_requests && request != NULL) {
-		if (!pushing && request->state == NEED_CHECK) {
-			start_check(request);
-			curl_multi_perform(curlm, &num_transfers);
-		} else if (pushing && request->state == NEED_PUSH) {
-			if (remote_dir_exists[request->sha1[0]])
+		if (pushing && request->state == NEED_PUSH) {
+			if (remote_dir_exists[request->obj->sha1[0]] == 1) {
 				start_put(request);
-			else
+			} else {
 				start_mkcol(request);
+			}
 			curl_multi_perform(curlm, &num_transfers);
 		}
 		request = request->next;
@@ -479,26 +462,34 @@ void fill_active_slots(void)
 	}				
 }
 
-static void add_request(unsigned char *sha1, struct active_lock *lock)
+static void get_remote_object_list(unsigned char parent);
+
+static void add_request(struct object *obj, struct remote_lock *lock)
 {
 	struct transfer_request *request = request_queue_head;
 	struct packed_git *target;
-	
-	while (request != NULL && memcmp(request->sha1, sha1, 20))
-		request = request->next;
-	if (request != NULL)
-		return;
 
-	target = find_sha1_pack(sha1, remote->packs);
-	if (target)
+	/*
+	 * Don't push the object if it's known to exist on the remote
+	 * or is already in the request queue
+	 */
+	if (remote_dir_exists[obj->sha1[0]] == -1)
+		get_remote_object_list(obj->sha1[0]);
+	if (obj->flags & (REMOTE | PUSHING))
 		return;
+	target = find_sha1_pack(obj->sha1, remote->packs);
+	if (target) {
+		obj->flags |= REMOTE;
+		return;
+	}
 
+	obj->flags |= PUSHING;
 	request = xmalloc(sizeof(*request));
-	memcpy(request->sha1, sha1, 20);
+	request->obj = obj;
 	request->url = NULL;
 	request->lock = lock;
 	request->headers = NULL;
-	request->state = NEED_CHECK;
+	request->state = NEED_PUSH;
 	request->next = request_queue_head;
 	request_queue_head = request;
 
@@ -698,14 +689,13 @@ static char *quote_ref_url(const char *b
 	int len, baselen, ch;
 
 	baselen = strlen(base);
-	len = baselen + 12; /* "refs/heads/" + NUL */
+	len = baselen + 1;
 	for (cp = ref; (ch = *cp) != 0; cp++, len++)
 		if (needs_quote(ch))
 			len += 2; /* extra two hex plus replacement % */
 	qref = xmalloc(len);
 	memcpy(qref, base, baselen);
-	memcpy(qref + baselen, "refs/heads/", 11);
-	for (cp = ref, dp = qref + baselen + 11; (ch = *cp) != 0; cp++) {
+	for (cp = ref, dp = qref + baselen; (ch = *cp) != 0; cp++) {
 		if (needs_quote(ch)) {
 			*dp++ = '%';
 			*dp++ = hex((ch >> 4) & 0xF);
@@ -751,6 +741,27 @@ int fetch_ref(char *ref, unsigned char *
         return 0;
 }
 
+static void one_remote_object(const char *hex)
+{
+	unsigned char sha1[20];
+	struct object *obj;
+
+	if (get_sha1_hex(hex, sha1) != 0)
+		return;
+
+	obj = lookup_object(sha1);
+	if (!obj)
+		obj = parse_object(sha1);
+
+	/* Ignore remote objects that don't exist locally */
+	if (!obj)
+		return;
+
+	obj->flags |= REMOTE;
+	if (!object_list_contains(objects, obj))
+		add_object(obj, &objects, NULL, "");
+}
+
 static void handle_lockprop_ctx(struct xml_ctx *ctx, int tag_closed)
 {
 	int *lock_flags = (int *)ctx->userData;
@@ -772,7 +783,7 @@ static void handle_lockprop_ctx(struct x
 
 static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
 {
-	struct active_lock *lock = (struct active_lock *)ctx->userData;
+	struct remote_lock *lock = (struct remote_lock *)ctx->userData;
 
 	if (tag_closed && ctx->cdata) {
 		if (!strcmp(ctx->name, DAV_ACTIVELOCK_OWNER)) {
@@ -791,6 +802,57 @@ static void handle_new_lock_ctx(struct x
 	}
 }
 
+static void one_remote_ref(char *refname);
+static void crawl_remote_refs(char *path);
+
+static void handle_crawl_ref_ctx(struct xml_ctx *ctx, int tag_closed)
+{
+	struct remote_dentry *dentry = (struct remote_dentry *)ctx->userData;
+
+
+	if (tag_closed) {
+		if (!strcmp(ctx->name, DAV_PROPFIND_RESP) && dentry->name) {
+			if (dentry->is_dir) {
+				if (strcmp(dentry->name, dentry->base)) {
+					crawl_remote_refs(dentry->name);
+				}
+			} else {
+				one_remote_ref(dentry->name);
+			}
+		} else if (!strcmp(ctx->name, DAV_PROPFIND_NAME) && ctx->cdata) {
+			dentry->name = xmalloc(strlen(ctx->cdata) -
+					       remote->path_len + 1);
+			strcpy(dentry->name,
+			       ctx->cdata + remote->path_len);
+		} else if (!strcmp(ctx->name, DAV_PROPFIND_COLLECTION)) {
+			dentry->is_dir = 1;
+		}
+	} else if (!strcmp(ctx->name, DAV_PROPFIND_RESP)) {
+		dentry->name = NULL;
+		dentry->is_dir = 0;
+	}
+}
+
+static void handle_remote_object_list_ctx(struct xml_ctx *ctx, int tag_closed)
+{
+	char *path;
+	char *obj_hex;
+
+	if (tag_closed) {
+		if (!strcmp(ctx->name, DAV_PROPFIND_NAME) && ctx->cdata) {
+			path = ctx->cdata + remote->path_len;
+			if (strlen(path) != 50)
+				return;
+			path += 9;
+			obj_hex = xmalloc(strlen(path));
+			strncpy(obj_hex, path, 2);
+			strcpy(obj_hex + 2, path + 3);
+			one_remote_object(obj_hex);
+			free(obj_hex);
+		}
+	}
+}
+
 static void
 xml_start_tag(void *userData, const char *name, const char **atts)
 {
@@ -848,7 +910,7 @@ xml_cdata(void *userData, const XML_Char
 	strncpy(ctx->cdata, s, len);
 }
 
-static struct active_lock *lock_remote(char *file, long timeout)
+static struct remote_lock *lock_remote(char *path, long timeout)
 {
 	struct active_request_slot *slot;
 	struct buffer out_buffer;
@@ -858,14 +920,26 @@ static struct active_lock *lock_remote(c
 	char *url;
 	char *ep;
 	char timeout_header[25];
-	struct active_lock *new_lock = NULL;
+	struct remote_lock *lock = remote_locks;
 	XML_Parser parser = XML_ParserCreate(NULL);
 	enum XML_Status result;
 	struct curl_slist *dav_headers = NULL;
 	struct xml_ctx ctx;
 
-	url = xmalloc(strlen(remote->url) + strlen(file) + 1);
-	sprintf(url, "%s%s", remote->url, file);
+	url = xmalloc(strlen(remote->url) + strlen(path) + 1);
+	sprintf(url, "%s%s", remote->url, path);
+
+	/* Make sure the url is not already locked */
+	while (lock && strcmp(lock->url, url)) {
+		lock = lock->next;
+	}
+	if (lock) {
+		free(url);
+		if (refresh_lock(lock))
+			return lock;
+		else
+			return NULL;
+	}
 
 	/* Make sure leading directories exist for the remote ref */
 	ep = strchr(url + strlen(remote->url) + 11, '/');
@@ -921,11 +995,11 @@ static struct active_lock *lock_remote(c
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_LOCK);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
 
-	new_lock = xcalloc(1, sizeof(*new_lock));
-	new_lock->owner = NULL;
-	new_lock->token = NULL;
-	new_lock->timeout = -1;
-	new_lock->refreshing = 0;
+	lock = xcalloc(1, sizeof(*lock));
+	lock->owner = NULL;
+	lock->token = NULL;
+	lock->timeout = -1;
+	lock->refreshing = 0;
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
@@ -934,7 +1008,7 @@ static struct active_lock *lock_remote(c
 			ctx.len = 0;
 			ctx.cdata = NULL;
 			ctx.userFunc = handle_new_lock_ctx;
-			ctx.userData = new_lock;
+			ctx.userData = lock;
 			XML_SetUserData(parser, &ctx);
 			XML_SetElementHandler(parser, xml_start_tag,
 					      xml_end_tag);
@@ -946,7 +1020,7 @@ static struct active_lock *lock_remote(c
 				fprintf(stderr, "XML error: %s\n",
 					XML_ErrorString(
 						XML_GetErrorCode(parser)));
-				new_lock->timeout = -1;
+				lock->timeout = -1;
 			}
 		}
 	} else {
@@ -957,23 +1031,26 @@ static struct active_lock *lock_remote(c
 	free(out_data);
 	free(in_data);
 
-	if (new_lock->token == NULL || new_lock->timeout <= 0) {
-		if (new_lock->token != NULL)
-			free(new_lock->token);
-		if (new_lock->owner != NULL)
-			free(new_lock->owner);
+	if (lock->token == NULL || lock->timeout <= 0) {
+		if (lock->token != NULL)
+			free(lock->token);
+		if (lock->owner != NULL)
+			free(lock->owner);
 		free(url);
-		free(new_lock);
-		new_lock = NULL;
+		free(lock);
+		lock = NULL;
 	} else {
-		new_lock->url = url;
-		new_lock->start_time = time(NULL);
+		lock->url = url;
+		lock->active = 1;
+		lock->start_time = time(NULL);
+		lock->next = remote_locks;
+		remote_locks = lock;
 	}
 
-	return new_lock;
+	return lock;
 }
 
-static int unlock_remote(struct active_lock *lock)
+static int unlock_remote(struct remote_lock *lock)
 {
 	struct active_request_slot *slot;
 	char *lock_token_header;
@@ -1005,15 +1082,171 @@ static int unlock_remote(struct active_l
 	curl_slist_free_all(dav_headers);
 	free(lock_token_header);
 
-	if (lock->owner != NULL)
-		free(lock->owner);
-	free(lock->url);
-	free(lock->token);
-	free(lock);
+	lock->active = 0;
 
 	return rc;
 }
 
+static void crawl_remote_refs(char *path)
+{
+	char *url;
+	struct active_request_slot *slot;
+	struct buffer in_buffer;
+	struct buffer out_buffer;
+	char *in_data;
+	char *out_data;
+	XML_Parser parser = XML_ParserCreate(NULL);
+	enum XML_Status result;
+	struct curl_slist *dav_headers = NULL;
+	struct xml_ctx ctx;
+	struct remote_dentry dentry;
+
+	fprintf(stderr, "  %s\n", path);
+
+	dentry.base = path;
+	dentry.name = NULL;
+	dentry.is_dir = 0;
+
+	url = xmalloc(strlen(remote->url) + strlen(path) + 1);
+	sprintf(url, "%s%s", remote->url, path);
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
+		if (slot->curl_result == CURLE_OK) {
+			ctx.name = xcalloc(10, 1);
+			ctx.len = 0;
+			ctx.cdata = NULL;
+			ctx.userFunc = handle_crawl_ref_ctx;
+			ctx.userData = &dentry;
+			XML_SetUserData(parser, &ctx);
+			XML_SetElementHandler(parser, xml_start_tag,
+					      xml_end_tag);
+			XML_SetCharacterDataHandler(parser, xml_cdata);
+			result = XML_Parse(parser, in_buffer.buffer,
+					   in_buffer.posn, 1);
+			free(ctx.name);
+
+			if (result != XML_STATUS_OK) {
+				fprintf(stderr, "XML error: %s\n",
+					XML_ErrorString(
+						XML_GetErrorCode(parser)));
+			}
+		}
+	} else {
+		fprintf(stderr, "Unable to start request\n");
+	}
+
+	free(url);
+	free(out_data);
+	free(in_buffer.buffer);
+	curl_slist_free_all(dav_headers);
+}
+
+static void get_remote_object_list(unsigned char parent)
+{
+	char *url;
+	struct active_request_slot *slot;
+	struct buffer in_buffer;
+	struct buffer out_buffer;
+	char *in_data;
+	char *out_data;
+	XML_Parser parser = XML_ParserCreate(NULL);
+	enum XML_Status result;
+	struct curl_slist *dav_headers = NULL;
+	struct xml_ctx ctx;
+	char path[] = "/objects/XX/";
+	static const char hex[] = "0123456789abcdef";
+	unsigned int val = parent;
+
+	path[9] = hex[val >> 4];
+	path[10] = hex[val & 0xf];
+	url = xmalloc(strlen(remote->url) + strlen(path) + 1);
+	sprintf(url, "%s%s", remote->url, path);
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
+		if (slot->curl_result == CURLE_OK) {
+			remote_dir_exists[parent] = 1;
+			ctx.name = xcalloc(10, 1);
+			ctx.len = 0;
+			ctx.cdata = NULL;
+			ctx.userFunc = handle_remote_object_list_ctx;
+			XML_SetUserData(parser, &ctx);
+			XML_SetElementHandler(parser, xml_start_tag,
+					      xml_end_tag);
+			XML_SetCharacterDataHandler(parser, xml_cdata);
+			result = XML_Parse(parser, in_buffer.buffer,
+					   in_buffer.posn, 1);
+			free(ctx.name);
+
+			if (result != XML_STATUS_OK) {
+				fprintf(stderr, "XML error: %s\n",
+					XML_ErrorString(
+						XML_GetErrorCode(parser)));
+			}
+		} else {
+			remote_dir_exists[parent] = 0;
+		}
+	} else {
+		fprintf(stderr, "Unable to start request\n");
+	}
+
+	free(url);
+	free(out_data);
+	free(in_buffer.buffer);
+	curl_slist_free_all(dav_headers);	
+}
+
 static int locking_available(void)
 {
 	struct active_request_slot *slot;
@@ -1027,9 +1260,12 @@ static int locking_available(void)
 	struct xml_ctx ctx;
 	int lock_flags = 0;
 
-	out_buffer.size = strlen(PROPFIND_REQUEST) + strlen(remote->url) - 2;
+	out_buffer.size =
+		strlen(PROPFIND_SUPPORTEDLOCK_REQUEST) + 
+		strlen(remote->url) - 2;
 	out_data = xmalloc(out_buffer.size + 1);
-	snprintf(out_data, out_buffer.size + 1, PROPFIND_REQUEST, remote->url);
+	snprintf(out_data, out_buffer.size + 1,
+		 PROPFIND_SUPPORTEDLOCK_REQUEST, remote->url);
 	out_buffer.posn = 0;
 	out_buffer.buffer = out_data;
 
@@ -1085,85 +1321,99 @@ static int locking_available(void)
 	return lock_flags;
 }
 
-static int is_ancestor(unsigned char *sha1, struct commit *commit)
+static struct object_list **process_blob(struct blob *blob,
+					 struct object_list **p,
+					 struct name_path *path,
+					 const char *name)
 {
-	struct commit_list *parents;
+	struct object *obj = &blob->object;
 
-	if (parse_commit(commit))
-		return 0;
-	parents = commit->parents;
-	for (; parents; parents = parents->next) {
-		if (!memcmp(sha1, parents->item->object.sha1, 20)) {
-			return 1;
-		} else if (parents->item->object.type == commit_type) {
-			if (is_ancestor(
-				    sha1,
-				    (struct commit *)&parents->item->object
-				    ))
-				return 1;
-		}
+	obj->flags |= LOCAL;
+
+	if (obj->flags & (UNINTERESTING | SEEN))
+		return p;
+
+	obj->flags |= SEEN;
+	return add_object(obj, p, path, name);
+}
+
+static struct object_list **process_tree(struct tree *tree,
+					 struct object_list **p,
+					 struct name_path *path,
+					 const char *name)
+{
+	struct object *obj = &tree->object;
+	struct tree_entry_list *entry;
+	struct name_path me;
+
+	obj->flags |= LOCAL;
+
+	if (obj->flags & (UNINTERESTING | SEEN))
+		return p;
+	if (parse_tree(tree) < 0)
+		die("bad tree object %s", sha1_to_hex(obj->sha1));
+
+	obj->flags |= SEEN;
+	p = add_object(obj, p, NULL, name);
+	me.up = path;
+	me.elem = name;
+	me.elem_len = strlen(name);
+	entry = tree->entries;
+	tree->entries = NULL;
+	while (entry) {
+		struct tree_entry_list *next = entry->next;
+		if (entry->directory)
+			p = process_tree(entry->item.tree, p, &me, entry->name);
+		else
+			p = process_blob(entry->item.blob, p, &me, entry->name);
+		free(entry);
+		entry = next;
 	}
-	return 0;
+	return p;
 }
 
-static void get_delta(unsigned char *sha1, struct object *obj,
-		      struct active_lock *lock)
+static void get_delta(struct rev_info *revs, struct remote_lock *lock)
 {
 	struct commit *commit;
-	struct commit_list *parents;
-	struct tree *tree;
-	struct tree_entry_list *entry;
+	struct object_list **p = &objects, *pending;
 
-	if (sha1 && !memcmp(sha1, obj->sha1, 20))
-		return;
+	while ((commit = get_revision(revs)) != NULL) {
+		p = process_tree(commit->tree, p, NULL, "");
+		commit->object.flags |= LOCAL;
+		if (!(commit->object.flags & UNINTERESTING))
+			add_request(&commit->object, lock);
+	}
 
-	if (aborted)
-		return;
+	for (pending = revs->pending_objects; pending; pending = pending->next) {
+		struct object *obj = pending->item;
+		const char *name = pending->name;
 
-	if (obj->type == commit_type) {
-		if (push_verbosely)
-			fprintf(stderr, "walk %s\n", sha1_to_hex(obj->sha1));
-		add_request(obj->sha1, lock);
-		commit = (struct commit *)obj;
-		if (parse_commit(commit)) {
-			fprintf(stderr, "Error parsing commit %s\n",
-				sha1_to_hex(obj->sha1));
-			aborted = 1;
-			return;
+		if (obj->flags & (UNINTERESTING | SEEN))
+			continue;
+		if (obj->type == tag_type) {
+			obj->flags |= SEEN;
+			p = add_object(obj, p, NULL, name);
+			continue;
 		}
-		parents = commit->parents;
-		for (; parents; parents = parents->next)
-			if (sha1 == NULL ||
-			    memcmp(sha1, parents->item->object.sha1, 20))
-				get_delta(sha1, &parents->item->object,
-					  lock);
-		get_delta(sha1, &commit->tree->object, lock);
-	} else if (obj->type == tree_type) {
-		if (push_verbosely)
-			fprintf(stderr, "walk %s\n", sha1_to_hex(obj->sha1));
-		add_request(obj->sha1, lock);
-		tree = (struct tree *)obj;
-		if (parse_tree(tree)) {
-			fprintf(stderr, "Error parsing tree %s\n",
-				sha1_to_hex(obj->sha1));
-			aborted = 1;
-			return;
+		if (obj->type == tree_type) {
+			p = process_tree((struct tree *)obj, p, NULL, name);
+			continue;
 		}
-		entry = tree->entries;
-		tree->entries = NULL;
-		while (entry) {
-			struct tree_entry_list *next = entry->next;
-			get_delta(sha1, entry->item.any, lock);
-			free(entry->name);
-			free(entry);
-			entry = next;
+		if (obj->type == blob_type) {
+			p = process_blob((struct blob *)obj, p, NULL, name);
+			continue;
 		}
-	} else if (obj->type == blob_type || obj->type == tag_type) {
-		add_request(obj->sha1, lock);
+		die("unknown pending object %s (%s)", sha1_to_hex(obj->sha1), name);
+	}
+
+	while (objects) {
+		if (!(objects->item->flags & UNINTERESTING))
+			add_request(objects->item, lock);
+		objects = objects->next;
 	}
 }
 
-static int update_remote(unsigned char *sha1, struct active_lock *lock)
+static int update_remote(unsigned char *sha1, struct remote_lock *lock)
 {
 	struct active_request_slot *slot;
 	char *out_data;
@@ -1218,22 +1468,146 @@ static int update_remote(unsigned char *
 	return 1;
 }
 
+static struct ref *local_refs, **local_tail;
+static struct ref *remote_refs, **remote_tail;
+
+static int one_local_ref(const char *refname, const unsigned char *sha1)
+{
+	struct ref *ref;
+	int len = strlen(refname) + 1;
+	ref = xcalloc(1, sizeof(*ref) + len);
+	memcpy(ref->new_sha1, sha1, 20);
+	memcpy(ref->name, refname, len);
+	*local_tail = ref;
+	local_tail = &ref->next;
+	return 0;
+}
+
+static void one_remote_ref(char *refname)
+{
+	struct ref *ref;
+	unsigned char remote_sha1[20];
+
+	if (fetch_ref(refname, remote_sha1) != 0) {
+		fprintf(stderr,
+			"Unable to fetch ref %s from %s\n",
+			refname, remote->url);
+		return;
+	}
+
+	int len = strlen(refname) + 1;
+	ref = xcalloc(1, sizeof(*ref) + len);
+	memcpy(ref->old_sha1, remote_sha1, 20);
+	memcpy(ref->name, refname, len);
+	*remote_tail = ref;
+	remote_tail = &ref->next;
+}
+
+static void get_local_heads(void)
+{
+	local_tail = &local_refs;
+	for_each_ref(one_local_ref);
+}
+
+static void get_dav_remote_heads(void)
+{
+	remote_tail = &remote_refs;
+	crawl_remote_refs("refs/");
+}
+
+static int is_zero_sha1(const unsigned char *sha1)
+{
+	int i;
+
+	for (i = 0; i < 20; i++) {
+		if (*sha1++)
+			return 0;
+	}
+	return 1;
+}
+
+static void unmark_and_free(struct commit_list *list, unsigned int mark)
+{
+	while (list) {
+		struct commit_list *temp = list;
+		temp->item->object.flags &= ~mark;
+		list = temp->next;
+		free(temp);
+	}
+}
+
+static int ref_newer(const unsigned char *new_sha1,
+		     const unsigned char *old_sha1)
+{
+	struct object *o;
+	struct commit *old, *new;
+	struct commit_list *list, *used;
+	int found = 0;
+
+	/* Both new and old must be commit-ish and new is descendant of
+	 * old.  Otherwise we require --force.
+	 */
+	o = deref_tag(parse_object(old_sha1), NULL, 0);
+	if (!o || o->type != commit_type)
+		return 0;
+	old = (struct commit *) o;
+
+	o = deref_tag(parse_object(new_sha1), NULL, 0);
+	if (!o || o->type != commit_type)
+		return 0;
+	new = (struct commit *) o;
+
+	if (parse_commit(new) < 0)
+		return 0;
+
+	used = list = NULL;
+	commit_list_insert(new, &list);
+	while (list) {
+		new = pop_most_recent_commit(&list, TMP_MARK);
+		commit_list_insert(new, &used);
+		if (new == old) {
+			found = 1;
+			break;
+		}
+	}
+	unmark_and_free(list, TMP_MARK);
+	unmark_and_free(used, TMP_MARK);
+	return found;
+}
+
+static void mark_edge_parents_uninteresting(struct commit *commit)
+{
+	struct commit_list *parents;
+
+	for (parents = commit->parents; parents; parents = parents->next) {
+		struct commit *parent = parents->item;
+		if (!(parent->object.flags & UNINTERESTING))
+			continue;
+		mark_tree_uninteresting(parent->tree);
+	}
+}
+
+static void mark_edges_uninteresting(struct commit_list *list)
+{
+	for ( ; list; list = list->next) {
+		struct commit *commit = list->item;
+
+		if (commit->object.flags & UNINTERESTING) {
+			mark_tree_uninteresting(commit->tree);
+			continue;
+		}
+		mark_edge_parents_uninteresting(commit);
+	}
+}
+
 int main(int argc, char **argv)
 {
 	struct transfer_request *request;
 	struct transfer_request *next_request;
 	int nr_refspec = 0;
 	char **refspec = NULL;
-	int do_remote_update;
-	int new_branch;
-	int force_this;
-	char *local_ref;
-	unsigned char local_sha1[20];
-	struct object *local_object = NULL;
-	char *remote_ref = NULL;
-	unsigned char remote_sha1[20];
-	struct active_lock *remote_lock;
-	char *remote_path = NULL;
+	struct remote_lock *ref_lock;
+	struct rev_info revs;
 	int rc = 0;
 	int i;
 
@@ -1242,6 +1616,7 @@ int main(int argc, char **argv)
 
 	remote = xmalloc(sizeof(*remote));
 	remote->url = NULL;
+	remote->path_len = 0;
 	remote->packs = NULL;
 
 	argv++;
@@ -1249,7 +1624,7 @@ int main(int argc, char **argv)
 		char *arg = *argv;
 
 		if (*arg == '-') {
-			if (!strcmp(arg, "--complete")) {
+			if (!strcmp(arg, "--all")) {
 				push_all = 1;
 				continue;
 			}
@@ -1265,6 +1640,12 @@ int main(int argc, char **argv)
 		}
 		if (!remote->url) {
 			remote->url = arg;
+			char *path = strstr(arg, "//");
+			if (path) {
+				path = index(path+2, '/');
+				if (path)
+					remote->path_len = strlen(path);
+			}
 			continue;
 		}
 		refspec = argv;
@@ -1275,7 +1656,7 @@ int main(int argc, char **argv)
 	if (!remote->url)
 		usage(http_push_usage);
 
-	memset(remote_dir_exists, 0, 256);
+	memset(remote_dir_exists, -1, 256);
 
 	http_init();
 
@@ -1293,92 +1674,113 @@ int main(int argc, char **argv)
 		goto cleanup;
 	}
 
-	/* Process each refspec */
-	for (i = 0; i < nr_refspec; i++) {
-		char *ep;
-		force_this = 0;
-		do_remote_update = 0;
-		new_branch = 0;
-		local_ref = refspec[i];
-		if (*local_ref == '+') {
-			force_this = 1;
-			local_ref++;
-		}
-		ep = strchr(local_ref, ':');
-		if (ep) {
-			remote_ref = ep + 1;
-			*ep = 0;
+	/* Get a list of all local and remote heads to validate refspecs */
+	get_local_heads();
+	fprintf(stderr, "Fetching remote heads...\n");
+	get_dav_remote_heads();
+
+	/* match them up */
+	if (!remote_tail)
+		remote_tail = &remote_refs;
+	if (match_refs(local_refs, remote_refs, &remote_tail,
+		       nr_refspec, refspec, push_all))
+		return -1;
+	if (!remote_refs) {
+		fprintf(stderr, "No refs in common and none specified; doing nothing.\n");
+		return 0;
+	}
+
+	int ret = 0;
+	int new_refs = 0;
+	struct ref *ref;
+	for (ref = remote_refs; ref; ref = ref->next) {
+		char old_hex[60], *new_hex;
+		if (!ref->peer_ref)
+			continue;
+		if (!memcmp(ref->old_sha1, ref->peer_ref->new_sha1, 20)) {
+			if (push_verbosely || 1)
+				fprintf(stderr, "'%s': up-to-date\n", ref->name);
+			continue;
 		}
-		else
-			remote_ref = local_ref;
+
+		if (!force_all &&
+		    !is_zero_sha1(ref->old_sha1) &&
+		    !ref->force) {
+			if (!has_sha1_file(ref->old_sha1) ||
+			    !ref_newer(ref->peer_ref->new_sha1,
+				       ref->old_sha1)) {
+				/* We do not have the remote ref, or
+				 * we know that the remote ref is not
+				 * an ancestor of what we are trying to
+				 * push.  Either way this can be losing
+				 * commits at the remote end and likely
+				 * we were not up to date to begin with.
+				 */
+				error("remote '%s' is not a strict "
+				      "subset of local ref '%s'. "
+				      "maybe you are not up-to-date and "
+				      "need to pull first?",
+				      ref->name,
+				      ref->peer_ref->name);
+				ret = -2;
+				continue;
+			}
+		}
+		memcpy(ref->new_sha1, ref->peer_ref->new_sha1, 20);
+		if (is_zero_sha1(ref->new_sha1)) {
+			error("cannot happen anymore");
+			ret = -3;
+			continue;
+		}
+		new_refs++;
+		strcpy(old_hex, sha1_to_hex(ref->old_sha1));
+		new_hex = sha1_to_hex(ref->new_sha1);
+
+		fprintf(stderr, "updating '%s'", ref->name);
+		if (strcmp(ref->name, ref->peer_ref->name))
+			fprintf(stderr, " using '%s'", ref->peer_ref->name);
+		fprintf(stderr, "\n  from %s\n  to   %s\n", old_hex, new_hex);
+
 
 		/* Lock remote branch ref */
-		if (remote_path)
-			free(remote_path);
-		remote_path = xmalloc(strlen(remote_ref) + 12);
-		sprintf(remote_path, "refs/heads/%s", remote_ref);
-		remote_lock = lock_remote(remote_path, LOCK_TIME);
-		if (remote_lock == NULL) {
+		ref_lock = lock_remote(ref->name, LOCK_TIME);
+		if (ref_lock == NULL) {
 			fprintf(stderr, "Unable to lock remote branch %s\n",
-				remote_ref);
+				ref->name);
 			rc = 1;
 			continue;
 		}
 
-		/* Resolve local and remote refs */
-		if (fetch_ref(remote_ref, remote_sha1) != 0) {
-			fprintf(stderr,
-				"Remote branch %s does not exist on %s\n",
-				remote_ref, remote->url);
-			new_branch = 1;
-		}
-		if (get_sha1(local_ref, local_sha1) != 0) {
-			fprintf(stderr, "Error resolving local branch %s\n",
-				local_ref);
-			rc = 1;
-			goto unlock;
-		}
-	
-		/* Find relationship between local and remote */
-		local_object = parse_object(local_sha1);
-		if (!local_object) {
-			fprintf(stderr, "Unable to parse local object %s\n",
-				sha1_to_hex(local_sha1));
-			rc = 1;
-			goto unlock;
-		} else if (new_branch) {
-			do_remote_update = 1;
-		} else {
-			if (!memcmp(local_sha1, remote_sha1, 20)) {
-				fprintf(stderr,
-					"* %s: same as branch '%s' of %s\n",
-					local_ref, remote_ref, remote->url);
-			} else if (is_ancestor(remote_sha1,
-					       (struct commit *)local_object)) {
-				fprintf(stderr,
-					"Remote %s will fast-forward to local %s\n",
-					remote_ref, local_ref);
-				do_remote_update = 1;
-			} else if (force_all || force_this) {
-				fprintf(stderr,
-					"* %s on %s does not fast forward to local branch '%s', overwriting\n",
-					remote_ref, remote->url, local_ref);
-				do_remote_update = 1;
-			} else {
-				fprintf(stderr,
-					"* %s on %s does not fast forward to local branch '%s'\n",
-					remote_ref, remote->url, local_ref);
-				rc = 1;
-				goto unlock;
-			}
+		/* Set up revision info for this refspec */
+		const char *commit_argv[3];
+		int commit_argc = 2;
+		char *new_sha1_hex = strdup(sha1_to_hex(ref->new_sha1));
+		char *old_sha1_hex = NULL;
+		commit_argv[1] = new_sha1_hex;
+		if (!push_all && !is_zero_sha1(ref->old_sha1)) {
+			old_sha1_hex = xmalloc(42);
+			sprintf(old_sha1_hex, "^%s",
+				sha1_to_hex(ref->old_sha1));
+			commit_argv[2] = old_sha1_hex;
+			commit_argc++;
+		}
+		revs.commits = NULL;
+		setup_revisions(commit_argc, commit_argv, &revs, NULL);
+		revs.tag_objects = 1;
+		revs.tree_objects = 1;
+		revs.blob_objects = 1;
+		free(new_sha1_hex);
+		if (old_sha1_hex) {
+			free(old_sha1_hex);
+			commit_argv[1] = NULL;
 		}
 
-		/* Generate and check list of required objects */
+		/* Generate a list of objects that need to be pushed */
 		pushing = 0;
-		if (do_remote_update || push_all)
-			fetch_indices();
-		get_delta(push_all ? NULL : remote_sha1,
-			  local_object, remote_lock);
+		prepare_revision_walk(&revs);
+		mark_edges_uninteresting(revs.commits);
+		fetch_indices();
+		get_delta(&revs, ref_lock);
 		finish_all_active_slots();
 
 		/* Push missing objects to remote, this would be a
@@ -1388,25 +1790,15 @@ int main(int argc, char **argv)
 		finish_all_active_slots();
 
 		/* Update the remote branch if all went well */
-		if (do_remote_update) {
-			if (!aborted && update_remote(local_sha1,
-						      remote_lock)) {
-				fprintf(stderr, "%s remote branch %s\n",
-					new_branch ? "Created" : "Updated",
-					remote_ref);
-			} else {
-				fprintf(stderr,
-					"Unable to %s remote branch %s\n",
-					new_branch ? "create" : "update",
-					remote_ref);
-				rc = 1;
-				goto unlock;
-			}
+		if (aborted || !update_remote(ref->new_sha1, ref_lock)) {
+			rc = 1;
+			goto unlock;
 		}
 
 	unlock:
-		unlock_remote(remote_lock);
-		free(remote_path);
+		if (!rc)
+			fprintf(stderr, "    done\n");
+		unlock_remote(ref_lock);
 	}
 
  cleanup:
-- 
1.2.4.gb477-dirty
