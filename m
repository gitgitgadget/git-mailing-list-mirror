From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 4/4] Refresh the remote lock if it is about to expire
Date: Fri, 4 Nov 2005 14:22:35 -0800
Message-ID: <20051104222235.GG3001@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 04 23:28:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY9xJ-0004Uy-K0
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 23:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbVKDWWg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 17:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbVKDWWg
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 17:22:36 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:35882 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751072AbVKDWWg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 17:22:36 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA4MMZDl017953
	for <git@vger.kernel.org>; Fri, 4 Nov 2005 14:22:35 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA4MMZOK017951
	for git@vger.kernel.org; Fri, 4 Nov 2005 14:22:35 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11171>

Refresh the remote lock if it is about to expire

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-push.c |  106 ++++++++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 79 insertions(+), 27 deletions(-)

applies-to: 678d5afb150b94bf4a516f852cd41f6920e8642b
197abe5895bea9924c8f01398d9fc73ec013cbd5
diff --git a/http-push.c b/http-push.c
index 85cd595..c10067c 100644
--- a/http-push.c
+++ b/http-push.c
@@ -40,6 +40,9 @@ static const char http_push_usage[] =
 #define PROPFIND_REQUEST "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<D:propfind xmlns:D=\"DAV:\">\n<D:prop xmlns:R=\"%s\">\n<D:supportedlock/>\n</D:prop>\n</D:propfind>"
 #define LOCK_REQUEST "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<D:lockinfo xmlns:D=\"DAV:\">\n<D:lockscope><D:exclusive/></D:lockscope>\n<D:locktype><D:write/></D:locktype>\n<D:owner>\n<D:href>mailto:%s</D:href>\n</D:owner>\n</D:lockinfo>"
 
+#define LOCK_TIME 600
+#define LOCK_REFRESH 30
+
 static int active_requests = 0;
 static int data_received;
 static int pushing = 0;
@@ -143,10 +146,12 @@ struct active_lock
 	int ctx_timeout;
 	int ctx_locktoken;
 	int ctx_locktoken_href;
+	char *url;
 	char *owner;
+	char *token;
 	time_t start_time;
 	long timeout;
-	char *token;
+	int refreshing;
 };
 
 struct lockprop
@@ -580,11 +585,65 @@ static void start_move(struct transfer_r
 	}
 }
 
+int refresh_lock(struct active_lock *lock)
+{
+	struct active_request_slot *slot;
+	char *if_header;
+	char timeout_header[25];
+	struct curl_slist *dav_headers = NULL;
+	int rc = 0;
+
+	lock->refreshing = 1;
+
+	if_header = xmalloc(strlen(lock->token) + 25);
+	sprintf(if_header, "If: (<opaquelocktoken:%s>)", lock->token);
+	sprintf(timeout_header, "Timeout: Second-%ld", lock->timeout);
+	dav_headers = curl_slist_append(dav_headers, if_header);
+	dav_headers = curl_slist_append(dav_headers, timeout_header);
+
+	slot = get_active_slot();
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, lock->url);
+	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_LOCK);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
+
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (slot->curl_result != CURLE_OK) {
+			fprintf(stderr, "Got HTTP error %ld\n", slot->http_code);
+		} else {
+			lock->start_time = time(NULL);
+			rc = 1;
+		}
+	}
+
+	lock->refreshing = 0;
+	curl_slist_free_all(dav_headers);
+	free(if_header);
+
+	return rc;
+}
+
 static void finish_request(struct transfer_request *request)
 {
+	time_t current_time = time(NULL);
+	int time_remaining;
+
 	request->curl_result =	request->slot->curl_result;
 	request->http_code = request->slot->http_code;
 	request->slot = NULL;
+
+	/* Refresh the lock if it is close to timing out */
+	time_remaining = request->lock->start_time + request->lock->timeout
+		- current_time;
+	if (time_remaining < LOCK_REFRESH && !request->lock->refreshing) {
+		if (!refresh_lock(request->lock)) {
+			fprintf(stderr, "Unable to refresh remote lock\n");
+			aborted = 1;
+		}
+	}
+
 	if (request->headers != NULL)
 		curl_slist_free_all(request->headers);
 	if (request->state == RUN_HEAD) {
@@ -1114,7 +1173,7 @@ end_lockprop_element(void *userData, con
 	}
 }
 
-struct active_lock *lock_remote(char *file, int timeout)
+struct active_lock *lock_remote(char *file, long timeout)
 {
 	struct active_request_slot *slot;
 	struct buffer out_buffer;
@@ -1175,8 +1234,9 @@ struct active_lock *lock_remote(char *fi
 	new_lock->owner = NULL;
 	new_lock->token = NULL;
 	new_lock->timeout = -1;
+	new_lock->refreshing = 0;
 
-	sprintf(timeout_header, "Timeout: Second-%d", timeout);
+	sprintf(timeout_header, "Timeout: Second-%ld", timeout);
 	dav_headers = curl_slist_append(dav_headers, timeout_header);
 	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
 
@@ -1211,7 +1271,6 @@ struct active_lock *lock_remote(char *fi
 		return NULL;
 	}
 
-	free(url);
 	free(out_data);
 
 	XML_SetUserData(parser, new_lock);
@@ -1223,6 +1282,7 @@ struct active_lock *lock_remote(char *fi
 	if (result != XML_STATUS_OK) {
 		fprintf(stderr, "%s", XML_ErrorString(
 				XML_GetErrorCode(parser)));
+		free(url);
 		free(new_lock);
 		return NULL;
 	}
@@ -1232,18 +1292,19 @@ struct active_lock *lock_remote(char *fi
 			free(new_lock->token);
 		if (new_lock->owner != NULL)
 			free(new_lock->owner);
+		free(url);
 		free(new_lock);
 		return NULL;
 	}
 
+	new_lock->url = url;
 	new_lock->start_time = time(NULL);
 	return new_lock;
 }
 
-int unlock_remote(char *file, struct active_lock *lock)
+int unlock_remote(struct active_lock *lock)
 {
 	struct active_request_slot *slot;
-	char *url;
 	char *lock_token_header;
 	struct curl_slist *dav_headers = NULL;
 	int rc = 0;
@@ -1251,13 +1312,11 @@ int unlock_remote(char *file, struct act
 	lock_token_header = xmalloc(strlen(lock->token) + 31);
 	sprintf(lock_token_header, "Lock-Token: <opaquelocktoken:%s>",
 		lock->token);
-	url = xmalloc(strlen(remote->url) + strlen(file) + 1);
-	sprintf(url, "%s%s", remote->url, file);
 	dav_headers = curl_slist_append(dav_headers, lock_token_header);
 
 	slot = get_active_slot();
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, lock->url);
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_UNLOCK);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
 
@@ -1274,7 +1333,12 @@ int unlock_remote(char *file, struct act
 
 	curl_slist_free_all(dav_headers);
 	free(lock_token_header);
-	free(url);
+
+	if (lock->owner != NULL)
+		free(lock->owner);
+	free(lock->url);
+	free(lock->token);
+	free(lock);
 
 	return rc;
 }
@@ -1423,20 +1487,15 @@ void get_delta(unsigned char *sha1, stru
 	}
 }
 
-int update_remote(char *remote_path, unsigned char *sha1,
-		  struct active_lock *lock)
+int update_remote(unsigned char *sha1, struct active_lock *lock)
 {
 	struct active_request_slot *slot;
-	char *url;
 	char *out_data;
 	char *if_header;
 	struct buffer out_buffer;
 	struct curl_slist *dav_headers = NULL;
 	int i;
 
-	url = xmalloc(strlen(remote->url) + strlen(remote_path) + 1);
-	sprintf(url, "%s%s", remote->url, remote_path);
-
 	if_header = xmalloc(strlen(lock->token) + 25);
 	sprintf(if_header, "If: (<opaquelocktoken:%s>)", lock->token);
 	dav_headers = curl_slist_append(dav_headers, if_header);
@@ -1460,13 +1519,12 @@ int update_remote(char *remote_path, uns
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
 	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_PUT, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, lock->url);
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		free(out_data);
 		free(if_header);
-		free(url);
 		if (slot->curl_result != CURLE_OK) {
 			fprintf(stderr,
 				"PUT error: curl result=%d, HTTP code=%ld\n",
@@ -1477,7 +1535,6 @@ int update_remote(char *remote_path, uns
 	} else {
 		free(out_data);
 		free(if_header);
-		free(url);
 		fprintf(stderr, "Unable to start PUT request\n");
 		return 0;
 	}
@@ -1629,7 +1686,7 @@ int main(int argc, char **argv)
 			free(remote_path);
 		remote_path = xmalloc(strlen(remote_ref) + 12);
 		sprintf(remote_path, "refs/heads/%s", remote_ref);
-		remote_lock = lock_remote(remote_path, 3600);
+		remote_lock = lock_remote(remote_path, LOCK_TIME);
 		if (remote_lock == NULL) {
 			fprintf(stderr, "Unable to lock remote branch %s\n",
 				remote_ref);
@@ -1701,8 +1758,7 @@ int main(int argc, char **argv)
 
 		/* Update the remote branch if all went well */
 		if (do_remote_update) {
-			if (!aborted && update_remote(remote_path,
-						      local_sha1,
+			if (!aborted && update_remote(local_sha1,
 						      remote_lock)) {
 				fprintf(stderr, "%s remote branch %s\n",
 					new_branch ? "Created" : "Updated",
@@ -1718,12 +1774,8 @@ int main(int argc, char **argv)
 		}
 
 	unlock:
-		unlock_remote(remote_path, remote_lock);
+		unlock_remote(remote_lock);
 		free(remote_path);
-		if (remote_lock->owner != NULL)
-			free(remote_lock->owner);
-		free(remote_lock->token);
-		free(remote_lock);
 	}
 
  cleanup:
---
0.99.9.GIT
