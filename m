From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] Make http-push smarter about creating remote dirs
Date: Mon, 7 Nov 2005 11:39:37 -0800
Message-ID: <20051107193937.GA3788@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 07 20:43:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZCqK-0005J2-0R
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 20:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbVKGTjp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 14:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965301AbVKGTjp
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 14:39:45 -0500
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:30445 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S964972AbVKGTjo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2005 14:39:44 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA7Jdbmh004396
	for <git@vger.kernel.org>; Mon, 7 Nov 2005 11:39:37 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA7Jdb7C004394
	for git@vger.kernel.org; Mon, 7 Nov 2005 11:39:37 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11278>

Remember object directories known to exist in the remote repo and don't
bother trying to create them.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-push.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

applies-to: 27732582039ada9c7781ce5a1583ee682e0452c6
9904bed158b8c297bfba8a8cff87644619688b62
diff --git a/http-push.c b/http-push.c
index 96d2778..4d41b4f 100644
--- a/http-push.c
+++ b/http-push.c
@@ -56,6 +56,7 @@ static int active_requests = 0;
 static int data_received;
 static int pushing = 0;
 static int aborted = 0;
+static char remote_dir_exists[256];
 
 #ifdef USE_CURL_MULTI
 static int max_requests = -1;
@@ -669,6 +670,7 @@ static void finish_request(struct transf
 		if (request->http_code == 404) {
 			request->state = NEED_PUSH;
 		} else if (request->curl_result == CURLE_OK) {
+			remote_dir_exists[request->sha1[0]] = 1;
 			request->state = COMPLETE;
 		} else {
 			fprintf(stderr, "HEAD %s failed, aborting (%d/%ld)\n",
@@ -680,6 +682,7 @@ static void finish_request(struct transf
 	} else if (request->state == RUN_MKCOL) {
 		if (request->curl_result == CURLE_OK ||
 		    request->http_code == 405) {
+			remote_dir_exists[request->sha1[0]] = 1;
 			start_put(request);
 		} else {
 			fprintf(stderr, "MKCOL %s failed, aborting (%d/%ld)\n",
@@ -790,7 +793,10 @@ void process_request_queue(void)
 			start_check(request);
 			curl_multi_perform(curlm, &num_transfers);
 		} else if (pushing && request->state == NEED_PUSH) {
-			start_mkcol(request);
+			if (remote_dir_exists[request->sha1[0]])
+				start_put(request);
+			else
+				start_mkcol(request);
 			curl_multi_perform(curlm, &num_transfers);
 		}
 		request = request->next;
@@ -1622,6 +1628,8 @@ int main(int argc, char **argv)
 		break;
 	}
 
+	memset(remote_dir_exists, 0, 256);
+
 	curl_global_init(CURL_GLOBAL_ALL);
 
 #ifdef USE_CURL_MULTI
---
0.99.9.GIT
