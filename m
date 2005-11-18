From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 1/5] Isolate shared HTTP request functionality
Date: Fri, 18 Nov 2005 11:02:58 -0800
Message-ID: <20051118190258.GF3968@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 18 20:03:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdBVu-0006bS-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 20:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVKRTDA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 14:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVKRTDA
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 14:03:00 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:1876 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750759AbVKRTC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 14:02:58 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jAIJ2we2026711
	for <git@vger.kernel.org>; Fri, 18 Nov 2005 11:02:58 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jAIJ2w6S026709
	for git@vger.kernel.org; Fri, 18 Nov 2005 11:02:58 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12246>

Move shared HTTP request functionality out of http-fetch and http-push,
and replace the two fwrite_buffer/fwrite_buffer_dynamic functions with
one fwrite_buffer function that does dynamic buffering.  Use slot
callbacks to process responses to fetch object transfer requests and
push transfer requests, and put all of http-push into an #ifdef check
for curl multi support.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 Makefile     |    3 
 http-fetch.c |  586 ++++++----------------------------------------------------
 http-push.c  |  484 ++++--------------------------------------------
 http.c       |  443 ++++++++++++++++++++++++++++++++++++++++++++
 http.h       |   95 +++++++++
 5 files changed, 635 insertions(+), 976 deletions(-)
 create mode 100644 http.c
 create mode 100644 http.h

applies-to: ae209db4abcd6d0c83ac92c23bb9b16ffd5bcf7e
4e68fe30c4999c9b1ad40ab562df61d9c267b8a2
diff --git a/Makefile b/Makefile
index 3bdd059..59c9a44 100644
--- a/Makefile
+++ b/Makefile
@@ -383,7 +383,8 @@ $(SIMPLE_PROGRAMS) : git-%$X : %.o
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIB_FILE) $(SIMPLE_LIB)
 
-git-http-fetch$X: fetch.o
+git-http-fetch$X: fetch.o http.o
+git-http-push$X: http.o
 git-local-fetch$X: fetch.o
 git-ssh-fetch$X: rsh.o fetch.o
 git-ssh-upload$X: rsh.o
diff --git a/http-fetch.c b/http-fetch.c
index 21cc1b9..6a9eaf3 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -2,44 +2,14 @@
 #include "commit.h"
 #include "pack.h"
 #include "fetch.h"
-
-#include <curl/curl.h>
-#include <curl/easy.h>
-
-#if LIBCURL_VERSION_NUM >= 0x070908
-#define USE_CURL_MULTI
-#define DEFAULT_MAX_REQUESTS 5
-#endif
-
-#if LIBCURL_VERSION_NUM < 0x070704
-#define curl_global_cleanup() do { /* nothing */ } while(0)
-#endif
-#if LIBCURL_VERSION_NUM < 0x070800
-#define curl_global_init(a) do { /* nothing */ } while(0)
-#endif
-
-#if LIBCURL_VERSION_NUM < 0x070c04
-#define NO_CURL_EASY_DUPHANDLE
-#endif
+#include "http.h"
 
 #define PREV_BUF_SIZE 4096
 #define RANGE_HEADER_SIZE 30
 
 static int got_alternates = -1;
-static int active_requests = 0;
-static int data_received;
 
-#ifdef USE_CURL_MULTI
-static int max_requests = -1;
-static CURLM *curlm;
-#endif
-#ifndef NO_CURL_EASY_DUPHANDLE
-static CURL *curl_default;
-#endif
-static struct curl_slist *pragma_header;
 static struct curl_slist *no_pragma_header;
-static struct curl_slist *no_range_header;
-static char curl_errorstr[CURL_ERROR_SIZE];
 
 struct alt_base
 {
@@ -79,19 +49,6 @@ struct transfer_request
 	struct transfer_request *next;
 };
 
-struct active_request_slot
-{
-	CURL *curl;
-	FILE *local;
-	int in_use;
-	int done;
-	CURLcode curl_result;
-	long http_code;
-	void *callback_data;
-	void (*callback_func)(void *data);
-	struct active_request_slot *next;
-};
-
 struct alt_request {
 	char *base;
 	char *url;
@@ -101,119 +58,6 @@ struct alt_request {
 };
 
 static struct transfer_request *request_queue_head = NULL;
-static struct active_request_slot *active_queue_head = NULL;
-
-static int curl_ssl_verify = -1;
-static char *ssl_cert = NULL;
-#if LIBCURL_VERSION_NUM >= 0x070902
-static char *ssl_key = NULL;
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070908
-static char *ssl_capath = NULL;
-#endif
-static char *ssl_cainfo = NULL;
-static long curl_low_speed_limit = -1;
-static long curl_low_speed_time = -1;
-
-struct buffer
-{
-        size_t posn;
-        size_t size;
-        void *buffer;
-};
-
-static int http_options(const char *var, const char *value)
-{
-	if (!strcmp("http.sslverify", var)) {
-		if (curl_ssl_verify == -1) {
-			curl_ssl_verify = git_config_bool(var, value);
-		}
-		return 0;
-	}
-
-	if (!strcmp("http.sslcert", var)) {
-		if (ssl_cert == NULL) {
-			ssl_cert = xmalloc(strlen(value)+1);
-			strcpy(ssl_cert, value);
-		}
-		return 0;
-	}
-#if LIBCURL_VERSION_NUM >= 0x070902
-	if (!strcmp("http.sslkey", var)) {
-		if (ssl_key == NULL) {
-			ssl_key = xmalloc(strlen(value)+1);
-			strcpy(ssl_key, value);
-		}
-		return 0;
-	}
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070908
-	if (!strcmp("http.sslcapath", var)) {
-		if (ssl_capath == NULL) {
-			ssl_capath = xmalloc(strlen(value)+1);
-			strcpy(ssl_capath, value);
-		}
-		return 0;
-	}
-#endif
-	if (!strcmp("http.sslcainfo", var)) {
-		if (ssl_cainfo == NULL) {
-			ssl_cainfo = xmalloc(strlen(value)+1);
-			strcpy(ssl_cainfo, value);
-		}
-		return 0;
-	}
-
-#ifdef USE_CURL_MULTI	
-	if (!strcmp("http.maxrequests", var)) {
-		if (max_requests == -1)
-			max_requests = git_config_int(var, value);
-		return 0;
-	}
-#endif
-
-	if (!strcmp("http.lowspeedlimit", var)) {
-		if (curl_low_speed_limit == -1)
-			curl_low_speed_limit = (long)git_config_int(var, value);
-		return 0;
-	}
-	if (!strcmp("http.lowspeedtime", var)) {
-		if (curl_low_speed_time == -1)
-			curl_low_speed_time = (long)git_config_int(var, value);
-		return 0;
-	}
-
-	/* Fall back on the default ones */
-	return git_default_config(var, value);
-}
-
-static size_t fwrite_buffer(void *ptr, size_t eltsize, size_t nmemb,
-                            struct buffer *buffer)
-{
-        size_t size = eltsize * nmemb;
-        if (size > buffer->size - buffer->posn)
-                size = buffer->size - buffer->posn;
-        memcpy(buffer->buffer + buffer->posn, ptr, size);
-        buffer->posn += size;
-	data_received++;
-        return size;
-}
-
-static size_t fwrite_buffer_dynamic(const void *ptr, size_t eltsize,
-				    size_t nmemb, struct buffer *buffer)
-{
-	size_t size = eltsize * nmemb;
-	if (size > buffer->size - buffer->posn) {
-		buffer->size = buffer->size * 3 / 2;
-		if (buffer->size < buffer->posn + size)
-			buffer->size = buffer->posn + size;
-		buffer->buffer = xrealloc(buffer->buffer, buffer->size);
-	}
-	memcpy(buffer->buffer + buffer->posn, ptr, size);
-	buffer->posn += size;
-	data_received++;
-	return size;
-}
 
 static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 			       void *data)
@@ -243,168 +87,9 @@ static size_t fwrite_sha1_file(void *ptr
 	return size;
 }
 
-#ifdef USE_CURL_MULTI
-static void process_curl_messages(void);
-static void process_request_queue(void);
-#endif
 static void fetch_alternates(char *base);
 
-static CURL* get_curl_handle(void)
-{
-	CURL* result = curl_easy_init();
-
-	curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, curl_ssl_verify);
-#if LIBCURL_VERSION_NUM >= 0x070907
-	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
-#endif
-
-	if (ssl_cert != NULL)
-		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
-#if LIBCURL_VERSION_NUM >= 0x070902
-	if (ssl_key != NULL)
-		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070908
-	if (ssl_capath != NULL)
-		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
-#endif
-	if (ssl_cainfo != NULL)
-		curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
-	curl_easy_setopt(result, CURLOPT_FAILONERROR, 1);
-
-	if (curl_low_speed_limit > 0 && curl_low_speed_time > 0) {
-		curl_easy_setopt(result, CURLOPT_LOW_SPEED_LIMIT,
-				 curl_low_speed_limit);
-		curl_easy_setopt(result, CURLOPT_LOW_SPEED_TIME,
-				 curl_low_speed_time);
-	}
-
-	curl_easy_setopt(result, CURLOPT_FOLLOWLOCATION, 1);
-
-	return result;
-}
-
-static struct active_request_slot *get_active_slot(void)
-{
-	struct active_request_slot *slot = active_queue_head;
-	struct active_request_slot *newslot;
-
-#ifdef USE_CURL_MULTI
-	int num_transfers;
-
-	/* Wait for a slot to open up if the queue is full */
-	while (active_requests >= max_requests) {
-		curl_multi_perform(curlm, &num_transfers);
-		if (num_transfers < active_requests) {
-			process_curl_messages();
-		}
-	}
-#endif
-
-	while (slot != NULL && slot->in_use) {
-		slot = slot->next;
-	}
-	if (slot == NULL) {
-		newslot = xmalloc(sizeof(*newslot));
-		newslot->curl = NULL;
-		newslot->in_use = 0;
-		newslot->next = NULL;
-
-		slot = active_queue_head;
-		if (slot == NULL) {
-			active_queue_head = newslot;
-		} else {
-			while (slot->next != NULL) {
-				slot = slot->next;
-			}
-			slot->next = newslot;
-		}
-		slot = newslot;
-	}
-
-	if (slot->curl == NULL) {
-#ifdef NO_CURL_EASY_DUPHANDLE
-		slot->curl = get_curl_handle();
-#else
-		slot->curl = curl_easy_duphandle(curl_default);
-#endif
-	}
-
-	active_requests++;
-	slot->in_use = 1;
-	slot->done = 0;
-	slot->local = NULL;
-	slot->callback_data = NULL;
-	slot->callback_func = NULL;
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, pragma_header);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_range_header);
-	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, curl_errorstr);
-
-	return slot;
-}
-
-static int start_active_slot(struct active_request_slot *slot)
-{
-#ifdef USE_CURL_MULTI
-	CURLMcode curlm_result = curl_multi_add_handle(curlm, slot->curl);
-
-	if (curlm_result != CURLM_OK &&
-	    curlm_result != CURLM_CALL_MULTI_PERFORM) {
-		active_requests--;
-		slot->in_use = 0;
-		return 0;
-	}
-#endif
-	return 1;
-}
-
-static void run_active_slot(struct active_request_slot *slot)
-{
-#ifdef USE_CURL_MULTI
-	int num_transfers;
-	long last_pos = 0;
-	long current_pos;
-	fd_set readfds;
-	fd_set writefds;
-	fd_set excfds;
-	int max_fd;
-	struct timeval select_timeout;
-	CURLMcode curlm_result;
-
-	while (!slot->done) {
-		data_received = 0;
-		do {
-			curlm_result = curl_multi_perform(curlm,
-							  &num_transfers);
-		} while (curlm_result == CURLM_CALL_MULTI_PERFORM);
-		if (num_transfers < active_requests) {
-			process_curl_messages();
-			process_request_queue();
-		}
-
-		if (!data_received && slot->local != NULL) {
-			current_pos = ftell(slot->local);
-			if (current_pos > last_pos)
-				data_received++;
-			last_pos = current_pos;
-		}
-
-		if (!slot->done && !data_received) {
-			max_fd = 0;
-			FD_ZERO(&readfds);
-			FD_ZERO(&writefds);
-			FD_ZERO(&excfds);
-			select_timeout.tv_sec = 0;
-			select_timeout.tv_usec = 50000;
-			select(max_fd, &readfds, &writefds,
-			       &excfds, &select_timeout);
-		}
-	}
-#else
-	slot->curl_result = curl_easy_perform(slot->curl);
-	active_requests--;
-#endif
-}
+static void process_object_response(void *callback_data);
 
 static void start_request(struct transfer_request *request)
 {
@@ -503,6 +188,10 @@ static void start_request(struct transfe
 	}
 
 	slot = get_active_slot();
+	slot->callback_func = process_object_response;
+	slot->callback_data = request;
+	request->slot = slot;
+
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, request);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, request->errorstr);
@@ -523,15 +212,13 @@ static void start_request(struct transfe
 	}
 
 	/* Try to get the request started, abort the request on error */
+	request->state = ACTIVE;
 	if (!start_active_slot(slot)) {
 		request->state = ABORTED;
+		request->slot = NULL;
 		close(request->local); request->local = -1;
 		free(request->url);
-		return;
 	}
-	
-	request->slot = slot;
-	request->state = ACTIVE;
 }
 
 static void finish_request(struct transfer_request *request)
@@ -567,6 +254,32 @@ static void finish_request(struct transf
 		pull_say("got %s\n", sha1_to_hex(request->sha1));
 }
 
+static void process_object_response(void *callback_data)
+{
+	struct transfer_request *request =
+		(struct transfer_request *)callback_data;
+
+	request->curl_result = request->slot->curl_result;
+	request->http_code = request->slot->http_code;
+	request->slot = NULL;
+	request->state = COMPLETE;
+
+	/* Use alternates if necessary */
+	if (request->http_code == 404) {
+		fetch_alternates(alt->base);
+		if (request->repo->next != NULL) {
+			request->repo =
+				request->repo->next;
+			close(request->local);
+			request->local = -1;
+			start_request(request);
+			return;
+		}
+	}
+
+	finish_request(request);
+}
+
 static void release_request(struct transfer_request *request)
 {
 	struct transfer_request *entry = request_queue_head;
@@ -587,73 +300,7 @@ static void release_request(struct trans
 }
 
 #ifdef USE_CURL_MULTI
-static void process_curl_messages(void)
-{
-	int num_messages;
-	struct active_request_slot *slot;
-	struct transfer_request *request = NULL;
-	CURLMsg *curl_message = curl_multi_info_read(curlm, &num_messages);
-
-	while (curl_message != NULL) {
-		if (curl_message->msg == CURLMSG_DONE) {
-			int curl_result = curl_message->data.result;
-			slot = active_queue_head;
-			while (slot != NULL &&
-			       slot->curl != curl_message->easy_handle)
-				slot = slot->next;
-			if (slot != NULL) {
-				curl_multi_remove_handle(curlm, slot->curl);
-				active_requests--;
-				slot->done = 1;
-				slot->in_use = 0;
-				slot->curl_result = curl_result;
-				curl_easy_getinfo(slot->curl,
-						  CURLINFO_HTTP_CODE,
-						  &slot->http_code);
-				request = request_queue_head;
-				while (request != NULL &&
-				       request->slot != slot)
-					request = request->next;
-			} else {
-				fprintf(stderr, "Received DONE message for unknown request!\n");
-			}
-
-			/* Process slot callback if appropriate */
-			if (slot->callback_func != NULL) {
-				slot->callback_func(slot->callback_data);
-			}
-
-			if (request != NULL) {
-				request->curl_result = curl_result;
-				request->http_code = slot->http_code;
-				request->slot = NULL;
-				request->state = COMPLETE;
-
-				/* Use alternates if necessary */
-				if (request->http_code == 404) {
-					fetch_alternates(alt->base);
-					if (request->repo->next != NULL) {
-						request->repo =
-							request->repo->next;
-						close(request->local);
-							request->local = -1;
-						start_request(request);
-					} else {
-						finish_request(request);
-					}
-				} else {
-					finish_request(request);
-				}
-			}
-		} else {
-			fprintf(stderr, "Unknown CURL message received: %d\n",
-				(int)curl_message->msg);
-		}
-		curl_message = curl_multi_info_read(curlm, &num_messages);
-	}
-}
-
-static void process_request_queue(void)
+void fill_active_slots(void)
 {
 	struct transfer_request *request = request_queue_head;
 	struct active_request_slot *slot = active_queue_head;
@@ -706,9 +353,10 @@ void prefetch(unsigned char *sha1)
 		}
 		tail->next = newreq;
 	}
+
 #ifdef USE_CURL_MULTI
-	process_request_queue();
-	process_curl_messages();
+	fill_active_slots();
+	step_active_slots();
 #endif
 }
 
@@ -815,12 +463,11 @@ static void process_alternates(void *cal
 					 alt_req->url);
 			active_requests++;
 			slot->in_use = 1;
-			slot->done = 0;
 			if (start_active_slot(slot)) {
 				return;
 			} else {
 				got_alternates = -1;
-				slot->done = 1;
+				slot->in_use = 0;
 				return;
 			}
 		}
@@ -831,7 +478,7 @@ static void process_alternates(void *cal
 		}
 	}
 
-	fwrite_buffer_dynamic(&null_byte, 1, 1, alt_req->buffer);
+	fwrite_buffer(&null_byte, 1, 1, alt_req->buffer);
 	alt_req->buffer->posn--;
 	data = alt_req->buffer->buffer;
 
@@ -902,16 +549,15 @@ static void fetch_alternates(char *base)
 	char *data;
 	struct active_request_slot *slot;
 	static struct alt_request alt_req;
-	int num_transfers;
 
 	/* If another request has already started fetching alternates,
 	   wait for them to arrive and return to processing this request's
 	   curl message */
+#ifdef USE_CURL_MULTI
 	while (got_alternates == 0) {
-		curl_multi_perform(curlm, &num_transfers);
-		process_curl_messages();
-		process_request_queue();
+		step_active_slots();
 	}
+#endif
 
 	/* Nothing to do if they've already been fetched */
 	if (got_alternates == 1)
@@ -938,8 +584,7 @@ static void fetch_alternates(char *base)
 	slot->callback_data = &alt_req;
 
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
-			 fwrite_buffer_dynamic);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 
 	alt_req.base = base;
@@ -983,8 +628,7 @@ static int fetch_indices(struct alt_base
 
 	slot = get_active_slot();
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
-			 fwrite_buffer_dynamic);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
 	if (start_active_slot(slot)) {
@@ -1115,7 +759,7 @@ static int fetch_pack(struct alt_base *r
 static int fetch_object(struct alt_base *repo, unsigned char *sha1)
 {
 	char *hex = sha1_to_hex(sha1);
-	int ret;
+	int ret = 0;
 	struct transfer_request *request = request_queue_head;
 
 	while (request != NULL && memcmp(request->sha1, sha1, 20))
@@ -1130,12 +774,7 @@ static int fetch_object(struct alt_base 
 
 #ifdef USE_CURL_MULTI
 	while (request->state == WAITING) {
-		int num_transfers;
-		curl_multi_perform(curlm, &num_transfers);
-		if (num_transfers < active_requests) {
-			process_curl_messages();
-			process_request_queue();
-		}
+		step_active_slots();
 	}
 #else
 	start_request(request);
@@ -1143,66 +782,33 @@ static int fetch_object(struct alt_base 
 
 	while (request->state == ACTIVE) {
 		run_active_slot(request->slot);
-#ifndef USE_CURL_MULTI
-		request->curl_result = request->slot->curl_result;
-		request->http_code = request->slot->http_code;
-		request->slot = NULL;
-
-		/* Use alternates if necessary */
-		if (request->http_code == 404) {
-			fetch_alternates(alt->base);
-			if (request->repo->next != NULL) {
-				request->repo = request->repo->next;
-				close(request->local); request->local = -1;
-				start_request(request);
-			}
-		} else {
-			finish_request(request);
-			request->state = COMPLETE;
-		}
-#endif
 	}
 	if (request->local != -1) {
 		close(request->local); request->local = -1;
 	}
 
 	if (request->state == ABORTED) {
-		release_request(request);
-		return error("Request for %s aborted", hex);
-	}
-
-	if (request->curl_result != CURLE_OK && request->http_code != 416) {
+		ret = error("Request for %s aborted", hex);
+	} else if (request->curl_result != CURLE_OK &&
+		   request->http_code != 416) {
 		if (request->http_code == 404)
 			ret = -1; /* Be silent, it is probably in a pack. */
 		else
 			ret = error("%s (curl_result = %d, http_code = %ld, sha1 = %s)",
 				    request->errorstr, request->curl_result,
 				    request->http_code, hex);
-		release_request(request);
-		return ret;
-	}
-
-	if (request->zret != Z_STREAM_END) {
+	} else if (request->zret != Z_STREAM_END) {
 		ret = error("File %s (%s) corrupt\n", hex, request->url);
-		release_request(request);
-		return ret;
-	}
-
-	if (memcmp(request->sha1, request->real_sha1, 20)) {
-		release_request(request);
-		return error("File %s has bad hash\n", hex);
-	}
-
-	if (request->rename < 0) {
+	} else if (memcmp(request->sha1, request->real_sha1, 20)) {
+		ret = error("File %s has bad hash\n", hex);
+	} else if (request->rename < 0) {
 		ret = error("unable to write sha1 filename %s: %s",
 			    request->filename,
 			    strerror(request->rename));
-		release_request(request);
-		return ret;
 	}
 
 	release_request(request);
-	return 0;
+	return ret;
 }
 
 int fetch(unsigned char *sha1)
@@ -1303,10 +909,6 @@ int main(int argc, char **argv)
 	char *commit_id;
 	char *url;
 	int arg = 1;
-	struct active_request_slot *slot;
-	char *low_speed_limit;
-	char *low_speed_time;
-	char *wait_url;
 	int rc = 0;
 
 	while (arg < argc && argv[arg][0] == '-') {
@@ -1335,58 +937,9 @@ int main(int argc, char **argv)
 	commit_id = argv[arg];
 	url = argv[arg + 1];
 
-	curl_global_init(CURL_GLOBAL_ALL);
-
-#ifdef USE_CURL_MULTI
-	{
-		char *http_max_requests = getenv("GIT_HTTP_MAX_REQUESTS");
-		if (http_max_requests != NULL)
-			max_requests = atoi(http_max_requests);
-	}
+	http_init();
 
-	curlm = curl_multi_init();
-	if (curlm == NULL) {
-		fprintf(stderr, "Error creating curl multi handle.\n");
-		return 1;
-	}
-#endif
-
-	if (getenv("GIT_SSL_NO_VERIFY"))
-		curl_ssl_verify = 0;
-
-	ssl_cert = getenv("GIT_SSL_CERT");
-#if LIBCURL_VERSION_NUM >= 0x070902
-	ssl_key = getenv("GIT_SSL_KEY");
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070908
-	ssl_capath = getenv("GIT_SSL_CAPATH");
-#endif
-	ssl_cainfo = getenv("GIT_SSL_CAINFO");
-
-	low_speed_limit = getenv("GIT_HTTP_LOW_SPEED_LIMIT");
-	if (low_speed_limit != NULL)
-		curl_low_speed_limit = strtol(low_speed_limit, NULL, 10);
-	low_speed_time = getenv("GIT_HTTP_LOW_SPEED_TIME");
-	if (low_speed_time != NULL)
-		curl_low_speed_time = strtol(low_speed_time, NULL, 10);
-
-	git_config(http_options);
-
-	if (curl_ssl_verify == -1)
-		curl_ssl_verify = 1;
-
-#ifdef USE_CURL_MULTI
-	if (max_requests < 1)
-		max_requests = DEFAULT_MAX_REQUESTS;
-#endif
-
-	pragma_header = curl_slist_append(pragma_header, "Pragma: no-cache");
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
-	no_range_header = curl_slist_append(no_range_header, "Range:");
-
-#ifndef NO_CURL_EASY_DUPHANDLE
-	curl_default = get_curl_handle();
-#endif
 
 	alt = xmalloc(sizeof(*alt));
 	alt->base = url;
@@ -1397,30 +950,9 @@ int main(int argc, char **argv)
 	if (pull(commit_id))
 		rc = 1;
 
-	curl_slist_free_all(pragma_header);
 	curl_slist_free_all(no_pragma_header);
-	curl_slist_free_all(no_range_header);
-#ifndef NO_CURL_EASY_DUPHANDLE
-	curl_easy_cleanup(curl_default);
-#endif
-	slot = active_queue_head;
-	while (slot != NULL) {
-		if (slot->in_use) {
-			if (get_verbosely) {
-				curl_easy_getinfo(slot->curl,
-						  CURLINFO_EFFECTIVE_URL,
-						  &wait_url);
-				fprintf(stderr, "Waiting for %s\n", wait_url);
-			}
-			run_active_slot(slot);
-		}
-		if (slot->curl != NULL)
-			curl_easy_cleanup(slot->curl);
-		slot = slot->next;
-	}
-#ifdef USE_CURL_MULTI
-	curl_multi_cleanup(curlm);
-#endif
-	curl_global_cleanup();
+
+	http_cleanup();
+
 	return rc;
 }
diff --git a/http-push.c b/http-push.c
index 8866189..afdcd8b 100644
--- a/http-push.c
+++ b/http-push.c
@@ -4,30 +4,15 @@
 #include "fetch.h"
 #include "tag.h"
 #include "blob.h"
+#include "http.h"
+
+#ifdef USE_CURL_MULTI
 
-#include <curl/curl.h>
-#include <curl/easy.h>
 #include <expat.h>
 
 static const char http_push_usage[] =
 "git-http-push [--complete] [--force] [--verbose] <url> <ref> [<ref>...]\n";
 
-#if LIBCURL_VERSION_NUM >= 0x070908
-#define USE_CURL_MULTI
-#define DEFAULT_MAX_REQUESTS 5
-#endif
-
-#if LIBCURL_VERSION_NUM < 0x070704
-#define curl_global_cleanup() do { /* nothing */ } while(0)
-#endif
-#if LIBCURL_VERSION_NUM < 0x070800
-#define curl_global_init(a) do { /* nothing */ } while(0)
-#endif
-
-#if LIBCURL_VERSION_NUM < 0x070c04
-#define NO_CURL_EASY_DUPHANDLE
-#endif
-
 #ifndef XML_STATUS_OK
 enum XML_Status {
   XML_STATUS_OK = 1,
@@ -52,34 +37,17 @@ enum XML_Status {
 #define LOCK_TIME 600
 #define LOCK_REFRESH 30
 
-static int active_requests = 0;
-static int data_received;
 static int pushing = 0;
 static int aborted = 0;
 static char remote_dir_exists[256];
 
-#ifdef USE_CURL_MULTI
-static int max_requests = -1;
-static CURLM *curlm;
-#endif
-#ifndef NO_CURL_EASY_DUPHANDLE
-static CURL *curl_default;
-#endif
 static struct curl_slist *no_pragma_header;
 static struct curl_slist *default_headers;
-static char curl_errorstr[CURL_ERROR_SIZE];
 
 static int push_verbosely = 0;
 static int push_all = 0;
 static int force_all = 0;
 
-struct buffer
-{
-        size_t posn;
-        size_t size;
-        void *buffer;
-};
-
 struct repo
 {
 	char *url;
@@ -122,31 +90,7 @@ struct transfer_request
 	struct transfer_request *next;
 };
 
-struct active_request_slot
-{
-	CURL *curl;
-	FILE *local;
-	int in_use;
-	int done;
-	CURLcode curl_result;
-	long http_code;
-	struct active_request_slot *next;
-};
-
 static struct transfer_request *request_queue_head = NULL;
-static struct active_request_slot *active_queue_head = NULL;
-
-static int curl_ssl_verify = -1;
-static char *ssl_cert = NULL;
-#if LIBCURL_VERSION_NUM >= 0x070902
-static char *ssl_key = NULL;
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070908
-static char *ssl_capath = NULL;
-#endif
-static char *ssl_cainfo = NULL;
-static long curl_low_speed_limit = -1;
-static long curl_low_speed_time = -1;
 
 struct active_lock
 {
@@ -174,260 +118,14 @@ struct lockprop
 	int lock_exclusive_write;
 };
 
-static int http_options(const char *var, const char *value)
-{
-	if (!strcmp("http.sslverify", var)) {
-		if (curl_ssl_verify == -1) {
-			curl_ssl_verify = git_config_bool(var, value);
-		}
-		return 0;
-	}
-
-	if (!strcmp("http.sslcert", var)) {
-		if (ssl_cert == NULL) {
-			ssl_cert = xmalloc(strlen(value)+1);
-			strcpy(ssl_cert, value);
-		}
-		return 0;
-	}
-#if LIBCURL_VERSION_NUM >= 0x070902
-	if (!strcmp("http.sslkey", var)) {
-		if (ssl_key == NULL) {
-			ssl_key = xmalloc(strlen(value)+1);
-			strcpy(ssl_key, value);
-		}
-		return 0;
-	}
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070908
-	if (!strcmp("http.sslcapath", var)) {
-		if (ssl_capath == NULL) {
-			ssl_capath = xmalloc(strlen(value)+1);
-			strcpy(ssl_capath, value);
-		}
-		return 0;
-	}
-#endif
-	if (!strcmp("http.sslcainfo", var)) {
-		if (ssl_cainfo == NULL) {
-			ssl_cainfo = xmalloc(strlen(value)+1);
-			strcpy(ssl_cainfo, value);
-		}
-		return 0;
-	}
+static void finish_request(struct transfer_request *request);
 
-#ifdef USE_CURL_MULTI	
-	if (!strcmp("http.maxrequests", var)) {
-		if (max_requests == -1)
-			max_requests = git_config_int(var, value);
-		return 0;
-	}
-#endif
-
-	if (!strcmp("http.lowspeedlimit", var)) {
-		if (curl_low_speed_limit == -1)
-			curl_low_speed_limit = (long)git_config_int(var, value);
-		return 0;
-	}
-	if (!strcmp("http.lowspeedtime", var)) {
-		if (curl_low_speed_time == -1)
-			curl_low_speed_time = (long)git_config_int(var, value);
-		return 0;
-	}
-
-	/* Fall back on the default ones */
-	return git_default_config(var, value);
-}
-
-static size_t fread_buffer(void *ptr, size_t eltsize, size_t nmemb,
-			   struct buffer *buffer)
+static void process_response(void *callback_data)
 {
-	size_t size = eltsize * nmemb;
-	if (size > buffer->size - buffer->posn)
-		size = buffer->size - buffer->posn;
-	memcpy(ptr, buffer->buffer + buffer->posn, size);
-	buffer->posn += size;
-	return size;
-}
-
-static size_t fwrite_buffer_dynamic(const void *ptr, size_t eltsize,
-				    size_t nmemb, struct buffer *buffer)
-{
-	size_t size = eltsize * nmemb;
-	if (size > buffer->size - buffer->posn) {
-		buffer->size = buffer->size * 3 / 2;
-		if (buffer->size < buffer->posn + size)
-			buffer->size = buffer->posn + size;
-		buffer->buffer = xrealloc(buffer->buffer, buffer->size);
-	}
-	memcpy(buffer->buffer + buffer->posn, ptr, size);
-	buffer->posn += size;
-	data_received++;
-	return size;
-}
+	struct transfer_request *request =
+		(struct transfer_request *)callback_data;
 
-static size_t fwrite_null(const void *ptr, size_t eltsize,
-			  size_t nmemb, struct buffer *buffer)
-{
-	data_received++;
-	return eltsize * nmemb;
-}
-
-#ifdef USE_CURL_MULTI
-static void process_curl_messages(void);
-static void process_request_queue(void);
-#endif
-
-static CURL* get_curl_handle(void)
-{
-	CURL* result = curl_easy_init();
-
-	curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, curl_ssl_verify);
-#if LIBCURL_VERSION_NUM >= 0x070907
-	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
-#endif
-
-	if (ssl_cert != NULL)
-		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
-#if LIBCURL_VERSION_NUM >= 0x070902
-	if (ssl_key != NULL)
-		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070908
-	if (ssl_capath != NULL)
-		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
-#endif
-	if (ssl_cainfo != NULL)
-		curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
-	curl_easy_setopt(result, CURLOPT_FAILONERROR, 1);
-
-	if (curl_low_speed_limit > 0 && curl_low_speed_time > 0) {
-		curl_easy_setopt(result, CURLOPT_LOW_SPEED_LIMIT,
-				 curl_low_speed_limit);
-		curl_easy_setopt(result, CURLOPT_LOW_SPEED_TIME,
-				 curl_low_speed_time);
-	}
-
-	return result;
-}
-
-static struct active_request_slot *get_active_slot(void)
-{
-	struct active_request_slot *slot = active_queue_head;
-	struct active_request_slot *newslot;
-
-#ifdef USE_CURL_MULTI
-	int num_transfers;
-
-	/* Wait for a slot to open up if the queue is full */
-	while (active_requests >= max_requests) {
-		curl_multi_perform(curlm, &num_transfers);
-		if (num_transfers < active_requests) {
-			process_curl_messages();
-		}
-	}
-#endif
-
-	while (slot != NULL && slot->in_use) {
-		slot = slot->next;
-	}
-	if (slot == NULL) {
-		newslot = xmalloc(sizeof(*newslot));
-		newslot->curl = NULL;
-		newslot->in_use = 0;
-		newslot->next = NULL;
-
-		slot = active_queue_head;
-		if (slot == NULL) {
-			active_queue_head = newslot;
-		} else {
-			while (slot->next != NULL) {
-				slot = slot->next;
-			}
-			slot->next = newslot;
-		}
-		slot = newslot;
-	}
-
-	if (slot->curl == NULL) {
-#ifdef NO_CURL_EASY_DUPHANDLE
-		slot->curl = get_curl_handle();
-#else
-		slot->curl = curl_easy_duphandle(curl_default);
-#endif
-	}
-
-	active_requests++;
-	slot->in_use = 1;
-	slot->done = 0;
-	slot->local = NULL;
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, default_headers);
-	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, curl_errorstr);
-
-	return slot;
-}
-
-static int start_active_slot(struct active_request_slot *slot)
-{
-#ifdef USE_CURL_MULTI
-	CURLMcode curlm_result = curl_multi_add_handle(curlm, slot->curl);
-
-	if (curlm_result != CURLM_OK &&
-	    curlm_result != CURLM_CALL_MULTI_PERFORM) {
-		active_requests--;
-		slot->in_use = 0;
-		return 0;
-	}
-#endif
-	return 1;
-}
-
-static void run_active_slot(struct active_request_slot *slot)
-{
-#ifdef USE_CURL_MULTI
-	int num_transfers;
-	long last_pos = 0;
-	long current_pos;
-	fd_set readfds;
-	fd_set writefds;
-	fd_set excfds;
-	int max_fd;
-	struct timeval select_timeout;
-	CURLMcode curlm_result;
-
-	while (!slot->done) {
-		data_received = 0;
-		do {
-			curlm_result = curl_multi_perform(curlm,
-							  &num_transfers);
-		} while (curlm_result == CURLM_CALL_MULTI_PERFORM);
-		if (num_transfers < active_requests) {
-			process_curl_messages();
-			process_request_queue();
-		}
-
-		if (!data_received && slot->local != NULL) {
-			current_pos = ftell(slot->local);
-			if (current_pos > last_pos)
-				data_received++;
-			last_pos = current_pos;
-		}
-
-		if (!slot->done && !data_received) {
-			max_fd = 0;
-			FD_ZERO(&readfds);
-			FD_ZERO(&writefds);
-			FD_ZERO(&excfds);
-			select_timeout.tv_sec = 0;
-			select_timeout.tv_usec = 50000;
-			select(max_fd, &readfds, &writefds,
-			       &excfds, &select_timeout);
-		}
-	}
-#else
-	slot->curl_result = curl_easy_perform(slot->curl);
-	active_requests--;
-#endif
+	finish_request(request);
 }
 
 static void start_check(struct transfer_request *request)
@@ -447,6 +145,8 @@ static void start_check(struct transfer_
 	strcpy(posn, hex + 2);
 
 	slot = get_active_slot();
+	slot->callback_func = process_response;
+	slot->callback_data = request;
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, request->errorstr);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, request->url);
 	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
@@ -476,6 +176,8 @@ static void start_mkcol(struct transfer_
 	strcpy(posn, "/");
 
 	slot = get_active_slot();
+	slot->callback_func = process_response;
+	slot->callback_data = request;
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1); /* undo PUT setup */
 	curl_easy_setopt(slot->curl, CURLOPT_URL, request->url);
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, request->errorstr);
@@ -553,6 +255,8 @@ static void start_put(struct transfer_re
 	strcpy(posn, request->lock->token);
 
 	slot = get_active_slot();
+	slot->callback_func = process_response;
+	slot->callback_data = request;
 	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &request->buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, request->buffer.size);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
@@ -578,6 +282,8 @@ static void start_move(struct transfer_r
 	struct curl_slist *dav_headers = NULL;
 
 	slot = get_active_slot();
+	slot->callback_func = process_response;
+	slot->callback_data = request;
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1); /* undo PUT setup */
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_MOVE);
 	dav_headers = curl_slist_append(dav_headers, request->dest);
@@ -725,48 +431,7 @@ static void release_request(struct trans
 	free(request);
 }
 
-#ifdef USE_CURL_MULTI
-static void process_curl_messages(void)
-{
-	int num_messages;
-	struct active_request_slot *slot;
-	struct transfer_request *request = NULL;
-	CURLMsg *curl_message = curl_multi_info_read(curlm, &num_messages);
-
-	while (curl_message != NULL) {
-		if (curl_message->msg == CURLMSG_DONE) {
-			slot = active_queue_head;
-			while (slot != NULL &&
-			       slot->curl != curl_message->easy_handle)
-				slot = slot->next;
-			if (slot != NULL) {
-				int curl_result = curl_message->data.result;
-				curl_multi_remove_handle(curlm, slot->curl);
-				active_requests--;
-				slot->done = 1;
-				slot->in_use = 0;
-				slot->curl_result = curl_result;
-				curl_easy_getinfo(slot->curl,
-						  CURLINFO_HTTP_CODE,
-						  &slot->http_code);
-				request = request_queue_head;
-				while (request != NULL &&
-				       request->slot != slot)
-					request = request->next;
-				if (request != NULL)
-					finish_request(request);
-			} else {
-				fprintf(stderr, "Received DONE message for unknown request!\n");
-			}
-		} else {
-			fprintf(stderr, "Unknown CURL message received: %d\n",
-				(int)curl_message->msg);
-		}
-		curl_message = curl_multi_info_read(curlm, &num_messages);
-	}
-}
-
-static void process_request_queue(void)
+void fill_active_slots(void)
 {
 	struct transfer_request *request = request_queue_head;
 	struct active_request_slot *slot = active_queue_head;
@@ -797,20 +462,6 @@ static void process_request_queue(void)
 		slot = slot->next;
 	}				
 }
-#endif
-
-static void process_waiting_requests(void)
-{
-	struct active_request_slot *slot = active_queue_head;
-
-	while (slot != NULL)
-		if (slot->in_use) {
-			run_active_slot(slot);
-			slot = active_queue_head;
-		} else {
-			slot = slot->next;
-		}
-}
 
 static void add_request(unsigned char *sha1, struct active_lock *lock)
 {
@@ -834,10 +485,9 @@ static void add_request(unsigned char *s
 	request->state = NEED_CHECK;
 	request->next = request_queue_head;
 	request_queue_head = request;
-#ifdef USE_CURL_MULTI
-	process_request_queue();
-	process_curl_messages();
-#endif
+
+	fill_active_slots();
+	step_active_slots();
 }
 
 static int fetch_index(unsigned char *sha1)
@@ -963,8 +613,7 @@ static int fetch_indices(void)
 
 	slot = get_active_slot();
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
-			 fwrite_buffer_dynamic);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
 	if (start_active_slot(slot)) {
@@ -1068,8 +717,7 @@ int fetch_ref(char *ref, unsigned char *
 	url = quote_ref_url(base, ref);
 	slot = get_active_slot();
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
-			 fwrite_buffer_dynamic);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	if (start_active_slot(slot)) {
@@ -1261,8 +909,7 @@ static struct active_lock *lock_remote(c
 	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.size);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
-			 fwrite_buffer_dynamic);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_LOCK);
@@ -1390,8 +1037,7 @@ static int check_locking(void)
 	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.size);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
-			 fwrite_buffer_dynamic);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, remote->url);
 	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PROPFIND);
@@ -1560,8 +1206,6 @@ static int update_remote(unsigned char *
 
 int main(int argc, char **argv)
 {
-	struct active_request_slot *slot;
-	struct active_request_slot *next_slot;
 	struct transfer_request *request;
 	struct transfer_request *next_request;
 	int nr_refspec = 0;
@@ -1576,8 +1220,6 @@ int main(int argc, char **argv)
 	unsigned char remote_sha1[20];
 	struct active_lock *remote_lock;
 	char *remote_path = NULL;
-	char *low_speed_limit;
-	char *low_speed_time;
 	int rc = 0;
 	int i;
 
@@ -1617,50 +1259,7 @@ int main(int argc, char **argv)
 
 	memset(remote_dir_exists, 0, 256);
 
-	curl_global_init(CURL_GLOBAL_ALL);
-
-#ifdef USE_CURL_MULTI
-	{
-		char *http_max_requests = getenv("GIT_HTTP_MAX_REQUESTS");
-		if (http_max_requests != NULL)
-			max_requests = atoi(http_max_requests);
-	}
-
-	curlm = curl_multi_init();
-	if (curlm == NULL) {
-		fprintf(stderr, "Error creating curl multi handle.\n");
-		return 1;
-	}
-#endif
-
-	if (getenv("GIT_SSL_NO_VERIFY"))
-		curl_ssl_verify = 0;
-
-	ssl_cert = getenv("GIT_SSL_CERT");
-#if LIBCURL_VERSION_NUM >= 0x070902
-	ssl_key = getenv("GIT_SSL_KEY");
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070908
-	ssl_capath = getenv("GIT_SSL_CAPATH");
-#endif
-	ssl_cainfo = getenv("GIT_SSL_CAINFO");
-
-	low_speed_limit = getenv("GIT_HTTP_LOW_SPEED_LIMIT");
-	if (low_speed_limit != NULL)
-		curl_low_speed_limit = strtol(low_speed_limit, NULL, 10);
-	low_speed_time = getenv("GIT_HTTP_LOW_SPEED_TIME");
-	if (low_speed_time != NULL)
-		curl_low_speed_time = strtol(low_speed_time, NULL, 10);
-
-	git_config(http_options);
-
-	if (curl_ssl_verify == -1)
-		curl_ssl_verify = 1;
-
-#ifdef USE_CURL_MULTI
-	if (max_requests < 1)
-		max_requests = DEFAULT_MAX_REQUESTS;
-#endif
+	http_init();
 
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
 	default_headers = curl_slist_append(default_headers, "Range:");
@@ -1669,10 +1268,6 @@ int main(int argc, char **argv)
 	default_headers = curl_slist_append(default_headers,
 					    "Pragma: no-cache");
 
-#ifndef NO_CURL_EASY_DUPHANDLE
-	curl_default = get_curl_handle();
-#endif
-
 	/* Verify DAV compliance/lock support */
 	if (check_locking() != 0) {
 		fprintf(stderr, "Error: no DAV locking support on remote repo %s\n", remote->url);
@@ -1766,13 +1361,13 @@ int main(int argc, char **argv)
 			fetch_indices();
 		get_delta(push_all ? NULL : remote_sha1,
 			  local_object, remote_lock);
-		process_waiting_requests();
+		finish_all_active_slots();
 
 		/* Push missing objects to remote, this would be a
 		   convenient time to pack them first if appropriate. */
 		pushing = 1;
-		process_request_queue();
-		process_waiting_requests();
+		fill_active_slots();
+		finish_all_active_slots();
 
 		/* Update the remote branch if all went well */
 		if (do_remote_update) {
@@ -1802,14 +1397,7 @@ int main(int argc, char **argv)
 	curl_slist_free_all(no_pragma_header);
 	curl_slist_free_all(default_headers);
 
-	slot = active_queue_head;
-	while (slot != NULL) {
-		next_slot = slot->next;
-		if (slot->curl != NULL)
-			curl_easy_cleanup(slot->curl);
-		free(slot);
-		slot = next_slot;
-	}
+	http_cleanup();
 
 	request = request_queue_head;
 	while (request != NULL) {
@@ -1818,12 +1406,12 @@ int main(int argc, char **argv)
 		request = next_request;
 	}
 
-#ifndef NO_CURL_EASY_DUPHANDLE
-	curl_easy_cleanup(curl_default);
-#endif
-#ifdef USE_CURL_MULTI
-	curl_multi_cleanup(curlm);
-#endif
-	curl_global_cleanup();
 	return rc;
 }
+#else /* ifdef USE_CURL_MULTI */
+int main(int argc, char **argv)
+{
+	fprintf(stderr, "http-push requires curl 7.9.8 or higher.\n");
+	return 1;
+}
+#endif
diff --git a/http.c b/http.c
new file mode 100644
index 0000000..470b56e
--- /dev/null
+++ b/http.c
@@ -0,0 +1,443 @@
+#include "http.h"
+
+int data_received;
+int active_requests = 0;
+
+#ifdef USE_CURL_MULTI
+int max_requests = -1;
+CURLM *curlm;
+#endif
+#ifndef NO_CURL_EASY_DUPHANDLE
+CURL *curl_default;
+#endif
+char curl_errorstr[CURL_ERROR_SIZE];
+
+int curl_ssl_verify = -1;
+char *ssl_cert = NULL;
+#if LIBCURL_VERSION_NUM >= 0x070902
+char *ssl_key = NULL;
+#endif
+#if LIBCURL_VERSION_NUM >= 0x070908
+char *ssl_capath = NULL;
+#endif
+char *ssl_cainfo = NULL;
+long curl_low_speed_limit = -1;
+long curl_low_speed_time = -1;
+
+struct curl_slist *pragma_header;
+struct curl_slist *no_range_header;
+
+struct active_request_slot *active_queue_head = NULL;
+
+size_t fread_buffer(void *ptr, size_t eltsize, size_t nmemb,
+			   struct buffer *buffer)
+{
+	size_t size = eltsize * nmemb;
+	if (size > buffer->size - buffer->posn)
+		size = buffer->size - buffer->posn;
+	memcpy(ptr, buffer->buffer + buffer->posn, size);
+	buffer->posn += size;
+	return size;
+}
+
+size_t fwrite_buffer(const void *ptr, size_t eltsize,
+			    size_t nmemb, struct buffer *buffer)
+{
+	size_t size = eltsize * nmemb;
+	if (size > buffer->size - buffer->posn) {
+		buffer->size = buffer->size * 3 / 2;
+		if (buffer->size < buffer->posn + size)
+			buffer->size = buffer->posn + size;
+		buffer->buffer = xrealloc(buffer->buffer, buffer->size);
+	}
+	memcpy(buffer->buffer + buffer->posn, ptr, size);
+	buffer->posn += size;
+	data_received++;
+	return size;
+}
+
+size_t fwrite_null(const void *ptr, size_t eltsize,
+			  size_t nmemb, struct buffer *buffer)
+{
+	data_received++;
+	return eltsize * nmemb;
+}
+
+static void finish_active_slot(struct active_request_slot *slot);
+
+#ifdef USE_CURL_MULTI
+static void process_curl_messages(void)
+{
+	int num_messages;
+	struct active_request_slot *slot;
+	CURLMsg *curl_message = curl_multi_info_read(curlm, &num_messages);
+
+	while (curl_message != NULL) {
+		if (curl_message->msg == CURLMSG_DONE) {
+			int curl_result = curl_message->data.result;
+			slot = active_queue_head;
+			while (slot != NULL &&
+			       slot->curl != curl_message->easy_handle)
+				slot = slot->next;
+			if (slot != NULL) {
+				curl_multi_remove_handle(curlm, slot->curl);
+				slot->curl_result = curl_result;
+				finish_active_slot(slot);
+			} else {
+				fprintf(stderr, "Received DONE message for unknown request!\n");
+			}
+		} else {
+			fprintf(stderr, "Unknown CURL message received: %d\n",
+				(int)curl_message->msg);
+		}
+		curl_message = curl_multi_info_read(curlm, &num_messages);
+	}
+}
+#endif
+
+static int http_options(const char *var, const char *value)
+{
+	if (!strcmp("http.sslverify", var)) {
+		if (curl_ssl_verify == -1) {
+			curl_ssl_verify = git_config_bool(var, value);
+		}
+		return 0;
+	}
+
+	if (!strcmp("http.sslcert", var)) {
+		if (ssl_cert == NULL) {
+			ssl_cert = xmalloc(strlen(value)+1);
+			strcpy(ssl_cert, value);
+		}
+		return 0;
+	}
+#if LIBCURL_VERSION_NUM >= 0x070902
+	if (!strcmp("http.sslkey", var)) {
+		if (ssl_key == NULL) {
+			ssl_key = xmalloc(strlen(value)+1);
+			strcpy(ssl_key, value);
+		}
+		return 0;
+	}
+#endif
+#if LIBCURL_VERSION_NUM >= 0x070908
+	if (!strcmp("http.sslcapath", var)) {
+		if (ssl_capath == NULL) {
+			ssl_capath = xmalloc(strlen(value)+1);
+			strcpy(ssl_capath, value);
+		}
+		return 0;
+	}
+#endif
+	if (!strcmp("http.sslcainfo", var)) {
+		if (ssl_cainfo == NULL) {
+			ssl_cainfo = xmalloc(strlen(value)+1);
+			strcpy(ssl_cainfo, value);
+		}
+		return 0;
+	}
+
+#ifdef USE_CURL_MULTI	
+	if (!strcmp("http.maxrequests", var)) {
+		if (max_requests == -1)
+			max_requests = git_config_int(var, value);
+		return 0;
+	}
+#endif
+
+	if (!strcmp("http.lowspeedlimit", var)) {
+		if (curl_low_speed_limit == -1)
+			curl_low_speed_limit = (long)git_config_int(var, value);
+		return 0;
+	}
+	if (!strcmp("http.lowspeedtime", var)) {
+		if (curl_low_speed_time == -1)
+			curl_low_speed_time = (long)git_config_int(var, value);
+		return 0;
+	}
+
+	/* Fall back on the default ones */
+	return git_default_config(var, value);
+}
+
+void http_init(void)
+{
+	char *low_speed_limit;
+	char *low_speed_time;
+
+	curl_global_init(CURL_GLOBAL_ALL);
+
+	pragma_header = curl_slist_append(pragma_header, "Pragma: no-cache");
+	no_range_header = curl_slist_append(no_range_header, "Range:");
+
+#ifdef USE_CURL_MULTI
+	{
+		char *http_max_requests = getenv("GIT_HTTP_MAX_REQUESTS");
+		if (http_max_requests != NULL)
+			max_requests = atoi(http_max_requests);
+	}
+
+	curlm = curl_multi_init();
+	if (curlm == NULL) {
+		fprintf(stderr, "Error creating curl multi handle.\n");
+		exit(1);
+	}
+#endif
+
+	if (getenv("GIT_SSL_NO_VERIFY"))
+		curl_ssl_verify = 0;
+
+	ssl_cert = getenv("GIT_SSL_CERT");
+#if LIBCURL_VERSION_NUM >= 0x070902
+	ssl_key = getenv("GIT_SSL_KEY");
+#endif
+#if LIBCURL_VERSION_NUM >= 0x070908
+	ssl_capath = getenv("GIT_SSL_CAPATH");
+#endif
+	ssl_cainfo = getenv("GIT_SSL_CAINFO");
+
+	low_speed_limit = getenv("GIT_HTTP_LOW_SPEED_LIMIT");
+	if (low_speed_limit != NULL)
+		curl_low_speed_limit = strtol(low_speed_limit, NULL, 10);
+	low_speed_time = getenv("GIT_HTTP_LOW_SPEED_TIME");
+	if (low_speed_time != NULL)
+		curl_low_speed_time = strtol(low_speed_time, NULL, 10);
+
+	git_config(http_options);
+
+	if (curl_ssl_verify == -1)
+		curl_ssl_verify = 1;
+
+#ifdef USE_CURL_MULTI
+	if (max_requests < 1)
+		max_requests = DEFAULT_MAX_REQUESTS;
+#endif
+
+#ifndef NO_CURL_EASY_DUPHANDLE
+	curl_default = get_curl_handle();
+#endif
+}
+
+void http_cleanup(void)
+{
+	struct active_request_slot *slot = active_queue_head;
+#ifdef USE_CURL_MULTI
+	char *wait_url;
+	CURLMcode curlm_result;
+#endif
+
+	while (slot != NULL) {
+#ifdef USE_CURL_MULTI
+		if (slot->in_use) {
+			curl_easy_getinfo(slot->curl,
+					  CURLINFO_EFFECTIVE_URL,
+					  &wait_url);
+			fprintf(stderr, "Waiting for %s\n", wait_url);
+			run_active_slot(slot);
+		}
+#endif
+		if (slot->curl != NULL)
+			curl_easy_cleanup(slot->curl);
+		slot = slot->next;
+	}
+
+#ifndef NO_CURL_EASY_DUPHANDLE
+	curl_easy_cleanup(curl_default);
+#endif
+
+#ifdef USE_CURL_MULTI
+	curl_multi_cleanup(curlm);
+#endif
+	curl_global_cleanup();
+	
+}
+
+static CURL* get_curl_handle(void)
+{
+	CURL* result = curl_easy_init();
+
+	curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, curl_ssl_verify);
+#if LIBCURL_VERSION_NUM >= 0x070907
+	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
+#endif
+
+	if (ssl_cert != NULL)
+		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
+#if LIBCURL_VERSION_NUM >= 0x070902
+	if (ssl_key != NULL)
+		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
+#endif
+#if LIBCURL_VERSION_NUM >= 0x070908
+	if (ssl_capath != NULL)
+		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
+#endif
+	if (ssl_cainfo != NULL)
+		curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
+	curl_easy_setopt(result, CURLOPT_FAILONERROR, 1);
+
+	if (curl_low_speed_limit > 0 && curl_low_speed_time > 0) {
+		curl_easy_setopt(result, CURLOPT_LOW_SPEED_LIMIT,
+				 curl_low_speed_limit);
+		curl_easy_setopt(result, CURLOPT_LOW_SPEED_TIME,
+				 curl_low_speed_time);
+	}
+
+	curl_easy_setopt(result, CURLOPT_FOLLOWLOCATION, 1);
+
+	return result;
+}
+
+struct active_request_slot *get_active_slot(void)
+{
+	struct active_request_slot *slot = active_queue_head;
+	struct active_request_slot *newslot;
+
+#ifdef USE_CURL_MULTI
+	int num_transfers;
+
+	/* Wait for a slot to open up if the queue is full */
+	while (active_requests >= max_requests) {
+		curl_multi_perform(curlm, &num_transfers);
+		if (num_transfers < active_requests) {
+			process_curl_messages();
+		}
+	}
+#endif
+
+	while (slot != NULL && slot->in_use) {
+		slot = slot->next;
+	}
+	if (slot == NULL) {
+		newslot = xmalloc(sizeof(*newslot));
+		newslot->curl = NULL;
+		newslot->in_use = 0;
+		newslot->next = NULL;
+
+		slot = active_queue_head;
+		if (slot == NULL) {
+			active_queue_head = newslot;
+		} else {
+			while (slot->next != NULL) {
+				slot = slot->next;
+			}
+			slot->next = newslot;
+		}
+		slot = newslot;
+	}
+
+	if (slot->curl == NULL) {
+#ifdef NO_CURL_EASY_DUPHANDLE
+		slot->curl = get_curl_handle();
+#else
+		slot->curl = curl_easy_duphandle(curl_default);
+#endif
+	}
+
+	active_requests++;
+	slot->in_use = 1;
+	slot->local = NULL;
+	slot->callback_data = NULL;
+	slot->callback_func = NULL;
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, pragma_header);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_range_header);
+	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, curl_errorstr);
+
+	return slot;
+}
+
+int start_active_slot(struct active_request_slot *slot)
+{
+#ifdef USE_CURL_MULTI
+	CURLMcode curlm_result = curl_multi_add_handle(curlm, slot->curl);
+
+	if (curlm_result != CURLM_OK &&
+	    curlm_result != CURLM_CALL_MULTI_PERFORM) {
+		active_requests--;
+		slot->in_use = 0;
+		return 0;
+	}
+#endif
+	return 1;
+}
+
+#ifdef USE_CURL_MULTI
+void step_active_slots(void)
+{
+	int num_transfers;
+	CURLMcode curlm_result;
+
+	do {
+		curlm_result = curl_multi_perform(curlm, &num_transfers);
+	} while (curlm_result == CURLM_CALL_MULTI_PERFORM);
+	if (num_transfers < active_requests) {
+		process_curl_messages();
+		fill_active_slots();
+	}
+}
+#endif
+
+void run_active_slot(struct active_request_slot *slot)
+{
+#ifdef USE_CURL_MULTI
+	long last_pos = 0;
+	long current_pos;
+	fd_set readfds;
+	fd_set writefds;
+	fd_set excfds;
+	int max_fd;
+	struct timeval select_timeout;
+
+	while (slot->in_use) {
+		data_received = 0;
+		step_active_slots();
+
+		if (!data_received && slot->local != NULL) {
+			current_pos = ftell(slot->local);
+			if (current_pos > last_pos)
+				data_received++;
+			last_pos = current_pos;
+		}
+
+		if (slot->in_use && !data_received) {
+			max_fd = 0;
+			FD_ZERO(&readfds);
+			FD_ZERO(&writefds);
+			FD_ZERO(&excfds);
+			select_timeout.tv_sec = 0;
+			select_timeout.tv_usec = 50000;
+			select(max_fd, &readfds, &writefds,
+			       &excfds, &select_timeout);
+		}
+	}
+#else
+	while (slot->in_use) {
+		slot->curl_result = curl_easy_perform(slot->curl);
+		finish_active_slot(slot);
+	}
+#endif
+}
+
+static void finish_active_slot(struct active_request_slot *slot)
+{
+        active_requests--;
+        slot->in_use = 0;
+        curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE, &slot->http_code);
+ 
+        /* Run callback if appropriate */
+        if (slot->callback_func != NULL) {
+                slot->callback_func(slot->callback_data);
+        }
+}
+
+void finish_all_active_slots(void)
+{
+	struct active_request_slot *slot = active_queue_head;
+
+	while (slot != NULL)
+		if (slot->in_use) {
+			run_active_slot(slot);
+			slot = active_queue_head;
+		} else {
+			slot = slot->next;
+		}
+}
diff --git a/http.h b/http.h
new file mode 100644
index 0000000..ed4ea33
--- /dev/null
+++ b/http.h
@@ -0,0 +1,95 @@
+#ifndef HTTP_H
+#define HTTP_H
+
+#include "cache.h"
+
+#include <curl/curl.h>
+#include <curl/easy.h>
+
+#if LIBCURL_VERSION_NUM >= 0x070908
+#define USE_CURL_MULTI
+#define DEFAULT_MAX_REQUESTS 5
+#endif
+
+#if LIBCURL_VERSION_NUM < 0x070704
+#define curl_global_cleanup() do { /* nothing */ } while(0)
+#endif
+#if LIBCURL_VERSION_NUM < 0x070800
+#define curl_global_init(a) do { /* nothing */ } while(0)
+#endif
+
+#if LIBCURL_VERSION_NUM < 0x070c04
+#define NO_CURL_EASY_DUPHANDLE
+#endif
+
+struct active_request_slot
+{
+	CURL *curl;
+	FILE *local;
+	int in_use;
+	CURLcode curl_result;
+	long http_code;
+	void *callback_data;
+	void (*callback_func)(void *data);
+	struct active_request_slot *next;
+};
+
+struct buffer
+{
+        size_t posn;
+        size_t size;
+        void *buffer;
+};
+
+/* Curl request read/write callbacks */
+extern size_t fread_buffer(void *ptr, size_t eltsize, size_t nmemb,
+			   struct buffer *buffer);
+extern size_t fwrite_buffer(const void *ptr, size_t eltsize,
+			    size_t nmemb, struct buffer *buffer);
+extern size_t fwrite_null(const void *ptr, size_t eltsize,
+			  size_t nmemb, struct buffer *buffer);
+
+/* Slot lifecycle functions */
+extern struct active_request_slot *get_active_slot(void);
+extern int start_active_slot(struct active_request_slot *slot);
+extern void run_active_slot(struct active_request_slot *slot);
+extern void finish_all_active_slots(void);
+
+#ifdef USE_CURL_MULTI
+extern void fill_active_slots(void);
+extern void step_active_slots(void);
+#endif
+
+extern void http_init(void);
+extern void http_cleanup(void);
+
+extern int data_received;
+extern int active_requests;
+
+#ifdef USE_CURL_MULTI
+extern int max_requests;
+extern CURLM *curlm;
+#endif
+#ifndef NO_CURL_EASY_DUPHANDLE
+extern CURL *curl_default;
+#endif
+extern char curl_errorstr[CURL_ERROR_SIZE];
+
+extern int curl_ssl_verify;
+extern char *ssl_cert;
+#if LIBCURL_VERSION_NUM >= 0x070902
+extern char *ssl_key;
+#endif
+#if LIBCURL_VERSION_NUM >= 0x070908
+extern char *ssl_capath;
+#endif
+extern char *ssl_cainfo;
+extern long curl_low_speed_limit;
+extern long curl_low_speed_time;
+
+extern struct curl_slist *pragma_header;
+extern struct curl_slist *no_range_header;
+
+extern struct active_request_slot *active_queue_head;
+
+#endif /* HTTP_H */
---
0.99.9.GIT
