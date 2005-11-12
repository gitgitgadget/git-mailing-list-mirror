From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] Fix for multiple alternates requests in http-fetch
Date: Sat, 12 Nov 2005 09:11:32 -0800
Message-ID: <20051112171131.GE4051@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Nov 12 18:12:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eayui-0000Sr-IA
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 18:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVKLRLh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 12:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbVKLRLh
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 12:11:37 -0500
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:16816 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932419AbVKLRLh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 12:11:37 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jACHBWkr023907
	for <git@vger.kernel.org>; Sat, 12 Nov 2005 09:11:32 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jACHBWUZ023905
	for git@vger.kernel.org; Sat, 12 Nov 2005 09:11:32 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11694>

Stop additional alternates requests from starting if one is already in
progress.  This adds an optional callback which is processed after a slot
has finished running.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-fetch.c |  178 ++++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 117 insertions(+), 61 deletions(-)

applies-to: 9a0f0c748316751fbf593a21f2b16bcdd975095a
6a34e305a8c718b69604e416e0766ab60e5c1944
diff --git a/http-fetch.c b/http-fetch.c
index f39e748..99b6cc7 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -25,7 +25,7 @@
 #define PREV_BUF_SIZE 4096
 #define RANGE_HEADER_SIZE 30
 
-static int got_alternates = 0;
+static int got_alternates = -1;
 static int active_requests = 0;
 static int data_received;
 
@@ -87,9 +87,19 @@ struct active_request_slot
 	int done;
 	CURLcode curl_result;
 	long http_code;
+	void *callback_data;
+	void (*callback_func)(void *data);
 	struct active_request_slot *next;
 };
 
+struct alt_request {
+	char *base;
+	char *url;
+	struct buffer *buffer;
+	struct active_request_slot *slot;
+	int http_specific;
+};
+
 static struct transfer_request *request_queue_head = NULL;
 static struct active_request_slot *active_queue_head = NULL;
 
@@ -237,7 +247,7 @@ static size_t fwrite_sha1_file(void *ptr
 static void process_curl_messages(void);
 static void process_request_queue(void);
 #endif
-static int fetch_alternates(char *base);
+static void fetch_alternates(char *base);
 
 static CURL* get_curl_handle(void)
 {
@@ -324,6 +334,8 @@ static struct active_request_slot *get_a
 	slot->in_use = 1;
 	slot->done = 0;
 	slot->local = NULL;
+	slot->callback_data = NULL;
+	slot->callback_func = NULL;
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, pragma_header);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_range_header);
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, curl_errorstr);
@@ -601,6 +613,12 @@ static void process_curl_messages(void)
 			} else {
 				fprintf(stderr, "Received DONE message for unknown request!\n");
 			}
+
+			/* Process slot callback if appropriate */
+			if (slot->callback_func != NULL) {
+				slot->callback_func(slot->callback_data);
+			}
+
 			if (request != NULL) {
 				request->curl_result = curl_result;
 				request->http_code = slot->http_code;
@@ -766,72 +784,51 @@ static int setup_index(struct alt_base *
 	return 0;
 }
 
-static int fetch_alternates(char *base)
+static void process_alternates(void *callback_data)
 {
-	int ret = 0;
-	struct buffer buffer;
-	char *url;
-	char *data;
-	int i = 0;
-	int http_specific = 1;
+	struct alt_request *alt_req = (struct alt_request *)callback_data;
+	struct active_request_slot *slot = alt_req->slot;
 	struct alt_base *tail = alt;
+	char *base = alt_req->base;
 	static const char null_byte = '\0';
+	char *data;
+	int i = 0;
 
-	struct active_request_slot *slot;
-
-	if (got_alternates)
-		return 0;
-
-	data = xmalloc(4096);
-	buffer.size = 4096;
-	buffer.posn = 0;
-	buffer.buffer = data;
-
-	if (get_verbosely)
-		fprintf(stderr, "Getting alternates list for %s\n", base);
-	
-	url = xmalloc(strlen(base) + 31);
-	sprintf(url, "%s/objects/info/http-alternates", base);
-
-	slot = get_active_slot();
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
-			 fwrite_buffer_dynamic);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (slot->curl_result != CURLE_OK || !buffer.posn) {
-			http_specific = 0;
-
-			sprintf(url, "%s/objects/info/alternates", base);
-
-			slot = get_active_slot();
-			curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
-					 fwrite_buffer_dynamic);
-			curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	if (alt_req->http_specific) {
+		if (slot->curl_result != CURLE_OK ||
+		    !alt_req->buffer->posn) {
+
+			/* Try reusing the slot to get non-http alternates */
+			alt_req->http_specific = 0;
+			sprintf(alt_req->url, "%s/objects/info/alternates",
+				base);
+			curl_easy_setopt(slot->curl, CURLOPT_URL,
+					 alt_req->url);
+			active_requests++;
+			slot->in_use = 1;
+			slot->done = 0;
 			if (start_active_slot(slot)) {
-				run_active_slot(slot);
-				if (slot->curl_result != CURLE_OK) {
-					free(buffer.buffer);
-					if (slot->http_code == 404)
-						got_alternates = 1;
-					return 0;
-				}
+				return;
+			} else {
+				got_alternates = -1;
+				slot->done = 1;
+				return;
 			}
 		}
-	} else {
-		free(buffer.buffer);
-		return 0;
+	} else if (slot->curl_result != CURLE_OK) {
+		if (slot->http_code != 404) {
+			got_alternates = -1;
+			return;
+		}
 	}
 
-	fwrite_buffer_dynamic(&null_byte, 1, 1, &buffer);
-	buffer.posn--;
-	data = buffer.buffer;
+	fwrite_buffer_dynamic(&null_byte, 1, 1, alt_req->buffer);
+	alt_req->buffer->posn--;
+	data = alt_req->buffer->buffer;
 
-	while (i < buffer.posn) {
+	while (i < alt_req->buffer->posn) {
 		int posn = i;
-		while (posn < buffer.posn && data[posn] != '\n')
+		while (posn < alt_req->buffer->posn && data[posn] != '\n')
 			posn++;
 		if (data[posn] == '\n') {
 			int okay = 0;
@@ -855,7 +852,7 @@ static int fetch_alternates(char *base)
 				// If the server got removed, give up.
 				okay = strchr(base, ':') - base + 3 < 
 					serverlen;
-			} else if (http_specific) {
+			} else if (alt_req->http_specific) {
 				char *colon = strchr(data + i, ':');
 				char *slash = strchr(data + i, '/');
 				if (colon && slash && colon < data + posn &&
@@ -881,15 +878,74 @@ static int fetch_alternates(char *base)
 				while (tail->next != NULL)
 					tail = tail->next;
 				tail->next = newalt;
-				ret++;
 			}
 		}
 		i = posn + 1;
 	}
 
 	got_alternates = 1;
-	free(buffer.buffer);
-	return ret;
+}
+
+static void fetch_alternates(char *base)
+{
+	struct buffer buffer;
+	char *url;
+	char *data;
+	struct active_request_slot *slot;
+	static struct alt_request alt_req;
+	int num_transfers;
+
+	/* If another request has already started fetching alternates,
+	   wait for them to arrive and return to processing this request's
+	   curl message */
+	while (got_alternates == 0) {
+		curl_multi_perform(curlm, &num_transfers);
+		process_curl_messages();
+		process_request_queue();
+	}
+
+	/* Nothing to do if they've already been fetched */
+	if (got_alternates == 1)
+		return;
+
+	/* Start the fetch */
+	got_alternates = 0;
+
+	data = xmalloc(4096);
+	buffer.size = 4096;
+	buffer.posn = 0;
+	buffer.buffer = data;
+
+	if (get_verbosely)
+		fprintf(stderr, "Getting alternates list for %s\n", base);
+	
+	url = xmalloc(strlen(base) + 31);
+	sprintf(url, "%s/objects/info/http-alternates", base);
+
+	/* Use a callback to process the result, since another request
+	   may fail and need to have alternates loaded before continuing */
+	slot = get_active_slot();
+	slot->callback_func = process_alternates;
+	slot->callback_data = &alt_req;
+
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
+			 fwrite_buffer_dynamic);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+
+	alt_req.base = base;
+	alt_req.url = url;
+	alt_req.buffer = &buffer;
+	alt_req.http_specific = 1;
+	alt_req.slot = slot;
+
+	if (start_active_slot(slot))
+		run_active_slot(slot);
+	else
+		got_alternates = -1;
+
+	free(data);
+	free(url);
 }
 
 static int fetch_indices(struct alt_base *repo)
---
0.99.9.GIT
