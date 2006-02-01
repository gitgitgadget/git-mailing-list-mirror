From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH 8/9] http: Paranoid sanity checking for active slots.
Date: Wed, 01 Feb 2006 11:44:41 +0000
Message-ID: <20060201114441.5042.13819.stgit@metalzone.distorted.org.uk>
References: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Wed Feb 01 12:45:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4GPp-00055O-SZ
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 12:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbWBALoo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 06:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbWBALoo
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 06:44:44 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:6896 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1161025AbWBALom (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 06:44:42 -0500
Received: (qmail 6610 invoked from network); 1 Feb 2006 11:44:41 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (?vgJhZdlXEG3w/VDC8oHXZ0meERcutOkU?@127.0.0.1)
  by localhost with SMTP; 1 Feb 2006 11:44:41 -0000
To: git@vger.kernel.org
In-Reply-To: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15412>

From: Mark Wooding <mdw@distorted.org.uk>

Probably not wanted in the mainline, but very useful when debugging.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 http-fetch.c |    2 ++
 http.c       |   28 ++++++++++++++++++++++++++++
 http.h       |    1 +
 3 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index 4aa5a11..fa3eb4a 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -465,9 +465,11 @@ static void process_alternates_response(
 				base);
 			curl_easy_setopt(slot->curl, CURLOPT_URL,
 					 alt_req->url);
+			sanity_check_active_slots();
 			if (!slot->in_use)
 				active_requests++;
 			slot->in_use |= SLOTUSE_ACTIVE;
+			sanity_check_active_slots();
 			if (!start_active_slot(slot))
 				got_alternates = -1;
 			return;
diff --git a/http.c b/http.c
index d0c92dc..8087ca0 100644
--- a/http.c
+++ b/http.c
@@ -1,3 +1,4 @@
+#include <assert.h>
 #include "http.h"
 
 int data_received;
@@ -348,19 +349,36 @@ struct active_request_slot *get_active_s
 	return slot;
 }
 
+void sanity_check_active_slots(void)
+{
+	struct active_request_slot *slot;
+	int n = 0;
+
+	for (slot = active_queue_head; slot; slot = slot->next) {
+		assert(!(slot->in_use & SLOTUSE_REF) == !slot->nrefs);
+		if (slot->in_use)
+			n++;
+	}
+	assert(n == active_requests);
+}
+
 int start_active_slot(struct active_request_slot *slot)
 {
+	sanity_check_active_slots();
 #ifdef USE_CURL_MULTI
 	CURLMcode curlm_result = curl_multi_add_handle(curlm, slot->curl);
 
 	if (curlm_result != CURLM_OK &&
 	    curlm_result != CURLM_CALL_MULTI_PERFORM) {
+		assert(slot->in_use & SLOTUSE_ACTIVE);
 		slot->in_use &= ~SLOTUSE_ACTIVE;
 		if (!slot->in_use)
 			active_requests--;
+		assert(active_requests >= 0);
 		return 0;
 	}
 #endif
+	sanity_check_active_slots();
 	return 1;
 }
 
@@ -382,20 +400,26 @@ void step_active_slots(void)
 
 static void watch_active_slot(struct active_request_slot *slot)
 {
+	sanity_check_active_slots();
 	if (!slot->in_use)
 		active_requests++;
 	slot->in_use |= SLOTUSE_REF;
 	slot->nrefs++;
+	sanity_check_active_slots();
 }
 
 static void unwatch_active_slot(struct active_request_slot *slot)
 {
+	sanity_check_active_slots();
+	assert(slot->nrefs);
 	slot->nrefs--;
 	if (!slot->nrefs) {
 		slot->in_use &= ~SLOTUSE_REF;
 		if (!slot->in_use)
 			active_requests--;
+		assert(active_requests >= 0);
 	}
+	sanity_check_active_slots();
 }
 
 void run_active_slot(struct active_request_slot *slot)
@@ -445,9 +469,13 @@ void run_active_slot(struct active_reque
 
 static void closedown_active_slot(struct active_request_slot *slot)
 {
+	sanity_check_active_slots();
+	assert(slot->in_use & SLOTUSE_ACTIVE);
         slot->in_use &= ~SLOTUSE_ACTIVE;
 	if (!slot->in_use)
 		active_requests--;
+	assert(active_requests >= 0);
+	sanity_check_active_slots();
 }
 
 void release_active_slot(struct active_request_slot *slot)
diff --git a/http.h b/http.h
index d028a5d..a2e48e8 100644
--- a/http.h
+++ b/http.h
@@ -59,6 +59,7 @@ extern int start_active_slot(struct acti
 extern void run_active_slot(struct active_request_slot *slot);
 extern void finish_all_active_slots(void);
 extern void release_active_slot(struct active_request_slot *slot);
+extern void sanity_check_active_slots(void);
 
 #ifdef USE_CURL_MULTI
 extern void fill_active_slots(void);
