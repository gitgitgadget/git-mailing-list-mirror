From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] Only compile parallel HTTP support with CURL >= 7.9.8
Date: Thu, 6 Oct 2005 17:04:06 -0700
Message-ID: <20051007000406.GI15593@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Oct 07 02:05:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENfid-00086h-GI
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 02:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVJGAEI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 20:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVJGAEI
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 20:04:08 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:27752 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932126AbVJGAEH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2005 20:04:07 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j97046uq016131
	for <git@vger.kernel.org>; Thu, 6 Oct 2005 17:04:06 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j97046iI016129
	for git@vger.kernel.org; Thu, 6 Oct 2005 17:04:06 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9792>

Only compile parallel HTTP support with CURL >= 7.9.8

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-fetch.c |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 57 insertions(+), 5 deletions(-)

2677e4eab199eb43f5e3a865e4008d3db79708a5
diff --git a/http-fetch.c b/http-fetch.c
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -6,7 +6,10 @@
 #include <curl/curl.h>
 #include <curl/easy.h>
 
+#if LIBCURL_VERSION_NUM >= 0x070908
+#define USE_CURL_MULTI
 #define DEFAULT_MAX_REQUESTS 5
+#endif
 
 #if LIBCURL_VERSION_NUM < 0x070704
 #define curl_global_cleanup() do { /* nothing */ } while(0)
@@ -18,11 +21,13 @@
 #define PREV_BUF_SIZE 4096
 #define RANGE_HEADER_SIZE 30
 
-static int max_requests = DEFAULT_MAX_REQUESTS;
 static int active_requests = 0;
 static int data_received;
 
+#ifdef USE_CURL_MULTI
+static int max_requests = DEFAULT_MAX_REQUESTS;
 static CURLM *curlm;
+#endif
 static CURL *curl_default;
 static struct curl_slist *no_pragma_header;
 static struct curl_slist *no_range_header;
@@ -151,13 +156,17 @@ int relink_or_rename(char *old, char *ne
 	return 0;
 }
 
+#ifdef USE_CURL_MULTI
 void process_curl_messages();
 void process_request_queue();
+#endif
 
 struct active_request_slot *get_active_slot()
 {
 	struct active_request_slot *slot = active_queue_head;
 	struct active_request_slot *newslot;
+
+#ifdef USE_CURL_MULTI
 	int num_transfers;
 
 	/* Wait for a slot to open up if the queue is full */
@@ -167,6 +176,7 @@ struct active_request_slot *get_active_s
 			process_curl_messages();
 		}
 	}
+#endif
 
 	while (slot != NULL && slot->in_use) {
 		slot = slot->next;
@@ -202,6 +212,7 @@ struct active_request_slot *get_active_s
 
 int start_active_slot(struct active_request_slot *slot)
 {
+#ifdef USE_CURL_MULTI
 	CURLMcode curlm_result = curl_multi_add_handle(curlm, slot->curl);
 
 	if (curlm_result != CURLM_OK &&
@@ -210,12 +221,13 @@ int start_active_slot(struct active_requ
 		slot->in_use = 0;
 		return 0;
 	}
-
+#endif
 	return 1;
 }
 
 void run_active_slot(struct active_request_slot *slot)
 {
+#ifdef USE_CURL_MULTI
 	int num_transfers;
 	long last_pos = 0;
 	long current_pos;
@@ -255,6 +267,10 @@ void run_active_slot(struct active_reque
 			       &excfds, &select_timeout);
 		}
 	}
+#else
+	slot->curl_result = curl_easy_perform(slot->curl);
+	active_requests--;
+#endif
 }
 
 void start_request(struct transfer_request *request)
@@ -356,7 +372,7 @@ void start_request(struct transfer_reque
 				 CURLOPT_HTTPHEADER, range_header);
 	}
 
-	/* Try to add to multi handle, abort the request on error */
+	/* Try to get the request started, abort the request on error */
 	if (!start_active_slot(slot)) {
 		request->state = ABORTED;
 		close(request->local);
@@ -413,6 +429,7 @@ void release_request(struct transfer_req
 	free(request);
 }
 
+#ifdef USE_CURL_MULTI
 void process_curl_messages()
 {
 	int num_messages;
@@ -478,6 +495,7 @@ void process_request_queue()
 		request = request->next;
 	}
 }
+#endif
 
 void prefetch(unsigned char *sha1)
 {
@@ -505,8 +523,10 @@ void prefetch(unsigned char *sha1)
 		}
 		tail->next = newreq;
 	}
+#ifdef USE_CURL_MULTI
 	process_request_queue();
 	process_curl_messages();
+#endif
 }
 
 static int got_alternates = 0;
@@ -864,13 +884,14 @@ static int fetch_object(struct alt_base 
 	char *hex = sha1_to_hex(sha1);
 	int ret;
 	struct transfer_request *request = request_queue_head;
-	int num_transfers;
 
 	while (request != NULL && memcmp(request->sha1, sha1, 20))
 		request = request->next;
 	if (request == NULL)
 		return error("Couldn't find request for %s in the queue", hex);
 
+#ifdef USE_CURL_MULTI
+	int num_transfers;
 	while (request->state == WAITING) {
 		curl_multi_perform(curlm, &num_transfers);
 		if (num_transfers < active_requests) {
@@ -878,9 +899,30 @@ static int fetch_object(struct alt_base 
 			process_request_queue();
 		}
 	}
+#else
+	start_request(request);
+#endif
 
-	if (request->state == ACTIVE)
+	while (request->state == ACTIVE) {
 		run_active_slot(request->slot);
+#ifndef USE_CURL_MULTI
+		request->curl_result = request->slot->curl_result;
+		curl_easy_getinfo(request->slot->curl,
+				  CURLINFO_HTTP_CODE,
+				  &request->http_code);
+		request->slot = NULL;
+
+		/* Use alternates if necessary */
+		if (request->http_code == 404 &&
+		    request->repo->next != NULL) {
+			request->repo = request->repo->next;
+			start_request(request);
+		} else {
+			finish_request(request);
+			request->state = COMPLETE;
+		}
+#endif
+	}
 
 	if (request->state == ABORTED) {
 		release_request(request);
@@ -992,16 +1034,22 @@ int main(int argc, char **argv)
 			arg++;
 		} else if (!strcmp(argv[arg], "--recover")) {
 			get_recover = 1;
+#ifdef USE_CURL_MULTI
 		} else if (argv[arg][1] == 'r') {
 			max_requests = atoi(argv[arg + 1]);
 			if (max_requests < 1)
 				max_requests = DEFAULT_MAX_REQUESTS;
 			arg++;
+#endif
 		}
 		arg++;
 	}
 	if (argc < arg + 2) {
+#ifdef USE_CURL_MULTI
+		usage("git-http-fetch [-c] [-t] [-a] [-d] [-v] [-r concurrent-request-limit] [--recover] [-w ref] commit-id url");
+#else
 		usage("git-http-fetch [-c] [-t] [-a] [-d] [-v] [--recover] [-w ref] commit-id url");
+#endif
 		return 1;
 	}
 	commit_id = argv[arg];
@@ -1009,11 +1057,13 @@ int main(int argc, char **argv)
 
 	curl_global_init(CURL_GLOBAL_ALL);
 
+#ifdef USE_CURL_MULTI
 	curlm = curl_multi_init();
 	if (curlm == NULL) {
 		fprintf(stderr, "Error creating curl multi handle.\n");
 		return 1;
 	}
+#endif
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
 	no_range_header = curl_slist_append(no_range_header, "Range:");
 
@@ -1061,7 +1111,9 @@ int main(int argc, char **argv)
 		curl_easy_cleanup(slot->curl);
 		slot = slot->next;
 	}
+#ifdef USE_CURL_MULTI
 	curl_multi_cleanup(curlm);
+#endif
 	curl_global_cleanup();
 	return 0;
 }
