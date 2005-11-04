From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 1/4] Verify remote packs, speed up pending request queue
Date: Fri, 4 Nov 2005 14:22:18 -0800
Message-ID: <20051104222218.GD3001@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 04 23:25:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY9x0-0004Jc-Lb
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 23:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbVKDWWT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 17:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbVKDWWT
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 17:22:19 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:28714 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751064AbVKDWWT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 17:22:19 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA4MMIA6017927
	for <git@vger.kernel.org>; Fri, 4 Nov 2005 14:22:18 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA4MMIoZ017924
	for git@vger.kernel.org; Fri, 4 Nov 2005 14:22:18 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11168>

Verify that remote packs exist before using the pack index, add requests to
the beginning of the queue to locate pending requests faster.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-push.c |   37 +++++++++++++++++++++----------------
 1 files changed, 21 insertions(+), 16 deletions(-)

applies-to: aaaf3e5d771c5de11e2c4da6677f51c7e07f7a50
216264d37339c149efa8c2eb03dbf03f2812d5d1
diff --git a/http-push.c b/http-push.c
index e85f1c1..134d405 100644
--- a/http-push.c
+++ b/http-push.c
@@ -727,7 +727,6 @@ void process_waiting_requests(void)
 void add_request(unsigned char *sha1, char *lock_token)
 {
 	struct transfer_request *request = request_queue_head;
-	struct transfer_request *tail;
 	struct packed_git *target;
 	
 	while (request != NULL && memcmp(request->sha1, sha1, 20))
@@ -745,17 +744,8 @@ void add_request(unsigned char *sha1, ch
 	request->lock_token = lock_token;
 	request->headers = NULL;
 	request->state = NEED_CHECK;
-	request->next = NULL;
-
-	if (request_queue_head == NULL) {
-		request_queue_head = request;
-	} else {
-		tail = request_queue_head;
-		while (tail->next != NULL) {
-			tail = tail->next;
-		}
-		tail->next = request;
-	}
+	request->next = request_queue_head;
+	request_queue_head = request;
 #ifdef USE_CURL_MULTI
 	process_request_queue();
 	process_curl_messages();
@@ -775,13 +765,29 @@ static int fetch_index(unsigned char *sh
 	FILE *indexfile;
 	struct active_request_slot *slot;
 
+	/* Don't use the index if the pack isn't there */
+	url = xmalloc(strlen(remote->url) + 65);
+	sprintf(url, "%s/objects/pack/pack-%s.pack", remote->url, hex);
+	slot = get_active_slot();
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (slot->curl_result != CURLE_OK) {
+			free(url);
+			return error("Unable to verify pack %s is available",
+				     hex);
+		}
+	} else {
+		return error("Unable to start request");
+	}
+
 	if (has_pack_index(sha1))
 		return 0;
 
 	if (push_verbosely)
 		fprintf(stderr, "Getting index for pack %s\n", hex);
 	
-	url = xmalloc(strlen(remote->url) + 64);
 	sprintf(url, "%s/objects/pack/pack-%s.idx", remote->url, hex);
 	
 	filename = sha1_pack_index_name(sha1);
@@ -792,6 +798,8 @@ static int fetch_index(unsigned char *sh
 			     filename);
 
 	slot = get_active_slot();
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, indexfile);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
@@ -833,8 +841,6 @@ static int fetch_index(unsigned char *sh
 static int setup_index(unsigned char *sha1)
 {
 	struct packed_git *new_pack;
-	if (has_pack_file(sha1))
-		return 0; // don't list this as something we can get
 
 	if (fetch_index(sha1))
 		return -1;
@@ -1610,7 +1616,6 @@ int main(int argc, char **argv)
 	while (request != NULL) {
 		next_request = request->next;
 		release_request(request);
-		free(request);
 		request = next_request;
 	}
 
---
0.99.9.GIT
