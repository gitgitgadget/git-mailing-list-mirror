From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: maybe breakage with latest git-pull and http protocol
Date: Thu, 20 Oct 2005 10:43:24 -0700
Message-ID: <20051020174324.GD6160@reactrix.com>
References: <867jciz18w.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 19:47:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESeRx-00020e-IY
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 19:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbVJTRnb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 13:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbVJTRna
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 13:43:30 -0400
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:21680 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932508AbVJTRna (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 13:43:30 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j9KHhPRo005119;
	Thu, 20 Oct 2005 10:43:25 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j9KHhOLs005116;
	Thu, 20 Oct 2005 10:43:24 -0700
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <867jciz18w.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10372>

Can you try using the following patch?  This cleans up curl handles for
active request slots that are no longer in use.  If all other prefetched
requests finish while a large transfer is happening, the active slots
currently keep open connections to the server and I'm guessing that
perhaps by the time additional objects are prefetched the server has
timed out some of those keepalive connections.


---

 http-fetch.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

applies-to: ce9a5a0fdd52a29e370d849a132b4509c844aca1
04b4353279eaceb7e7c3d73a9565b219aa7a10a9
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

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
