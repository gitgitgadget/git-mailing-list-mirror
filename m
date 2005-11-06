From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] http-fetch: do not use curl_message after releasing it
Date: Mon, 7 Nov 2005 00:59:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511070059150.24078@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Nov 07 00:59:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYuQO-0001pC-Sw
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 00:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVKFX7l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 18:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVKFX7l
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 18:59:41 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:22484 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932370AbVKFX7k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 18:59:40 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 997C913EF04; Mon,  7 Nov 2005 00:59:39 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7E0DDB50BF; Mon,  7 Nov 2005 00:59:39 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 610565926B; Mon,  7 Nov 2005 00:59:39 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 43A4E13EF04; Mon,  7 Nov 2005 00:59:39 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11239>


When curl_message is released using curl_multi_remove_handle(), it's
contents are undefined. Therefore, get the information before releasing it.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 http-fetch.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

applies-to: a216f59923735f7680de8b3d9d333dc14de12b77
0516b1524ce60af57bf056f24b29983a70fb113f
diff --git a/http-fetch.c b/http-fetch.c
index b12779d..ea8af1b 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -578,6 +578,7 @@ void process_curl_messages(void)
 
 	while (curl_message != NULL) {
 		if (curl_message->msg == CURLMSG_DONE) {
+			int curl_result = curl_message->data.result;
 			slot = active_queue_head;
 			while (slot != NULL &&
 			       slot->curl != curl_message->easy_handle)
@@ -587,7 +588,7 @@ void process_curl_messages(void)
 				active_requests--;
 				slot->done = 1;
 				slot->in_use = 0;
-				slot->curl_result = curl_message->data.result;
+				slot->curl_result = curl_result;
 				curl_easy_getinfo(slot->curl,
 						  CURLINFO_HTTP_CODE,
 						  &slot->http_code);
@@ -599,8 +600,7 @@ void process_curl_messages(void)
 				fprintf(stderr, "Received DONE message for unknown request!\n");
 			}
 			if (request != NULL) {
-				request->curl_result =
-					curl_message->data.result;
+				request->curl_result = curl_result;
 				request->http_code = slot->http_code;
 				request->slot = NULL;
 				request->state = COMPLETE;
---
0.99.9.GIT
