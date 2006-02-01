From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH 1/9] http-fetch: Mark slots as `watched' to stop them being reused.
Date: Wed, 01 Feb 2006 11:44:26 +0000
Message-ID: <20060201114426.5042.97599.stgit@metalzone.distorted.org.uk>
References: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Wed Feb 01 12:45:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4GPk-00055O-2S
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 12:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWBALoa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 06:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWBALo3
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 06:44:29 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:5104 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S964855AbWBALo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 06:44:28 -0500
Received: (qmail 6500 invoked from network); 1 Feb 2006 11:44:26 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (?cgAY+OIa5oCAynKRgntbyFdPapj3KwUx?@127.0.0.1)
  by localhost with SMTP; 1 Feb 2006 11:44:26 -0000
To: git@vger.kernel.org
In-Reply-To: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15408>

From: Mark Wooding <mdw@distorted.org.uk>

Previously, it was possible for the slot passed to run_active_slot() to
be reused before that function returned, rendering its completion status
useless.  This is particularly noticeable when fetching a repository
with a wide, flat directory structure (lots of blobs in the top-level
tree), a single unpacked commit which changes just one or two blobs, and
the rest of the history in one pack.  When fetch_indices() gets the
pack-list, the slot is (usually!) reused for some blob object which is
packed, so it fails with 404; fetch_indices() decides that the pack-list
fetch failed, and nothing therefore fetches the pack.

We fix this by adding a feature to lock slots against reuse.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 http-fetch.c |    6 +++---
 http.c       |   43 +++++++++++++++++++++++++++++++++----------
 http.h       |    6 +++++-
 3 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index 61b2188..4b1b62d 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -465,13 +465,13 @@ static void process_alternates_response(
 				base);
 			curl_easy_setopt(slot->curl, CURLOPT_URL,
 					 alt_req->url);
-			active_requests++;
-			slot->in_use = 1;
+			if (!slot->in_use)
+				active_requests++;
+			slot->in_use |= SLOTUSE_ACTIVE;
 			if (start_active_slot(slot)) {
 				return;
 			} else {
 				got_alternates = -1;
-				slot->in_use = 0;
 				return;
 			}
 		}
diff --git a/http.c b/http.c
index 75e6717..498b4ae 100644
--- a/http.c
+++ b/http.c
@@ -262,7 +262,7 @@ void http_cleanup(void)
 
 	while (slot != NULL) {
 #ifdef USE_CURL_MULTI
-		if (slot->in_use) {
+		if (slot->in_use & SLOTUSE_ACTIVE) {
 			curl_easy_getinfo(slot->curl,
 					  CURLINFO_EFFECTIVE_URL,
 					  &wait_url);
@@ -311,6 +311,7 @@ struct active_request_slot *get_active_s
 		newslot->curl = NULL;
 		newslot->in_use = 0;
 		newslot->next = NULL;
+		newslot->nrefs = 0;
 
 		slot = active_queue_head;
 		if (slot == NULL) {
@@ -333,7 +334,7 @@ struct active_request_slot *get_active_s
 	}
 
 	active_requests++;
-	slot->in_use = 1;
+	slot->in_use |= SLOTUSE_ACTIVE;
 	slot->local = NULL;
 	slot->callback_data = NULL;
 	slot->callback_func = NULL;
@@ -351,8 +352,9 @@ int start_active_slot(struct active_requ
 
 	if (curlm_result != CURLM_OK &&
 	    curlm_result != CURLM_CALL_MULTI_PERFORM) {
-		active_requests--;
-		slot->in_use = 0;
+		slot->in_use &= ~SLOTUSE_ACTIVE;
+		if (!slot->in_use)
+			active_requests--;
 		return 0;
 	}
 #endif
@@ -375,6 +377,24 @@ void step_active_slots(void)
 }
 #endif
 
+static void watch_active_slot(struct active_request_slot *slot)
+{
+	if (!slot->in_use)
+		active_requests++;
+	slot->in_use |= SLOTUSE_REF;
+	slot->nrefs++;
+}
+
+static void unwatch_active_slot(struct active_request_slot *slot)
+{
+	slot->nrefs--;
+	if (!slot->nrefs) {
+		slot->in_use &= ~SLOTUSE_REF;
+		if (!slot->in_use)
+			active_requests--;
+	}
+}
+
 void run_active_slot(struct active_request_slot *slot)
 {
 #ifdef USE_CURL_MULTI
@@ -386,7 +406,8 @@ void run_active_slot(struct active_reque
 	int max_fd;
 	struct timeval select_timeout;
 
-	while (slot->in_use) {
+	watch_active_slot(slot);
+	while (slot->in_use & SLOTUSE_ACTIVE) {
 		data_received = 0;
 		step_active_slots();
 
@@ -397,7 +418,7 @@ void run_active_slot(struct active_reque
 			last_pos = current_pos;
 		}
 
-		if (slot->in_use && !data_received) {
+		if ((slot->in_use & SLOTUSE_ACTIVE) && !data_received) {
 			max_fd = 0;
 			FD_ZERO(&readfds);
 			FD_ZERO(&writefds);
@@ -408,8 +429,9 @@ void run_active_slot(struct active_reque
 			       &excfds, &select_timeout);
 		}
 	}
+	unwatch_active_slot(slot);
 #else
-	while (slot->in_use) {
+	while (slot->in_use & SLOTUSE_ACTIVE) {
 		slot->curl_result = curl_easy_perform(slot->curl);
 		finish_active_slot(slot);
 	}
@@ -418,8 +440,9 @@ void run_active_slot(struct active_reque
 
 static void finish_active_slot(struct active_request_slot *slot)
 {
-        active_requests--;
-        slot->in_use = 0;
+	slot->in_use &= ~SLOTUSE_ACTIVE;
+	if (!slot->in_use)
+		active_requests--;
         curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE, &slot->http_code);
  
         /* Run callback if appropriate */
@@ -433,7 +456,7 @@ void finish_all_active_slots(void)
 	struct active_request_slot *slot = active_queue_head;
 
 	while (slot != NULL)
-		if (slot->in_use) {
+		if (slot->in_use & SLOTUSE_ACTIVE) {
 			run_active_slot(slot);
 			slot = active_queue_head;
 		} else {
diff --git a/http.h b/http.h
index ed4ea33..a66e06a 100644
--- a/http.h
+++ b/http.h
@@ -26,7 +26,8 @@ struct active_request_slot
 {
 	CURL *curl;
 	FILE *local;
-	int in_use;
+	unsigned in_use;
+	int nrefs;
 	CURLcode curl_result;
 	long http_code;
 	void *callback_data;
@@ -34,6 +35,9 @@ struct active_request_slot
 	struct active_request_slot *next;
 };
 
+#define SLOTUSE_ACTIVE 1u
+#define SLOTUSE_REF 2u
+
 struct buffer
 {
         size_t posn;
