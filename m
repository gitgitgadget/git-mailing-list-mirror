From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/4] Refactor http.h USE_CURL_MULTI fill_active_slots().
Date: Sun, 22 Jul 2007 18:09:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707221808460.29679@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jul 23 00:09:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICjcL-0000IM-Sb
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 00:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759298AbXGVWJW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 18:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756112AbXGVWJW
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 18:09:22 -0400
Received: from iabervon.org ([66.92.72.58]:3832 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758784AbXGVWJV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 18:09:21 -0400
Received: (qmail 29511 invoked by uid 1000); 22 Jul 2007 22:09:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Jul 2007 22:09:20 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53338>

This removes all of the boilerplate and http-internal stuff from
fill_active_slots() and makes it easy to turn into a callback.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 http-fetch.c |   23 +++++++----------------
 http-push.c  |   23 ++++++-----------------
 http.c       |   24 ++++++++++++++++++++++++
 http.h       |    9 +++------
 4 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index 202fae0..e9b9f30 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -317,30 +317,21 @@ static void release_object_request(struct object_request *obj_req)
 }
 
 #ifdef USE_CURL_MULTI
-void fill_active_slots(void)
+int fill_active_slot(void)
 {
-	struct object_request *obj_req = object_queue_head;
-	struct active_request_slot *slot = active_queue_head;
-	int num_transfers;
+	struct object_request *obj_req;
 
-	while (active_requests < max_requests && obj_req != NULL) {
+	for (obj_req = object_queue_head; obj_req; obj_req = obj_req->next) {
 		if (obj_req->state == WAITING) {
 			if (has_sha1_file(obj_req->sha1))
 				obj_req->state = COMPLETE;
-			else
+			else {
 				start_object_request(obj_req);
-			curl_multi_perform(curlm, &num_transfers);
-		}
-		obj_req = obj_req->next;
-	}
-
-	while (slot != NULL) {
-		if (!slot->in_use && slot->curl != NULL) {
-			curl_easy_cleanup(slot->curl);
-			slot->curl = NULL;
+				return 1;
+			}
 		}
-		slot = slot->next;
 	}
+	return 0;
 }
 #endif
 
diff --git a/http-push.c b/http-push.c
index 7c3720f..c7471fa 100644
--- a/http-push.c
+++ b/http-push.c
@@ -795,38 +795,27 @@ static void finish_request(struct transfer_request *request)
 }
 
 #ifdef USE_CURL_MULTI
-void fill_active_slots(void)
+int fill_active_slot(void)
 {
 	struct transfer_request *request = request_queue_head;
-	struct transfer_request *next;
-	struct active_request_slot *slot = active_queue_head;
-	int num_transfers;
 
 	if (aborted)
-		return;
+		return 0;
 
-	while (active_requests < max_requests && request != NULL) {
-		next = request->next;
+	for (request = request_queue_head; request; request = request->next) {
 		if (request->state == NEED_FETCH) {
 			start_fetch_loose(request);
+			return 1;
 		} else if (pushing && request->state == NEED_PUSH) {
 			if (remote_dir_exists[request->obj->sha1[0]] == 1) {
 				start_put(request);
 			} else {
 				start_mkcol(request);
 			}
-			curl_multi_perform(curlm, &num_transfers);
-		}
-		request = next;
-	}
-
-	while (slot != NULL) {
-		if (!slot->in_use && slot->curl != NULL) {
-			curl_easy_cleanup(slot->curl);
-			slot->curl = NULL;
+			return 1;
 		}
-		slot = slot->next;
 	}
+	return 0;
 }
 #endif
 
diff --git a/http.c b/http.c
index c6fb8ac..1f305bd 100644
--- a/http.c
+++ b/http.c
@@ -372,6 +372,7 @@ int start_active_slot(struct active_request_slot *slot)
 {
 #ifdef USE_CURL_MULTI
 	CURLMcode curlm_result = curl_multi_add_handle(curlm, slot->curl);
+	int num_transfers;
 
 	if (curlm_result != CURLM_OK &&
 	    curlm_result != CURLM_CALL_MULTI_PERFORM) {
@@ -379,11 +380,34 @@ int start_active_slot(struct active_request_slot *slot)
 		slot->in_use = 0;
 		return 0;
 	}
+
+	/*
+	 * We know there must be something to do, since we just added
+	 * something.
+	 */
+	curl_multi_perform(curlm, &num_transfers);
 #endif
 	return 1;
 }
 
 #ifdef USE_CURL_MULTI
+void fill_active_slots(void)
+{
+	struct active_request_slot *slot = active_queue_head;
+
+	while (active_requests < max_requests)
+		if (!fill_active_slot())
+			break;
+
+	while (slot != NULL) {
+		if (!slot->in_use && slot->curl != NULL) {
+			curl_easy_cleanup(slot->curl);
+			slot->curl = NULL;
+		}
+		slot = slot->next;
+	}
+}
+
 void step_active_slots(void)
 {
 	int num_transfers;
diff --git a/http.h b/http.h
index 69b6b66..559105c 100644
--- a/http.h
+++ b/http.h
@@ -71,6 +71,9 @@ extern void release_active_slot(struct active_request_slot *slot);
 #ifdef USE_CURL_MULTI
 extern void fill_active_slots(void);
 extern void step_active_slots(void);
+
+/* Provided by the program using http. */
+extern int fill_active_slot(void);
 #endif
 
 extern void http_init(void);
@@ -79,10 +82,6 @@ extern void http_cleanup(void);
 extern int data_received;
 extern int active_requests;
 
-#ifdef USE_CURL_MULTI
-extern int max_requests;
-extern CURLM *curlm;
-#endif
 #ifndef NO_CURL_EASY_DUPHANDLE
 extern CURL *curl_default;
 #endif
@@ -103,6 +102,4 @@ extern long curl_low_speed_time;
 extern struct curl_slist *pragma_header;
 extern struct curl_slist *no_range_header;
 
-extern struct active_request_slot *active_queue_head;
-
 #endif /* HTTP_H */
-- 
1.5.3.rc1.818.g84b7
