From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 3/4] Improve lock handling
Date: Fri, 4 Nov 2005 14:22:31 -0800
Message-ID: <20051104222231.GF3001@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 04 23:27:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY9xD-0004RO-D9
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 23:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVKDWWc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 17:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbVKDWWc
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 17:22:32 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:13355 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751071AbVKDWWb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 17:22:31 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA4MMVVE017944
	for <git@vger.kernel.org>; Fri, 4 Nov 2005 14:22:31 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA4MMV4n017942
	for git@vger.kernel.org; Fri, 4 Nov 2005 14:22:31 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11170>

Improve lock handling: parse the server response for the timeout, owner,
and lock token

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-push.c |  201 +++++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 147 insertions(+), 54 deletions(-)

applies-to: 99366e40c96e3fd0436287c601697f3166e8cf36
1b26b4528dc9e14f2be5d57154022249206fcc6f
diff --git a/http-push.c b/http-push.c
index 6a241aa..85cd595 100644
--- a/http-push.c
+++ b/http-push.c
@@ -55,7 +55,6 @@ static CURL *curl_default;
 static struct curl_slist *no_pragma_header;
 static struct curl_slist *default_headers;
 static char curl_errorstr[CURL_ERROR_SIZE];
-static char *lock_token = NULL;
 
 static int push_verbosely = 0;
 static int push_all = 0;
@@ -92,7 +91,7 @@ struct transfer_request
 	unsigned char sha1[20];
 	char *url;
 	char *dest;
-	char *lock_token;
+	struct active_lock *lock;
 	struct curl_slist *headers;
 	struct buffer buffer;
 	char filename[PATH_MAX];
@@ -136,6 +135,20 @@ static char *ssl_cainfo = NULL;
 static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
 
+struct active_lock
+{
+	int ctx_activelock;
+	int ctx_owner;
+	int ctx_owner_href;
+	int ctx_timeout;
+	int ctx_locktoken;
+	int ctx_locktoken_href;
+	char *owner;
+	time_t start_time;
+	long timeout;
+	char *token;
+};
+
 struct lockprop
 {
 	int supported_lock;
@@ -509,7 +522,7 @@ static void start_put(struct transfer_re
 	if (request->url != NULL)
 		free(request->url);
 	request->url = xmalloc(strlen(remote->url) + 
-			       strlen(request->lock_token) + 51);
+			       strlen(request->lock->token) + 51);
 	strcpy(request->url, remote->url);
 	posn = request->url + strlen(remote->url);
 	strcpy(posn, "objects/");
@@ -522,7 +535,7 @@ static void start_put(struct transfer_re
 	sprintf(request->dest, "Destination: %s", request->url);
 	posn += 38;
 	*(posn++) = '.';
-	strcpy(posn, request->lock_token);
+	strcpy(posn, request->lock->token);
 
 	slot = get_active_slot();
 	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &request->buffer);
@@ -724,7 +737,7 @@ void process_waiting_requests(void)
 		}
 }
 
-void add_request(unsigned char *sha1, char *lock_token)
+void add_request(unsigned char *sha1, struct active_lock *lock)
 {
 	struct transfer_request *request = request_queue_head;
 	struct packed_git *target;
@@ -741,7 +754,7 @@ void add_request(unsigned char *sha1, ch
 	request = xmalloc(sizeof(*request));
 	memcpy(request->sha1, sha1, 20);
 	request->url = NULL;
-	request->lock_token = lock_token;
+	request->lock = lock;
 	request->headers = NULL;
 	request->state = NEED_CHECK;
 	request->next = request_queue_head;
@@ -999,6 +1012,68 @@ int fetch_ref(char *ref, unsigned char *
 }
 
 static void
+start_activelock_element(void *userData, const char *name, const char **atts)
+{
+	struct active_lock *lock = (struct active_lock *)userData;
+
+	if (lock->ctx_activelock && !strcmp(name, "D:timeout"))
+		lock->ctx_timeout = 1;
+	else if (lock->ctx_owner && strstr(name, "href"))
+		lock->ctx_owner_href = 1;
+	else if (lock->ctx_activelock && strstr(name, "owner"))
+		lock->ctx_owner = 1;
+	else if (lock->ctx_locktoken && !strcmp(name, "D:href"))
+		lock->ctx_locktoken_href = 1;
+	else if (lock->ctx_activelock && !strcmp(name, "D:locktoken"))
+		lock->ctx_locktoken = 1;
+	else if (!strcmp(name, "D:activelock"))
+		lock->ctx_activelock = 1;
+}
+
+static void
+end_activelock_element(void *userData, const char *name)
+{
+	struct active_lock *lock = (struct active_lock *)userData;
+
+	if (lock->ctx_timeout && !strcmp(name, "D:timeout")) {
+		lock->ctx_timeout = 0;
+	} else if (lock->ctx_owner_href && strstr(name, "href")) {
+		lock->ctx_owner_href = 0;
+	} else if (lock->ctx_owner && strstr(name, "owner")) {
+		lock->ctx_owner = 0;
+	} else if (lock->ctx_locktoken_href && !strcmp(name, "D:href")) {
+		lock->ctx_locktoken_href = 0;
+	} else if (lock->ctx_locktoken && !strcmp(name, "D:locktoken")) {
+		lock->ctx_locktoken = 0;
+	} else if (lock->ctx_activelock && !strcmp(name, "D:activelock")) {
+		lock->ctx_activelock = 0;
+	}
+}
+
+static void
+activelock_cdata(void *userData, const XML_Char *s, int len)
+{
+	struct active_lock *lock = (struct active_lock *)userData;
+	char *this = malloc(len+1);
+	strncpy(this, s, len);
+
+	if (lock->ctx_owner_href) {
+		lock->owner = malloc(len+1);
+		strcpy(lock->owner, this);
+	} else if (lock->ctx_locktoken_href) {
+		if (!strncmp(this, "opaquelocktoken:", 16)) {
+			lock->token = malloc(len-15);
+			strcpy(lock->token, this+16);
+		}
+	} else if (lock->ctx_timeout) {
+		if (!strncmp(this, "Second-", 7))
+			lock->timeout = strtol(this+7, NULL, 10);
+	}
+
+	free(this);
+}
+
+static void
 start_lockprop_element(void *userData, const char *name, const char **atts)
 {
 	struct lockprop *prop = (struct lockprop *)userData;
@@ -1039,40 +1114,21 @@ end_lockprop_element(void *userData, con
 	}
 }
 
-size_t process_lock_header( void *ptr, size_t size, size_t nmemb, void *stream)
-{
-	size_t header_size = size*nmemb;
-	char *start;
-	char *end;
-
-	if (!strncmp(ptr, "Lock-Token: <opaquelocktoken:", 29)) {
-		start = ptr + 29;
-		for (end = ptr + header_size;
-		     *(end - 1) == '\r' || *(end - 1) == '\n' || *(end - 1) == '>';
-		     end--) {}
-		if (end > start) {
-			lock_token = xmalloc(end - start + 1);
-			memcpy(lock_token, start, end - start);
-			lock_token[end - start] = 0;
-		}
-	}
-
-	return header_size;
-}
-
-char *lock_remote(char *file, int timeout)
+struct active_lock *lock_remote(char *file, int timeout)
 {
 	struct active_request_slot *slot;
 	struct buffer out_buffer;
+	struct buffer in_buffer;
 	char *out_data;
+	char *in_data;
 	char *url;
 	char *ep;
 	char timeout_header[25];
+	struct active_lock *new_lock;
+	XML_Parser parser = XML_ParserCreate(NULL);
+	enum XML_Status result;
 	struct curl_slist *dav_headers = NULL;
 
-	if (lock_token != NULL)
-		free(lock_token);
-
 	url = xmalloc(strlen(remote->url) + strlen(file) + 1);
 	sprintf(url, "%s%s", remote->url, file);
 
@@ -1110,6 +1166,16 @@ char *lock_remote(char *file, int timeou
 	out_buffer.posn = 0;
 	out_buffer.buffer = out_data;
 
+	in_buffer.size = 4096;
+	in_data = xmalloc(in_buffer.size);
+	in_buffer.posn = 0;
+	in_buffer.buffer = in_data;
+
+	new_lock = xmalloc(sizeof(*new_lock));
+	new_lock->owner = NULL;
+	new_lock->token = NULL;
+	new_lock->timeout = -1;
+
 	sprintf(timeout_header, "Timeout: Second-%d", timeout);
 	dav_headers = curl_slist_append(dav_headers, timeout_header);
 	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
@@ -1118,9 +1184,9 @@ char *lock_remote(char *file, int timeou
 	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.size);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
-	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION,
-		process_lock_header);
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
+			 fwrite_buffer_dynamic);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_LOCK);
@@ -1130,13 +1196,17 @@ char *lock_remote(char *file, int timeou
 		run_active_slot(slot);
 		if (slot->curl_result != CURLE_OK) {
 			fprintf(stderr, "Got HTTP error %ld\n", slot->http_code);
+			free(new_lock);
 			free(url);
 			free(out_data);
+			free(in_data);
 			return NULL;
 		}
 	} else {
+		free(new_lock);
 		free(url);
 		free(out_data);
+		free(in_data);
 		fprintf(stderr, "Unable to start request\n");
 		return NULL;
 	}
@@ -1144,10 +1214,33 @@ char *lock_remote(char *file, int timeou
 	free(url);
 	free(out_data);
 
-	return strdup(lock_token);
+	XML_SetUserData(parser, new_lock);
+	XML_SetElementHandler(parser, start_activelock_element,
+				      end_activelock_element);
+	XML_SetCharacterDataHandler(parser, activelock_cdata);
+	result = XML_Parse(parser, in_buffer.buffer, in_buffer.posn, 1);
+	free(in_data);
+	if (result != XML_STATUS_OK) {
+		fprintf(stderr, "%s", XML_ErrorString(
+				XML_GetErrorCode(parser)));
+		free(new_lock);
+		return NULL;
+	}
+
+	if (new_lock->token == NULL || new_lock->timeout <= 0) {
+		if (new_lock->token != NULL)
+			free(new_lock->token);
+		if (new_lock->owner != NULL)
+			free(new_lock->owner);
+		free(new_lock);
+		return NULL;
+	}
+
+	new_lock->start_time = time(NULL);
+	return new_lock;
 }
 
-int unlock_remote(char *file, char *lock_token)
+int unlock_remote(char *file, struct active_lock *lock)
 {
 	struct active_request_slot *slot;
 	char *url;
@@ -1155,14 +1248,9 @@ int unlock_remote(char *file, char *lock
 	struct curl_slist *dav_headers = NULL;
 	int rc = 0;
 
-	if (lock_token == NULL) {
-		fprintf(stderr, "Unable to unlock, no lock token");
-		return 0;
-	}
-
-	lock_token_header = xmalloc(strlen(lock_token) + 31);
+	lock_token_header = xmalloc(strlen(lock->token) + 31);
 	sprintf(lock_token_header, "Lock-Token: <opaquelocktoken:%s>",
-		lock_token);
+		lock->token);
 	url = xmalloc(strlen(remote->url) + strlen(file) + 1);
 	sprintf(url, "%s%s", remote->url, file);
 	dav_headers = curl_slist_append(dav_headers, lock_token_header);
@@ -1278,7 +1366,8 @@ int is_ancestor(unsigned char *sha1, str
 	return 0;
 }
 
-void get_delta(unsigned char *sha1, struct object *obj, char *lock_token)
+void get_delta(unsigned char *sha1, struct object *obj,
+	       struct active_lock *lock)
 {
 	struct commit *commit;
 	struct commit_list *parents;
@@ -1294,7 +1383,7 @@ void get_delta(unsigned char *sha1, stru
 	if (obj->type == commit_type) {
 		if (push_verbosely)
 			fprintf(stderr, "walk %s\n", sha1_to_hex(obj->sha1));
-		add_request(obj->sha1, lock_token);
+		add_request(obj->sha1, lock);
 		commit = (struct commit *)obj;
 		if (parse_commit(commit)) {
 			fprintf(stderr, "Error parsing commit %s\n",
@@ -1307,12 +1396,12 @@ void get_delta(unsigned char *sha1, stru
 			if (sha1 == NULL ||
 			    memcmp(sha1, parents->item->object.sha1, 20))
 				get_delta(sha1, &parents->item->object,
-					  lock_token);
-		get_delta(sha1, &commit->tree->object, lock_token);
+					  lock);
+		get_delta(sha1, &commit->tree->object, lock);
 	} else if (obj->type == tree_type) {
 		if (push_verbosely)
 			fprintf(stderr, "walk %s\n", sha1_to_hex(obj->sha1));
-		add_request(obj->sha1, lock_token);
+		add_request(obj->sha1, lock);
 		tree = (struct tree *)obj;
 		if (parse_tree(tree)) {
 			fprintf(stderr, "Error parsing tree %s\n",
@@ -1324,17 +1413,18 @@ void get_delta(unsigned char *sha1, stru
 		tree->entries = NULL;
 		while (entry) {
 			struct tree_entry_list *next = entry->next;
-			get_delta(sha1, entry->item.any, lock_token);
+			get_delta(sha1, entry->item.any, lock);
 			free(entry->name);
 			free(entry);
 			entry = next;
 		}
 	} else if (obj->type == blob_type || obj->type == tag_type) {
-		add_request(obj->sha1, lock_token);
+		add_request(obj->sha1, lock);
 	}
 }
 
-int update_remote(char *remote_path, unsigned char *sha1, char *lock_token)
+int update_remote(char *remote_path, unsigned char *sha1,
+		  struct active_lock *lock)
 {
 	struct active_request_slot *slot;
 	char *url;
@@ -1347,8 +1437,8 @@ int update_remote(char *remote_path, uns
 	url = xmalloc(strlen(remote->url) + strlen(remote_path) + 1);
 	sprintf(url, "%s%s", remote->url, remote_path);
 
-	if_header = xmalloc(strlen(lock_token) + 25);
-	sprintf(if_header, "If: (<opaquelocktoken:%s>)", lock_token);
+	if_header = xmalloc(strlen(lock->token) + 25);
+	sprintf(if_header, "If: (<opaquelocktoken:%s>)", lock->token);
 	dav_headers = curl_slist_append(dav_headers, if_header);
 
 	out_buffer.size = 41;
@@ -1411,7 +1501,7 @@ int main(int argc, char **argv)
 	struct object *local_object = NULL;
 	char *remote_ref = NULL;
 	unsigned char remote_sha1[20];
-	char *remote_lock = NULL;
+	struct active_lock *remote_lock;
 	char *remote_path = NULL;
 	char *low_speed_limit;
 	char *low_speed_time;
@@ -1630,6 +1720,9 @@ int main(int argc, char **argv)
 	unlock:
 		unlock_remote(remote_path, remote_lock);
 		free(remote_path);
+		if (remote_lock->owner != NULL)
+			free(remote_lock->owner);
+		free(remote_lock->token);
 		free(remote_lock);
 	}
 
---
0.99.9.GIT
