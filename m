From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] HTTP cleanup
Date: Tue, 6 Jun 2006 09:41:32 -0700
Message-ID: <20060606164131.GB3938@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jun 06 18:41:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fneca-0001kp-9x
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 18:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWFFQld (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 12:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWFFQld
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 12:41:33 -0400
Received: from 241.37.26.69.virtela.net ([69.26.37.241]:16403 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750726AbWFFQlc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 12:41:32 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k56GfW46008435
	for <git@vger.kernel.org>; Tue, 6 Jun 2006 09:41:32 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k56GfW51008433
	for git@vger.kernel.org; Tue, 6 Jun 2006 09:41:32 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21387>

Fix broken build when USE_CURL_MULTI is not defined, as noted by Becky Bruce.

During cleanup, free header slist that was created during init, as noted
by Junio.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>
---

I've verified that git will build with USE_CURL_MULTI commented out, but
have done very little testing of the resulting fetch/push binaries.

http-push.c |    8 ++++++++
 http.c      |    5 +++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/http-push.c b/http-push.c
index b1c018a..40524a8 100644
--- a/http-push.c
+++ b/http-push.c
@@ -788,6 +788,7 @@ static void finish_request(struct transf
 	}
 }
 
+#ifdef USE_CURL_MULTI
 void fill_active_slots(void)
 {
 	struct transfer_request *request = request_queue_head;
@@ -821,6 +822,7 @@ void fill_active_slots(void)
 		slot = slot->next;
 	}
 }
+#endif
 
 static void get_remote_object_list(unsigned char parent);
 
@@ -851,8 +853,10 @@ static void add_fetch_request(struct obj
 	request->next = request_queue_head;
 	request_queue_head = request;
 
+#ifdef USE_CURL_MULTI
 	fill_active_slots();
 	step_active_slots();
+#endif
 }
 
 static int add_send_request(struct object *obj, struct remote_lock *lock)
@@ -889,8 +893,10 @@ static int add_send_request(struct objec
 	request->next = request_queue_head;
 	request_queue_head = request;
 
+#ifdef USE_CURL_MULTI
 	fill_active_slots();
 	step_active_slots();
+#endif
 
 	return 1;
 }
@@ -2523,7 +2529,9 @@ int main(int argc, char **argv)
 		if (objects_to_send)
 			fprintf(stderr, "    sending %d objects\n",
 				objects_to_send);
+#ifdef USE_CURL_MULTI
 		fill_active_slots();
+#endif
 		finish_all_active_slots();
 
 		/* Update the remote branch if all went well */
diff --git a/http.c b/http.c
index 146cf7b..a2e8e78 100644
--- a/http.c
+++ b/http.c
@@ -287,6 +287,7 @@ #ifdef USE_CURL_MULTI
 #endif
 	curl_global_cleanup();
 	
+	curl_slist_free_all(pragma_header);
 }
 
 struct active_request_slot *get_active_slot(void)
@@ -438,11 +439,15 @@ void release_active_slot(struct active_r
 {
 	closedown_active_slot(slot);
 	if (slot->curl) {
+#ifdef USE_CURL_MULTI
 		curl_multi_remove_handle(curlm, slot->curl);
+#endif
 		curl_easy_cleanup(slot->curl);
 		slot->curl = NULL;
 	}
+#ifdef USE_CURL_MULTI
 	fill_active_slots();
+#endif
 }
 
 static void finish_active_slot(struct active_request_slot *slot)
-- 
1.3.3.g423a-dirty
