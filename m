From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 1/3] Clean up CURL handles in unused request slots
Date: Fri, 21 Oct 2005 12:06:10 -0700
Message-ID: <20051021190610.GE6160@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Oct 21 21:08:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET2Dp-0000L1-6v
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 21:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbVJUTGU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 15:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbVJUTGU
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 15:06:20 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:3579 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S965094AbVJUTGT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 15:06:19 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j9LJ6BoQ023854
	for <git@vger.kernel.org>; Fri, 21 Oct 2005 12:06:11 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j9LJ6BBl023852
	for git@vger.kernel.org; Fri, 21 Oct 2005 12:06:11 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10442>

Clean up CURL handles in unused request slots

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

While it's not clear whether this fixes any of the reported problems, it
seems safer to close connections that we know aren't in use.

 http-fetch.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

applies-to: ce9a5a0fdd52a29e370d849a132b4509c844aca1
24cd59bf9c4f5519e7f529cdd5bf3a9fbec72e5e
diff --git a/http-fetch.c b/http-fetch.c
index a7dc2cc..d26fae8 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -291,11 +291,7 @@ static struct active_request_slot *get_a
 	}
 	if (slot == NULL) {
 		newslot = xmalloc(sizeof(*newslot));
-#ifdef NO_CURL_EASY_DUPHANDLE
-		newslot->curl = get_curl_handle();
-#else
-		newslot->curl = curl_easy_duphandle(curl_default);
-#endif
+		newslot->curl = NULL;
 		newslot->in_use = 0;
 		newslot->next = NULL;
 
@@ -311,6 +307,14 @@ static struct active_request_slot *get_a
 		slot = newslot;
 	}
 
+	if (slot->curl == NULL) {
+#ifdef NO_CURL_EASY_DUPHANDLE
+		slot->curl = get_curl_handle();
+#else
+		slot->curl = curl_easy_duphandle(curl_default);
+#endif
+	}
+
 	active_requests++;
 	slot->in_use = 1;
 	slot->done = 0;
@@ -612,6 +616,7 @@ void process_curl_messages(void)
 void process_request_queue(void)
 {
 	struct transfer_request *request = request_queue_head;
+	struct active_request_slot *slot = active_queue_head;
 	int num_transfers;
 
 	while (active_requests < max_requests && request != NULL) {
@@ -624,6 +629,14 @@ void process_request_queue(void)
 		}
 		request = request->next;
 	}
+
+	while (slot != NULL) {
+		if (!slot->in_use && slot->curl != NULL) {
+			curl_easy_cleanup(slot->curl);
+			slot->curl = NULL;
+		}
+		slot = slot->next;
+	}				
 }
 #endif
 
@@ -1297,7 +1310,8 @@ int main(int argc, char **argv)
 #endif
 	slot = active_queue_head;
 	while (slot != NULL) {
-		curl_easy_cleanup(slot->curl);
+		if (slot->curl != NULL)
+			curl_easy_cleanup(slot->curl);
 		slot = slot->next;
 	}
 #ifdef USE_CURL_MULTI
---
0.99.8.GIT
