From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Small bugfixes for http-push.c
Date: Mon, 7 Nov 2005 19:23:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511071918520.14111@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Nov 07 19:23:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZBeJ-00057P-AL
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 19:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbVKGSXQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 13:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbVKGSXQ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 13:23:16 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:62356 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964879AbVKGSXP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2005 13:23:15 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3F12913F213; Mon,  7 Nov 2005 19:23:12 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 21EE59F1C9; Mon,  7 Nov 2005 19:23:12 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 103EF8A825; Mon,  7 Nov 2005 19:23:12 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E27EC13F213; Mon,  7 Nov 2005 19:23:11 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11274>


This patch fixes three things:

- older libexpat does not know about enum XML_Status
- as in my patch for http-fetch, do not rely on a curl result in
	free()d data
- calloc the new_lock structure

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	I verified in a small scale test that it works now. The buglets
	showed only on my iBook, not on any Linux box I tried.

	The calloc'ing of the new_lock structure is necessary, because
	activelock_cdata() relies on several members being 0 until
	set by start_activelock_element().

	The problem I was experiencing with a crash in 
	cleanup_multi_handle() was due to the curl result not being
	interpreted correctly.

	Unfortunately, valgrind does not work on macosx, so it could
	not help me.

	Note: http-push shares a lot of code with http-fetch. It might
	be a good idea to refactor them (after some more out-ironing).

 http-push.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)
diff --git a/http-push.c b/http-push.c
index c10067c..5532d02 100644
--- a/http-push.c
+++ b/http-push.c
@@ -28,6 +28,15 @@ static const char http_push_usage[] =
 #define NO_CURL_EASY_DUPHANDLE
 #endif
 
+#ifndef XML_STATUS_OK
+enum XML_Status {
+  XML_STATUS_OK = 1,
+  XML_STATUS_ERROR = 0
+};
+#define XML_STATUS_OK    1
+#define XML_STATUS_ERROR 0
+#endif
+
 #define RANGE_HEADER_SIZE 30
 
 /* DAV method names and request body templates */
@@ -728,11 +737,12 @@ void process_curl_messages(void)
 			       slot->curl != curl_message->easy_handle)
 				slot = slot->next;
 			if (slot != NULL) {
+				int curl_result = curl_message->data.result;
 				curl_multi_remove_handle(curlm, slot->curl);
 				active_requests--;
 				slot->done = 1;
 				slot->in_use = 0;
-				slot->curl_result = curl_message->data.result;
+				slot->curl_result = curl_result;
 				curl_easy_getinfo(slot->curl,
 						  CURLINFO_HTTP_CODE,
 						  &slot->http_code);
@@ -1230,7 +1240,7 @@ struct active_lock *lock_remote(char *fi
 	in_buffer.posn = 0;
 	in_buffer.buffer = in_data;
 
-	new_lock = xmalloc(sizeof(*new_lock));
+	new_lock = xcalloc(1, sizeof(*new_lock));
 	new_lock->owner = NULL;
 	new_lock->token = NULL;
 	new_lock->timeout = -1;
