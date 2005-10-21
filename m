From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 2/3] Switched back to loading alternates as needed
Date: Fri, 21 Oct 2005 12:06:20 -0700
Message-ID: <20051021190620.GF6160@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Oct 21 21:08:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET2Do-0000L1-Jb
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 21:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbVJUTG0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 15:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbVJUTG0
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 15:06:26 -0400
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:37375 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S965096AbVJUTGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 15:06:25 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j9LJ6KCv023863
	for <git@vger.kernel.org>; Fri, 21 Oct 2005 12:06:20 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j9LJ6Kbt023861
	for git@vger.kernel.org; Fri, 21 Oct 2005 12:06:20 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10440>

Switched back to loading alternates as needed

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

Always loading alternates causes unnecessary requests, especially
when a repository is being cloned and git-http-fetch is run repeatedly
with different commit IDs.  On a related note, in such a case could we
pass multiple IDs to the commit walkers (perhaps via stdin?)

 http-fetch.c |   45 +++++++++++++++++++++++++++++----------------
 1 files changed, 29 insertions(+), 16 deletions(-)

applies-to: 6a0c92c60e0b46581276e7592e4f7a1b12f3dc7e
274889e0d7a97eaf060851653166b7cbc72dd3f6
diff --git a/http-fetch.c b/http-fetch.c
index d26fae8..ed1053a 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -25,6 +25,7 @@
 #define PREV_BUF_SIZE 4096
 #define RANGE_HEADER_SIZE 30
 
+static int got_alternates = 0;
 static int active_requests = 0;
 static int data_received;
 
@@ -85,6 +86,7 @@ struct active_request_slot
 	int in_use;
 	int done;
 	CURLcode curl_result;
+	long http_code;
 	struct active_request_slot *next;
 };
 
@@ -235,6 +237,7 @@ static size_t fwrite_sha1_file(void *ptr
 static void process_curl_messages(void);
 static void process_request_queue(void);
 #endif
+static int fetch_alternates(char *base);
 
 static CURL* get_curl_handle(void)
 {
@@ -580,6 +583,9 @@ void process_curl_messages(void)
 				slot->done = 1;
 				slot->in_use = 0;
 				slot->curl_result = curl_message->data.result;
+				curl_easy_getinfo(slot->curl,
+						  CURLINFO_HTTP_CODE,
+						  &slot->http_code);
 				request = request_queue_head;
 				while (request != NULL &&
 				       request->slot != slot)
@@ -590,19 +596,20 @@ void process_curl_messages(void)
 			if (request != NULL) {
 				request->curl_result =
 					curl_message->data.result;
-				curl_easy_getinfo(slot->curl,
-						  CURLINFO_HTTP_CODE,
-						  &request->http_code);
+				request->http_code = slot->http_code;
 				request->slot = NULL;
+				request->state = COMPLETE;
 
 				/* Use alternates if necessary */
-				if (request->http_code == 404 &&
-				    request->repo->next != NULL) {
-					request->repo = request->repo->next;
-					start_request(request);
+				if (request->http_code == 404) {
+					fetch_alternates(alt->base);
+					if (request->repo->next != NULL) {
+						request->repo =
+							request->repo->next;
+						start_request(request);
+					}
 				} else {
 					finish_request(request);
-					request->state = COMPLETE;
 				}
 			}
 		} else {
@@ -765,6 +772,9 @@ static int fetch_alternates(char *base)
 
 	struct active_request_slot *slot;
 
+	if (got_alternates)
+		return 0;
+
 	data = xmalloc(4096);
 	buffer.size = 4096;
 	buffer.posn = 0;
@@ -797,6 +807,8 @@ static int fetch_alternates(char *base)
 				run_active_slot(slot);
 				if (slot->curl_result != CURLE_OK) {
 					free(buffer.buffer);
+					if (slot->http_code == 404)
+						got_alternates = 1;
 					return 0;
 				}
 			}
@@ -868,6 +880,7 @@ static int fetch_alternates(char *base)
 		i = posn + 1;
 	}
 
+	got_alternates = 1;
 	free(buffer.buffer);
 	return ret;
 }
@@ -1059,16 +1072,16 @@ static int fetch_object(struct alt_base 
 		run_active_slot(request->slot);
 #ifndef USE_CURL_MULTI
 		request->curl_result = request->slot->curl_result;
-		curl_easy_getinfo(request->slot->curl,
-				  CURLINFO_HTTP_CODE,
-				  &request->http_code);
+		request->http_code = request->slot->http_code;
 		request->slot = NULL;
 
 		/* Use alternates if necessary */
-		if (request->http_code == 404 &&
-		    request->repo->next != NULL) {
-			request->repo = request->repo->next;
-			start_request(request);
+		if (request->http_code == 404) {
+			fetch_alternates(alt->base);
+			if (request->repo->next != NULL) {
+				request->repo = request->repo->next;
+				start_request(request);
+			}
 		} else {
 			finish_request(request);
 			request->state = COMPLETE;
@@ -1121,6 +1134,7 @@ int fetch(unsigned char *sha1)
 	while (altbase) {
 		if (!fetch_pack(altbase, sha1))
 			return 0;
+		fetch_alternates(alt->base);
 		altbase = altbase->next;
 	}
 	return error("Unable to find %s under %s\n", sha1_to_hex(sha1), 
@@ -1297,7 +1311,6 @@ int main(int argc, char **argv)
 	alt->got_indices = 0;
 	alt->packs = NULL;
 	alt->next = NULL;
-	fetch_alternates(alt->base);
 
 	if (pull(commit_id))
 		return 1;
---
0.99.8.GIT
